Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030783AbeBNO2S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:28:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:45406 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030563AbeBNO2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:28:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="17834922"
Date: Wed, 14 Feb 2018 16:28:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: Re: [PATCH 18/18] thunderbolt: Add support for Intel Titan Ridge
Message-ID: <20180214142809.GT27191@lahna.fi.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
 <20180213170018.9780-19-mika.westerberg@linux.intel.com>
 <CAHp75VcwWDTFnBcLotrABvWhT7a=-Z-vue8nB6hko1BaSqKQPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcwWDTFnBcLotrABvWhT7a=-Z-vue8nB6hko1BaSqKQPQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 04:23:44PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 13, 2018 at 7:00 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> 
> > Intel Titan Ridge is the next Thunderbolt 3 controller. The ICM firmware
> > message format in Titan Ridge differs from Falcon Ridge and Alpine Ridge
> > somewhat because it is using route strings addressing devices. In
> > addition to that the DMA port of 4-channel (two port) controller is in
> > different port number than the previous controllers. There are some
> > other minor differences as well.
> >
> > This patch add support for Intel Titan Ridge and the new ICM firmware
> > message format.
> 
> >  static int dma_find_port(struct tb_switch *sw)
> >  {
> > +       static const int ports[] = { 7, 5, 3 };
> 
> Is it anything special in ordering? Otherwise I would keep it the same
> as in comment below.

I don't think there is anything special in ordering so I can update it
accordingly.

> > +       int i;
> >
> >         /*
> > +        * The DMA (NHI) port is either 3, 5 or 7 depending on the
> > +        * controller. Try all of them.
> >          */
> > +       for (i = 0; i < ARRAY_SIZE(ports); i++) {
> > +               u32 type;
> > +               int ret;
> > +
> > +               ret = dma_port_read(sw->tb->ctl, &type, tb_route(sw), ports[i],
> > +                                   2, 1, DMA_PORT_TIMEOUT);
> > +               if (!ret && (type & 0xffffff) == TB_TYPE_NHI)
> > +                       return ports[i];
> > +       }
> 
> > +static inline u64 get_parent_route(u64 route)
> > +{
> > +       int depth = tb_route_length(route);
> > +       return depth ? route & ~((u64)0xff << (depth - 1) * TB_ROUTE_SHIFT) : 0;
> 
> 0xffULL ?
> 
> > +}
> 
> > +       const struct icm_tr_event_device_connected *pkg =
> > +               (const struct icm_tr_event_device_connected *)hdr;
> 
> > +       const struct icm_tr_event_device_disconnected *pkg =
> > +               (const struct icm_tr_event_device_disconnected *)hdr;
> 
> > +       const struct icm_tr_event_xdomain_connected *pkg =
> > +               (const struct icm_tr_event_xdomain_connected *)hdr;
> 
> > +       const struct icm_tr_event_xdomain_disconnected *pkg =
> > +               (const struct icm_tr_event_xdomain_disconnected *)hdr;
> 
> 
> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_LP_USBONLY_NHI        0x15dc
> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_USBONLY_NHI   0x15dd
> >  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_USBONLY_NHI 0x15de
> 
> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI         0x15e8
> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_BRIDGE      0x15e7
> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI         0x15eb
> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_BRIDGE      0x15ea
> > +#define PCI_DEVICE_ID_INTEL_TITAN_RIDGE_DD_BRIDGE      0x15ef
> 
> Can we keep it sorted?

It is sorted by the controller type ;-)

> 
> > +#define ICM_TR_INFO_SLEVEL_MASK                0x7
> 
> GENMASK() ?

OK.

> > +#define ICM_TR_INFO_BOOT_ACL_SHIFT     7
> > +#define ICM_TR_INFO_BOOT_ACL_MASK      GENMASK(12, 7)
> 
> -- 
> With Best Regards,
> Andy Shevchenko
