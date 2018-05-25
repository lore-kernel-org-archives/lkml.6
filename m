Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934184AbeEYMkF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:40:05 -0400
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:10239
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752099AbeEYMjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:39:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
From: Thomas Hellstrom <thellstrom@vmware.com>
To: maarten.lankhosrt@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH RFC 1/2] locking: Implement an algorithm choice for Wound-Wait mutexes
Date: Fri, 25 May 2018 14:38:54 +0200
Message-Id: <20180525123855.28956-2-thellstrom@vmware.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180525123855.28956-1-thellstrom@vmware.com>
References: <20180525123855.28956-1-thellstrom@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: HE1PR0902CA0038.eurprd09.prod.outlook.com
 (2603:10a6:7:15::27) To BN7PR05MB4579.namprd05.prod.outlook.com
 (2603:10b6:406:f2::13)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR05MB4579;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;3:xWE6bhF4BgBGmhj75Q8HnsF+3QjfneZTiTteZQeKkVdv8Q+9lUzoGp61JBF219ns9aXXwU0QFZDr1sttwAJ7TeMW+0mL9WoTXDrqTA6x8XzzC9dan3l14u9NWBqc4SFHXI5sZu7KDN8z+igOMwgnFFb1mFnrbmWmsOyv2x4vzJgDTh3yaX0YxqS2IU0P+rcHWDhIkAMguuCHHEZai332f40PDYvjg1Wu12zdBihJjYkMDnW0Cm5knf0ujcCdAszr;25:cl0Eq622IN6KYWzbrIvqm3yA8ie7zDNnagr0wSmoCWYsbKQr7yh6apu+mkA54ecyIyeyKLHeVCKIjIN3/UYXTzAYPQHCo7aJtKZyej7VoTtG2IhhDag7B2+Q6o8bndZrG6WSa93zCQl+sFzHPDgb3X7/biChh+EQh836HrSrR0TCZ79Lat9qF+Ktc4K8ha9cfAp/TmFCmLwYDNaViDoeV52dViwK/Y+EsAJOSUmigzxJDcZbZ8YX61uYbUtzwVLS2r8BKj5gWSAjSOnpCnfK8/NheOv/yK8tEO8H4jDgCf+8UosqMctYxMc2yejJlVJ74iLNX9kkjmWMYsiUbLYq3w==;31:3Jqybuka3MvXj5WbNMbFeOYmPdUzzfi8lNOGBYJj4buyfr7iczmDqiacaozHd4Zn3ofoWD99UEPB6t/Pfd1WKCd6jlfw3Vadxo8CLRPD47rFhe2/T5zlsNP8nNCZKj3GVQ8eW9+ZsUQXNH10TNDBGTdQ4sTXIr5M4QpDx4nUy/7QcLmiDWImnnkxBRSLfscb6a46PCLyRS/E8yChlPQyZVsxCkZO0KF9MdCD5cS4VuM=
X-MS-TrafficTypeDiagnostic: BN7PR05MB4579:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;20:XF72mV89a6DZzPEdJLp0VfMpDEUyAUEBmJSQSxC4J9Yx+J/y7ltK/UvDErIk/GUFlW7iArq7l0VBKDj1DeNT7K+a3TgYJfFXxnj7T5OOfGzGl/FYicD9mDwLG+0KYZGzcjZ1l4CX974DqJaHNHV50+KRs8RU7nOmZxKC70xF875wHCAwmQTVGBowRjfDNW6qmzcb5m7JkJNbgTOxZK5btC2lc3fkOXx8l3zkUaQl+Dk78IWGyxvmT44sfWyK0BQ25pFF8Qnlqz6SYQ3vSMkISYtQ1TgxaWwoVQqY5ZuP/A0IVyrTpBOqE/tC7IUURfM19Me7v2n6XErMY8jGMn6Uaqzo2SjPLLaeHnma2hQa6nLK7j8BViGKW8Gngt+ovFnT8IX/YTwvESR3R8VrsDx+3xprSf+V2UI1/4YH/NKVVFzfGYUXwGPMscUBy1oD/FAWPg97aDPhE89DJDYAeMtsSBEcpUeGIHdEKYYPpInWhEBO9L9SNZP0ai/wcfte6F89;4:dLo1guh6sDa4DcQ1onr/wTlRiZrd4tP41rkNMFvH33NCSDX39RC6LtWCFdzbqcb4lFudHOWYAzB6Pwlp28avyAszoaKGLb/rjml+mX/GsKAhM0BZB5JM3oUJLiCfzhqS+SaRa7xEKzj4F3VvkzPhat/VeWh2Vk2hkCEfPIXCHe8OhscuwkB+fRIX+npd3CKxkSD0AmH95yNo7n/2OHK0+evNGLA5FEponytDrxueg//Jtcx/6b/Ba0R86J/4KubzAq5co1gdQ571k1jssX9IRqX4cJvoL7IBrSmy/OUtaDM0KMY2s6iQetotZf57VIT6
X-Microsoft-Antispam-PRVS: <BN7PR05MB4579CB419BFF7F9370187E40A1690@BN7PR05MB4579.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN7PR05MB4579;BCL:0;PCL:0;RULEID:;SRVR:BN7PR05MB4579;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(199004)(189003)(36756003)(446003)(48376002)(50466002)(6506007)(386003)(25786009)(6486002)(5660300001)(476003)(11346002)(26005)(68736007)(76176011)(956004)(2616005)(59450400001)(7736002)(51416003)(52116002)(478600001)(4326008)(305945005)(186003)(16526019)(486006)(6666003)(97736004)(6116002)(8676002)(81156014)(551934003)(106356001)(50226002)(107886003)(1076002)(86362001)(575784001)(3846002)(81166006)(105586002)(8936002)(6512007)(2906002)(53936002)(316002)(16586007)(47776003)(66066001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4579;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR05MB4579;23:kpeMsCufShStjqJ4g9/boTZpxuCxm31NjrM32vloe?=
 =?us-ascii?Q?5p6wRcpQkr6HfFMKxnWNhHx4rzwEwZSJNOVnFZW6YcsG8VwSFRM+Nx784S96?=
 =?us-ascii?Q?4C6DE3JlhCyxdyf4DGlO6Fc5PMdicIUxP30aS6BlUmMXyPZOGtnWMCy1efuM?=
 =?us-ascii?Q?iFPRWQFfMquCJm3WS4r6pEtncXt1e5i+aGJ8dtG9lbI/sLGBW2Ultqb4QP3i?=
 =?us-ascii?Q?GjArIMIbpP9KauiUkAfjuLeV8DBBEcoecCzgum4y01iAAHxr2OpEdEW+p6rZ?=
 =?us-ascii?Q?uXCOpKaY7MWsUEZUTi82M9rWgOhaWCyJDbW85OnrLtChEuAbMWRzB8MJC1xE?=
 =?us-ascii?Q?U90hAnApok57H4vSKhC5euOMy/XRvCI0CA2vmwI0XHSC672dik5O7JGvC8Ud?=
 =?us-ascii?Q?sp+EAUXB/ZPYjdTVq7qFS1ldItTb6xVTJYqBJQaUOxGVb+JNvlLSQf/+ao0i?=
 =?us-ascii?Q?Dilwf4cPerYRajUBKlyApDXxiuRnj6cmTmPVNd+48KTPcwIrBa7vz2X5/GzM?=
 =?us-ascii?Q?lVwCS3kt8O5LyMf0nedVa8DgmtyN9V0pFxjt2c0d/YqGa4DiSLqzZHb+mkFd?=
 =?us-ascii?Q?sSs6LHgqdJ4rsKaTVnoBh+qQP46LSrJa/WHmf3dSaKpZxk8VfXiX85FAIQY7?=
 =?us-ascii?Q?LhSNMHpCiH7Hqdh1yjItMUMfeegddfVqNLRAQzKR2qgwak3MSebnzQ/v0ptO?=
 =?us-ascii?Q?H4sp11uFGNbISrIuT6oUbCCwbkg58MEhV1ZXiF/3VWjwwbXzWFa9zo2axOiD?=
 =?us-ascii?Q?HiHjnEZubeXdyyAMY0mvAsdpp2WL9zz0XVMKvL4XCeBhZ+w9ScsVtjVEUHLP?=
 =?us-ascii?Q?4GnJR7vhs/SI5rL3MhzJnNQTgfT5ZxH6UprqEq87Lg1PS0Dzdc0umxfKh73C?=
 =?us-ascii?Q?Se5Xm8OyFSYaW4m6NODbH/N0SgnqOYkwRKR+C9gRGFMidYVUObx4Ivq13BXC?=
 =?us-ascii?Q?TGTxnCfSXN1pS4dEt6E8TJ03Id7gYLvpaprJjrU7lRpu2OyuqH/yU8DZeQV/?=
 =?us-ascii?Q?KgGasWZNGviyPWSD5vSUHhtyiXS96aO+DyxWW647I+FIvg6R/GRbOFLVY21/?=
 =?us-ascii?Q?xuOgPv4cgEoaPyiH63v6HslO1hpyjnJRdd7p8PdiQLJSHhFBIP4E4Kh0UkBZ?=
 =?us-ascii?Q?lPjAxgmIkjJhBPMY3xI+ZXePYzNiEhStGcsCJucCdrj7+dmMP79MDM9Bjj5h?=
 =?us-ascii?Q?7shTEda3gXam6vlFalMLt8bBgwoodd7jfhFi5eT6QqaJamklxkauat8aAJGE?=
 =?us-ascii?Q?O2LoXfUwziHYwrGmLIkFYcvk3D5Xfj6eCH5mcwKmavHUSKpTy63NFB1ipef8?=
 =?us-ascii?Q?htLw4NdfGIwaVDWa5W3yd8=3D?=
X-Microsoft-Antispam-Message-Info: Gdl5xPLhm5xRhxtkZxEMua60iGFs8Y7u5wERpoDie+6ZKrgBRl0SqH0qk+UkRiUjOVXKvVOIIuVl3U1C6PYA3vcgWZMsiKNHXSBEyhliSsPpjsyniXj3g3pOtInhH6hrl6pbflEFSdaxOq4ja/Yze8bePWt/T8ekBTc0OavUbJ8IkWodLTDiczA2Nquo23l9
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;6:dHC+7Y094VHQyNpXnPkOPRVPe+p9uVbITUO6vFJtM5kivvhpGpFn8BJkJUINajoo6tpEFQyAjvnATR4rYoJRSLyagFymQsAABXuuzhHVi/ak5pD/pM0AYVQe/NW1H+SmWyzIJbsUQ2mNDfV4aQrv5BI67uDAOUONOJ5kQK92yRLEZ5JGQRx94WhPKxntqwPtyoDXIxncqQhp5hc4RJ5YQSWdKNHf6zBffly6lZEZIEubv15hMzKPRjnXLdNG3xu8ERhb85eu04VcAzVBDmuYjXgPLqOcn91ze49GhDbHhSt1EradVm2Kund/2kexVwCFPcXIev0HKiWdUfJ7MFBKzDI2bsgDtTTXK8Mgi5N6uIuflxvOVvYHehjeO46o0DaXYuvG2Aqsx0f5mg18FGzb2uYgumsV+NlyO3I3zow62cKxqF7HkuXCAr+B0azDi0ax3E06H0kRfug7TNAorulDIw==;5:SUDCHbpJ0rR+EXzaNRejcVng9ORL81WnY053JH2r6x6KM34hFsorglqQDJDxyKX9sZlkR1pYTw5f5UTDqZf2cmsh+Uas6Ib9lB91FnWZFtK49EB/0XLr+yd2q+H61Rq8DBvZtakETsW1nDlJyKByVQyjL+dF5pmHdGmPcK0q0gc=;24:qQCq/F3FHSLxQh9uzQ6W4hQGJIHVGpBDVR2M8vSjXdtzBZmFqbH2MEm+3i4CH4SdUxoY1ovgY8A3OuZOh6BXbJZbTbsbjL5/6+mYtgDjBSQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR05MB4579;7:sbklSVlVEZX5W6YO5sdfyumhNh/aifpcbnH9j/LJud1IPlZrhMDgc9Xr2KV8fTUMAJbutW6P4C1kAGrA5GMrA7JFPIQ0AWK7+9GbnsJYZBTzNd7VxLDX3TxILjOFNtS82sCMx3pFFm7yZyc4IjYIusw3vM0o2JxYD4ZyHN35Cj79XwKGQ11tL/QsHwoQG9n4zqZEl6sVHVI7CnxDcfd7ViEO+Hhu2iFbSblAsNvJNnXayrAjhdX3LBzVTXDiycmr;20:c1Be6EWyYZW5LApbeRby9lEFGIaT9hPmrwc368sBBuDZBfIKXr0ZQInxqvFBvrK+pj4HuU8fcY57HrJykM6RNPOJWIeCSIPyWtZj79CzM+aexzyEe0Q5AZ+D8djHBFLjASO3cuM++avMq9EcVCWS8/NFZfxR84mf5yYwX3/zjMo=
X-MS-Office365-Filtering-Correlation-Id: 5aea1a29-4394-47cf-13d9-08d5c23c9748
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 12:39:42.6036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aea1a29-4394-47cf-13d9-08d5c23c9748
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4579
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current Wound-Wait mutex algorithm is actually not Wound-Wait but
Wait-Die. Implement also Wound-Wait as a per-ww-class choice. Wound-Wait
is, contrary to Wait-Die a preemptive algorithm and is known to generate
fewer backoffs in some cases. Testing reveals that this is true if the
number of simultaneous contending transactions is small.
As the number of simultaneous contending threads increases, Wait-Wound
becomes inferior to Wait-Die, probably due to the larger number of held locks
of sleeping transactions.

Update documentation and callers.

Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 Documentation/locking/ww-mutex-design.txt |  57 +++++++++++++----
 drivers/dma-buf/reservation.c             |   2 +-
 drivers/gpu/drm/drm_modeset_lock.c        |   2 +-
 include/linux/ww_mutex.h                  |  19 ++++--
 kernel/locking/locktorture.c              |   2 +-
 kernel/locking/mutex.c                    | 101 +++++++++++++++++++++++++++---
 kernel/locking/test-ww_mutex.c            |   2 +-
 lib/locking-selftest.c                    |   2 +-
 8 files changed, 154 insertions(+), 33 deletions(-)

diff --git a/Documentation/locking/ww-mutex-design.txt b/Documentation/locking/ww-mutex-design.txt
index 34c3a1b50b9a..29c85623b551 100644
--- a/Documentation/locking/ww-mutex-design.txt
+++ b/Documentation/locking/ww-mutex-design.txt
@@ -1,4 +1,4 @@
-Wait/Wound Deadlock-Proof Mutex Design
+Wound/Wait Deadlock-Proof Mutex Design
 ======================================
 
 Please read mutex-design.txt first, as it applies to wait/wound mutexes too.
@@ -32,10 +32,23 @@ the oldest task) wins, and the one with the higher reservation id (i.e. the
 younger task) unlocks all of the buffers that it has already locked, and then
 tries again.
 
-In the RDBMS literature this deadlock handling approach is called wait/wound:
-The older tasks waits until it can acquire the contended lock. The younger tasks
-needs to back off and drop all the locks it is currently holding, i.e. the
-younger task is wounded.
+In the RDBMS literature, a reservation ticket is associated with a transaction.
+and the deadlock handling approach is called Wait-Die. The name is based on
+the actions of a locking thread when it encounters an already locked mutex.
+If the transaction holding the lock is younger, the locking transaction waits.
+If the transaction holding the lock is older, the locking transaction backs off
+and dies. Hence Wait-Die.
+There is also another algorithm called Wound-Wait:
+If the transaction holding the lock is younger, the locking transaction
+preempts the transaction holding the lock, requiring it to back off. It
+Wounds the other transaction.
+If the transaction holding the lock is older, it waits for the other
+transaction. Hence Wound-Wait.
+The two algorithms are both fair in that a transaction will eventually succeed.
+However, the Wound-Wait algorithm is typically stated to generate fewer backoffs
+compared to Wait-Die, but is, on the other hand, associated with more work than
+Wait-Die when recovering from a backoff. Wound-Wait is also a preemptive
+algorithm which requires a reliable way to preempt another transaction.
 
 Concepts
 --------
@@ -47,10 +60,12 @@ Acquire context: To ensure eventual forward progress it is important the a task
 trying to acquire locks doesn't grab a new reservation id, but keeps the one it
 acquired when starting the lock acquisition. This ticket is stored in the
 acquire context. Furthermore the acquire context keeps track of debugging state
-to catch w/w mutex interface abuse.
+to catch w/w mutex interface abuse. An acquire context is representing a
+transaction.
 
 W/w class: In contrast to normal mutexes the lock class needs to be explicit for
-w/w mutexes, since it is required to initialize the acquire context.
+w/w mutexes, since it is required to initialize the acquire context. The lock
+class also specifies what algorithm to use, Wound-Wait or Wait-Die.
 
 Furthermore there are three different class of w/w lock acquire functions:
 
@@ -90,10 +105,15 @@ provided.
 Usage
 -----
 
+The algorithm (Wait-Die vs Wound-Wait) is chosen using the _is_wait_die
+argument to DEFINE_WW_CLASS(). As a rough rule of thumb, use Wound-Wait iff you
+typically expect the number of simultaneous competing transactions to be small,
+and the rollback cost can be substantial.
+
 Three different ways to acquire locks within the same w/w class. Common
 definitions for methods #1 and #2:
 
-static DEFINE_WW_CLASS(ww_class);
+static DEFINE_WW_CLASS(ww_class, false);
 
 struct obj {
 	struct ww_mutex lock;
@@ -243,7 +263,7 @@ struct obj {
 	struct list_head locked_list;
 };
 
-static DEFINE_WW_CLASS(ww_class);
+static DEFINE_WW_CLASS(ww_class, false);
 
 void __unlock_objs(struct list_head *list)
 {
@@ -312,12 +332,23 @@ Design:
   We maintain the following invariants for the wait list:
   (1) Waiters with an acquire context are sorted by stamp order; waiters
       without an acquire context are interspersed in FIFO order.
-  (2) Among waiters with contexts, only the first one can have other locks
-      acquired already (ctx->acquired > 0). Note that this waiter may come
-      after other waiters without contexts in the list.
+  (2) For Wait-Die, among waiters with contexts, only the first one can have
+      other locks acquired already (ctx->acquired > 0). Note that this waiter
+      may come after other waiters without contexts in the list.
+
+  The Wound-Wait preemption is implemented with a lazy-preemption scheme:
+  The wounded status of the transaction is checked only when there is
+  contention for a new lock and hence a true chance of deadlock. In that
+  situation, if the transaction is wounded, it backs off, clears the
+  wounded status and retries. A great benefit of implementing preemption in
+  this way is that the wounded transaction can identify a contending lock to
+  wait for before restarting the transaction. Just blindly restarting the
+  transaction would likely make the transaction end up in a situation where
+  it would have to back off again.
 
   In general, not much contention is expected. The locks are typically used to
-  serialize access to resources for devices.
+  serialize access to resources for devices, and optimization focus should
+  therefore be directed towards the uncontended cases.
 
 Lockdep:
   Special care has been taken to warn for as many cases of api abuse
diff --git a/drivers/dma-buf/reservation.c b/drivers/dma-buf/reservation.c
index 314eb1071cce..039571b9fea1 100644
--- a/drivers/dma-buf/reservation.c
+++ b/drivers/dma-buf/reservation.c
@@ -46,7 +46,7 @@
  * write-side updates.
  */
 
-DEFINE_WW_CLASS(reservation_ww_class);
+DEFINE_WW_CLASS(reservation_ww_class, true);
 EXPORT_SYMBOL(reservation_ww_class);
 
 struct lock_class_key reservation_seqcount_class;
diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 8a5100685875..f22a7ef41de1 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -70,7 +70,7 @@
  * lists and lookup data structures.
  */
 
-static DEFINE_WW_CLASS(crtc_ww_class);
+static DEFINE_WW_CLASS(crtc_ww_class, true);
 
 /**
  * drm_modeset_lock_all - take all modeset locks
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 39fda195bf78..acc0d93acc8b 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -8,6 +8,8 @@
  *
  * Wound/wait implementation:
  *  Copyright (C) 2013 Canonical Ltd.
+ * Choice of algorithm:
+ *  Copyright (C) 2018 WMWare Inc.
  *
  * This file contains the main data structure and API definitions.
  */
@@ -23,15 +25,17 @@ struct ww_class {
 	struct lock_class_key mutex_key;
 	const char *acquire_name;
 	const char *mutex_name;
+	bool is_wait_die;
 };
 
 struct ww_acquire_ctx {
 	struct task_struct *task;
 	unsigned long stamp;
 	unsigned acquired;
+	bool wounded;
+	struct ww_class *ww_class;
 #ifdef CONFIG_DEBUG_MUTEXES
 	unsigned done_acquire;
-	struct ww_class *ww_class;
 	struct ww_mutex *contending_lock;
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -58,17 +62,19 @@ struct ww_mutex {
 # define __WW_CLASS_MUTEX_INITIALIZER(lockname, class)
 #endif
 
-#define __WW_CLASS_INITIALIZER(ww_class) \
+#define __WW_CLASS_INITIALIZER(ww_class, _is_wait_die)      \
 		{ .stamp = ATOMIC_LONG_INIT(0) \
 		, .acquire_name = #ww_class "_acquire" \
-		, .mutex_name = #ww_class "_mutex" }
+		, .mutex_name = #ww_class "_mutex" \
+                , .is_wait_die = _is_wait_die }
 
 #define __WW_MUTEX_INITIALIZER(lockname, class) \
 		{ .base =  __MUTEX_INITIALIZER(lockname.base) \
 		__WW_CLASS_MUTEX_INITIALIZER(lockname, class) }
 
-#define DEFINE_WW_CLASS(classname) \
-	struct ww_class classname = __WW_CLASS_INITIALIZER(classname)
+#define DEFINE_WW_CLASS(classname, _is_wait_die)			\
+	struct ww_class classname = __WW_CLASS_INITIALIZER(classname, \
+							   _is_wait_die)
 
 #define DEFINE_WW_MUTEX(mutexname, ww_class) \
 	struct ww_mutex mutexname = __WW_MUTEX_INITIALIZER(mutexname, ww_class)
@@ -123,8 +129,9 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	ctx->task = current;
 	ctx->stamp = atomic_long_inc_return_relaxed(&ww_class->stamp);
 	ctx->acquired = 0;
-#ifdef CONFIG_DEBUG_MUTEXES
 	ctx->ww_class = ww_class;
+	ctx->wounded = false;
+#ifdef CONFIG_DEBUG_MUTEXES
 	ctx->done_acquire = 0;
 	ctx->contending_lock = NULL;
 #endif
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 6850ffd69125..778ed026382f 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -365,7 +365,7 @@ static struct lock_torture_ops mutex_lock_ops = {
 };
 
 #include <linux/ww_mutex.h>
-static DEFINE_WW_CLASS(torture_ww_class);
+static DEFINE_WW_CLASS(torture_ww_class, true);
 static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
 static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2048359f33d2..b6e730c7d42c 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -290,12 +290,46 @@ __ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
 	       (a->stamp != b->stamp || a > b);
 }
 
+/*
+ * Wound the lock holder transaction if it's younger than the contending
+ * transaction, and there is a possibility of a deadlock.
+ * Also if the lock holder transaction isn't the current transaction,
+ * Make sure it's woken up in case it's sleeping on another ww mutex.
+ */
+static bool __ww_mutex_wound(struct mutex *lock,
+			     struct ww_acquire_ctx *ww_ctx,
+			     struct ww_acquire_ctx *hold_ctx)
+{
+	struct task_struct *owner = __owner_task(atomic_long_read(&lock->owner));
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (owner && hold_ctx && __ww_ctx_stamp_after(hold_ctx , ww_ctx) &&
+	    ww_ctx->acquired > 0) {
+		hold_ctx->wounded = true;
+		if (owner != current) {
+			/*
+			 * wake_up_process() inserts a write memory barrier to
+			 * make sure owner sees it is wounded before
+			 * TASK_RUNNING in case it's sleeping on another
+			 * ww_mutex. Note that owner points to a valid
+			 * task_struct as long as we hold the wait_lock.
+			 */
+			wake_up_process(owner);
+		}
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Wake up any waiters that may have to back off when the lock is held by the
  * given context.
  *
  * Due to the invariants on the wait list, this can only affect the first
- * waiter with a context.
+ * waiter with a context, unless the Wound-Wait algorithm is used where
+ * also subsequent waiters with a context main wound the lock holder.
  *
  * The current task must not be on the wait list.
  */
@@ -303,20 +337,22 @@ static void __sched
 __ww_mutex_wakeup_for_backoff(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
 {
 	struct mutex_waiter *cur;
-
+	bool is_wait_die = ww_ctx->ww_class->is_wait_die;
+	
 	lockdep_assert_held(&lock->wait_lock);
 
 	list_for_each_entry(cur, &lock->wait_list, list) {
 		if (!cur->ww_ctx)
 			continue;
 
-		if (cur->ww_ctx->acquired > 0 &&
+		if (is_wait_die && cur->ww_ctx->acquired > 0 &&
 		    __ww_ctx_stamp_after(cur->ww_ctx, ww_ctx)) {
 			debug_mutex_wake_waiter(lock, cur);
 			wake_up_process(cur->task);
 		}
 
-		break;
+		if (is_wait_die || __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
+			break;
 	}
 }
 
@@ -338,12 +374,17 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * and keep spinning, or it will acquire wait_lock, add itself
 	 * to waiter list and sleep.
 	 */
-	smp_mb(); /* ^^^ */
+	smp_mb(); /* See comments above and below. */
 
 	/*
-	 * Check if lock is contended, if not there is nobody to wake up
+	 * Check if lock is contended, if not there is nobody to wake up.
+	 * Checking MUTEX_FLAG_WAITERS is not enough here, since we need to
+	 * order against the lock->ctx check in __ww_mutex_wound called from
+	 * __ww_mutex_add_waiter. We can use list_empty without taking the
+	 * wait_lock, given the memory barrier above and the list_empty
+	 * documentation.
 	 */
-	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
+	if (likely(list_empty(&lock->base.wait_list)))
 		return;
 
 	/*
@@ -653,6 +694,19 @@ __ww_mutex_lock_check_stamp(struct mutex *lock, struct mutex_waiter *waiter,
 	struct ww_acquire_ctx *hold_ctx = READ_ONCE(ww->ctx);
 	struct mutex_waiter *cur;
 
+	/*
+	 * If we miss a wounded == true here, we will have a pending
+	 * TASK_RUNNING and pick it up on the next schedule fall-through +
+	 * spinlock.
+	 */
+	if (!ctx->ww_class->is_wait_die) {
+		if (ctx->wounded) {
+			goto deadlock;
+		} else {
+			return 0;
+		}
+	}
+
 	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
 		goto deadlock;
 
@@ -683,12 +737,15 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 {
 	struct mutex_waiter *cur;
 	struct list_head *pos;
+	bool is_wait_die;
 
 	if (!ww_ctx) {
 		list_add_tail(&waiter->list, &lock->wait_list);
 		return 0;
 	}
 
+	is_wait_die = ww_ctx->ww_class->is_wait_die;
+
 	/*
 	 * Add the waiter before the first waiter with a higher stamp.
 	 * Waiters without a context are skipped to avoid starving
@@ -701,7 +758,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 
 		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
 			/* Back off immediately if necessary. */
-			if (ww_ctx->acquired > 0) {
+			if (is_wait_die && ww_ctx->acquired > 0) {
 #ifdef CONFIG_DEBUG_MUTEXES
 				struct ww_mutex *ww;
 
@@ -721,13 +778,26 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 		 * Wake up the waiter so that it gets a chance to back
 		 * off.
 		 */
-		if (cur->ww_ctx->acquired > 0) {
+		if (is_wait_die && cur->ww_ctx->acquired > 0) {
 			debug_mutex_wake_waiter(lock, cur);
 			wake_up_process(cur->task);
 		}
 	}
 
 	list_add_tail(&waiter->list, pos);
+	if (!is_wait_die) {
+		struct ww_mutex *ww = container_of(lock, struct ww_mutex, base);
+
+		/*
+		 * Make sure a racing lock taker sees a non-empty waiting list
+		 * before we read ww->ctx, so that if we miss ww->ctx, the
+		 * racing lock taker will call __ww_mutex_wake_up_for_backoff()
+		 * and wound itself.
+		 */
+		smp_mb();
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+	}
+
 	return 0;
 }
 
@@ -750,6 +820,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	if (use_ww_ctx && ww_ctx) {
 		if (unlikely(ww_ctx == READ_ONCE(ww->ctx)))
 			return -EALREADY;
+
+		/*
+		 * Reset the wounded flag after a backoff.
+		 * No other process can race and wound us here since they
+		 * can't have a valid owner pointer at this time
+		 */
+		if (ww_ctx->acquired == 0)
+			ww_ctx->wounded = false;
 	}
 
 	preempt_disable();
@@ -858,6 +936,11 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 acquired:
 	__set_current_state(TASK_RUNNING);
 
+	/* We stole the lock. Need to check wounded status. */
+	if (use_ww_ctx && ww_ctx && !ww_ctx->ww_class->is_wait_die &&
+	    !__mutex_waiter_is_first(lock, &waiter))
+		__ww_mutex_wakeup_for_backoff(lock, ww_ctx);
+
 	mutex_remove_waiter(lock, &waiter, current);
 	if (likely(list_empty(&lock->wait_list)))
 		__mutex_clear_flag(lock, MUTEX_FLAGS);
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 0e4cd64ad2c0..c7fc112d691d 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/ww_mutex.h>
 
-static DEFINE_WW_CLASS(ww_class);
+static DEFINE_WW_CLASS(ww_class, true);
 struct workqueue_struct *wq;
 
 struct test_mutex {
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index b5c1293ce147..e52065f2acbf 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -29,7 +29,7 @@
  */
 static unsigned int debug_locks_verbose;
 
-static DEFINE_WW_CLASS(ww_lockdep);
+static DEFINE_WW_CLASS(ww_lockdep, true);
 
 static int __init setup_debug_locks_verbose(char *str)
 {
-- 
2.14.3
