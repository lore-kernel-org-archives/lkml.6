Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5686C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98985206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98985206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeJAGXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 02:23:22 -0400
Received: from smtprelay0045.hostedemail.com ([216.40.44.45]:56629 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726745AbeJAGXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 02:23:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 9C4FC100E806B;
        Sun, 30 Sep 2018 23:48:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thumb11_2be3df0eaed14
X-Filterd-Recvd-Size: 2500
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Sep 2018 23:48:21 +0000 (UTC)
Message-ID: <aa1fbf64fc1190674abb9ecae3ffe1a39e1e60c0.camel@perches.com>
Subject: Re: [PATCH] ARM: disable ARMv6 for Clang older than 8.0
From:   Joe Perches <joe@perches.com>
To:     Stefan Agner <stefan@agner.ch>, linux@armlinux.org.uk,
        arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sun, 30 Sep 2018 16:48:20 -0700
In-Reply-To: <20180930222230.24167-1-stefan@agner.ch>
References: <20180930222230.24167-1-stefan@agner.ch>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-01 at 00:22 +0200, Stefan Agner wrote:
> The kernel passes the ArmV6K architecture to the compiler when
> using the multi platform selection and enabling ARMv6. Clang
> older than version 8.0 emit assembly with an non-existing CPU,
> which then makes the assembler fail. Prevent the user from
> selecting ARMv6 when using Clang before 8.0.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Link: https://github.com/ClangBuiltLinux/linux/issues/55
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e8cd55a5b04c..8da160757381 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -671,6 +671,7 @@ config ARCH_MULTI_V4_V5
>  
>  config ARCH_MULTI_V6
>  	bool "ARMv6 based platforms (ARM11)"
> +	depends on !CC_IS_CLANG || CLANG_VERSION>=80000
>  	select ARCH_MULTI_V6_V7
>  	select CPU_V6K
>  

Perhaps it'd be better to avoid this in selection
criteria in Kconfig and instead add this to
include/linux/compiler_clang.h
---
 include/linux/compiler-clang.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index b1ce500fe8b3..90fd16c85359 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -3,6 +3,10 @@
 #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
 #endif
 
+#if defined(CONFIG_ARCH_MULTI_V6) && CLANG_VERSION < 80000
+# error Sorry, your compiler is too old - please upgrade it.
+#endif
+
 /* Some compiler specific definitions are overwritten here
  * for Clang compiler
  */


