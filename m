Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeCCEeU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 23:34:20 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:7281 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCCEeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 23:34:18 -0500
X-IronPort-AV: E=Sophos;i="5.47,415,1515456000";
   d="scan'208";a="722536129"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 2/2] PCI/IOV: Use the cached VF BARs size instead of
 re-reading them
Thread-Topic: [PATCH v3 2/2] PCI/IOV: Use the cached VF BARs size instead of
 re-reading them
Thread-Index: AQHTsaS1TwIm3iGB3UmhQpx81kZ7sqO9fT6AgABxNoA=
Date: Sat, 3 Mar 2018 04:34:10 +0000
Message-ID: <1520051649.28771.3.camel@amazon.de>
References: <1519939897-14596-1-git-send-email-karahmed@amazon.de>
         <1519939897-14596-2-git-send-email-karahmed@amazon.de>
         <20180302214857.GD202062@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180302214857.GD202062@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A7983D3A3C88A43ADB3958C028B793A@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w234YUFC021153

On Fri, 2018-03-02 at 15:48 -0600, Bjorn Helgaas wrote:
> On Thu, Mar 01, 2018 at 10:31:37PM +0100, KarimAllah Ahmed wrote:
> > 
> > Use the cached VF BARs size instead of re-reading them from the hardware.
> > That avoids doing unnecessarily bus transactions which is specially
> > noticable when you have a PF with a large number of VFs.
> 
> Thanks a lot for breaking this out!  It seems trivial, but it did make it
> much easier for me to think about this one.
> 
> > 
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: linux-pci@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> > ---
> >  drivers/pci/probe.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index a96837e..aeaa10a 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -180,6 +180,7 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
> >  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >  		    struct resource *res, unsigned int pos)
> >  {
> > +	int bar = res - dev->resource;
> >  	u32 l = 0, sz = 0, mask;
> >  	u64 l64, sz64, mask64;
> >  	u16 orig_cmd;
> > @@ -199,9 +200,13 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >  	res->name = pci_name(dev);
> >  
> >  	pci_read_config_dword(dev, pos, &l);
> > -	pci_write_config_dword(dev, pos, l | mask);
> > -	pci_read_config_dword(dev, pos, &sz);
> > -	pci_write_config_dword(dev, pos, l);
> > +	if (dev->is_virtfn) {
> > +		sz = dev->physfn->sriov->barsz[bar] & 0xffffffff;
> > +	} else {
> > +		pci_write_config_dword(dev, pos, l | mask);
> > +		pci_read_config_dword(dev, pos, &sz);
> > +		pci_write_config_dword(dev, pos, l);
> > +	}
> 
> I don't quite understand this.  This is reading the regular BARs (config
> offsets 0x10, 0x14, ..., 0x24).  Per sec 9.3.4.1.11, these are all RO Zero
> for VFs.  That should make them look like they're all unimplemented.
> 
> But this patch makes us use the size we discovered from the PF's VF BARn
> registers in its SR-IOV capability.  Won't that cause us to fill in the
> VF's dev->resource[n], when we didn't do it before?

Oh .. that is correct! I did not notice this part from the spec :)

> 
> > 
> >  	/*
> >  	 * All bits set in sz means the device isn't working properly.
> > @@ -241,9 +246,14 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >  
> >  	if (res->flags & IORESOURCE_MEM_64) {
> >  		pci_read_config_dword(dev, pos + 4, &l);
> > -		pci_write_config_dword(dev, pos + 4, ~0);
> > -		pci_read_config_dword(dev, pos + 4, &sz);
> > -		pci_write_config_dword(dev, pos + 4, l);
> > +
> > +		if (dev->is_virtfn) {
> > +			sz = (dev->physfn->sriov->barsz[bar] >> 32) & 0xffffffff;
> > +		} else {
> > +			pci_write_config_dword(dev, pos + 4, ~0);
> > +			pci_read_config_dword(dev, pos + 4, &sz);
> > +			pci_write_config_dword(dev, pos + 4, l);
> > +		}
> >  
> >  		l64 |= ((u64)l << 32);
> >  		sz64 |= ((u64)sz << 32);
> > @@ -332,6 +342,8 @@ static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
> >  	for (pos = 0; pos < howmany; pos++) {
> >  		struct resource *res = &dev->resource[pos];
> >  		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
> > +		if (dev->is_virtfn && dev->physfn->sriov->barsz[pos] == 0)
> > +			continue;
> 
> Since we know the VF BARs are all zero (the ones in the VF config space,
> not the ones in the PF SR-IOV capability), including the VF ROM BAR, it
> would make sense to me to totally skip this whole function, e.g.,
> 
>   if (dev->non_compliant_bars)
>     return;
> 
>   if (dev->is_virtfn)
>     return;
> 

Correct! Done.

> > 
> >  		pos += __pci_read_base(dev, pci_bar_unknown, res, reg);
> >  	}
> >  
> > -- 
> > 2.7.4
> > 
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
