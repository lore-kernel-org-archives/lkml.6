Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60269ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7F7205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7F7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbeGTKvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:51:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38571 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727578AbeGTKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:51:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so9329459edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 03:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1lcFQB3z8emiUI91XrT+zC2mcmQxznHsyGOmv+zVyIM=;
        b=RjKS8CAPhyxCTp+y2xyYhfh4TEOEA4QkNoz6ZSCG4kV/5P2D3WzaJzVXp6XUCj24FX
         PzxuQZ2PnaREgWxYrGGPqupwotLgQ1+Ewi9EER8YVj2U85sYnqkdh1opRg+acM1kpum9
         g/BR40QgttqNjGp1+y+hI58J5HjEsjTs272hT1W997ws2/WBCOMOaA0GH7lhB7/Rk1xY
         BA6paFOGluGiI8rZRQd9X/OmioUb97oDjzo8tIp1D0xolsn9/TQp2JmGwN7XN1iBehTY
         y7PxB+nGQQK/hWEekIqzSzOWNLUf3b96UKVExw0BZJkJYOsgWYcYsbeUOYVPRTsEjuAM
         Lfnw==
X-Gm-Message-State: AOUpUlF+mMowuiysHVUAr8DAdCo2Bb1fppjkmY8Hee+IPiA1cau5+ieb
        HBOES1t5T8rWdJkblKHOq0c=
X-Google-Smtp-Source: AAOMgpcg6YCiWXZ905uMX3xWpCPNFt7o9q8XF8uIVGNQCVjrfqB/gYq3XRbgK7StCI43UzVadKscjw==
X-Received: by 2002:a50:9fe9:: with SMTP id c96-v6mr1886040edf.17.1532081008443;
        Fri, 20 Jul 2018 03:03:28 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id u3-v6sm898646edo.44.2018.07.20.03.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 03:03:27 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 2CD751241D6; Fri, 20 Jul 2018 12:03:27 +0200 (CEST)
Date:   Fri, 20 Jul 2018 12:03:27 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 3/5] mm/page_alloc: Optimize free_area_init_core
Message-ID: <20180720100327.GA19478@techadventures.net>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-4-osalvador@techadventures.net>
 <20180719134417.GC7193@dhcp22.suse.cz>
 <20180719140327.GB10988@techadventures.net>
 <20180719151555.GH7193@dhcp22.suse.cz>
 <20180719205235.GA14010@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719205235.GA14010@techadventures.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:52:35PM +0200, Oscar Salvador wrote:
> On Thu, Jul 19, 2018 at 05:15:55PM +0200, Michal Hocko wrote:
> > Your changelog doesn't really explain the motivation. Does the change
> > help performance? Is this a pure cleanup?
> 
> Hi Michal,
> 
> Sorry to not have explained this better from the very beginning.
> 
> It should help a bit in performance terms as we would be skipping those
> condition checks and assignations for zones that do not have any pages.
> It is not a huge win, but I think that skipping code we do not really need to run
> is worh to have.
> 
> > The function is certainly not an example of beauty. It is more an
> > example of changes done on top of older ones without much thinking. But
> > I do not see your change would make it so much better. I would consider
> > it a much nicer cleanup if it was split into logical units each doing
> > one specific thing.
> 
> About the cleanup, I thought that moving that block of code to a separate function
> would make the code easier to follow.
> If you think that this is still not enough, I can try to split it and see the outcome.

I tried to split it innto three logical blocks:

- Substract memmap pages
- Substract dma reserves
- Account kernel pages (nr_kernel_pages and nr_total_pages)

Is this something that makes sense to you:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 10b754fba5fa..1397dcdd4a3c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6237,6 +6237,47 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat)
 static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
 #endif
 
+static void account_kernel_pages(enum zone_type j, unsigned long freesize,
+						unsigned long memmap_pages)
+{
+	if (!is_highmem_idx(j))
+		nr_kernel_pages += freesize;
+	/* Charge for highmem memmap if there are enough kernel pages */
+	else if (nr_kernel_pages > memmap_pages * 2)
+		 nr_kernel_pages -= memmap_pages;
+	nr_all_pages += freesize;
+}
+
+static unsigned long substract_dma_reserves(unsigned long freesize)
+{
+	/* Account for reserved pages */
+	if (freesize > dma_reserve) {
+		freesize -= dma_reserve;
+		printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
+					zone_names[0], dma_reserve);
+	}
+
+	return freesize;
+}
+
+static unsigned long substract_memmap_pages(unsigned long freesize, unsigned long memmap_pages)
+{
+	/*
+	 * Adjust freesize so that it accounts for how much memory
+	 * is used by this zone for memmap. This affects the watermark
+	 * and per-cpu initialisations
+	 */
+	if (freesize >= memmap_pages) {
+		freesize -= memmap_pages;
+		if (memmap_pages)
+			printk(KERN_DEBUG "  %s zone: %lu pages used for memmap\n",
+							zone_names[j], memmap_pages);
+	} else
+		pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
+				zone_names[j], memmap_pages, freesize);
+	return freesize;
+}
+
 /*
  * Set up the zone data structures:
  *   - mark all pages reserved
@@ -6267,44 +6308,20 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 
 	for (j = 0; j < MAX_NR_ZONES; j++) {
 		struct zone *zone = pgdat->node_zones + j;
-		unsigned long size, freesize, memmap_pages;
+		unsigned long size = zone->spanned_pages
+		unsigned long freesize = zone->present_pages;
 		unsigned long zone_start_pfn = zone->zone_start_pfn;
 
-		size = zone->spanned_pages;
-		freesize = zone->present_pages;
-
-		/*
-		 * Adjust freesize so that it accounts for how much memory
-		 * is used by this zone for memmap. This affects the watermark
-		 * and per-cpu initialisations
-		 */
-		memmap_pages = calc_memmap_size(size, freesize);
-		if (!is_highmem_idx(j)) {
-			if (freesize >= memmap_pages) {
-				freesize -= memmap_pages;
-				if (memmap_pages)
-					printk(KERN_DEBUG
-					       "  %s zone: %lu pages used for memmap\n",
-					       zone_names[j], memmap_pages);
-			} else
-				pr_warn("  %s zone: %lu pages exceeds freesize %lu\n",
-					zone_names[j], memmap_pages, freesize);
-		}
+		if (size) {
+			unsigned long memmap_pages = calc_memmap_size(size, freesize);
+			if (!is_highmem_idx(j))
+				freesize =  substract_memmap_pages(freesize, memmap_pages);
 
-		/* Account for reserved pages */
-		if (j == 0 && freesize > dma_reserve) {
-			freesize -= dma_reserve;
-			printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
-					zone_names[0], dma_reserve);
+			if (j == ZONE_DMA)
+				freesize = substract_dma_reserves(freesize);
+			account_kernel_pages(j, freesize, memmap_pages);
 		}
 
-		if (!is_highmem_idx(j))
-			nr_kernel_pages += freesize;
-		/* Charge for highmem memmap if there are enough kernel pages */
-		else if (nr_kernel_pages > memmap_pages * 2)
-			nr_kernel_pages -= memmap_pages;
-		nr_all_pages += freesize;

Thanks
-- 
Oscar Salvador
SUSE L3
