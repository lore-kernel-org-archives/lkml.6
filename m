Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFE4C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377232086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S79vV7vj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gjAJ0fPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbfARVc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:32:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfARVcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:32:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D56A1608CC; Fri, 18 Jan 2019 21:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547847174;
        bh=UZnCKxb6ZrWfjM/OUHrLJO/tDBrmvJlyjcuWHnZsoOc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=S79vV7vjRtxwk6msAlVa+fgkPMGMFgyt8ndg8skSpm4343wyWRIzjZSPkjt9eCK7n
         fU/XG92vZp8UyEnFQ0LsCDpIsxeI/8NrnxsU+OMGgdqpbNY7u03zaq9nLSJQ3wOEmd
         2cI/l8otK1FpFUBtXGCIIMIZYDORZ3rydj54BVeM=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EC6160851;
        Fri, 18 Jan 2019 21:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547847173;
        bh=UZnCKxb6ZrWfjM/OUHrLJO/tDBrmvJlyjcuWHnZsoOc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gjAJ0fPReXSrKzvpGaJbw8uZgOB+VLL8mt2O7Vn9G88+7n92P8YDot5oZIBXpobvF
         0OL81JrA2psKIDYdvcN7tPi62JrOHpXimgkVQ9rsKPiIQCBtSKctLORjc+qyunFbVY
         L9aPec4RcWCK2FRxjD2lbDj0pO7R1lfdyCRh4BYw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EC6160851
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Fri, 18 Jan 2019 13:32:52 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Laura Abbott <labbott@redhat.com>
cc:     sumit.semwal@linaro.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
In-Reply-To: <9f654f36-08de-f5e8-c9b3-ff9b2954f0a6@redhat.com>
Message-ID: <alpine.DEB.2.10.1901181322300.9328@lmark-linux.qualcomm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org> <1547836667-13695-4-git-send-email-lmark@codeaurora.org> <9f654f36-08de-f5e8-c9b3-ff9b2954f0a6@redhat.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Laura Abbott wrote:

> On 1/18/19 10:37 AM, Liam Mark wrote:
> > Add support for configuring dma mapping attributes when mapping
> > and unmapping memory through dma_buf_map_attachment and
> > dma_buf_unmap_attachment.
> > 
> > Signed-off-by: Liam Mark <lmark@codeaurora.org>
> > ---
> >   include/linux/dma-buf.h | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 58725f890b5b..59bf33e09e2d 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -308,6 +308,8 @@ struct dma_buf {
> >    * @dev: device attached to the buffer.
> >    * @node: list of dma_buf_attachment.
> >    * @priv: exporter specific attachment data.
> > + * @dma_map_attrs: DMA mapping attributes to be used in
> > + *		   dma_buf_map_attachment() and dma_buf_unmap_attachment().
> >    *
> >    * This structure holds the attachment information between the dma_buf
> > buffer
> >    * and its user device(s). The list contains one attachment struct per
> > device
> > @@ -323,6 +325,7 @@ struct dma_buf_attachment {
> >   	struct device *dev;
> >   	struct list_head node;
> >   	void *priv;
> > +	unsigned long dma_map_attrs;
> >   };
> >     /**
> > 
> 
> Did you miss part of this patch? This only adds it to the structure but
> doesn't
> add it to any API. The same commment applies to the follow up patch,
> I don't quite see how it's being used.
> 

Were you asking for a cleaner DMA-buf API to set this field or were you 
asking for a change to an upstream client to make use of this field?

I have clients set the dma_map_attrs field directly on their
dma_buf_attachment struct before calling dma_buf_map_attachment (if they
need this functionality).
Of course this is all being used in Android for out of tree drivers, but
I assume it is just as useful to everyone else who has cached ION buffers
which aren't always accessed by the CPU.

My understanding is that AOSP Android on Hikey 960 also is currently
suffering from too many CMOs due to dma_map_attachemnt always applying
CMOs, so this support should help them avoid it.

> Thanks,
> Laura
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
