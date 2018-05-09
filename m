Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZqduq0htFrUiae9RchUuZVZWMQLSgxQEqwuMcDboIEZHolYPptuRf7G51FJ/8E2adiVfCrj
ARC-Seal: i=1; a=rsa-sha256; t=1525871252; cv=none;
        d=google.com; s=arc-20160816;
        b=Cm7LweBeV1qAzbHTNFw+XbugHhw05ZgiGKCTr5lZYNbho74A/I2XW8SUMprFH4kR95
         C6fbPs6FustfC7iLb7ozXDEAIvQ3mbE9K1IonMZ1W5qZpTXpkrHhnzkPoRkH+ZhUXqYs
         QvELLEl/XUCsHyHiVLdBKqtD4ml37YXaRfZD/ID/JkUdlNHxG1D5hsYtwy9IZ5FCI8Fg
         Max62xfd4+WUVg2dUTd4mxiZTr0k78h/6SUiEii78/QGt2AaKI3gmBd1Pn/GFQJN5oq0
         lHnNI+0wqSeJXFuU9R0LVpHrhFogRN531r6M6jx9/SbtYxUfoR5p7d4zLrjnfkXi3Ony
         2toQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=jKTGe8/nGfj+sTYEIoWYcLO0iSzb5sLo3N+nEMcauSc=;
        b=YOK28wd3AU5AKrqZ7bUVoH6viVkEBhoC6AHqAjStDmA16JV4nYkOOMC3/UW3nr7n7K
         MVM/AotfX9x6KoUMJbuwlG+w2azil7S8VhiQVOBr1tJ0/r+lJ9VQHfE2CKlXXevXDYxX
         YAnaIXEklYSq4hlVo0R+HqO9KTkEWNgWRW4LV4mbGD1l+GZUzg+ARO6fDiJdrAIybVjw
         irOGfIbs5nBDcJKnut1g6fiZwFNsM8p8QYIqliefdAajKSw+sbgxBjRCXSwj7/4SFsOZ
         rO/n+/v0mh87K+FgzgbgRTAYDCMwROdXhtOB0wNIPLhIAsPLP9Srfg3zYMEnr6rxDoH6
         zIEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2u9fSaCQ;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2u9fSaCQ;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 08:07:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <poza@codeaurora.org>
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
Subject: Re: [PATCH v15 3/9] PCI/AER: Handle ERR_FATAL with removal and
 re-enumeration of devices
Message-ID: <20180509130730.GA236548@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-4-git-send-email-poza@codeaurora.org>
 <20180508235330.GN161390@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508235330.GN161390@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417977501212020?=
X-GMAIL-MSGID: =?utf-8?q?1599991974820116579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 06:53:30PM -0500, Bjorn Helgaas wrote:
> On Thu, May 03, 2018 at 01:03:52AM -0400, Oza Pawandeep wrote:
> > This patch alters the behavior of handling of ERR_FATAL, where removal
> > of devices is initiated, followed by reset link, followed by
> > re-enumeration.
> > 
> > So the errors are handled in a different way as follows:
> > ERR_NONFATAL => call driver recovery entry points
> > ERR_FATAL    => remove and re-enumerate
> > 
> > please refer to Documentation/PCI/pci-error-recovery.txt for more details.
> > 
> > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> > 
> > diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> > index 779b387..206f590 100644
> > --- a/drivers/pci/pcie/aer/aerdrv.c
> > +++ b/drivers/pci/pcie/aer/aerdrv.c
> > @@ -330,6 +330,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> >  	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> >  	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
> >  
> > +	/*
> > +	 * This function is called only on ERR_FATAL now, and since
> > +	 * the pci_report_resume is called only in ERR_NONFATAL case,
> > +	 * the clearing part has to be taken care here.
> > +	 */
> > +	aer_error_resume(dev);
> 
> I don't understand this part.  Previously the ERR_FATAL path looked like
> this:
> 
>   do_recovery
>     reset_link
>       driver->reset_link
>         aer_root_reset
>           pci_reset_bridge_secondary_bus                # <-- reset
>     broadcast_error_message(..., report_resume)
>       pci_walk_bus(..., report_resume, ...)
>         report_resume
>       if (cb == report_resume)
>         pci_cleanup_aer_uncorrect_error_status
>           pci_write_config_dword(PCI_ERR_UNCOR_STATUS)  # <-- clear status
> 
> After this patch, it will look like this:
> 
>   do_recovery
>     do_fatal_recovery
>       pci_cleanup_aer_uncorrect_error_status
>         pci_write_config_dword(PCI_ERR_UNCOR_STATUS)    # <-- clear status
>       reset_link
>         driver->reset_link
>           aer_root_reset
>             pci_reset_bridge_secondary_bus              # <-- reset
>             aer_error_resume
>               pcie_capability_write_word(PCI_EXP_DEVSTA)        # <-- clear more
>               pci_write_config_dword(PCI_ERR_UNCOR_STATUS)      # <-- clear status
> 
> So if I'm understanding correctly, the new path clears the status too
> early, then clears it again (plus clearing DEVSTA, which we didn't do
> before) later.
> 
> I would think we would want to leave aer_root_reset() alone, and just move
> the pci_cleanup_aer_uncorrect_error_status() in do_fatal_recovery() down so
> it happens after we call reset_link().  That way the reset/clear sequence
> would be the same as it was before.

I've been fiddling with this a bit myself and will post the results to see
what you think.
