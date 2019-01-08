Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9BDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA09720827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977997;
	bh=xlGWI9SRKKsZJQ5R6HUmX+gD3P/8XZd4y2US7siRE80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xcNWhaFGNaUXC8Lz/lrsjrkg4GB4nV3wNgssR9gd2vOI/lujmuGfdBoLRnDrwzkLI
	 tgBvkt4vwEE8CV5VGJW4mmPFRucQRziQjytwhol4mn6yyudgxTrycNXnsauNKAT4Ls
	 AVcyl4mSTAmkn7nXQUzeP4cP/k4oBK99CJQUX5lU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbfAHUGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:06:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbfAHT2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EA5218B0;
        Tue,  8 Jan 2019 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975684;
        bh=xlGWI9SRKKsZJQ5R6HUmX+gD3P/8XZd4y2US7siRE80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znrGw7FcUvDlQSGm4M9s06H9QzJcPhea1CQw6ij4n+MgqlcI19l2W/qE3+f4PPUpI
         r51zSnMAE65G4a+JGFrK5M/n5g60l9K25GpHgoOFBUsI/LCu0lBb/8jg6Qvk0p66OM
         VRYc7Cy9vfX1AmnuhCshmUhJ08Bxfw89MyrbR1ac=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 052/117] coresight: tmc: Fix bad register address for CLAIM
Date:   Tue,  8 Jan 2019 14:25:20 -0500
Message-Id: <20190108192628.121270-52-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

[ Upstream commit 323ed1e0f60b35df55763356d4973a18d5eaea15 ]

Commit 4d3ebd3658d8 ("coreisght: tmc: Claim device before use") uses
CLAIM tag to validate if the device is available, it needs to pass
the device base address to access related registers.

In the function tmc_etb_disable_hw() it wrongly passes the driver data
pointer as register base address, thus it's easily to produce the kernel
warning info like below:

[   83.579898] WARNING: CPU: 4 PID: 2970 at drivers/hwtracing/coresight/coresight.c:207 coresight_disclaim_device_unlocked+0x44/0x80
[   83.591448] Modules linked in:
[   83.594485] CPU: 4 PID: 2970 Comm: uname Not tainted 4.19.0-rc6-00417-g721b509 #110
[   83.602067] Hardware name: ARM Juno development board (r2) (DT)
[   83.607932] pstate: 80000085 (Nzcv daIf -PAN -UAO)
[   83.612681] pc : coresight_disclaim_device_unlocked+0x44/0x80
[   83.618375] lr : coresight_disclaim_device_unlocked+0x44/0x80
[   83.624064] sp : ffff00000fe3ba20
[   83.627347] x29: ffff00000fe3ba20 x28: ffff80002d430dc0
[   83.632618] x27: ffff800033177c00 x26: ffff80002eb44480
[   83.637889] x25: 0000000000000001 x24: ffff800033c72600
[   83.643160] x23: ffff0000099b11f8 x22: ffff0000099b11c8
[   83.648430] x21: 0000000000000002 x20: ffff800033a90418
[   83.653701] x19: ffff0000099b11c8 x18: 0000000000000000
[   83.658971] x17: 0000000000000000 x16: 0000000000000000
[   83.664241] x15: 0000000000000000 x14: 0000000000000000
[   83.669511] x13: 0000000000000000 x12: 0000000000000000
[   83.674782] x11: 0000000000000000 x10: 0000000000000000
[   83.680052] x9 : 0000000000000000 x8 : 0000000000000001
[   83.685322] x7 : 0000000000010000 x6 : ffff800033ebab18
[   83.690593] x5 : ffff800033ebab18 x4 : ffff800033e6c698
[   83.695862] x3 : 0000000000000001 x2 : 0000000000000000
[   83.701133] x1 : 0000000000000000 x0 : 0000000000000001
[   83.706404] Call trace:
[   83.708830]  coresight_disclaim_device_unlocked+0x44/0x80
[   83.714180]  coresight_disclaim_device+0x34/0x48
[   83.718756]  tmc_disable_etf_sink+0xc4/0xf0
[   83.722902]  coresight_disable_path_from+0xc8/0x240
[   83.727735]  coresight_disable_path+0x24/0x30
[   83.732053]  etm_event_stop+0x130/0x170
[   83.735854]  etm_event_del+0x24/0x30
[   83.739399]  event_sched_out.isra.51+0xcc/0x1e8
[   83.743887]  group_sched_out.part.53+0x44/0xb0
[   83.748291]  ctx_sched_out+0x298/0x2b8
[   83.752005]  task_ctx_sched_out+0x74/0xa8
[   83.755980]  perf_event_exit_task+0x140/0x418
[   83.760298]  do_exit+0x3f4/0xcf0
[   83.763497]  do_group_exit+0x5c/0xc0
[   83.767041]  __arm64_sys_exit_group+0x24/0x28
[   83.771359]  el0_svc_common+0x110/0x178
[   83.775160]  el0_svc_handler+0x94/0xe8
[   83.778875]  el0_svc+0x8/0xc
[   83.781728] ---[ end trace 02d8d8eac46db9e5 ]---

This patch is to fix this bug by using 'drvdata->base' as the
register base address for CLAIM related operation.

Fixes: 4d3ebd3658d8 ("coreisght: tmc: Claim device before use")
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 53fc83b72a49..5864ac55e275 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -86,7 +86,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
-	coresight_disclaim_device(drvdata);
+	coresight_disclaim_device(drvdata->base);
 	__tmc_etb_disable_hw(drvdata);
 }
 
-- 
2.19.1

