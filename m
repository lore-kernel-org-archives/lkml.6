Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B3C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494E623FC4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494E623FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeGFL4Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:56:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932776AbeGFL4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:56:20 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66Bs3EU010501
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 07:56:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k262jcrxu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 07:56:20 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
        Fri, 6 Jul 2018 12:56:18 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 12:56:15 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w66BuEgq35127544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 11:56:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 629EF4204C;
        Fri,  6 Jul 2018 14:56:38 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8591E42042;
        Fri,  6 Jul 2018 14:56:36 +0100 (BST)
Received: from oc4502181600.ibm.com (unknown [9.77.202.248])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jul 2018 14:56:36 +0100 (BST)
From:   Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To:     linux@roeck-us.net, mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v4 1/3] powernv:opal-sensor-groups: Add support to enable sensor groups
Date:   Fri,  6 Jul 2018 17:26:04 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1530878166-12589-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1530878166-12589-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070611-0020-0000-0000-000002A3CB5E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070611-0021-0000-0000-000020EFF864
Message-Id: <1530878166-12589-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support to enable/disable a sensor group at runtime. This
can be used to select the sensor groups that needs to be copied to
main memory by OCC. Sensor groups like power, temperature, current,
voltage, frequency, utilization can be enabled/disabled at runtime.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h                |  1 +
 arch/powerpc/include/asm/opal.h                    |  2 ++
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 28 ++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S     |  1 +
 4 files changed, 32 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 3bab299..56a94a1 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -206,6 +206,7 @@
 #define OPAL_NPU_SPA_CLEAR_CACHE		160
 #define OPAL_NPU_TL_SET				161
 #define OPAL_SENSOR_READ_U64			162
+#define OPAL_SENSOR_GROUP_ENABLE		163
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
 #define OPAL_LAST				165
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index e1b2910..fc0550e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -292,6 +292,7 @@ int64_t opal_imc_counters_init(uint32_t type, uint64_t address,
 int opal_get_power_shift_ratio(u32 handle, int token, u32 *psr);
 int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
 int opal_sensor_group_clear(u32 group_hndl, int token);
+int opal_sensor_group_enable(u32 group_hndl, int token, bool enable);
 
 s64 opal_signal_system_reset(s32 cpu);
 s64 opal_quiesce(u64 shutdown_type, s32 cpu);
@@ -326,6 +327,7 @@ extern int opal_async_wait_response_interruptible(uint64_t token,
 		struct opal_msg *msg);
 extern int opal_get_sensor_data(u32 sensor_hndl, u32 *sensor_data);
 extern int opal_get_sensor_data_u64(u32 sensor_hndl, u64 *sensor_data);
+extern int sensor_group_enable(u32 grp_hndl, bool enable);
 
 struct rtc_time;
 extern time64_t opal_get_boot_time(void);
diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 541c9ea..f7d04b6 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -32,6 +32,34 @@ struct sg_attr {
 	struct sg_attr *sgattrs;
 } *sgs;
 
+int sensor_group_enable(u32 handle, bool enable)
+{
+	struct opal_msg msg;
+	int token, ret;
+
+	token = opal_async_get_token_interruptible();
+	if (token < 0)
+		return token;
+
+	ret = opal_sensor_group_enable(handle, token, enable);
+	if (ret == OPAL_ASYNC_COMPLETION) {
+		ret = opal_async_wait_response(token, &msg);
+		if (ret) {
+			pr_devel("Failed to wait for the async response\n");
+			ret = -EIO;
+			goto out;
+		}
+		ret = opal_error_code(opal_get_async_rc(msg));
+	} else {
+		ret = opal_error_code(ret);
+	}
+
+out:
+	opal_async_release_token(token);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(sensor_group_enable);
+
 static ssize_t sg_store(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *buf, size_t count)
 {
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index a8d9b40..8268a1e 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -327,3 +327,4 @@ OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
 OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
+OPAL_CALL(opal_sensor_group_enable,		OPAL_SENSOR_GROUP_ENABLE);
-- 
1.8.3.1

