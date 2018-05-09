Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZr8gx7zYOgvZZjROYPgYksjqP/8jZqA+2a9KDuPphqCkmsjuAI2h1lHJLhTGuHGS4D9wZIQ
ARC-Seal: i=1; a=rsa-sha256; t=1525908075; cv=none;
        d=google.com; s=arc-20160816;
        b=cl1qAJp0DtebbbHw4rSFIT4qNQ6lc0AtM595nxGbqAs9Hz+atXZvdEaTYeP5FzqyuG
         ZypPeDcGh8rIat79mTD+P0oJFtyig08twDfvXlXN7Y4jKCderQDI17rZtt0JHtbz4HGZ
         S0UKENzYUCQ6gc1H6JiqrrZ1l8JHpU6odSWANtl5JRXIjCs7mEOkytQbY3Qvpssi7mSy
         4JvT/PlboVA5dFh46smt6AdrJHo7oAkBiyO1XhitoYH77/CyUmn0zpZ5y8MU2ZZXxCJb
         s4lhyVDtoVI09DQ8wmqtZskpw28etAtwhW6yMXqdFUiEANx7xcAtBFHmiwkbnkfaPQGx
         MJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=o1IsiioJqwoiD0avnfH0xt5oy10sY3Qmdq/dC+POaNU=;
        b=i6YAPxGeHVSNiiWwA6WSaphHPyAE8a2Ny95Xa40ZeRWwVLECh8FOdT70QM3UhHa2pB
         UVXbfgn2B53GVsLl6xt2V+lny8U9ZQSpKSzKa6HtbCU3yWc0FWZ3AwtlTo1NkhUUu2o2
         lW9H0KmbJw6A6YHSBilTUB8GgCF0uBJCLedsS8srutq4VGeul4axwwSLjT+eOUl5gdyg
         Od0j8Cv8/YKblX0+2SqLBdfmD0aqNtU8Xi5U3vwWSFUn+yNlMIqgcqYpWUSokIGe4ICf
         66/5p5tfecWMjsiyZvzCdc0aBweDWBX1l/uPfiA6qCQG6frGR/vzNqP3j1JBrUd403JX
         tCdw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IXcSF79I;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=IXcSF79I;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 18:21:11 -0500
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
Subject: Re: [PATCH v15 3/9] PCI/AER: Handle ERR_FATAL with removal and
 re-enumeration of devices
Message-ID: <20180509232111.GA43216@bhelgaas-glaptop.roam.corp.google.com>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
 <1525323838-1735-4-git-send-email-poza@codeaurora.org>
 <20180508235330.GN161390@bhelgaas-glaptop.roam.corp.google.com>
 <20180509130730.GA236548@bhelgaas-glaptop.roam.corp.google.com>
 <b1f9aaf43300ef7a829001e964bf4e72@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f9aaf43300ef7a829001e964bf4e72@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417977501212020?=
X-GMAIL-MSGID: =?utf-8?q?1600030585972738361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 06:44:53PM +0530, poza@codeaurora.org wrote:
> On 2018-05-09 18:37, Bjorn Helgaas wrote:
> > On Tue, May 08, 2018 at 06:53:30PM -0500, Bjorn Helgaas wrote:
> > > On Thu, May 03, 2018 at 01:03:52AM -0400, Oza Pawandeep wrote:
> > > > This patch alters the behavior of handling of ERR_FATAL, where removal
> > > > of devices is initiated, followed by reset link, followed by
> > > > re-enumeration.
> > > >
> > > > So the errors are handled in a different way as follows:
> > > > ERR_NONFATAL => call driver recovery entry points
> > > > ERR_FATAL    => remove and re-enumerate
> > > >
> > > > please refer to Documentation/PCI/pci-error-recovery.txt for more details.
> > > >
> > > > Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
> > > >
> > > > diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
> > > > index 779b387..206f590 100644
> > > > --- a/drivers/pci/pcie/aer/aerdrv.c
> > > > +++ b/drivers/pci/pcie/aer/aerdrv.c
> > > > @@ -330,6 +330,13 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
> > > >         reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
> > > >         pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
> > > >
> > > > +       /*
> > > > +        * This function is called only on ERR_FATAL now, and since
> > > > +        * the pci_report_resume is called only in ERR_NONFATAL case,
> > > > +        * the clearing part has to be taken care here.
> > > > +        */
> > > > +       aer_error_resume(dev);
> > > 
> > > I don't understand this part.  Previously the ERR_FATAL path looked
> > > like
> > > this:
> > > 
> > >   do_recovery
> > >     reset_link
> > >       driver->reset_link
> > >         aer_root_reset
> > >           pci_reset_bridge_secondary_bus                # <-- reset
> > >     broadcast_error_message(..., report_resume)
> > >       pci_walk_bus(..., report_resume, ...)
> > >         report_resume
> > >       if (cb == report_resume)
> > >         pci_cleanup_aer_uncorrect_error_status
> > >           pci_write_config_dword(PCI_ERR_UNCOR_STATUS)  # <-- clear
> > > status
> > > 
> > > After this patch, it will look like this:
> > > 
> > >   do_recovery
> > >     do_fatal_recovery
> > >       pci_cleanup_aer_uncorrect_error_status
> > >         pci_write_config_dword(PCI_ERR_UNCOR_STATUS)    # <-- clear
> > > status
> > >       reset_link
> > >         driver->reset_link
> > >           aer_root_reset
> > >             pci_reset_bridge_secondary_bus              # <-- reset
> > >             aer_error_resume
> > >               pcie_capability_write_word(PCI_EXP_DEVSTA)        #
> > > <-- clear more
> > >               pci_write_config_dword(PCI_ERR_UNCOR_STATUS)      #
> > > <-- clear status
> > > 
> > > So if I'm understanding correctly, the new path clears the status too
> > > early, then clears it again (plus clearing DEVSTA, which we didn't do
> > > before) later.
> > > 
> > > I would think we would want to leave aer_root_reset() alone, and
> > > just move
> > > the pci_cleanup_aer_uncorrect_error_status() in do_fatal_recovery()
> > > down so
> > > it happens after we call reset_link().  That way the reset/clear
> > > sequence
> > > would be the same as it was before.
> > 
> > I've been fiddling with this a bit myself and will post the results to
> > see
> > what you think.
> 
> 
> ok so you are suggesting to move pci_cleanup_aer_uncorrect_error_status down
> which I can do.
> 
> And not to call aer_error_resume, because you think its clearing the status
> again.
> 
> following code: calls aer_error_resume.
> pci_broadcast_error_message()
>  /*
>                  * If the error is reported by an end point, we think this
>                  * error is related to the upstream link of the end point.
>                  */
>                 if (state == pci_channel_io_normal)
>                         /*
>                          * the error is non fatal so the bus is ok, just
> invoke
>                          * the callback for the function that logged the
> error.
>                          */
>                         cb(dev, &result_data);
>                 else
>                         pci_walk_bus(dev->bus, cb, &result_data);

Holy crap, I thought this could not possibly get any more complicated,
but you're right; we do actually call aer_error_resume() today via an
extremely convoluted path:

  do_recovery(pci_dev)
    broadcast_error_message(..., error_detected, ...)
    if (AER_FATAL)
      reset_link(pci_dev)
        udev = BRIDGE ? pci_dev : pci_dev->bus->self
        driver->reset_link(udev)
          aer_root_reset(udev)
    if (CAN_RECOVER)
      broadcast_error_message(..., mmio_enabled, ...)
    if (NEED_RESET)
      broadcast_error_message(..., slot_reset, ...)
    broadcast_error_message(dev, ..., report_resume, ...)
      if (BRIDGE)
        report_resume
          driver->resume
            pcie_portdrv_err_resume
              device_for_each_child(..., resume_iter)
                resume_iter
                  driver->error_resume
                    aer_error_resume
        pci_cleanup_aer_uncorrect_error_status(pci_dev)       # only if BRIDGE
          pci_write_config_dword(PCI_ERR_UNCOR_STATUS)

aerdriver is the only port service driver that implements
.error_resume(), and aerdriver only binds to root ports.  I can't
really believe all these device_for_each_child()/resume_iter()
gyrations are necessary when this is AER code calling AER code.

Bjorn
