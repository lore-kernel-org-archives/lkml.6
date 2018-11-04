Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AADC0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61B02082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0Iawrr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61B02082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeKDJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 04:30:41 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34856 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeKDJal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 04:30:41 -0500
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so2692777plp.2;
        Sat, 03 Nov 2018 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lyTd4RClOG1ERM4t9WNz5RF4niw9++b2uh1j47Xf6xQ=;
        b=Q0Iawrr6uBFldI8Jw0jUBA5OKzqOlbBPcLvH5bYEUKCGThs5CKwN+bQAwYaZxdDQkl
         Qf1vmyFNJg2YI5PMPb0yuJIg6M5ZRFubAICyfSGWgSIc90EqTS7O3v6Ksa6zmN6Hanr6
         zt74qKo61RzP+ElUiLhX7HhDloc0e7963vRRcG1U0HWSM+vcEAOvu4+YqnObQW2jjesm
         o73UYrF987roZPlSm41Qt3K94noVChunm1B7msp3aluBKC4Zd0vbSkFD8gxR+GPhJKDY
         fh5lddcTRA5rOXzvid9/k4R9r2+bUtM5asg6F1ckyKKigSxH0kx3zfKlwcyU65Toc8Vr
         JbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lyTd4RClOG1ERM4t9WNz5RF4niw9++b2uh1j47Xf6xQ=;
        b=P24mCyo1CrBoalK/u3+ma8ig+QXqOGzEbju/3sQN211PjneKKpiF/30pa9fzTxG5I4
         lWrCQu6Oc+iKCY7ESoRo9J905NivLKtoaIR8h4d1MHUqmklwAXBcpv6qu+sEsj+F5N2Y
         8Bm72JhOX9IfF1SXp7oZFFZXHYu5N3RZzuFc8oe1Mmh9XdeRucA4wW5Wivy3mR7tF8dc
         9RcB410i7bow6bklbwInYA4khOytcXvGCMgIr0vHL4E+nn6jJnrZ+1gFjHZ+Acj7VlJk
         jG6gpBNgeQhDGolWAMfkM/4x+6vvso+C0qSD9JqaVLgV06yhE4+jT4n5UrDreNVMGw9B
         mEZQ==
X-Gm-Message-State: AGRZ1gKM69DPrbgtF2HWQkPS8p/zSJ9M5JJguqItZJ3xQ9qLefW3MRQS
        sqWubJxWJB1rzBcHkt1XfLxX4Af8EC8=
X-Google-Smtp-Source: AJdET5fZlDtPTDWJ6OnTAIE8SETuOuntwuThcTEr0UPhb3CNMrHsWaivTFG5/GuoR3J4qzgdOPCR7w==
X-Received: by 2002:a17:902:4827:: with SMTP id s36-v6mr6989910pld.226.1541290665763;
        Sat, 03 Nov 2018 17:17:45 -0700 (PDT)
Received: from emca-Inspiron-3558 ([2603:3004:c:2200:79c7:ed8e:b2dc:2f5d])
        by smtp.gmail.com with ESMTPSA id m10-v6sm79716933pfg.180.2018.11.03.17.17.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Nov 2018 17:17:45 -0700 (PDT)
From:   Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] e1000e: Change watchdog task to be delayed work
Date:   Sat,  3 Nov 2018 17:17:19 -0700
Message-Id: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This completes a pending TODO to use queue_delayed_work() instead of
schedule_work().

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 16a73bd..a387b21 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -39,6 +39,8 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+struct workqueue_struct *e1000e_workqueue;
+
 static const struct e1000_info *e1000_info_tbl[] = {
 	[board_82571]		= &e1000_82571_info,
 	[board_82572]		= &e1000_82572_info,
@@ -5137,9 +5139,9 @@ static void e1000_watchdog(struct timer_list *t)
 	struct e1000_adapter *adapter = from_timer(adapter, t, watchdog_timer);
 
 	/* Do the rest outside of interrupt context */
-	schedule_work(&adapter->watchdog_task);
+	struct delayed_work *dwork = to_delayed_work(&adapter->watchdog_task);
 
-	/* TODO: make this use queue_delayed_work() */
+	queue_delayed_work(e1000e_workqueue, dwork, 1);
 }
 
 static void e1000_watchdog_task(struct work_struct *work)
@@ -7572,6 +7574,13 @@ static int __init e1000_init_module(void)
 		e1000e_driver_version);
 	pr_info("Copyright(c) 1999 - 2015 Intel Corporation.\n");
 
+	e1000e_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
+					   e1000e_driver_name);
+	if (!e1000e_workqueue) {
+		pr_err("%s: Failed to create workqueue\n", e1000e_driver_name);
+		return -ENOMEM;
+	}
+
 	return pci_register_driver(&e1000_driver);
 }
 module_init(e1000_init_module);
@@ -7585,6 +7594,7 @@ module_init(e1000_init_module);
 static void __exit e1000_exit_module(void)
 {
 	pci_unregister_driver(&e1000_driver);
+	destroy_workqueue(e1000e_workqueue);
 }
 module_exit(e1000_exit_module);
 
-- 
2.7.4

