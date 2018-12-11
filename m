Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2BCC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C8520811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C8520811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeLKI5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:57:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:33464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726085AbeLKI5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:57:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F08A5AD90;
        Tue, 11 Dec 2018 08:57:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Dec 2018 09:57:11 +0100
From:   osalvador@suse.de
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, pasha.tatashin@soleen.com,
        dan.j.williams@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, owner-linux-mm@kvack.org
Subject: Re: [PATCH] mm, memory_hotplug: Don't bail out in do_migrate_range
 prematurely
In-Reply-To: <20181211085042.2696-1-osalvador@suse.de>
References: <20181211085042.2696-1-osalvador@suse.de>
Message-ID: <01021c8571af27995acbaaca7a1a68f0@suse.de>
X-Sender: osalvador@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-11 09:50, Oscar Salvador wrote:

> -		} else {
> -			pr_warn("failed to isolate pfn %lx\n", pfn);
> -			dump_page(page, "isolation failed");
> -			put_page(page);
> -			/* Because we don't have big zone->lock. we should
> -			   check this again here. */
> -			if (page_count(page)) {
> -				not_managed++;
> -				ret = -EBUSY;
> -				break;

I forgot that here we should at least leave the put_page().
But leave also the dump_page() and the pr_warn().

--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1394,6 +1394,10 @@ do_migrate_range(unsigned long start_pfn, 
unsigned long end_pfn)
                                 inc_node_page_state(page, 
NR_ISOLATED_ANON +
                                                     
page_is_file_cache(page));

+               } else {
+                       pr_warn("failed to isolate pfn %lx\n", pfn);
+                       dump_page(page, "isolation failed");
+                       put_page(page);
                 }
         }
         if (!list_empty(&source)) {

