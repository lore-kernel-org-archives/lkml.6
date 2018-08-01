Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB9BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31CA208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="URDZ5F2J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ig7Wr69h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31CA208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbeHAIZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:25:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43680 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbeHAIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:25:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2EB066074D; Wed,  1 Aug 2018 06:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533105684;
        bh=xMFo6AgokAB14p/2jESTRLOwum26/eCoUeRxe/4S3ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=URDZ5F2J4xqgyUaqF6dEcA97vME8H2x8k50lxAQd1QNJc9ftJkne5qu+TgUWSD2i7
         NdHUM/irKaq4vJKjv4WlcWrrBAAcgKL5fiE9x/F0sWiwwvbqDVuf7Bv8VWL0L55au4
         VMcgxjAebOk5zJFIAYEOFHHIiqQDqt2ZrTda0APk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7A82460275;
        Wed,  1 Aug 2018 06:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533105683;
        bh=xMFo6AgokAB14p/2jESTRLOwum26/eCoUeRxe/4S3ao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ig7Wr69hrXIMK4G+/UzdMDNV7uNbB9EiB59TsJF5OzaOw5uX7ViMhRy5s6IlS2P1W
         Nn8mgqFLvBEsB+lkGS3ze/ASXqxA/b0R7J0XosmfpDFIpTdJm+bsVoKKm5beKpAEuy
         hpiWZO8oV9Kv/W6PeO5sQoAjDuFcQyYe6pQgFQrY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Jul 2018 23:41:23 -0700
From:   okaya@codeaurora.org
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, okaya@kernel.org
Subject: Re: [PATCH] ia64: fix barrier placement for write* / dma mapping
In-Reply-To: <20180731172031.4447-2-hch@lst.de>
References: <20180731172031.4447-1-hch@lst.de>
 <20180731172031.4447-2-hch@lst.de>
Message-ID: <c7ecb31e9a79d26ce9edb15f58e0880f@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ my new email

On 2018-07-31 10:20, Christoph Hellwig wrote:
> memory-barriers.txt has been updated with the following requirement.
> 
> "When using writel(), a prior wmb() is not needed to guarantee that the
> cache coherent memory writes have completed before writing to the MMIO
> region."
> 
> The current writeX() and iowriteX() implementations on ia64 are not
> satisfying this requirement as the barrier is after the register write.
> 

I asked this question to Tony Luck before. If I remember right,
his answer was:

CPU guarantees outstanding writes to be flushed when a register write
instruction is executed and an additional barrier instruction is not
needed.

> This adds the missing memory barriers, and instead drops them from the
> dma sync routine where they are misplaced (and were missing in the
> more important map/unmap cases anyway).
> 
> All this doesn't affect the SN2 platform, which already has barrier
> in the I/O accessors, and none in dma mapping (but then again
> swiotlb doesn't have any either).
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
