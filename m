Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3CFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD92208E7
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD92208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbeJAUC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:02:27 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47524 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729182AbeJAUC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:02:26 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w91DJIvw019119;
        Mon, 1 Oct 2018 15:24:13 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mu1bjmav9-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 01 Oct 2018 15:24:13 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 71E6431;
        Mon,  1 Oct 2018 13:24:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 457F4465E;
        Mon,  1 Oct 2018 13:24:12 +0000 (GMT)
Received: from localhost (10.75.127.46) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 1 Oct 2018 15:24:11
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
Subject: [PATCH v2 2/2] pwm: send a uevent on the pwmchip device upon channel sysfs (un)export
Date:   Mon, 1 Oct 2018 15:23:57 +0200
Message-ID: <1538400237-28766-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sends a uevent (KOBJ_CHANGE) on the pwmchipN device, everytime
a pwmX channel has been exported/unexported via sysfs.
This allows udev to implement rules on such events, like:

SUBSYSTEM=="pwm*", PROGRAM="/bin/sh -c '\
        chown -R root:gpio /sys/class/pwm && chmod -R 770 /sys/class/pwm;\
        chown -R root:gpio
/sys/devices/platform/soc/*.pwm/pwm/pwmchip* && chmod -R 770
/sys/devices/platform/soc/*.pwm/pwm/pwmchip*\
'"

This is a replacement patch for commit 7e5d1fd75c3d ("pwm: Set class for
exported channels in sysfs"), see [1].

basic testing:
$ udevadm monitor --environment &
$ echo 0 > /sys/class/pwm/pwmchip0/export
KERNEL[197.321736] change   /devices/.../pwm/pwmchip0 (pwm)
ACTION=change
DEVPATH=/devices/.../pwm/pwmchip0
EXPORT=pwm0
SEQNUM=2045
SUBSYSTEM=pwm

[1] https://lkml.org/lkml/2018/9/25/713

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Tested-by: Gottfried Haider <gottfried.haider@gmail.com>
---
 drivers/pwm/sysfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 4726d43..ceb233d 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -249,6 +249,7 @@ static void pwm_export_release(struct device *child)
 static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 {
 	struct pwm_export *export;
+	char *pwm_prop[2];
 	int ret;
 
 	if (test_and_set_bit(PWMF_EXPORTED, &pwm->flags))
@@ -276,6 +277,10 @@ static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 		export = NULL;
 		return ret;
 	}
+	pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
+	pwm_prop[1] = NULL;
+	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+	kfree(pwm_prop[0]);
 
 	return 0;
 }
@@ -288,6 +293,7 @@ static int pwm_unexport_match(struct device *child, void *data)
 static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
 {
 	struct device *child;
+	char *pwm_prop[2];
 
 	if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
 		return -ENODEV;
@@ -296,6 +302,11 @@ static int pwm_unexport_child(struct device *parent, struct pwm_device *pwm)
 	if (!child)
 		return -ENODEV;
 
+	pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
+	pwm_prop[1] = NULL;
+	kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+	kfree(pwm_prop[0]);
+
 	/* for device_find_child() */
 	put_device(child);
 	device_unregister(child);
-- 
1.9.1

