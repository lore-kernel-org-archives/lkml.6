Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AIpwx4+g/fA8wUrV4KMSWyU0PPcIyQ0MvlA6oBPzAgv2GhlDKBLYw6DlMa5u046GJpZKA2a5yKUv
ARC-Seal: i=1; a=rsa-sha256; t=1522321284; cv=none;
        d=google.com; s=arc-20160816;
        b=Oes0thLNQSVNBcPkGdmvotTAdXbarfm84XYygtjt/ruhbHGU4J5HSphGNqI58w5D7B
         a0XcVtJovdS+ezphBKRqL/Ip8BsfPD2vxTBaqQ8z/RnS6BBAxyN29VDPZKYr/hTb8P2I
         VIwHtsj+1GMuYqwdDOrDlvJuGLsP1mDMDN+Az1/dSYA19IgPnpftZSlxyd92a6rMwcsG
         IzSJPzOq/1jo3+bsrO5Gk+Iwbvm/Dun2EulqVcDQ1AUDEjo1xnsRszUb3K3Ccu0VoTvb
         1HeVy7OvHAr2uTxHZ3F82J2FAyhDMa4fthgO+ElNWO/zBrrhYBXQQHafNRUJ1VPAB3sA
         KzeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Fjl6aA7eAHGIwZ2xFyGppK7SVoxGlwmdRGPkBcs0lZY=;
        b=u+Pju7RRfHWNe+Ck1QKa/oN6yfc34f7HCPZ3WELfzn+Cv/q7eiXNSBnydC4IjAGvWl
         RKVgKFofzNweP0r2WXhSTlLxpx3ya5EhaO4OLyfSGuD5KD/cpL/q7nRz6eH9lZjfWK9B
         1euPhwPlK6dLieLRA4IWyo/f+CbiqPdzDN1Fa8PnrnYImcUg4qvZ3WFnTPTC0Q154Eey
         CxwOqiljYDDijdmy6pOEEqql0GBHzsd5pYtU+3msKBXUf/3DnwFKeFFmY5Xy4v4+P7Ik
         7bXPO5vzbyw1xONw241+O/6T4dOj9ULbwhVio4luiknLaXDiKa2Vd6jdkdeE4tn2dn5n
         yC0A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: move pcie_pme_root_status_cleanup into SUSPEND section
Date: Thu, 29 Mar 2018 13:01:42 +0200
Message-ID: <8350395.vIT3VM8fAC@aspire.rjw.lan>
In-Reply-To: <20180328134747.2062348-1-arnd@arndb.de>
References: <20180328134747.2062348-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596189436680749086?=
X-GMAIL-MSGID: =?utf-8?q?1596269563266034421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday, March 28, 2018 3:47:18 PM CEST Arnd Bergmann wrote:
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
> 

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
