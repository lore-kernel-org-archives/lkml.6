Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4173C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647242084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFObk1Ja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647242084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeJ2WZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbeJ2WZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:25:19 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A5B2082D;
        Mon, 29 Oct 2018 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540820197;
        bh=4dqWG0GBWPMUzwKsPqk0scqM9PAuN8RviIX3A3Xpc9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFObk1JasxcS2XK6LP1W8urpabcKEDkyXRuikvv7jMIv26BGgxVMeVWZofwdJQLJa
         ox1iW3dezevmjuu8DU8b0qciPW6yRryvBFbleVNQ46oEjJwexFKq79k1AjB29t6ECs
         T9btBMNTuBWauVTk8plP6nlsMwk50c8a04tvKe1I=
Date:   Mon, 29 Oct 2018 09:36:35 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL 4.14 33/46] MIPS: Workaround GCC
 __builtin_unreachable reordering bug
Message-ID: <20181029133635.GM2015@sasha-vm>
References: <20181025141053.213330-1-sashal@kernel.org>
 <20181025141053.213330-33-sashal@kernel.org>
 <20181025195254.q55noj2rdh5vyw5s@pburton-laptop>
 <CAK8P3a2eOo=9Pv4XmyX30_PYoRpp_f6rXQn+pk9z21wMvE84Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK8P3a2eOo=9Pv4XmyX30_PYoRpp_f6rXQn+pk9z21wMvE84Ag@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 09:36:30AM +0200, Arnd Bergmann wrote:
>On 10/25/18, Paul Burton <paul.burton@mips.com> wrote:
>> On Thu, Oct 25, 2018 at 10:10:40AM -0400, Sasha Levin wrote:
>>> From: Paul Burton <paul.burton@mips.com>
>>> ---
>>>  arch/mips/Kconfig                |  1 +
>>>  arch/mips/include/asm/compiler.h | 35 ++++++++++++++++++++++++++++++++
>>>  2 files changed, 36 insertions(+)
>>
>> In principle I'm fine with backporting this - it does fix broken builds.
>>
>> It's only going to be of any use though if you also backport commit
>> 04f264d3a8b0 ("compiler.h: Allow arch-specific asm/compiler.h"). I'd
>> recommend backporting both or neither.
>>
>> In practice I think it's unlikely anyone will need a microMIPS kernel &
>> be tied to the particular versions affected by the bug this patch fixed,
>> so I don't think it's a problem to backport neither.
>
>I think the current practice of the stable kernel these days is to take
>both patches in this case: They fix an actual bug in the mainline kernel,
>and it seems unlikely enough that they cause a regression if backported,
>so putting them into 4.14 has more advantages than disadvantages.

I'll take both, thank you!

--
Thanks,
Sasha
