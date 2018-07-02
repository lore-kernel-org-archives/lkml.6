Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944A3C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584B32543E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584B32543E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeGBOjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:39:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752615AbeGBOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:39:02 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62EcbJt130411
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 10:39:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jyjrtgdmh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 10:39:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 15:38:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 15:38:55 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62EcsUg41877660
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 14:38:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80B4411C04A;
        Mon,  2 Jul 2018 15:38:37 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14DE911C052;
        Mon,  2 Jul 2018 15:38:36 +0100 (BST)
Received: from localhost.ibm.com (unknown [9.80.97.108])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 15:38:35 +0100 (BST)
From:   Mimi Zohar <zohar@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 4/8] firmware: add call to LSM hook before firmware sysfs fallback
Date:   Mon,  2 Jul 2018 10:37:59 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18070214-0012-0000-0000-00000285E2ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070214-0013-0000-0000-000020B75ADB
Message-Id: <1530542283-26145-5-git-send-email-zohar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an LSM hook prior to allowing firmware sysfs fallback loading.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

---
Changelog v4:
- call new LSM security_kernel_load_data hook

Changelog v2:
- call security_kernel_read_blob()
- rename the READING_FIRMWARE_FALLBACK kernel_read_file_id enumeration to
READING_FIRMWARE_FALLBACK_SYSFS.

 drivers/base/firmware_loader/fallback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 7f732744f0d3..202324291542 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(enum fw_opt opt_flags)
 
 static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
 {
+	int ret;
+
 	if (fw_fallback_config.ignore_sysfs_fallback) {
 		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
 		return false;
@@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
 	if ((opt_flags & FW_OPT_NOFALLBACK))
 		return false;
 
+	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
+	ret = security_kernel_load_data(LOADING_FIRMWARE);
+	if (ret < 0)
+		return ret;
+
 	return fw_force_sysfs_fallback(opt_flags);
 }
 
-- 
2.7.5

