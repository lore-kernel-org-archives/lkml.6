Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D65DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503AD2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:24:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503AD2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbeJAUC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:02:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59885 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729289AbeJAUC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:02:27 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w91DOCIP031562;
        Mon, 1 Oct 2018 15:24:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2msxh6bevr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Oct 2018 15:24:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A939634;
        Mon,  1 Oct 2018 13:24:11 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 76F0946B0;
        Mon,  1 Oct 2018 13:24:11 +0000 (GMT)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Oct 2018 15:24:10
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>, <gottfried.haider@gmail.com>
CC:     <stefan.wahren@i2se.com>, <hsweeten@visionengravers.com>,
        <loic.pallardy@st.com>, <broonie@kernel.org>,
        <fabrice.gasnier@st.com>, <gohai@sukzessiv.net>,
        <michal.vokac@ysoft.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 1/2] Revert "pwm: Set class for exported channels in sysfs"
Date:   Mon, 1 Oct 2018 15:23:56 +0200
Message-ID: <1538400237-28766-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 ("pwm: Set
class for exported channels in sysfs") as it causes regression with
multiple pwm chip[1], when exporting a pwm channel (echo X > export):

- ABI (Documentation/ABI/testing/sysfs-class-pwm) states pwmX should be
  created in /sys/class/pwm/pwmchipN/pwmX
- Reverted patch causes new entry to be also created directly in
  /sys/class/pwm/pwmX
- 1st time, exporting pwmX will create an entry in /sys/class/pwm/pwmX
- class attributes are added under pwmX folder, such as export, unexport
  npwm, symlinks. This is wrong as it belongs to pwmchipN. It may cause
  bad behavior and report wrong values.
- when another export happens on another pwmchip, it can't be created
  (e.g. -EEXIST). This is causing the issue with multiple pwmchip.

Example on stm32 (stm32429i-eval) platform:
$ ls /sys/class/pwm
pwmchip0 pwmchip4

$ cd /sys/class/pwm/pwmchip0/
$ echo 0 > export
$ ls /sys/class/pwm
pwm0 pwmchip0 pwmchip4

$ cd /sys/class/pwm/pwmchip4/
$ echo 0 > export
sysfs: cannot create duplicate filename '/class/pwm/pwm0'
...Exception stack follows...

This is also seen on other platform [2]

[1] https://lkml.org/lkml/2018/9/25/713
[2] https://lkml.org/lkml/2018/9/25/447

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Tested-by: Gottfried Haider <gottfried.haider@gmail.com>
---
 drivers/pwm/sysfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 7c71cdb..4726d43 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -263,7 +263,6 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 	export->pwm = pwm;
 	mutex_init(&export->lock);
 
-	export->child.class = parent->class;
 	export->child.release = pwm_export_release;
 	export->child.parent = parent;
 	export->child.devt = MKDEV(0, 0);
-- 
1.9.1

