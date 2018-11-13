Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3727CC4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A5F22511
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A5F22511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732745AbeKNEGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:06:00 -0500
Received: from mga02.intel.com ([134.134.136.20]:59581 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732229AbeKNEF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:05:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 10:06:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="279519696"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2018 10:06:45 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
        arnd@arndb.de, corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, todd.riffel@intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv11 8/8] firmware: add remote status update client support
Date:   Tue, 13 Nov 2018 12:14:06 -0600
Message-Id: <1542132846-24168-9-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542132846-24168-1-git-send-email-richard.gong@linux.intel.com>
References: <1542132846-24168-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Extend Intel Stratix10 service layer to support the second service layer
client, Remote Status Update (RSU).

RSU is used to provide our customers with protection against loading bad
bitstreams onto their devices when those devices are booting from flash.

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v7: this patch is added in patch set version 7
v8: no change
v9: add case for COMMAND_RSU_UPDATE at svc_thread_recv_status_ok() at
    stratix10-svc.c file
    add RSU related definitions at stratix10-smc.h file
v10: s/misc/firmware at commit header
v11: correct a typo in commit message
---
 drivers/firmware/stratix10-svc.c                   | 35 +++++++++++++++-
 include/linux/firmware/intel/stratix10-smc.h       | 47 ++++++++++++++++++++++
 .../linux/firmware/intel/stratix10-svc-client.h    | 20 ++++++++-
 3 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 168f523..81f3182 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -34,7 +34,7 @@
  * timeout is set to 30 seconds (30 * 1000) at Intel Stratix10 SoC.
  */
 #define SVC_NUM_DATA_IN_FIFO			32
-#define SVC_NUM_CHANNEL				1
+#define SVC_NUM_CHANNEL				2
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
 
@@ -271,7 +271,7 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
  * @cb_data: pointer to callback data structure to service client
  * @res: result from SMC or HVC call
  *
- * Send back the correspond status to the service client (FPGA manager etc).
+ * Send back the correspond status to the service clients.
  */
 static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 				      struct stratix10_svc_cb_data *cb_data,
@@ -295,6 +295,9 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RECONFIG_STATUS:
 		cb_data->status = BIT(SVC_STATUS_RECONFIG_COMPLETED);
 		break;
+	case COMMAND_RSU_UPDATE:
+		cb_data->status = BIT(SVC_STATUS_RSU_OK);
+		break;
 	default:
 		pr_warn("it shouldn't happen\n");
 		break;
@@ -373,6 +376,16 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		case COMMAND_RSU_STATUS:
+			a0 = INTEL_SIP_SMC_RSU_STATUS;
+			a1 = 0;
+			a2 = 0;
+			break;
+		case COMMAND_RSU_UPDATE:
+			a0 = INTEL_SIP_SMC_RSU_UPDATE;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -389,6 +402,19 @@ static int svc_normal_to_secure_thread(void *data)
 			 (unsigned int)res.a1, (unsigned int)res.a2);
 		pr_debug(" res.a3=0x%016x\n", (unsigned int)res.a3);
 
+		if (pdata->command == COMMAND_RSU_STATUS) {
+			if (res.a0 == INTEL_SIP_SMC_RSU_ERROR)
+				cbdata->status = BIT(SVC_STATUS_RSU_ERROR);
+			else
+				cbdata->status = BIT(SVC_STATUS_RSU_OK);
+
+			cbdata->kaddr1 = &res;
+			cbdata->kaddr2 = NULL;
+			cbdata->kaddr3 = NULL;
+			pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
+			continue;
+		}
+
 		switch (res.a0) {
 		case INTEL_SIP_SMC_STATUS_OK:
 			svc_thread_recv_status_ok(pdata, cbdata, res);
@@ -941,6 +967,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	chans[0].name = SVC_CLIENT_FPGA;
 	spin_lock_init(&chans[0].lock);
 
+	chans[1].scl = NULL;
+	chans[1].ctrl = controller;
+	chans[1].name = SVC_CLIENT_RSU;
+	spin_lock_init(&chans[1].lock);
+
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
 
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index a109e4c..5be5dab 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -67,6 +67,12 @@
  *
  * INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR:
  * There is error during the FPGA configuration process.
+ *
+ * INTEL_SIP_SMC_REG_ERROR:
+ * There is error during a read or write operation of the protected registers.
+ *
+ * INTEL_SIP_SMC_RSU_ERROR:
+ * There is error during a remote status update.
  */
 #define INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION		0xFFFFFFFF
 #define INTEL_SIP_SMC_STATUS_OK				0x0
@@ -74,6 +80,7 @@
 #define INTEL_SIP_SMC_FPGA_CONFIG_STATUS_REJECTED       0x2
 #define INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR		0x4
 #define INTEL_SIP_SMC_REG_ERROR				0x5
+#define INTEL_SIP_SMC_RSU_ERROR				0x7
 
 /**
  * Request INTEL_SIP_SMC_FPGA_CONFIG_START
@@ -262,4 +269,44 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_REG_UPDATE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_UPDATE)
 
+/*
+ * Request INTEL_SIP_SMC_RSU_STATUS
+ *
+ * Request remote status update boot log, call is synchronous.
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_RSU_STATUS
+ * a1-7 not used
+ *
+ * Return status
+ * a0: Current Image
+ * a1: Last Failing Image
+ * a2: Version | State
+ * a3: Error details | Error location
+ *
+ * Or
+ *
+ * a0: INTEL_SIP_SMC_RSU_ERROR
+ */
+#define INTEL_SIP_SMC_FUNCID_RSU_STATUS 11
+#define INTEL_SIP_SMC_RSU_STATUS \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_STATUS)
+
+/*
+ * Request INTEL_SIP_SMC_RSU_UPDATE
+ *
+ * Request to set the offset of the bitstream to boot after reboot, call
+ * is synchronous.
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_RSU_UPDATE
+ * a1 64bit physical address of the configuration data memory in flash
+ * a2-7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ */
+#define INTEL_SIP_SMC_FUNCID_RSU_UPDATE 12
+#define INTEL_SIP_SMC_RSU_UPDATE \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_UPDATE)
 #endif
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index f2fda7e..e521f17 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -10,8 +10,10 @@
  * Service layer driver supports client names
  *
  * fpga: for FPGA configuration
+ * rsu: for remote status update
  */
 #define SVC_CLIENT_FPGA			"fpga"
+#define SVC_CLIENT_RSU			"rsu"
 
 /**
  * Status of the sent command, in bit number
@@ -36,6 +38,9 @@
  *
  * SVC_COMMAND_STATUS_RECONFIG_ERROR:
  * Error encountered during FPGA configuration.
+ *
+ * SVC_STATUS_RSU_OK:
+ * Secure firmware accepts the request of remote status update (RSU).
  */
 #define SVC_STATUS_RECONFIG_REQUEST_OK		0
 #define SVC_STATUS_RECONFIG_BUFFER_SUBMITTED	1
@@ -43,7 +48,8 @@
 #define SVC_STATUS_RECONFIG_COMPLETED		3
 #define SVC_STATUS_RECONFIG_BUSY		4
 #define SVC_STATUS_RECONFIG_ERROR		5
-
+#define SVC_STATUS_RSU_OK			6
+#define SVC_STATUS_RSU_ERROR			7
 /**
  * Flag bit for COMMAND_RECONFIG
  *
@@ -56,9 +62,11 @@
 /**
  * Timeout settings for service clients:
  * timeout value used in Stratix10 FPGA manager driver.
+ * timeout value used in RSU driver
  */
 #define SVC_RECONFIG_REQUEST_TIMEOUT_MS         100
 #define SVC_RECONFIG_BUFFER_TIMEOUT_MS          240
+#define SVC_RSU_REQUEST_TIMEOUT_MS              300
 
 struct stratix10_svc_chan;
 
@@ -81,13 +89,21 @@ struct stratix10_svc_chan;
  * @COMMAND_RECONFIG_STATUS: check the status of the configuration, return
  * status is SVC_STATUS_RECONFIG_COMPLETED, or  SVC_STATUS_RECONFIG_BUSY, or
  * SVC_STATUS_RECONFIG_ERROR
+ *
+ * @COMMAND_RSU_STATUS: request remote system update boot log, return status
+ * is log data or SVC_STATUS_RSU_ERROR
+ *
+ * @COMMAND_RSU_UPDATE: set the offset of the bitstream to boot after reboot,
+ * return status is SVC_STATUS_RSU_OK or SVC_STATUS_RSU_ERROR
  */
 enum stratix10_svc_command_code {
 	COMMAND_NOOP = 0,
 	COMMAND_RECONFIG,
 	COMMAND_RECONFIG_DATA_SUBMIT,
 	COMMAND_RECONFIG_DATA_CLAIM,
-	COMMAND_RECONFIG_STATUS
+	COMMAND_RECONFIG_STATUS,
+	COMMAND_RSU_STATUS,
+	COMMAND_RSU_UPDATE
 };
 
 /**
-- 
2.7.4

