Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F74C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC49F214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="OLGVGS0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC49F214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeIZWYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:24:46 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:10420 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727442AbeIZWYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1537978232; x=1569514232;
  h=from:to:cc:subject:date:message-id;
  bh=06OQBzpEygTNfoE2EaoArADsjFWub6dr8IXgjJTaUA0=;
  b=OLGVGS0HDzw4sSoWNOLvNMizTZ5NpR7KoIJ4qPknig+rEMhDPXN+Pu/8
   kCV5IO8Mok15YtnJqPEl7hhZv+NegdGogUD4exuGawZVcLoaqKGHqz2tL
   1JlvsPflo+w3nHJ+xCF1ROT/m4ZdVdLzbsH4BcUUpnkWuoNbvinDacj6c
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EUAABKrqtbhyeV50NaHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUYJzfyiMCV+LUphcgT87CyMLhD6EACE0GAEDAQECAQECAQECEAEBAQo?=
 =?us-ascii?q?LCQgpIwyCNSQBCgRLOzABAQEBAQEBAQEBAQEBAQEaAg1mFmdPbwESIoJ/AYI?=
 =?us-ascii?q?BD5huiVcBAQGCG4QrAYVkBYYUUTyDWoFYP4EShi0CAhiBEIYPAog2CIYzRo1?=
 =?us-ascii?q?QBwKCCASEN4lqAhWPMwGLe4hvAgQCBAUCFIFCgg5wgzyCM4NPhRSFXFEBinq?=
 =?us-ascii?q?CTAEB?=
X-IPAS-Result: =?us-ascii?q?A2EUAABKrqtbhyeV50NaHAEBAQQBAQcEAQGBUYJzfyiMC?=
 =?us-ascii?q?V+LUphcgT87CyMLhD6EACE0GAEDAQECAQECAQECEAEBAQoLCQgpIwyCNSQBC?=
 =?us-ascii?q?gRLOzABAQEBAQEBAQEBAQEBAQEaAg1mFmdPbwESIoJ/AYIBD5huiVcBAQGCG?=
 =?us-ascii?q?4QrAYVkBYYUUTyDWoFYP4EShi0CAhiBEIYPAog2CIYzRo1QBwKCCASEN4lqA?=
 =?us-ascii?q?hWPMwGLe4hvAgQCBAUCFIFCgg5wgzyCM4NPhRSFXFEBinqCTAEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2018 11:10:31 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QG8Uld139047;
        Wed, 26 Sep 2018 12:11:06 -0400
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0a-00154901.pphosted.com with ESMTP id 2mnfyqptpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 12:11:05 -0400
Received: from ausxippc101.us.dell.com ([143.166.85.207])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2018 22:11:02 +0600
X-LoopCount0: from 10.173.37.27
X-IronPort-AV: E=Sophos;i="5.54,306,1534827600"; 
   d="scan'208";a="1140620428"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mika Westerberg <mika.westerberg@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH] platform/x86: intel-wmi-thunderbolt: Add dynamic debugging
Date:   Wed, 26 Sep 2018 11:10:58 -0500
Message-Id: <1537978258-2907-1-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=758 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users have been reporting issues with thunderbolt being turned off
before fully initialized.  This is suspected to be caused by userspace
turning off the Thunderbolt controller using intel-wmi-thunderbolt
prematurely.

Details are available here:
https://bugzilla.kernel.org/show_bug.cgi?id=201227
https://bugzilla.kernel.org/show_bug.cgi?id=199631

Userspace has already made some mitigiations for this situation:
https://github.com/hughsie/fwupd/commit/ef6f1d76983c9b66
https://github.com/hughsie/fwupd/commit/c07ce5b4889a5384

To allow easier debugging of this situation add output that can be turned
on with dynamic debugging to better root cause this problem.

Suggested-by: Mika Westerberg <mika.westerberg@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/intel-wmi-thunderbolt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-wmi-thunderbolt.c b/drivers/platform/x86/intel-wmi-thunderbolt.c
index c2257bd..ce5fbf0 100644
--- a/drivers/platform/x86/intel-wmi-thunderbolt.c
+++ b/drivers/platform/x86/intel-wmi-thunderbolt.c
@@ -38,12 +38,16 @@ static ssize_t force_power_store(struct device *dev,
 	input.length = sizeof(u8);
 	input.pointer = &mode;
 	mode = hex_to_bin(buf[0]);
+	dev_dbg(dev, "force_power: storing %#x\n", mode);
 	if (mode == 0 || mode == 1) {
 		status = wmi_evaluate_method(INTEL_WMI_THUNDERBOLT_GUID, 0, 1,
 					     &input, NULL);
-		if (ACPI_FAILURE(status))
+		if (ACPI_FAILURE(status)) {
+			dev_dbg(dev, "force_power: failed to evaluate ACPI method\n");
 			return -ENODEV;
+		}
 	} else {
+		dev_dbg(dev, "force_power: unsupported mode\n");
 		return -EINVAL;
 	}
 	return count;
-- 
2.7.4

