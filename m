Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 11F8FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27D6208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LOq5ZF0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27D6208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935748AbeFMVi1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:38:27 -0400
Received: from casper.infradead.org ([85.118.1.10]:51202 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935384AbeFMViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cY86FqKn+3EaCupKkt8IN4mqdEOaLdMxV0XH0ZqhAhU=; b=LOq5ZF0wQN3OAWh0tfW9HSXG/
        IZH1iNDHu0BZn4IH6MSYX9AhQdlP3qsUfm92IcsUGkDSaP8wvtPXVsNKcAzTDiuic0qiI9sOaXjz+
        oosgUMqZGSAqsDr7Q6tFJrCvTeZ5+PI8HmzdDpC4lFmRI2M6WqwJAygSgXxsM9oyHxTvp58CikatJ
        DbeoJMjf3lNHfsNCWSlrk8JA+4y+lC3aeZbFYlfFjFLU+AxzgyGrnlA1h0+F4F6sj5Z1CV4t8ABxJ
        LSPJKN1hdsnTid0YyNe5o4wA19n+g+08DpDEbCWVjpN/5XWNQ+3joPcEINPiAZ9Y7phBLmzh+ucw8
        iGSOUaq4A==;
Received: from jsimmons (helo=localhost)
        by casper.infradead.org with local-esmtp (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTDT6-0003gY-Ez; Wed, 13 Jun 2018 21:38:18 +0000
Date:   Wed, 13 Jun 2018 22:38:16 +0100 (BST)
From:   James Simmons <jsimmons@infradead.org>
To:     NeilBrown <neilb@suse.com>
cc:     Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 11/11] staging: lustre: centralize setting of
 subdir-ccflags-y
In-Reply-To: <152826511930.16761.12770722873423628004.stgit@noble>
Message-ID: <alpine.LFD.2.21.1806132237140.12664@casper.infradead.org>
References: <152826510267.16761.14361003167157833896.stgit@noble> <152826511930.16761.12770722873423628004.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180613_223816_495018_31709EB1 
X-CRM114-Status: GOOD (  14.12  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> We don't need to set subdir-ccflags-y in every Makefile.
> The whole point of the "subdir-" bit is that the setting
> can go once in the top-level Makefile.
> 

Nak: When attempting to build individual components I get:

~/lustre-upstream$ make SUBDIRS=drivers/staging/lustre/lustre/lmv modules 
-j 16

  WARNING: Symbol version dump ./Module.symvers
           is missing; modules will have no dependencies and modversions.

  CC [M]  drivers/staging/lustre/lustre/lmv/lmv_obd.o
  CC [M]  drivers/staging/lustre/lustre/lmv/lmv_intent.o
  CC [M]  drivers/staging/lustre/lustre/lmv/lmv_fld.o
  CC [M]  drivers/staging/lustre/lustre/lmv/lproc_lmv.o
drivers/staging/lustre/lustre/lmv/lproc_lmv.c:38:28: fatal error: 
lprocfs_status.h: No such file or directory
 #include <lprocfs_status.h>
                            ^
compilation terminated.


> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/staging/lustre/Makefile                    |    3 +++
>  drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile |    2 --
>  drivers/staging/lustre/lnet/klnds/socklnd/Makefile |    2 --
>  drivers/staging/lustre/lnet/libcfs/Makefile        |    2 --
>  drivers/staging/lustre/lnet/lnet/Makefile          |    2 --
>  drivers/staging/lustre/lnet/selftest/Makefile      |    2 --
>  drivers/staging/lustre/lustre/fid/Makefile         |    2 --
>  drivers/staging/lustre/lustre/fld/Makefile         |    2 --
>  drivers/staging/lustre/lustre/llite/Makefile       |    2 --
>  drivers/staging/lustre/lustre/lmv/Makefile         |    2 --
>  drivers/staging/lustre/lustre/lov/Makefile         |    2 --
>  drivers/staging/lustre/lustre/mdc/Makefile         |    2 --
>  drivers/staging/lustre/lustre/mgc/Makefile         |    2 --
>  drivers/staging/lustre/lustre/obdclass/Makefile    |    2 --
>  drivers/staging/lustre/lustre/obdecho/Makefile     |    2 --
>  drivers/staging/lustre/lustre/osc/Makefile         |    2 --
>  drivers/staging/lustre/lustre/ptlrpc/Makefile      |    2 --
>  17 files changed, 3 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/staging/lustre/Makefile b/drivers/staging/lustre/Makefile
> index 95ffe337a80a..a44086fa8668 100644
> --- a/drivers/staging/lustre/Makefile
> +++ b/drivers/staging/lustre/Makefile
> @@ -1,2 +1,5 @@
> +subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> +subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
> +
>  obj-$(CONFIG_LNET)		+= lnet/
>  obj-$(CONFIG_LUSTRE_FS)		+= lustre/
> diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile b/drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile
> index 4affe1d79948..e1a05ece130c 100644
> --- a/drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile
> +++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LNET_XPRT_IB) += ko2iblnd.o
>  ko2iblnd-y := o2iblnd.o o2iblnd_cb.o o2iblnd_modparams.o
> diff --git a/drivers/staging/lustre/lnet/klnds/socklnd/Makefile b/drivers/staging/lustre/lnet/klnds/socklnd/Makefile
> index a7da1abfc804..4d03cad997c1 100644
> --- a/drivers/staging/lustre/lnet/klnds/socklnd/Makefile
> +++ b/drivers/staging/lustre/lnet/klnds/socklnd/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LNET) += ksocklnd.o
>  
> diff --git a/drivers/staging/lustre/lnet/libcfs/Makefile b/drivers/staging/lustre/lnet/libcfs/Makefile
> index 6a1b232da495..3d6b99c6e883 100644
> --- a/drivers/staging/lustre/lnet/libcfs/Makefile
> +++ b/drivers/staging/lustre/lnet/libcfs/Makefile
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LNET) += libcfs.o
>  
> diff --git a/drivers/staging/lustre/lnet/lnet/Makefile b/drivers/staging/lustre/lnet/lnet/Makefile
> index 0a9d70924fe0..ba33e90e47ec 100644
> --- a/drivers/staging/lustre/lnet/lnet/Makefile
> +++ b/drivers/staging/lustre/lnet/lnet/Makefile
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LNET) += lnet.o
>  
> diff --git a/drivers/staging/lustre/lnet/selftest/Makefile b/drivers/staging/lustre/lnet/selftest/Makefile
> index 3ccc8966b566..16f8efcd1531 100644
> --- a/drivers/staging/lustre/lnet/selftest/Makefile
> +++ b/drivers/staging/lustre/lnet/selftest/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LNET_SELFTEST) := lnet_selftest.o
>  
> diff --git a/drivers/staging/lustre/lustre/fid/Makefile b/drivers/staging/lustre/lustre/fid/Makefile
> index 77b65b92667d..11f6e4046e61 100644
> --- a/drivers/staging/lustre/lustre/fid/Makefile
> +++ b/drivers/staging/lustre/lustre/fid/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include/
>  
>  obj-$(CONFIG_LUSTRE_FS) += fid.o
>  fid-y := fid_request.o fid_lib.o lproc_fid.o
> diff --git a/drivers/staging/lustre/lustre/fld/Makefile b/drivers/staging/lustre/lustre/fld/Makefile
> index 426deba8b815..e7843d7aac9d 100644
> --- a/drivers/staging/lustre/lustre/fld/Makefile
> +++ b/drivers/staging/lustre/lustre/fld/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include/
>  
>  obj-$(CONFIG_LUSTRE_FS) += fld.o
>  fld-y := fld_request.o fld_cache.o lproc_fld.o
> diff --git a/drivers/staging/lustre/lustre/llite/Makefile b/drivers/staging/lustre/lustre/llite/Makefile
> index 5200924182ae..f46b61770254 100644
> --- a/drivers/staging/lustre/lustre/llite/Makefile
> +++ b/drivers/staging/lustre/lustre/llite/Makefile
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LUSTRE_FS) += lustre.o
>  lustre-y := dcache.o dir.o file.o llite_lib.o llite_nfs.o \
> diff --git a/drivers/staging/lustre/lustre/lmv/Makefile b/drivers/staging/lustre/lustre/lmv/Makefile
> index 91c99114aa13..7a392c31c508 100644
> --- a/drivers/staging/lustre/lustre/lmv/Makefile
> +++ b/drivers/staging/lustre/lustre/lmv/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LUSTRE_FS) += lmv.o
>  lmv-y := lmv_obd.o lmv_intent.o lmv_fld.o lproc_lmv.o
> diff --git a/drivers/staging/lustre/lustre/lov/Makefile b/drivers/staging/lustre/lustre/lov/Makefile
> index 1ebf0193f61a..6294769aca95 100644
> --- a/drivers/staging/lustre/lustre/lov/Makefile
> +++ b/drivers/staging/lustre/lustre/lov/Makefile
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LUSTRE_FS) += lov.o
>  lov-y := lov_obd.o lov_pack.o lov_offset.o lov_merge.o \
> diff --git a/drivers/staging/lustre/lustre/mdc/Makefile b/drivers/staging/lustre/lustre/mdc/Makefile
> index c7bc3351ccb0..c3bc71f6596d 100644
> --- a/drivers/staging/lustre/lustre/mdc/Makefile
> +++ b/drivers/staging/lustre/lustre/mdc/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LUSTRE_FS) += mdc.o
>  mdc-y := mdc_request.o mdc_reint.o mdc_lib.o mdc_locks.o lproc_mdc.o
> diff --git a/drivers/staging/lustre/lustre/mgc/Makefile b/drivers/staging/lustre/lustre/mgc/Makefile
> index 8abf108dbcf7..301cd7a1fa25 100644
> --- a/drivers/staging/lustre/lustre/mgc/Makefile
> +++ b/drivers/staging/lustre/lustre/mgc/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LUSTRE_FS) += mgc.o
>  mgc-y := mgc_request.o lproc_mgc.o
> diff --git a/drivers/staging/lustre/lustre/obdclass/Makefile b/drivers/staging/lustre/lustre/obdclass/Makefile
> index e36ba2167d10..be118391b402 100644
> --- a/drivers/staging/lustre/lustre/obdclass/Makefile
> +++ b/drivers/staging/lustre/lustre/obdclass/Makefile
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LUSTRE_FS) += obdclass.o
>  
> diff --git a/drivers/staging/lustre/lustre/obdecho/Makefile b/drivers/staging/lustre/lustre/obdecho/Makefile
> index 6be66fbab872..4ae346f5ddcd 100644
> --- a/drivers/staging/lustre/lustre/obdecho/Makefile
> +++ b/drivers/staging/lustre/lustre/obdecho/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LUSTRE_FS) += obdecho.o
>  obdecho-y := echo_client.o
> diff --git a/drivers/staging/lustre/lustre/osc/Makefile b/drivers/staging/lustre/lustre/osc/Makefile
> index 30dec90e64e8..ecdf07e925c7 100644
> --- a/drivers/staging/lustre/lustre/osc/Makefile
> +++ b/drivers/staging/lustre/lustre/osc/Makefile
> @@ -1,5 +1,3 @@
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LUSTRE_FS) += osc.o
>  osc-y := osc_request.o osc_dev.o osc_object.o \
> diff --git a/drivers/staging/lustre/lustre/ptlrpc/Makefile b/drivers/staging/lustre/lustre/ptlrpc/Makefile
> index aa152e652002..0fae7de09de2 100644
> --- a/drivers/staging/lustre/lustre/ptlrpc/Makefile
> +++ b/drivers/staging/lustre/lustre/ptlrpc/Makefile
> @@ -1,6 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/include
> -subdir-ccflags-y += -I$(srctree)/drivers/staging/lustre/lustre/include
>  
>  obj-$(CONFIG_LUSTRE_FS) += ptlrpc.o
>  
> 
> 
> 
