Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AH8x2276mbDo775uzpP6huPGaO8+Rm01OA/TOHRhELJPL0K+zd6kgNdwnwpA2F1mTG/tiDsfptD1
ARC-Seal: i=1; a=rsa-sha256; t=1519676602; cv=none;
        d=google.com; s=arc-20160816;
        b=IfG7RXiEOWfbzwjDxzTcbdhGEjglPVLOba2pK9AW6lR/GQ1Rd75grmlNdC23O07rZW
         WE6Rp/xAxQADKa1bCZXoL9UlkLPXKBMHy3S/k5fUrWYUPU1k2mCq/kleakVIUWeYT9lJ
         2R/xZ3+OgP0lia0Luwh6m1FXv1qeZ1jLn+i1pUQWMimk7HVSrnH5Rc6YZIFN/V57a+ZU
         X+1HZ6pIdI4d+8UaZzY78R/SK74teofYZQkWBia86X/FXFiB1fIupJAxzEQXn9pRi0P9
         eYHHYv7eCFRAO2KxlJRBDMNOuGZa5So+B4xH3lBCTQtoN2/67sjpznh9PyGhb9hrBaBC
         vuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=6bEsiQ8lvijqgikSrEvWNuw/UeYtRL3ai26vhK0ppag=;
        b=zMhzvQtic5b+brFX2sKBfEtRNqMRDw1OeV4DdmP2it0LHjFFa2UYfsCU185r0AsEJo
         66H4wa5kC2Vh8ZbtrfAJv5/DpWJscgoK8ohLt/akaOVlHnJGM+uQ6jL9FiM/wU+LEQkI
         +AIdk7quekC9P++lzprrTFOcq45tvaTku3XrCqfkzLvVvAjbEST0by+pzp8ZiT/B3YsN
         bfbB9b+5Yxsd1rltmY7SAbdm6xc8MFlatibNp0hqkxQ7KPtbtq1LIEBi1VaAW7oJN1GX
         DTu7KVzuV/gfonF1g85qKx054C64V2FAptXOMJObSDtovRTY1+17NxnannhWZuNz4mR6
         gAyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6329205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Mon, 26 Feb 2018 14:23:21 -0600
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
	Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v11 2/7] PCI/AER: factor out error reporting from AER
Message-ID: <20180226202321.GA63171@bhelgaas-glaptop.roam.corp.google.com>
References: <1519374244-20539-1-git-send-email-poza@codeaurora.org>
 <1519374244-20539-3-git-send-email-poza@codeaurora.org>
 <20180223234232.GP14632@bhelgaas-glaptop.roam.corp.google.com>
 <3e536e31983d0bed397e10bb542f2a72@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e536e31983d0bed397e10bb542f2a72@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593086410511514158?=
X-GMAIL-MSGID: =?utf-8?q?1593496413221755231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 11:02:50AM +0530, poza@codeaurora.org wrote:
> On 2018-02-24 05:12, Bjorn Helgaas wrote:
> > On Fri, Feb 23, 2018 at 01:53:59PM +0530, Oza Pawandeep wrote:

> > >   * handle_error_source - handle logging error into an event log
> > > diff --git a/drivers/pci/pcie/pcie-err.c b/drivers/pci/pcie/pcie-err.c
> > > new file mode 100644
> > > index 0000000..fcd5add
> > > --- /dev/null
> > > +++ b/drivers/pci/pcie/pcie-err.c
> > > @@ -0,0 +1,334 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * This file implements the error recovery as a core part of PCIe
> > > error reporting.
> > > + * When a PCIe error is delivered, an error message will be
> > > collected and printed
> > > + * to console, then, an error recovery procedure will be executed
> > > by following
> > > + * the PCI error recovery rules.
> > 
> > Wrap this so it fits in 80 columns.
> 
> I thought of keeping the way it was before (hence did not change it)
> I would change it now.

The original text fit in 80 columns, but you changed the text a little
bit as part of making this code more generic, which made it not fit
anymore.  Ideally I would leave the text the same in this patch that
only moves code, then update the text (and rewrap it) in the patch
that makes the code more generic.

> > > +static pci_ers_result_t reset_link(struct pci_dev *dev)
> > > +{
> > > +	struct pci_dev *udev;
> > > +	pci_ers_result_t status;
> > > +	struct pcie_port_service_driver *driver = NULL;
> > > +
> > > +	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > > +		/* Reset this port for all subordinates */
> > > +		udev = dev;
> > > +	} else {
> > > +		/* Reset the upstream component (likely downstream port) */
> > > +		udev = dev->bus->self;
> > > +	}
> > > +
> > > +#if IS_ENABLED(CONFIG_PCIEAER)
> > 
> > AER can't be a module, so you can use just:
> > 
> >   #ifdef CONFIG_PCIEAER
> > 
> > This ifdef should be added in the patch where you add a caller from
> > non-AER
> > code.  This patch should only move code, not change it.
> 
> ok, it can remain unchanged. but reset_link() is called by
> pcie_do_recovery()
> and pcie_do_recovery can be called by various agents such as AER, DPC.
> so let us say if DPC calls pcie_do_recovery, then DPC has no way of knowing
> that AER is enabled or not.
> in fact it should not know, but err.c/reset_link() should take care somehow.

If all you're doing is moving code, the functionality isn't changing
and you shouldn't need to add the ifdef.  At the point where you add a
new caller and the #ifdef becomes necessary, you can add it there.
Then it will make sense because we can connect the ifdef with the need
for it.

> I can make it a separate patch to do #ifdef CONFIG_PCIEAER inside
> reset_link()
> or
> I can add severity parameter in reset_link() so based on severity it can
> find the service.
> 
> but I think you have comment to unify the find_aer_service and
> find_dpc_service into a pcie_find_service (routine)
> so I will see how I can club and take care of this comment. [without the
> need of #ifdef]
