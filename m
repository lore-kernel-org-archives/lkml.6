Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A1C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5007208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5007208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbeHAJJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 05:09:35 -0400
Received: from verein.lst.de ([213.95.11.211]:32929 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732300AbeHAJJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 05:09:35 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 960C79ED64; Wed,  1 Aug 2018 09:29:47 +0200 (CEST)
Date:   Wed, 1 Aug 2018 09:29:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     okaya@codeaurora.org
Cc:     Christoph Hellwig <hch@lst.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, okaya@kernel.org
Subject: Re: [PATCH] ia64: fix barrier placement for write* / dma mapping
Message-ID: <20180801072947.GD20224@lst.de>
References: <20180731172031.4447-1-hch@lst.de> <20180731172031.4447-2-hch@lst.de> <c7ecb31e9a79d26ce9edb15f58e0880f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ecb31e9a79d26ce9edb15f58e0880f@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 11:41:23PM -0700, okaya@codeaurora.org wrote:
> I asked this question to Tony Luck before. If I remember right,
> his answer was:
>
> CPU guarantees outstanding writes to be flushed when a register write
> instruction is executed and an additional barrier instruction is not
> needed.

That would be great.  It still doesn't explain the barriers in the
dma sync routines.  Those have been there since the following commit
in the history tree:

commit 66b99421d118a5ddd98a72913670b0fcf0a38d45
Author: Andrew Morton <akpm@osdl.org>
Date:   Sat Mar 13 17:05:37 2004 -0800

    [PATCH] DMA: Fill gaping hole in DMA API interfaces.

    From: "David S. Miller" <davem@redhat.com>

which in fact only added them for the HP zx1 platform, and doesn't
contain any good explanation of why we need a barrier.

So I guess the right answer might be to just remove these barriers
without replacement.
