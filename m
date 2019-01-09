Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67373C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361DD20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547052760;
	bh=PGmQbghLzB//LYJFii0db6Hv2f/jthDwNAeOQyXQduk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PrNyBXmWFxiPmhtq396J2NsH2RwzzQXcqFXkl4RMKfOhEwPS86hk00hMUPdqCR1OW
	 CMRR1O/fyeqR8GKHHTIfoAJbq77ObG6oX0BD4WrtXC9eehQ5jzv4ieb2LTUM0oHziC
	 lrCAwJK9O0DKVclte0t80cF8bLwh7cfqhCPY+9rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfAIQwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:52:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbfAIQwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:52:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4901206BA;
        Wed,  9 Jan 2019 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547052758;
        bh=PGmQbghLzB//LYJFii0db6Hv2f/jthDwNAeOQyXQduk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1OeohSki498/SbzVQ4l7ltwXEM4p766QfBV+9ohg8SHz0ndntxEQ09W3kSRB5YybH
         xAe/Bu4A00E2tXTcRP6u45HoJn1rrQl9mBLeKuEwHxRwJS9u+mY45q8xl0JQv5pf+M
         WzSPO1d55AdhE4WZ2vZLYaNkaHzz4MQj47Cg1AO8=
Date:   Wed, 9 Jan 2019 17:52:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Marc Dionne <marc.c.dionne@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190109165235.GA8151@kroah.com>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:19:52PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-01-07 18:08:26 [-0400], Marc Dionne wrote:
> > On Thu, Dec 27, 2018 at 11:20 AM Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org> wrote:
> > >
> > > Commit:     12209993e98c5fa1855c467f22a24e3d5b8be205
> > >     x86/fpu: Don't export __kernel_fpu_{begin,end}()
> > >
> …
> > >     With EFI gone as the last user of __kernel_fpu_{begin|end}(), both can
> > >     be made static and not exported anymore.
> > >
> > This commit removes an exported function pair that is currently used
> > by out of tree modules, while the replacement pair
> > (kernel_fpu_begin/end) is EXPORT_SYMBOL_GPL.  So this is making
> > existing functionality GPL only, which will probably be an issue for
> > several out of tree modules that use the fpu.
> > 
> > Could kernel_fpu_begin/end be made plain EXPORT_SYMBOL?
> 
> It can be used by OOT modules as long as they are not under a
> proprietary license. The change here is not for me to decide, I added
> the x86 maintainers to make their decision. I can make a patch if they
> say so.

If there are no in-kernel users, the symbols should not be exported
anymore.  That's nothing new, we have always done this.

> On the other hand could we just drop EXPORT_SYMBOL_GPL? I doubt this
> helps in any way yet please correct me if I am wrong. 

Yes, it helps, please leave it as-is.

thanks,

greg k-h
