Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AIpwx4+FAOQTxp4S58X2jgyzzH27qsjcSe2iTtRw5+QKyrb0AmOgSX75VSuWjTZjj+b/0CAdpaIc
ARC-Seal: i=1; a=rsa-sha256; t=1522448875; cv=none;
        d=google.com; s=arc-20160816;
        b=TvnGrGw7lt/xO9bFkqUfSyP2+YlLFmMu7Sb+MJDMvQZskizmyhMRStT22tIgIsVChz
         qAmd8BoJVAraeJkHw6y8HrmLuhnHqyHZoHM/OYi3iYpFBcufqGq0zcj+5rVZPgy8mUCc
         6g0EpX32VWrQEca86MrLYIJceRk2TQHivxm3afszN8bm05+PiEOyOrEKBCOD1mPX4TCR
         Sok+j1lYyNG8Jt4hq+2snp6PA2Fg5FSW+N8FfdjIfdOpYm7qeFpkQ3wZcGU9Ewp9pggp
         kUG0UKZaAYJM2BnQ8l4kaKCTQtLxLSadZMs2bBcHJtzJcBDLLcmxyBsl/BQo75zu69Ov
         N5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=47+RIDav2gswQ53ndpMMb5xzOfniU8bcq2pBw9dch3g=;
        b=nrB05QAHY0caO9inJUsEYN90iAHLwnacxr4o8HHXEbmG3EcDmCZlMqoDjE8GVv2Wfs
         4rqz51qRw4Zr5RkCdKjPfgE1GRQIoX/z2ktIJDABl0+T8MjL63yahIR7mQJCV3R9Iral
         m5PIa6F5V6w/mUjXhTs84qew960APYDWDXzUONxVXIe1EW+3cGgh+L62cV7Ypgyh+G8O
         avRtj1aSJGv6XmF0QbBBVgpy68JZnJty0c8/patqLcPAQHAyhZ0T7YLSkay5vdvV+6E4
         F1F7diEywkTv2xTD7UtzePD7JudfWqnYy95jU70/46orTxjYjSMdTU+HdNGD+nLnSLK2
         h0Lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E11217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Fri, 30 Mar 2018 17:27:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: move pcie_pme_root_status_cleanup into SUSPEND
 section
Message-ID: <20180330222752.GD9322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180328134747.2062348-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328134747.2062348-1-arnd@arndb.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596189436680749086?=
X-GMAIL-MSGID: =?utf-8?q?1596403351585383969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 03:47:18PM +0200, Arnd Bergmann wrote:
> The power management code in pci-driver.c is a maze of #ifdefs, and
> the newly added pcie_pme_root_status_cleanup function ended up in the
> wrong one of them, causing a harmless warning in some configurations:
> 
> drivers/pci/pci-driver.c:527:13: error: 'pcie_pme_root_status_cleanup' defined but not used [-Werror=unused-function]
>  static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This moves the definition into the correct #ifdef section.
> 
> Fixes: 6c4dfc1389e1 ("PCI/PM: Clear PCIe PME Status bit in core, not PCIe port driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I folded this into 6c4dfc1389e1.

> ---
>  drivers/pci/pci-driver.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index b9bca74e9eff..6ace47099fc5 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -524,19 +524,6 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  }
>  
> -static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
> -{
> -	/*
> -	 * Some BIOSes forget to clear Root PME Status bits after system
> -	 * wakeup, which breaks ACPI-based runtime wakeup on PCI Express.
> -	 * Clear those bits now just in case (shouldn't hurt).
> -	 */
> -	if (pci_is_pcie(pci_dev) &&
> -	    (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	     pci_pcie_type(pci_dev) == PCI_EXP_TYPE_RC_EC))
> -		pcie_clear_root_pme_status(pci_dev);
> -}
> -
>  /*
>   * Default "suspend" method for devices that have no driver provided suspend,
>   * or not even a driver at all (second part).
> @@ -726,6 +713,18 @@ static void pci_pm_complete(struct device *dev)
>  #endif /* !CONFIG_PM_SLEEP */
>  
>  #ifdef CONFIG_SUSPEND
> +static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
> +{
> +	/*
> +	 * Some BIOSes forget to clear Root PME Status bits after system
> +	 * wakeup, which breaks ACPI-based runtime wakeup on PCI Express.
> +	 * Clear those bits now just in case (shouldn't hurt).
> +	 */
> +	if (pci_is_pcie(pci_dev) &&
> +	    (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(pci_dev) == PCI_EXP_TYPE_RC_EC))
> +		pcie_clear_root_pme_status(pci_dev);
> +}
>  
>  static int pci_pm_suspend(struct device *dev)
>  {
> -- 
> 2.9.0
> 
