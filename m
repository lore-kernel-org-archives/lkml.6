Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B27AECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3E220857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWIGuw95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3E220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeKIBWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbeKIBWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:22:31 -0500
Received: from localhost (unknown [63.64.74.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F79620827;
        Thu,  8 Nov 2018 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541691986;
        bh=kRFugjfvWuqdDl3LsfXmYiIg3gJ2bJePGUZstk7YSZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LWIGuw95HtqlpXKAkUiKwCkilZjKkpvubtAnrgoVoqGB5clVLTWz+kFUilnsXSXnC
         LEsjXjojDmmLDl24eZdulUM1qsfneAazi0DFIGLoynBjDePHKTHvACar6F4sfX6koN
         lgs1EPaN9Ue3anl87rVTDUdX0k+UT+teseV1N8bg=
Date:   Thu, 8 Nov 2018 10:46:25 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        stable@vger.kernel.org, gregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH stable 4.9] posix-timers: Sanitize overrun handling
Message-ID: <20181108154625.GC8097@sasha-vm>
References: <1541102558-14839-1-git-send-email-f.fainelli@gmail.com>
 <6341cf9e-b2aa-9447-88e9-ad89ab42a641@gmail.com>
 <alpine.DEB.2.21.1811080747450.1666@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811080747450.1666@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 07:48:16AM +0100, Thomas Gleixner wrote:
>Florian,
>
>On Wed, 7 Nov 2018, Florian Fainelli wrote:
>> On 11/1/18 1:02 PM, Florian Fainelli wrote:
>> > From: Thomas Gleixner <tglx@linutronix.de>
>> >
>> > [ Upstream commit 78c9c4dfbf8c04883941445a195276bb4bb92c76 ]
>> >
>> > The posix timer overrun handling is broken because the forwarding functions
>> > can return a huge number of overruns which does not fit in an int. As a
>> > consequence timer_getoverrun(2) and siginfo::si_overrun can turn into
>> > random number generators.
>> >
>> > The k_clock::timer_forward() callbacks return a 64 bit value now. Make
>> > k_itimer::ti_overrun[_last] 64bit as well, so the kernel internal
>> > accounting is correct. 3Remove the temporary (int) casts.
>> >
>> > Add a helper function which clamps the overrun value returned to user space
>> > via timer_getoverrun(2) or siginfo::si_overrun limited to a positive value
>> > between 0 and INT_MAX. INT_MAX is an indicator for user space that the
>> > overrun value has been clamped.
>> >
>> > Reported-by: Team OWL337 <icytxw@gmail.com>
>> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> > Acked-by: John Stultz <john.stultz@linaro.org>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> > Link: https://lkml.kernel.org/r/20180626132705.018623573@linutronix.de
>> > [florian: Make patch apply to v4.9.135]
>> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> > ---
>> > Thomas, can you review for correctness? Thanks!
>>
>> Thomas, John, does that look like a reasonable backport for 4.9?
>
>Looks correct.

Queued for 4.9, thanks all.

--
Thanks,
Sasha
