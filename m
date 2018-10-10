Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4C9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2B92087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2i4Nwznr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2B92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJKCXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbeJKCXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:23:48 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C04942085B;
        Wed, 10 Oct 2018 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539198020;
        bh=AptFhrvWf9sAT1Yo9xbpAIi9S/maAaiaIzLfSfs58eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2i4NwznrDlIpeplG36HYdg1MRD80Ifz12lpcnjRo+MhXmkXSotCOPj4Dn4Rkz20Lp
         dcETK1aYVl2GMPkRUgcVEoFy0s3ygwuZ5cpVCfoHViZ9xHGRBoQX+PK+RssHieVgvn
         whh2XaRcFSs+RjAH/WMoSgG8+ZyXAGzrfIAcQgMc=
Date:   Wed, 10 Oct 2018 15:00:18 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181010190018.GK32006@sasha-vm>
References: <20181008152523.70705-1-sashal@kernel.org>
 <20181008152523.70705-24-sashal@kernel.org>
 <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm>
 <20181010170219.GA47260@dtor-ws>
 <20181010181148.GI32006@sasha-vm>
 <20181010183609.GG47260@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181010183609.GG47260@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:36:09AM -0700, Dmitry Torokhov wrote:
>On Wed, Oct 10, 2018 at 02:11:48PM -0400, Sasha Levin wrote:
>> There is a big difference between distros and the stable trees. Distros
>> know who their users/customers are, OTOH we have no clue who the users
>> of stable trees are.
>>
>> I think Greg's last estimate was that about 1/3 of the kernels in the
>> wild are custom based on a kernel.org stable kernel, which means that we
>> have no visibility as to what they do with the kernel. If you don't know
>> who your users are, how can you prioritize some subsystems over others?
>
>You make a judgement call, based on the data you have. And I think if
>you want override maintainer decision you need a decent justification,
>better than "it is easy to backport" or "we do not know if someone might
>use it".

I'll never override a maintainer with regards to whether a patch will go
in stable or not. We're having this discussion only because you posed a
question rather than NAKed it. If you want me to drop this or any other
patch I'll happily do that.

>>
>> I don't think we can do any of that because we don't know who uses the
>> kernel and what bugs they hit, or don't hit.
>
>They should file bugs, report on mailing lists, and so on. If they hit
>bugs and do not bother to report them anywhere, it is not our problem.
>They need to be part of community.

The tricky part I see here is being able to say "this is a kernel bug".
Given an average user who's capslock key stops working, do you really
expect them to diagnose this as a kernel issue? Most users don't even
know what the kernel is.

>> This is one of the reasons
>> we ask everyone to pick everything, if they don't use whatever code we
>> changed they won't be affected at all.
>
>Or there is unexpected behavior change and they are affected. What do
>you do if users of atakbd adjusted their userspace for the broken kernel
>map? From my POV it is OK-ish to change in new kernel release, but
>not in a middle of "stable" series.

Fair enough, we usually do that trade-off based on how complex a patch
is rather than how many users a certain driver has.

>>
>> As a trivial example: we run a few kernels with custom configs in
>> Microsoft. Can you tell which drivers we use and how many machines use
>> them? Us not showing up in git log doesn't mean we don't use something,
>> it just means that the stable process works for us.
>
>I can tell you that you are not using atakbd ;)
>
>Look, if we are talking about Microsoft, what are criteria for changes
>that are going into "patch tuesday" releases? Is it any random junk that
>might land on top of the development tree? Or is it just a bit more
>disciplined? Like Release managers looking at the incoming problem
>report rates and make a judgement call as to whether pull the fix in or
>wait for bigger maintenance release? In ChromeOS land it is the latter.

Exactly! If we'd have a system to report bugs and issues where these are
automatically sent back to the mothership like on Windows I'd agree
with you. But for now we have shit for bugtracker and noisy LKML that no
one reads. And this assumes that a user knows what this mystical
"kernel" thing is.

As you might know, Microsoft is rather new in the Linux field, and we
sometimes have a "what is the linux kernel?" discussions. This is
inside a TECH company. I can't iamgine a lay person knows what a kernel
is.

It's hard to expect those users to do that much footwork to report bugs.

--
Thanks,
Sasha
