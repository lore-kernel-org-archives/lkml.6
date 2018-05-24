Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970133AbeEXNxZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 09:53:25 -0400
Received: from mail-eopbgr00093.outbound.protection.outlook.com ([40.107.0.93]:13536
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S970016AbeEXNwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 09:52:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH v3 1/2] rtmutex: allow specifying a subclass for nested locking
Date: Thu, 24 May 2018 15:52:39 +0200
Message-Id: <20180524135240.10881-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180524135240.10881-1-peda@axentia.se>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524135240.10881-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:7:66::22) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:mrGCDtLK792tGRfTBeDrSBU0nWLV6luuZgYgORCUQ4mM6zXow/5Q6vtm9lywHQdLc6ng5LplyRAaqHh3NVGsrSCzyDhlHX39giUEpgbHUklL1pFFSE/4++rQFQ0xfwS53Zz+hQ6Dyzlduoeign7wyH09w5h1s9FIpsa5LStjH+rYSq28PCd7ORUiafyX5VVmLPxIpZwHTv51k5FzHhy//wWuOLCaTx0qd0v0DyzAieNbBcLZkEOCC+rf0v1n0BK+;25:pEBr9bvuvaPKvSfY2qefHfPKSbxgPdGg0o9Ljw1MdsBO2cgV/6wZ/C45QVoDaNFTCKGjhP9oMS35Waw3cmUMkpG9SCfBmj9NLc4Cn52WQOSqArAzqbeosiotPkjJPo6PlUggmHWTMILGBVZVTVKFsl2SEcAROT3iOYJi39rp7BtQRojy7WRyEScV+BN25qMSvlIEayn/AcggjlhdRIF8167OqjJks81iSgvfUDH2FmygOwlQF4QgtfE+V6epqGaS6kkNj6WmQdc1/XPlIVRzvYQ6VDx6bYVlrk+F5esg536JFa3TfbqPMw+exNV1Bo3RqR023DrmfDkINR1m1z0dmw==;31:6yUJgaZIwCBHAp1d7jEsNQlcd7kKrWZnjboJVI4O62y4qdyqqQPwMEzalQyAFI8+oZZUz8gzBikUetdTnw/1ZsWaPykrkzMx92buaSK051fxG0OGYlYkBEQ/KgTg4ESRRiSSx6OZng3LRe0ki+xnd9AZ0/82eMpZSW56sr3AHhd72lLY0+/2/5fEL6BteHH2tXsgtNHoj82s6FuW5lw6hodXidpjrM01VTVeqbC2zIU=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782B899F725C22276860ED8BC6A0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:aSHkxjnF4AHaKIbO9JWvx3akebabvmuBa/GysPoaxa1PpoVDMcm9gzfpIT9GuSha8esKNlqS7pZ47sjN70dHSCybbfa63DY+0jXloMuzIJk2BljKcDRXumI5eG0terTAPLthHHYaNe9i5WxnYsYv+gRPCivjkBpE0soYXWqiMLTsAPL4hOKTkCsOeA2UvPuD5p9iZoFpuUrAoXZUzuHPt41lQaxbC2Kac/8/OAzdG0WJzDU5IREU3u7KeKPt+bJcEXS/2dFknRc3DC3EPtOhnA==
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39830400003)(396003)(39380400002)(376002)(189003)(199004)(25786009)(8676002)(8936002)(305945005)(7416002)(86362001)(7736002)(16586007)(6486002)(76176011)(59450400001)(52116002)(51416003)(575784001)(2361001)(26005)(81156014)(186003)(16526019)(105586002)(316002)(6506007)(386003)(81166006)(54906003)(106356001)(48376002)(50466002)(2351001)(47776003)(50226002)(66066001)(74482002)(6116002)(68736007)(478600001)(956004)(486006)(97736004)(476003)(3846002)(6512007)(446003)(11346002)(4326008)(1076002)(2616005)(36756003)(6916009)(2906002)(53936002)(6666003)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:M4wbFTsIfqmpej3uhmMi4kQulzCbpXFaPsX0A02?=
 =?us-ascii?Q?MCRRnrpYBoW5WwCpiehCckzsnQO9IhYI0JJGRgr23uE7Nvr/0qLnZ47RMviF?=
 =?us-ascii?Q?w81YrlVsslu6ACAXg1ovU4cAbJvn7xTkGFVFjQPUH++oM2MPhqAEgPGXv3IJ?=
 =?us-ascii?Q?tnEqCEjaDH0Il9u+A88ggVXca42mOvU1uUGuvGt9nwkY5KZX9r0015FoIFP3?=
 =?us-ascii?Q?swqRBJHSmhuIG87V3sw/dUf9pA3civJ4TkSPLNnW6uuXDGwV+l3FcEXzoLTK?=
 =?us-ascii?Q?tU12afoabkgvxNOq5kUzrhGEFYzqBssiO81fGItcEX6K+G+KETaF5FlvjRD0?=
 =?us-ascii?Q?p9uVZi7et3QdEgzZmJ8YUBtvnBN31r2uE+OO9q1Gz1YBF5RQYN5oAY5jggDI?=
 =?us-ascii?Q?hdIKVzsYznWNx51k/Qg48LJ0YhE/KKgXeAZM4vNrQP+kwfZwfQSD/OTNIAmd?=
 =?us-ascii?Q?9HY29CaL+HA54EJCXEcZPvD4h6gXQV7rnW1E618rUUG1ewX0wBiycgGgRt3H?=
 =?us-ascii?Q?Bd1GXLXWGBfL3zHZ1kBxBbas2Zm8PJ8Dg3Yp+JIt9ADf/nhBOFDfWTBcQcVz?=
 =?us-ascii?Q?YFaOFIh7zE5DyNR1b5D8Hn/JYMCTPusyw3PsU9cEuVA4NJaRJxIJhtTSa4ql?=
 =?us-ascii?Q?H8fFCLx+pqV4fjSO9yYJnhxVBBO4QW/3dPWYI+SUOlvQi4/cxHZW28jr8eBs?=
 =?us-ascii?Q?P1fbMW71OoUHRtEG+aDnASHCGYzLAWoK1DqWnlytgXiZxDeEBu7ajxSp0Hka?=
 =?us-ascii?Q?iguwYgToEpKfIKvQMLhGgj+uEsPDKbTZjjMyX1VXVVPnvAwza41fjoV4/yPV?=
 =?us-ascii?Q?uWbRW/0VK7Kte3TWAkN5oBOzB/Lof9DJsNJbgBYyNWNP8dRjUxTHwVoIHkkP?=
 =?us-ascii?Q?YiZ1h/kznCqYs3MafZSPOOoORDuLMArVj6Fws5+bumrQHtqnXzuHLqn5nYSH?=
 =?us-ascii?Q?w0v1Qm8XBRouQBTfBHkKpY5EYIwNDSoskFs9zbafJ230PY1TVH/xZhhqi92f?=
 =?us-ascii?Q?xC0KbqrXUSv7u3v8UZu0wnb/loYitgJTVXImfQ+MUE/LCoI+jaGP76sLtEDy?=
 =?us-ascii?Q?zE0a5FMkoGDrnCAAoK8N3ZEaeCgb9jtuFumSfHcmumDoi3UcGztBeitzzSAZ?=
 =?us-ascii?Q?fLHH/DRB5tIAEfTkf4QGBIoAjVTXlT3MgrPnKaDtGS4Ztp56Ox+YLrrQkaOp?=
 =?us-ascii?Q?b9O0+HM5XYxZOFHGuAKki1HwU4VQ+Zj8P1w6hX0C8jEazeCkZQUFp9oKpcqi?=
 =?us-ascii?Q?fj5JiNCHWz+kLBYRWH7qJd5167kK4gwFHHHkWdw8vMIBK5CQrWHS4XcWDY0C?=
 =?us-ascii?Q?A70rswlfnmYc2cN5FZL/3c1++enGUwG0pL8ofI+MAto2WjvTBWvY9s4xayk+?=
 =?us-ascii?Q?n5OVwUew4tGuWqiiI6yTitFdNhKo=3D?=
X-Microsoft-Antispam-Message-Info: l8a9SFeUgqSg2mOtniyMyfY7tScZJdQPHPenyZszOxsO8VCPVyDkYY61TR4u08JFeXeirjwm8k876po3Ig6VNDxm0RIZdFHq2rR/UCJFVLo94d6gvmbrld4SOcI+KC9ubVmpdijvqfcS9OmIrhzTjSb9shSbrxv3pt3qtAGNd7yI0O+F9Fq3geNqEPjqzfZq
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:Y1ha61CA5+KKjWcOK3LqgWX/lgtmm2jm9AhkRH2H8nBRanoG+rZKXu8zX2QzhZafPE8AZW9ATjxkJeaAVrSkqGdsg07ov2xOtl5zvToeo5QoAkhAf6p0h5Wo6YB6TGgKAfy/HjvwRBN860nymCUuxKon9lqtGgGZjHR0zSukxVP54dA81tURMNWENzg1IcTFcgShsizze+GbRvN9JwbybLVFvT6yljJ2wp2vFWxzqao0Yq7H94YS+wi0XzgwlMriUAwFddbKSfBJ840PdEmaxar/0JXVMcwAIqs9S93Fgc6WEhgwCAvgyRj9Fcx+wDyGPOBe9UUKxMMwE0s9NjPM0VCw2NiRcmRNVtl35XK5N5HwTA84eidi3trIT2GZfk6xsuJtRlN6c6Rtjovm52HXb6hoPfomXxyrLJYrH6H4+J1NrwUKAWoTmVPGWeMVIU7oPk2kANExDnCV0k8c6i69NQ==;5:HEUylAJhmgUH77+fM0Yj7g8LyJhnVO6+mPAlO9fraQBybiOIn4EH2Y6PpIqH8jF63vajh6O599EymHw0LUVRWHekUoe2NPDjG4wYayyA69x0qB/EsDxxFk3viytLEatc7lat650HE8YYgy5bVFsIZTgYVMs3Mjae5Nm20kOj5X8=;24:Uw1bkxWOh4LgU7yBTZzB44OTqDTeQkSK8NLZ2Q7go57nWDqM5G16HA4aE7Y03izBCx9OxrCZwNLRu9UBr7siZJeDLcw6r/yxrZGU0AbZSMI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:+7BjnRu3RusfNAvn98Ze0aDlQvhDrVrDim8xWkRj1rijMbyKsgA7g8VlPs9gkiztYZWVXFDNZd88tI67KBfbvj6NhaOK9lD9wUIexKVsNg0nIrYLAM6ckVk0ZLkPZ1nbJBVDVpsXAHGFdWdFg3xR9ORdYNfkgQpmunVYISRXBrpyTnMbq+wwLuA3LD9Cz20lhq690nvIF9NmS/5t1P+A13jvSPhgqyNJWUhFVZ2yi3SlYkXYmWt7ier1C6Y/+g2+
X-MS-Office365-Filtering-Correlation-Id: 1a517364-9da5-488e-facd-08d5c17da5a4
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 13:52:52.7074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a517364-9da5-488e-facd-08d5c17da5a4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
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
