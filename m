Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9738C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E75320811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E75320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeLKLGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:06:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59543 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbeLKLGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:06:36 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 283B2F890CEF1;
        Tue, 11 Dec 2018 19:06:33 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 11 Dec
 2018 19:06:26 +0800
Subject: Re: [PATCH 4/5] drivers: staging: erofs: Fix parentheses error in
 macro
To:     Aaron Strahlberger <aaron.strahlberger@posteo.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@i4.cs.fau.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181211105443.21826-1-aaron.strahlberger@posteo.de>
 <20181211105443.21826-5-aaron.strahlberger@posteo.de>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <dc56553c-a5ea-5265-5820-4bb481b0b948@huawei.com>
Date:   Tue, 11 Dec 2018 19:06:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181211105443.21826-5-aaron.strahlberger@posteo.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On 2018/12/11 18:54, Aaron Strahlberger wrote:
> Fix of ERROR: Macros with complex values should be enclosed in parentheses
> from checkpatch.pl
> 
> Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
> Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
> Signed-off-by: Dominik Huber <domi250@gmx.de>
> ---
>  drivers/staging/erofs/erofs_fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
> index d4bffa2852b3..892c913960c3 100644
> --- a/drivers/staging/erofs/erofs_fs.h
> +++ b/drivers/staging/erofs/erofs_fs.h
> @@ -38,9 +38,9 @@ struct erofs_super_block {
>  /* 80 */__u8 reserved2[48];     /* 128 bytes */
>  } __packed;
>  
> -#define __EROFS_BIT(_prefix, _cur, _pre)	enum {	\
> +#define __EROFS_BIT(_prefix, _cur, _pre)	(enum { \
>  	_prefix ## _cur ## _BIT = _prefix ## _pre ## _BIT + \
> -		_prefix ## _pre ## _BITS }
> +	_prefix ## _pre ## _BITS })

It seems not the valid C, here is the compiler error:

...

In file included from drivers/staging/erofs/internal.h:25:0,
                 from drivers/staging/erofs/xattr.h:16,
                 from drivers/staging/erofs/xattr.c:14:
drivers/staging/erofs/erofs_fs.h:41:43: error: expected identifier or ‘(’ before ‘enum’
 #define __EROFS_BIT(_prefix, _cur, _pre) (enum { \
                                           ^
drivers/staging/erofs/erofs_fs.h:65:1: note: in expansion of macro ‘__EROFS_BIT’
 __EROFS_BIT(EROFS_I_, DATA_MAPPING, VERSION);
 ^~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:292: drivers/staging/erofs/xattr.o] Error 1

...


the __EROFS_BIT marco is used to define yyy_BIT according to xxx_BIT + xxx_BITS for cascade, eg.

__EROFS_BIT(EROFS_I_, DATA_MAPPING, VERSION);
it will defines EROFS_I_DATA_MAPPING_BIT = EROFS_I_VERSION_BIT + EROFS_I_VERSION_BITS;

__EROFS_BIT(EROFS_I_, FEATURE2, DATA_MAPPING);
it will defines EROFS_I_FEATURE2_BIT = EROFS_I_DATA_MAPPING_BIT + EROFS_I_DATA_MAPPING_BITS;


Thanks,
Gao Xiang

>  
>  /*
>   * erofs inode data mapping:
> 
