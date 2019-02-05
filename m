Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91A92083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfBEHYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:24:10 -0500
Received: from verein.lst.de ([213.95.11.211]:52732 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfBEHYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:24:09 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6EB4968D93; Tue,  5 Feb 2019 08:24:07 +0100 (CET)
Date:   Tue, 5 Feb 2019 08:24:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is
 encrypted
Message-ID: <20190205072407.GA4311@lst.de>
References: <87zhrj8kcp.fsf@morokweng.localdomain> <87womn8inf.fsf@morokweng.localdomain> <20190129134750-mutt-send-email-mst@kernel.org> <6c68f7f7-1b28-6eba-9b8b-2c32efac9701@redhat.com> <20190129213137-mutt-send-email-mst@kernel.org> <20190130074427.GA29516@lst.de> <875ztzxvw2.fsf@morokweng.localdomain> <20190204152416-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204152416-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 04:38:21PM -0500, Michael S. Tsirkin wrote:
> It was designed to make, when set, as many guests as we can work
> correctly, and it seems to be successful in doing exactly that.
> 
> Unfortunately there could be legacy guests that do work correctly but
> become slow. Whether trying to somehow work around that
> can paint us into a corner where things again don't
> work for some people is a question worth discussing.

The other problem is that some qemu machines just throw passthrough
devices and virtio devices on the same virtual PCI(e) bus, and have a
common IOMMU setup for the whole bus / root port / domain.  I think
this is completely bogus, but unfortunately it is out in the field.

Given that power is one of these examples I suspect that is what
Thiago referes to.  But in this case the answer can't be that we
pile on hack ontop of another, but instead introduce a new qemu
machine that separates these clearly, and make that mandatory for
the secure guest support.
