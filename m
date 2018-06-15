Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 49E96C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C20208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C20208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755978AbeFOIKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:10:50 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:46598 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755819AbeFOIKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:10:49 -0400
Received: from [IPv6:2001:983:e9a7:1:14b8:b232:de25:1225] ([IPv6:2001:983:e9a7:1:14b8:b232:de25:1225])
        by smtp-cloud7.xs4all.net with ESMTPA
        id TjoifCSkL6brUTjojfubhm; Fri, 15 Jun 2018 10:10:48 +0200
Subject: Re: [PATCH] media: fsl-viu: Use proper check for presence of
 {out,in}_be32()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1528451328-21316-1-git-send-email-geert@linux-m68k.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5948eb0d-410d-5bc6-a0f3-ffcaa4b3f975@xs4all.nl>
Date:   Fri, 15 Jun 2018 10:10:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1528451328-21316-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJIZdtU95T4vc3LZes9rO12Jc77VGTknX5Y4R7bf2DKQxdxLjAsW+vxVNpLIOKWiTyL4eZE2A8a8ILibI75zf05S//OPifTP//ttFjGN3hW0QMOhBySB
 zUB2kd50eX1WJ7tJqSMBx9r02JAkEKtLzr4TQ9ruyJDDmr+Muc2CKZRuU2pmIph+gWheDv1840qQeEZeOv2fXKwhKhlir3p1oJZ6pRIemsmrgtNj+Hw70b8k
 0+HFQ3R30Km+kmGOw+mwgBbMMr99Iklg3ixd0JiP2MmC9UtoLmOAMm0sbJ1SEEkTHi/PLWhw3PuhdP16SUUP3rJB/C7X9/l5hi10Jbadf14LGIshXDIcUNW4
 G6ZFa4xTTkuzOr8s9u/WTTLIgd7nmbQYctI9QXjujfsqUA3Vl/siE46Al2H7uklLXomWk4rTc29LknnGF5vBTKS3ON5p6EUukaZu9ZTmN5n9aoTr6hjLFMNH
 YdzebrF7ZP0gJtSxyJHdi4XVl1+2Sa+mJQ4Lzt3Xf+V1QQJK3WNpA/qWhrA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/18 11:48, Geert Uytterhoeven wrote:
> When compile-testing on m68k or microblaze:
> 
>     drivers/media/platform/fsl-viu.c:41:1: warning: "out_be32" redefined
>     drivers/media/platform/fsl-viu.c:42:1: warning: "in_be32" redefined
> 
> Fix this by replacing the check for PowerPC by checks for the presence
> of {out,in}_be32().
> 
> As PowerPC implements the be32 accessors using inline functions instead
> of macros, identity definions are added for all accessors to make the
> above checks work.
> 
> Fixes: 29d750686331a1a9 ("media: fsl-viu: allow building it with COMPILE_TEST")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>

Should this go through the media tree or powerpc tree? Either way works for me.

Regards,

	Hans

> ---
> Compile-tested on m68k, microblaze, and powerpc.
> Assembler output before/after compared for powerpc.
> ---
>  arch/powerpc/include/asm/io.h    | 14 ++++++++++++++
>  drivers/media/platform/fsl-viu.c |  4 +++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index e0331e7545685c5f..3741183ae09349f1 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -222,6 +222,20 @@ static inline void out_be64(volatile u64 __iomem *addr, u64 val)
>  #endif
>  #endif /* __powerpc64__ */
>  
> +#define in_be16 in_be16
> +#define in_be32 in_be32
> +#define in_be64 in_be64
> +#define in_le16 in_le16
> +#define in_le32 in_le32
> +#define in_le64 in_le64
> +
> +#define out_be16 out_be16
> +#define out_be32 out_be32
> +#define out_be64 out_be64
> +#define out_le16 out_le16
> +#define out_le32 out_le32
> +#define out_le64 out_le64
> +
>  /*
>   * Low level IO stream instructions are defined out of line for now
>   */
> diff --git a/drivers/media/platform/fsl-viu.c b/drivers/media/platform/fsl-viu.c
> index e41510ce69a40815..5d5e030c9c980647 100644
> --- a/drivers/media/platform/fsl-viu.c
> +++ b/drivers/media/platform/fsl-viu.c
> @@ -37,8 +37,10 @@
>  #define VIU_VERSION		"0.5.1"
>  
>  /* Allow building this driver with COMPILE_TEST */
> -#ifndef CONFIG_PPC
> +#ifndef out_be32
>  #define out_be32(v, a)	iowrite32be(a, (void __iomem *)v)
> +#endif
> +#ifndef in_be32
>  #define in_be32(a)	ioread32be((void __iomem *)a)
>  #endif
>  
> 

