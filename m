Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCE9ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB2721522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB2721522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbeIULcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:32:15 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46354 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIULcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:32:14 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1g3EFI-0005WH-Ay; Fri, 21 Sep 2018 13:44:52 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1g3EFH-0000ZB-A7; Fri, 21 Sep 2018 13:44:51 +0800
Date:   Fri, 21 Sep 2018 13:44:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] crypto: caam - add DPAA2 (DPSECI) driver
Message-ID: <20180921054451.fkw4o4dwaqfuweyd@gondor.apana.org.au>
References: <20180912085937.22489-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180912085937.22489-1-horia.geanta@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:59:25AM +0300, Horia Geantă wrote:
> Hi,
> 
> This patch set adds the CAAM crypto engine driver for DPAA2
> (Data Path Acceleration Architecture v2) found on ARMv8-based SoCs
> like LS1088A, LS2088A, LX2160A.
> 
> v1 -> v2:
> 5/12 - new patch fixing sparse endianness-related warnings
> 2/12 - changed commit message, since it's not a straightforward revert
> 3/12, 8/12, 11/12 - fixed sparse and compiler warnings
> 
> Previous versions:
> v1: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1763549.html
> RFC: https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg27290.html
> 
> Driver consists of:
> -DPSECI (Data Path SEC Interface) backend - low-level API that allows
> to manage DPSECI devices (DPAA2 objects) that sit on
> the Management Complex (MC) fsl-mc bus
> -algorithms frontend - AEAD, skcipher and ahash algorithms implementation
> 
> Patches 1-4 are fsl-mc bus and DPIO dependencies.
> Stuart, Laurentiu, Leo, Roy, please review the patches and let me know
> if you have anything against going with them through the cryptodev tree.
> 
> Patch 5 fixes sparse endianness-related warnings in regs.h helper functions.
> 
> Patches 6-11 are the core of the patch set, adding the driver.
> For symmetric encryption the new skcipher interface is used.
> 
> Patch 12 enables driver on arm64. It will be built only if dependency
> on DPIO (CONFIG_FSL_MC_DPIO) is satisfied.
> 
> Note: multiple modprobe/rmmod won't work without the following patches
> [5/7,v7] bus/fsl-mc: support dma configure for devices on fsl-mc bus
> https://patchwork.kernel.org/patch/10594179
> [7/7,v7] arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
> https://patchwork.kernel.org/patch/10594171
> (for LS1088A a similar DT update is needed)
> 
> Thanks,
> Horia
> 
> Horia Geantă (12):
>   bus: fsl-mc: add support for dpseci device type
>   soc: fsl: dpio: add back some frame queue functions
>   soc: fsl: dpio: add frame list format support
>   soc: fsl: dpio: add congestion notification support
>   crypto: caam - fix implicit casts in endianness helpers
>   crypto: caam - add DPAA2-CAAM (DPSECI) backend API
>   crypto: caam - add Queue Interface v2 error codes
>   crypto: caam/qi2 - add DPAA2-CAAM driver
>   crypto: caam/qi2 - add skcipher algorithms
>   crypto: caam - export ahash shared descriptor generation
>   crypto: caam/qi2 - add support for ahash algorithms
>   arm64: defconfig: enable CAAM crypto engine on QorIQ DPAA2 SoCs
> 
>  arch/arm64/configs/defconfig        |    1 +
>  drivers/bus/fsl-mc/fsl-mc-bus.c     |    5 +
>  drivers/crypto/Makefile             |    2 +-
>  drivers/crypto/caam/Kconfig         |   55 +-
>  drivers/crypto/caam/Makefile        |   10 +-
>  drivers/crypto/caam/caamalg_qi2.c   | 5165 +++++++++++++++++++++++++++++++++++
>  drivers/crypto/caam/caamalg_qi2.h   |  223 ++
>  drivers/crypto/caam/caamhash.c      |   79 +-
>  drivers/crypto/caam/caamhash_desc.c |   80 +
>  drivers/crypto/caam/caamhash_desc.h |   21 +
>  drivers/crypto/caam/compat.h        |    1 +
>  drivers/crypto/caam/dpseci.c        |  426 +++
>  drivers/crypto/caam/dpseci.h        |  333 +++
>  drivers/crypto/caam/dpseci_cmd.h    |  149 +
>  drivers/crypto/caam/error.c         |   79 +-
>  drivers/crypto/caam/error.h         |    6 +-
>  drivers/crypto/caam/regs.h          |   30 +-
>  drivers/soc/fsl/dpio/dpio-service.c |   58 +
>  include/linux/fsl/mc.h              |    6 +
>  include/soc/fsl/dpaa2-fd.h          |  242 ++
>  include/soc/fsl/dpaa2-global.h      |   15 +
>  include/soc/fsl/dpaa2-io.h          |    4 +
>  22 files changed, 6885 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/crypto/caam/caamalg_qi2.c
>  create mode 100644 drivers/crypto/caam/caamalg_qi2.h
>  create mode 100644 drivers/crypto/caam/caamhash_desc.c
>  create mode 100644 drivers/crypto/caam/caamhash_desc.h
>  create mode 100644 drivers/crypto/caam/dpseci.c
>  create mode 100644 drivers/crypto/caam/dpseci.h
>  create mode 100644 drivers/crypto/caam/dpseci_cmd.h

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
