Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7531AECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215C8208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215C8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbeISL3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:29:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:19775 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbeISL3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:29:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42FTXp4LwFz9ttG0;
        Wed, 19 Sep 2018 07:52:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zjyckiJn1U0B; Wed, 19 Sep 2018 07:52:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42FTXp3k73z9ttFP;
        Wed, 19 Sep 2018 07:52:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BE6AC8B815;
        Wed, 19 Sep 2018 07:52:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gfrVZcJX-wkd; Wed, 19 Sep 2018 07:52:42 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 719DD8B776;
        Wed, 19 Sep 2018 07:52:42 +0200 (CEST)
Subject: Re: [PATCH] lib/xz: Fix powerpc build with KERNEL_XZ
To:     Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Oliver O'Halloran <oohall@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
References: <20180918230756.26035-1-joel@jms.id.au>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <a3a97ebf-9a40-db6e-8225-7b9ccf9cfb4b@c-s.fr>
Date:   Wed, 19 Sep 2018 07:52:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918230756.26035-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/09/2018 à 01:07, Joel Stanley a écrit :
> This partially reverts faa16bc404d72a5 ("lib: Use existing define with
> polynomial").
> 
> The cleanup added a dependency on include/linux, which broke the PowerPC
> boot wrapper/decompresser when KERNEL_XZ is enabled:
> 
>    BOOTCC  arch/powerpc/boot/decompress.o
>   In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:233,
>                   from arch/powerpc/boot/decompress.c:42:
>   arch/powerpc/boot/../../../lib/xz/xz_crc32.c:18:10: fatal error:
>   linux/crc32poly.h: No such file or directory
>    #include <linux/crc32poly.h>
>             ^~~~~~~~~~~~~~~~~~~
> 
> The powerpc decompressor is a hairy corner of the kernel. Even while building
> a 64-bit kernel it needs to build a 32-bit binary and therefore avoid including
> files from include/linux.
> 
> Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> We need to clean up the powerpc boot decompresser but that work will be
> more involved than we would include in a late -rc. Please consider
> merging this fix for 4.19. Thanks!
> 
>   lib/xz/xz_crc32.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
> index 25a5d87e2e4c..34532d14fd4c 100644
> --- a/lib/xz/xz_crc32.c
> +++ b/lib/xz/xz_crc32.c
> @@ -15,7 +15,6 @@
>    * but they are bigger and use more memory for the lookup table.
>    */
>   
> -#include <linux/crc32poly.h>
>   #include "xz_private.h"
>   
>   /*
> @@ -30,7 +29,7 @@ STATIC_RW_DATA uint32_t xz_crc32_table[256];
>   
>   XZ_EXTERN void xz_crc32_init(void)
>   {
> -	const uint32_t poly = CRC32_POLY_LE;
> +	const uint32_t poly = 0xEDB88320;

Maybe avoid capital letters ?

What about adding something like the following in xz_private.h instead:

#define CRC32_POLY_LE 0xedb88320

Christophe

>   
>   	uint32_t i;
>   	uint32_t j;
> 
