Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E8DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769D521479
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ai+c9gRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbeL0Du4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 22:50:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeL0Du4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 22:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=v1zbUXRIIsFVyLyoH8wsxE9Pkh8xRmMrZj/dFo/4uZ4=; b=ai+c9gRcDI2SgEhm3PYCn/e9Y
        u/mzBJmBqasZqbepYIMYb64ieCk0Ek0yhLRkfoHPI6lk7xA3j/pOc4jXn8RCG03TXhtx93x6Q2yES
        Hd+TOwKzENG7jSJBh2Yv8O+cmg9L5roipFu3JH8miOYsiII9jnJtk6api8Ej3m791z5cTIt0ZnDYq
        U59eYSCjgy/bgs3V7MT/9A2Prc6/05VCo3DeU8jCL/ExGxnenLN0WfZSNwIA5amdiHqcdH4IzNidm
        GVIYxLz8IUyc+3/8GEHxsW1NsZHySXk97XfgsY17kkoU+br/aaOS67FcbYqK99MkIThkR9+iS/nAn
        K4xNuxoeQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcMgn-0001jS-HY; Thu, 27 Dec 2018 03:50:29 +0000
Date:   Wed, 26 Dec 2018 19:50:29 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joe Perches <joe@perches.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] mm: compaction.c: Propagate return value upstream
Message-ID: <20181227035029.GE20878@bombadil.infradead.org>
References: <20181226194257.11038-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181226194257.11038-1-pakki001@umn.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 01:42:56PM -0600, Aditya Pakki wrote:
> In sysctl_extfrag_handler(), proc_dointvec_minmax() can return an
> error. The fix propagates the error upstream in case of failure.

Why not just ...

Mel, Randy?  You seem to have been the prime instigators on this.

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 68250a57aace..70d0256edd31 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -88,8 +88,6 @@ extern int sysctl_compact_memory;
 extern int sysctl_compaction_handler(struct ctl_table *table, int write,
 			void __user *buffer, size_t *length, loff_t *ppos);
 extern int sysctl_extfrag_threshold;
-extern int sysctl_extfrag_handler(struct ctl_table *table, int write,
-			void __user *buffer, size_t *length, loff_t *ppos);
 extern int sysctl_compact_unevictable_allowed;
 
 extern int fragmentation_index(struct zone *zone, unsigned int order);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5fc724e4e454..e9c69247fc29 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1439,7 +1439,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &sysctl_extfrag_threshold,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= sysctl_extfrag_handler,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &min_extfrag_threshold,
 		.extra2		= &max_extfrag_threshold,
 	},
diff --git a/mm/compaction.c b/mm/compaction.c
index 7c607479de4a..80b941d9b6e7 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1876,14 +1876,6 @@ int sysctl_compaction_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-int sysctl_extfrag_handler(struct ctl_table *table, int write,
-			void __user *buffer, size_t *length, loff_t *ppos)
-{
-	proc_dointvec_minmax(table, write, buffer, length, ppos);
-
-	return 0;
-}
-
 #if defined(CONFIG_SYSFS) && defined(CONFIG_NUMA)
 static ssize_t sysfs_compact_node(struct device *dev,
 			struct device_attribute *attr,
