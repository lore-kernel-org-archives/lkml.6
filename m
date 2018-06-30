Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7087C6778C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC6027EED
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC6027EED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755225AbeF3Bh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:37:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59252 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbeF3Bhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:37:55 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25560CA0;
        Sat, 30 Jun 2018 01:37:55 +0000 (UTC)
Date:   Fri, 29 Jun 2018 18:37:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     icytxw@gmail.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/fadvise: Fix signed overflow UBSAN complaint
Message-Id: <20180629183754.b5accab9f7f6593a39d6f0be@linux-foundation.org>
In-Reply-To: <20180629184453.7614-1-aryabinin@virtuozzo.com>
References: <20180627204808.99988d94180dd144b14aa38b@linux-foundation.org>
        <20180629184453.7614-1-aryabinin@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2018 21:44:53 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> Signed integer overflow is undefined according to the C standard.
> The overflow in ksys_fadvise64_64() is deliberate, but since it is signed
> overflow, UBSAN complains:
> 	UBSAN: Undefined behaviour in mm/fadvise.c:76:10
> 	signed integer overflow:
> 	4 + 9223372036854775805 cannot be represented in type 'long long int'
> 
> Use unsigned types to do math. Unsigned overflow is defined so UBSAN
> will not complain about it. This patch doesn't change generated code.
> 
> ...
>
> --- a/mm/fadvise.c
> +++ b/mm/fadvise.c
> @@ -73,7 +73,7 @@ int ksys_fadvise64_64(int fd, loff_t offset, loff_t len, int advice)
>  	}
>  
>  	/* Careful about overflows. Len == 0 means "as much as possible" */
> -	endbyte = offset + len;
> +	endbyte = (u64)offset + (u64)len;
>  	if (!len || endbyte < len)
>  		endbyte = -1;
>  	else

Readers of this code will wonder "what the heck are those casts for". 
Therefore:

--- a/mm/fadvise.c~mm-fadvise-fix-signed-overflow-ubsan-complaint-fix
+++ a/mm/fadvise.c
@@ -72,7 +72,11 @@ int ksys_fadvise64_64(int fd, loff_t off
 		goto out;
 	}
 
-	/* Careful about overflows. Len == 0 means "as much as possible" */
+	/*
+	 * Careful about overflows. Len == 0 means "as much as possible".  Use
+	 * unsigned math because signed overflows are undefined and UBSan
+	 * complains.
+	 */
 	endbyte = (u64)offset + (u64)len;
 	if (!len || endbyte < len)
 		endbyte = -1;
_

