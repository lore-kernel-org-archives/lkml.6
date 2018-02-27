Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751943AbeB0WGK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:06:10 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43039 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751706AbeB0WGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:06:08 -0500
X-Google-Smtp-Source: AG47ELvPu4K2j62ytg/yZf0Egr3WolRMwXq05Uir4oB4rCRR1w4xePL/cw/53+yAASYykv3dbvRVwA==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 2/2] IB/qib: Move char *qib_sdma_state_names[] and constify while there.
Date: Tue, 27 Feb 2018 19:05:43 -0300
Message-Id: <1519769143-20000-2-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519769143-20000-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1519769143-20000-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This is compile only tested as I have no access to the hw.
This variable was not used in qib_sdma.c but in qib_iba7322.c. Declaring it
there, as static, saves 56 bytes.

add/remove: 0/2 grow/shrink: 0/0 up/down: 0/-144 (-144)
Function                                     old     new   delta
qib_sdma_state_names                          56       -     -56
qib_sdma_event_names                          88       -     -88
Total: Before=2874565, After=2874421, chg -0.01%

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/infiniband/hw/qib/qib.h         |  2 --
 drivers/infiniband/hw/qib/qib_iba7322.c | 10 ++++++++++
 drivers/infiniband/hw/qib/qib_sdma.c    | 10 ----------
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index b709ebd..4607245 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -472,8 +472,6 @@ enum qib_sdma_events {
 	qib_sdma_event_e90_timer_tick,
 };
 
-extern char *qib_sdma_state_names[];
-
 struct sdma_set_state_action {
 	unsigned op_enable:1;
 	unsigned op_intenable:1;
diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index 6265dac..8414ae4 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -463,6 +463,16 @@ static u8 ib_rate_to_delay[IB_RATE_120_GBPS + 1] = {
 	[IB_RATE_40_GBPS] = 1
 };
 
+static const char * const qib_sdma_state_names[] = {
+	[qib_sdma_state_s00_hw_down]          = "s00_HwDown",
+	[qib_sdma_state_s10_hw_start_up_wait] = "s10_HwStartUpWait",
+	[qib_sdma_state_s20_idle]             = "s20_Idle",
+	[qib_sdma_state_s30_sw_clean_up_wait] = "s30_SwCleanUpWait",
+	[qib_sdma_state_s40_hw_clean_up_wait] = "s40_HwCleanUpWait",
+	[qib_sdma_state_s50_hw_halt_wait]     = "s50_HwHaltWait",
+	[qib_sdma_state_s99_running]          = "s99_Running",
+};
+
 #define IBA7322_LINKSPEED_SHIFT SYM_LSB(IBCStatusA_0, LinkSpeedActive)
 #define IBA7322_LINKWIDTH_SHIFT SYM_LSB(IBCStatusA_0, LinkWidthActive)
 
diff --git a/drivers/infiniband/hw/qib/qib_sdma.c b/drivers/infiniband/hw/qib/qib_sdma.c
index 1f2d7a0..d0723d4 100644
--- a/drivers/infiniband/hw/qib/qib_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_sdma.c
@@ -54,16 +54,6 @@ MODULE_PARM_DESC(sdma_descq_cnt, "Number of SDMA descq entries");
 #define SDMA_DESC_COUNT_LSB     16
 #define SDMA_DESC_GEN_LSB       30
 
-char *qib_sdma_state_names[] = {
-	[qib_sdma_state_s00_hw_down]          = "s00_HwDown",
-	[qib_sdma_state_s10_hw_start_up_wait] = "s10_HwStartUpWait",
-	[qib_sdma_state_s20_idle]             = "s20_Idle",
-	[qib_sdma_state_s30_sw_clean_up_wait] = "s30_SwCleanUpWait",
-	[qib_sdma_state_s40_hw_clean_up_wait] = "s40_HwCleanUpWait",
-	[qib_sdma_state_s50_hw_halt_wait]     = "s50_HwHaltWait",
-	[qib_sdma_state_s99_running]          = "s99_Running",
-};
-
 /* declare all statics here rather than keep sorting */
 static int alloc_sdma(struct qib_pportdata *);
 static void sdma_complete(struct kref *);
-- 
2.7.4
