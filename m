Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BA2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC708223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="P1S1e5zD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC708223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbeKPDtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:49:40 -0500
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:58474 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387839AbeKPDtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:49:40 -0500
X-Greylist: delayed 1984 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Nov 2018 22:49:39 EST
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id wAFGvTmY023114;
        Thu, 15 Nov 2018 17:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=jan2016.eng; bh=Aw712imagVJJ+wUu+8vqd9e74uGx7tPYwV+30vjNQ1E=;
 b=P1S1e5zDjipnXHNH1/X/rIhNhSJb2aLpYcUX6g7abnsInpx6fqfPRUi43KOh7ADEMwiu
 tK1cmiJMiY5/wPDV/CqmGcNONwonUrRbIZjGm0wuW7J/4y8sIUQyne0YMGw9mQjxQLjY
 XLaoUooOlyWv5kWObJ6IUdYHwImA/9YeaARRzeGQsm8GQed4kwrXwlm/oy0BfxwyRWxe
 RbnzahIj7YBMdpjHa0jLeXy+xKo41QzhTqJN3v/G77UZXSFlAkz7wRf9L39KnxYtHg+B
 aoBBOKK0twgE70ulIbsglYF3GOHRs42ziEa5q7lm2vzf+Cr+fTqd04e75Z/Hp2KGBXij ZA== 
Received: from prod-mail-ppoint3 (a96-6-114-86.deploy.static.akamaitechnologies.com [96.6.114.86] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2nscffg3v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Nov 2018 17:07:29 +0000
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.21/8.16.0.21) with SMTP id wAFH5627011112;
        Thu, 15 Nov 2018 12:07:28 -0500
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2nr7jbh0sc-1;
        Thu, 15 Nov 2018 12:07:28 -0500
Received: from bos-lpo4l.kendall.corp.akamai.com (bos-lpo4l.kendall.corp.akamai.com [172.28.13.75])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id 6C5C581394;
        Thu, 15 Nov 2018 17:07:28 +0000 (GMT)
Received: from mzhivich by bos-lpo4l.kendall.corp.akamai.com with local (Exim 4.86_2)
        (envelope-from <mzhivich@akamai.com>)
        id 1gNL71-0001Ea-WB; Thu, 15 Nov 2018 12:07:27 -0500
From:   Michael Zhivich <mzhivich@akamai.com>
To:     linux-kernel@vger.kernel.org
Cc:     tiny.windzz@gmail.com, joel@joelfernandes.org,
        alexander.levin@verizon.com, frederic@kernel.org,
        bigeasy@linutronix.de, mingo@kernel.org, rostedt@goodmis.org,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        john.stultz@linaro.org, arnd@arndb.de, omosnace@redhat.com,
        jason.wessel@windriver.com, kreview@akamai.com,
        Michael Zhivich <mzhivich@akamai.com>
Subject: [PATCH] softirq: don't push timer softirq handling to ksoftirqd
Date:   Thu, 15 Nov 2018 12:07:01 -0500
Message-Id: <20181115170701.4696-1-mzhivich@akamai.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811150150
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-15_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811150149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Require TIMER_SOFTIRQ to be handled immediately instead of delaying until
ksoftirqd runs, thus preventing problems with reading clocksources that
wrap often (e.g. acpi_pm).

If acpi_pm is used as the clocksource watchdog, and machine is under heavy
load, the time period for the watchdog check may be significantly longer
than the requested 0.5 seconds.  If the watchdog check is delayed by 2
seconds (observed behavior), then acpi_pm time delta will be

    2.5 sec * 3579545 ticks/sec = 8948863 = 0x888c3f

which will be treated as negative (since acpi_pm is only 24-bits wide) and
truncated to 0.  This behavior will cause tsc to be incorrectly declared
unstable in clocksource_watchdog(), as it no longer agrees with acpi_pm.
If the clocksource watchdog check is delayed by more than 4.7 sec, then the
acpi_pm clocksource will wrap altogether and produce incorrect time delta.

The likely cause of this delay is that timer interrupts are serviced in
ksoftirqd when the machine is very busy.

Per Linus' comment in commit 3c53776e29f8 ("Mark HI and TASKLET softirq
synchronous"):
   ...
   We should probably also consider the timer softirqs to be synchronous
   and not be delayed to ksoftirqd (since they were the issue with the
   earlier watchdog problems), but that should be done as a separate patch.
   ...

Signed-off-by: Michael Zhivich <mzhivich@akamai.com>
---
 kernel/softirq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d28813306b2c..6d517ce0fba8 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -82,7 +82,8 @@ static void wakeup_softirqd(void)
  * right now. Let ksoftirqd handle this at its own rate, to get fairness,
  * unless we're doing some of the synchronous softirqs.
  */
-#define SOFTIRQ_NOW_MASK ((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ))
+#define SOFTIRQ_NOW_MASK \
+	((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ) | (1 << TIMER_SOFTIRQ))
 static bool ksoftirqd_running(unsigned long pending)
 {
 	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
-- 
2.19.1

