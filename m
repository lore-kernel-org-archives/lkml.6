Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081ABECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD51420850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD51420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbeGRO7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:59:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:51153 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeGRO7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:59:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 07:21:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,370,1526367600"; 
   d="scan'208";a="217002915"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.8.16])
  by orsmga004.jf.intel.com with ESMTP; 18 Jul 2018 07:21:11 -0700
Message-ID: <4bb491b5b31eeefbe82b5d21c1c2b3c19d7cc0d4.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: Prevent loading of driver on Mehlow
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 18 Jul 2018 07:21:11 -0700
In-Reply-To: <CAO-hwJ+b6aSSC7UGDtdivfh69+ZZaV5uwJH_ramLM0FeAZwRDQ@mail.gmail.com>
References: <20180717200557.39925-1-srinivas.pandruvada@linux.intel.com>
         <CAO-hwJ+b6aSSC7UGDtdivfh69+ZZaV5uwJH_ramLM0FeAZwRDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 09:53 +0200, Benjamin Tissoires wrote:
> On Tue, Jul 17, 2018 at 10:06 PM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > On Mehlow Xeon-E workstation, ISH PCI device is enabled but without
> > ISH
> > firmware. Here the ISH device PCI device id was reused for some non
> > Linux
> > storage drivers. So this was not done for enabling ISH. But this
> > has a
> > undesirable side effect for Linux.
> > 
> > Here the ISH driver will be loaded via PCI enumeration and will try
> > to do
> > reset sequence. But reset sequence will wait till timeout as there
> > is no
> > real ISH firmware is present to take action. This delay will add to
> > boot
> > time of Linux (This platform will still continue to boot after this
> > timeout).
> > 
> > To avoid this boot delay we need to prevent loading of ISH drivers
> > on
> > this platform. So we need to have hack to avoid treating this
> > device as
> > ISH on this platform. To identify this workstation, we need some
> > runtime
> > method. Luckily there are special PCI id on this workstation to
> > distinguish from the client version of this platform. On client
> > version,
> > the ISH is supported using same PCI device id. So this change look
> > for
> > the presence of PCI device IDs A309 and A30A and exit.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > ---
> > This is not a change for 4.18-rc.
> > 
> >  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 23
> > +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > index a2c53ea3b5ed..d6e7156c36d9 100644
> > --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > @@ -95,6 +95,26 @@ static int ish_init(struct ishtp_device *dev)
> >         return 0;
> >  }
> > 
> > +
> > +static bool ish_invalid_firmware(void)
> > +{
> > +       struct pci_dev *pdev;
> > +
> > +       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0xA309, NULL);
> > +       if (pdev) {
> > +               pci_dev_put(pdev);
> > +               return true;
> > +       }
> > +
> > +       pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0xA30A, NULL);
> > +       if (pdev) {
> > +               pci_dev_put(pdev);
> > +               return true;
> > +       }
> 
> I think this duplicated code should be merged in a for loop on an
> array of blacklisted items :)
Good idea.

Thanks,
Srinivas

> 
> Cheers,
> Benjamin
> 
> > +
> > +       return false;
> > +}
> > +
> >  /**
> >   * ish_probe() - PCI driver probe callback
> >   * @pdev:      pci device
> > @@ -110,6 +130,9 @@ static int ish_probe(struct pci_dev *pdev,
> > const struct pci_device_id *ent)
> >         struct ish_hw *hw;
> >         int     ret;
> > 
> > +       if (ish_invalid_firmware())
> > +               return -ENODEV;
> > +
> >         /* enable pci dev */
> >         ret = pci_enable_device(pdev);
> >         if (ret) {
> > --
> > 2.17.1
> > 
