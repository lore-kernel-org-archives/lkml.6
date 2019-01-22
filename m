Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E7BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41ED520870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UHFVySlM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S9Wf1H1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfAVWuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:50:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfAVWuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:50:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C6E4860867; Tue, 22 Jan 2019 22:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548197403;
        bh=vCSSvRVfZ0XHisZ25/uoPP/+0QrTlYbkg6HMjzLUSU8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=UHFVySlMR62MrNbNIOFsEQKYjD1pQsPPuw4MeYNKlxHY4LMEWClyW2adYVzlnUfXD
         0xiQMZ4KlTXjzaQ3laj9z7HG4ZSxMi79WlaXdNY10zixqYb9oYRFL77mGxdcissAiM
         daf2qYfzPv7YFUOXjejvXUY8GGfe/jLj18MQWa+0=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 423DB60740;
        Tue, 22 Jan 2019 22:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548197401;
        bh=vCSSvRVfZ0XHisZ25/uoPP/+0QrTlYbkg6HMjzLUSU8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=S9Wf1H1SkSPLNcnqXOBrkV0tehuFGMfcI+dXSjgWUMMeHi5E8WJKExDt1qzqO8tWk
         09nlFsboa8wpaRIKRcDSK4VDXaWjfA9BuPS3wEztO8KN/a4AqZqxyTE79/FDqDPb3A
         7mldVYOlzYXlgooDswY6NvqLSIc+TMo1DP5xE2v4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 423DB60740
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Tue, 22 Jan 2019 14:50:00 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     "Andrew F. Davis" <afd@ti.com>
cc:     Christoph Hellwig <hch@infradead.org>,
        Laura Abbott <labbott@redhat.com>, sumit.semwal@linaro.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
In-Reply-To: <8d87ffa0-0710-fc82-ef87-50843fe3a4ee@ti.com>
Message-ID: <alpine.DEB.2.10.1901221447270.23328@lmark-linux.qualcomm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org> <1547836667-13695-4-git-send-email-lmark@codeaurora.org> <20190119102527.GA17723@infradead.org> <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com> <20190121083046.GD12420@infradead.org>
 <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com> <20190121212947.GA28620@infradead.org> <alpine.DEB.2.10.1901211357140.11004@lmark-linux.qualcomm.com> <8d87ffa0-0710-fc82-ef87-50843fe3a4ee@ti.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2019, Andrew F. Davis wrote:

> On 1/21/19 4:12 PM, Liam Mark wrote:
> > On Mon, 21 Jan 2019, Christoph Hellwig wrote:
> > 
> >> On Mon, Jan 21, 2019 at 11:44:10AM -0800, Liam Mark wrote:
> >>> The main use case is for allowing clients to pass in 
> >>> DMA_ATTR_SKIP_CPU_SYNC in order to skip the default cache maintenance 
> >>> which happens in dma_buf_map_attachment and dma_buf_unmap_attachment. In 
> >>> ION the buffers aren't usually accessed from the CPU so this allows 
> >>> clients to often avoid doing unnecessary cache maintenance.
> >>
> >> This can't work.  The cpu can still easily speculate into this area.
> > 
> > Can you provide more detail on your concern here.
> > The use case I am thinking about here is a cached buffer which is accessed 
> > by a non IO-coherent device (quite a common use case for ION).
> > 
> > Guessing on your concern:
> > The speculative access can be an issue if you are going to access the 
> > buffer from the CPU after the device has written to it, however if you 
> > know you aren't going to do any CPU access before the buffer is again 
> > returned to the device then I don't think the speculative access is a 
> > concern.
> > 
> >> Moreover in general these operations should be cheap if the addresses
> >> aren't cached.
> >>
> > 
> > I am thinking of use cases with cached buffers here, so CMO isn't cheap.
> > 
> 
> These buffers are cacheable, not cached, if you haven't written anything
> the data wont actually be in cache. 

That's true

> And in the case of speculative cache
> filling the lines are marked clean. In either case the only cost is the
> little 7 instruction loop calling the clean/invalidate instruction (dc
> civac for ARMv8) for the cache-lines. Unless that is the cost you are
> trying to avoid?
> 

This is the cost I am trying to avoid and this comes back to our previous 
discussion.  We have a coherent system cache so if you are doing this for 
every cache line on a large buffer it adds up with this work and the going 
to the bus.
For example I believe 1080P buffers are 8MB, and 4K buffers are even 
larger.

I also still think you would want to solve this properly such that 
invalidates aren't being done unnecessarily.

> In that case if you are mapping and unmapping so much that the little
> CMO here is hurting performance then I would argue your usage is broken
> and needs to be re-worked a bit.
> 

I am not sure I would say it is broken, the large buffers (example 1080P 
buffers) are mapped and unmapped on every frame. I don't think there is 
any clean way to avoid that in a pipelining framework, you could ask 
clients to keep the buffers dma mapped but there isn't necessarily a good 
time to tell them to unmap. 

It would be unfortunate to not consider this something legitimate for 
usespace to do in a pipelining use case.
Requiring devices to stay attached doesn't seem very clean to me as there 
isn't necessarily a nice place to tell them when to detach.


Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
