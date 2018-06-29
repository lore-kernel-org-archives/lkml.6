Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA718C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 23:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5401A27DAB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 23:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJQUXrTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5401A27DAB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935084AbeF2X1P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 19:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933794AbeF2X1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 19:27:13 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F195E27D8B;
        Fri, 29 Jun 2018 23:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530314833;
        bh=bAN3TEaQG2umCeS6Lw8blIv+KnZHadx/ZL1Z/4/1f0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJQUXrTupHhMGr5VG/aqZo0xtucskUSBaMhhc3C5FJKVE01zco1EgYY5/bXXALTca
         1alDYLYRkwi6ZHVhuEG1OYu8DJVPtqDceXULOqssr6tWrkRpMK0HJDVRedLGSET2pZ
         I/7m7EFB0vvNzbfaPIKkNoPgUm1oCPbqsy8ysIDc=
Date:   Fri, 29 Jun 2018 18:27:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayurkumar.patel@intel.com, rajatxjain@gmail.com
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
Message-ID: <20180629232711.GG40928@bhelgaas-glaptop.roam.corp.google.com>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510233912.96454-1-rajatja@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 04:39:12PM -0700, Rajat Jain wrote:
> Currently, the linux kernel disables ASPM when a device is
> removed from the kernel. But it is not enabled again when
> a new device is added on that slot even if it was originally
> enabled (by the BIOS) when the system booted up (assuming
> POLICY_DEFAULT).
> 
> This was earlier discussed here:
> https://www.spinics.net/lists/linux-pci/msg60212.html
> 
> And some suggestions from Bjorn here:
> https://www.spinics.net/lists/linux-pci/msg60541.html
> 
> This patch picks up one of the suggestion, to remove the
> CONFIG_PCIEASPM_DEBUG and thus make the code always
> avilable. This provides control to userspace to control
> ASPM on a per slot / device basis using sysfs interface.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Applied with Sinan's reviewed-by to pci/aspm for v4.19, thanks!

> ---
> v2: provide function definitions for !CONFIG_PCIEASPM case
> 
>  drivers/pci/pci.h        | 8 ++------
>  drivers/pci/pcie/Kconfig | 8 --------
>  drivers/pci/pcie/aspm.c  | 2 --
>  3 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 023f7cf25bff..b953b2349ca1 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -358,17 +358,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
> +void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> -#endif
> -
> -#ifdef CONFIG_PCIEASPM_DEBUG
> -void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
> -void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
> -#else
>  static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
>  #endif
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index b12e28b3d8f9..089b9f559d88 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -46,14 +46,6 @@ config PCIEASPM
>  
>  	  When in doubt, say Y.
>  
> -config PCIEASPM_DEBUG
> -	bool "Debug PCI Express ASPM"
> -	depends on PCIEASPM
> -	default n
> -	help
> -	  This enables PCI Express ASPM debug support. It will add per-device
> -	  interface to control ASPM.
> -
>  choice
>  	prompt "Default ASPM policy"
>  	default PCIEASPM_DEFAULT
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index c687c817b47d..8ffc13d42baa 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1161,7 +1161,6 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
>  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>  	NULL, 0644);
>  
> -#ifdef CONFIG_PCIEASPM_DEBUG
>  static ssize_t link_state_show(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -1264,7 +1263,6 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
>  		sysfs_remove_file_from_group(&pdev->dev.kobj,
>  			&dev_attr_clk_ctl.attr, power_group);
>  }
> -#endif
>  
>  static int __init pcie_aspm_disable(char *str)
>  {
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
