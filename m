Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57DE2183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfBSP5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:57:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:51906 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbfBSP5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:57:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4A6AAE5C;
        Tue, 19 Feb 2019 15:57:36 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] MIPS: SGI-IP27: do xtalk scanning later
Date:   Tue, 19 Feb 2019 16:57:18 +0100
Message-Id: <20190219155728.19163-5-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190219155728.19163-1-tbogendoerfer@suse.de>
References: <20190219155728.19163-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move xtalk scanning to a later boot stage to be able using things like
kmalloc and friends.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 arch/mips/sgi-ip27/ip27-init.c  |  3 ---
 arch/mips/sgi-ip27/ip27-xtalk.c | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-init.c b/arch/mips/sgi-ip27/ip27-init.c
index 83399e578b61..aba985cf07c0 100644
--- a/arch/mips/sgi-ip27/ip27-init.c
+++ b/arch/mips/sgi-ip27/ip27-init.c
@@ -52,8 +52,6 @@ EXPORT_SYMBOL_GPL(sn_cpu_info);
 
 extern void pcibr_setup(cnodeid_t);
 
-extern void xtalk_probe_node(cnodeid_t nid);
-
 static void per_hub_init(cnodeid_t cnode)
 {
 	struct hub_data *hub = hub_data(cnode);
@@ -71,7 +69,6 @@ static void per_hub_init(cnodeid_t cnode)
 	REMOTE_HUB_S(nasid, IIO_ICTO, 0xff);
 
 	hub_rtc_init(cnode);
-	xtalk_probe_node(cnode);
 
 #ifdef CONFIG_REPLICATE_EXHANDLERS
 	/*
diff --git a/arch/mips/sgi-ip27/ip27-xtalk.c b/arch/mips/sgi-ip27/ip27-xtalk.c
index 4fe5678ba74d..ce06aaa115ae 100644
--- a/arch/mips/sgi-ip27/ip27-xtalk.c
+++ b/arch/mips/sgi-ip27/ip27-xtalk.c
@@ -99,7 +99,7 @@ static int xbow_probe(nasid_t nasid)
 	return 0;
 }
 
-void xtalk_probe_node(cnodeid_t nid)
+static void xtalk_probe_node(cnodeid_t nid)
 {
 	volatile u64		hubreg;
 	nasid_t			nasid;
@@ -133,3 +133,14 @@ void xtalk_probe_node(cnodeid_t nid)
 		break;
 	}
 }
+
+static int __init xtalk_init(void)
+{
+	cnodeid_t cnode;
+
+	for_each_online_node(cnode)
+		xtalk_probe_node(cnode);
+
+	return 0;
+}
+arch_initcall(xtalk_init);
-- 
2.13.7

