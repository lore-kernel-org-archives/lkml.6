Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965523AbeEXIrQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:47:16 -0400
Received: from mail-ve1eur01on0134.outbound.protection.outlook.com ([104.47.1.134]:37534
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965497AbeEXIrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:47:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-i2c@vger.kernel.org,
        Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v2 1/2] rtmutex: allow specifying a subclass for nested locking
Date: Thu, 24 May 2018 10:46:45 +0200
Message-Id: <20180524084646.31697-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180524084646.31697-1-peda@axentia.se>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524084646.31697-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0019.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::29) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:C5jG2pI1o/PZLpMlTJlIFvuzMGtZ5GIrH0q80U/XOfIGx1JJS6Ez8FfPuZS197q8WBiPpaa094aYRmCsCfuAxd4znBj6NVrsDR9ccr5aWDT0WiZGPi0XcyEzsYUGpBfL1mdTW9vC12Q2E56Ey7tJ1fKuYtRM6awhrIk1gr8LJqAYi3+mwWyv7gr6N5tGv1Rk9citO+y6md5jUuKInfEFkxy9RVOIX0kwd/ySOVU3aOdDWT1Exsnv4GQx/Xqzb4J0;25:hYDhppRpzfPmwkOJlf3rbpCcax/EjqKx1iOzAXB1Y5hsliFVFIQUdJs3s6WfKws5G25e3Cb9HgEZaP+h/5KcrJGAYzPsapnyXSIc+b+QYAZNdWfwwWmm3AuHOBztRLALyr61wkH5rmz+5cRPHC/tJrPBAaaUqeTljOKY5iJx70eS0M0u9v4hkiSbJFeTfk+/+qCW/M1m3hBnWy4nsZPoGhJQk09uOi4BBxQCr1LHvQQTgO6cF7Tp1v3ICuBA9Fotah6m4LQY//KuBM3kAoJSpRSXFDjs5ZezgI50y1Chny+O9+d9VlTMQ9oywPpGOz1SMa/9Ikbj6Y9u5sHZsJV11A==;31:2dBZQ86t/mYH9QO0zMejTnFca4XW4LGEUP2N5/rBM3kZdYh5W2zQQXNeRjVE7NScSqRTmr60tapIeDyOi9HIEvLEQlBBkPIZzVzK/yO1P4dBdAZi+pYaAbjgX8kmXSzmZgV4TiQCYZb+AIGLbP3KmnFFxB+zA4aFSo03a6LLjNY3wPbjxxgBM/nxNux/Ts9TyvhK+IYMWIfS9wlZX7gvmzfV6o48blJh/GoSO9NH2HU=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB277915C0539E1909CAD1F274BC6A0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:xTgCp+tavh93FVrxXFMmYXjj3rP+gmDpo+M5/gCmDrdWeSLe3YkTsdNpvU4X3DpE3Evif9toJALXSv9AA5EM44ei5/JUPBBszlpnD4tUNISOHy09xEsjgCHNWqldbYv5pVV0uD24OE7iEXqLq8l7I/q5Aj7CA/FOTvn2XPYu7jH/v3riJ8+MA++retgDqlc+H9+yClDnJMWT1KT4vCbUyh6V9DMrN4Csu/1F0apRzHxpY6ymTdrgTn1OEuwgDCSqe0RRmya4th28cgg3zGRpQw==
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(396003)(39830400003)(376002)(346002)(189003)(199004)(74482002)(52116002)(25786009)(575784001)(6916009)(50226002)(8936002)(6506007)(386003)(478600001)(51416003)(2351001)(2361001)(7736002)(5660300001)(476003)(6486002)(97736004)(6512007)(305945005)(76176011)(6666003)(53936002)(86362001)(54906003)(486006)(59450400001)(316002)(2616005)(81156014)(81166006)(11346002)(4326008)(956004)(8676002)(3846002)(48376002)(66066001)(68736007)(7416002)(50466002)(36756003)(16586007)(6116002)(106356001)(16526019)(105586002)(1076002)(186003)(26005)(446003)(2906002)(47776003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:ic0wiNdw0YvF+uiWPFwwp347qFqN35xQg7gMYg5?=
 =?us-ascii?Q?mbtI29lfpSKu7QMusZRAw3IXRs5TJ6OEiq5KPfYuhAnIL9OZ/r8jyjATMbGL?=
 =?us-ascii?Q?df1YTqQz9yhJE00CxMzEhsbyC9hsWOPKSEzhQ2iSzgxuRc46RiZG+DJPi8Qo?=
 =?us-ascii?Q?naraoKY2jvNHGDdl/wUUu5zN/wwT795WlfbqIrTc/PGNYd6+U9gDmFq2RrYq?=
 =?us-ascii?Q?u22CqRZz/p5N0M2qQ53eBWMdqXoUlZGcNuikcYH01kusJ7GSM2vi4BDdgenm?=
 =?us-ascii?Q?erCL3hEinwrejpMQ70FpoTa5n6uZool/2YMfkJpkL5wz2o2nYbxKwEBNo8P3?=
 =?us-ascii?Q?aAm9h36JjbDVBhIapGFZXDesz5+PC2kqwTU9uuB76rDLilxdPl6gtiyMit++?=
 =?us-ascii?Q?xKsYHdXRJNuQgeKFQRjtakqy6Zd1COEd6+havh8PGGcsL751EtWYY3oOUXYf?=
 =?us-ascii?Q?HnIsrwZbtKWPxBd56IyA3e44m4+57n7MesXNsgEq5qRQS9crzaIkydhDRdJo?=
 =?us-ascii?Q?ib+KXuR6h/oYEnZYjN99BtbmmZ6ornAGaXnTQkciNjkRS704oZFMiRXPBuS/?=
 =?us-ascii?Q?Q/7s3rvKqsEU503bNGoAOz0lC35dGXg2Fa/vyq2e78JsNnujN1Bgdkf/tJHz?=
 =?us-ascii?Q?yKCvf+c5nyU4f1TZlxQqZzF2PxWcMSVRVci8nie523Jc4xhUWYbC5B/7ALWx?=
 =?us-ascii?Q?PwaqdE07XwZIej+ALeEDkvIiJOjitfhHMISz9vFJXMp8eYGrVjSNy/JYakwg?=
 =?us-ascii?Q?K7q9Cr+hqWNukMbgXYuJTgqGcQTDgH4+54d9mDY38AYN9Yc1qKIF/fh4TD2C?=
 =?us-ascii?Q?gaqmFY+EpOrCNvqhoQAGuq9/cFMJ6xdaRF1yilk6lOC4sdnKYoHH7hwrGoUO?=
 =?us-ascii?Q?krw635qCWTvNEbt/ppYrkEj+466fCYFsifsQO4H5v6RDFYD1sNA9HF34kIyg?=
 =?us-ascii?Q?2A8uSl69TEHX/CQ+REk+xMKiVorU9VbfGgoc/LvipEE4vNrp/+QcaRNIybuX?=
 =?us-ascii?Q?bx7sYDUPYvCW0FyZ5oAIPuGBH3Jf2Udh/qvmX0KSXphcxfqbkClN8PVEpfX8?=
 =?us-ascii?Q?Wi9BgSGZessIRu5epuSPFTwcSYUzsVHjHbxkHPXGeAxlUJfDDYC9rcqvUHpW?=
 =?us-ascii?Q?XNfTMIkqBIKWrsTOC+4iiYGuJJiL45qJbdVNCbkm6fJMZnrGEBYot/UFCb4J?=
 =?us-ascii?Q?LvNcjD+Z+dadHX2cQFP1Y/igxQy3u81Qyi/siQE3wnM/h4IhQshpZn/wvizf?=
 =?us-ascii?Q?yGXv4G4Qjtt2MpJN+HBGi9/V0LT/fNU0JNWmEwZtZF4tLHcF9C0Z0ikK32TX?=
 =?us-ascii?Q?Q8XLtxxBjb29jyIGcdulNsDzjE371Gh8+7SpothO4LbfnuBDB0mShXCL5a3m?=
 =?us-ascii?Q?lUT+musE4TtVst5CkxVxT8yeFzxw=3D?=
X-Microsoft-Antispam-Message-Info: uqt+x0zsa2/dFlJl3oxFSjTHY2V5Dab7o2XQWzO+X8sMlWlXLqoRruynhZxP/aIFZM46y/nq8SSFjiuDcKi69Xg2eTEogPMqK+DXVtKiZOEPUeZ5j+sOywGPwjQMv6Zp9xGELN/lhkpGBEMCzhZpZzd3o+Q4uDhV53WPvvHdVFGDb1QrQozMAseojJemksax
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:+YX8xuxanSKSYVVfuOiNJb8YO0lphvfi/yaan9VNl4C64zJ+ecPdUS1vxFVUYo77ryHl9vJghl8uI6qnqY/mmOAfFWB6NFfUsaCfnqMJZaiJrBQrvbuTzqdfFwUSmqVguNZacmuAprjTJn92B79kkx2A24zPRYxHTsqRyZPoLM7MAwsRmQa42pTmYzfPvi8Lr92jGeacFON1M5cdvTL55fpoNHfAwm2ET02zp6ftdevkqh0bl3gBL/UbFzrJpkHKQNJPeRoxq8Cgo39sSVa8TscyQG8ebz5qn1UYKedAVGaJ+ftLYJoDRFDM1A7dn5Cl39c6gMWvLzyItBUgWUpGTU5ntZLte3pa10IFa1g9H7n/5X51m2wQwBslIQaItcvqSGV6fw86HuPf14L0ejFO52jvWNFnR+IcFNHn9/D+Ougu+PfuEaFdkTq9jLuzoHfL6E0ZAqQWrMPDSfLegZ0fEA==;5:q2+DLxCd87Ej6aq7uXGXj/gT1+fDVpFQkOyGYajHXWaAnYJgN5EGRRmnRYFraTSSWRkMOykkHvFKb+kHUL8SkZaTVnGkbXldx5SAv7qUdnq51Ew7n250UZZj/yYuNKiLbSN9xg3EEEx6WwzTXcZleJnLgAPcMaSaLsCR51OofQw=;24:ipGJhdlAFOEoeEi8Jpjy4kNaFF60/KLstG1g9QsNq4PD0LvHXxrDaNL4ngUBFgEty9qrktft9znf5lpbiSs2Dxncl5Q5qferM9BcY5aPF7Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;7:6TqpR0e0Xu4yqAiZwZxYNS1WM10F0RTFFNaRrL4jQVmM2RpsWozbjnSTbfvClvRyyUxxLKJv/upUL8KWfbEp4XeMULcfxQRBxTfkdk+2/tqNOFl0ANShJRTKTHKhf1XNE3Vh5hpbV1yLYVdTYgbuLAEqfWpcysWQZ0NvEd7+GLY7KAWrsw1uzUHwAbjWulvRjTuyYV99dPzeFXFXrTOIbVQMrqsT8CgodTtyWDoyBp8m3mv31Q5omoqxRPoOrpNE
X-MS-Office365-Filtering-Correlation-Id: 32a7bf8b-034d-4dd4-4bd2-08d5c152ee4c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 08:47:06.8655 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a7bf8b-034d-4dd4-4bd2-08d5c152ee4c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed for annotating rt_mutex locks.

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
index 4f014be7a4b8..d33bc45b9d64 100644
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
+EXPORT_SYMBOL_GPL(mutex_lock_nested);
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
