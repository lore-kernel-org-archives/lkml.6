Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZqGAvozrCAT3CPCWMcupZaohqGjPRZHwcg410M/wulwksyTyiJImeZilAstcbxiLdl5YRX6
ARC-Seal: i=1; a=rsa-sha256; t=1525969669; cv=none;
        d=google.com; s=arc-20160816;
        b=As41jLwKrCWZ70gjnzcUOeVXJ24qhzksSk+/deMn0ryp0RYRb/aXTXOUKqcvJXQzwI
         WVXijKsAmdcDSurCD2x02oufxUmN9linwHIqCt19y6A/lL4N2weioyji7CdHIWILlmZO
         /8f6en5PHxNQ6rHAPaYbD3dbyCQyKdqUPTLSFHAT3187qqe6ffKkPuNyhLuy77TxmK18
         2MGcBnKMiaHwSQ0kgH33giAbOsdKRBtzZ4iqbFcjvH0kxwFqO1n0Ccr1ig0XYptZk09B
         qCHprDqmgn8fkbKIb8pGk1PwlvuWzlIgv/CFFFI5KQEGyPAvbNfL671epiDaIRuisu9m
         IsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=reQESOcGnrWsrk08LKA6B2VzDTdfpAZxuDyN8V69jKE=;
        b=O3ou36ZUnJQQFAdfWh5nkzKGAnU2PNbBOUJ1D7C2K9oCA8Hy73sEHHkRCLfef4DUNJ
         w4ahJsjTweEFtqsxYv3mYKN8E6w150CBU3FfU1V+DZo90MZvgM41S9+6URmEZLBifMcV
         7c683hMFN/mK1rpLs/9ig1wEIaditA09D3SytFAci5PyFpVhyIMbO1Y0RNysNmCkAsAc
         GX0IPA3k377bfG6YAX8gMYNODhtSps1HpBL2Z4X9MkekPKvGUeG+yKMD+atLWWAsS0f9
         0K7m1jLIOIa8oMWHhBZDMCXzDEL5S5yK1fXZ9UUTHf955rmUU0xAb6xZ6aTbnMhpjvKu
         XWfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QxCkZ1hS;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QxCkZ1hS;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 11:27:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: poza@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>, linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v15 8/9] PCI/DPC: Unify and plumb error handling into DPC
Message-ID: <20180510162746.GA190385@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-9-git-send-email-poza@codeaurora.org>
 <20180510132222.GE173327@bhelgaas-glaptop.roam.corp.google.com>
 <29c21a3fbaeb56c0581da66b9203dfd1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29c21a3fbaeb56c0581da66b9203dfd1@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417976795916736?=
X-GMAIL-MSGID: =?utf-8?q?1600095172373215157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 07:56:00PM +0530, poza@codeaurora.org wrote:
> On 2018-05-10 18:52, Bjorn Helgaas wrote:
> > On Thu, May 03, 2018 at 01:03:57AM -0400, Oza Pawandeep wrote:
> ...

> > > -static pci_ers_result_t reset_link(struct pci_dev *dev)
> > > +static pci_ers_result_t reset_link(struct pci_dev *dev, int severity)
> > >  {
> > >  	struct pci_dev *udev;
> > >  	pci_ers_result_t status;
> > >  	struct pcie_port_service_driver *driver;
> > > +	u32 service;
> > > 
> > >  	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > >  		/* Reset this port for all subordinates */
> > > @@ -196,7 +197,12 @@ static pci_ers_result_t reset_link(struct
> > > pci_dev *dev)
> > >  	}
> > > 
> > >  	/* Use the aer driver of the component firstly */
> > > -	driver = pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);
> > > +	if (severity == DPC_FATAL)
> > > +		service = PCIE_PORT_SERVICE_DPC;
> > > +	else
> > > +		service = PCIE_PORT_SERVICE_AER;
> > > +
> > > +	driver = pcie_port_find_service(udev, service);
> > 
> > This is where I was wondering about passing in "service" directly
> > instead
> > of "severity".
> 
> passing service directly instead of severity ? (I do not think you meant to
> write severity there)

I did mean "severity".

> perhaps do you mean following ?
> 
> if (severity == DPC_FATAL)
>          pcie_port_find_service(udev, PCIE_PORT_SERVICE_DPC);
> else
>          pcie_port_find_service(udev, PCIE_PORT_SERVICE_AER);

No, my thought was that most of the places that use "severity" only
use it to decide between PCIE_PORT_SERVICE_DPC and
PCIE_PORT_SERVICE_AER, so if you just passed in "service" directly,
you wouldn't need this "if" statement.

Bjorn
