Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8D9C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D38021726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548169109;
	bh=ijoguKNKOW+osmpm75miT/X5mA7FLeCrfFSkQYzCLyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wkLuvTqvlmIpFUTDE6m2hsrwuWd1HWbGPoekBBmjJ2hBvGxv03n6v7NxZGuXzr7de
	 udVdO0DWGQBtzYIBNx30umPc+ZDd+bBcZwfj/EAXlDtEA2DkyL8n7J6/yDSV9oMtE/
	 Yzoqt+/h2Pwm1m17UfD1wG90diBZjZ2CqBD0aG4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfAVO61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:58:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728795AbfAVO60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:58:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B92120870;
        Tue, 22 Jan 2019 14:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548169105;
        bh=ijoguKNKOW+osmpm75miT/X5mA7FLeCrfFSkQYzCLyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdMmuXJIUex6E0yvEJjiR1dfB+EgfOXd3I43lGsMd6RYWP3/YoytwvkAfTgr8WNef
         If5ecDa5P1W6ve+sShfCSfp5xI4XOZRZP4/zhe7Z4e4n9za+RVFWUW8FzNaQw0dNf0
         a5D3OSQ1xdGblwJIYvUJbnvhCT7zJqz+tX3Wj9j0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/5] mips: cavium: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 15:57:38 +0100
Message-Id: <20190122145742.11292-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122145742.11292-1-gregkh@linuxfoundation.org>
References: <20190122145742.11292-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/cavium-octeon/oct_ilm.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/arch/mips/cavium-octeon/oct_ilm.c b/arch/mips/cavium-octeon/oct_ilm.c
index 2d68a39f1443..0b6ec4c17896 100644
--- a/arch/mips/cavium-octeon/oct_ilm.c
+++ b/arch/mips/cavium-octeon/oct_ilm.c
@@ -63,31 +63,12 @@ static int reset_statistics(void *data, u64 value)
 
 DEFINE_SIMPLE_ATTRIBUTE(reset_statistics_ops, NULL, reset_statistics, "%llu\n");
 
-static int init_debufs(void)
+static void init_debugfs(void)
 {
-	struct dentry *show_dentry;
 	dir = debugfs_create_dir("oct_ilm", 0);
-	if (!dir) {
-		pr_err("oct_ilm: failed to create debugfs entry oct_ilm\n");
-		return -1;
-	}
-
-	show_dentry = debugfs_create_file("statistics", 0222, dir, NULL,
-					  &oct_ilm_ops);
-	if (!show_dentry) {
-		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/statistics\n");
-		return -1;
-	}
-
-	show_dentry = debugfs_create_file("reset", 0222, dir, NULL,
-					  &reset_statistics_ops);
-	if (!show_dentry) {
-		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/reset\n");
-		return -1;
-	}
-
+	debugfs_create_file("statistics", 0222, dir, NULL, &oct_ilm_ops);
+	debugfs_create_file("reset", 0222, dir, NULL, &reset_statistics_ops);
 	return 0;
-
 }
 
 static void init_latency_info(struct latency_info *li, int startup)
@@ -169,11 +150,7 @@ static __init int oct_ilm_module_init(void)
 	int rc;
 	int irq = OCTEON_IRQ_TIMER0 + TIMER_NUM;
 
-	rc = init_debufs();
-	if (rc) {
-		WARN(1, "Could not create debugfs entries");
-		return rc;
-	}
+	init_debugfs();
 
 	rc = request_irq(irq, cvm_oct_ciu_timer_interrupt, IRQF_NO_THREAD,
 			 "oct_ilm", 0);
-- 
2.20.1

