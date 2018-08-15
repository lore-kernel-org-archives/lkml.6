Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045E7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB0C20C03
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 23:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB0C20C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbeHPB5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:57:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:16231 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbeHPB5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:57:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2018 16:02:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,245,1531810800"; 
   d="scan'208";a="82084275"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2018 16:02:35 -0700
Date:   Wed, 15 Aug 2018 17:03:22 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Message-ID: <20180815230321.GA5438@localhost.localdomain>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 03:26:39PM -0600, Jon Derrick wrote:
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -536,4 +536,10 @@ static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
>  #endif
>  
> +#ifdef CONFIG_PCIE_DPC
> +void pci_no_dpc(void);
> +#else
> +static inline void pci_no_dpc(void) { }
> +#endif

<snip>

> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1473,6 +1473,12 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>  static inline bool pci_aer_available(void) { return false; }
>  #endif
>  
> +#ifdef CONFIG_PCIE_DPC
> +bool pci_dpc_available(void);
> +#else
> +static inline bool pci_dpc_available(void) { return false; }
> +#endif

Seems like these two sections belong together. Otherwise, looks fine.
