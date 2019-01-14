Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F945C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6794A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfANQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:57:58 -0500
Received: from verein.lst.de ([213.95.11.211]:47770 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANQ55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:57:57 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9077968D93; Mon, 14 Jan 2019 17:57:55 +0100 (CET)
Date:   Mon, 14 Jan 2019 17:57:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: remove block layer bounce buffering for MMC
Message-ID: <20190114165755.GA7456@lst.de>
References: <20190114095804.27978-1-hch@lst.de> <5d09d233-8631-2a35-cbcf-ba87b0314b3a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d09d233-8631-2a35-cbcf-ba87b0314b3a@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 04:52:40PM +0000, Robin Murphy wrote:
> One general point for the kmap() conversions - it's not obvious (to me at 
> least) whether or how that would work for a segment where sg->length > 
> PAGE_SIZE. Or is there some cast-iron guarantee from the MMC mid-layer that 
> it will never let the block layer generate such things in the first place?

None of this will with such segments.  But yes, I guess the old case
could have worked as long as any physical contigous ranges are also
virtually contigous.  So we might have to throw in a page size segment
boundary here.
