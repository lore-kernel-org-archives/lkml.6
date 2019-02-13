Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9183C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731EF222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550050847;
	bh=rJViwTCa2QfYHOt87iFtceKwM5H0Psvenl0BBCQDiFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gM9CnJgycuOSse83ifwF70IVEdFq0DeN0ouDOfLz9ccvj599E/HNJ2ckwKoFVMw76
	 tK9LsZM2Qb2FKH2BX+MFhC6yaA+BfIgY4CYhPDeixx89Mxqdf0p9o0t4XTql0NcNV5
	 ebgb7JBw3jq0fQTeZgjR3JSVU1nq9sMp7I5QxVHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbfBMJkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:40:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37582 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfBMJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:40:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so1687446wrs.4;
        Wed, 13 Feb 2019 01:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KPQIvusfQffcbSiTMJqq6ntVvlDynZgSpryXWkwTGaM=;
        b=qXfQ6UVrO8BCK8zlVywWnE6Hd/PS3oEFU45Xq2dAsHogwEx1UZQY92ZmvsNjMSobbQ
         NX16qEu/SNXFUHg9mNv0Edl0vJr8FN7PCzFhxTU8A9LAiRi4eKtByNpHbCBi4JU195DS
         yvfE9wz+t8u5XgiAgdNMO7PD9vuLw46yLLDch4JTvwtcSEo0+K68d2cKgzHsbpTmpRhD
         M+0q0MYfCh6eUrfaATSUVK4Z1bYAemhVkr6aY0nnwUR1Cw6pHHQWmg/oyHvk9nk9tqSK
         y4V6e2J/FljqYWS30Ti5r2QdCTA5IiIbkuiuxLGGsa2AbiJ2uKmq8PsjyQQHMUEdCyAM
         rORw==
X-Gm-Message-State: AHQUAuaT+k089gai53d3RML4KdLBdZ1WLTas1fVvdC17OoyuEQrU+9cI
        +r8nLYSfpjDFZWUfzLVCs1Q=
X-Google-Smtp-Source: AHgI3IZuh4Vbs+i/l3tBIYxc0NPmfUP4uiVUoKfoZUsXIyJmFEXYRFSSKGguAs+YWrr2sqbfmcUeRQ==
X-Received: by 2002:adf:de83:: with SMTP id w3mr6080776wrl.56.1550050843722;
        Wed, 13 Feb 2019 01:40:43 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-151-205.eurotel.cz. [37.188.151.205])
        by smtp.gmail.com with ESMTPSA id i13sm20879739wrm.86.2019.02.13.01.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 01:40:42 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 2/2] mm: be more verbose about zonelist initialization
Date:   Wed, 13 Feb 2019 10:40:34 +0100
Message-Id: <20190213094034.1341-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212095343.23315-3-mhocko@kernel.org>
References: <20190212095343.23315-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

We have seen several bugs where zonelists have not been initialized
properly and it is not really straightforward to track those bugs down.
One way to help a bit at least is to dump zonelists of each node when
they are (re)initialized.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e097f336126..02c843f0db4f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5234,6 +5234,7 @@ static void build_zonelists(pg_data_t *pgdat)
 	int node, load, nr_nodes = 0;
 	nodemask_t used_mask;
 	int local_node, prev_node;
+	struct zone *zone;
 
 	/* NUMA-aware ordering of nodes */
 	local_node = pgdat->node_id;
@@ -5259,6 +5260,11 @@ static void build_zonelists(pg_data_t *pgdat)
 
 	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
 	build_thisnode_zonelists(pgdat);
+
+	pr_info("node[%d] zonelist: ", pgdat->node_id);
+	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
+		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
+	pr_cont("\n");
 }
 
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
-- 
2.20.1

