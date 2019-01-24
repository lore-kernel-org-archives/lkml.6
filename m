Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827DBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4A3218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfAXI30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:29:26 -0500
Received: from 8bytes.org ([81.169.241.247]:59454 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfAXI3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:29:25 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E945A3C8; Thu, 24 Jan 2019 09:29:23 +0100 (CET)
Date:   Thu, 24 Jan 2019 09:29:23 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de
Subject: Re: [PATCH 2/5] swiotlb: Add is_swiotlb_active() function
Message-ID: <20190124082923.GI32526@8bytes.org>
References: <20190123163049.24863-1-joro@8bytes.org>
 <20190123163049.24863-3-joro@8bytes.org>
 <20190123212755.GA9032@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123212755.GA9032@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 10:27:55PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 23, 2019 at 05:30:46PM +0100, Joerg Roedel wrote:
> > +bool is_swiotlb_active(void)
> > +{
> > +	return !no_iotlb_memory;
> > +}
> 
> As I've just introduced and fixed a bug in this area in the current
> cycle - I don't think no_iotlb_memory is what your want (and maybe
> not useful at all): if the arch valls swiotlb_exit after previously
> initializing a buffer it won't be set.  You probably want to check
> for non-zero io_tlb_start and/or io_tlb_end.

Okay, but that requires that I also set io_tlb_start and friends back to
zero in the failure path of swiotlb_init(). Otherwise it could be left
non-zero in case swiotlb_init_with_tbl() returns an error.


Regards,

	Joerg
