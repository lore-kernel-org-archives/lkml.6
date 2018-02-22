Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AH8x225XR5pEVcA8zo2CtMY3LdXX0UJENt3LLlrdgwacuN0q5GNRGoVJ28Rite4GSJkbWjGv9SeY
ARC-Seal: i=1; a=rsa-sha256; t=1519305515; cv=none;
        d=google.com; s=arc-20160816;
        b=C9sTQ12dN5qaqr7qyPkR0AQw1RcWjyNzjG9uhBeL/sYjYdea7+860b3xJf5IZqR8AJ
         bousZINmOYytCmvxomuxHY6aMQvzcOEWEW35nVIImYgF/Cnkk0+a+FRLdRrC3SNhMPML
         k4Al262cqWz11lKynMS8oSaPxY1h8rbKKRs7KqCGh4mmv+bRigK2IYt7fkm8PIuWZlUZ
         gXRgUz6ICxqmk/7/sISPUU8PM9iF/FudN0J1kP8qV83XeIHNn82MtYBN3SCvSXdpVAOR
         HqxPdgMC1Gd91TdHujNiDtvFrxDFp+4jKD6MaQm1sRM4YCl3lFxb1OJQRwqvswcoULHl
         ODUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=6Zpo2+Pc7ueVE3bedcaEh1mwl58TqHgMTXfXhPjdTn0=;
        b=qByyunCYzW2ZARTcjiSyXSpMtAFDjIf6KfHfGGmlMZYlksGdm2ZlQoTX445v0ruE9W
         nnYM7zzJDTLgp0dNZsDnUhjk+Oe50ABajvCBAcjVFEOfXkFWdexMF/MTk5BTh2NNydo4
         5f5m66plb8AtC+G+6o9lAFACElKWro4Z0higCs+G96qe9mRbXxADSYiRtszKpR5/2Zul
         z4Z8F+JE0SG+HE4+de2NRLTSPYDplQB827Q3UNQqCrdd+9E4CkuXb+IRA/UJ7RnMDc83
         bkvEWSSZ8VmlwduyleiMS7TggbFhXQzfa23yXt3GCg2nVfWFt7ywVDmMrMwSTzA5qSwA
         V9wA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.90.240 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Thu, 22 Feb 2018 14:18:34 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
Message-ID: <20180222131834.GA5527@wunner.de>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
 <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872976935903628?=
X-GMAIL-MSGID: =?utf-8?q?1593107299865313148?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 12:15:54PM -0600, Bjorn Helgaas wrote:
> Basically I was hoping to partially rectify what I think was a mistake
> on my part when we merged this.  9d26d3a8f1b0 ("PCI: Put PCIe ports
> into D3 during suspend") is somewhat misleading because it suggests
> that PCI bridge power management can only be supported on non-hotplug
> PCIe ports, when in fact this was mostly a question of testing and "we
> know this works on the systems we care about so we're going to
> minimize our risk by excluding others".  These constraints seem pretty
> Intel-centric and it's not clear how or whether they apply to other
> architectures.
> 
> Adding the comments will help with that some, but in general I don't
> like to artificially limit feature support because it reduces testing
> exposure and makes future maintenance more difficult.
> 
> For example, we disallow D3 for hotplug bridges.  I don't think the
> spec requires that, so the fact that we put that limitation in
> suggests that there was some issue we didn't fully understand, and now
> it will be hard to go back and figure that out if and when we *do*
> want to support D3 for hotplug bridges.

Some x86 machines which handle hotplug in firmware, rather than natively
by the OS, require that the OS doesn't transition them to D3hot behind
the firmware's back.  That's the reason why Mika excluded them from
runtime PM:
https://bugzilla.kernel.org/show_bug.cgi?id=53811

If the OS handles hotplug natively, transitioning the ports to D3hot
should be fine in theory.  I submitted this series last May to extend
runtime PM to those:
https://www.spinics.net/lists/linux-pci/msg60962.html

However Ashok Raj tested them on a Xeon-SP system and got Hardware Errors:
https://lkml.org/lkml/2017/5/3/480

I'm not sure if I've done anything wrong in that series or if we're
dealing with an incompatibility of this particular platform with D3hot
on hotplug ports.

We do need runtime PM on hotplug ports to power off Thunderbolt
controllers when nothing is plugged in.  That saves 1.5 W, so a
noticeable amount of power.  I was going to respin the series one
of these days, I think the best I can do is continue to forbid
runtime PM on hotplug ports by default, but whitelist it for
Thunderbolt and allow manually enabling it on other platforms via
the command line.  That way, vendors are put in a position to
validate their platforms for runtime PM of hotplug ports, and
perhaps someday we can enable it for all platforms by default,
but with a BIOS cut-off date.

As for the existing 2015 cut-off for non-hotplug ports, I remember
Rafael writing that we may try to slowly push the cut-off further
back into the past and stop as soon as problems are reported.
That hasn't happened yet because noone had a need for it.

Thanks,

Lukas
