Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7164C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62003204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bVvk9bbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62003204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeJBJmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:42:43 -0400
Received: from m12-14.163.com ([220.181.12.14]:44154 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeJBJmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=/JQZIX+zvmfNbG4mUX
        W50jwQ83j36qjnhRJIjM3rb9g=; b=bVvk9bbEqh0cUX/RyEv9IT8OR4aDlyEfGz
        ztqAn4f93ClmQmCcEQrCwnV5uvWO5+Q5QJqH6KThc18M63BF9YibJjvWr9iDo2lD
        zXme01nYxtx98295nLbJ1LirndG/A7SZsbd9QNox5ONHVPHIT0QHLB5kQzsyXBKg
        H7Q/WnzgM=
Received: from localhost (unknown [183.156.114.194])
        by smtp10 (Coremail) with SMTP id DsCowACHm7FJ37JbxXe7Sw--.17030S5;
        Tue, 02 Oct 2018 11:00:27 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jun qian <hangdianqj@163.com>, Barry song <21cnbao@gmail.com>
Subject: [PATCH] mm:slab: Adjust the print format for the slabinfo
Date:   Mon,  1 Oct 2018 19:59:39 -0700
Message-Id: <20181002025939.115804-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowACHm7FJ37JbxXe7Sw--.17030S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWxGw1ruw47Ar4UArW7CFg_yoW8tF4Upw
        43twnrX3yxJryjgrZIva4vqryYgFn5AFWUZr97tw1vvw1UCwn7W34j9r1xZFZxtFySyana
        vw4v9F13WFWkX3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlPfQUUUUU=
X-Originating-IP: [183.156.114.194]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/xtbBSQvTR1aDzWPJewAAsf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header and the corresponding information is not aligned,
adjust the printing format helps us to understand the slabinfo better.

Signed-off-by: jun qian <hangdianqj@163.com>
Cc: Barry song <21cnbao@gmail.com>
---
 mm/slab_common.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index fea3376f9816..07a324cbbfb6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1263,9 +1263,13 @@ static void print_slabinfo_header(struct seq_file *m)
 #else
 	seq_puts(m, "slabinfo - version: 2.1\n");
 #endif
-	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
-	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
-	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
+	seq_printf(m, "%-22s %-14s %-11s %-10s %-13s %-14s",
+		  "# name", "<active_objs>", "<num_objs>", "<objsize>",
+		  "<objperslab>", "<pagesperslab>");
+	seq_printf(m, " : %-9s %-8s %-13s %-14s",
+		  "tunables", "<limit>", "<batchcount>", "<sharedfactor>");
+	seq_printf(m, " : %-9s %-15s %-12s %-16s",
+		  "slabdata", "<active_slabs>", "<num_slabs>", "<sharedavail>");
 #ifdef CONFIG_DEBUG_SLAB
 	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> <alienoverflow>");
 	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
@@ -1319,13 +1323,13 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
 
 	memcg_accumulate_slabinfo(s, &sinfo);
 
-	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
+	seq_printf(m, "%-22s %-14lu %-11lu %-10u %-13u %-14d",
 		   cache_name(s), sinfo.active_objs, sinfo.num_objs, s->size,
 		   sinfo.objects_per_slab, (1 << sinfo.cache_order));
 
-	seq_printf(m, " : tunables %4u %4u %4u",
+	seq_printf(m, " : %-9s %-8u %-13u %-14u", "tunables",
 		   sinfo.limit, sinfo.batchcount, sinfo.shared);
-	seq_printf(m, " : slabdata %6lu %6lu %6lu",
+	seq_printf(m, " : %-9s %-15lu %-12lu %-16lu", "slabdata",
 		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail);
 	slabinfo_show_stats(m, s);
 	seq_putc(m, '\n');
-- 
2.17.1



