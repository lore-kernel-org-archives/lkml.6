Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24656ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA45221473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="POeOzG9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA45221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbeJRUoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbeJRUoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:44:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 711BE2098A;
        Thu, 18 Oct 2018 12:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539866643;
        bh=fQpH7q3E6CLCD1y5i/lPDVBjRnF7SlSVk3qJxeCnCn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=POeOzG9WMGrbmwIVT6zzrt9y+tnQlho4fdPoyHXH63BD3o9ARdWwE1KgFDMh0K03i
         dvgiEJfDP11C69q/7ULJNBSWjt0x5jkUUgV9guat/Z41uF480FYvUiDpnolg1wUxLq
         cLOHxirLmxmRrJWtxxB8/Y3i1Jb4eLiDxCH8TUvI=
Date:   Thu, 18 Oct 2018 14:44:01 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Don't set CROSS_COMPILE in arch's Makefile
Message-ID: <20181018124401.GB1451@kroah.com>
References: <20180916204757.31131-1-abrodkin@synopsys.com>
 <4881796E12491D4BB15146FE0209CE6468174FFF@DE02WEMBXB.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4881796E12491D4BB15146FE0209CE6468174FFF@DE02WEMBXB.internal.synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:33:02PM +0000, Alexey Brodkin wrote:
> Hello,
> 
> > -----Original Message-----
> > From: Alexey Brodkin [mailto:abrodkin@synopsys.com]
> > Sent: Sunday, September 16, 2018 11:48 PM
> > To: linux-snps-arc@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org; Vineet Gupta <vgupta@synopsys.com>; Alexey Brodkin <abrodkin@synopsys.com>; Masahiro
> > Yamada <yamada.masahiro@socionext.com>; Rob Herring <robh@kernel.org>
> > Subject: [PATCH] ARC: Don't set CROSS_COMPILE in arch's Makefile
> > 
> > There's not much sense in doing that because if user or
> > his build-system didn't set CROSS_COMPILE we still may
> > very well make incorrect guess.
> > 
> > But as it turned out setting CROSS_COMPILE is not as harmless
> > as one may think: with recent changes that implemented automatic
> > discovery of __host__ gcc features unconditional setup of
> > CROSS_COMPILE leads to failures on execution of "make xxx_defconfig"
> > with absent cross-compiler, for more info see [1].
> > 
> > Set CROSS_COMPILE as well gets in the way if we want only to build
> > .dtb's (again with absent cross-compiler which is not really needed
> > for building .dtb's), see [2].
> > 
> > Note, we had to change LIBGCC assignment type from ":=" to "="
> > so that is is resolved on its usage, otherwise if it is resolved
> > at declaration time with missing CROSS_COMPILE we're getting this
> > error message from host GCC:
> > ------------------------->8-------------------------
> > gcc: error: unrecognized command line option ‘-mmedium-calls’
> > gcc: error: unrecognized command line option ‘-mno-sdata’; did you mean ‘-fno-stats’?
> > ------------------------->8-------------------------
> > 
> > [1] http://lists.infradead.org/pipermail/linux-snps-arc/2018-September/004308.html
> > [2] http://lists.infradead.org/pipermail/linux-snps-arc/2018-September/004320.html
> > 
> > Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arc/Makefile | 10 +---------
> >  1 file changed, 1 insertion(+), 9 deletions(-)
> > 
> > diff --git a/arch/arc/Makefile b/arch/arc/Makefile
> > index 99cce77ab98f..5f6b67917dc2 100644
> > --- a/arch/arc/Makefile
> > +++ b/arch/arc/Makefile
> > @@ -6,14 +6,6 @@
> >  # published by the Free Software Foundation.
> >  #
> > 
> > -ifeq ($(CROSS_COMPILE),)
> > -ifndef CONFIG_CPU_BIG_ENDIAN
> > -CROSS_COMPILE := arc-linux-
> > -else
> > -CROSS_COMPILE := arceb-linux-
> > -endif
> > -endif
> > -
> >  KBUILD_DEFCONFIG := nsim_700_defconfig
> > 
> >  cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
> > @@ -79,7 +71,7 @@ cflags-$(disable_small_data)		+= -mno-sdata -fcall-used-gp
> >  cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= -mbig-endian
> >  ldflags-$(CONFIG_CPU_BIG_ENDIAN)	+= -EB
> > 
> > -LIBGCC	:= $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
> > +LIBGCC	= $(shell $(CC) $(cflags-y) --print-libgcc-file-name)
> > 
> >  # Modules with short calls might break for calls into builtin-kernel
> >  KBUILD_CFLAGS_MODULE	+= -mlong-calls -mno-millicode
> > --
> > 2.17.1
> 
> May we have this one back-ported to stable branches?
> 
> Upstream commit in Linus' tree is:
> 40660f1fcee8 ("ARC: build: Don't set CROSS_COMPILE in arch's Makefile").

Applied to 4.9.y, 4.14.y, and 4.18.y, thanks.

greg k-h
