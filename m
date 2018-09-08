Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F72BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 03:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA4420855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 03:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7zHoK+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA4420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeIHImG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 04:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbeIHImF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 04:42:05 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2053920855;
        Sat,  8 Sep 2018 03:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536379073;
        bh=arwUWlO1pkWaHSXd2bTSDzEx3UalQy/6JHWxcc2vCRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q7zHoK+LE1meC/KdGOFnvjqhp9k1H9KKPYGsU98lotrS+SAnjb+ezt8vSMIKif8mm
         O3v9d1p+aedETIw0RnNOhQYMMBsxI9KTrXb2vClcZf3gpqzVpKlFtNVwbHDx2WeFoU
         Lod7/JHHKBrBfomzFVq62lrB34h3QEuCYwIsXv4k=
Date:   Sat, 8 Sep 2018 12:57:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arnd@arndb.de
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-Id: <20180908125749.9c903e507a33046d5586e841@kernel.org>
In-Reply-To: <ebad9c9d-a7d0-44cc-f000-bf5e500fcd24@linux.ibm.com>
References: <20180824133206.4218c2e5@canb.auug.org.au>
        <20180824172053.20fa197294f51496dcec5605@kernel.org>
        <20180824204756.e787765461975cd1e27502dc@kernel.org>
        <20180824224211.2934d7c0@canb.auug.org.au>
        <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
        <20180828072333.36af4d5d@canb.auug.org.au>
        <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
        <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
        <20180907014209.49e2940f74615a1e4f544ffd@kernel.org>
        <ebad9c9d-a7d0-44cc-f000-bf5e500fcd24@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Sep 2018 14:50:59 +0200
Peter Oberparleiter <oberpar@linux.ibm.com> wrote:

> On 06.09.2018 18:42, Masami Hiramatsu wrote:
> > Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
> >> I've attached a quick fix that should address both problems. I'd
> >> appreciate if this patch could get some testing before I post proper fix
> >> patches.
> > 
> > Hmm, I'm still not able to reproduce it on powerpc cross build even with
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y ... So, sorry I couldn't test this patch.
> 
> Maybe this is related to the compiler/binutils versions used. I'm using
> Fedora 28's gcc-powerpc64 and binutils-powerpc64 packages:
> 
> powerpc64-linux-gnu-gcc (GCC) 7.1.1 20170622 (Red Hat Cross 7.1.1-3)
> GNU ld version 2.29.1-4.fc28
> 
> For reference I'm also attaching the config that I used to reproduce the
> problem on kernel v4.18.
> 
> >> diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
> >> index ae5fdff18406..2ca33277a28b 100644
> >> --- a/arch/arm/kernel/vmlinux.lds.h
> >> +++ b/arch/arm/kernel/vmlinux.lds.h
> >> @@ -48,6 +48,7 @@
> >>
> >>  #define ARM_DISCARD							\
> >>  		*(.ARM.exidx.exit.text)					\
> >> +		*(.ARM.exidx.text.exit)					\
> > 
> > BTW, why would we need this?
> 
> That's necessary to fix one of the two ARM linker failures reported via
> https://lkml.org/lkml/2018/8/24/345
> 
> >>> `.text.exit' referenced in section `.ARM.exidx.text.exit' of
> >>> kernel/trace/trace_clock.o: defined in discarded section `.text.exit'
> >>> of kernel/trace/trace_clock.o
> 
> Section ".ARM.exidx.text.exit" refers to ".text.exit" which was
> discarded. With the change above, the extraneous section
> ".ARM.exidx.text.exit" is also discarded, resolving the linker failure.

OK, so your patch fixes following issue too?

https://patchwork.kernel.org/patch/10584685/

In that case, we should drop above patch.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
