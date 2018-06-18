Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F3C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D5B20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D5B20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936326AbeFRIYx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:24:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936245AbeFRIYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:24:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93422C5C;
        Mon, 18 Jun 2018 08:24:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 204/279] powerpc/pseries: Fix CONFIG_NUMA=n build
Date:   Mon, 18 Jun 2018 10:13:09 +0200
Message-Id: <20180618080617.337523186@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 6c0a8f6b5a45ac892a763b6299bd3c5324fc5e02 ]

The build is failing with CONFIG_NUMA=n and some compiler versions:

  arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_online_cpu':
  hotplug-cpu.c:(.text+0x12c): undefined reference to `timed_topology_update'
  arch/powerpc/platforms/pseries/hotplug-cpu.o: In function `dlpar_cpu_remove':
  hotplug-cpu.c:(.text+0x400): undefined reference to `timed_topology_update'

Fix it by moving the empty version of timed_topology_update() into the
existing #ifdef block, which has the right guard of SPLPAR && NUMA.

Fixes: cee5405da402 ("powerpc/hotplug: Improve responsiveness of hotplug change")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/include/asm/topology.h |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -91,6 +91,7 @@ extern int start_topology_update(void);
 extern int stop_topology_update(void);
 extern int prrn_is_enabled(void);
 extern int find_and_online_cpu_nid(int cpu);
+extern int timed_topology_update(int nsecs);
 #else
 static inline int start_topology_update(void)
 {
@@ -108,16 +109,12 @@ static inline int find_and_online_cpu_ni
 {
 	return 0;
 }
+static inline int timed_topology_update(int nsecs)
+{
+	return 0;
+}
 #endif /* CONFIG_NUMA && CONFIG_PPC_SPLPAR */
 
-#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_NEED_MULTIPLE_NODES)
-#if defined(CONFIG_PPC_SPLPAR)
-extern int timed_topology_update(int nsecs);
-#else
-#define	timed_topology_update(nsecs)
-#endif /* CONFIG_PPC_SPLPAR */
-#endif /* CONFIG_HOTPLUG_CPU || CONFIG_NEED_MULTIPLE_NODES */
-
 #include <asm-generic/topology.h>
 
 #ifdef CONFIG_SMP


