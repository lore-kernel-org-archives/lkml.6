Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244C5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF875206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="CbUgUb8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF875206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbeGTJ0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:26:51 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com ([40.107.3.109]:59520
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbeGTJ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXffP0Kv1n9K5xRMmZw8SUi5qq8kEqA8OG3oevy6nT0=;
 b=CbUgUb8aBei37/QREWkYfiK67MP+ceBAFIwGZfVMaoNxoX62qkkaGozTD3qE7uVck3Y3NnvVB8GXZ5OXYmfJVwRNzhVngy+iTAiE7EkDMTGt9u/LNYwCV2/YKQ2ZrSpGMV34WVWPORVsj2UUQ+5qPZWru5RV3+MsT4ClTe8LBEk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 08:39:32 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v4 1/2] rtmutex: allow specifying a subclass for nested locking
Date:   Fri, 20 Jul 2018 10:39:13 +0200
Message-Id: <20180720083914.1950-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180720083914.1950-1-peda@axentia.se>
References: <20180720083914.1950-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0010.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::20) To HE1PR0201MB2459.eurprd02.prod.outlook.com
 (2603:10a6:3:82::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ada897-d2e9-4029-7b42-08d5ee1c514f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;3:057o/s2szgUhAaPfF10Rub1TMACe5ejoQd/C7Gg10zCFj2b+FspXKDYPiJ+icYTkRBZuU7Q18Pyv0Vu2C4uiZ577yXljM1APsBfOZuJEB8aiN6xfce/rMnJ2Z0qQAEeEoWKuNmSfqO83evc9Hx5kBDHcoG9Z+7i+z6QVIm0mNNmIqTR1CDanXAVLv/XAjgNsB6DWGb/rav/4M96vkPJpq8rpA/PXmj6JBnZPput8XTx1HdqQht4Zn3JsuX+qGc8f;25:zWaW2O7g4UBdHDCyo/LYbOc70aIxEtDl4QVxCgjVkvyrepItyO5yGwKBbKoHxufGtmISkUEl1Jk2dH1gB/+QmdJuInZGcaquWMBDj8f/nIqigi2nZthLPm6JRd0qxL+DpmzfezKgpw5z+HLomQXWgelbUxu7pD1acNfQqcUIbYJ1OLszRlm56ZuDLBsHZsT/YfPZG4MsfOaRrQwbzar76DTVfWZAlKXqda+iRo05jQqkGsEuWboMkiBnjVnyVDZyo7Rxya1U6Pkg17KXFcafjiEv1ZUSTFmszHCQCjpAp3XUZNFBDGL++M2g4zMSfVOS5bYw7nguiBcd5i3nhEi5fA==;31:Rv89HgF4AM0mvPpACMxeVWyEWMG6UOxpkx95Dp0DhgcEs1LgX9CBCEj95bussbPRhuFb3WCfPrAR/pbQsVpgyEHFBlRKBayostMZo/+IuAsNb9J2teZB4psSOlTzWGuZ5bkpKqujhsPSwwcCXHk7+UkurnJ316OpExMljGu3xPccCIOHqh8wCjNBRzO9qwylyHgW/BD/K5fD7fVgdjpiFryXLZOkVe1Jtj/pU3HUPI4=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2459:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24596311EDF5123B7672FBC1BC510@HE1PR0201MB2459.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;4:2x6v6ygD2vnD8D8GQSJ63mKDWittsW7tIOv3uPb/3o7FvAiKNCXuJOLT4VINXw/mFHq+CiR4sqAetPfcfAa4oblhlABNzOPqH7vramUPT1fXxZfTlUof05amWqQd5pfi4yTk4Hi/Cqz52/L5MnTiuo1dAdfc1SM/llaNkTVtMDQG9YH9Fnc/IhFZL5HYJQAPsV+3CVduuIBZqwksqxAWaqQI9/r6uQ3dmR3f5KsLmLAK62MmpdbVswizWEmSuV6zw/0aGMZOwyzd2xxIW5i+xcAKcLBkCkLbT02guGK/NU3e3a3jCBqQBK7P3tEKDakleMtLQLhoF2sI42n1ndy/WsiDWc+FV0PohULn56mqMa8=
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39830400003)(346002)(366004)(376002)(199004)(189003)(36756003)(6486002)(47776003)(6512007)(478600001)(66066001)(4326008)(7736002)(14444005)(26005)(305945005)(486006)(476003)(11346002)(446003)(25786009)(956004)(2616005)(50226002)(316002)(76176011)(74482002)(52116002)(51416003)(575784001)(86362001)(54906003)(16586007)(2351001)(106356001)(6916009)(6666003)(105586002)(97736004)(6506007)(386003)(68736007)(7416002)(5660300001)(16526019)(81166006)(8936002)(81156014)(186003)(53936002)(2906002)(48376002)(3846002)(50466002)(1076002)(2361001)(6116002)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2459;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0201MB2459;23:bVQytVOMIkqaIJkhXpI2FllxA9nb+vqiKwCbTg+?=
 =?us-ascii?Q?u3OUacZK+3gIFUPKC11Gt3ZS7XJu6lYGeIRiCArzyj5kqwxAby6iNOhPv0xf?=
 =?us-ascii?Q?GmpBheu/wBCoc8M7TojAjSsbA/FVlC6gwPNH3R3zdKPza/5ykomRMveTxdON?=
 =?us-ascii?Q?/dNQbT7N/ruYDAjb8P37ettXUKKTY77YxAdsl7HRN6xgKIPeq0p5r2pn8p6K?=
 =?us-ascii?Q?x4/8qORojuLRFigeAf716n7kaJT+KWRm617R9CGzWzi8LjwJeOEWGbf1k4yg?=
 =?us-ascii?Q?1YJR/P4tpGB4w8eqj27OEw9NJ6sFURZGBKnkNBbYW+pZ7ulNLhPuMKc7W1UO?=
 =?us-ascii?Q?8T0L7B0DgfwmntzNz2cJskeLaQ89ls0U2f+e8PhoNHyhrKSl0TRkJ45q+BXA?=
 =?us-ascii?Q?dk0trA6kCid+CS3fuiboOHIqc0J0dpwMRyiGzpP9gS5CSCYoi/Osuq/UtxZM?=
 =?us-ascii?Q?szbL6nVA/B7TsscDHJPVzdoWwnbzrR1/1rhr3uyhjR76kSuOPNTIfo1kTni2?=
 =?us-ascii?Q?m2jpJtBUTVVmTVmiuPASBH842EJmWrUItSTVq+tQV0035hs53MEVQw54sXbU?=
 =?us-ascii?Q?Dcli/axbPtiMu36ecGXXuQxtD2Hq5zW8DXV35OnjUgcW0ZcvMHeNO+2jTSDd?=
 =?us-ascii?Q?Gcbvp0C9IUql/IcxwDlYM6KcsJPdzXZCScmz7DlvfSDdH4mbMM7y4PGai75i?=
 =?us-ascii?Q?ALtMA4BAP3KWhPZmAXLS8MW5mDFs5a1uNPBYX2KD55PPmDlvtT9uge/3XKGL?=
 =?us-ascii?Q?kBnEIV8RRU6l143AdczVOybBXlTzIwMiMXk9IVjAcDJhcQ3zQgF4Hld4tCt3?=
 =?us-ascii?Q?uYJfxuuex6PrGClYhjy0hjrZWVBfR8x9PZDk5stkYU1SVI/qYigX5kAoovJG?=
 =?us-ascii?Q?+ZBU5EMfo/wtTcI+NpYFbzLJTdPoQWXYOSPTnXb3oi+S2bz3xOeYs4BG3+U2?=
 =?us-ascii?Q?8nnWWdcgH82EYr+8WENF95yzF2bUioa72r2X9RE33glVWpkyGAhgvDS4gWhu?=
 =?us-ascii?Q?RYC6l7ZOF77AEtIIvdKtCMbm08oolK42o9v3ACNXsbbbbolux8fktdmAGkxc?=
 =?us-ascii?Q?eQ0dslyAOPQZoOuYifXLLtAAOYHaZHHVuk45buWfu85KmFLjI+cUhrjm5dzz?=
 =?us-ascii?Q?ROx1y3b3zVyvZiL6pnBtqUjcBaAZRxw3q+O0OYDLaXy8BHeHQJ5XvaUaKAEk?=
 =?us-ascii?Q?RW7mEVKYE+IasN4TqQbov9bJQxrYl5N8cZddexlCQJ/RDlcNvQbrSjKv/sZ/?=
 =?us-ascii?Q?Ank5lQeaWED2dOuKvD/GOEAm7uqYUaY9/LoAX1v0YDgT1sROg3ILOQ8Zai8l?=
 =?us-ascii?Q?jUuI42mH8YssDcmM1ePpuz20B0Lc1sgcj4sY6jBKkSa09vPHNE/9ESc35D+h?=
 =?us-ascii?Q?h7sFUvQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6zudZnde918EYlUjVIRyBJ2Y2Ad4KJ8rAAGv+32Qwr1CGBK+AeFCheIoOcLdM9tnrqWr7mtyBSKNbY5Muht5IczXgDbOcQu7nx2IQR/hgghdDhjnIfaVBjxSJ/AHf74k1LU+IU2B5nlBQOAZuxYwolYplAgB1dTfT2ZXodO9acPxph99pHYISaRepfIpxv36qYH2zinOqzVe9kq8rF4dw++aCL/toR5Jq1eAHGqO6WGvycbYgvqADJQvLmFUKL5uE1fBgA23njJSfy/yHBKscIwbiA1doSXfjs3opNchzFni8N/Pnc08HS8RgOqALb6NDDvloLadgSE86V5cS2LGUEjRwUIwHtF4P0MtHyujZcQ=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;6:IdVegOXVbIIDKxq49Ux9JcbWtDV4tkCr1m15s6EIGxJKsOHfwG2vMHnrH47TW7tioztOADW671s6aQjvjE1AVF+cLFBTfryG4mnCXORFzqRqi55vddlYl+l50NqeYEoQRphRvXn+qst/pRAKIKdkEtX9ck5DPw0OehWrEf/4DAjEd35JRaPcrG8uRYTdZ9ZSTdY0OZq1/FTPbJVz45vjOqrKfn9QQUY39fj74UCpCX2lGfKOvdTSodCjgUsEBXxUEh6SUHvy6y+/lk4v9TIWsY92ZuqYqssPkOGM3BLpStj+Gkbl/xhoR2PyRiKgPf2Eh9JPFq34WlAFg49lm3pPgmHo+SQxHubzueffG7wA0h7lljY35bgUIWEGFI9tlCmndXKiWqKQhbrYTzl2CLeBmHlrFGU/YQZfx9xbPOh1gxI03331uHo+rrOicik+JcOVHoheEbwPy32J9SvTsZHPTw==;5:Pg64EHPUM4RL5OnA1gTgJgfFZzcwy37XfXsPW1yyCZWmgdHt0mCcmj+8J1o9ZJWouo1PUBx9XXefiw2RoBOb1AYABSFplmg/FXL6U3sucS2abYsRjwb6NFvXX86JxWPwrwKs8BbrV5docfk0u3B2hbm3GxT2anLrnuoIctyQXbk=;7:DieiLPXY7NEY9xz2SxCjbRHmOa5NBA9gwtY1pdBsSl1yRMSk0JSm58BFb+ofgTS31kxje2xS4tvfeSsKJEw4AJqdLM0/pBqqJv2U1K7y+j9dVb10iRTbKHrrFcsl8G2SKJ5DkTfOv8ZhqUxZwpin/IbPVMGXN3PFYIvLxyq+9Upv2jbQpQsYbNa5rH8unMj7RS1ofUANPGLJvW8FlVC7dEarnZ8dzSaMN2xHgeW0LWrKKjViwKC+SBAc0hqML4rT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 08:39:32.9998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ada897-d2e9-4029-7b42-08d5ee1c514f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed for annotating rt_mutex locks.

Tested-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 include/linux/rtmutex.h  |  7 +++++++
 kernel/locking/rtmutex.c | 29 +++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 1b92a28dd672..6fd615a0eea9 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -106,7 +106,14 @@ static inline int rt_mutex_is_locked(struct rt_mutex *lock)
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
+#define rt_mutex_lock(lock) rt_mutex_lock_nested(lock, 0)
+#else
 extern void rt_mutex_lock(struct rt_mutex *lock);
+#define rt_mutex_lock_nested(lock, subclass) rt_mutex_lock(lock)
+#endif
+
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
 extern int rt_mutex_timed_lock(struct rt_mutex *lock,
 			       struct hrtimer_sleeper *timeout);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4f014be7a4b8..2823d4163a37 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1465,6 +1465,29 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
 		rt_mutex_postunlock(&wake_q);
 }
 
+static inline void __rt_mutex_lock(struct rt_mutex *lock, unsigned int subclass)
+{
+	might_sleep();
+
+	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
+}
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+/**
+ * rt_mutex_lock_nested - lock a rt_mutex
+ *
+ * @lock: the rt_mutex to be locked
+ * @subclass: the lockdep subclass
+ */
+void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass)
+{
+	__rt_mutex_lock(lock, subclass);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
+#endif
+
+#ifndef CONFIG_DEBUG_LOCK_ALLOC
 /**
  * rt_mutex_lock - lock a rt_mutex
  *
@@ -1472,12 +1495,10 @@ rt_mutex_fastunlock(struct rt_mutex *lock,
  */
 void __sched rt_mutex_lock(struct rt_mutex *lock)
 {
-	might_sleep();
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
+	__rt_mutex_lock(lock, 0);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_lock);
+#endif
 
 /**
  * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
-- 
2.11.0

