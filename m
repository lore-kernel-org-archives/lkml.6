Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03571C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80BB20882
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80BB20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJHPDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:03:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:61203 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbeJHPDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:03:21 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 00:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,356,1534834800"; 
   d="scan'208";a="239400120"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga004.jf.intel.com with SMTP; 08 Oct 2018 00:52:42 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 08 Oct 2018 10:52:41 +0300
Date:   Mon, 8 Oct 2018 10:52:41 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     H Hartley Sweeten <hartleys@visionengravers.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3] spi: spi-ep93xx: Use dma_data_direction for
 ep93xx_spi_dma_{finish,prepare}
Message-ID: <20181008075241.GW2302@lahna.fi.intel.com>
References: <20181004024010.15986-1-natechancellor@gmail.com>
 <20181005192508.18659-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005192508.18659-1-natechancellor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 12:25:09PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> 'dma_map_sg'
> #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
>                                ~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> 3 warnings generated.
> 
> dma_{,un}map_sg expect an enum of type dma_data_direction but this
> driver uses dma_transfer_direction for everything. Convert the driver to
> use dma_data_direction for these two functions.
> 
> There are two places that strictly require an enum of type
> dma_transfer_direction: the direction member in struct dma_slave_config
> and the direction parameter in dmaengine_prep_slave_sg. To avoid using
> an explicit cast, add a simple function, ep93xx_dma_data_to_trans_dir,
> to safely map between the two types because they are not 1 to 1 in
> meaning.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
