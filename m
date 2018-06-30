Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D6CC6778C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EB72810E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA5jVyyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EB72810E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936285AbeF3BNN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933615AbeF3BNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:13:08 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 039662810A;
        Sat, 30 Jun 2018 01:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530321188;
        bh=xK9Gm/U/1Y1rBHo2/BfNIIh/TF3zz16jq9aosou3vJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EA5jVyykgANq5CYV05eQqPi4AoNCH29K9GRKuC257Ov/NKruwsBnt4dwHMX64aoo8
         XfupHlEEwvfsUHxGrm5mg4GT2jtbo2ec8k2reH0xebCrdVsUM+MtPU9TZK3HYBpkRr
         R3jeYfAo7zF2PS5G/7WIFA5/7EVBBJizx8aCydvw=
Date:   Fri, 29 Jun 2018 20:13:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     linux-pci@vger.kernel.org, timur@codeaurora.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Petr Tesarik <ptesarik@suse.cz>, Ram Pai <linuxram@us.ibm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christoffer Dall <cdall@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH V4] PCI: move early dump functionality from x86 arch into
 the common code
Message-ID: <20180630011305.GK40928@bhelgaas-glaptop.roam.corp.google.com>
References: <1528164985-14099-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528164985-14099-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 10:16:09PM -0400, Sinan Kaya wrote:
> Move early dump functionality into common code so that it is available for
> all archtiectures. No need to carry arch specific reads around as the read
> hooks are already initialized by the time pci_setup_device() is getting
> called during scan.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied with Andy's tested- and reviewed-by to pci/resource for v4.19,
thanks!  This is really a nice generalization.

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  arch/x86/include/asm/pci-direct.h               |  4 ---
>  arch/x86/kernel/setup.c                         |  5 ---
>  arch/x86/pci/common.c                           |  4 ---
>  arch/x86/pci/early.c                            | 44 -------------------------
>  drivers/pci/pci.c                               |  5 +++
>  drivers/pci/pci.h                               |  1 +
>  drivers/pci/probe.c                             | 19 +++++++++++
>  8 files changed, 26 insertions(+), 58 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e490902..e64f1d8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2995,7 +2995,7 @@
>  			See also Documentation/blockdev/paride.txt.
>  
>  	pci=option[,option...]	[PCI] various PCI subsystem options:
> -		earlydump	[X86] dump PCI config space before the kernel
> +		earlydump	dump PCI config space before the kernel
>  				changes anything
>  		off		[X86] don't probe for the PCI bus
>  		bios		[X86-32] force use of PCI BIOS, don't access
> diff --git a/arch/x86/include/asm/pci-direct.h b/arch/x86/include/asm/pci-direct.h
> index e1084f7..94597a3 100644
> --- a/arch/x86/include/asm/pci-direct.h
> +++ b/arch/x86/include/asm/pci-direct.h
> @@ -15,8 +15,4 @@ extern void write_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset, u8 val);
>  extern void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val);
>  
>  extern int early_pci_allowed(void);
> -
> -extern unsigned int pci_early_dump_regs;
> -extern void early_dump_pci_device(u8 bus, u8 slot, u8 func);
> -extern void early_dump_pci_devices(void);
>  #endif /* _ASM_X86_PCI_DIRECT_H */
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 2f86d88..480f250 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -991,11 +991,6 @@ void __init setup_arch(char **cmdline_p)
>  		setup_clear_cpu_cap(X86_FEATURE_APIC);
>  	}
>  
> -#ifdef CONFIG_PCI
> -	if (pci_early_dump_regs)
> -		early_dump_pci_devices();
> -#endif
> -
>  	e820__reserve_setup_data();
>  	e820__finish_early_params();
>  
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 563049c..d4ec117 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -22,7 +22,6 @@
>  unsigned int pci_probe = PCI_PROBE_BIOS | PCI_PROBE_CONF1 | PCI_PROBE_CONF2 |
>  				PCI_PROBE_MMCONF;
>  
> -unsigned int pci_early_dump_regs;
>  static int pci_bf_sort;
>  int pci_routeirq;
>  int noioapicquirk;
> @@ -599,9 +598,6 @@ char *__init pcibios_setup(char *str)
>  		pci_probe |= PCI_BIG_ROOT_WINDOW;
>  		return NULL;
>  #endif
> -	} else if (!strcmp(str, "earlydump")) {
> -		pci_early_dump_regs = 1;
> -		return NULL;
>  	} else if (!strcmp(str, "routeirq")) {
>  		pci_routeirq = 1;
>  		return NULL;
> diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
> index e5f753c..f5fc953 100644
> --- a/arch/x86/pci/early.c
> +++ b/arch/x86/pci/early.c
> @@ -57,47 +57,3 @@ int early_pci_allowed(void)
>  			PCI_PROBE_CONF1;
>  }
>  
> -void early_dump_pci_device(u8 bus, u8 slot, u8 func)
> -{
> -	u32 value[256 / 4];
> -	int i;
> -
> -	pr_info("pci 0000:%02x:%02x.%d config space:\n", bus, slot, func);
> -
> -	for (i = 0; i < 256; i += 4)
> -		value[i / 4] = read_pci_config(bus, slot, func, i);
> -
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value, 256, false);
> -}
> -
> -void early_dump_pci_devices(void)
> -{
> -	unsigned bus, slot, func;
> -
> -	if (!early_pci_allowed())
> -		return;
> -
> -	for (bus = 0; bus < 256; bus++) {
> -		for (slot = 0; slot < 32; slot++) {
> -			for (func = 0; func < 8; func++) {
> -				u32 class;
> -				u8 type;
> -
> -				class = read_pci_config(bus, slot, func,
> -							PCI_CLASS_REVISION);
> -				if (class == 0xffffffff)
> -					continue;
> -
> -				early_dump_pci_device(bus, slot, func);
> -
> -				if (func == 0) {
> -					type = read_pci_config_byte(bus, slot,
> -								    func,
> -							       PCI_HEADER_TYPE);
> -					if (!(type & 0x80))
> -						break;
> -				}
> -			}
> -		}
> -	}
> -}
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 97acba7..04052dc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -115,6 +115,9 @@ static bool pcie_ari_disabled;
>  /* If set, the PCIe ATS capability will not be used. */
>  static bool pcie_ats_disabled;
>  
> +/* If set, the PCI config space of each device is printed during boot. */
> +bool pci_early_dump;
> +
>  bool pci_ats_disabled(void)
>  {
>  	return pcie_ats_disabled;
> @@ -5805,6 +5808,8 @@ static int __init pci_setup(char *str)
>  				pcie_ats_disabled = true;
>  			} else if (!strcmp(str, "noaer")) {
>  				pci_no_aer();
> +			} else if (!strcmp(str, "earlydump")) {
> +				pci_early_dump = true;
>  			} else if (!strncmp(str, "realloc=", 8)) {
>  				pci_realloc_get_opt(str + 8);
>  			} else if (!strncmp(str, "realloc", 7)) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c358e7a0..c33265e 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -7,6 +7,7 @@
>  #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
>  
>  extern const unsigned char pcie_link_speed[];
> +extern bool pci_early_dump;
>  
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 56771f3..3678f0a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1545,6 +1545,23 @@ static int pci_intx_mask_broken(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +static void early_dump_pci_device(struct pci_dev *pdev)
> +{
> +	u32 value[256 / 4];
> +	int i;
> +
> +	if (!pci_early_dump)
> +		return;
> +
> +	pci_info(pdev, "config space:\n");
> +
> +	for (i = 0; i < 256; i += 4)
> +		pci_read_config_dword(pdev, i, &value[i / 4]);
> +
> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value,
> +		       256, false);
> +}
> +
>  /**
>   * pci_setup_device - Fill in class and map information of a device
>   * @dev: the device structure to fill
> @@ -1594,6 +1611,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
>  		   dev->vendor, dev->device, dev->hdr_type, dev->class);
>  
> +	early_dump_pci_device(dev);
> +
>  	/* Need to have dev->class ready */
>  	dev->cfg_size = pci_cfg_space_size(dev);
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
