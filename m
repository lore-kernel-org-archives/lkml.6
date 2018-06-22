Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99096C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5349B23C3A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5349B23C3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932968AbeFVLTg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:19:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39141 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeFVLTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:19:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id b8-v6so902122wro.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FwE2DVSw8f3TVzFlTcffGarktS9bl9OK1DspEEDxH8E=;
        b=eDuS9rJ2yP8rL8rOhpc2dPNBE+9mq+b7xFxwJrFltkyTfk0xExxiTH9EJKhPKQ8TcZ
         qqLCt+ttktl+bQLtW5gTIWLbmapP4WsZtGZRg+/JR1zOSk/LCGJjxxA+EAYaNzExoWPg
         YH+4TFKeDv4uu9m+1tEFu2koI98enCupPF1opGx/SdVZdiPMqHrk3ATyAAQXvcpuiCvB
         TuRZjbf3PLX0Wzo/YJtHa67+9rjEHFcJIa5g4ozJOUqwOuTgLrRMGaZH6WDp2pzR//4c
         s8aKzUzafG7GWE1LRNwwibS/46v7Zr+fNuH/wEJ0MTcFuyWJXMRE2mdgp7iCfUOk3Ss0
         iSqg==
X-Gm-Message-State: APt69E0OYSm9V73pISJ9Nd1HBBr6EslHDIhqk+RuzCiwb6fQ4dLm81IV
        p6kPxEpOK2OTl0nIUUqIxgU=
X-Google-Smtp-Source: ADUXVKLZpn64MaGLgV1JfRJqRMXJRQC7ZW5cPsR/DjGyuctKziehVSZjSG5jM5vRx12McvF/dGYquA==
X-Received: by 2002:adf:b3d4:: with SMTP id x20-v6mr1280718wrd.272.1529666373021;
        Fri, 22 Jun 2018 04:19:33 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id t1-v6sm1723394wmt.40.2018.06.22.04.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 04:19:32 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 83C72123759;
        Fri, 22 Jun 2018 13:19:31 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        Jonathan.Cameron@huawei.com, arbab@linux.vnet.ibm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 1/4] mm/memory_hotplug: Make add_memory_resource use __try_online_node
Date:   Fri, 22 Jun 2018 13:18:36 +0200
Message-Id: <20180622111839.10071-2-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180622111839.10071-1-osalvador@techadventures.net>
References: <20180622111839.10071-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

add_memory_resource() contains code to allocate a new node in case
it is necessary.
Since try_online_node() also hast some code for this purpose,
let us make use of that and remove duplicate code.

This introduces __try_online_node(), which is called by
add_memory_resource() and try_online_node().
__try_online_node() has two new parameters, start_addr of the node,
and if the node should be onlined and registered right away.
This is always wanted if we are calling from do_cpu_up(), but not
when we are calling from memhotplug code.
Nothing changes from the point of view of the users of try_online_node(),
since try_online_node passes start_addr=0 and online_node=true to
__try_online_node().

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/memory_hotplug.c | 67 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7deb49f69e27..504ba120bdfc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1034,8 +1034,10 @@ static pg_data_t __ref *hotadd_new_pgdat(int nid, u64 start)
 	return pgdat;
 }
 
-static void rollback_node_hotadd(int nid, pg_data_t *pgdat)
+static void rollback_node_hotadd(int nid)
 {
+	pg_data_t *pgdat = NODE_DATA(nid);
+
 	arch_refresh_nodedata(nid, NULL);
 	free_percpu(pgdat->per_cpu_nodestats);
 	arch_free_nodedata(pgdat);
@@ -1046,28 +1048,48 @@ static void rollback_node_hotadd(int nid, pg_data_t *pgdat)
 /**
  * try_online_node - online a node if offlined
  * @nid: the node ID
- *
+ * @start: start addr of the node
+ * @set_node_online: Whether we want to online the node
  * called by cpu_up() to online a node without onlined memory.
+ *
+ * Returns:
+ * 1 -> a new node has been allocated
+ * 0 -> the node is already online
+ * -ENOMEM -> the node could not be allocated
  */
-int try_online_node(int nid)
+static int __try_online_node(int nid, u64 start, bool set_node_online)
 {
-	pg_data_t	*pgdat;
-	int	ret;
+	pg_data_t *pgdat;
+	int ret = 1;
 
 	if (node_online(nid))
 		return 0;
 
-	mem_hotplug_begin();
-	pgdat = hotadd_new_pgdat(nid, 0);
+	pgdat = hotadd_new_pgdat(nid, start);
 	if (!pgdat) {
 		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
 		ret = -ENOMEM;
 		goto out;
 	}
-	node_set_online(nid);
-	ret = register_one_node(nid);
-	BUG_ON(ret);
+
+	if (set_node_online) {
+		node_set_online(nid);
+		ret = register_one_node(nid);
+		BUG_ON(ret);
+	}
 out:
+	return ret;
+}
+
+/*
+ * Users of this function always want to online/register the node
+ */
+int try_online_node(int nid)
+{
+	int ret;
+
+	mem_hotplug_begin();
+	ret =  __try_online_node(nid, 0, true);
 	mem_hotplug_done();
 	return ret;
 }
@@ -1099,9 +1121,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 int __ref add_memory_resource(int nid, struct resource *res, bool online)
 {
 	u64 start, size;
-	pg_data_t *pgdat = NULL;
-	bool new_pgdat;
-	bool new_node;
+	bool new_node = false;
 	int ret;
 
 	start = res->start;
@@ -1111,11 +1131,6 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	if (ret)
 		return ret;
 
-	{	/* Stupid hack to suppress address-never-null warning */
-		void *p = NODE_DATA(nid);
-		new_pgdat = !p;
-	}
-
 	mem_hotplug_begin();
 
 	/*
@@ -1126,17 +1141,13 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 	 */
 	memblock_add_node(start, size, nid);
 
-	new_node = !node_online(nid);
-	if (new_node) {
-		pgdat = hotadd_new_pgdat(nid, start);
-		ret = -ENOMEM;
-		if (!pgdat)
-			goto error;
-	}
+	ret = __try_online_node(nid, start, false);
+	if (ret < 0)
+		goto error;
+	new_node = ret;
 
 	/* call arch's memory hotadd */
 	ret = arch_add_memory(nid, start, size, NULL, true);
-
 	if (ret < 0)
 		goto error;
 
@@ -1180,8 +1191,8 @@ int __ref add_memory_resource(int nid, struct resource *res, bool online)
 
 error:
 	/* rollback pgdat allocation and others */
-	if (new_pgdat && pgdat)
-		rollback_node_hotadd(nid, pgdat);
+	if (new_node)
+		rollback_node_hotadd(nid);
 	memblock_remove(start, size);
 
 out:
-- 
2.13.6

