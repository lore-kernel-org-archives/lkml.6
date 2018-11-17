Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA4AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE0D2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 08:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE0D2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeKQSkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 13:40:39 -0500
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:47603 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbeKQSki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 13:40:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 614441800B891;
        Sat, 17 Nov 2018 08:24:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: songs71_bbd521b5d657
X-Filterd-Recvd-Size: 3762
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Nov 2018 08:24:40 +0000 (UTC)
Message-ID: <ced26fae338bb4bd28a16d44980bbd0517aaec10.camel@perches.com>
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
From:   Joe Perches <joe@perches.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        darren@stevens-zone.net, christophe.leroy@c-s.fr,
        geoff@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 17 Nov 2018 00:24:39 -0800
In-Reply-To: <CAFqt6zY2bv=G1N13E4-SA2DE6ey3kw378fFzgEHV7wdpJ5hp5g@mail.gmail.com>
References: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com>
         <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
         <7a3922bc5089dfe0978e07a809606360c74c940c.camel@perches.com>
         <CAFqt6zY2bv=G1N13E4-SA2DE6ey3kw378fFzgEHV7wdpJ5hp5g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-11-17 at 12:40 +0530, Souptick Joarder wrote:
> Hi Joe,

Hi back.

> On Fri, Nov 16, 2018 at 12:55 AM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2018-11-15 at 23:29 +0530, Sabyasachi Gupta wrote:
> > > On Mon, Nov 5, 2018 at 8:58 AM Sabyasachi Gupta
> > > <sabyasachi.linux@gmail.com> wrote:
> > > > Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> > > > 
> > > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> > > 
> > > Any comment on this patch?
> > 
> > It's obviously correct.
> > 
> > You might realign the arguments on the next lines
> > to the open parenthesis.
> > 
> > Perhaps there should be new function calls
> > added for symmetry to the other alloc functions
> > for multiplication overflow protection.
> > 
> > Perhaps:
> > 
> > void *dma_alloc_array_coherent()
> > void *dma_calloc_coherent()
> > 
> > Something like
> > ---
> >  include/linux/dma-mapping.h | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 15bd41447025..95bebf8883b1 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -565,6 +565,25 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
> >                         (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
> >  }
> > 
> > +static inline void *dma_alloc_array_coherent(struct device *dev,
> > +                                            size_t n, size_t size,
> > +                                            dma_addr_t *dma_handle, gfp_t gfp)
> > +{
> > +       size_t bytes;
> > +
> > +       if (unlikely(check_mul_overflow(n, size, &bytes)))
> > +               return NULL;
> > +       return dma_alloc_coherent(dev, bytes, dma_handle, gfp);
> > +}
> > +
> > +static inline void *dma_calloc_coherent(struct device *dev,
> > +                                       size_t n, size_t size,
> > +                                       dma_addr_t *dma_handle, gfp_t gfp)
> > +{
> > +       return dma_alloc_array_coherent(dev, n, size, dma_handle,
> > +                                       gfp | __GFP_ZERO);
> > +}
> > +
> 
> If I understood correctly, you are talking about adding these 2 new inline
> functions. We can do that.
> 
> Can you please help to understand the consumers of these 2 new inline ?

Any call to dma_alloc_coherent with a multiply
_might_overflow the multiplication.  The
check_mul_overflow simply avoids the overflow.


