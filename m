Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8018821904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HXjE4m8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfBNEI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:08:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBNEI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:08:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l0SO85yWNfakOdmZHEh/uES1GCWX1/G3Rg92wvpmbX0=; b=HXjE4m8mmg2QS2YmCSrg1ZtBz
        CnzKbjtOd89dzkKaV/KCzd+x//l309kLgUj7eicwih3rKAG3YFEc+r5TUtlYVfn8Lxun/hGf3jygV
        Wq7JauDR8D7rLUj+PdcSPzLzapQuyO+JN0lXimyh+2uCvqycSKhyvjNwmsxTHff/eUGM68jFrGc7G
        cQf26GW/vavcU7vnCAVuXr7wpKZl4VZKqWZm1cDMk39oHwHfeE3owjojtsazNXy6Gf3p4edMNYrTu
        u/uNQhDKFFiHAaWJNxtiPUuwwvq7YA+A6tipCp/eVLCr5pE+R/LGGaou9lq8AHkqju5mIiJjCxkAh
        DFpoQTC6A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gu8K0-0000xL-OR; Thu, 14 Feb 2019 04:08:24 +0000
Subject: Re: [PATCH 1/2] lib/string: add memrchr function
To:     Xiang Xiao <xiaoxiang781216@gmail.com>, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, wendy.liang@xilinx.com,
        arnaud.pouliquen@st.com, kumar.gala@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Xiao <xiaoxiang@xiaomi.com>
References: <1550116097-29710-1-git-send-email-xiaoxiang@xiaomi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f4742c3c-ca55-d90f-7056-b340eea5160b@infradead.org>
Date:   Wed, 13 Feb 2019 20:08:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1550116097-29710-1-git-send-email-xiaoxiang@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/19 7:48 PM, Xiang Xiao wrote:
> Here is the detailed description for memrchr:
> 
> void *memrchr(const void *s, int c, size_t n);
> 
> The memrchr() function is like the memchr() function, except
> that it searches backward from the end of the n bytes pointed
> to by s instead of forward from the beginning.
> 
> The memrchr() functions return a pointer to the matching byte
> or NULL if the character does not occur in the given memory
> area.
> 
> Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> ---
>  include/linux/string.h |  1 +
>  lib/string.c           | 21 +++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b87..f380f4b 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -167,6 +167,7 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
>  	memcpy(dst, src, cnt);
>  }
>  #endif
> +void *memrchr(const void *s, int c, size_t n);
>  void *memchr_inv(const void *s, int c, size_t n);
>  char *strreplace(char *s, char old, char new);
>  
> diff --git a/lib/string.c b/lib/string.c
> index 38e4ca0..92914f6 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -964,6 +964,27 @@ void *memchr(const void *s, int c, size_t n)
>  EXPORT_SYMBOL(memchr);
>  #endif
>  
> +/**
> + * memrchr - Find a character in an area of memory.

This should say up front that this is a reverse search, from the end of
the memory area backwards.

> + * @s: The memory area
> + * @c: The byte to search for
> + * @n: The size of the area.
> + *
> + * returns the address of the last occurrence of @c, or %NULL

    * Return: the address of the last occurrence of @c, or %NULL

> + * if @c is not found
> + */
> +void *memrchr(const void *s, int c, size_t n)
> +{
> +	const unsigned char *p = s + n;
> +
> +	while (n-- != 0) {
> +		if ((unsigned char)c == *--p)
> +			return (void *)p;
> +	}
> +	return NULL;
> +}
> +EXPORT_SYMBOL(memrchr);
> +
>  static void *check_bytes8(const u8 *start, u8 value, unsigned int bytes)
>  {
>  	while (bytes) {
> 


-- 
~Randy
