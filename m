Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1244CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2A6218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfBFVbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:31:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbfBFVbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:31:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x16LVTRK009478
        for <linux-kernel@vger.kernel.org>; Wed, 6 Feb 2019 16:31:42 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qg53y7bu5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 16:31:42 -0500
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 6 Feb 2019 21:31:41 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Feb 2019 21:31:38 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x16LVWQn34013322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 21:31:32 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9454F6E04E;
        Wed,  6 Feb 2019 21:31:32 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5112E6E050;
        Wed,  6 Feb 2019 21:31:30 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.ibm.com (unknown [9.85.161.236])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Feb 2019 21:31:30 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, pmorel@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, akrowiak@linux.vnet.ibm.com,
        oberpar@linux.ibm.com, sebott@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2] zcrypt: handle AP Info notification from CHSC SEI command
Date:   Wed,  6 Feb 2019 16:31:26 -0500
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19020621-0036-0000-0000-00000A86769E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010549; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01157294; UDB=6.00603757; IPR=6.00937822;
 MB=3.00025469; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-06 21:31:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020621-0037-0000-0000-00004AA04951
Message-Id: <1549488686-3746-1-git-send-email-akrowiak@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-06_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902060161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current AP bus implementation periodically polls the AP configuration
to detect changes. When the AP configuration is dynamically changed via the
SE or an SCLP instruction, the changes will not be reflected to sysfs until
the next time the AP configuration is polled. The CHSC architecture
provides a Store Event Information (SEI) command to make notification of an
AP configuration change. This patch introduces a handler to process
notification from the CHSC SEI command by immediately kicking off an AP bus
scan-after-event.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Sebastian Ott <sebott@linux.ibm.com>
---
 arch/s390/include/asm/ap.h   | 11 +++++++++++
 drivers/s390/cio/chsc.c      | 13 +++++++++++++
 drivers/s390/crypto/ap_bus.c | 11 +++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index 1a6a7092d942..e94a0a28b5eb 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -360,4 +360,15 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
 	return reg1;
 }
 
+/*
+ * Interface to tell the AP bus code that a configuration
+ * change has happened. The bus code should at least do
+ * an ap bus resource rescan.
+ */
+#if IS_ENABLED(CONFIG_ZCRYPT)
+void ap_bus_cfg_chg(void);
+#else
+static inline void ap_bus_cfg_chg(void){};
+#endif
+
 #endif /* _ASM_S390_AP_H_ */
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index a0baee25134c..eaf4699be2c5 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -24,6 +24,7 @@
 #include <asm/crw.h>
 #include <asm/isc.h>
 #include <asm/ebcdic.h>
+#include <asm/ap.h>
 
 #include "css.h"
 #include "cio.h"
@@ -586,6 +587,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
 			      " failed (rc=%d).\n", ret);
 }
 
+static void chsc_process_sei_ap_cfg_chg(struct chsc_sei_nt0_area *sei_area)
+{
+	CIO_CRW_EVENT(3, "chsc: ap config changed\n");
+	if (sei_area->rs != 5)
+		return;
+
+	ap_bus_cfg_chg();
+}
+
 static void chsc_process_sei_nt2(struct chsc_sei_nt2_area *sei_area)
 {
 	switch (sei_area->cc) {
@@ -612,6 +622,9 @@ static void chsc_process_sei_nt0(struct chsc_sei_nt0_area *sei_area)
 	case 2: /* i/o resource accessibility */
 		chsc_process_sei_res_acc(sei_area);
 		break;
+	case 3: /* ap config changed */
+		chsc_process_sei_ap_cfg_chg(sei_area);
+		break;
 	case 7: /* channel-path-availability information */
 		chsc_process_sei_chp_avail(sei_area);
 		break;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 48ea0004a56d..015cd2ba8afe 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -860,6 +860,17 @@ void ap_bus_force_rescan(void)
 EXPORT_SYMBOL(ap_bus_force_rescan);
 
 /*
+* A config change has happened, force an ap bus rescan.
+*/
+void ap_bus_cfg_chg(void)
+{
+	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
+
+	ap_bus_force_rescan();
+}
+EXPORT_SYMBOL(ap_bus_cfg_chg);
+
+/*
  * hex2bitmap() - parse hex mask string and set bitmap.
  * Valid strings are "0x012345678" with at least one valid hex number.
  * Rest of the bitmap to the right is padded with 0. No spaces allowed
-- 
2.7.4

