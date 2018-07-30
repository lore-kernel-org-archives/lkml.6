Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A87C46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 01:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D9720873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 01:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D9720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbeG3DIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 23:08:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:11835 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728628AbeG3DIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 23:08:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2018 18:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,420,1526367600"; 
   d="scan'208";a="78869862"
Received: from jalaryea-mobl5.amr.corp.intel.com (HELO spandruv-mobl.amr.corp.intel.com) ([10.254.15.88])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2018 18:36:12 -0700
Message-ID: <a43b252b84196087d523c97a162461e6883be1ab.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel_ish-hid: tx_buf memory leak on probe/remove
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Anton Vasilyev <vasilyev@ispras.ru>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Date:   Sun, 29 Jul 2018 18:36:12 -0700
In-Reply-To: <20180724143455.13770-1-vasilyev@ispras.ru>
References: <20180724143455.13770-1-vasilyev@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-24 at 17:34 +0300, Anton Vasilyev wrote:
> ish_dev_init() allocates 512*176 bytes memory for tx_buf and stores
> it at
> &dev->wr_free_list_head.link list on ish_probe().
> But there is no deallocation of this memory in ish_remove() and in
> ish_probe() error path.
> So current intel-ish-ipc provides 88 KB memory leak for each
> probe/release.
> 
> The patch replaces kzalloc allocation by devm_kzalloc and removes
> ishtp_device *dev deallocation by kfree.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
I prefer align with "(" for the next line for multi line statements
even if character /line > slightly over 80. If you can do that resubmit
 with my ACK below.

> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/hid/intel-ish-hid/ipc/ipc.c     | 7 +++++--
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 --
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-
> ish-hid/ipc/ipc.c
> index 9a60ec13cb10..2f8e5402b450 100644
> --- a/drivers/hid/intel-ish-hid/ipc/ipc.c
> +++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
> @@ -907,7 +907,8 @@ struct ishtp_device *ish_dev_init(struct pci_dev
> *pdev)
>  	struct ishtp_device *dev;
>  	int	i;
>  
> -	dev = kzalloc(sizeof(struct ishtp_device) + sizeof(struct
> ish_hw),
> +	dev = devm_kzalloc(&pdev->dev,
> +		sizeof(struct ishtp_device) + sizeof(struct ish_hw),
>  		GFP_KERNEL);
>  	if (!dev)
>  		return NULL;
> @@ -925,7 +926,9 @@ struct ishtp_device *ish_dev_init(struct pci_dev
> *pdev)
>  	for (i = 0; i < IPC_TX_FIFO_SIZE; ++i) {
>  		struct wr_msg_ctl_info	*tx_buf;
>  
> -		tx_buf = kzalloc(sizeof(struct wr_msg_ctl_info),
> GFP_KERNEL);
> +		tx_buf = devm_kzalloc(&pdev->dev,
> +			sizeof(struct wr_msg_ctl_info),
> +			GFP_KERNEL);
>  		if (!tx_buf) {
>  			/*
>  			 * IPC buffers may be limited or not
> available
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index a2c53ea3b5ed..81d035a480bc 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -172,7 +172,6 @@ static int ish_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
>  	free_irq(pdev->irq, dev);
>  free_device:
>  	pci_iounmap(pdev, hw->mem_addr);
> -	kfree(dev);
>  release_regions:
>  	pci_release_regions(pdev);
>  disable_device:
> @@ -202,7 +201,6 @@ static void ish_remove(struct pci_dev *pdev)
>  	pci_release_regions(pdev);
>  	pci_clear_master(pdev);
>  	pci_disable_device(pdev);
> -	kfree(ishtp_dev);
>  }
>  
>  static struct device __maybe_unused *ish_resume_device;
