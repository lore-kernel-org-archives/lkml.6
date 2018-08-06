Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B527AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ABFF2172B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="NSIp0Avc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABFF2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeHFL1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:27:36 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47344 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729714AbeHFL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:27 -0400
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BFX3013915;
        Mon, 6 Aug 2018 04:17:49 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0113.outbound.protection.outlook.com [207.46.163.113])
        by mx0a-00010702.pphosted.com with ESMTP id 2kn9nruyu1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iDfCFXWK4Bo2HmTbrtF/VerabXmQWCtlkLAlxKpIpA=;
 b=NSIp0AvcfOXELZk+hSDfgps7GcG9gya7z53qTjd1UCwG+LAJbQQ1ikiONi6vDRAvgUoyFt3pguLaNfQ+bF3NMySflt4Y83XAwLwJ3/IDlweJRrDDWNcPqUjYaKxwnByLqSTFDlWiGHgRczJ4m6BkAP6/Hp+qEQsGHbXdwXgR9Ls=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 MWHPR04MB0974.namprd04.prod.outlook.com (2603:10b6:301:43::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 09:17:47 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id 14C62302F60; Mon,  6 Aug 2018 04:17:39 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 14/22] Revert "rt,ntp: Move call to schedule_delayed_work() to helper thread"
Date:   Mon,  6 Aug 2018 04:17:30 -0500
Message-Id: <b9699e9fe2effcc1e54e54e04d247f5b6cf1b294.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1533540554.git.julia@ni.com>
References: <cover.1533540554.git.julia@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: CY4PR1801CA0030.namprd18.prod.outlook.com
 (2603:10b6:910:74::43) To MWHPR04MB0974.namprd04.prod.outlook.com
 (2603:10b6:301:43::35)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e309394-df3b-41be-6cb2-08d5fb7d79a8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0974;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;3:5krdHkgadzXYPkkrx0GroYaJ6R8WyK3ak2/FBSmsDu5zLWGaz6S0aiV/efKxZEoG5Rospu8Gsn3lo4BvkmMSOnOrxVpsbW1QUbFb0SOK5LLejZ1J0pa3gYbrTPYW5JrTed90uhhPxSAVfAo23acDa9M+6Y3LG3YXVcMGCQUFfLO7fjO9tUWeL8hJ8LfjvkCBMgl8J4srjaoe//FZNnRgj6/fBU6m0qkbIevbcndmgzGPULyIp7jXFTYaiaZ68Cg3;25:OvHHQwQe10rl6kXHwdfCEk34WsR/QaVAYLvxCBlrc0uhLuo15YMAIFb1sT8NqaNBZqzteCWt61ErzVbA/nsp6njddWQNzOiFgAtkFLDzJ//ep+3Qyw3+ChTKH8yDuT5iVUowL+b6++D7N7XFRHpjH+B+mnD/iaeJepyl7n+x7WvhYp8g9mJZjJGMb7U56HvtcUJFOtIcqPNIAv4VbaDpswAYyvbRt6G+o1o1u0k3ANgGW48MVylFajEFh3+x3MrUYXItk5CNDaORonCdRuquwdllhEsVdhSRXs96nydADUd/1YEtD5WMtKc6UVa9GheHrnw26OLjwBWFw4vtCPUwCQ==;31:0gX5+qX75e7FfgSslFUycPO1QqwKbfKARiPSaAPkuOpTHZVo+2BOwSaRSL289ET04SKmkRmDZYku+8vKL+bsh11oojZzqpBH1+SxLJi4Dbnyn0K+CHO8lE3a5jYfWNSUquANhsTscwQgM7GILNXQG3ZVUbz0tm7dttMW3c+pG9hCqngkoC/5N8fcCZzqqfA5VZByqV9+7JZcPQdTfVCYAGtBFDK9auo+UOzuBwUmxII=
X-MS-TrafficTypeDiagnostic: MWHPR04MB0974:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;20:50MXlHIhZ6QD9t0cSexCWx99Pjur8kLopQW7hIbmlzDhqUc5k8e+Bf2TyujlCD55vb4YGETT3t7vwJc++7nQqLhgpcGQr3PAV+o+FJttMYyTEKL76/dcn/R+RNTdmTWP1QH/A6CL6D+hM2/MDy2Z2JOf6K832XxDj7GTLECTe32YeCbcEjX6xsK+0Gu5z9yI9uZG8CT2bmkktdeOkVVFU9ONsx/WLqg8lLR6bwEL9VVhTr5NqIQD3xUsAsjH5uJS/JYrZicO7gDy9sjK9AqRAW9Et9AC9wsNc+fb6cb407y8H0KDceQqODB7nV5z9EZaSFfmQQQiuvmPLp6a4Seow2EnoLtEBn6IaAXbQTn49ESEGwkcodP7ibaGyA1yGVKUr4kYDWHNns585phPNl97AxdiMDjHxR/nf26iUg3/m/RJ8ZKfy5eL7v4BAUyQxiMPpHN3j6J+4EQ3vvTS5Qfjl9HIQwizxDkWTdV9yUwY8QKg8e1UrNRwWMl3qjbpzZY/BtLN4gt1UVf28rlCIXs3xrnGQLJIFEfgNOpfo0brWgws4oYUZ247d0Q5KYzUgw//T1wSERB1wbEVlkvf1K+OGm3Obw/274DgkBXA2bT/6ow=
X-Microsoft-Antispam-PRVS: <MWHPR04MB09740499EB24BF4DCC4799E4F4200@MWHPR04MB0974.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(145744241990776);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0974;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0974;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;4:2YE5ozll8qVcLQFxggWR2AezfoCd9OGC9otje2tGfQRx9y58p3A/LTNgRxltm4B9tRJ0yNr6gbTW/MGtZOr0hr/CErU3p9cVQKyJ09PzQ+cfMjWcoihu/L2/XzkSV9mTQUD0/9DYXaqI/jsYaXX1Hobt9NlItPNcAnXfoew1/9txhneetTWU2tuS4/u6FyrC1UTJ9gbFIhLYAjlH/uHXjjI4S5x973hkbiSmKAsoDMuOG8SRgxeI1USQqwuuNDVjv+r8eHjOXWLQtsMXBdV43KS5WPHSThydTCl4SA8EovuQf77Dup7HyhfSZJcINNzzxcc4UVZySgHs6AV5351awSA0RGtyy6JOuOdOunIgfI0=
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(39850400004)(346002)(366004)(189003)(199004)(305945005)(7736002)(386003)(51416003)(118296001)(36756003)(53936002)(48376002)(68736007)(76176011)(2906002)(16586007)(316002)(54906003)(52116002)(47776003)(42186006)(50466002)(50226002)(81166006)(8676002)(81156014)(8936002)(122856001)(4326008)(106356001)(105586002)(478600001)(11346002)(446003)(66066001)(486006)(6266002)(476003)(3846002)(5660300001)(2616005)(6116002)(90966002)(7416002)(186003)(26005)(6666003)(52956003)(97736004)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0974;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR04MB0974;23:STQYXuUoGpU3ANRMQ1/g7l8b9z4/HDNB0FIqGhLlq?=
 =?us-ascii?Q?5b7WCjuA3FhfNmVjXCS7XFMACPlvfPRwlbkpdmnpAfmYj+OLsJurlf5gNpkq?=
 =?us-ascii?Q?/j3UI3Xg8g622yumfNcl6vFXNyhTszAp/IXbUHqWfjTB4xaRVvPsTjqMYzrM?=
 =?us-ascii?Q?fY/V8gH3QY3FowHggcrYWPKH9T2kwA2cUlp3mTXXK8w+NIuu4qM4jXL4VMcN?=
 =?us-ascii?Q?/cw6Q7FaW2ECXV+0vLYqsukV2AtKy5zDdOrVon2w3As+QZ4LTqd7O8qtchMz?=
 =?us-ascii?Q?PwNFMH+8z6xYOO7CdPDK1Rb3O/4QH+nka1Z7mX4epgiBTtD3jz1VFP5NjdX+?=
 =?us-ascii?Q?qwXAv9k6lGsolbPWJwHKVmBtAr0wLCo07epFJ1gwBNqMozASuiSFLyvBB3+a?=
 =?us-ascii?Q?ZWgHTMDAamkozWGzm4Osrp6LE8IpcfzfJpVEJaV8+iFTSy6sG7vY1VP7v3WP?=
 =?us-ascii?Q?YNLfO+p1dbtRMBaHPRas4Vf7By5YuOqq+wl0smZ64RG4lyKroiXbTs2O/HMn?=
 =?us-ascii?Q?utSn6GmaoO8djgrixnXvm6wBmhDQTHR8jBQ01ZW40E/hgKnZshhpNRM0kLKq?=
 =?us-ascii?Q?ei9t3MMH+rO3GN8bELMewRNnwWQ/rnCG6NA+BhfDMAx3sv7umndwqnmGhvHK?=
 =?us-ascii?Q?+bybukcDEZbu0AJPC+6kKOgXBf2PbEh5nd/fVYCX8rhZHZs7M2rnQbjWZXWU?=
 =?us-ascii?Q?XinEscRH3Oq6vvFEhRBksmX8sXmXbONXqTqDQ5MR+JLsKol9s5KeJVvxu2NI?=
 =?us-ascii?Q?2JCOAzzQgepYiscdM2o2JNjeCcf5bLK5MytPZjQhnu9ZXontRMQ6zlfRbyJ6?=
 =?us-ascii?Q?x+ey4pIiMutp1OvIK4JN51OAbhpVanN1CoIV3I/3lOFJAY859gig4oMDWZ2b?=
 =?us-ascii?Q?IvZjAsHl1XWadrwaNgRqil7SPRU3OXDigeEzJ0yxAMWUtkUguIuTEUlLUW5c?=
 =?us-ascii?Q?DaugO9wSglTJ1Wl213W/rmAeT41+/pq/XxBuXa4vAc8BSp1BfZSyShzIB9WE?=
 =?us-ascii?Q?evfYMf3lfoSl9wQZUARyJqNa6rcoOiHIQqqr6ZL2CqpeqPlu01CYgL2Tk5Oe?=
 =?us-ascii?Q?Sz9xfJb/GhACZsV2BFf1v+BqIyzr2umsROjn+b4ZpNgMVVpGKYChGZB3ignn?=
 =?us-ascii?Q?pYK7PSTyCYrRGA18WZiOiOUjXTWyyBS1RFcP35jGWIJYT+t4bBMyb4VxgI0M?=
 =?us-ascii?Q?AI7rgiHSrVJSdpDpomnJ5GifkVK05s3HUS9?=
X-Microsoft-Antispam-Message-Info: 3WqwlPjFoCVelweDSovaEjlDjzXRjTI8WddSiQrZp/CN+TdWCkqHIihlwFk1pjNsBRWLI3HGLbkNKuY8WuYpZBMjGfMYdt0uqaQlDxptObkf5gGTlN0+rmv1oQ7JWvvd6Rqnf3VoCUyfMMLLaNnhPFPmPuYSF6BjHG3VInJdmcYUTOh2ZwjkxwgNxFQYKphbXmFu7GUZquNJGIIjoxz/ZoRVo/YEogBMgn0DIztCk4vvFj66/kO+qEJogEbeBQ0thHywUcPC+54/LXjks3mqy0zljoK0Kks71knoJzalQAouRI9F9kpCNIRhaW1L7BcHlkGaWKz0cg+1mp4MURHw2ITNTfny+AiMMbK1DkfJ4vU=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR04MB0974;6:bOLS/hxyJ9Ld+5TaCcQf3acqIXcFroXIO/Ub/mzZ5GWPX0cvYQkz1hWJiEZ5vlYZ0/paViHmZtTwf3O1ke+OvxrWCYTJ5fUeJ2Cf2R2TaguIy8+gAcBhE1+cRsx0MpRL+xwKgkGs2duO2T7qtHNY7HhH9MGDqK6ZG3I+9rtfiOyQ6OCG8w1CoAlogztVcGV3dQ1GY4kuBt2ttdLeZ8cIwWO8N6P3C+S4OOIoYqZUv3+PZAAowuL4V4/rdcWkVwtGwPleUIEcy0enhStxo0f3iW1AR4vS6mT6DYEoJk/0gvefbXmxTN6f6uGYsaz98V5Y1J28y2ZEC8pODmMKZj60WFt9Ik8+Cj5OYiAlqoA8KbP0HaMW+y/PtgEmxHkGO+rgJ+J41YfSoz43iprgZUktFjcU8xGgM57/zTuSZNFbSVcTP+/WfmUmaG9NDw+qFUUgGKqv4iKUaqHyqluTledt3g==;5:rbhwIEYfe86rzHJ1mduGbXs51brg6Svmgh5v/mMdmE5z83SUGWCKn+tG7GW5JF6wBYKJRiZyYXSsJ6y5ppjfeOHew5LRwh6RLkj4YJHceq76O3CE0zZ1vYo24EyUzYu15I7t64ndXrBhb0KgDmexy6G1SLjausRYe5uHhk0ITG8=;7:yMt7pU9TceFGn3C6NgtIuDt7DfG+gj+KdkQ7+G8R8JDIfd7hUWbCmQsVJWJLLQkg7yNmJIL4fJ+R+J+2sJXIRcJa2V3w/aUJaOqDAmgGm9aPcZ5tGpJiBQYYp4qsXyZvqlhRITIlXi9cSTIzEyewajUFNZgng0uFK/8dS0SLf/vljoUnGED4sBLoJRh+UvGWBgFpwZrpm9w6e0iyDiEcQB5BuLM8os7MN2LEFFBYyQA1UmA4EbjyPrf4oFFO+m4s
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:47.2787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e309394-df3b-41be-6cb2-08d5fb7d79a8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0974
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

4.9.115-rt94-rc1 stable review patch.
If you have any objection to the inclusion of this patch, let me know.

--- 8< --- 8< --- 8< ---
I've been looking at this in v3.10-RT where it got in. The patch
description says

|The ntp code for notify_cmos_timer() is called from a hard interrupt
|context.

I see only one caller of ntp_notify_cmos_timer() and that is
do_adjtimex() after "raw_spin_unlock_irqrestore()".
I see a few callers of do_adjtimex() which is SYS_adjtimex() (+compat)
and posix_clock_realtime_adj() which in turn is called by
SYS_clock_adjtime().

Reverting the patch.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
(cherry picked from commit 932c5783d4434250a1019f49ae81b80731dfd4cd)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
 kernel/time/ntp.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 05b7391bf9bd..6df8927c58a5 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/math64.h>
-#include <linux/swork.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -569,35 +568,10 @@ static void sync_cmos_clock(struct work_struct *work)
 			   &sync_cmos_work, timespec64_to_jiffies(&next));
 }
 
-#ifdef CONFIG_PREEMPT_RT_FULL
-
-static void run_clock_set_delay(struct swork_event *event)
-{
-	queue_delayed_work(system_power_efficient_wq, &sync_cmos_work, 0);
-}
-
-static struct swork_event ntp_cmos_swork;
-
-void ntp_notify_cmos_timer(void)
-{
-	swork_queue(&ntp_cmos_swork);
-}
-
-static __init int create_cmos_delay_thread(void)
-{
-	WARN_ON(swork_get());
-	INIT_SWORK(&ntp_cmos_swork, run_clock_set_delay);
-	return 0;
-}
-early_initcall(create_cmos_delay_thread);
-
-#else
-
 void ntp_notify_cmos_timer(void)
 {
 	queue_delayed_work(system_power_efficient_wq, &sync_cmos_work, 0);
 }
-#endif /* CONFIG_PREEMPT_RT_FULL */
 
 #else
 void ntp_notify_cmos_timer(void) { }
-- 
2.18.0

