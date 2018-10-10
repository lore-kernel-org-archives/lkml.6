Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19857C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FE820870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtFCTnDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FE820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeJJVw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbeJJVw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:52:26 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F9A2085B;
        Wed, 10 Oct 2018 14:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539181800;
        bh=9R5ZinCTfBx2JMq7InCr057CNC+MQp6l7nMwsLl7Gss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtFCTnDnby4o16XXbKwUaqCCFaH02CASTacCyPlDgSF+XX6HFVq4759kKeAJAfIYJ
         5xnhlYtR74dBBkUyrpOwDaq8OsSpgsKWfqrZQxmD5ePpY6B/ZL4sd61veYi9EJvlCR
         oxd+S12DV+xjWSeHuK7gvxE8L94yw+ZPEOCMMMVs=
Date:   Wed, 10 Oct 2018 10:29:58 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181010142958.GF32006@sasha-vm>
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 12:20:26PM -0700, Dmitry Torokhov wrote:
>Hi Michael,
>
>On Mon, Oct 8, 2018 at 12:09 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>
>> Dmitry,
>>
>> someone on debian-68k reported the bug, which (to me) indicates that the
>> code is not just used by me.
>>
>> Whether or not a functioning Capslock is essential to have? You be the
>> judge of that. If you are OK with applying the keymap patch, why not
>> this one?
>
>I have exactly the same concerns about the keymap patch. This all has
>not been working correctly for many many years (and it was not broken
>in a subtly way as far as I understand, but rather quite obvious).
>Thus I do not understand why this belongs to stable release. It is not
>a [recent] regression, nor secutiry bug, nor even enabling of new
>hardware, that is why I myself did not mark it as stable.
>
>I still maintain that we pick up for stable too many patches for no
>clear benefit. This is similar to the patch for Atmel controllers that
>was picked to stable and I asked why, as it is not clear how many
>users might be affected (or if the problem the patch was solving was
>purely theoretical, or only affecting hardware that is not in
>circulation yet).

If you belive that a certain piece of code has no actual users, why do
you keep it in the upstream kernel to begin with?

I don't think it makes sense to keep something upstream because it might
have users, but not backport fixes because there might not have any
users.

You haven't seen evidence of anyone using/caring about it for a few
years? Great! Remove the code and if someone complains we can always
revert. This is how all those orphaned archs got removed a few releases
back. I'll even submit the patch if you'd like.

It doesn't make sense to have "second class citizens" like how you
suggested.

--
Thanks,
Sasha
