Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2C1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BFF2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dGmLxfl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BFF2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbeKMXax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:30:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733229AbeKMXax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sRyBSVNzLwzHrFetxFMjdbVTz4W6h9t5a0Cz5J+ZU44=; b=dGmLxfl9fwJbG1TsiXKQPvZKg
        7TGNa1PvCapR+J5Cjlbk91mh69fLKrAocJ6O9M6hD41dYfdGcGw4fUQc9OQ5CSoMcedNRs+LVR4Hx
        OOH806kAf3FU606VhFNhlOPvtC2JgYKVx5YGp1OMHTWJQSYMPl/sxA8mDoQPj175/x08NBaq/BpBA
        eoWcihQgCqoFYAOTZWi3ooeYwKUS2Wzp4DhrX3Fh3WUVFuOnyYrve6tFQc2n0hr9mhPzWFU7tdeDh
        /WdRyzgCekp1je+KpoB+GP3ZFX74I0YH2bf1vMAGp0t31QCiwZjVFafNuXhVr9VqUYB3diie/Pt2n
        1Eqh/2WPg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMYo7-0002I0-P3; Tue, 13 Nov 2018 13:32:43 +0000
Date:   Tue, 13 Nov 2018 05:32:43 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vmscan: return NODE_RECLAIM_NOSCAN in node_reclaim()
 when CONFIG_NUMA is n
Message-ID: <20181113133243.GW21824@bombadil.infradead.org>
References: <20181113041750.20784-1-richard.weiyang@gmail.com>
 <20181113080436.22078-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113080436.22078-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 04:04:36PM +0800, Wei Yang wrote:
> This patch fix the return value by adjusting to NODE_RECLAIM_NOSCAN. Since
> node_reclaim() is only called in page_alloc.c, move it to mm/internal.h.

linux/swap.h is included in quite a few places in the kernel, but let's
see what's really used from it outside mm/

SWAP_FLAG* -- only used in mm/swapfile.c.  Move to swapfile.c?
current_is_kswapd() -- used by some drivers.
MAX_SWAPFILES* -- used by arch code.
union swap_header -- used by mtdswap.
struct reclaim_state -- used by fs/inode.c.
struct swap_extent -- embedded in swap_info_struct, which is used widely.
struct swap_cluster_info -- ditto
struct vma_swap_readahead -- only used in swap_state.c.  Move it there?
nr_free_pages() -- used in fs/ and kernel/power/swap.c
totalram_pages -- used widely
totalreserve_pages -- used widely
vm_swappiness -- used by sysctl
vm_total_pages -- only used in mm -- move to mm/internal.h?
node_reclaim_mode -- used by sysctl
kswapd_run -- only used in mm
kswapd_stop -- ditto
swap_address_space -- only used in mm
swapper_spaces -- likewise
SWAP_ADDRESS_SPACE* --likewise

I haven't covered all of the file, but there's definitely opportunity
for some followup patches to shrink linux/swap.h.
