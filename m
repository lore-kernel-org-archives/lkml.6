Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1057ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A64320862
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 22:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A64320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbeGPWna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 18:43:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:47250 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbeGPWna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 18:43:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 15:14:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,363,1526367600"; 
   d="scan'208";a="56996646"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.32])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2018 15:13:52 -0700
Date:   Mon, 16 Jul 2018 15:13:52 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Gage Eads <gage.eads@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/pci: Some buggy virtual functions incorrectly report
 1 for intx.
Message-ID: <20180716221352.GA43385@otc-nc-03>
References: <1531773745-41876-1-git-send-email-ashok.raj@intel.com>
 <20180716151757.28206fae@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716151757.28206fae@t450s.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex

On Mon, Jul 16, 2018 at 03:17:57PM -0600, Alex Williamson wrote:
> >  static bool vfio_pci_nointx(struct pci_dev *pdev)
> >  {
> > +	/*
> > +	 * Per PCI, no VF's should have INTx
> > +	 * Simply disable it here
> > +	 */
> > +	if (pdev->is_virtfn)
> > +		return true;
> > +
> >  	switch (pdev->vendor) {
> >  	case PCI_VENDOR_ID_INTEL:
> >  		switch (pdev->device) {
> 
> Nak, this is not what vfio_pci_nointx() is meant for, it's been tried
> before and it was broken:

That seems to make sense. I'll spin a new patch and have that tested
before reposting with the following suggestions.

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/vfio/pci/vfio_pci.c?id=834814e80268c818f354c8f402e0c6604ed75589
> 
> This would cause *every* VF to print:
> 
> 	dev_info(&pdev->dev, "Masking broken INTx support\n");
> 
> If the device is incapable of generating INTx then it's probably better
> to drop it at vfio_pci_get_irq_count().  Please also note the subject is
> misidentified, this is a "vfio/pci" patch, not an "x86/pci" patch.
> kvm@vger is the official list for vfio patches.  Thanks,
> 
> Alex
