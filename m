Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D138020883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfAHPlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:41:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:12397 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbfAHPlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:41:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 07:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,454,1539673200"; 
   d="scan'208";a="113099720"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jan 2019 07:41:30 -0800
Date:   Tue, 8 Jan 2019 08:39:59 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-core: don't initlialize ctrl->cntlid twice
Message-ID: <20190108153959.GA18014@localhost.localdomain>
References: <20190108030849.12870-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108030849.12870-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:08:49PM -0800, Andrey Smirnov wrote:
> ctrl->cntlid will already be initialized from id->cntlid for
> non-NVME_F_FABRICS controllers few lines below. For NVME_F_FABRICS
> controllers this field should already be initialized, otherwise the
> check
> 
> 	if (ctrl->cntlid != le16_to_cpu(id->cntlid))
> 
> below will always be a no-op.

Yeah, this bug defeats the fabrics sanity check. Good catch.

Reviewed-by: Keith Busch <keith.busch@intel.com>

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2e65be8b1387..1ec87b30fad1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2397,7 +2397,6 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	ctrl->oaes = le32_to_cpu(id->oaes);
>  	atomic_set(&ctrl->abort_limit, id->acl + 1);
>  	ctrl->vwc = id->vwc;
> -	ctrl->cntlid = le16_to_cpup(&id->cntlid);
>  	if (id->mdts)
>  		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
>  	else
> -- 
