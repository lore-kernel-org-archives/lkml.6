Return-Path: <kishon@ti.com>
X-Google-Smtp-Source: AIpwx49kZQ0TFSrb/cLI/bQgKW8/HsmTnq/s3UvJqd10J6Wj52aieJ8hQ8zzg1ifdHLARYI7Oomt
ARC-Seal: i=1; a=rsa-sha256; t=1522317638; cv=none;
        d=google.com; s=arc-20160816;
        b=gMzkmemMVUlSWvEvRsLPL0F2QbIWFmOB9aM0N8fkYw5e4it99eFikQmqTiDY/Xh1Ch
         /dYbJaXtVOZ34hIpjOIVbFlb+V/vDUfWR5wFuGyhhZLiFRqPm2npSv3elUxhZSA2G8CQ
         kyNEXjl68uaZuNPUk0bSvg+fvk138/EM+uyfoJBDkt6O2H3U5C7usd5PturPzUXqv41q
         F6GgCyPnNMccT5FVFWlaFDO2V6AucnLjTjwaYgFYPmMs3Dwzedly276lLc6CVzo9gJPc
         0dwsjaB7TXfJqqf/aqGE2dMIEHNCrDiTwInRQ6ilzkvLUjr5A5D8uPtJca3C3iR6SoGW
         aIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :arc-authentication-results;
        bh=cBMYdoXrvWhVAmoADZcHCCNnI7Eibp4D424Glq1Ebgg=;
        b=EDzbBwpr4C61MwmhKZAXPKovEtXCl9daWg0IupKCt+PTCMcrTSiAPxQW1KNoXGwspR
         hByvoQ0I3z48+bH27fHw/QE1HL4p0O906oEQ7pXRGx9MfeZuPoLbAPZm022GRet1aQ9l
         b6Dmm6YQj5+s8XhGR3PSeFzHy6Z7U0UeNuL8esJdhTZYF/CU0TTnlaLRNYUJGyUXC67S
         vsh9Jev9eGJ6QIxXHtf/0nlHRCReOHWPc/SXPsDpSGhNnm5wATYXd1mrooj2Uek15SrE
         McA+q7OEQu6FmQJge/o6ZyN2SfSoS1x1beOZ0FbxtDNfD5lqJk96MKKPoS/cwFnqrbuT
         Gatg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Had5bq8k;
       spf=pass (google.com: domain of kishon@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=kishon@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Had5bq8k;
       spf=pass (google.com: domain of kishon@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=kishon@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH v5 09/12] PCI: endpoint: Make
 epc->ops->clear_bar()/pci_epc_clear_bar() take struct *epf_bar
To: Niklas Cassel <niklas.cassel@axis.com>,
        <cyrille.pitchen@free-electrons.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Joao
 Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>,
        Sekhar Nori <nsekhar@ti.com>, Shawn Lin
	<shawn.lin@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklass@axis.com>, John Keeping <john@metanate.com>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-10-niklas.cassel@axis.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ac3131cb-468d-5143-62a4-68d6e6b47e82@ti.com>
Date: Thu, 29 Mar 2018 15:30:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-10-niklas.cassel@axis.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596182110870306641?=
X-GMAIL-MSGID: =?utf-8?q?1596265740255900293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Niklas,

On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> Make epc->ops->clear_bar()/pci_epc_clear_bar() take struct *epf_bar.
> 
> This is needed so that epc->ops->clear_bar() can clear the BAR pair,
> if the BAR is 64-bits wide.
> 
> This also makes it possible for pci_epc_clear_bar() to sanity check
> the flags.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  drivers/pci/cadence/pcie-cadence-ep.c         |  3 ++-
>  drivers/pci/dwc/pcie-designware-ep.c          | 13 ++++++++++---
>  drivers/pci/endpoint/functions/pci-epf-test.c |  5 ++++-
>  drivers/pci/endpoint/pci-epc-core.c           |  7 ++++---
>  include/linux/pci-epc.h                       |  5 +++--
>  5 files changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> index 2905e098678c..3d8283e450a9 100644
> --- a/drivers/pci/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> @@ -145,10 +145,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
>  }
>  
>  static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
> -				   enum pci_barno bar)
> +				   struct pci_epf_bar *epf_bar)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct cdns_pcie *pcie = &ep->pcie;
> +	enum pci_barno bar = epf_bar->barno;
>  	u32 reg, cfg, b, ctrl;
>  
>  	if (bar < BAR_4) {
> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> index 571b90f88d84..cc4d8381c1dc 100644
> --- a/drivers/pci/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/dwc/pcie-designware-ep.c
> @@ -19,7 +19,8 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  	pci_epc_linkup(epc);
>  }
>  
> -void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
> +static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
> +				   int flags)

Looks like the 'flags' are not used anywhere here?

Thanks
Kishon
