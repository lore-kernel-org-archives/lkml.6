Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D3CC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3172620836
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 16:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KSoiz+Fp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfAMQOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 11:14:38 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34514 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfAMQOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 11:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R8WF8Lc/Hu2iKQhD6ijSeFw1ni/Wm67m4kCSLmSA9qw=; b=KSoiz+Fp6/UPmZuYgskoE/JK/
        KLGhrbtmyR26fpvM3G/Vdatz6DUFkGmaB2i8/eeIGWmR1L/89sOZwCH7Dre5AP8a2XkEnF8Qar1Ah
        HohL12z1NiA0RJtQPzht67L8EElxuWYQkaL8D6mU6fQpcv+mK9y63sb58rO2f49lKOPJU=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:42495)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1giiP4-00022f-Nt; Sun, 13 Jan 2019 16:14:26 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1giiP1-0001DU-L2; Sun, 13 Jan 2019 16:14:23 +0000
Date:   Sun, 13 Jan 2019 16:14:20 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Jeremy Fertic <jeremyfertic@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: ARM: config issue with ftrace function graph tracer
Message-ID: <20190113161420.GE2392@n2100.armlinux.org.uk>
Mail-Followup-To: Russell King - ARM Linux <linux@armlinux.org.uk>,
        Stefan Agner <stefan@agner.ch>,
        Jeremy Fertic <jeremyfertic@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190112010139.GA5288@r2700x.localdomain>
 <d9bc5937c5fc7a45f3aca14fdf68803d@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9bc5937c5fc7a45f3aca14fdf68803d@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 04:41:52PM +0100, Stefan Agner wrote:
> Hi,
> 
> On 12.01.2019 02:01, Jeremy Fertic wrote:
> > I'm having a problem with the ftrace function graph tracer on a 32 bit arm
> > board (orangepi pc). A bisect points to the following commit:
> > 
> > f9b58e8c7d03 ("ARM: 8800/1: use choice for kernel unwinders")
> > 
> > Before this commit, if I use sunxi_defconfig and then menuconfig to enable
> > FTRACE and FUNCTION_TRACER then the function graph tracer works. With this
> > commit, and as of v5.0-rc1, doing the same as above results in a broken
> > function graph tracer and often an oops as well. The commit introduces a
> > choice group and it looks like it should default to UNWINDER_FRAME_POINTER
> > if FUNCTION_GRAPH_TRACER is enabled. FUNCTION_GRAPH_TRACER is enabled by
> > default when I enable FUNCTION_TRACER but this has no effect on the choice.
> > The choice always defaults to the other option which is UNWINDER_ARM. If I
> > manually choose UNWINDER_FRAME_POINTER then the function graph tracer works
> > fine.
> 
> The default selection is there, but this is made at "make
> sunxi_defconfig" time. At this point FUNCTION_GRAPH_TRACER is not
> enabled, hence Kconfig uses UNWIDER_ARM. However, when enabling the
> FUNCTION_GRAPH_TRACER Kconfig will _not_ reconsider and switch enable
> UNWINDER_FRAME_POINTER.
> 
> Before that commit, when enabling FUNCTION_GRAPH_TRACER, we simply also
> enabled FRAME_POINTER...
> 
> I guess we need to make sure that FUNCTION_GRAPH_TRACER depends on the
> UNWINDER_FRAME_POINTER choice. There is already a similar dependency
> with THUMB2_KERNEL. We can cleanup that dependency since
> UNWINDER_FRAME_POINTER already depends on !THUMB2_KERNEL.
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 664e918e2624..a2ac65a8b2cc 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -69,7 +69,7 @@ config ARM
>         select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K ||
> CPU_V7) && MMU
>         select HAVE_EXIT_THREAD
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> -       select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL
> +       select HAVE_FUNCTION_GRAPH_TRACER if UNWINDER_FRAME_POINTER
>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
>         select HAVE_GCC_PLUGINS
>         select HAVE_GENERIC_DMA_COHERENT
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 6d6e0330930b..8341649fa71d 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -47,8 +47,8 @@ config DEBUG_WX
> 
>  choice
>         prompt "Choose kernel unwinder"
> -       default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
> -       default UNWINDER_FRAME_POINTER if !AEABI ||
> FUNCTION_GRAPH_TRACER
> +       default UNWINDER_ARM if AEABI
> +       default UNWINDER_FRAME_POINTER if !AEABI
>         help
>           This determines which method will be used for unwinding kernel
> stack
>           traces for panics, oopses, bugs, warnings, perf,
> /proc/<pid>/stack,

This looks rather horrid - the upshot of this means that the function
tracer becomes unavailable on EABI unless you know that you must change
the unwinder from its default.

Before the change to the choice statement, people could select the
function graph tracer, and the correct unwinder would be selected
for them.  That's knowledge that people never required before, and
I think it's really quite unfair to require them to know this to use
the function graph tracer.

Maybe someone can put some effort into getting the function graph
tracer working with non-framepointer kernels... but as the above
currently stands, I really don't like the patch and I'd much rather
revert the original change to fix this regression.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
