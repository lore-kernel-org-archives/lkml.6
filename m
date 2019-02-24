Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF658C00319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D592086D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsZNpX90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfBXMfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 07:35:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42931 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfBXMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 07:35:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so3191903pgl.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 04:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VUSACWx8owSCA/d69ivl0fhPuKN1EhNSteFOcIuEGZ0=;
        b=lsZNpX90ShPlWQ2zhfCCGLs4i3irzO/qGpdGtyiAVLlwhyAM9bJBwH1VpoF5hjkhUd
         8EUw47B2VpHPlhkSiDW/2Aqy47CseX4XJEnfPB8suhAPn4E9PESpAclo8hmmoUf1/T1g
         PrwAKcR6kJXWz4z7/qi+m31N9ImyTGhf5MdYqOZGPpeRwD/M0cvl+lZm7cLWMOZUwhdw
         5miumxFV+4Y0Zwjui1NQfNcIczbjE0QoMSvg8smGI+VZ6rCei0hywyQi4dC+iLKOn7da
         vVtpQ1jmIK8mo6jkDkO0Gf9ToiAbrWv9SUSRbzXqbxZuWck6rc+HUwYfsGRG2RnYWdQe
         +rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VUSACWx8owSCA/d69ivl0fhPuKN1EhNSteFOcIuEGZ0=;
        b=mOxj9dACJQsEE1nq4cD82BK98WUeN0SjfGtj21TAkRzkt5r8c6wboRaRNrvmQQWo35
         KlzY1lRw2EhsPM3v6lC6yeVwkRXUQintGorSGSOwgeTUFNTa1oebeedmPfa7YipwLP2J
         AMesnMc1Et2PqNgYE1MW5Oo1jTy93RfJiI4JtufyoqjQ43682UzbMlPAWH+qxFHBA/Nh
         fblBFKgm635HiD9WLJCCdHXxWww1zjY9Xof8sEJhB5+tb4IvXXOrFao8pD7l9VX+tiIw
         IYuGJKDsAJs/8RBfJyZ4N2j/seUprU6yzQkpaFK3WHP9IAh1gZkyjXEWVqMAUmvObRgn
         wXkA==
X-Gm-Message-State: AHQUAuYAuUuxCUdkQ74ns/ERNMLLZj/p5vOQL/nGr6QJjv3uNHkXYipG
        pVvGEhla6MvLQ8gWh7DoUQ==
X-Google-Smtp-Source: AHgI3IZ+KhDfYa4kZE1/ENHjM5rMoFfQUz/8SRp5zyphLnw8+HWtaHY6Dz/ZQLwOtrZah70pozY1yQ==
X-Received: by 2002:a62:b508:: with SMTP id y8mr13857223pfe.140.1551011699044;
        Sun, 24 Feb 2019 04:34:59 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v6sm9524634pgb.2.2019.02.24.04.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 04:34:58 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org, linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Vacek <neelx@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] x86/numa: concentrate the code of setting cpu to node map
Date:   Sun, 24 Feb 2019 20:34:07 +0800
Message-Id: <1551011649-30103-5-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
References: <1551011649-30103-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both numa_init_array() and init_cpu_to_node() aim at setting up the cpu to
node map, so combining them. And the coming patch will set up node to
cpumask map in the combined function.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Vlastimil Babka <vbabka@suse.cz>
CC: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mel Gorman <mgorman@suse.de>
CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Andi Kleen <ak@linux.intel.com>
CC: Petr Tesarik <ptesarik@suse.cz>
CC: Michal Hocko <mhocko@suse.com>
CC: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Daniel Vacek <neelx@redhat.com>
CC: linux-kernel@vger.kernel.org
---
 arch/x86/mm/numa.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index bfe6732..c8dd7af 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -599,30 +599,6 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 	return 0;
 }
 
-#ifdef CONFIG_NUMA
-/*
- * There are unfortunately some poorly designed mainboards around that
- * only connect memory to a single CPU. This breaks the 1:1 cpu->node
- * mapping. To avoid this fill in the mapping for all possible CPUs,
- * as the number of CPUs is not known yet. We round robin the existing
- * nodes.
- */
-static void __init numa_init_array(void)
-{
-	int rr, i;
-
-	rr = first_node(node_online_map);
-	for (i = 0; i < nr_cpu_ids; i++) {
-		if (early_cpu_to_node(i) != NUMA_NO_NODE)
-			continue;
-		numa_set_node(i, rr);
-		rr = next_node_in(rr, node_online_map);
-	}
-}
-#else
-static void __init numa_init_array(void) {}
-#endif
-
 static int __init numa_init(int (*init_func)(void))
 {
 	int i;
@@ -675,7 +651,6 @@ static int __init numa_init(int (*init_func)(void))
 		if (!node_online(nid))
 			numa_clear_node(i);
 	}
-	numa_init_array();
 
 	return 0;
 }
@@ -758,14 +733,26 @@ void __init init_cpu_to_node(void)
 {
 	int cpu;
 	u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);
+	int rr;
 
 	BUG_ON(cpu_to_apicid == NULL);
+	rr = first_node(node_online_map);
 
 	for_each_possible_cpu(cpu) {
 		int node = numa_cpu_node(cpu);
 
-		if (node == NUMA_NO_NODE)
+		/*
+		 * There are unfortunately some poorly designed mainboards
+		 * around that only connect memory to a single CPU. This
+		 * breaks the 1:1 cpu->node mapping. To avoid this fill in
+		 * the mapping for all possible CPUs, as the number of CPUs
+		 * is not known yet. We round robin the existing nodes.
+		 */
+		if (node == NUMA_NO_NODE) {
+			numa_set_node(cpu, rr);
+			rr = next_node_in(rr, node_online_map);
 			continue;
+		}
 
 		if (!node_online(node))
 			init_memory_less_node(node);
-- 
2.7.4

