Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B1FC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE4120658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE4120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJKU5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 16:57:23 -0400
Received: from verein.lst.de ([213.95.11.211]:42889 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbeJKU5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 16:57:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id AE92B68BF4; Thu, 11 Oct 2018 15:30:09 +0200 (CEST)
Date:   Thu, 11 Oct 2018 15:30:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 1/5] mm/sparse: add common helper to mark all memblocks
 present
Message-ID: <20181011133009.GA7276@lst.de>
References: <20181005161642.2462-1-logang@deltatee.com> <20181005161642.2462-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005161642.2462-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	for_each_memblock(memory, reg) {
> +		int nid = memblock_get_region_node(reg);
> +
> +		memory_present(nid, memblock_region_memory_base_pfn(reg),
> +			       memblock_region_memory_end_pfn(reg));

Any reason you have a local variable for the node id while you happily
get away without one for the others?  Why not simply:

	for_each_memblock(memory, reg) {
		memory_present(memblock_get_region_node(reg)
			       memblock_region_memory_base_pfn(reg),
			       memblock_region_memory_end_pfn(reg));
	}
