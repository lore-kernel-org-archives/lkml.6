Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F2CC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE4520883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE4520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932748AbeFUOGt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:06:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:41772 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754079AbeFUOGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:06:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 07:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="66514138"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2018 07:06:34 -0700
Date:   Thu, 21 Jun 2018 08:09:48 -0600
From:   Keith Busch <keith.busch@linux.intel.com>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme-pci: move nvme_kill_queues to
 nvme_remove_dead_ctrl
Message-ID: <20180621140948.GA26662@localhost.localdomain>
References: <1529473342-1886-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529473342-1886-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 01:42:22PM +0800, Jianchao Wang wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fc33804..73a97fc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2289,6 +2289,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
>  
>  	nvme_get_ctrl(&dev->ctrl);
>  	nvme_dev_disable(dev, false);
> +	nvme_kill_queues(&dev->ctrl);
>  	if (!queue_work(nvme_wq, &dev->remove_work))
>  		nvme_put_ctrl(&dev->ctrl);
>  }
> @@ -2405,7 +2406,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
>  	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
> -	nvme_kill_queues(&dev->ctrl);
>  	if (pci_get_drvdata(pdev))
>  		device_release_driver(&pdev->dev);
>  	nvme_put_ctrl(&dev->ctrl);

Looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
