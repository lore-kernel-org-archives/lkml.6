Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE6DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E365920664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E365920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeJaA7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:59:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:4372 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJaA7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:59:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 09:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="96294721"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 30 Oct 2018 09:05:04 -0700
Date:   Tue, 30 Oct 2018 10:02:42 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 11/14] irq: add support for allocating (and affinitizing)
 sets of IRQs
Message-ID: <20181030160242.GD18906@localhost.localdomain>
References: <20181029163738.10172-1-axboe@kernel.dk>
 <20181029163738.10172-12-axboe@kernel.dk>
 <20181030142601.GA18906@localhost.localdomain>
 <c11c95ae-5e10-38bd-d2c2-e2407634f52a@kernel.dk>
 <20181030144527.GB18906@localhost.localdomain>
 <46dbcbcd-799f-9970-a68f-de7e96b1a6bb@kernel.dk>
 <20181030150840.GC18906@localhost.localdomain>
 <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d049e764-b9d1-f06f-40d3-39517f3f65a2@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 09:18:05AM -0600, Jens Axboe wrote:
> On 10/30/18 9:08 AM, Keith Busch wrote:
> > On Tue, Oct 30, 2018 at 08:53:37AM -0600, Jens Axboe wrote:
> >> The sum of the set can't exceed the nvecs passed in, the nvecs passed in
> >> should be the less than or equal to nvecs. Granted this isn't enforced,
> >> and perhaps that should be the case.
> > 
> > That should at least initially be true for a proper functioning
> > driver. It's not enforced as you mentioned, but that's only related to
> > the issue I'm referring to.
> > 
> > The problem is pci_alloc_irq_vectors_affinity() takes a range, min_vecs
> > and max_vecs, but a range of allowable vector allocations doesn't make
> > sense when using sets.
> 
> I feel like we're going in circles here, not sure what you feel the
> issue is now? The range is fine, whoever uses sets will need to adjust
> their sets based on what pci_alloc_irq_vectors_affinity() returns,
> if it didn't return the passed in desired max.

Sorry, let me to try again.

pci_alloc_irq_vectors_affinity() starts at the provided max_vecs. If
that doesn't work, it will iterate down to min_vecs without returning to
the caller. The caller doesn't have a chance to adjust its sets between
iterations when you provide a range.

The 'masks' overrun problem happens if the caller provides min_vecs
as a smaller value than the sum of the set (plus any reserved).

If it's up to the caller to ensure that doesn't happen, then min and
max must both be the same value, and that value must also be the same as
the set sum + reserved vectors. The range just becomes redundant since
it is already bounded by the set.

Using the nvme example, it would need something like this to prevent the
'masks' overrun:

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a8747b956e43..625eff570eaa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2120,7 +2120,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * setting up the full range we need.
 	 */
 	pci_free_irq_vectors(pdev);
-	result = pci_alloc_irq_vectors_affinity(pdev, 1, nr_io_queues,
+	result = pci_alloc_irq_vectors_affinity(pdev, nr_io_queues, nr_io_queues,
 			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 	if (result <= 0)
 		return -EIO;
--
