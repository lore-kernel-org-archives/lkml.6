Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0903821773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547126006;
	bh=Xsv6Ecs9NH4PeP7CLi5NcqWeZJVAediYMwyPJa/dMCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n9xubigu/QUPATQrOnaWBsQU27J6ws46lKDEX+b95AS1s3BMmeSmIST1qO7EVeo9S
	 QfQNkFhPE+9At8yiOh4NQoaZ1Wbpatl/t9iTE0/2pzRCfbqQS6dJswTKlbzdt9e/s2
	 W2VFBDj55sSUuY33Z76+LSUIAbn+yQodXHxqRA3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfAJNNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbfAJNNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 08:13:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 933BD214DA;
        Thu, 10 Jan 2019 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547126004;
        bh=Xsv6Ecs9NH4PeP7CLi5NcqWeZJVAediYMwyPJa/dMCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uePhNWnFPoyJt3vLEUNMpcIF36fKxZj8YGDyXSn2mYStcuqSYRN+rp5OhXjCoTOJU
         Q83SFORRr74rJ9Hosf6dcjMVCgDdBQ2AwgHzivyDU5pK0qtRShr/N01lVWKO5PPomd
         Yr+FoSDOYttTWLTid6k/CmInYA0vbOhYU0sEnC0o=
Date:   Thu, 10 Jan 2019 14:13:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Dionne <marc.c.dionne@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Subject: Re: x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20190110131321.GD20217@kroah.com>
References: <git-mailbomb-linux-master-12209993e98c5fa1855c467f22a24e3d5b8be205@kernel.org>
 <CAB9dFdsZb-sZixeOzrt8F50h1pnUK2W2Cxx8+xjhgd0=6xs7iw@mail.gmail.com>
 <20190109111951.5zvnj7ls6jv56p2u@linutronix.de>
 <20190109165235.GA8151@kroah.com>
 <20190109170935.e6b6rwzpk6dlruu4@linutronix.de>
 <CAB9dFdvRAzqnRAUEr3Y6H+h6viwdEMDpWP2Gf=tj3-0ojH58Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB9dFdvRAzqnRAUEr3Y6H+h6viwdEMDpWP2Gf=tj3-0ojH58Xg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:40:14PM -0400, Marc Dionne wrote:
> On Wed, Jan 9, 2019 at 1:09 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2019-01-09 17:52:35 [+0100], Greg Kroah-Hartman wrote:
> > > If there are no in-kernel users, the symbols should not be exported
> > > anymore.  That's nothing new, we have always done this.
> >
> > The thing is that we had
> >   EXPORT_SYMBOL(__kernel_fpu_begin)
> >   EXPORT_SYMBOL_GPL(kernel_fpu_begin)
> >
> > and now __kernel_fpu_begin() is no longer exported and static only.
> > All in kernel user (including the kvm module) use kernel_fpu_begin()
> > which is not available to proprietary modules. Hence Marc's mail.
> >
> > > > On the other hand could we just drop EXPORT_SYMBOL_GPL? I doubt this
> > > > helps in any way yet please correct me if I am wrong.
> > >
> > > Yes, it helps, please leave it as-is.
> >
> > As you say. I only notice that certain things used to work and then no
> > longer do because due to $rework it somehow become EXPORT_SYMBOL_GPL
> > only and people complain and we tend to switch the export back to
> > EXPORT_SYMBOL. I'm not aware of a case where it actually helped in
> > anyway.
> >
> > > thanks,
> > >
> > > greg k-h
> >
> > Sebastian
> 
> I would point out that there are several precedents for restoring
> exports after functionality has been unintentionally made GPL only;
> from a quick lookup these are some examples:
> 
>   8af190958059 ("x86/paravirt: Remove GPL from pv_ops export")
>   31c5bda3a656 ("mm: fix exports that inadvertently make put_page()
> EXPORT_SYMBOL_GPL")
>   1e5476815fd7 ("x86/tlb: Drop the _GPL from the cpu_tlbstate export")
>   b562c171cf01 ("locking/refcounts: Do not force refcount_t usage as
> GPL-only export")

Yes, but this is a bit different of a thing here.  The symbol you wish
to have changed was not modified at all, you just lost access to an
internal function that was fixed up and removed.

Best of luck,

greg k-h
