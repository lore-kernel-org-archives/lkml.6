Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA1AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978D02087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfA3Rs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:48:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729636AbfA3Rs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:48:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UHiYiX021398
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 12:48:58 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qbg8ds7e4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 12:48:57 -0500
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 30 Jan 2019 17:48:56 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 30 Jan 2019 17:48:53 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0UHmogO25296900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 17:48:50 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E705C112064;
        Wed, 30 Jan 2019 17:48:49 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56477112061;
        Wed, 30 Jan 2019 17:48:49 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.ibm.com (unknown [9.80.231.233])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Jan 2019 17:48:49 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        sebott@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        pmorel@linux.ibm.com, pasic@linux.ibm.com, cohuck@redhat.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
Date:   Wed, 30 Jan 2019 12:48:46 -0500
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19013017-0072-0000-0000-000003F23D0C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010505; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01154014; UDB=6.00601699; IPR=6.00934391;
 MB=3.00025357; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-30 17:48:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013017-0073-0000-0000-00004B001366
Message-Id: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current AP bus implementation periodically polls the AP configuration
to detect changes. When the AP configuration is dynamically changed via the
SE or an SCLP instruction, the changes will not be reflected to sysfs until
the next time the AP configuration is polled. The CHSC architecture
provides a Store Event Information (SEI)command to make notification of an
AP configuration change. This patch introduces a handler to process
notification from the CHSC SEI command BY immediately kickING off an AP bus
scan.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
---
 arch/s390/include/asm/ap.h   | 12 ++++++++++++
 drivers/s390/cio/chsc.c      | 12 ++++++++++++
 drivers/s390/cio/chsc.h      |  1 +
 drivers/s390/crypto/ap_bus.c | 12 ++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
index 1a6a7092d942..c778593d509f 100644
--- a/arch/s390/include/asm/ap.h
+++ b/arch/s390/include/asm/ap.h
@@ -360,4 +360,16 @@ static inline struct ap_queue_status ap_dqap(ap_qid_t qid,
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
+#error "no CONFIG_ZCRYPT"
+static void ap_bus_cfg_chg(void){};
+#endif
+
 #endif /* _ASM_S390_AP_H_ */
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index a0baee25134c..dccccc337078 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -586,6 +586,15 @@ static void chsc_process_sei_scm_avail(struct chsc_sei_nt0_area *sei_area)
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
@@ -612,6 +621,9 @@ static void chsc_process_sei_nt0(struct chsc_sei_nt0_area *sei_area)
 	case 2: /* i/o resource accessibility */
 		chsc_process_sei_res_acc(sei_area);
 		break;
+	case 3: /* ap config changed */
+		chsc_process_sei_ap_cfg_chg(sei_area);
+		break;
 	case 7: /* channel-path-availability information */
 		chsc_process_sei_chp_avail(sei_area);
 		break;
diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
index 78aba8d94eec..5651066c46e3 100644
--- a/drivers/s390/cio/chsc.h
+++ b/drivers/s390/cio/chsc.h
@@ -9,6 +9,7 @@
 #include <asm/chsc.h>
 #include <asm/schid.h>
 #include <asm/qdio.h>
+#include <asm/ap.h>
 
 #define CHSC_SDA_OC_MSS   0x2
 
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 48ea0004a56d..94f621783d6b 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -35,6 +35,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/debugfs.h>
 #include <linux/ctype.h>
+#include <asm/crw.h>
 
 #include "ap_bus.h"
 #include "ap_debug.h"
@@ -860,6 +861,17 @@ void ap_bus_force_rescan(void)
 EXPORT_SYMBOL(ap_bus_force_rescan);
 
 /*
+* A config change has happened, Force an ap bus rescan.
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

