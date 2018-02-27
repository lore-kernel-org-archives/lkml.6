Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeB0PM4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:12:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:45269 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753292AbeB0PMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:12:55 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,401,1515484800";
   d="scan'208";a="21177905"
Date: Tue, 27 Feb 2018 08:13:11 -0700
From: Keith Busch <keith.busch@intel.com>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: assign separate irq vectors for adminq and ioq0
Message-ID: <20180227151311.GD10832@localhost.localdomain>
References: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 04:46:17PM +0800, Jianchao Wang wrote:
> Currently, adminq and ioq0 share the same irq vector. This is
> unfair for both amdinq and ioq0.
>  - For adminq, its completion irq has to be bound on cpu0.
>  - For ioq0, when the irq fires for io completion, the adminq irq
>    action has to be checked also.

This change log could use some improvements. Why is it bad if admin
interrupts affinity is with cpu0?

Are you able to measure _any_ performance difference on IO queue 1 vs IO
queue 2 that you can attribute to IO queue 1's sharing vector 0?
 
> @@ -1945,11 +1947,11 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	 * setting up the full range we need.
>  	 */
>  	pci_free_irq_vectors(pdev);
> -	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
> -			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
> -	if (nr_io_queues <= 0)
> +	ret = pci_alloc_irq_vectors_affinity(pdev, 1, (nr_io_queues + 1),
> +			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
> +	if (ret <= 0)
>  		return -EIO;
> -	dev->max_qid = nr_io_queues;
> +	dev->max_qid = ret - 1;

So controllers that have only legacy or single-message MSI don't get any
IO queues?
