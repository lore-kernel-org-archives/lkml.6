Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeEVJWy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:22:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57922 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751160AbeEVJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:22:21 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>, <stefan.wahren@i2se.com>,
        <gohai@sukzessiv.net>
CC: <hsweeten@visionengravers.com>, <gottfried.haider@gmail.com>,
        <loic.pallardy@st.com>, <fabrice.gasnier@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH] Revert "pwm: Set class for exported channels in sysfs"
Date: Tue, 22 May 2018 11:21:44 +0200
Message-ID: <1526980904-11041-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it causes
regression with multiple pwm chip. It creates a new entry in
'/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export':
- 1st time export will create an entry in /sys/class/pwm/pwmX
- when another export happens on another pwmchip, it can't be created
(e.g. -EEXIST)

This also changes existing ABI (Documentation/ABI/testing/sysfs-class-pwm):
- pmwX should be there: /sys/class/pwm/pwmchipN/pwmX

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

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
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
