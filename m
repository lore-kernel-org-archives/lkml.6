Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C503ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9292084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9292084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbeGSIRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 04:17:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37590 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeGSIRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 04:17:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id a19-v6so5265042wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 00:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZSHVeUmxaRs/bHTRX6MZqfR5Lk1G8TprM3+I0RdvAb0=;
        b=RsitaOGaKkakwA92eRm0ac2LEr+R9HO3rc5VIrMYO62TnIW/zWG0xa+m1RUiqCQoSm
         SDc1rNnaHsUkJZ3Nh4lpZP/zuI+3HVBFsEMatVSD0/B9CLYOFzuEgX+zl89gLnqJWdZI
         R+EaLmbXaFxk1CFiwEyNoQuhDhMtdH2ic/xlNO06qtdcoPSIkJz9KI/ltXicqin8Xfs4
         hrlFvcMEdE3/gg/pkWOSXVE6a/RDCjsPMoJPXENfukuYRyFP1Fu1eAr8XfpHuC6cnfmp
         dGmSLzW2vXDNoLH4kZsLTKjEBgPBId5EkkjArtdoMMhS0tyloD4SVHci3p78W6KroKm5
         eJ2g==
X-Gm-Message-State: AOUpUlG+fSRWw2S/eL1LzPTN8s7Gvtw6XmD/+jMrF8chXayxDAU5A20b
        kZqj2dbQPK1BtACPKrccBLQ=
X-Google-Smtp-Source: AAOMgpcCPSZhNU+GytuJ3u6vzwnP84PgwRbUcDNyF/wYtbLzmXf0q1l2pZ9m5JKm5IwM1yJuji94Cg==
X-Received: by 2002:a1c:b788:: with SMTP id h130-v6mr3652561wmf.27.1531985732386;
        Thu, 19 Jul 2018 00:35:32 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id u185-v6sm3321832wmg.25.2018.07.19.00.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 00:35:31 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 2B63E12413E; Thu, 19 Jul 2018 09:35:31 +0200 (CEST)
Date:   Thu, 19 Jul 2018 09:35:31 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, iamjoonsoo.kim@lge.com,
        aaron.lu@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@suse.de
Subject: Re: [PATCH 3/3] mm/page_alloc: Split context in free_area_init_node
Message-ID: <20180719073531.GA8750@techadventures.net>
References: <20180718124722.9872-1-osalvador@techadventures.net>
 <20180718124722.9872-4-osalvador@techadventures.net>
 <CAGM2reY8ODmr=u4bsCrdEX3f-c6NkSuKuEcXowRy=SkuMppjiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2reY8ODmr=u4bsCrdEX3f-c6NkSuKuEcXowRy=SkuMppjiw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:34:19AM -0400, Pavel Tatashin wrote:
> On Wed, Jul 18, 2018 at 8:47 AM <osalvador@techadventures.net> wrote:
> >
> > From: Oscar Salvador <osalvador@suse.de>
> >
> > If free_area_init_node gets called from memhotplug code,
> > we do not need to call calculate_node_totalpages(),
> > as the node has no pages.
> 
> I am not positive this is safe. Some pgdat fields in
> calculate_node_totalpages() are set. Even if those fields are always
> set to zeros, pgdat may be reused (i.e. node went offline and later
> came back online), so we might still need to set those fields to
> zeroes.
> 

You are right, I do not know why, but I thought that we were zeroing pgdat struct
before getting in the function.

I will leave that part out.
Since we only should care about deferred pfns during the boot, maybe we can change 
it to something like:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 70fe4c80643f..89fc8f4240ca 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6381,6 +6381,21 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
 static void __ref alloc_node_mem_map(struct pglist_data *pgdat) { }
 #endif /* CONFIG_FLAT_NODE_MEM_MAP */
 
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+static void pgdat_set_deferred_range(pg_data_t *pgdat)
+{
+	/*
+	 * We start only with one section of pages, more pages are added as
+	 * needed until the rest of deferred pages are initialized.
+	 */
+	pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
+						pgdat->node_spanned_pages);
+	pgdat->first_deferred_pfn = ULONG_MAX;
+}
+#else
+static void pgdat_set_deferred_range(pg_data_t *pgdat) {}
+#endif
+
 void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 		unsigned long node_start_pfn, unsigned long *zholes_size)
 {
@@ -6402,20 +6417,14 @@ void __paginginit free_area_init_node(int nid, unsigned long *zones_size,
 #else
 	start_pfn = node_start_pfn;
 #endif
-	calculate_node_totalpages(pgdat, start_pfn, end_pfn,
-				  zones_size, zholes_size);
 
+	calculate_node_totalpages(pgdat, start_pfn, end_pfn,
+					zones_size, zholes_size);
 	alloc_node_mem_map(pgdat);
 
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-	/*
-	 * We start only with one section of pages, more pages are added as
-	 * needed until the rest of deferred pages are initialized.
-	 */
-	pgdat->static_init_pgcnt = min_t(unsigned long, PAGES_PER_SECTION,
-					 pgdat->node_spanned_pages);
-	pgdat->first_deferred_pfn = ULONG_MAX;
-#endif
+	if (system_state == SYSTEM_BOOTING)
+		pgdat_set_deferred_range(pgdat);
+
 	free_area_init_core(pgdat);
 }

Thanks
-- 
Oscar Salvador
SUSE L3
