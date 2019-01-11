Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDF3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BA121841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217826;
	bh=AOjTSP8+oOzFy3AyeXoURySFFCpvCzXd26iIUN+Ua3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JOx5WkQzKNHnJEBLlA2HHk1bLxat+gWP29ax4+vYYyVOVB6EW0116A/nTD4L7t8sN
	 si3xGUeqr85JCbV9okialv9zu/etttPZ1eSxcP1JWtCl40uebfPwec+ziRKUurN3az
	 5syZ3mZ/Bb71eUgiFfXvruxDNJt3KBgyjUV9J12k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404457AbfAKOnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbfAKOnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A00A20872;
        Fri, 11 Jan 2019 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217823;
        bh=AOjTSP8+oOzFy3AyeXoURySFFCpvCzXd26iIUN+Ua3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JkeHizBPhBIiuSoj+QzN/ZQsk8XPnJQyCsqUl57xHuJGwJByGM9I4W+pvo2EFam+f
         lnat5ojWmHWnx5EplgFSIexefh4pLNzPH6ePy7lVwUc3BNwE0IvVEegljMuQaf9we3
         sKiXUbbQdj9QJtnJBikMRu3mmq1zAlF7Gxs52EUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Weijian Huang <huangweijian4@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH 4.20 54/65] drivers/perf: hisi: Fixup one DDRC PMU register offset
Date:   Fri, 11 Jan 2019 15:15:40 +0100
Message-Id: <20190111131103.476392289@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shaokun Zhang <zhangshaokun@hisilicon.com>

commit eb4f5213251833567570df1a09803f895653274d upstream.

For DDRC PMU, each PMU counter is fixed-purpose. There is a mismatch
between perf list and driver definition on rw_chg event.
# perf list | grep chg
  hisi_sccl1_ddrc0/rnk_chg/                          [Kernel PMU event]
  hisi_sccl1_ddrc0/rw_chg/                           [Kernel PMU event]
But the register offset of rw_chg event is not defined in the driver,
meanwhile bnk_chg register offset is mis-defined, let's fixup it.

Fixes: 904dcf03f086 ("perf: hisi: Add support for HiSilicon SoC DDRC PMU driver")
Cc: stable@vger.kernel.org
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reported-by: Weijian Huang <huangweijian4@hisilicon.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -30,8 +30,8 @@
 #define DDRC_FLUX_RCMD          0x38c
 #define DDRC_PRE_CMD            0x3c0
 #define DDRC_ACT_CMD            0x3c4
-#define DDRC_BNK_CHG            0x3c8
 #define DDRC_RNK_CHG            0x3cc
+#define DDRC_RW_CHG             0x3d0
 #define DDRC_EVENT_CTRL         0x6C0
 #define DDRC_INT_MASK		0x6c8
 #define DDRC_INT_STATUS		0x6cc
@@ -51,7 +51,7 @@
 
 static const u32 ddrc_reg_off[] = {
 	DDRC_FLUX_WR, DDRC_FLUX_RD, DDRC_FLUX_WCMD, DDRC_FLUX_RCMD,
-	DDRC_PRE_CMD, DDRC_ACT_CMD, DDRC_BNK_CHG, DDRC_RNK_CHG
+	DDRC_PRE_CMD, DDRC_ACT_CMD, DDRC_RNK_CHG, DDRC_RW_CHG
 };
 
 /*


