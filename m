Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeEGKZ5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:25:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752154AbeEGKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:25:51 -0400
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, jdelvare@suse.com, stewart@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 1/3] powernv: opal-sensor: Add support to read 64bit sensor values
Date: Mon,  7 May 2018 15:55:36 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050710-0044-0000-0000-0000054FE1BF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050710-0045-0000-0000-000028911AE8
Message-Id: <1525688738-9185-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to read 64-bit sensor values. This method is
used to read energy sensors and counters which are of type u64.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |  1 +
 arch/powerpc/include/asm/opal.h                |  2 +
 arch/powerpc/platforms/powernv/opal-sensor.c   | 53 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 4 files changed, 57 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index d886a5b..f34d173 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -204,6 +204,7 @@
 #define OPAL_NPU_SPA_SETUP			159
 #define OPAL_NPU_SPA_CLEAR_CACHE		160
 #define OPAL_NPU_TL_SET				161
+#define OPAL_SENSOR_READ_U64			162
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
 #define OPAL_LAST				165
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 03e1a92..3960def 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -201,6 +201,7 @@ int64_t opal_get_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 		uint64_t length);
 int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
+int64_t opal_sensor_read_u64(u32 sensor_hndl, int token, __be64 *sensor_data);
 int64_t opal_handle_hmi(void);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
@@ -323,6 +324,7 @@ extern int opal_message_notifier_unregister(enum opal_msg_type msg_type,
 extern int opal_async_wait_response_interruptible(uint64_t token,
 		struct opal_msg *msg);
 extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
+extern int opal_get_sensor_data_u64(u32 sensor_hndl, u64 *sensor_data);
 
 struct rtc_time;
 extern unsigned long opal_get_boot_time(void);
diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
index 0a7074b..35a5f4b 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -72,6 +72,59 @@ int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data)
 }
 EXPORT_SYMBOL_GPL(opal_get_sensor_data);
 
+int opal_get_sensor_data_u64(u32 sensor_hndl, u64 *sensor_data)
+{
+	int ret, token;
+	struct opal_msg msg;
+	__be64 data;
+
+	if (!opal_check_token(OPAL_SENSOR_READ_U64)) {
+		u32 sdata;
+
+		ret = opal_get_sensor_data(sensor_hndl, &sdata);
+		if (!ret)
+			*sensor_data = sdata;
+		return ret;
+	}
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0)
+		return token;
+
+	ret = opal_sensor_read_u64(sensor_hndl, token, &data);
+	switch (ret) {
+	case OPAL_ASYNC_COMPLETION:
+		ret = opal_async_wait_response(token, &msg);
+		if (ret) {
+			pr_err("%s: Failed to wait for the async response, %d\n",
+			       __func__, ret);
+			goto out_token;
+		}
+
+		ret = opal_error_code(opal_get_async_rc(msg));
+		*sensor_data = be64_to_cpu(data);
+		break;
+
+	case OPAL_SUCCESS:
+		ret = 0;
+		*sensor_data = be64_to_cpu(data);
+		break;
+
+	case OPAL_WRONG_STATE:
+		ret = -EIO;
+		break;
+
+	default:
+		ret = opal_error_code(ret);
+		break;
+	}
+
+out_token:
+	opal_async_release_token(token);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(opal_get_sensor_data_u64);
+
 int __init opal_sensor_init(void)
 {
 	struct platform_device *pdev;
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3da30c2..8482df2 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -325,3 +325,4 @@ OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
 OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
 OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
+OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
-- 
1.8.3.1
