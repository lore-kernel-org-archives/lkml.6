Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1527C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6AC20833
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6AC20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeH2Olt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:41:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:36914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726858AbeH2Olt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:41:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ACDAAAEEA;
        Wed, 29 Aug 2018 10:45:30 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id D98D6A0F35; Wed, 29 Aug 2018 12:45:28 +0200 (CEST)
Date:   Wed, 29 Aug 2018 12:45:28 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT] powerpc/boot: Fix missing crc32poly.h when building with
 KERNEL_XZ
Message-ID: <20180829104528.GA4444@unicorn.suse.cz>
References: <1535527943-32566-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535527943-32566-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 09:32:23AM +0200, Krzysztof Kozlowski wrote:
> After commit faa16bc404d7 ("lib: Use existing define with
> polynomial") the lib/xz/xz_crc32.c includes a header from include/linux
> directory thus any other user of this code should define proper include
> path.
> 
> This fixes the build error on powerpc with CONFIG_KERNEL_XZ:
> 
>     In file included from ../arch/powerpc/boot/../../../lib/decompress_unxz.c:233:0,
>                      from ../arch/powerpc/boot/decompress.c:42:
>     ../arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:29: fatal error: linux/crc32poly.h: No such file or directory
> 
> Reported-by: Michal Kubecek <mkubecek@suse.cz>
> Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Only compile tested.
> ---
>  arch/powerpc/boot/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 0fb96c26136f..ba4182fb185d 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -63,7 +63,7 @@ ifeq ($(call cc-option-yn, -fstack-protector),y)
>  BOOTCFLAGS	+= -fno-stack-protector
>  endif
>  
> -BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj)
> +BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj) -I$(srctree)/include
>  
>  DTC_FLAGS	?= -p 1024
>  
> -- 
> 2.7.4
> 

With this patch 4.19-rc1 builds and boots on ppc64le. Thank you.

Tested-by: Michal Kubecek <mkubecek@suse.cz>

