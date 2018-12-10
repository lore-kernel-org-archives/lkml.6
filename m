Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FA3C65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51F22064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 01:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZaJ/40Oo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51F22064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeLJBPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 20:15:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45740 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeLJBPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 20:15:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so4531872pfd.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 17:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDHo2G57TH3bcKVmO7L4FOO4ZhAAEjCAIwPeVa/m8Iw=;
        b=ZaJ/40Oor6/NtvfhwNrl5WvkSL4Td68cN+kyNER2UhZSruPtb/vPDmtN6HLOaN53Mm
         KIXG+orNtv74XskprxQ9IXcdSJhzQZxByr23Dxyhn28J8FKAfGPD78tGNaaJD+5QUP2+
         +AiJGDzaDjklmFSKfV18RUsZP12/wyZAbdo0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDHo2G57TH3bcKVmO7L4FOO4ZhAAEjCAIwPeVa/m8Iw=;
        b=VSpgfIIHUr25w53W/iVpiN9SCA8H5nrXv7xAB/lAAtyTuoBMh4OZsmuM+gV0Hv1lv4
         PdFPVjoArxmWmFQlpqB9D5jM09RE6Zq+1cDNUtzt5Cv0ajzAq1tRSTN9mMZnpWDpsA3v
         8ix2iUAmK7tudF56vpeKuR6JCQIjf36kE2FK/ENXJuKWKn5HOHiRkJ7c7Xkwib1EusSy
         XZn/SRJVYnE0Pmc4ywcxZ7k/oUKMdMrmjSrUNXZnlPNZwNsetHHDOgwM/5kOnu3bTAIN
         JZ0v4G+3JGWtVl0N4owj6YeSXnHaokQ21ui57ZMYgFL9gQmvwHKX+y0suRx4JLnk/tp8
         gamw==
X-Gm-Message-State: AA+aEWY91Tak1j0Mffe/Ay0Zp2pYaplHzufGwHPlrwQDfV6Kr0qMbYlR
        wwMI0+F4H8nt1U1diANhwlof7Q==
X-Google-Smtp-Source: AFSGD/WiOLiNXT6YfwmG1oS8ywLxJPMqFMoEQpnRb2Y1AqFVl4LuoM2SfrAMmFDhPIekmPqTgXi5iA==
X-Received: by 2002:a63:c051:: with SMTP id z17mr9032972pgi.20.1544404532459;
        Sun, 09 Dec 2018 17:15:32 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:f659:7f17:ea11:4e8e])
        by smtp.gmail.com with ESMTPSA id b10sm16516336pfj.183.2018.12.09.17.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 17:15:31 -0800 (PST)
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
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>,
        hsinyi@chromium.org, stable@vger.kernel.org
Subject: [PATCH v6 3/3] mm: Add /sys/kernel/slab/cache/cache_dma32
Date:   Mon, 10 Dec 2018 09:15:04 +0800
Message-Id: <20181210011504.122604-4-drinkcat@chromium.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181210011504.122604-1-drinkcat@chromium.org>
References: <20181210011504.122604-1-drinkcat@chromium.org>
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

Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

There were different opinions on whether this sysfs entry should
be added, so I'll leave it up to the mm/slub maintainers to decide
whether they want to pick this up, or drop it.

No change since v5.

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

