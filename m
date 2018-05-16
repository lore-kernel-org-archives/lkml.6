Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZpdTqt00XYLAiWKfKFsO99P+gOqZh5R3HceUWTOJLN/c2Wkd6oHSJ2s008ftl87kekrn8bU
ARC-Seal: i=1; a=rsa-sha256; t=1526500987; cv=none;
        d=google.com; s=arc-20160816;
        b=oQJRIahfO0XAn92HEh5Zq9uT8j7SZbtxvvhahItGb1RbNjC+Ud66Tgi3jDBX62z8Os
         WO339wLcA34X0ddE3gkaQs/IRUeInDDZPMk48Py3GMnxsO2kIedgGA5DX72Z5+5gvSH5
         2ABg085qnz17t7YHeDVAhsKNsEPv/E/wllcbPbt0x9RV/5HZHaXZO86v/jBs9eB7Och4
         eyGLkYzrDBjlKd0Drs1BA7MeIs0Emc9dKbgPXDOg9cYDf8QCcfXXBZFaJ3YGwWlsfvQp
         O+hM0lgn9tnz3YWjOw6ZPPgojDVSlQRdF8bOf/dKaIQSnDfFHdVZy6PyvT7vu9nidUt6
         Rq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=+QnspkJcp8mrLAf6/SZHRlYY04tWN5qjbvMXKnoky9A=;
        b=y0AHGzERfWMRw9NuoT5qOAeg5Rb6wgeRubTIAONa69taGeijkdWTmF7nE2nQSBqVCW
         6+KKApA3hCevc0ouuOWQsp9qLkm24km6WfLMDy/pj/pr/QllqYap4K1GDXK/FsPflhNk
         He49rHmHfASmyqqOrlGCn/7Pj5lgWJBvNpas1B4jB90EdGU9rR/pmUVYfWZCSaJ5DfL9
         ND2wf1FJLqnTqU8cSNn0ixeBQdM/iTUIEqa9qGSsxD3473bLiv2Izg7NGtgWjBFBGEfM
         r2MZ3B9rvbHK2x8M4WUxd81uoztbIoc5G9WQW9FuC+rOulgc1rjorCN0Sj781DvpVpIl
         oYRg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=koK5Pf2O;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=koK5Pf2O;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 16 May 2018 15:02:56 -0500
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
Subject: Re: [PATCH v16 8/9] PCI/DPC: Unify and plumb error handling into DPC
Message-ID: <20180516200256.GB236884@bhelgaas-glaptop.roam.corp.google.com>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
 <1526035408-31328-9-git-send-email-poza@codeaurora.org>
 <a497fae20a326bdf67395c907a5b6b0d@codeaurora.org>
 <20180515235632.GB11156@bhelgaas-glaptop.roam.corp.google.com>
 <2ca65f6b38668cfcf553833409ee38e3@codeaurora.org>
 <20180516105236.GA217390@bhelgaas-glaptop.roam.corp.google.com>
 <3822b5ea0b05f9836b991ce18f16a30f@codeaurora.org>
 <20180516130455.GA233993@bhelgaas-glaptop.roam.corp.google.com>
 <33496e8d8c663240c9db51b98ef6dd52@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33496e8d8c663240c9db51b98ef6dd52@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164111312988494?=
X-GMAIL-MSGID: =?utf-8?q?1600652299185825998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 08:28:39PM +0530, poza@codeaurora.org wrote:
> On 2018-05-16 18:34, Bjorn Helgaas wrote:
> > On Wed, May 16, 2018 at 05:45:58PM +0530, poza@codeaurora.org wrote:
> > > On 2018-05-16 16:22, Bjorn Helgaas wrote:
> > > > On Wed, May 16, 2018 at 01:46:25PM +0530, poza@codeaurora.org wrote:

> > > > > I am sorry I pasted the wrong snippet.
> > > > > following needs to be fixed in v17.
> > > > > from:
> > > > >    if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > > > >                 /*
> > > > >                  * If the error is reported by a bridge, we think
> > > > > this error
> > > > >                  * is related to the downstream link of the bridge,
> > > > > so we
> > > > >                  * do error recovery on all subordinates of the bridge
> > > > > instead
> > > > >                  * of the bridge and clear the error status of the
> > > > > bridge.
> > > > >                  */
> > > > >                 pci_walk_bus(dev->subordinate, report_resume,
> > > > > &result_data);
> > > > >                 pci_cleanup_aer_uncorrect_error_status(dev);
> > > > >         }
> > > > >
> > > > >
> > > > > to
> > > > >
> > > > >    if (service==AER  && dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> > > > >                 /*
> > > > >                  * If the error is reported by a bridge, we think
> > > > > this error
> > > > >                  * is related to the downstream link of the bridge,
> > > > > so we
> > > > >                  * do error recovery on all subordinates of the bridge
> > > > > instead
> > > > >                  * of the bridge and clear the error status of the
> > > > > bridge.
> > > > >                  */
> > > > >                 pci_walk_bus(dev->subordinate, report_resume,
> > > > > &result_data);
> > > > >                 pci_cleanup_aer_uncorrect_error_status(dev);
> > > > >         }
> > > > >
> > > > > this is only needed in case of AER.
> > > >
> > > > Oh, I missed this before.  It makes sense to clear the AER status
> > > > here, but why do we need to call report_resume()?  We just called all
> > > > the driver .remove() methods and detached the drivers from the
> > > > devices.  So I don't think report_resume() will do anything
> > > > ("dev->driver" should be NULL) except set the dev->error_state to
> > > > pci_channel_io_normal.  We probably don't need that because we didn't
> > > > change error_state in this fatal error path.
> > > 
> > > if you remember, the path ends up calling
> > > aer_error_resume
> > > 
> > > the existing code ends up calling aer_error_resume as follows.
> > > 
> > > do_recovery(pci_dev)
> > >     broadcast_error_message(..., error_detected, ...)
> > >     if (AER_FATAL)
> > >       reset_link(pci_dev)
> > >         udev = BRIDGE ? pci_dev : pci_dev->bus->self
> > >         driver->reset_link(udev)
> > >           aer_root_reset(udev)
> > >     if (CAN_RECOVER)
> > >       broadcast_error_message(..., mmio_enabled, ...)
> > >     if (NEED_RESET)
> > >       broadcast_error_message(..., slot_reset, ...)
> > >     broadcast_error_message(dev, ..., report_resume, ...)
> > >       if (BRIDGE)
> > >         report_resume
> > >           driver->resume
> > >             pcie_portdrv_err_resume
> > >               device_for_each_child(..., resume_iter)
> > >                 resume_iter
> > >                   driver->error_resume
> > >                     aer_error_resume
> > >         pci_cleanup_aer_uncorrect_error_status(pci_dev)       # only
> > > if
> > > BRIDGE
> > >           pci_write_config_dword(PCI_ERR_UNCOR_STATUS)
> > > 
> > > hence I think we have to call it in order to clear the root port
> > > PCI_ERR_UNCOR_STATUS and PCI_EXP_DEVSTA.
> > > makes sense ?
> > 
> > I know I sent you the call graph above, so you would think I might
> > understand it, but you would be mistaken :)  This still doesn't make
> > sense to me.
> > 
> > I think your point is that we need to call aer_error_resume().  That
> > is the aerdriver.error_resume() method.  The AER driver only binds to
> > root ports.
> > 
> > This path:
> > 
> >   pcie_do_fatal_recovery
> >     pci_walk_bus(dev->subordinate, report_resume, &result_data)
> > 
> > calls report_resume() for every device on the dev->subordinate bus
> > (and for anything below those devices).  There are no root ports on
> > that dev->subordinate bus, because root ports are always on a root
> > bus, never on a subordinate bus.
> > 
> > So I don't see how report_resume() can ever get to aer_error_resume().
> > Can you instrument that path and verify that it actually does get
> > there somehow?
> 
> you are right....the call
> pci_walk_bus(dev->subordinate, report_resume, &result_data);
> does not call aer_error_resume()
> 
> but
> pci_walk_bus(udev->bus, report_resume, &result_data);
> does call aer_error_resume()
> 
> now if you look at the comment of the function:
> /**
>  * aer_error_resume - clean up corresponding error status bits
>  * @dev: pointer to Root Port's pci_dev data structure
>  *
>  * Invoked by Port Bus driver during nonfatal recovery.
>  */
> 
> it is invoked during nonfatal recovery.
> but the code handles both fatal and nonfatal clearing of error bits.
> 
> if (dev->error_state == pci_channel_io_normal)
> 		status &= ~mask; /* Clear corresponding nonfatal bits */
> 	else
> 		status &= mask; /* Clear corresponding fatal bits */
> 	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
> 
> 
> so the question is, should we not call aer_error_resume during fatal
> recovery ?
> so that it clears the root port status, if of course the error is triggered
> by AER running agent (RP, Switch)

I'm sure we *should* clear AER status bits somewhere during ERR_FATAL
recovery.

As far as I can tell, the current code (before your patches) never
calls aer_error_resume().  That might be a bug, but even if it is,
it's something that should be fixed separately from *this* series.

I think in this series, you should probably adjust the patch that adds
do_fatal_recovery() so it doesn't call pci_walk_bus(..., report_resume).

I don't think that does anything useful anyway, and that patch already
changes AER so it doesn't call the pci_error_handlers callbacks
(except .resume()).  I think it would be cleaner to remove the
ERR_FATAL use of .resume() at the same time you remove the others.
