Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2456C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6526B20676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6526B20676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeIZUgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:36:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:20753 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727504AbeIZUgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:36:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 07:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="73038201"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2018 07:23:32 -0700
Date:   Wed, 26 Sep 2018 08:25:40 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20180926142540.GB14407@localhost.localdomain>
References: <20180926150051.6ee97aae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926150051.6ee97aae@canb.auug.org.au>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 03:00:51PM +1000, Stephen Rothwell wrote:
> Hi Bjorn,
> 
> After merging the pci tree, today's linux-next build (powerpc allnoconfig)
> failed like this:
> 
> ld: drivers/pci/pci.o: in function `pci_bus_error_reset':
> pci.c:(.text+0x5fba): undefined reference to `pci_slot_mutex'
> ld: pci.c:(.text+0x5fc2): undefined reference to `pci_slot_mutex'
> 
> Caused by commit
> 
>   131b0ca2c7b2 ("PCI/ERR: Use slot reset if available")
> 
> I have applied the following hack for today (there is probably a better
> way):

Thanks for the notice. Does this mean you don't have CONFIG_SYSFS? I
must admit I missed that connection for building slot.c.

 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 26 Sep 2018 14:55:37 +1000
> Subject: [PATCH] pci: move pci_slot_mutex so it is available where needed
> 
> Fixes: 131b0ca2c7b2 ("PCI/ERR: Use slot reset if available")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/pci/pci.c  | 2 ++
>  drivers/pci/slot.c | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8c1e99a637d8..1fa67db6b21e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5190,6 +5190,8 @@ static int pci_bus_reset(struct pci_bus *bus, int probe)
>  	return ret;
>  }
>  
> +DEFINE_MUTEX(pci_slot_mutex);
> +
>  /**
>   * pci_bus_error_reset - reset the bridge's subordinate bus
>   * @bridge: The parent device that connects to the bus to reset
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 3da03fcc6fbf..c46d5e1ff536 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -14,7 +14,6 @@
>  
>  struct kset *pci_slots_kset;
>  EXPORT_SYMBOL_GPL(pci_slots_kset);
> -DEFINE_MUTEX(pci_slot_mutex);
>  
>  static ssize_t pci_slot_attr_show(struct kobject *kobj,
>  					struct attribute *attr, char *buf)
> -- 
> 2.18.0
