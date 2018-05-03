Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeECAwk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 20:52:40 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:50908 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbeECAwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 20:52:39 -0400
X-Google-Smtp-Source: AB8JxZpS/dKXhbOdhrBiNk3S+Vvx4y6hsj/KANwk/Lt5+xcMwKe+1uH4RMWZ5x7DGLc/cUafpQC60g==
Message-ID: <1525308755.14025.25.camel@arista.com>
Subject: Re: [PATCHv4 2/2] iommu/vt-d: Limit number of faults to clear in
 irq handler
From: Dmitry Safonov <dima@arista.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, linux-kernel@vger.kernel.org,
        joro@8bytes.org, "Raj, Ashok" <ashok.raj@intel.com>
Cc: 0x7f454c46@gmail.com, Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        iommu@lists.linux-foundation.org
Date: Thu, 03 May 2018 01:52:35 +0100
In-Reply-To: <5AEA4E84.6050609@linux.intel.com>
References: <20180331003312.6390-1-dima@arista.com>
         <20180331003312.6390-2-dima@arista.com> <5AE95BFF.5040306@linux.intel.com>
         <1525264687.14025.20.camel@arista.com> <5AEA4E84.6050609@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 07:49 +0800, Lu Baolu wrote:
> Hi,
> 
> On 05/02/2018 08:38 PM, Dmitry Safonov wrote:
> > Hi Lu,
> > 
> > On Wed, 2018-05-02 at 14:34 +0800, Lu Baolu wrote:
> > > Hi,
> > > 
> > > On 03/31/2018 08:33 AM, Dmitry Safonov wrote:
> > > > Theoretically, on some machines faults might be generated
> > > > faster
> > > > than
> > > > they're cleared by CPU.
> > > 
> > > Is this a real case?
> > 
> > No. 1/2 is a real case and this one was discussed on v3:
> > lkml.kernel.org/r/<20180215191729.15777-1-dima@arista.com>
> > 
> > It's not possible on my hw as far as I tried, but the discussion
> > result
> > was to fix this theoretical issue too.
> 
> If faults are generated faster than CPU can clear them, the PCIe
> device should be in a very very bad state. How about disabling
> the PCIe device and ask the administrator to replace it? Anyway,
> I don't think that's goal of this patch series. :-)

Uhm, yeah, my point is not about the number of faults, but about
physical ability of iommu to generate faults faster than cpu processes
them. I might be wrong that it's not possible (like low cpu freq?)

But the number of interrupts might be high. It's like you've many
mappings on iommu and PCIe device went off. It could be just a link
flap. I think it makes sense not lockup on such occasions.

> > > >  Let's limit the cleaning-loop by number of hw
> > > > fault registers.
> > > 
> > > Will this cause the fault recording registers full of faults,
> > > hence
> > > new faults will be dropped without logging?
> > 
> > If faults come faster then they're being cleared - some of them
> > will be
> > dropped without logging. Not sure if it's worth to report all
> > faults in
> > such theoretical(!) situation.
> > If amount of reported faults for such situation is not enough and
> > it's
> > worth to keep all the faults, then probably we should introduce a
> > workqueue here (which I did in v1, but it was rejected by the
> > reason
> > that it will introduce some latency in fault reporting).
> > 
> > > And even worse, new faults will not generate interrupts?
> > 
> > They will, we clear page fault overflow outside of the loop, so any
> > new
> > fault will raise interrupt, iiuc.
> > 
> 
> I am afraid that they might not generate interrupts any more.
> 
> Say, the fault registers are full of events that are not cleared,
> then a new fault comes. There is no room for this event and
> hence the hardware might drop it silently.

AFAICS, we're doing fault-clearing in a loop inside irq handler.
That means that while we're clearing if a fault raises, it'll make
an irq level triggered (or on edge) on lapic. So, whenever we return
from the irq handler, irq will raise again.

-- 
Thanks,
             Dmitry
