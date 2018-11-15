Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C56BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0381223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0381223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbeKPFeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:34:17 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:38812 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725869AbeKPFeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:34:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id CD391180790B5;
        Thu, 15 Nov 2018 19:25:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: train79_844655162681d
X-Filterd-Recvd-Size: 3595
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Nov 2018 19:25:08 +0000 (UTC)
Message-ID: <7a3922bc5089dfe0978e07a809606360c74c940c.camel@perches.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
From:   Joe Perches <joe@perches.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        darren@stevens-zone.net, christophe.leroy@c-s.fr,
        geoff@infradead.org
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Thu, 15 Nov 2018 11:25:07 -0800
In-Reply-To: <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
References: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
         <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-15 at 23:29 +0530, Sabyasachi Gupta wrote:
> On Mon, Nov 5, 2018 at 8:58 AM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
> > Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> > 
> > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> 
> Any comment on this patch?

It's obviously correct.

You might realign the arguments on the next lines
to the open parenthesis.

Perhaps there should be new function calls
added for symmetry to the other alloc functions
for multiplication overflow protection.

Perhaps:

void *dma_alloc_array_coherent()
void *dma_calloc_coherent()

Something like
---
 include/linux/dma-mapping.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 15bd41447025..95bebf8883b1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -565,6 +565,25 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
+static inline void *dma_alloc_array_coherent(struct device *dev,
+					     size_t n, size_t size,
+					     dma_addr_t *dma_handle, gfp_t gfp)
+{
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, size, &bytes)))
+		return NULL;
+	return dma_alloc_coherent(dev, bytes, dma_handle, gfp);
+}
+
+static inline void *dma_calloc_coherent(struct device *dev,
+					size_t n, size_t size,
+					dma_addr_t *dma_handle, gfp_t gfp)
+{
+	return dma_alloc_array_coherent(dev, n, size, dma_handle,
+					gfp | __GFP_ZERO);
+}
+
 static inline void dma_free_coherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {

---
> > diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
[]
> > @@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
> > 
> >         chan->ring_size = ring_size;
> > 
> > -       chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
> > +       chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
> >                                              ring_size * sizeof(u64),
> >                                              &chan->ring_dma, GFP_KERNEL);
> >  en
> >         if (!chan->ring_virt)
> >                 return -ENOMEM;
> > 
> > -       memset(chan->ring_virt, 0, ring_size * sizeof(u64));
> > -
> >         return 0;
> >  }
> >  EXPORT_SYMBOL(pasemi_dma_alloc_ring);


