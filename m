Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D3A20700
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390912AbfBRRB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:01:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387648AbfBRRB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:01:56 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1IGsbUq186820
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:01:54 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qqxatg8e0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 12:01:53 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 18 Feb 2019 17:01:52 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Feb 2019 17:01:49 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1IH1gx425952462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Feb 2019 17:01:42 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9961C7806A;
        Mon, 18 Feb 2019 17:01:42 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3F2A78068;
        Mon, 18 Feb 2019 17:01:40 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.ibm.com (unknown [9.85.134.111])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Feb 2019 17:01:40 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, pmorel@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, akrowiak@linux.vnet.ibm.com,
        oberpar@linux.ibm.com, sebott@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v3] zcrypt: handle AP Info notification from CHSC SEI command
Date:   Mon, 18 Feb 2019 12:01:35 -0500
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19021817-0016-0000-0000-00000985B5A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010620; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01162912; UDB=6.00607158; IPR=6.00943488;
 MB=3.00025639; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-18 17:01:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021817-0017-0000-0000-000042319FEA
Message-Id: <1550509295-1199-1-git-send-email-akrowiak@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-18_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902180126
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
Reviewed-by: Harald Freudenberger <FREUDE@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/ap.h   | 11 +++++++++++
 drivers/s390/cio/chsc.c      | 13 +++++++++++++
 drivers/s390/crypto/ap_bus.c | 10 ++++++++++
 3 files changed, 34 insertions(+)

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
index 5a699746c357..d0d415954142 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -861,6 +861,16 @@ void ap_bus_force_rescan(void)
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
+
+/*
  * hex2bitmap() - parse hex mask string and set bitmap.
  * Valid strings are "0x012345678" with at least one valid hex number.
  * Rest of the bitmap to the right is padded with 0. No spaces allowed
-- 
2.7.4

