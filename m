Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9AF20675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lyJwjnJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfAMPl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:41:57 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:54652 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfAMPl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 10:41:56 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 0543B5C24F2;
        Sun, 13 Jan 2019 16:41:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1547394114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whId9VZUnwaqxuqa4KlUIdkBQryPsOBB/uh+zXCwGk4=;
        b=lyJwjnJa2J/3QCxmW/d/gOHvcb5Tlwf3FQ5Ty+HeMGPFbysyuqOl/gpW7OjPx1gd9rRSC0
        QB3YgEsWwVaVPAhPjhyV039gLGj+NivIKYAwbh9mnn8/R+g9pgqjT7eQBXi3WmXqYiObqT
        WsjWz71QAi+eWJ8P99hUMA2U5iUKFKM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 13 Jan 2019 16:41:52 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>, rostedt@goodmis.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: ARM: config issue with ftrace function graph tracer
In-Reply-To: <20190112010139.GA5288@r2700x.localdomain>
References: <20190112010139.GA5288@r2700x.localdomain>
Message-ID: <d9bc5937c5fc7a45f3aca14fdf68803d@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12.01.2019 02:01, Jeremy Fertic wrote:
> I'm having a problem with the ftrace function graph tracer on a 32 bit arm
> board (orangepi pc). A bisect points to the following commit:
> 
> f9b58e8c7d03 ("ARM: 8800/1: use choice for kernel unwinders")
> 
> Before this commit, if I use sunxi_defconfig and then menuconfig to enable
> FTRACE and FUNCTION_TRACER then the function graph tracer works. With this
> commit, and as of v5.0-rc1, doing the same as above results in a broken
> function graph tracer and often an oops as well. The commit introduces a
> choice group and it looks like it should default to UNWINDER_FRAME_POINTER
> if FUNCTION_GRAPH_TRACER is enabled. FUNCTION_GRAPH_TRACER is enabled by
> default when I enable FUNCTION_TRACER but this has no effect on the choice.
> The choice always defaults to the other option which is UNWINDER_ARM. If I
> manually choose UNWINDER_FRAME_POINTER then the function graph tracer works
> fine.

The default selection is there, but this is made at "make
sunxi_defconfig" time. At this point FUNCTION_GRAPH_TRACER is not
enabled, hence Kconfig uses UNWIDER_ARM. However, when enabling the
FUNCTION_GRAPH_TRACER Kconfig will _not_ reconsider and switch enable
UNWINDER_FRAME_POINTER.

Before that commit, when enabling FUNCTION_GRAPH_TRACER, we simply also
enabled FRAME_POINTER...

I guess we need to make sure that FUNCTION_GRAPH_TRACER depends on the
UNWINDER_FRAME_POINTER choice. There is already a similar dependency
with THUMB2_KERNEL. We can cleanup that dependency since
UNWINDER_FRAME_POINTER already depends on !THUMB2_KERNEL.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..a2ac65a8b2cc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -69,7 +69,7 @@ config ARM
        select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K ||
CPU_V7) && MMU
        select HAVE_EXIT_THREAD
        select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
-       select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL
+       select HAVE_FUNCTION_GRAPH_TRACER if UNWINDER_FRAME_POINTER
        select HAVE_FUNCTION_TRACER if !XIP_KERNEL
        select HAVE_GCC_PLUGINS
        select HAVE_GENERIC_DMA_COHERENT
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6d6e0330930b..8341649fa71d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -47,8 +47,8 @@ config DEBUG_WX

 choice
        prompt "Choose kernel unwinder"
-       default UNWINDER_ARM if AEABI && !FUNCTION_GRAPH_TRACER
-       default UNWINDER_FRAME_POINTER if !AEABI ||
FUNCTION_GRAPH_TRACER
+       default UNWINDER_ARM if AEABI
+       default UNWINDER_FRAME_POINTER if !AEABI
        help
          This determines which method will be used for unwinding kernel
stack
          traces for panics, oopses, bugs, warnings, perf,
/proc/<pid>/stack,


> 
> Any idea why the default behaviour has changed?

The rational is stated in the commit message, the main reason was to
disallow UNWINDER_FRAME_POINTER in case Clang is used (since Clang does
not create the expected function prologue).

The choice also aligns with how unwinders are selected on x86.

--
Stefan
