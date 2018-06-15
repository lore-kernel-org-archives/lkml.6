Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F0CFAC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66B2208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 09:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UzKBZtwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66B2208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965599AbeFOJQd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 05:16:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965488AbeFOJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 05:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7XGI5O/B4FOb/uJyH5vWb6+ZJbhPouCTnX2JoA+MZu4=; b=UzKBZtwt9EzM4mmfrRr3DW/HH
        jSx8vwh98EXPXZU6mPg5Xha9UiTsDKYX1tDhG4fmA5m0jJHbGpGTNEcvJPDcW0S0FKYl9VnE394FC
        k0q3MibRnRiEPphyvdTF1aBznYJpgaxBjKU52w6XqLyUP7K/B3BuUg/VwFS8YaMAZ12QP/dct0BMk
        7zajpTMXM9McVnylgx8Y8hkD8S8qVInByJhYSSr/pPBHQ7BqvqlBcrbFc38GmjBOSNy4zhPiNKTF3
        VAhOg+3IOKNgW6zzLZsPXJC/VRJb6exjvH0M3g5SpKmLFh6IcrwVIdy7e8aaG1wcbWE/j0KxJz1hH
        VM18+zmWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fTkqH-0002H6-0t; Fri, 15 Jun 2018 09:16:25 +0000
Date:   Fri, 15 Jun 2018 02:16:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ram Pai <linuxram@us.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, robh@kernel.org,
        pawel.moll@arm.com, Tom Lendacky <thomas.lendacky@amd.com>,
        aik@ozlabs.ru, jasowang@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, joe@perches.com,
        "Rustad, Mark D" <mark.d.rustad@intel.com>,
        david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Message-ID: <20180615091624.GA1064@infradead.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10bbd7122aaa67f51de7a8328df8154212a13f23.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 11:11:01PM +1000, Benjamin Herrenschmidt wrote:
> Actually ... the stuff in lib/dma-direct.c seems to be just it, no ?
> 
> There's no cache flushing and there's no architecture hooks that I can
> see other than the AMD security stuff which is probably fine.
> 
> Or am I missing something ?

You are missing the __phys_to_dma arch hook that allows architectures
to adjust the dma address.  Various systems have offsets, or even
multiple banks with different offsets there.  Most of them don't
use the dma-direct code yet (working on it), but there are a few
examples in the tree already.
