Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840DAC43143
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431B120866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="fXaqM1dB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431B120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeIJW52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:57:28 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:64654 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbeIJW52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1536602532; x=1568138532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=g7d3HqtijHvSG1qn2XepmMw02he+0ZSar6vu1PYZCmc=;
  b=fXaqM1dBvLD5krD9+xrvN7p9Ks2rFatyZnD5oXBoQImZJYanIG/rlArK
   Ub/P/843zyXQKTSc50kWP/c63rKcwbtvETdxrtGrdJbthPon0PebJtn3R
   NDc41Qc6kUqehbiirXuh5OSKcppHlELKjm/a103G5O5u1ILdk4X95rA7I
   c=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GqAADusJZbhyWd50NcHQEBBQELAYU?=
 =?us-ascii?q?yKIwFX4tAmEGBeguEbAKDeyE0GAECAQECAQECAQECEAEBAQoLCQgpL4I1JAG?=
 =?us-ascii?q?CYAIBAxIVUhA/ElcGARIign+CAppaiVcBAQGBaDOKAYZPhBaBWD+BEo1oAo4?=
 =?us-ascii?q?0jVQHAoIEBI16AhWOcJNmAgQCBAUCFIFCgg5wgzyCM44+UY4WAQE?=
X-IPAS-Result: =?us-ascii?q?A2GqAADusJZbhyWd50NcHQEBBQELAYUyKIwFX4tAmEGBe?=
 =?us-ascii?q?guEbAKDeyE0GAECAQECAQECAQECEAEBAQoLCQgpL4I1JAGCYAIBAxIVUhA/E?=
 =?us-ascii?q?lcGARIign+CAppaiVcBAQGBaDOKAYZPhBaBWD+BEo1oAo40jVQHAoIEBI16A?=
 =?us-ascii?q?hWOcJNmAgQCBAUCFIFCgg5wgzyCM44+UY4WAQE?=
Received: from mx0b-00154901.pphosted.com ([67.231.157.37])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2018 13:02:11 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8AHwmEi107550;
        Mon, 10 Sep 2018 14:02:10 -0400
Received: from esa2.dell-outbound2.iphmx.com (esa2.dell-outbound2.iphmx.com [68.232.153.202])
        by mx0b-00154901.pphosted.com with ESMTP id 2mdsbj1pky-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Sep 2018 14:02:09 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206])
  by esa2.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Sep 2018 00:02:07 +0600
X-LoopCount0: from 10.173.37.27
X-IronPort-AV: E=Sophos;i="5.53,356,1531803600"; 
   d="scan'208";a="1298566027"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: alienware-wmi: Correct a memory leak
Date:   Mon, 10 Sep 2018 13:01:53 -0500
Message-Id: <1536602513-13861-2-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536602513-13861-1-git-send-email-mario.limonciello@dell.com>
References: <1536602513-13861-1-git-send-email-mario.limonciello@dell.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=994 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809100178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An ACPI buffer that was allocated was not being freed after use.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/alienware-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/alienware-wmi.c b/drivers/platform/x86/alienware-wmi.c
index d975462..f10af5c 100644
--- a/drivers/platform/x86/alienware-wmi.c
+++ b/drivers/platform/x86/alienware-wmi.c
@@ -536,6 +536,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
 		if (obj && obj->type == ACPI_TYPE_INTEGER)
 			*out_data = (u32) obj->integer.value;
 	}
+	kfree(output.pointer);
 	return status;
 
 }
-- 
2.7.4

