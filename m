Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C72BC65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB1D20837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 06:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ajW7ykpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB1D20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLGGQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:16:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45245 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbeLGGQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 01:16:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so1331185plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 22:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfDZBvP3TWcZW6yQdou2wK6yj8xee8CfAn4H8ypmyuM=;
        b=ajW7ykpgmnhWZg6QkL05VwuXLNY8vPub3SVB9mHKkj9yGCbbp3RyvKpsenzdB8F1TU
         oLn1EdtQlrOmf/uaPsNtoOjCZKEAYJPBoRxMOEDlXShDmjeohgQld96dRL+2yqHPwu17
         6eJR8s89WqE/vMoVrnBAkPf/i9bLdV4xvIElw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfDZBvP3TWcZW6yQdou2wK6yj8xee8CfAn4H8ypmyuM=;
        b=bEESyQ6komiNn3KU5JdCbYrggoyvaGIE2cbahv++oYJvNdu5EJAP1hplrmcu470joj
         lMASVnLy+llyWw6Utetn3cxKE4DvjqD2HKagPhy3SAs8cgtN7WM9VXY/cHv8m4cJb9Nl
         cbHCZPsvO9XMU5SBsl+fr6lQBWVXZiGmcY50yvDCKlXqH7Hn+sJg6kMmKWZwwMVmk2CC
         MbvFZyJtHMW2U3bbiYizA+PMP9rhP0dQySsh1dnw9JEG1ZsEp1AIPleVbOmU+mLtUdLf
         9mwOfux0s3kZBCUXo0gHVX3RGpfIfeibC+Ep+RHbpypDm9mZh+7HRze83vbSHv8V4vth
         67CQ==
X-Gm-Message-State: AA+aEWbYLZwZ/54Txf5m9vUISsUbdURl3XPfDzqLP2efnKGOt+yCD0d2
        3bQz68QXSKEkytAr5iRHhKf+9w==
X-Google-Smtp-Source: AFSGD/WjibF7BAGBT7JCP1KlcCBZK1mBbMEJXi1hjBLMmy0oX0rCi/RPt/SNWaq9HMeIq/lHjXLIEw==
X-Received: by 2002:a17:902:7848:: with SMTP id e8mr1006902pln.100.1544163415694;
        Thu, 06 Dec 2018 22:16:55 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id z30-v6sm2995944pfg.41.2018.12.06.22.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 22:16:55 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 3/3] mm: Add /sys/kernel/slab/cache/cache_dma32
Date:   Fri,  7 Dec 2018 14:16:20 +0800
Message-Id: <20181207061620.107881-4-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181207061620.107881-1-drinkcat@chromium.org>
References: <20181207061620.107881-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch in this series adds support for SLAB_CACHE_DMA32
kmem caches. This adds the corresponding
/sys/kernel/slab/cache/cache_dma32 entries, and fixes slabinfo
tool.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

There were different opinions on whether this sysfs entry should
be added, so I'll leave it up to the mm/slub maintainers to decide
whether they want to pick this up, or drop it.

 Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
 mm/slub.c                                   | 11 +++++++++++
 tools/vm/slabinfo.c                         |  7 ++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
index 29601d93a1c2ea..d742c6cfdffbe9 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -106,6 +106,15 @@ Description:
 		are from ZONE_DMA.
 		Available when CONFIG_ZONE_DMA is enabled.
 
+What:		/sys/kernel/slab/cache/cache_dma32
+Date:		December 2018
+KernelVersion:	4.21
+Contact:	Nicolas Boichat <drinkcat@chromium.org>
+Description:
+		The cache_dma32 file is read-only and specifies whether objects
+		are from ZONE_DMA32.
+		Available when CONFIG_ZONE_DMA32 is enabled.
+
 What:		/sys/kernel/slab/cache/cpu_slabs
 Date:		May 2007
 KernelVersion:	2.6.22
diff --git a/mm/slub.c b/mm/slub.c
index 4caadb926838ef..840f3719d9d543 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5104,6 +5104,14 @@ static ssize_t cache_dma_show(struct kmem_cache *s, char *buf)
 SLAB_ATTR_RO(cache_dma);
 #endif
 
+#ifdef CONFIG_ZONE_DMA32
+static ssize_t cache_dma32_show(struct kmem_cache *s, char *buf)
+{
+	return sprintf(buf, "%d\n", !!(s->flags & SLAB_CACHE_DMA32));
+}
+SLAB_ATTR_RO(cache_dma32);
+#endif
+
 static ssize_t usersize_show(struct kmem_cache *s, char *buf)
 {
 	return sprintf(buf, "%u\n", s->usersize);
@@ -5444,6 +5452,9 @@ static struct attribute *slab_attrs[] = {
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
 #endif
+#ifdef CONFIG_ZONE_DMA32
+	&cache_dma32_attr.attr,
+#endif
 #ifdef CONFIG_NUMA
 	&remote_node_defrag_ratio_attr.attr,
 #endif
diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 334b16db0ebbe9..4ee1bf6e498dfa 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -29,7 +29,7 @@ struct slabinfo {
 	char *name;
 	int alias;
 	int refs;
-	int aliases, align, cache_dma, cpu_slabs, destroy_by_rcu;
+	int aliases, align, cache_dma, cache_dma32, cpu_slabs, destroy_by_rcu;
 	unsigned int hwcache_align, object_size, objs_per_slab;
 	unsigned int sanity_checks, slab_size, store_user, trace;
 	int order, poison, reclaim_account, red_zone;
@@ -531,6 +531,8 @@ static void report(struct slabinfo *s)
 		printf("** Hardware cacheline aligned\n");
 	if (s->cache_dma)
 		printf("** Memory is allocated in a special DMA zone\n");
+	if (s->cache_dma32)
+		printf("** Memory is allocated in a special DMA32 zone\n");
 	if (s->destroy_by_rcu)
 		printf("** Slabs are destroyed via RCU\n");
 	if (s->reclaim_account)
@@ -599,6 +601,8 @@ static void slabcache(struct slabinfo *s)
 		*p++ = '*';
 	if (s->cache_dma)
 		*p++ = 'd';
+	if (s->cache_dma32)
+		*p++ = 'D';
 	if (s->hwcache_align)
 		*p++ = 'A';
 	if (s->poison)
@@ -1205,6 +1209,7 @@ static void read_slab_dir(void)
 			slab->aliases = get_obj("aliases");
 			slab->align = get_obj("align");
 			slab->cache_dma = get_obj("cache_dma");
+			slab->cache_dma32 = get_obj("cache_dma32");
 			slab->cpu_slabs = get_obj("cpu_slabs");
 			slab->destroy_by_rcu = get_obj("destroy_by_rcu");
 			slab->hwcache_align = get_obj("hwcache_align");
-- 
2.20.0.rc2.403.gdbc3b29805-goog

