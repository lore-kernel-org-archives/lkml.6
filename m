Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30B1C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759AD20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 00:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSAYT0rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 759AD20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeLLA5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:57:15 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39874 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLA5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 19:57:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so14127318edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ExxebZN2RIFYcD98z1I48vzd9kiHJ7sShLcUlTBlmAk=;
        b=SSAYT0rkrcsOMRC/AOBitNo0hPlxk7b1HRC93gQpVf3rjIT1ZYDyGNI4vR38TFH3ic
         3R4MeB3wWbFp69G1N1eDlhFy5BQmNRNrKOnh9V6xOqiJdl5/zksNTqTqJZ25v+YXZjfN
         XcxMiSJlDKj2N5qP3WZsaCgKT7V5APa6bY1cFj2aIXl2VjlK2miT9hcmLJA+N8zVkB7a
         U29yl7P8iDqYVWyrJ4bNGAPGioqCNNCrC3v3yazZ9JEuuHN91zgMyuS5tYqn9/ASMzX8
         JJmbxoaYEphEQK8D7HsC9tkG5xKgtMS1PFN+teUHbuL/bGgnewEhGF9lcTcaub/TV9Ev
         C62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ExxebZN2RIFYcD98z1I48vzd9kiHJ7sShLcUlTBlmAk=;
        b=Ne5jGFiegPtnWxVwQUNiZ+fKw3U/6gN1P/cTMO3MdwFOO2Q/COiXJCdWZTxr+BZEMi
         FXOoKYQSBqVOInXGoF9jue1qQZ6VcRfKHI67Cy2Ji4PiYw1MUS29X/jmPsuEIucVC2FT
         ZNHg1e2SbWbpizebIjrK5sOLiO8lebmN7F4gM17GyAJuqQ8vhSbteKAnTuyjy2VXGptq
         yhuAEIIt+/IbDIbxhocIXVTh9Psi1pdEKEjw6CExIU5gvXNTTpQq6w5qiymfVM85S4oU
         lQBQAGLp2kB4MzlWNzT53tbGlJQwNG7ODg/6g9fRATGZ2MfAyNY+VgTN3a/Vwu4POxRg
         9dWg==
X-Gm-Message-State: AA+aEWaOj6Et31PG/Rwfg1gkw6/6kenKUMRyTTzsts7/ogGztuteA9bU
        OuwW7MVrMAjH52v2+wSW4zM=
X-Google-Smtp-Source: AFSGD/Xfjgu04xgxu9Aa0EeveGQNJeYiOxmNomX2ALcnZWvXiFGmCqtl2XYDf1wNfYsKTeAp1FOsYg==
X-Received: by 2002:a17:906:b297:: with SMTP id q23-v6mr13781354ejz.147.1544576232766;
        Tue, 11 Dec 2018 16:57:12 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v14sm4388926edq.74.2018.12.11.16.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 16:57:12 -0800 (PST)
Date:   Wed, 12 Dec 2018 00:57:11 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, david@redhat.com,
        pasha.tatashin@soleen.com, dan.j.williams@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm, memory_hotplug: Don't bail out in
 do_migrate_range prematurely
Message-ID: <20181212005711.smbujty5nviw6tvd@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181211135312.27034-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211135312.27034-1-osalvador@suse.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 02:53:12PM +0100, Oscar Salvador wrote:
>v1 -> v2:
>        - Keep branch to decrease refcount and print out
>          the failed pfn/page
>        - Modified changelog per Michal's feedback
>        - move put_page() out of the if/else branch
>
>---
>>From f81da873be9a5b7845249d1e62a423f054c487d5 Mon Sep 17 00:00:00 2001
>From: Oscar Salvador <osalvador@suse.com>
>Date: Tue, 11 Dec 2018 11:45:19 +0100
>Subject: [PATCH] mm, memory_hotplug: Don't bail out in do_migrate_range
> prematurely
>
>do_migrate_ranges() takes a memory range and tries to isolate the

I think it is do_migrate_range().

>pages to put them into a list.
>This list will be later on used in migrate_pages() to know
>the pages we need to migrate.
>
>Currently, if we fail to isolate a single page, we put all already
>isolated pages back to their LRU and we bail out from the function.
>This is quite suboptimal, as this will force us to start over again
>because scan_movable_pages will give us the same range.
>If there is no chance that we can isolate that page, we will loop here
>forever.
>
>Issue debugged in [1] has proved that.
>During the debugging of that issue, it was noticed that if
>do_migrate_ranges() fails to isolate a single page, we will
>just discard the work we have done so far and bail out, which means
>that scan_movable_pages() will find again the same set of pages.
>
>Instead, we can just skip the error, keep isolating as much pages
>as possible and then proceed with the call to migrate_pages().
>
>This will allow us to do as much work as possible at once.
>
>[1] https://lkml.org/lkml/2018/12/6/324
>
>Signed-off-by: Oscar Salvador <osalvador@suse.de>
>---
> mm/memory_hotplug.c | 18 ++----------------
> 1 file changed, 2 insertions(+), 16 deletions(-)
>
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 86ab673fc4e3..68e740b1768e 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -1339,7 +1339,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 	unsigned long pfn;
> 	struct page *page;
> 	int move_pages = NR_OFFLINE_AT_ONCE_PAGES;
>-	int not_managed = 0;
> 	int ret = 0;
> 	LIST_HEAD(source);
> 
>@@ -1388,7 +1387,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 		else
> 			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
> 		if (!ret) { /* Success */
>-			put_page(page);
> 			list_add_tail(&page->lru, &source);
> 			move_pages--;
> 			if (!__PageMovable(page))
>@@ -1398,22 +1396,10 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 		} else {
> 			pr_warn("failed to isolate pfn %lx\n", pfn);
> 			dump_page(page, "isolation failed");
>-			put_page(page);
>-			/* Because we don't have big zone->lock. we should
>-			   check this again here. */
>-			if (page_count(page)) {
>-				not_managed++;
>-				ret = -EBUSY;
>-				break;
>-			}
> 		}
>+		put_page(page);
> 	}
> 	if (!list_empty(&source)) {
>-		if (not_managed) {
>-			putback_movable_pages(&source);
>-			goto out;
>-		}
>-
> 		/* Allocate a new page from the nearest neighbor node */
> 		ret = migrate_pages(&source, new_node_page, NULL, 0,
> 					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
>@@ -1426,7 +1412,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> 			putback_movable_pages(&source);
> 		}
> 	}
>-out:
>+
> 	return ret;
> }
> 
>-- 
>2.13.7

-- 
Wei Yang
Help you, Help me
