Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763E5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140B82089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XM3RivOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140B82089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeJAXch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:32:37 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47196 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeJAXch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zU9RtA6dvNz508u6EhRvjciaC//O0BCa+iW5FGW84kw=; b=XM3RivOF6V/TiPa85+AQg9PUR
        txnJR6ZhTTA2vn9oamuDi/utO6UxJWm+9xcpwzRc+8V7WhL3yrD9QgGi/K4d1zz0LgY0oGk+8W/6o
        VlVY0ejLkcOccOr9BiFroeginHF0DYo2hFW7ScMvBZ37ijs4k0ORL8VXOBLSAbGeVb/jc=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:60133)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g71S8-0006nX-5O; Mon, 01 Oct 2018 17:53:48 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g71S4-0007Y2-4T; Mon, 01 Oct 2018 17:53:44 +0100
Date:   Mon, 1 Oct 2018 17:53:42 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Joe Perches <joe@perches.com>
Cc:     Stefan Agner <stefan@agner.ch>, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: disable ARMv6 for Clang older than 8.0
Message-ID: <20181001165342.GR30658@n2100.armlinux.org.uk>
References: <20180930222230.24167-1-stefan@agner.ch>
 <aa1fbf64fc1190674abb9ecae3ffe1a39e1e60c0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa1fbf64fc1190674abb9ecae3ffe1a39e1e60c0.camel@perches.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 04:48:20PM -0700, Joe Perches wrote:
> On Mon, 2018-10-01 at 00:22 +0200, Stefan Agner wrote:
> > The kernel passes the ArmV6K architecture to the compiler when
> > using the multi platform selection and enabling ARMv6. Clang
> > older than version 8.0 emit assembly with an non-existing CPU,
> > which then makes the assembler fail. Prevent the user from
> > selecting ARMv6 when using Clang before 8.0.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/55
> > ---
> >  arch/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index e8cd55a5b04c..8da160757381 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -671,6 +671,7 @@ config ARCH_MULTI_V4_V5
> >  
> >  config ARCH_MULTI_V6
> >  	bool "ARMv6 based platforms (ARM11)"
> > +	depends on !CC_IS_CLANG || CLANG_VERSION>=80000
> >  	select ARCH_MULTI_V6_V7
> >  	select CPU_V6K
> >  
> 
> Perhaps it'd be better to avoid this in selection
> criteria in Kconfig and instead add this to
> include/linux/compiler_clang.h
> ---
>  include/linux/compiler-clang.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index b1ce500fe8b3..90fd16c85359 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -3,6 +3,10 @@
>  #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
>  #endif
>  
> +#if defined(CONFIG_ARCH_MULTI_V6) && CLANG_VERSION < 80000
> +# error Sorry, your compiler is too old - please upgrade it.
> +#endif

(a) does it makes sense to have arch CONFIG_* in linux/*.h?  It could
    instead go in arch/arm/kernel/asm-offsets.c, where we have the other
    tests similar to this for GCC.

(b) do we get far enough that the #error will be generated before the
    reported assembler error happens?  IOW, would the assembler error
    mask this #error?

I think it needs confirmation that a #error for this problem results
in the desired behaviour.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 14.8Mbps down 650kbps up
According to speedtest.net: 13Mbps down 490kbps up
