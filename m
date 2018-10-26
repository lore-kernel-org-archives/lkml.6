Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B424ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20A1207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORX8+31s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20A1207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeJZTqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeJZTqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:46:02 -0400
Received: from localhost (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 108922075D;
        Fri, 26 Oct 2018 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540552162;
        bh=4W+kYVQTmfxXr195VHfoRBCL+1VQUQEegvLQTU4ExZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ORX8+31sQZcFAztthFKAfIWhV04Zl3+1I9SygmVviGsY7zNNi1WbEtEleOqwK+01U
         ER8MTfElkHBBOi5JwP8hy9sOemBGU0SHVIFuiHjR33V8udc1vN4qYPmDpAbhNCTxCi
         yBDhXHJQOKJe9Ha4sLg8sgut5GBJfqWkHA6RLR7U=
Date:   Fri, 26 Oct 2018 07:09:20 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg KH <greg@kroah.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH AUTOSEL 4.14 02/15] s390/hibernate: fix error handling
 when suspend cpu != resume cpu
Message-ID: <20181026110920.GF2015@sasha-vm>
References: <20181022102026.40869-1-sashal@kernel.org>
 <20181022102026.40869-2-sashal@kernel.org>
 <20181026090543.GC20200@amd>
 <20181026092214.GA4307@kroah.com>
 <20181026101549.GA30955@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181026101549.GA30955@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 12:15:49PM +0200, Pavel Machek wrote:
>On Fri 2018-10-26 10:22:14, Greg KH wrote:
>> On Fri, Oct 26, 2018 at 11:05:43AM +0200, Pavel Machek wrote:
>> > On Mon 2018-10-22 06:20:13, Sasha Levin wrote:
>> > > From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
>> > >
>> > > [ Upstream commit 55a5542a546238354d1f209f794414168cf8c71d ]
>> > >
>> > > The resume code checks if the resume cpu is the same as the suspend cpu.
>> > > If not, and if it is also not possible to switch to the suspend cpu, an
>> > > error message should be printed and the resume process should be stopped
>> > > by loading a disabled wait psw.
>> > >
>> > > The current logic is broken in multiple ways, the message is never printed,
>> > > and the disabled wait psw never loaded because the kernel panics before that:
>> > > - sam31 and SIGP_SET_ARCHITECTURE to ESA mode is wrong, this will break
>> > >   on the first 64bit instruction in sclp_early_printk().
>> > > - The init stack should be used, but the stack pointer is not set up correctly
>> > >   (missing aghi %r15,-STACK_FRAME_OVERHEAD).
>> > > - __sclp_early_printk() checks the sclp_init_state. If it is not
>> > >   sclp_init_state_uninitialized, it simply returns w/o printing anything.
>> > >   In the resumed kernel however, sclp_init_state will never be uninitialized.
>> >
>> > Stable patches should fix one bug, and one bug only.
>>
>> So should upstream patches, but the rule of "stable patches match
>> upstream identically" overrules this :)
>
>a) There is no such rule for upstream.

I invite you to read the docs in Documentation/process/ where you'll
find gems like "Each logically independent change should be formatted as
a separate patch".

>b) You should split the patch if it is important enough.
>
>c) The "stable patches match upstream identically" rule does not
>exist. Check the documentation.

The rule in question here is that every patch that goes into -stable
must be upstream. If we were to split this patch, it would create 2+
patches that do not exist upstream, thus breaking our own rules.

Anyway, given that this is an upstream issue, I'll also invite you to
have this discussion with the maintainer of the subsystem this patch
went into; you raise a valid concern which can hopefully be addressed by
that maintainer.

--
Thanks,
Sasha
