Return-Path: <nks@flawful.org>
X-Google-Smtp-Source: AIpwx48PdHwimwCdzDME0MESXSZqcwesWeDBc6c+xDM7xAFjFjwQsRuQREslQ+vYa4d8KrplSk69
ARC-Seal: i=1; a=rsa-sha256; t=1522694825; cv=none;
        d=google.com; s=arc-20160816;
        b=Id78q84pcfiwleoQkPZRwLOn/5+cDkO3/NwVHTaeAfrS8Fwd+AGkY/Thbc+CsJmf+T
         qHJp9IrWzTNsywApnUmCZRQK15jFmretAUfHmmzfxBpbYNywhlMV3OBAUHxGLY+9X58o
         UlDs69hm/FlDZ5aYp3UPy1aYdIpbdpM+CsqSct88WWiSh6szNOB4i97FJFiA2kLyGvuQ
         r4b3HHZELRHLNXyJk46WOFrkJ7pJ8b/m6/xVoYvY57r6qQA9XqZk1pc2nhMQ0yhXIJqR
         eWC4EcY7P4LJ86+4XEqlDovLD9OdWls/ew7HAemSgIbJkp6QbDMQ0oAM3mZd3fj/2DC7
         O05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=LDS2xsJcjzROs1Jrx1AMyogOQ1Q/GkNN4yhdpeKndTA=;
        b=098FWeDBkdsH8jAyOSoBvQPw0J4Mj06wfNMIyMx356AECGUH3e3LkOtCscUIzojvy0
         s8pyK6WZBrEIKPxMrQxcKvmA922ZdUlGjJlg/ALLqzW6VMcfJnQxea4a32yM7RH/ShHN
         y4nDxsX+tWtP16lbCYvs4rHrN0Z3njsRu80K6ebTNqSH6nYBJkRAKytgfR7fDl6IPAO5
         Hs8VBbpmU1BWP8Gg07RsGJEArm6BuZkzhHFzywPjHfqQDSmHgRaU0lLJKpwubs/oBsci
         5Wv8LQoTuGp5W6cDudQDnA691Uf6n5CsxvlmWfTU8RnMIJXhlweluXfJ260t5CEgPHn9
         DqCA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@flawful.org header.s=mail header.b=H6n4Zn58;
       spf=pass (google.com: domain of nks@flawful.org designates 213.80.101.71 as permitted sender) smtp.mailfrom=nks@flawful.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@flawful.org header.s=mail header.b=H6n4Zn58;
       spf=pass (google.com: domain of nks@flawful.org designates 213.80.101.71 as permitted sender) smtp.mailfrom=nks@flawful.org
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
	dkim=pass (1024-bit key) header.d=flawful.org
Date: Mon, 2 Apr 2018 20:47:01 +0200
From: Niklas Cassel <nks@flawful.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Niklas Cassel <niklas.cassel@axis.com>,
	cyrille.pitchen@free-electrons.com,
	Alan Douglas <adouglas@cadence.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Sekhar Nori <nsekhar@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <niklass@axis.com>, John Keeping <john@metanate.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] PCI: endpoint: Make
 epc->ops->clear_bar()/pci_epc_clear_bar() take struct *epf_bar
Message-ID: <20180402184701.GA23587@flawful.org>
References: <20180328115018.31921-1-niklas.cassel@axis.com>
 <20180328115018.31921-10-niklas.cassel@axis.com>
 <ac3131cb-468d-5143-62a4-68d6e6b47e82@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac3131cb-468d-5143-62a4-68d6e6b47e82@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596182110870306641?=
X-GMAIL-MSGID: =?utf-8?q?1596661248789374749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 03:30:23PM +0530, Kishon Vijay Abraham I wrote:
> Hi Niklas,
> 
> On Wednesday 28 March 2018 05:20 PM, Niklas Cassel wrote:
> > Make epc->ops->clear_bar()/pci_epc_clear_bar() take struct *epf_bar.
> > 
> > This is needed so that epc->ops->clear_bar() can clear the BAR pair,
> > if the BAR is 64-bits wide.
> > 
> > This also makes it possible for pci_epc_clear_bar() to sanity check
> > the flags.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> > ---
> >  drivers/pci/cadence/pcie-cadence-ep.c         |  3 ++-
> >  drivers/pci/dwc/pcie-designware-ep.c          | 13 ++++++++++---
> >  drivers/pci/endpoint/functions/pci-epf-test.c |  5 ++++-
> >  drivers/pci/endpoint/pci-epc-core.c           |  7 ++++---
> >  include/linux/pci-epc.h                       |  5 +++--
> >  5 files changed, 23 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/cadence/pcie-cadence-ep.c b/drivers/pci/cadence/pcie-cadence-ep.c
> > index 2905e098678c..3d8283e450a9 100644
> > --- a/drivers/pci/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/cadence/pcie-cadence-ep.c
> > @@ -145,10 +145,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
> >  }
> >  
> >  static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
> > -				   enum pci_barno bar)
> > +				   struct pci_epf_bar *epf_bar)
> >  {
> >  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> >  	struct cdns_pcie *pcie = &ep->pcie;
> > +	enum pci_barno bar = epf_bar->barno;
> >  	u32 reg, cfg, b, ctrl;
> >  
> >  	if (bar < BAR_4) {
> > diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> > index 571b90f88d84..cc4d8381c1dc 100644
> > --- a/drivers/pci/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/dwc/pcie-designware-ep.c
> > @@ -19,7 +19,8 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> >  	pci_epc_linkup(epc);
> >  }
> >  
> > -void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
> > +static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
> > +				   int flags)
> 
> Looks like the 'flags' are not used anywhere here?

Hello Kishon,

That is correct, this patch is simply refactoring, flags is first used
in patch 11/12, since I didn't want to refactor + add new code in the
same commit.

Kind regards,
Niklas
