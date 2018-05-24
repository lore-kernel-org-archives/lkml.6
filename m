Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935705AbeEXHdS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:33:18 -0400
Received: from mail-eopbgr40136.outbound.protection.outlook.com ([40.107.4.136]:42544
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935580AbeEXHdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:33:12 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-i2c@vger.kernel.org,
        Peter Chang <dpf@google.com>,
        Deepa Dinamani <deepadinamani@google.com>,
        John Sperbeck <jsperbeck@google.com>
Subject: [PATCH 1/2] rtmutex: allow specifying a subclass for nested locking
Date: Thu, 24 May 2018 09:32:54 +0200
Message-Id: <20180524073255.22495-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180524073255.22495-1-peda@axentia.se>
References: <CAFNjLiXZk3Zigfpy9Hj2uY92sPGB7msUxoZHf6pFDOWSuBwkBA@mail.gmail.com>
 <20180524073255.22495-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0174.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::22) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:msL7+SmqCCWF7F70menvLBrHWMylsqjIJ4QTR2+fv7+42qNQMWGOnGqItuhtQ43YLK6w70u6cJ3vGd9zKG++E+ivMccc7kQGbJ5cKnUPspyeLC9yGTB88LtfC26oHxmPHs3JucpgvRVfzTsUKx26e1Bvz3OhZKPw9mtrtP3KIKdkaQvzEzO3PEB0I/wTxYoZERLpgDv2Qjk8lIpsjOqMLyr/+nVPW88tAaZIDkXuNjxMOrJqYkOoIvH+mQZvvUTz;25:ZAEi5+PpgBrzmGCiGdnrCOKppUlI0mdqeO7ErzSioiyAkd/sorzEHGDCr3HU0G0Jy6ylFtfGcV0lc4ZYdk9azj5PJOkZoirbIllsHLuwVhqwxKKoTqAWb4QZEqY1KIPadzA7EhrL3Yi4G/AwLLALMONti74Bhtq2mPtoUIxxhY93oUq31u7geMC+eA7mOXRauEM1/ui1byN4xvMcyMHt+Y2EWWXogyHqBCbejN3I4gD8NougO3fRIe4XwOW69FEzyhVej1Pqsu6SUMSISA1ek3uBP47CsxdWw9hBbcs/Ym354KT3zhITN8Qj9pFqY58vk6cpI8IF3MVYvp8F0DYGHw==;31:XVpfZiFuS9Sb7Q6i6k2Q5ENwqN6wQS10+Va8JyAVP4+F2xLVdTO5PcQLSCiOSja3852ZgnyKBR2bkRecUcO/Zo/OGCn15LI+w+LngNNvDY1PpY7jSRq1RJsPMAHUCHDTDa7g8Xsrk+VMaZM1kh/qVn5zvDVCWrsTWmSJxD5S71wvWVbISbBrED1emI9kRtcVwkdc840QKuZIBZdF5de1dXrGOw1z6amhRPZly+OOmEs=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <DB6PR0202MB277608D76F85B40CE55ADBB8BC6A0@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:/AD6bbe+7EISjL9ZGnh376sGw2Q+9nquaDdN7sqTa4U+AU7LlIAFzlTOw5eGrmk3typSrnpKBlVCKTTTrYpcqNNeJmuDhZD0bk2sq+XICPjjNo48153A5Lf3YQOs4F2BeEBN9XC9eclyI/QF4AiUxiqQr+uKk4LUSHU6ggN4A5NkjJCWrCLjECvEKjzGsF7unLiAredz4RqjcyoA9eiLEGDieh3YW/y074QbQjZeANgaUyIHDq0YrrPKBjiJ7tY69OtTCl9eq6sqmEzOHI6FHg==
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(366004)(376002)(39380400002)(396003)(199004)(189003)(36756003)(2361001)(50226002)(5660300001)(2616005)(956004)(446003)(7416002)(476003)(25786009)(8936002)(16526019)(186003)(486006)(6506007)(386003)(478600001)(66066001)(59450400001)(6666003)(47776003)(26005)(6916009)(74482002)(2351001)(51416003)(76176011)(52116002)(86362001)(68736007)(106356001)(105586002)(1076002)(4326008)(7736002)(2906002)(6486002)(48376002)(3846002)(305945005)(6116002)(81166006)(11346002)(8676002)(81156014)(316002)(53936002)(97736004)(50466002)(16586007)(54906003)(6512007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0202MB2776;23:C9Usd0YsYmysAlmYSJDC5ZfNAgcY/5Ubj1lhKLE?=
 =?us-ascii?Q?Z8SIwFDpF0vK680YBFj9G/RLLNCub6f2dSIsJV8vTHQO4JMahkY+XOrxoLt8?=
 =?us-ascii?Q?+lbhgaf2c0UtR/t2ez8Id1kvKgxVPu8Sw1c05kwBY5s6VGQeFf+gfN7VuruE?=
 =?us-ascii?Q?lrh2JmJI7/fK2B3Iw9WE0v72ExztepUF2CDILUpOu+CctTv8SLlDzu7wZIsU?=
 =?us-ascii?Q?//StavMZALZgD3t3ctpCFviGksrp/Rwiq6iXbEZP/63rvemPWqw677hk+vk6?=
 =?us-ascii?Q?KprjyXBGys/oI+esrNxAgzQPdZTWvTKrXSl1BhebqzLR92rbWGeA4j5e+/CS?=
 =?us-ascii?Q?eefFMi4vuPNvkAvTPycwRcjGnNQMlh0t/yijqsD2OBKeGTIcrApIJQOGQScC?=
 =?us-ascii?Q?JljbcYDhX+x/jl0/1gxBnSBEbJjzd99JR745NqkCrOIkhi3jIXULbqTUrxKD?=
 =?us-ascii?Q?FK6gMalbD56nd7pvn38Dqol2+ilqZCZUDgFRuCXiIoU5Zgxz+cRWoVa5C2OP?=
 =?us-ascii?Q?Hw6iy8gDEUwFNg9A1SVVcQsrlWQvAR/ux1FSIniPfk3JZDtaIEVQ2YEY50sV?=
 =?us-ascii?Q?lWmD48DiB7flHbzcIm1+ayZ3WS678kEfCwh8uErA1oCdPOKyJn1eSoYzwlB3?=
 =?us-ascii?Q?sSkvwBvvBw6G9HFvKzV/31wyTH0g1KUB7fBc+JSxmldNOhS77lK86hSeX960?=
 =?us-ascii?Q?f17JspoSi4mmlyhgZmMyzOwIFhyR8ib1J8sC5KsKjiBJQp+USsDhAOgPgEFv?=
 =?us-ascii?Q?CqTlRxk0W+Id2704qRwwhKL4i54g6yFp2kUEvr5/mvXtk8jmra2NYdTZt3xV?=
 =?us-ascii?Q?rHd7TYgBqQJE+LHgah/9U6HbcbyrRQQ8WuohXMK5cBSZn5ZjsxqldVAYvPtb?=
 =?us-ascii?Q?HHWYcdrxebtHMs99wEZlsiRhrBeWeq8wVbGEGrE2tZjhHpd2m47QZB5PZpvu?=
 =?us-ascii?Q?HGRrV4nYG2AC15iaYf7/3RcBGlWDhwzUi5L6ST0jcWuTB3eVGesI3npeOVsS?=
 =?us-ascii?Q?UMZunaZNxd/jfuhxEAme7nO8FQuDT6bE5sQbkPmPTC91I7DjZVnHosbQ/Bfj?=
 =?us-ascii?Q?q2uCMVi51IvLUlc3XOHe+mqWEkT0h2AeBiWUpf7Vb8GWlGyEwNCwbJ4d6UXO?=
 =?us-ascii?Q?zhTt6sDqN9Za5x37WVp/Y9Mxve89P3ofSLAktxWVGui9vbY/a7tLxuPdozTy?=
 =?us-ascii?Q?oR00qA1yjsssSi9sZJ3PTRZOdHBxUV6lHQpZoWSLksdRat9FzNE269Dpyuea?=
 =?us-ascii?Q?YbLo4nhlhkVrqDnMqU0j45Jt5f81Osw7cCHG08+HjxYDQbM47WEu0lKkhD0e?=
 =?us-ascii?Q?nI3vVwWVf8QkVO0F3//eUk3DbRp6BokG+HRZiabuhgc8O?=
X-Microsoft-Antispam-Message-Info: Siy5nNrrqUfa2r+4OaTEWioDjURiBmVRSsdWlNUIjaqHsCuIpL/+O2QBmrEgZTsveoKfSQI0UnJq1fzLG4/yt5KTl1iy+b8UJdLpmwEAZoubmbcu7zlLHBSHSj5LI61ZzQ8DlP5hz0/GVHcw85ithee/hmrgFGzc2ZV80rtmLBlljtH0igYcpPRi6bn61SRq
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:3LfylTaPOLEgu4EhpGexuZnmzHL6rZpHjxfZ2RoksNCiC42kqlhdz4DzfJePKB/PwWXwFGwicqT7gkzg5OrPVEvt32jzKOkS7J4ipd9yCbiIVDKHVM46Dd+fDkswH+5+ozjUXjJwN/zCUydZaXcNMfluBNuwxJiYoSjFAx2UHZedNTOdICFN9gvf9mPAMRRbB3RMLHW5nD4D9O3HDMqGBEMekGrQd6ZOmKyQYK9h8UCGNdltmgv7BQ3RioSMdaTmQAzcu7OeulUBZqwKiJI1ltGg4bbINxr6BSQ+YZJV+vzBJDM63rbnDxexfszMsAHSBM1czNCNMJtA8vcKj4PBYnKF0nEvE8V/kocR3AQNA4P7KfR853abttgPPnpQm7KmUF7tzBKIcqoyHiHHgFDtX5UoKj5Y7DD+1nBQHDmoPdAMGDA7+HeoiBWHu5yqcwQslCZvkNmyCb1xMCI5QxGyHQ==;5:fUHaRwNod6hetnsqaG5HiD09cpcuxaYEimwFazN0DXExfvbbzlTIr+uYXEYbsvrfhlf7BuRMSyRFmlJEVAs9fezeMDy+yf59CVRlHSAOPXSpTnuWwG+RK62b80KRrzp5nBOQYBosonZ9JHVF3KBZYzKtHcFCqzIxwAXzJb0K1C8=;24:U76eErXfc4mQlfhx6oLpa7zUhzEvb9PH4tVb1vk9Z4W5nfVzaH8YxIkO9tJqYKXagSYTONqz72rsr6eyTWTD5jkQGLWOS2SnigLztx9g5NA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:iYtpqUVQvS9Dpsbk2NGsiyaGfbYL8eaEWBoG8ADDUuSVTwe5JupDPUQrYnOgSwcGiPnkHezlG/d/PIcZGzuKrqEs3OwyoKaFQ1oBrAgxndoXE8hGZyJnqMqvnAWSlgtdv7MXfVoZCA7E5c1pYDVTSQzbsE4HAxojdD7YZNsjYhzpEZCGXRAJtOu1N3Z3pWDJ9khDvpQS5ADfv2XJSmLPOCvDuZPMEvwyX22ZS3HXI94fzES/slnc3V/u26J6wZ8U
X-MS-Office365-Filtering-Correlation-Id: dc80863e-dbff-4ee4-c42e-08d5c14899a2
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 07:33:09.2492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc80863e-dbff-4ee4-c42e-08d5c14899a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Needed for annotating rt_mutex locks.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 include/linux/rtmutex.h  |  6 ++++++
 kernel/locking/rtmutex.c | 29 +++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 1b92a28dd672..32e18527be64 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -106,7 +106,13 @@ static inline int rt_mutex_is_locked(struct rt_mutex *lock)
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subclass);
+#else
 extern void rt_mutex_lock(struct rt_mutex *lock);
+# define rt_mutex_lock_nested(lock, subclass) rt_mutex_lock(lock)
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
