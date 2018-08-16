Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF752C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689FD21523
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fdcPkr6Z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fdcPkr6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689FD21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390476AbeHPMYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:24:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37842 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbeHPMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:24:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C7ADE61FEF; Thu, 16 Aug 2018 09:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534411629;
        bh=lBsyIqx49GNZCowyi0v2m1UVdmX7/pzVBPsRzmvjBnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fdcPkr6ZgNCfiYzhM+e4AyNz6acwyGCH8kavctjdBxOYKFJ5TVWZ7GnB17Tkvta/I
         JJxRC3+BbQgAUt2m+Y2cukhFI2S1CqDMU1OsZjlVdF8RzaADX9VtS3taIoPqlAod7C
         kyr6uf/M5w3p+UTmuGOy78jb8f3FWqUJbf787rko=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E110B62198;
        Thu, 16 Aug 2018 09:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534411629;
        bh=lBsyIqx49GNZCowyi0v2m1UVdmX7/pzVBPsRzmvjBnY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fdcPkr6ZgNCfiYzhM+e4AyNz6acwyGCH8kavctjdBxOYKFJ5TVWZ7GnB17Tkvta/I
         JJxRC3+BbQgAUt2m+Y2cukhFI2S1CqDMU1OsZjlVdF8RzaADX9VtS3taIoPqlAod7C
         kyr6uf/M5w3p+UTmuGOy78jb8f3FWqUJbf787rko=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Aug 2018 14:57:08 +0530
From:   poza@codeaurora.org
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
In-Reply-To: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <f11c06374a90650e862cb68206ad2fdb@codeaurora.org>
X-Sender: poza@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-16 02:56, Jon Derrick wrote:
> Some users may want to disable downstream port containment (DPC), so
> give them this option
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci.c      |  2 ++
>  drivers/pci/pci.h      |  6 ++++++
>  drivers/pci/pcie/dpc.c | 48 
> ++++++++++++++++++++++++++++++++++++++----------
>  include/linux/pci.h    |  6 ++++++
>  4 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 80da484..4e629c2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6062,6 +6062,8 @@ static int __init pci_setup(char *str)
>  				pcie_ats_disabled = true;
>  			} else if (!strcmp(str, "noaer")) {
>  				pci_no_aer();
> +			} else if (!strcmp(str, "nodpc")) {
> +				pci_no_dpc();
>  			} else if (!strcmp(str, "earlydump")) {
>  				pci_early_dump = true;
>  			} else if (!strncmp(str, "realloc=", 8)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6e0d152..f73f29e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -536,4 +536,10 @@ static inline void
> pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline void pci_aer_clear_device_status(struct pci_dev *dev) { 
> }
>  #endif
> 
> +#ifdef CONFIG_PCIE_DPC
> +void pci_no_dpc(void);
> +#else
> +static inline void pci_no_dpc(void) { }
> +#endif
> +
>  #endif /* DRIVERS_PCI_H */
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index f03279f..068fca0 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -44,6 +44,18 @@ struct dpc_dev {
>  	"Memory Request Completion Timeout",		 /* Bit Position 18 */
>  };
> 
> +static int pcie_dpc_disable;
> +
> +void pci_no_dpc(void)
> +{
> +	pcie_dpc_disable = 1;
> +}
> +
> +bool pci_dpc_available(void)
> +{
> +	return !pcie_dpc_disable && pci_aer_available() && pci_msi_enabled();

1) why do you check pci_aer_available() ?
2) and pci_aer_available() already internally checks pci_msi_enabled();

> +}
> +
>  static int dpc_wait_rp_inactive(struct dpc_dev *dpc)
>  {
>  	unsigned long timeout = jiffies + HZ;
> @@ -209,6 +221,17 @@ static irqreturn_t dpc_irq(int irq, void *context)
>  	return IRQ_HANDLED;
>  }
> 
> +static void dpc_disable(struct pci_dev *pdev)
> +{
> +	u16 cap_pos, ctl;
> +
> +	cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
> +	pci_read_config_word(pdev, cap_pos + PCI_EXP_DPC_CTL, &ctl);
> +	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_EN_NONFATAL |
> +		 PCI_EXP_DPC_CTL_INT_EN);
> +	pci_write_config_word(pdev, cap_pos + PCI_EXP_DPC_CTL, ctl);
> +}
> +
>  #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
>  static int dpc_probe(struct pcie_device *dev)
>  {
> @@ -221,9 +244,16 @@ static int dpc_probe(struct pcie_device *dev)
>  	if (pcie_aer_get_firmware_first(pdev))
>  		return -ENOTSUPP;
> 
> +	if (!pci_dpc_available()) {
> +		status = -ENOTSUPP;
> +		goto disable_dpc;
> +	}
> +
>  	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
> -	if (!dpc)
> -		return -ENOMEM;
> +	if (!dpc) {
> +		status = -ENOMEM;
> +		goto disable_dpc;
> +	}
> 
>  	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
>  	dpc->dev = dev;
> @@ -235,7 +265,7 @@ static int dpc_probe(struct pcie_device *dev)
>  	if (status) {
>  		dev_warn(device, "request IRQ%d failed: %d\n", dev->irq,
>  			 status);
> -		return status;
> +		goto disable_dpc;
>  	}
> 
>  	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
> @@ -260,17 +290,15 @@ static int dpc_probe(struct pcie_device *dev)
>  		FLAG(cap, PCI_EXP_DPC_CAP_SW_TRIGGER), dpc->rp_log_size,
>  		FLAG(cap, PCI_EXP_DPC_CAP_DL_ACTIVE));
>  	return status;
> +
> +disable_dpc:
> +	dpc_disable(pdev);
> +	return status;
>  }
> 
>  static void dpc_remove(struct pcie_device *dev)
>  {
> -	struct dpc_dev *dpc = get_service_data(dev);
> -	struct pci_dev *pdev = dev->port;
> -	u16 ctl;
> -
> -	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
> -	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
> -	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
> +	dpc_disable(dev->port);
>  }
> 
>  static struct pcie_port_service_driver dpcdriver = {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5454e6b..559b792 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1473,6 +1473,12 @@ static inline int pci_irqd_intx_xlate(struct
> irq_domain *d,
>  static inline bool pci_aer_available(void) { return false; }
>  #endif
> 
> +#ifdef CONFIG_PCIE_DPC
> +bool pci_dpc_available(void);
> +#else
> +static inline bool pci_dpc_available(void) { return false; }
> +#endif
> +
>  #ifdef CONFIG_PCIE_ECRC
>  void pcie_set_ecrc_checking(struct pci_dev *dev);
>  void pcie_ecrc_get_policy(char *str);
