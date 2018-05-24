Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AB8JxZqPDnOgnRt9ik2oWC1//RLQUPMu/Y8U9y90R8/vqnXkZzEbxOdJEQAavqMyR63y3YN+6pcF
ARC-Seal: i=1; a=rsa-sha256; t=1527167249; cv=none;
        d=google.com; s=arc-20160816;
        b=kQaYMBN0kBGasERPNIVjSdRW7uX4B22ZjotJRyF00xG9l8MZWK+aBW4lgksJyXyQGe
         TzTJs6CaXirEl75uKjj2Vrva6kdF9rrMwjtxoUwgVsJ6mQZAawlbuNvPV04hs9MB/fmP
         DND2xG3JBFcQwsONhy8HyJr82hG9TOzxSVeHsaGk2+gkGgIniJvCM/Rr73+zw7rbNZHQ
         x3IrstC2v2hohbUCdMufA2afEHyTq6BrTvJCDbszWY/h6naKXpPd3aEbK4Ai9Rsw5xhU
         BpsEgkyO4jAGAih4FQbkfoqOnfQ0zpFxt6VrDLmipG7lRBIjl39RfjFvKw7HdEKPqght
         6EMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ovHdnV3NtaR5CprTp41AvD527DJi+Nt9JIyUD5r27ts=;
        b=NuR57WyO+VFKvlMu2ZCrKKbE774KELNjwBkFuO907cEpENRHuML8kVWPuPnbqVr5/x
         z81BwIS2zxsuccf5/BKH9pJs3ma335A9VG/KyvBUP+rcu+Gv8S1nwAKZLPkD3wTK5SyY
         N5SRHlxjHQr48Kg5nuR6p4kHqI4JwwD9kCyu+hCDhrZco2nT1j5JdQz21izdOxHsJy13
         4tsseM7uFa3g5fhi2xVNUMc8+C8mv+75wp1ijWBxPdHEpcBlv+lO5bj7YCy5yc9mVU5Y
         dPJiOR4l5TNx718Yop1k71vyX7LlVu9uv19uGmeo1uJgWgrHZivGEzyUzbMTpvlyrZuq
         OOgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OPx33pY/;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OPx33pY/;
       spf=pass (google.com: domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 24 May 2018 08:07:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Frederick Lawler <fred@fredlawl.com>,
	Dongdong Liu <liudongdong3@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Don Brace <don.brace@microsemi.com>, esc.storagedev@microsemi.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
Message-ID: <20180524130727.GA85822@bhelgaas-glaptop.roam.corp.google.com>
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
 <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
 <82656e20-e821-1944-3399-1667ceb27719@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82656e20-e821-1944-3399-1667ceb27719@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601221164637868413?=
X-GMAIL-MSGID: =?utf-8?q?1601350925274380040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 07:43:05AM -0400, Sinan Kaya wrote:
> On 5/23/2018 6:57 PM, Sinan Kaya wrote:
> >> The crash seems to indicate that the hpsa device attempted a DMA after
> >> we cleared the Root Port's PCI_COMMAND_MASTER, which means
> >> hpsa_shutdown() didn't stop DMA from the device (it looks like *most*
> >> shutdown methods don't disable device DMA, so it's in good company).
> > All drivers are expected to shutdown DMA and interrupts in their shutdown()
> > routines. They can skip removing threads, data structures etc. but DMA and
> > interrupt disabling are required. This is the difference between shutdown()
> > and remove() callbacks.
> 
> I found this note yesterday to see why we are not disabling the
> devices in the PCI core itself. 
> 
> pci_device_remove()
> 
> 	/*
> 	 * We would love to complain here if pci_dev->is_enabled is set, that
> 	 * the driver should have called pci_disable_device(), but the
> 	 * unfortunate fact is there are too many odd BIOS and bridge setups
> 	 * that don't like drivers doing that all of the time.
> 	 * Oh well, we can dream of sane hardware when we sleep, no matter how
> 	 * horrible the crap we have to deal with is when we are awake...
> 	 */ 
> 
> Ryan, can you discard the previous patch and test this one instead?
> remove() path in hpsa driver seems to call pci_disable_device() via 
> 
> hpsa_remove_one()
> 	hpsa_free_pci_init()
> 
> but nothing on the shutdown path.
> 
> diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
> index 4ed3d26..3823f04 100644
> --- a/drivers/scsi/hpsa.c
> +++ b/drivers/scsi/hpsa.c
> @@ -8651,6 +8651,7 @@ static void hpsa_shutdown(struct pci_dev *pdev)
>         h->access.set_intr_mask(h, HPSA_INTR_OFF);
>         hpsa_free_irqs(h);                      /* init_one 4 */
>         hpsa_disable_interrupt_mode(h);         /* pci_init 2 */
> +       pci_disable_device(h->pdev);
>  }

I suspect this will make things "work" (if the device can't attempt
DMA, no Unsupported Request error will occur).

But I'm concerned that the reason for the DMA might that hpsa is
transferring buffers from system memory to the hpsa device, and if we
arbitrarily terminate those transfers with pci_disable_device(), we
may leave the hpsa device in an inconsistent state, e.g., with a dirty
filesystem.

But we really need guidance from an hpsa expert.  I don't know the
filesystem/SCSI/hpsa details.

Bjorn
