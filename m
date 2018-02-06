Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeBFKUJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:20:09 -0500
Received: from mail-db5eur01on0111.outbound.protection.outlook.com ([104.47.2.111]:6209
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752248AbeBFKT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:19:56 -0500
Subject: [PATCH 1/2] rcu: Transform kfree_rcu() into kvfree_rcu()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: paulmck@linux.vnet.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Tue, 06 Feb 2018 13:19:45 +0300
Message-ID: <151791238553.5994.4933976056810745303.stgit@localhost.localdomain>
In-Reply-To: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR0501CA0007.eurprd05.prod.outlook.com
 (2603:10a6:800:92::17) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a534421c-ac89-49bd-7afb-08d56d4b288c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:kcsleADrTnFZgCjMZ42p8Dj32hiSK0zXM/vjans6gs1LQ6pgEBB+yWjN8CMLsIkMjUwIoLRpptxVdGLY6g6AHnRfQOouJTlWgukIBf17xxFQh1s9oP7SnB0tj2Nov8Fg1fe9CX0Ib2++s02ELVfrlmymwySdousWpUr3EmFcIwUiaP0VvXe0hPWF3LMabtTqzEOmM4E2P9AAkir270LJPXMbe0dDyVPl7GeMgX8AFeuK22ewBVpSzeeHerxKc9c1;25:n4ZhKKUqn1hmNogOOzFiZZnishWdjafgnPwRBdRXx7XZzthWA6HyeYi4A7CKjchZo7M3p6xMVtlbYTqdfH+CDvu5roRXaYWmf+NHytyab6vbvrbNL3Zgmkg98LXOONNTVL6PcJ6oq/Yf7wRWWn/tSUOVnpmvY2ZDpngvp9ps7T5yNNdBgVThcC7qpSQRmhwtT7IuUCPRRja0ZSGqcq02H37OKEW+RVUfOqV8WrWt8ysLTprESNJRaoUFsTh9jwQQHskqUJu3CTDC4d/wAB8/ONJYPuXh7wJcXjbZHeApCbg/nqC+/CbGReJnTDcZ3/i1T03zgDILzCL0EVqZ3mX60w==;31:/DCohsFsbqO61+5/wb9fIraUpnhD9YiiWBZmh7c3RG5luuFYNgtaFCOH26uxkgOPN0kpaN5klZcurM9mdOhCU+amU1cdC/L7wMPlkK5XvmoqU/NjW2I/C2uSy/j4qFjDiuuEbaoiLu9ws9y2NVp80/54BJAPDLIdE+sTJppIdI6ClBrcOSkrbhC2urBkIJ2641+s4aubJOxVFfaShB4zZK3cgBNLMlqP81utbs3YvQ4=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:JVKbhiHqmk3LrO+TcLtLk7UOZnmZy5LayivSi/LCqok6e4Jt1EiMjICz/WMfpHm/hAaIjvb1kAaGs0L+Fo64Tlvqm4S7z+bwavQGXMtxhAK6L0gddvKZVV4YziygYq7NGhcBw1oRiJEO1X32WtXh4iOZF5Z4U/curyQy6HgpJa6c6yHnBUhiLUoI5oQONAW7dbKoEUoAR1OIIpzYEH6/PHrdDx+PfWjGPfjLoxxMDZ0iO0+wEXSsoUuqDS4LZyRFD9tDT2pXyGfY66LECb1PKGXHVsDyoK6WreHDYOxEV1ptMWYhBS0C7OYjFFKbeQeag5zVmvR3hWNPJlwRpoTv1ftKmr0ojLZVTLltNiXzYBC5KITi+iUG6vW9gKXmYT04USqcZ+aO0W9GfDF9hMGMCgWc5+Oh1jnlEOVFvqhtKI0=;4:TH/7lOhhnUTnbuijA1B9vbzbJGzExLqticbd+HcsXD1EJ/+p2bP+KR5IV9K9aD9FnSq5/tGCqVZ0Wb3iviGNM9Ks1gIicga2Y+BkjBUrpVhPDEDpFQtO1Pn+YcRLL4XUbCVwMvxwbLde88ivtAeqN7R+Wa/LL1iQ5A11HHttqtIVt43Gfpvlfr0A8IDMjYjqa38u5gp2/fOKhdJkTkV1MIlPwSDI6n8NGvJW4p9K74Q80pYSK5HHbooOtDztCFdjQRvZ+xzHL2peCD8hTN0/R0r4tlULEzqCTpDCp5+vZ3tZBWnsZZT2RlQBafvQ7GqYqXbHYxuJ0GeTQocT638a3g==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13396B89A4D32D9E5F49D7D6CDFD0@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0575F81B58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(39380400002)(376002)(366004)(346002)(39840400004)(199004)(189003)(26005)(52116002)(50466002)(25786009)(2950100002)(6666003)(105586002)(47776003)(61506002)(86362001)(106356001)(8936002)(81156014)(81166006)(8676002)(66066001)(5660300001)(230700001)(68736007)(478600001)(103116003)(83506002)(2906002)(39060400002)(6116002)(58126008)(316002)(76176011)(6346003)(16526019)(186003)(55016002)(7696005)(55236004)(3846002)(386003)(9686003)(7416002)(53936002)(6506007)(33896004)(59450400001)(7736002)(2486003)(305945005)(23676004)(97736004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6bkFTMFI5WjZhRnlwQmhRL2Q1NVdneTA2?=
 =?utf-8?B?dHdFRUZQZys4UlJNbGY1aHJuVGRjTktKNExia2IrR083SVhCZkRtb0FWNEVw?=
 =?utf-8?B?ZVJYNk5ZMUhjRmV4Y0FTZXIrRDg3NGg5a1BVWkJOOTZ4S2lZMHJNM251TkhZ?=
 =?utf-8?B?MVlvQlJkY1VkNVNBU1VoOVFhU2hUdU5vSC9CU2dhUlpxRVdWdFdPL28zZkNU?=
 =?utf-8?B?dTJlUDN2cTg1YzZiUnFyZmRsRUFvNE9zVUNPYXZZLzJZQS93bW8xSmg3TW5t?=
 =?utf-8?B?dmQ3TU9tSFZrSlJIM2w1NWJ4TnBXd2sxaTRYeXFzYmw2VkZtV1VwRmZYSHF1?=
 =?utf-8?B?UDdtTitQanJBRGgreUl1dFA2M3RPenY4cTY4OUliWk92S0JQUjBMWUNLYVAv?=
 =?utf-8?B?NmtHRWVBY3FJd1VPOUZGdmRwU0t1RytlRzBrekIxRGxtVDloYk9wQkdJK2lS?=
 =?utf-8?B?VGV3ZUNRai90b0tYM3dzaGNKaFJrOFhwU0EzWHRYVkl1Q1UyTDVDMXJkT3FQ?=
 =?utf-8?B?OWtTUzE3RUVSMHMrcjN1Q2tLd2J5MkJPTUZHVHFCZmFNVkQ3aDZJSlRDSmZB?=
 =?utf-8?B?VExSM0NyNWxudHl2YnpQQjR3Zy9wYkMzeTduRTJncko0UmU4R2V3OTFBN3hH?=
 =?utf-8?B?VGR5Q1lkZlIxT0xxc0o2SW94dHBPZk5tVHRKTHp2ZTQrc3JNb1Z4WlBkSXJC?=
 =?utf-8?B?bnFzeTQwcUo5VTJqS0h4eCtKTlRWaDlEQnFST3pqaGJpMjM3K0N2OHVxT1FF?=
 =?utf-8?B?YkltU1dIM1A3cFc0SGZhTWV4WnBIRjg5SzgycmRRTkJFWUkxQ2hLQldaMHBM?=
 =?utf-8?B?WCt2VG9vWkVkbmNRZTRVSk4wYUloMEc3U2Q5SHJYZjN6THhzYUZxTnhkRnF1?=
 =?utf-8?B?Z2IyRVg1U0NQTTduMkErZXJtczlNMnd3Y0JIT0hlNXhpVzhMN0FUUjNPTUZ4?=
 =?utf-8?B?bC9SR2NOOVhMR1B2UGVpY1ZMUldwRkw3OStjeXFpMzZrc1B4ZlBTMHJtRStL?=
 =?utf-8?B?WmpUMGxBRW16M3M2YVI3QUFFTDkveWJFU3hDY3VHK0JjMllqRUFRdS84Wk03?=
 =?utf-8?B?Y2krNHhwc1RsTnpHMXVQdmIxa3BjTVNLaXphbWxhWjYwQTJpckxlZzRubDNz?=
 =?utf-8?B?djJIeGgwQm40VUpmK0FDRS8yT3JQODU0SjdRd0pmenRSQkRtTU5reFBJQk4v?=
 =?utf-8?B?N0FJUmxXd1NGUHBha0FySEd2RkFwUHprdmlCeU4yQWVjSThuZWRCNWoyRDcz?=
 =?utf-8?B?bk5YUHVvaVpPMTBYOTZDcCt1RjZqQmFPQ1k3VlVKMzRlVkREeXZzd01UUkpy?=
 =?utf-8?B?TmR0dlJhQWVrZENMS1piNTVERXgzbW0yaEp6TWZRSU0wSEt0dnpSNzVCNXlL?=
 =?utf-8?B?L2YxN05LRkIvbi85RTdTVnZGMDFGS2hmdVhjMTdXVXlrMC9RVExOU0xaWjA1?=
 =?utf-8?B?VTVzdW1LNEpXeXJSeWdpeGpwTVpnbGJQb3FyU1pJZnJkUGxwc013amJnUHlL?=
 =?utf-8?B?Q0NGaVNoc0FZekxNZ3k1YWFKbTZOUWxTdHZHU1h6bGV3VTJ4akQrMnRuMDN4?=
 =?utf-8?B?bWpHSkk4U0xvZThOOEd6bXc4NFZjbjNjenZ0WGJKS2lOY3YzdWxYMkFqY0NS?=
 =?utf-8?B?RUhOTDNHOGoyOEpNNTN4SytmdmsybllyMmI3ZDF5cDVUbU1XakR1b0hYQThp?=
 =?utf-8?B?Q3hUa2JGcDI1QjVnamFycnFlL3FET1A4Mmhpd0crUGUxNElRN2xLU3ZZc1NT?=
 =?utf-8?Q?JzHlh5T62p7ekC8uHSTK1REuIwEnnXhsWLn0SFc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:7dsNGXPOh+Is4voLfuakdddmwf/IXqWNXrQvqacf8FSVycRQSde6u/wAfsfYI6NQvn/jDw9bosItgGdHxHFQOYpI72oNARPdM3UHIT9MhvJp9aprMJGAvHxiYvnxF3Mjkwa2pIwQdX9gyHImVJ9AqAYvRkDcCnRSUBAlsmlgVkQamie0Cs0HhakHJUWH+BE7/dJNgqi3ePn9FL51Uvv9gXS7awTPV+Qp+NzUIjfZA+caWU1eNzjOFdaI+p+rONCTmkM32lPF6o+Khw/9jfxpb8EK5PbXFC65gBzTf9EAX167pMd5TqK/spPqnhbFREKAPOSSi2XmcojdDkyKQmni8GtE0hzMtLBdBj5jQ6CGEoU=;5:BgPhnyyqgb0FX9DoBTM6BDZstYmzXbGHDN+OnMTQtir6C3ShcqFM+Ge+jVFKWhbgCafNdMU3dcknOnw1QFbY7A7QdiT8t5A+Kjh3YHkbqblaSlBt8ZzyWFyh/m+tVxO7el/RjgX7uhfgwxukra/vq5JByTjzOH42OMMSHZgzI1Y=;24:NVUsrx/VuFP2kwoteqRsl7AC34Vdk9xkkrzo6LhOMAJx3LlDISPWdBQkidaXmoNSdCB0imrWYiEdxi5YzdJs8WCKf6o4s1CO+nWETGFCKeQ=;7:1A4NKG8savSN04ur6LPoG4xhnEvb00hxVlhzClZ6hg0Yc4tES7P3RP5w53CZdPf6cRj95wIcStd6edSqbAssVRgb9rAuvffp2oype44tugT1RkHHAYSk/+pNFy4nE5cWYIa5NYIDzke7tAxIq3bzECsgVEKYdBNXYPhboWb7v679z6B5ZDiLLqLG4gB5ScKkX++usXcitcWlWhGx8FbVJPQCykGka1kIZFnEa7x/83d3x9qQkzFLvDWpwgsjx9jf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:8m2yhQ+qS1vivOIMeZwLJbm5ihY3w0857lZcd7g/TLf7Jh6NK4giyfNXrTWZVvccV0SXQD7n5hgp59qAGviRQ5ojAzkf+KrHxOmuSbADByoxWv7N8SJNnK/0FBixg41KteNxhuCxmj+VJy/qUtWLF3wdE1ze4UAWJrZDoKag6uY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 10:19:49.7749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a534421c-ac89-49bd-7afb-08d56d4b288c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent times kvmalloc() begun widely be used in kernel.
Some of such memory allocations have to be freed after
rcu grace period, and this patch introduces a generic
primitive for doing this.

Currently, there is kfree_rcu() primitive in kernel,
which encodes rcu_head offset inside freed structure
on place of callback function. We can simply reuse it
and replace final kfree() in __rcu_reclaim() with
kvfree(). Since this primitive is able to free memory
allocated via kmalloc(), vmalloc() and kvmalloc(),
we may have single kvfree_rcu(), and define kfree_rcu()
and vfree_rcu() through it.

This allows users to avoid to implement custom functions
for destruction kvmalloc()'ed and vmalloc()'ed memory.
The new primitive kvfree_rcu() are used since next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/rcupdate.h   |   31 +++++++++++++++++--------------
 include/linux/rcutiny.h    |    4 ++--
 include/linux/rcutree.h    |    2 +-
 include/trace/events/rcu.h |   12 ++++++------
 kernel/rcu/rcu.h           |    8 ++++----
 kernel/rcu/tree.c          |   14 +++++++-------
 kernel/rcu/tree_plugin.h   |   10 +++++-----
 7 files changed, 42 insertions(+), 39 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 043d04784675..22d4086f50b2 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -832,36 +832,36 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
 
 /*
  * Does the specified offset indicate that the corresponding rcu_head
- * structure can be handled by kfree_rcu()?
+ * structure can be handled by kvfree_rcu()?
  */
-#define __is_kfree_rcu_offset(offset) ((offset) < 4096)
+#define __is_kvfree_rcu_offset(offset) ((offset) < 4096)
 
 /*
- * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
+ * Helper macro for kvfree_rcu() to prevent argument-expansion eyestrain.
  */
-#define __kfree_rcu(head, offset) \
+#define __kvfree_rcu(head, offset) \
 	do { \
-		BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
-		kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
+		BUILD_BUG_ON(!__is_kvfree_rcu_offset(offset)); \
+		kvfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
 	} while (0)
 
 /**
- * kfree_rcu() - kfree an object after a grace period.
- * @ptr:	pointer to kfree
+ * kvfree_rcu() - kvfree an object after a grace period.
+ * @ptr:	pointer to kvfree
  * @rcu_head:	the name of the struct rcu_head within the type of @ptr.
  *
- * Many rcu callbacks functions just call kfree() on the base structure.
+ * Many rcu callbacks functions just call kvfree() on the base structure.
  * These functions are trivial, but their size adds up, and furthermore
  * when they are used in a kernel module, that module must invoke the
  * high-latency rcu_barrier() function at module-unload time.
  *
- * The kfree_rcu() function handles this issue.  Rather than encoding a
- * function address in the embedded rcu_head structure, kfree_rcu() instead
+ * The kvfree_rcu() function handles this issue.  Rather than encoding a
+ * function address in the embedded rcu_head structure, kvfree_rcu() instead
  * encodes the offset of the rcu_head structure within the base structure.
  * Because the functions are not allowed in the low-order 4096 bytes of
  * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
  * If the offset is larger than 4095 bytes, a compile-time error will
- * be generated in __kfree_rcu().  If this error is triggered, you can
+ * be generated in __kvfree_rcu().  If this error is triggered, you can
  * either fall back to use of call_rcu() or rearrange the structure to
  * position the rcu_head structure into the first 4096 bytes.
  *
@@ -871,9 +871,12 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
  * The BUILD_BUG_ON check must not involve any function calls, hence the
  * checks are done in macros here.
  */
-#define kfree_rcu(ptr, rcu_head)					\
-	__kfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
+#define kvfree_rcu(ptr, rcu_head)					\
+	__kvfree_rcu(&((ptr)->rcu_head), offsetof(typeof(*(ptr)), rcu_head))
 
+#define kfree_rcu(ptr, rcu_head) kvfree_rcu(ptr, rcu_head)
+
+#define vfree_rcu(ptr, rcu_head) kvfree_rcu(ptr, rcu_head)
 
 /*
  * Place this after a lock-acquisition primitive to guarantee that
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index ce9beec35e34..2e484aaa534f 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -84,8 +84,8 @@ static inline void synchronize_sched_expedited(void)
 	synchronize_sched();
 }
 
-static inline void kfree_call_rcu(struct rcu_head *head,
-				  rcu_callback_t func)
+static inline void kvfree_call_rcu(struct rcu_head *head,
+				   rcu_callback_t func)
 {
 	call_rcu(head, func);
 }
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index fd996cdf1833..4d6365be4504 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -48,7 +48,7 @@ void synchronize_rcu_bh(void);
 void synchronize_sched_expedited(void);
 void synchronize_rcu_expedited(void);
 
-void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 /**
  * synchronize_rcu_bh_expedited - Brute-force RCU-bh grace period
diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 0b50fda80db0..9507264fa8f8 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -496,13 +496,13 @@ TRACE_EVENT(rcu_callback,
 
 /*
  * Tracepoint for the registration of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU type, the second argument
+ * kvfree() form.  The first argument is the RCU type, the second argument
  * is a pointer to the RCU callback, the third argument is the offset
  * of the callback within the enclosing RCU-protected data structure,
  * the fourth argument is the number of lazy callbacks queued, and the
  * fifth argument is the total number of callbacks queued.
  */
-TRACE_EVENT(rcu_kfree_callback,
+TRACE_EVENT(rcu_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset,
 		 long qlen_lazy, long qlen),
@@ -591,12 +591,12 @@ TRACE_EVENT(rcu_invoke_callback,
 
 /*
  * Tracepoint for the invocation of a single RCU callback of the special
- * kfree() form.  The first argument is the RCU flavor, the second
+ * kvfree() form.  The first argument is the RCU flavor, the second
  * argument is a pointer to the RCU callback, and the third argument
  * is the offset of the callback within the enclosing RCU-protected
  * data structure.
  */
-TRACE_EVENT(rcu_invoke_kfree_callback,
+TRACE_EVENT(rcu_invoke_kvfree_callback,
 
 	TP_PROTO(const char *rcuname, struct rcu_head *rhp, unsigned long offset),
 
@@ -767,12 +767,12 @@ TRACE_EVENT(rcu_barrier,
 #define trace_rcu_fqs(rcuname, gpnum, cpu, qsevent) do { } while (0)
 #define trace_rcu_dyntick(polarity, oldnesting, newnesting, dyntick) do { } while (0)
 #define trace_rcu_callback(rcuname, rhp, qlen_lazy, qlen) do { } while (0)
-#define trace_rcu_kfree_callback(rcuname, rhp, offset, qlen_lazy, qlen) \
+#define trace_rcu_kvfree_callback(rcuname, rhp, offset, qlen_lazy, qlen) \
 	do { } while (0)
 #define trace_rcu_batch_start(rcuname, qlen_lazy, qlen, blimit) \
 	do { } while (0)
 #define trace_rcu_invoke_callback(rcuname, rhp) do { } while (0)
-#define trace_rcu_invoke_kfree_callback(rcuname, rhp, offset) do { } while (0)
+#define trace_rcu_invoke_kvfree_callback(rcuname, rhp, offset) do { } while (0)
 #define trace_rcu_batch_end(rcuname, callbacks_invoked, cb, nr, iit, risk) \
 	do { } while (0)
 #define trace_rcu_torture_read(rcutorturename, rhp, secs, c_old, c) \
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 6334f2c1abd0..696200886098 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -151,7 +151,7 @@ static inline void debug_rcu_head_unqueue(struct rcu_head *head)
 }
 #endif	/* #else !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
 
-void kfree(const void *);
+void kvfree(const void *);
 
 /*
  * Reclaim the specified callback, either by invoking it (non-lazy case)
@@ -162,9 +162,9 @@ static inline bool __rcu_reclaim(const char *rn, struct rcu_head *head)
 	unsigned long offset = (unsigned long)head->func;
 
 	rcu_lock_acquire(&rcu_callback_map);
-	if (__is_kfree_rcu_offset(offset)) {
-		RCU_TRACE(trace_rcu_invoke_kfree_callback(rn, head, offset);)
-		kfree((void *)head - offset);
+	if (__is_kvfree_rcu_offset(offset)) {
+		RCU_TRACE(trace_rcu_invoke_kvfree_callback(rn, head, offset);)
+		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
 	} else {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 491bdf39f276..8e736aa11a46 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3061,10 +3061,10 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func,
 	if (!lazy)
 		rcu_idle_count_callbacks_posted();
 
-	if (__is_kfree_rcu_offset((unsigned long)func))
-		trace_rcu_kfree_callback(rsp->name, head, (unsigned long)func,
-					 rcu_segcblist_n_lazy_cbs(&rdp->cblist),
-					 rcu_segcblist_n_cbs(&rdp->cblist));
+	if (__is_kvfree_rcu_offset((unsigned long)func))
+		trace_rcu_kvfree_callback(rsp->name, head, (unsigned long)func,
+					  rcu_segcblist_n_lazy_cbs(&rdp->cblist),
+					  rcu_segcblist_n_cbs(&rdp->cblist));
 	else
 		trace_rcu_callback(rsp->name, head,
 				   rcu_segcblist_n_lazy_cbs(&rdp->cblist),
@@ -3134,14 +3134,14 @@ EXPORT_SYMBOL_GPL(call_rcu_bh);
  * This will likely be later named something like "call_rcu_lazy()",
  * but this change will require some way of tagging the lazy RCU
  * callbacks in the list of pending callbacks. Until then, this
- * function may only be called from __kfree_rcu().
+ * function may only be called from __kvfree_rcu().
  */
-void kfree_call_rcu(struct rcu_head *head,
+void kvfree_call_rcu(struct rcu_head *head,
 		    rcu_callback_t func)
 {
 	__call_rcu(head, func, rcu_state_p, -1, 1);
 }
-EXPORT_SYMBOL_GPL(kfree_call_rcu);
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
 /*
  * Because a context switch is a grace period for RCU-sched and RCU-bh,
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fb88a028deec..85715963658e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1984,11 +1984,11 @@ static bool __call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *rhp,
 	if (!rcu_is_nocb_cpu(rdp->cpu))
 		return false;
 	__call_rcu_nocb_enqueue(rdp, rhp, &rhp->next, 1, lazy, flags);
-	if (__is_kfree_rcu_offset((unsigned long)rhp->func))
-		trace_rcu_kfree_callback(rdp->rsp->name, rhp,
-					 (unsigned long)rhp->func,
-					 -atomic_long_read(&rdp->nocb_q_count_lazy),
-					 -atomic_long_read(&rdp->nocb_q_count));
+	if (__is_kvfree_rcu_offset((unsigned long)rhp->func))
+		trace_rcu_kvfree_callback(rdp->rsp->name, rhp,
+					  (unsigned long)rhp->func,
+					  -atomic_long_read(&rdp->nocb_q_count_lazy),
+					  -atomic_long_read(&rdp->nocb_q_count));
 	else
 		trace_rcu_callback(rdp->rsp->name, rhp,
 				   -atomic_long_read(&rdp->nocb_q_count_lazy),
