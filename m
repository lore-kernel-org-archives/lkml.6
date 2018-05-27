Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755123AbeE0EPL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 00:15:11 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:43849 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeE0EPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 00:15:09 -0400
Date: Sat, 26 May 2018 21:15:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Joshua Thompson <funaho@jurai.org>, Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH] m68k: set dma and coherent masks for Macintosh SONIC
 based ethernet
Message-ID: <20180527041505.GB31985@roeck-us.net>
References: <1527378785-13326-1-git-send-email-linux@roeck-us.net>
 <alpine.LNX.2.21.1805271212480.9@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1805271212480.9@nippy.intranet>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 27, 2018 at 01:01:11PM +1000, Finn Thain wrote:
> On Sat, 26 May 2018, Guenter Roeck wrote:
> 
> > As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
> > coherent_dma_mask") the NatSemi SONIC Ethernet driver is issuing the
> > following warning on driver initialization on Macintosh q800 systems.
> > 
> > SONIC ethernet @50f0a000, MAC 08:00:07:12:34:56, IRQ 3
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 macsonic_init+0x6a/0x15a
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0-rc6-mac-00286-g527f47c #1
> > Stack from 0781fdd8:
> >         0781fdd8 003615b3 000181ba 000005c4 07a24cbc 00000000 00000000 000020e8
> > 	07a24800 002c196c 0001824e 00334c06 00000204 001f782a 00000009 00000000
> > 	00000000 003358d9 001f782a 00334c06 00000204 00000003 00000000 07a24800
> > 	002b5cb6 000372ec 001f8b1a 07a24800 00359203 50f0a000 07a14a48 00000003
> > 	00000000 07845c0a 0039dcca 003c835c 003c835c 0035b924 001c19de 07845c00
> > 	07845c0a 0039dcca 001c06dc 07845c0a 0781fed8 00000007 0054d040 07845c0a
> > Call Trace: [<000181ba>] __warn+0xc0/0xc2
> >  [<000020e8>] do_one_initcall+0x0/0x140
> >  [<0001824e>] warn_slowpath_null+0x26/0x2c
> >  [<001f782a>] macsonic_init+0x6a/0x15a
> >  [<001f782a>] macsonic_init+0x6a/0x15a
> >  [<002b5cb6>] memcmp+0x0/0x2a
> >  [<000372ec>] printk+0x0/0x18
> >  [<001f8b1a>] mac_sonic_platform_probe+0x380/0x404
> > 
> > As per the warning the coherent_dma_mask is not set on this device.
> > There is nothing special about the DMA memory coherency on this hardware
> > so we can just set the mask to 32bits in the platform data for the FEC
> > ethernet devices.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Geert, assuming that Guenter's patch is acceptable, would you also accept 
> a similar patch for the "macmace" platform device?
> 
> > ---
> > Modeled after f61e64310b75 ("m68k: set dma and coherent masks for platform
> > FEC ethernets"). 
> > 
> > RFC: Is "nothing special about the DMA memory coherency" correect ?
> > 
> 
> As I understand it, "cache-coherence" is meaningless unless you have 
> multiple CPU cores and caches. If there's only one CPU core, its cache 

Good point. Maybe it would be better to limit the warning to SMP systems
instead of (unnecessarily) fixing drivers all over the place ?

Guenter

---
>From 9eea0e1b609b69094682757285fd7f89d3930a8e Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 26 May 2018 21:08:39 -0700
Subject: [PATCH] dma-mapping: Warn about coherent_dma_mask only for SMP

As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
coherent_dma_mask") is unconditional, even if the affected system
is a single-CPU system where coherence is irrelevant. Limit the
warning to SMP configurations to reduce the noise.

Fixes: 205e1b7f51e4 ("dma-mapping: warn when there is no coherent_dma_mask")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f8ab1c0f589e..ffbb39d84797 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -513,7 +513,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	void *cpu_addr;
 
 	BUG_ON(!ops);
-	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_SMP) && dev && !dev->coherent_dma_mask);
 
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
-- 
2.7.4
