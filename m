Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B02CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9E02086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zs9xc5Lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9E02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeJKF7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:59:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKF7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4RTNWCERxKB5mOLaOR/QI+bh0G/IQmofjrrD/rBUQRU=; b=Zs9xc5LqiXB7srkT3wy9P36WA
        16nsl5SKqcqjqN1jPDYdO/RP8qCoOXbe5EYozD5vAGQx7LktNyFhqBk3Ah+9LOcuNol+XKXVy2vkB
        OT9Uj3cMhOrtaYiJ19SRNZNdiCYxo4VFPXJB9Km/NVgpb8BVIvO8vu3AZ7+ZCSwaws5DpaSKwEUyf
        jm6nQ+hNtyoU7ysi1AHdXj4NatMa61TcU7XzzE37jQJP2c+PSmL3pzm+X6z0ybyFGVVJWGyyl3zOL
        7n1kMQf4FugRwPT3jc3l8AEyqHwh4noEpc0Ym3QrpjL1AZpk0yMm2pMVmj1i0tgGgr1nV0fyZ7Af7
        gXlMtZ1nA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAN4H-0003Tj-9o; Wed, 10 Oct 2018 22:35:01 +0000
Subject: Re: [PATCH] kbuild: Fail the build early when no lz4 present
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
References: <20181010222333.17794-1-bp@alien8.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ebc95e03-3fdf-afc1-168a-6a78f9ce0e61@infradead.org>
Date:   Wed, 10 Oct 2018 15:34:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010222333.17794-1-bp@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 3:23 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> When building randconfigs, the build fails at kernel compression stage
> due to missing lz4 on the system but CONFIG_KERNEL_LZ4 has been selected
> by randconfig. The result looks somethins like this:
> 
>     (cat arch/x86/boot/compressed/vmlinux.bin arch/x86/boot/compressed/vmlinux.relocs | lz4c -l -c1 stdin stdout && printf \334\141\301\001) > arch/x86/boot/compressed/vmlinux.bin.lz4 || (rm -f arch/x86/boot/compressed/vmlinux.bin.lz4 ; false)
>   /bin/sh: 1: lz4c: not found
>   make[2]: *** [arch/x86/boot/compressed/Makefile:143: arch/x86/boot/compressed/vmlinux.bin.lz4] Error 1
>   make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
>   make: *** [arch/x86/Makefile:290: bzImage] Error 2
> 
> Fail the build much earlier by checking for lz4c presence before doing
> anything else.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> ---
>  Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index a0c32de80482..f91de649234b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -788,6 +788,12 @@ KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
>  LDFLAGS_vmlinux += --gc-sections
>  endif
>  
> +ifdef CONFIG_KERNEL_LZ4
> +ifeq ($(CONFIG_SHELL which lz4c),)

Hi,
I have been informed in the past the POSIX spells "which" as "command -v" and
hence requested to do s/which/command -v/

> +$(error "lz4 tool not found on this system but CONFIG_KERNEL_LZ4 enabled")
> +endif
> +endif
> +
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  
> 

cheers,
-- 
~Randy
