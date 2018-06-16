Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E54C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14426204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14426204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756198AbeFPBJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 21:09:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:36427 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753724AbeFPBJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 21:09:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5G17OqR030994;
        Fri, 15 Jun 2018 20:07:25 -0500
Message-ID: <1b4732c5015ee4377fef1de0270065174cde397a.camel@kernel.crashing.org>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ram Pai <linuxram@us.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, robh@kernel.org,
        pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>,
        aik@ozlabs.ru, jasowang@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Sat, 16 Jun 2018 11:07:24 +1000
In-Reply-To: <20180615091624.GA1064@infradead.org>
References: <20180524072104.GD6139@ram.oc3035372033.ibm.com>
         <0c508eb2-08df-3f76-c260-90cf7137af80@linux.vnet.ibm.com>
         <20180531204320-mutt-send-email-mst@kernel.org>
         <20180607052306.GA1532@infradead.org>
         <20180607185234-mutt-send-email-mst@kernel.org>
         <20180611023909.GA5726@ram.oc3035372033.ibm.com>
         <07b804fccd7373c650be79ac9fa77ae7f2375ced.camel@kernel.crashing.org>
         <20180613074141.GA12033@infradead.org>
         <5dbcafa73b065bc619fd6adc9ef47eb6367b8378.camel@kernel.crashing.org>
         <10bbd7122aaa67f51de7a8328df8154212a13f23.camel@kernel.crashing.org>
         <20180615091624.GA1064@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-06-15 at 02:16 -0700, Christoph Hellwig wrote:
> On Wed, Jun 13, 2018 at 11:11:01PM +1000, Benjamin Herrenschmidt wrote:
> > Actually ... the stuff in lib/dma-direct.c seems to be just it, no ?
> > 
> > There's no cache flushing and there's no architecture hooks that I can
> > see other than the AMD security stuff which is probably fine.
> > 
> > Or am I missing something ?
> 
> You are missing the __phys_to_dma arch hook that allows architectures
> to adjust the dma address.  Various systems have offsets, or even
> multiple banks with different offsets there.  Most of them don't
> use the dma-direct code yet (working on it), but there are a few
> examples in the tree already.

Ok and on those systems, qemu will bypass said offset ? Maybe we could
just create a device DMA "flag" or (or use the attributes) to instruct
dma-direct to not use that for legacy virtio ?

Cheers,
Ben.

