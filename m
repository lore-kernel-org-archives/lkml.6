Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDB8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C822085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6pGvxOr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C822085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeJKC0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbeJKC0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:26:05 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2752085B;
        Wed, 10 Oct 2018 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539198156;
        bh=aMNSP2JBOgbC4kOl87Ja5b2fCvoMn4YEyglaZYPjd38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6pGvxOrQmRMvFBjao95Spy1VLIsoQYXQdxDu2K5BWqJ1YvN4xK1H0PPrFSZVJ7ay
         JIQ7Pu+jc44fYFvyi8D/aSUsUvdZqOPPHiW9TI8Xtmrr6ZT1CFKTQ9SFyi9548Cyda
         YIUKjeFWd8SpMW4vVgAzhRmE0TU4fekeQEhGWrHs=
Date:   Wed, 10 Oct 2018 15:02:35 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        alexander.levin@microsoft.com
Subject: Re: [PATCH AUTOSEL 4.18 24/58] Input: atakbd - fix Atari CapsLock
 behaviour
Message-ID: <20181010190235.GL32006@sasha-vm>
References: <CAKdAkRSoq_U1rkO+6gbautYpS1fFn3icLY3Dtx0geXNC7MwvbA@mail.gmail.com>
 <bec357b5-09d0-5014-d2a3-0ade83499d15@gmail.com>
 <CAKdAkRSuuv_8BOz2m=DSgnV7a2MNY+6ZPera3ROfV3osMUTStQ@mail.gmail.com>
 <20181010142958.GF32006@sasha-vm>
 <20181010170219.GA47260@dtor-ws>
 <20181010181148.GI32006@sasha-vm>
 <20181010182840.GB23517@kroah.com>
 <20181010184039.GH47260@dtor-ws>
 <20181010184947.GJ32006@sasha-vm>
 <20181010185820.GI47260@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181010185820.GI47260@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:58:20AM -0700, Dmitry Torokhov wrote:
>On Wed, Oct 10, 2018 at 02:49:47PM -0400, Sasha Levin wrote:
>> On Wed, Oct 10, 2018 at 11:40:39AM -0700, Dmitry Torokhov wrote:
>> > On Wed, Oct 10, 2018 at 08:28:40PM +0200, Greg KH wrote:
>> > > On Wed, Oct 10, 2018 at 02:11:48PM -0400, Sasha Levin wrote:
>> > > > I think Greg's last estimate was that about 1/3 of the kernels in the
>> > > > wild are custom based on a kernel.org stable kernel, which means that we
>> > > > have no visibility as to what they do with the kernel. If you don't know
>> > > > who your users are, how can you prioritize some subsystems over others?
>> > >
>> > > The numbers I had was 75% of the images a major cloud provider was using
>> > > was either a kernel.org stable kernel release, or Debian.  The remaining
>> > > 25% was an "enterprise" kernel including CentOS.
>> > >
>> > > Also note that all Android devices are now required to follow the stable
>> > > kernel releases as well, so add a few more million to that number :)
>> > >
>> > > That being said, for a well-maintained subsystem like Input, whose
>> > > maintainer almost always marks patches for stable releases, having them
>> > > picked up by the autobot is unusual.  Dmitry, if you want your subsytem
>> > > to be excluded, just let Sasha know, other subsystems have been excluded
>> > > at the maintainer's request, and that's fine.
>> >
>> > I am hesitant to request to exclude input from autosel just yet, on an
>> > account that I might miss something. But I would like autosel to acquire
>> > more smarts and be less trigger happy. I think it would be for the best
>> > for everyone.
>>
>> Keep in mind that it learns based on your choices, so maybe in a while
>> it will be a perfect fit :)
>>
>> Maybe to make it easier, just reply with NAK on the patch(es) you don't
>> want in the tree and I'll drop them.
>
>OK, I will be doing it then. Should it be a certain string so you can
>script or a free form?

Nah, I go through any comments I receive and am not planning on changing
that.

>>
>> I was discussing more about the general case and stable tree policy
>> rather than drivers/input and AUTOSEL, and didn't mean to try and
>> dictate what we'll take or not. Sorry!
>
>Me too and I am not trying to be dismissive of your effort, I am just
>trying to have discussion on the criteria that we should use for stable
>candidates.

This is great input for me as well. Thank you!

--
Thanks,
Sasha
