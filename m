Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71E8C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E3F22B62
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E3F22B62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754301AbeGFW5D convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:57:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753905AbeGFW5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5093ECB9E5;
        Fri,  6 Jul 2018 22:57:00 +0000 (UTC)
Received: from t450s.home (ovpn-116-113.phx2.redhat.com [10.3.116.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9832B7C26;
        Fri,  6 Jul 2018 22:56:55 +0000 (UTC)
Date:   Fri, 6 Jul 2018 16:56:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5 3/3] PCI: Introduce the disable_acs_redir parameter
Message-ID: <20180706165655.62306b6f@t450s.home>
In-Reply-To: <20180627174650.27433-4-logang@deltatee.com>
References: <20180627174650.27433-1-logang@deltatee.com>
        <20180627174650.27433-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 06 Jul 2018 22:57:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 06 Jul 2018 22:57:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'alex.williamson@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2018 11:46:50 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> In order to support P2P traffic on a segment of the PCI hierarchy,
> we must be able to disable the ACS redirect bits for select
> PCI bridges. The bridges must be selected before the devices are
> discovered by the kernel and the IOMMU groups created. Therefore,
> a kernel command line parameter is created to specify devices
> which must have their ACS bits disabled.
> 
> The new parameter takes a list of devices separated by a semicolon.
> Each device specified will have it's ACS redirect bits disabled.
> This is similar to the existing 'resource_alignment' parameter.
> 
> The ACS Request P2P Request Redirect, P2P Completion Redirect and P2P
> Egress Control bits are disabled which is sufficient to always allow
> passing P2P traffic uninterrupted. The bits are set after the kernel
> (optionally) enables the ACS bits itself. It is also done regardless of
> whether the kernel sets the bits or not seeing some BIOS firmware is known
> to set the bits on boot.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 ++++
>  drivers/pci/pci.c                               | 71 ++++++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a69947d9e14e..02634c4ab181 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3192,6 +3192,15 @@
>  				Adding the window is slightly risky (it may
>  				conflict with unreported devices), so this
>  				taints the kernel.
> +		disable_acs_redir=<pci_dev>[; ...]
> +				Specify one or more PCI devices (in the format
> +				specified above) separated by semicolons.
> +				Each device specified will have the PCI ACS
> +				redirect capabilities forced off which will
> +				allow P2P traffic between devices through
> +				bridges without forcing it upstream. Note:
> +				this removes isolation between devices and
> +				will make the IOMMU groups less granular.
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59638075b4df..079f7c911e09 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2983,6 +2983,61 @@ void pci_request_acs(void)
>  	pci_acs_enable = 1;
>  }
>  
> +static const char *disable_acs_redir_param;
> +
> +/**
> + * pci_disable_acs_redir - disable ACS redirect capabilities
> + * @dev: the PCI device
> + *
> + * For only devices specified in the disable_acs_redir parameter.
> + */
> +static void pci_disable_acs_redir(struct pci_dev *dev)
> +{
> +	int ret = 0;
> +	const char *p;
> +	int pos;
> +	u16 ctrl;
> +
> +	if (!disable_acs_redir_param)
> +		return;
> +
> +	p = disable_acs_redir_param;
> +	while (*p) {
> +		ret = pci_dev_str_match(dev, p, &p);
> +		if (ret < 0) {
> +			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
> +				     disable_acs_redir_param);
> +
> +			break;
> +		} else if (ret == 1) {
> +			/* Found a match */
> +			break;
> +		}
> +
> +		if (*p != ';' && *p != ',') {
> +			/* End of param or invalid format */
> +			break;
> +		}
> +		p++;
> +	}
> +
> +	if (ret != 1)
> +		return;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +
> +	/* P2P Request & Completion Redirect */
> +	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +
> +	pci_info(dev, "disabled ACS redirect\n");
> +}
> +
>  /**
>   * pci_std_enable_acs - enable ACS on devices using standard ACS capabilites
>   * @dev: the PCI device
> @@ -3022,12 +3077,22 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>  void pci_enable_acs(struct pci_dev *dev)
>  {
>  	if (!pci_acs_enable)
> -		return;
> +		goto disable_acs_redir;
>  
>  	if (!pci_dev_specific_enable_acs(dev))
> -		return;
> +		goto disable_acs_redir;
>  
>  	pci_std_enable_acs(dev);
> +
> +disable_acs_redir:
> +	/*
> +	 * Note: pci_disable_acs_redir() must be called even if
> +	 * ACS is not enabled by the kernel because the firmware
> +	 * may have unexpectedly set the flags. So if we are told
> +	 * to disable it, we should always disable it after setting
> +	 * the kernel's default preferences.
> +	 */
> +	pci_disable_acs_redir(dev);
>  }
>  
>  static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
> @@ -5967,6 +6032,8 @@ static int __init pci_setup(char *str)
>  				pcie_bus_config = PCIE_BUS_PEER2PEER;
>  			} else if (!strncmp(str, "pcie_scan_all", 13)) {
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
> +			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
> +				disable_acs_redir_param = str + 18;
>  			} else {
>  				printk(KERN_ERR "PCI: Unknown option `%s'\n",
>  						str);

If we lived in a perfect world where vendors actually implemented ACS
correctly, this looks fine, I approve.  But take a look at the quirks
we call out to via pci_dev_specific_enable_acs().  Both of these are
for Intel root ports, in one case we're twiddling ACS comparable
features in the device, in the other Intel has decided specs don't
matter and used dwords rather than words for the ACS capability and
control registers.  Is disabling redirect via device specific means,
then attempting to re-enable via standard mechanisms perhaps not the
right approach here?  Maybe if we determine a device is slated to
enable p2p we shouldn't call the device specific enabler.  The
non-standard ACS implementation on Intel root ports is still
troublesome though, I wonder if we need a more generic approach for
those...

Maybe we track if we enabled ACS via a device specific quirk and
minimally print an incompatibility error if it's also specified for
disable_acs_redir?  Thanks,

Alex
