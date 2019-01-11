Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AD5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8312133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217658;
	bh=HMLI5u/ktZW2z3KrsY/hXkDBXeBy2raIIL8pf70W+FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uhOow2uCIBpyX9uEwrTM75IASTyOKnPLNb4BDgB3UDsy88kPhWaOsD1hoMZO8wzZl
	 KnoSBh/AXHMgkXdyrxQdNAh878Cz6MaglAioCUsr8wNDc+joYoYtrBlKF6M9Hd9B1r
	 aU9k6nq3dsH6DGuAamk+F9SRzDn6ib1bCCDRpiq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbfAKOk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403915AbfAKOkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3522206B6;
        Fri, 11 Jan 2019 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217648;
        bh=HMLI5u/ktZW2z3KrsY/hXkDBXeBy2raIIL8pf70W+FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFqP5oMPGzqWYOJrXQxI8g+kpBmSsoTPsofOKffGG8bdaOAvz9W5d0wyBdysI9Its
         8RrG9UkJzXnDcajFvBNGUKOrQxTO3eut+X8L/aZ40DLxkh2rDxJqEns20wrQiiCRQF
         mwY3o16Xsmp9iNK4qafl0I9zi5UClsvM0aOS/TsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Weijian Huang <huangweijian4@hisilicon.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH 4.19 138/148] drivers/perf: hisi: Fixup one DDRC PMU register offset
Date:   Fri, 11 Jan 2019 15:15:16 +0100
Message-Id: <20190111131119.802583279@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


