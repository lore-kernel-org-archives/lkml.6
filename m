Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB6AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0706B20989
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0706B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeLKPtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:49:06 -0500
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:39517 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728176AbeLKPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:49:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8C01C18224D97;
        Tue, 11 Dec 2018 15:49:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grade91_3171d7440cd47
X-Filterd-Recvd-Size: 3177
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Dec 2018 15:48:59 +0000 (UTC)
Message-ID: <df69ac6826a2ec20e29d1ded7a8e7ec63c73c2c4.camel@perches.com>
Subject: Re: [PATCH 4/5] drivers: staging: erofs: Fix parentheses error in
 macro
From:   Joe Perches <joe@perches.com>
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Aaron Strahlberger <aaron.strahlberger@posteo.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
Date:   Tue, 11 Dec 2018 07:48:58 -0800
In-Reply-To: <dc56553c-a5ea-5265-5820-4bb481b0b948@huawei.com>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
         <20181211105443.21826-1-aaron.strahlberger@posteo.de>
         <20181211105443.21826-5-aaron.strahlberger@posteo.de>
         <dc56553c-a5ea-5265-5820-4bb481b0b948@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-11 at 19:06 +0800, Gao Xiang wrote:
> Hi Aaron,
> 
> On 2018/12/11 18:54, Aaron Strahlberger wrote:
> > Fix of ERROR: Macros with complex values should be enclosed in parentheses
> > from checkpatch.pl
[]
> > diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
[]
> > @@ -38,9 +38,9 @@ struct erofs_super_block {
> >  /* 80 */__u8 reserved2[48];     /* 128 bytes */
> >  } __packed;
> >  
> > -#define __EROFS_BIT(_prefix, _cur, _pre)	enum {	\
> > +#define __EROFS_BIT(_prefix, _cur, _pre)	(enum { \
> >  	_prefix ## _cur ## _BIT = _prefix ## _pre ## _BIT + \
> > -		_prefix ## _pre ## _BITS }
> > +	_prefix ## _pre ## _BITS })
> 
> It seems not the valid C, here is the compiler error:
> 
> ...
> 
> In file included from drivers/staging/erofs/internal.h:25:0,
>                  from drivers/staging/erofs/xattr.h:16,
>                  from drivers/staging/erofs/xattr.c:14:
> drivers/staging/erofs/erofs_fs.h:41:43: error: expected identifier or ‘(’ before ‘enum’
>  #define __EROFS_BIT(_prefix, _cur, _pre) (enum { \
>                                            ^
> drivers/staging/erofs/erofs_fs.h:65:1: note: in expansion of macro ‘__EROFS_BIT’
>  __EROFS_BIT(EROFS_I_, DATA_MAPPING, VERSION);
>  ^~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:292: drivers/staging/erofs/xattr.o] Error 1
> 
> ...
> 
> 
> the __EROFS_BIT marco is used to define yyy_BIT according to xxx_BIT + xxx_BITS for cascade, eg.
> 
> __EROFS_BIT(EROFS_I_, DATA_MAPPING, VERSION);
> it will defines EROFS_I_DATA_MAPPING_BIT = EROFS_I_VERSION_BIT + EROFS_I_VERSION_BITS;
> 
> __EROFS_BIT(EROFS_I_, FEATURE2, DATA_MAPPING);
> it will defines EROFS_I_FEATURE2_BIT = EROFS_I_DATA_MAPPING_BIT + EROFS_I_DATA_MAPPING_BITS;

This macro is used only once and is merely obfuscation
for that one use.  Please remove the macro and expand
it in the one place it is used.


