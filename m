Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AIpwx49GDnO+r2WJc9QT5IWtZeBXk4xu3fkdW20xxC8LfrwzB4FktpZkhbjm/fN/tWanVt6XTJTT
ARC-Seal: i=1; a=rsa-sha256; t=1523542013; cv=none;
        d=google.com; s=arc-20160816;
        b=CS0owA6BArjU54qLb9cGVWI+XLvwe2JrMHJY+JColDH8CwW41+5o8VfLNEzG8kdAjD
         5Y8RDdnL06LKOttW1gdIIinACPbjT8avjwHALxIQ1cZskQLEegT52+Q8CMEKfaUJw76k
         lQVoKsf9CvVbns+bT8POFzT5mBfMtTZVn+oRLOfx7SmoQ7Quf7TFHnL6Cemgp3q/isoT
         1d+JHUVUm5Rjy4M1t5Nrhs13CvyNyFBMYOunhCrcQOZsQBvbeF8mtGOYxZNW66MS5Vhg
         5Vqwy34S26tX8L5hXilSH9l04RUnU4mXxQ2Fh4jYJdi7n/U50FTH06fSBjnyTYAGLgOU
         D5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=eRS+4KeJ5Nn0ot+T+MWeDcQQ+UUwuSiBjoIxCZUUahc=;
        b=CXnqna4aMZSE7ZvQWmr6wQxKDDyxMz05jCPvowAEKhFySxX58xWhD8s6EGGjZYMRs6
         bvrLucvAG+gJBRBVMO47/IPKIdzNqusCFqjxl8twS/p3L49UPksPv1PF8lPDkMJt3llK
         jwrB1G1ynBtWPJ2rhfmYyBX7nYx55NZzRbIK2q2RA1o21pAHBV+dHqU17NzAyyeQUhLH
         VHoyClygjCE1Q4bsKBb5k9QHCiT03iseIaN9X9iA8iWZxqQZ5K9ssnR90vSwOGByU/Tj
         PTNqvautdQE/jv1a65qPzpAY0emHi1M5NaZTgVeBciRdlCktkg1aU2T41mlnMYKfMQBl
         6pfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983BF2178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Thu, 12 Apr 2018 09:06:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
	Timur Tabi <timur@codeaurora.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
Message-ID: <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597549590469898888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[+cc Alex because of his interest in device reset]

For context, here's the part of the patch we're discussing:

> >>  static void dpc_work(struct work_struct *work)
> >>  {
> >>         struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
> >>         struct pci_dev *pdev = dpc->dev->port;
> >> 
> >>         /* From DPC point of view error is always FATAL. */
> >> -       pcie_do_recovery(pdev, DPC_FATAL);
> >> +       if (!pdev->is_hotplug_bridge)
> >> +               pcie_do_recovery(pdev, DPC_FATAL);
> >> +       else
> >> +               dpc_reset_link_remove_dev(pdev);
> >>  }

This is at the point where DPC has been triggered in the hardware and
the DPC driver is starting recovery, and I'm wondering why we need to
handle the "!pdev->is_hotplug_bridge" case differently.

On Wed, Apr 11, 2018 at 09:41:56PM -0400, Sinan Kaya wrote:
> On 4/10/2018 5:03 PM, Bjorn Helgaas wrote:
> >> DPC and AER should attempt recovery in the same way, except the
> >> cases where system is with hotplug enabled.
> > What's the connection with hotplug?  I see from the patch that for
> > hotplug bridges you remove the tree below the bridge, and otherwise
> > you just reset the secondary link (I think).
> > 
> > The changelog should explain why we need the difference.
> > 
> > I'm a little skeptical to begin with, because I'm not sure why we
> > should handle a DPC event differently just because a bridge has the
> > *capability* of hotplug.  Even if a hotplug bridge reports a DPC
> > event, that doesn't necessarily mean a hotplug has occurred.
> 
> Let's do a recap on what we have discussed about this until now.
> 
> There are two conflicting error recovery mechanisms for PCIe. 
> 
> If a system supports both hotplug and DPC, endpoint can be removed
> and inserted safely.  DPC driver shuts down the driver on link down.
> When link comes back up, hotplug driver takes over and initiates an
> enumeration process.  Keith mentioned the stop and re-enumerate
> design was chosen because someone could remove a drive and insert an
> unrelated drive back to the system.  We can't really save and
> restore state as we do in the AER path. 
> 
> Now, let's assume a system without hotplug capability.  Second
> mechanism is to go through DPC/AER path and do an automatic link
> down recovery via DPC retrain/secondary bus reset including register
> save and restore.  Second mechanism is more suitable for handling
> "surprise link down" event. The goal is to retrain the link and
> continue driver operation. 
> 
> The goal of this patch to separate these two cases from each other
> as the DPC driver needs to work on both contexts. Current DPC code
> doesn't handle the second use case.

I think the scenario you are describing is two systems that are
identical except that in the first, the endpoint is below a hotplug
bridge, while in the second, it's below a non-hotplug bridge.  There's
no physical hotplug (no drive removed or inserted), and DPC is
triggered in both systems.

I suggest that DPC should be handled identically in both systems:

  - The PCI core should have the same view of the endpoint: it should
    be removed and re-added in both cases (or in neither case).

  - The endpoint itself should not be able to tell the difference: it
    should see a link down event, followed by a link retrain, followed
    by the same sequence of config accesses, etc.

  - The endpoint driver should not be able to tell the difference,
    i.e., we should be calling the same pci_error_handlers callbacks
    in both cases.

It's true that in the non-hotplug system, pciehp probably won't start
re-enumeration, so we might need an alternate path to trigger that.

But that's not what we're doing in this patch.  In this patch we're
adding a much bigger difference: for hotplug bridges, we stop and
remove the hierarchy below the bridge; for non-hotplug bridges, we do
the AER-style flow of calling pci_error_handlers callbacks.

Bjorn
