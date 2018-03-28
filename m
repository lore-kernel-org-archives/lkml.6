Return-Path: <gustavo.pimentel@synopsys.com>
X-Google-Smtp-Source: AIpwx4/YiueH0FABkaFWca82vkaDENRc3JbBWU/H4nH85O05dFUSF1cvYqy0/TTPKiYCjfEjbEjk
ARC-Seal: i=1; a=rsa-sha256; t=1522242910; cv=none;
        d=google.com; s=arc-20160816;
        b=PQ0rw0widxtNbw6APxfTy3vj+phNhOZTvCiRCZzLW1Juo+irhXQa/KQ0giP5QanRP1
         Aytl395y8pnpFBW2V/MZqv2aSdK7XnaGLUHqfsHNceuCN8+XWjXsTe6UcEtuzYP7fw9W
         3yri5M/aYhq90+k3LZeKrum/e3PrVeFdp/w0xjJreM8IKrFkNHznOhQkh0CvoFjy4tb+
         ZcD3RopD4b9/igzr1z/m6qgqezjlKE/BtNeBVrCJ5asAvYX71YzoTtECtmpQRJ/78tGQ
         T1A9xALvu8J7/tA8b5P28J5hx/Gf5gKD8Q4qtIvgF5mvZgwbqY93HONc+Uk1HfnHLQ4q
         Wskw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=quLR1c4F6DoCnWypHfZJ0Wqc+WrAPGcx5F7As4viDD8=;
        b=zqYt9asgGGy5s4zgVHMpxTVEqtTklrqKZ4H2VvHoTUjuwlgiDfe9ZCTJ/I/oa1ZmpB
         3A+la7kQckTfVuKdstipy0GFWrkCTH9ZfC+e0+hQRSb21NIcGyiBpOaAM9S8RIkozSSM
         T9H6DWUGN7NAtF83sZ5NcreNxHdn4F2Udl8fx00IcASghqRTh/17Z045sP2I5JejpFXX
         Spegdkdjk4L5Si0xN9FnLbvRATBxwfB5V3nvaIar/ze58vguFsYdV7o9OTVWe8ZPtf1q
         VUHnOphRhCf3S39lFI3WB3YV8SeY4gthV0p9CjYpLIT6k8rfMIvo8u0oSvKFVHnGOvu5
         Vseg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of gustavo.pimentel@synopsys.com designates 198.182.60.111 as permitted sender) smtp.mailfrom=gustavo.pimentel@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of gustavo.pimentel@synopsys.com designates 198.182.60.111 as permitted sender) smtp.mailfrom=gustavo.pimentel@synopsys.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Subject: Re: [PATCH v5 09/12] PCI: endpoint: Make
 epc->ops->clear_bar()/pci_epc_clear_bar() take struct *epf_bar
To: Niklas Cassel <niklas.cassel@axis.com>, "kishon@ti.com" <kishon@ti.com>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 Alan Douglas <adouglas@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sekhar Nori <nsekhar@ti.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Niklas Cassel <niklass@axis.com>, John Keeping <john@metanate.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-10-niklas.cassel@axis.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <5cb36688-e572-fe97-f472-657b70037ab0@synopsys.com>
Date: Wed, 28 Mar 2018 14:14:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328115018.31921-10-niklas.cassel@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596182110870306641?=
X-GMAIL-MSGID: =?utf-8?q?1596187382797552394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Niklas,

On 28/03/2018 12:50, Niklas Cassel wrote:
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
>  {
>  	u32 reg;
>  
> @@ -30,6 +31,11 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
> +void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
> +{
> +	__dw_pcie_ep_reset_bar(pci, bar, 0);
> +}
> +
>  static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no,
>  				   struct pci_epf_header *hdr)
>  {
> @@ -104,13 +110,14 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
>  }
>  
>  static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no,
> -				 enum pci_barno bar)
> +				 struct pci_epf_bar *epf_bar)
>  {
>  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
>  	u32 atu_index = ep->bar_to_atu[bar];
>  
> -	dw_pcie_ep_reset_bar(pci, bar);
> +	__dw_pcie_ep_reset_bar(pci, bar, epf_bar->flags);
>  
>  	dw_pcie_disable_atu(pci, atu_index, DW_PCIE_REGION_INBOUND);
>  	clear_bit(atu_index, ep->ib_window_map);
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index d46e3ebabb8e..7cef85124325 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -344,14 +344,17 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	struct pci_epc *epc = epf->epc;
> +	struct pci_epf_bar *epf_bar;
>  	int bar;
>  
>  	cancel_delayed_work(&epf_test->cmd_handler);
>  	pci_epc_stop(epc);
>  	for (bar = BAR_0; bar <= BAR_5; bar++) {
> +		epf_bar = &epf->bar[bar];
> +
>  		if (epf_test->reg[bar]) {
>  			pci_epf_free_space(epf, epf_test->reg[bar], bar);
> -			pci_epc_clear_bar(epc, epf->func_no, bar);
> +			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
>  		}
>  	}
>  }
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 8637822605ff..eccc942043cb 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -276,11 +276,12 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>   * pci_epc_clear_bar() - reset the BAR
>   * @epc: the EPC device for which the BAR has to be cleared
>   * @func_no: the endpoint function number in the EPC device
> - * @bar: the BAR number that has to be reset
> + * @epf_bar: the struct epf_bar that contains the BAR information
>   *
>   * Invoke to reset the BAR of the endpoint device.
>   */
> -void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, int bar)
> +void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
> +		       struct pci_epf_bar *epf_bar)
>  {
>  	unsigned long flags;
>  
> @@ -291,7 +292,7 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, int bar)
>  		return;
>  
>  	spin_lock_irqsave(&epc->lock, flags);
> -	epc->ops->clear_bar(epc, func_no, bar);
> +	epc->ops->clear_bar(epc, func_no, epf_bar);
>  	spin_unlock_irqrestore(&epc->lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 75bae8aabbf9..af657ca58b70 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -41,7 +41,7 @@ struct pci_epc_ops {
>  	int	(*set_bar)(struct pci_epc *epc, u8 func_no,
>  			   struct pci_epf_bar *epf_bar);
>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no,
> -			     enum pci_barno bar);
> +			     struct pci_epf_bar *epf_bar);
>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no,
>  			    phys_addr_t addr, u64 pci_addr, size_t size);
>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no,
> @@ -127,7 +127,8 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
>  			 struct pci_epf_header *hdr);
>  int pci_epc_set_bar(struct pci_epc *epc, u8 func_no,
>  		    struct pci_epf_bar *epf_bar);
> -void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, int bar);
> +void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
> +		       struct pci_epf_bar *epf_bar);
>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>  		     phys_addr_t phys_addr,
>  		     u64 pci_addr, size_t size);
> 

Seems good to me. :)

Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
