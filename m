Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9879C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A7B20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A7B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbeICV65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:58:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeICV64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:58:56 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DC2A3A95;
        Mon,  3 Sep 2018 17:37:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.18 091/123] s390/numa: move initial setup of node_to_cpumask_map
Date:   Mon,  3 Sep 2018 18:57:15 +0200
Message-Id: <20180903165723.375178687@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

commit fb7d7518b0d65955f91c7b875c36eae7694c69bd upstream.

The numa_init_early initcall sets the node_to_cpumask_map[0] to the
full cpu_possible_mask. Unfortunately this early_initcall is too late,
the NUMA setup for numa=emu is done even earlier. The order of calls
is numa_setup() -> emu_update_cpu_topology(), then the early_initcalls(),
followed by sched_init_domains().

Starting with git commit 051f3ca02e46432c0965e8948f00c07d8a2f09c0
"sched/topology: Introduce NUMA identity node sched domain"
the incorrect node_to_cpumask_map[0] really screws up the domain
setup and the kernel panics with the follow oops:

Cc: <stable@vger.kernel.org> # v4.15+
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/numa/numa.c |   16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -134,6 +134,8 @@ void __init numa_setup(void)
 {
 	pr_info("NUMA mode: %s\n", mode->name);
 	nodes_clear(node_possible_map);
+	/* Initially attach all possible CPUs to node 0. */
+	cpumask_copy(&node_to_cpumask_map[0], cpu_possible_mask);
 	if (mode->setup)
 		mode->setup();
 	numa_setup_memory();
@@ -141,20 +143,6 @@ void __init numa_setup(void)
 }
 
 /*
- * numa_init_early() - Initialization initcall
- *
- * This runs when only one CPU is online and before the first
- * topology update is called for by the scheduler.
- */
-static int __init numa_init_early(void)
-{
-	/* Attach all possible CPUs to node 0 for now. */
-	cpumask_copy(&node_to_cpumask_map[0], cpu_possible_mask);
-	return 0;
-}
-early_initcall(numa_init_early);
-
-/*
  * numa_init_late() - Initialization initcall
  *
  * Register NUMA nodes.


