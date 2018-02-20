Return-Path: <helgaas@kernel.org>
X-Google-Smtp-Source: AH8x226Qfgk4CHaywEdxLxyOpfSewtBTMfqvMVDKrfxuKzbY0u+E+54LUD0cSmu2o/mwB3I803/Y
ARC-Seal: i=1; a=rsa-sha256; t=1519150557; cv=none;
        d=google.com; s=arc-20160816;
        b=aPxPcQsLiSKmntExo8xwvkv6WWifBhdhOrvApFerFYmUCPDYWL5MecdyYbnuxYZLFV
         kn2RklOos5oQIBa3ENHD9BCJmreME3Q62L+gfGKYaV0YjVWc6cTl7PBmapeicbm1uZoM
         YMk9P22joML5tokpYT9tZJuatfn0QvhobuqcrjbwyuZroS0eHUPtgFxaWxzQ3GNekwGy
         /1dzk3WYw6qCoEyluVgZGx5j3Y9xLWT53ffF5FbOC3CpzXONrkhREeOw2kr84KrQRIEb
         /KIIhT5sl7r8cQl1uxFC0fVe5aqVjFD3X7iL10WHVjzclPhO9aF0ifFuPy9mwrSXlY9q
         pdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=PLHKU52ef00SVOG/JACoHe/huX9aP+VZq6YVmXn5Zvw=;
        b=bl8ouBQ4JAXY7yc1Awmt1C0uYMovZ8UkQsGU8bHVk1WwKrGr1hGnzMwpmupG1wBipP
         9DDsUDZ86kAgCWS5OQA8uEm9V7YBPytxOjKSlf7qpcJMU5BOg8xUfr/88Txt3NhM8GYD
         zg3ChgECxmGJ0YrVxPBYx/yK0MFto/LJjZ5978nCk7XhYvrHKHMasQZo3pgNI71tDtWH
         y1Im0rXblB+VcRQ2ZyJTdipFkHjaH2jW024xpO/dbFRdUOGWL5+lgvRLfMwAYdvlASNz
         UHtXgSFtae1DkEVPCxkrlzcLIFocokR2z8zJUfupJNAEb0eavUlGsE6NW10n1QV46EIS
         nxqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of helgaas@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=helgaas@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CCC20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Tue, 20 Feb 2018 12:15:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Peter Wu <peter@lekensteyn.nl>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
Message-ID: <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872976935903628?=
X-GMAIL-MSGID: =?utf-8?q?1592944814747876827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:41:33AM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 20, 2018 at 12:14 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Previously "pcie_port_pm=force" enabled power management of PCI bridges,
> > but only for PCIe ports (not conventional PCI bridges) and only for ports
> > that do not support hotplug.  Those limitations are there because we're not
> > confident that all those configurations work, not because the spec requires
> > them.
> >
> > Change "pcie_port_pm=force" to enable power management of conventional PCI
> > bridges and hotplug bridges as well as PCIe ports.  As with the previous
> > PCIe port-only behavior, this is not expected to work in all systems.
> >
> > Add a "pci=bridge_pm" parameter to reflect the increased scope.  For
> > backward compatibility, retain "pcie_port_pm=force" as an undocumented
> > equivalent.
> >
> > Add "pci=no_bridge_pm" as an equivalent to "pcie_port_pm=off".  This
> > disables power management for all PCI bridges, which is results in the same
> > behavior as before, since we always disabled power management of
> > conventional PCI bridges, and "pcie_port_pm=off" disabled it for PCIe
> > ports.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Honestly, I wouldn't do that, at least not this way.
> 
> Somebody might be using pcie_port_pm=force already, for example, and
> it works for them for PCIe, but the PCI-to-PCI part of the same system
> may not.

Yes, you and Valdis are right, this is over-aggressive and I'll drop
it.

> IMO the behavior of pcie_port_pm= should be as is and I don't see
> what's wrong with it being documented.
>
> Of course, you can add pci=bridge_pm/no_bridge_pm to extend the scope,
> but for what reason really?  Just to follow the letter of the spec?

Basically I was hoping to partially rectify what I think was a mistake
on my part when we merged this.  9d26d3a8f1b0 ("PCI: Put PCIe ports
into D3 during suspend") is somewhat misleading because it suggests
that PCI bridge power management can only be supported on non-hotplug
PCIe ports, when in fact this was mostly a question of testing and "we
know this works on the systems we care about so we're going to
minimize our risk by excluding others".  These constraints seem pretty
Intel-centric and it's not clear how or whether they apply to other
architectures.

Adding the comments will help with that some, but in general I don't
like to artificially limit feature support because it reduces testing
exposure and makes future maintenance more difficult.

For example, we disallow D3 for hotplug bridges.  I don't think the
spec requires that, so the fact that we put that limitation in
suggests that there was some issue we didn't fully understand, and now
it will be hard to go back and figure that out if and when we *do*
want to support D3 for hotplug bridges.

Anyway, I'll drop this one and just go with adding the comments.

Bjorn
