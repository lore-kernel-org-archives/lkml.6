Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AH8x227zN3PUHhn0eftxemLPysP8Mc6qzh/RzljumAz1RsJm785xLW3IEAkSyITa57Xf9cJckUKg
ARC-Seal: i=1; a=rsa-sha256; t=1519647764; cv=none;
        d=google.com; s=arc-20160816;
        b=Rr22Z82cs18wNjNLCR+83wke7iWsUoV8sfjRzPyJtIRxA+vyFUKZH4iiFBynGdl0aJ
         KWEZOhlpFwUkbH4M7EwauHvoTCX4SBApmDkDE35bX1nVIkYOhijhdi9CYQDCirsUBMuC
         mdnzwtXlOBUjaWJk5ZofmElrs9pYOW89Q41L9mp1QgcgJ7WyG1yNkJ70V4v6irhXgx1Z
         KpjWczOalRUq1Z9oC/Q5+oEZJbCyJ189iMpH9nv9nPe213h1+OYcdfNvXJ7STaDOgy2l
         nHvHM/FyXOfDOuWhnPHBCmokYgqL0bF0+faTjCG7Hzwsolu4x6g6wQrmKE9Z2PEytrwM
         OUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DVD3O8a9eBXaeIhaVmF1lKj4sF6T3tzjlbSXzPD+TcI=;
        b=K2L3Q+6cxJs+9DKe4tf1+bYWxPnkdvbc3QdZxLq50thSnc/kut2usuF8me7uwVcYcV
         TP+sM8dmqZxCHSDfGagTzW+rqsfhEB5r0b/EA3+h2new/l0oLnQ0tEmEu1y/Ux55G8vb
         NOhn92ia5ATBwenZzV38POMrZhLzd2G41I2r+1+Tat/a9TfmcSobsdgETI/St4OiTnG6
         ml5CjHi2D42QIWjrSurDNKQBDIdpeJAGCFlHqdHGOW7vFuERPL8kfeNSYlNo9lFRmJnf
         8T4WD5FM+i9kmJaenD1BnjsP1QdAvuDoz52QngZ12FLWqU5GK9FJgciSww1dg3jxLJB6
         i+og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Mon, 26 Feb 2018 13:22:43 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
Message-ID: <20180226122243.GA25450@wunner.de>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
 <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
 <20180222131834.GA5527@wunner.de>
 <20180226120534.GO27191@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226120534.GO27191@lahna.fi.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872976935903628?=
X-GMAIL-MSGID: =?utf-8?q?1593466174123333307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 02:05:34PM +0200, Mika Westerberg wrote:
> On Thu, Feb 22, 2018 at 02:18:34PM +0100, Lukas Wunner wrote:
> > We do need runtime PM on hotplug ports to power off Thunderbolt
> > controllers when nothing is plugged in.  That saves 1.5 W, so a
> > noticeable amount of power.  I was going to respin the series one
> > of these days, I think the best I can do is continue to forbid
> > runtime PM on hotplug ports by default, but whitelist it for
> > Thunderbolt and allow manually enabling it on other platforms via
> > the command line.  That way, vendors are put in a position to
> > validate their platforms for runtime PM of hotplug ports, and
> > perhaps someday we can enable it for all platforms by default,
> > but with a BIOS cut-off date.
> 
> AFAIK Windows started to enable runtime PM (RTD3) for native PCIe
> hotplug ports with the latest release (I guess it's the RS3 release) but
> only when there is a special ACPI _DSD property ("HotPlugSupportInD3")
> associated with the root port. I think we can take advantage of that in
> Linux as well and I already have a patch series to enable runtime PM for
> such ports but I haven't been able to test it properly yet.

Okay.  Well it would be trivial to whitelist those ports with
device_property_present("HotPlugSupportInD3").  In how far are
your patches identical with the patches I submitted last May?
I've started reworking them for v2 but that would be a waste of
time if you're working on this issue in parallel.

Thanks,

Lukas
