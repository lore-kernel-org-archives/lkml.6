Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeEVKHv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:07:51 -0400
Received: from mail-eopbgr50105.outbound.protection.outlook.com ([40.107.5.105]:39474
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751601AbeEVKHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:07:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 02/17] mm: Introduce CONFIG_MEMCG_KMEM as combination of
 CONFIG_MEMCG && !CONFIG_SLOB
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
        mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
        lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Tue, 22 May 2018 13:07:33 +0300
Message-ID: <152698365328.3393.18066403280990272261.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM5PR0402CA0017.eurprd04.prod.outlook.com
 (2603:10a6:203:90::27) To VI1PR0801MB1343.eurprd08.prod.outlook.com
 (2603:10a6:800:3b::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1343;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;3:RxrR5UzZJNN6kEgASq2Xcre4DD0U10YXu7VuKkeUz5LTACxmjIJs2wAHCgMg1hjw+ZN0kB8GwMqKLf7J4z9keqPvlabwDJzPl5Mc6wDmbWlY0DyceO7YvIIOQF+chLPWUCqxc/ONdm97AMXubiI4LwSUa71oPnwa6dyhd9O6C1tOi98GlzkcJd2QccKlDOcHv1WPL86Zi1BDDsMrbwQN1mCPEzkLGHJCfHgY1bJZfXsqqlRKbOIOFQtjz11nFwy0;25:Mt0aVK/vsvDLR8MkyjjCOKJMmTxGORXpVnNm6s6dLy2z7njOfyoyZWzxLahlkfhiqygNrdiWsJVXfYqhtzOPBBmJJvMxUOCLtGecdbIVAcBOpwih539piBhUNfQIerzv0T/fySpuW7zz00tu6AxiOui8ZTnFjkps2qzwWhj1VM+aUpziDUx3XqjpW0OXRMdRSTJiCUJOPR9wW8k4HqeC5oGsAR9V70/IcMj88aJ3HN0ec6cjTux4B0WISCK0FUzla22ZPc5O3fFQOQvO9GHEXSuQXVAnBpB9R1ZwPjrwktCZCSfSGyiBwj8RFdTMfMu6cyuvnclP9oCco+W0HMA8mQ==;31:UYGVxfgK/8UeQH5Y2pMoOrvYIVYeDyaEYJKgFZaVoOp+pS95+806Q5J4xV9kaDuEE1whyU3aI8OEND56torxIMnSSieCDWlUDu6J3HdxafoVzobmOLoDnXnvLQ1XkKeWvSK4ZF7tP9Lg77h+LSeMshe2SNYXZ0PghmB+xyjGm/Bj7OhzB3CjAdUAP1oawqU/pUiiOhga7GbRJqjj2HNwbAH0BipbaxJfdgQDLPkLktk=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1343:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;20:BMEKDdRM4suQ7pG8Hb9feRRoIq+gO1TE14k/cK1pMl6faQmXEg0TH/ccneRCyz/o40+dcvanOY75UBdcXkkpAGQccpAbjpHEPVDUThKj/B1ipTe+o8iIoRA/xWa0r2ZUpecrRrxgXcFSPqrtqJT6RN728pabSwjGsyUfAdQCfD0D7PQo6nsPFkjp/affylcBrU1r236NWZRX9Z9LOtRUhjTWAluUO5CZXMJVs8l84VnxmAUDoAaMbv5mAbNXAHzgdLMXanK2hijDupkRZQT2MZNSXvWD0c9ncsP6NWPBwJDKjouWYGG1sRsRb0kM40AU6TBf3OxDKrYU9TwLTy4a3PegvhZkyGhQ5E/A1jvQFdsP/Gx+Uybx0onP8TxTNURwZXKHaM+m0wwsESxXEHEaxj1uiGXk6DaWB4RtAmun+YyVWctR/Zz5+5agySYafjldPma0hFGmzGuc6mnz3BfsHAcl4aUYCajv4XazHaFudDGwUBEjqZozoVdbJveRS00N;4:uOa0KODZznnIuRxSJHZy4iSp3WKESE/gkurVFBSp1N7VowqKo0lQrTI5Hbzxht2sYWKIUaWel6r+pg+yDOOHEmcSmqfEt/ONs+Zr81fPkR1B3y8/FgZ3eiFulwyQIa9SJv3uoVZsFbuxvfF/ZcY6ynWF5FcvrtWr8vqLjuKgQKJOz1kOT4GELdbZFMGjD5ShOaKTUQIWllc/H0YH94XnnM6GobWKoXNuGdy/cNXvWCcSjkYTaRHQH5JsDdmnCFraKb8Bfr/AFT+kL8FP2FIt+MRAr67FULcZdrGSeKJWWYx+rLdUWPA8IEuYYHXwrRg3
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13430F228EC23AA971F620B6CD940@VI1PR0801MB1343.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1343;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(39380400002)(396003)(39850400004)(376002)(366004)(199004)(189003)(8676002)(8936002)(186003)(16526019)(9686003)(486006)(6506007)(55236004)(6666003)(55016002)(386003)(33896004)(7416002)(76176011)(2486003)(5660300001)(23676004)(52116002)(7696005)(39060400002)(6636002)(53936002)(47776003)(26005)(478600001)(86362001)(575784001)(50466002)(81166006)(81156014)(105586002)(66066001)(7736002)(305945005)(446003)(11346002)(103116003)(59450400001)(58126008)(61506002)(25786009)(106356001)(956004)(3846002)(230700001)(6116002)(316002)(2906002)(97736004)(476003)(68736007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1343;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDM7MjM6WXZkVHI4NzBYN0NKM1BPYjdvV1JhSnJ2?=
 =?utf-8?B?azRUTVhEcVo1L013YlZISzZYSlhWaDY3OFhFTGpwSGtkTkwxeVQ3VExJTUxs?=
 =?utf-8?B?TVZJekVaNjFLSU1YQmQ5bzFFQ3ZPL0VTV2hoazdwY0ZmU1hzWFkxRXFVYmNI?=
 =?utf-8?B?M0Nvd1Z6R2FIUkxNU250cWpDS3dQOWsrZ3dMVnhNL2NyMkp4bHQzMVBVeUpy?=
 =?utf-8?B?UWhwNmsvL2djOVM1enJiVzlFaW9yUmYySll4YnhzTTlGMDJqL0RmRzNZZGxF?=
 =?utf-8?B?RWI1OUFNNE83UkJPL25lOHkyOXJyWm1HTyt5T015eDQyYzY2S0dYRjdydDVl?=
 =?utf-8?B?TVNibGtObHpRYUFIOHlJUWZEQm1mdVJCNHMzanNSbkJjeUplbi9UUys4WldX?=
 =?utf-8?B?WWU1UXlLSytMVGhrYVNOL3R0TzMyWGE4YWpHNGNSM21Hb2JTQklVdDVkUU9o?=
 =?utf-8?B?WXFVZVRCWHRjSFNad25JTVR1OWZBUit4UUJhUUtjY05zaHhBMFBNZjMrWEVU?=
 =?utf-8?B?TDRXRVA1bSt5cWFUZTlndFFFMXNRMGEyRWZsb3pBMTlkbkZxeXQ4QVJWaTBk?=
 =?utf-8?B?NVdjMVVwUVdXSTlWZnZ3bWRQK2Qra1pqZm9Wa2tjQmlJb0lCMUhxaWRFeFQx?=
 =?utf-8?B?Ri91cEF1aEFiVktvdG5RS0Fkd25KUEZxK1RYdDc5bDFTaWR6bFRVT0FBYnQ1?=
 =?utf-8?B?Y01aejhsL2VvcXRXM2tXWUNhWVlKK1NEUWR4YUllaWZJRGxqVGhDc2RqY1JU?=
 =?utf-8?B?OVlnVHplZWJsTTlwMVRydTdNUFpMNzhnYUlrN0tLaThheHZNczNrRjFnL244?=
 =?utf-8?B?QnNVVTRTTGNjell6RHV1emQ0RGV5YlZSZVZlcktXalBWRURuVG9BYkozc3hQ?=
 =?utf-8?B?WHBnWDhncWgyLy9CTnUrNlN4MVZwNUtJa3ZibUs4eDZoNm9KYjYydmZ5WXAy?=
 =?utf-8?B?YnZkOWROemlWTExXVzhUbDRtSVgzNklNVkNpbWtqbWcwZTBoTlA2YmFYQUVy?=
 =?utf-8?B?MlFsODBVQS8yWmZFVUdYWE1WSWcvdTcyYndXWkNVZXhzOTZyS3hhMWZWZEN4?=
 =?utf-8?B?dlUxNE1hRHFLb1Rzb0w1WFlxV1NjdVNzRGhLS3MybFh0bzJRRGZKOXZsK1o4?=
 =?utf-8?B?b3UxUHRXWFdJMVp1enN1ckx0YnQrdkRsdURUY25RWVlsUHVLekVDdTZWV3cz?=
 =?utf-8?B?SDNpOEtoYkhQSzE1RlduUFJ2ZW1xNVlJSE9TdUk1MGFUTjg0MzNLYzFtd2Rx?=
 =?utf-8?B?b21Qd2F4eUJnNXVEWG1YNzROVG5wcUp1MDVLVjNhMnFFV0x5NytPV2REWWVs?=
 =?utf-8?B?SnprVHlBRFIvZTk0ZEhvcGNpSUc4YWJRdGZuZjVra2hDNTZKT3pnSkJndGdB?=
 =?utf-8?B?bCtUQUJvVUoyYXJIcmZIZFEvZXJqS0dTblEycnAzKytyTngrampMQUNHNlpJ?=
 =?utf-8?B?aTJtRERpRGF6MUlMT3lGUWZQR1RreEE3NGFZNHNSZU9jZlF3OU1SQkwzQmYv?=
 =?utf-8?B?SFZMaTF2OXJHaG1QWGdaN0Nmb3EyOHFVaFNHai80QkdxY0lETGhla1pvb3A0?=
 =?utf-8?B?Mjd0VFBienR2NnVtcWxBRHBpc1I5aFlNL2VucDBNZlRpTFp0eEdTVitoNzlU?=
 =?utf-8?B?SmlXVjFhUmEwREVVL2pmbTBUTHhteWxubytUWE9nL2FXNm1YbTlyaXZSL0hz?=
 =?utf-8?B?T3F3QjZzc1V4R2E3ZGZYZXlZNzczV0xLZVhqaFMyNVlHeUx5N3lUTTVRYTh5?=
 =?utf-8?B?WWNsWFpqVEExNFVrb2ZrelZkTk5HczNaQS9sNG9ZYm9MRjRReUlHU2NVUHJ6?=
 =?utf-8?B?Mnh2RFhaYXFyTXlZVHBTdzZacDZSeDFnV3FRaHpyWmhyRkVuZEsvY0VmUTBk?=
 =?utf-8?Q?WnvqIo+4nVwEU=3D?=
X-Microsoft-Antispam-Message-Info: FOavEaJgbkdC6n131w2AV9AcZ6ybEcVKSn3FKPr8dni1MJKEBAEfHOytpVRZSd2issrtcnUe1soK5AZfiA5lHG1wJtxQGTM8dzaTsc44Hl4BjFnDL6mUUHK/F4AQtkJfe2kNDecit4GfsU+eNBoIDA0AVCSkRex1SO3LQFfMiT4iIds2dzQ+zZGOXcGeywKq
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;6:O3ytGX6uaNEDq9EWpVqer3KdUiLfsq1zQi55gnHuHIe0uTukfjValQ3ti2tUCoGb28x0bkaDd128hPVUYY675Pr11UiNdC4vQt1Gif84DUeRD50nm4oajSyYILh05e/U40UlE9TgwVWIt3hLjlSPhryIGeUxoMsEXwoWdnD5KzgBpb4qdYg5MjAd1lzz3gCtzKzfOw4nXUADSmmfTrMvuUU/IslsZC1977FqooZ4/o00OksYfid3pB+OVT8LBZ62JI9mtw3iGSfN8jOYVD6LHEp4Josun9Q9P1We/vQcIhhOQotY5weeLdngmjzbruZmxVbiHWqsjZZTHqExutcXZicSvvVpvP5AyfgxSDDsrHX3Fa2z3W4hOpBp4Xj2ghu2Sin9FK8kKO0fKo2hxaVaPpQ1THMz1xIJ6fh4ppz8RxNy87X7EcPJ7raCYqNgwFdzJlfZpF0NENjP+BGU3lXkXQ==;5:5ZMR6Z9UTPcKFoLMK2ZFo53ZOWb6ozH0reZGYIigwSsno6YidUeFTXC/3xse2Z+j/4ArftSvQH2aIKMPgd4hPlyEFFY6Ft++sWs8aH79Hsns+A4nwwFzs5NVF5S2GsBP6fHxTR4+Z4Pbv/FHn8AUpP2ktqFs+pJApkvh3/+i0Zk=;24:8mRrbUiHDtNNqOcMFHvWlvxeDaYgY2swUWnPtSmY9o/p9Vr73Nw6325/CVlKHtnjvhb8rXMKvs/z5NEPvGt5iHuH+IeYCfgguMcfq9wkFAY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1343;7:sjojXCLk9OWLejcSs+lAoKCM+psSvcrbvlhmCBwOFE+3KSyhd1NRCN0/HBm2myFNyUuKQIREUlrxwspYz2d3b+QWkQkk5nokkS/sIEi1ZN9KRzXmMniYqAjYahQx0ElSnxr6FxbZcjqkO73ylxzxbqQ7jAKiYnKmPY1MgBnr6HSL66++3jC3CQqywTJV1ZgckU6CELKNKnTK1LiT2shXSyfKr4+ETZ5BnGJ+lNA3ZoTp2+9i8TBQ1Om1jhTCWBQn;20:aquJpkrHY8S0hmSATeN35u9A4CIc19/ocMYgZFiUI1TGVloFRbVIhtspJG3eTqGvO2zO+ZFenXzphk+JLpNhZ2SXEODTk1vJxr+rJjjXKB4ckQnExh3tBQGDuosVkfIH7Sri+2FajmHzanNuviBPXXQEOW4nA4Z4nJPBelWhqYM=
X-MS-Office365-Filtering-Correlation-Id: 4777ab26-e4ef-4220-773e-08d5bfcbd8da
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:07:36.1817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4777ab26-e4ef-4220-773e-08d5bfcbd8da
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1343
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces new config option, which is used
to replace repeating CONFIG_MEMCG && !CONFIG_SLOB pattern.
Next patches add a little more memcg+kmem related code,
so let's keep the defines more clearly.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/list_lru.h   |    4 ++--
 include/linux/memcontrol.h |    6 +++---
 include/linux/sched.h      |    2 +-
 include/linux/slab.h       |    2 +-
 init/Kconfig               |    5 +++++
 mm/list_lru.c              |    8 ++++----
 mm/memcontrol.c            |   16 ++++++++--------
 mm/slab.h                  |    6 +++---
 mm/slab_common.c           |    8 ++++----
 9 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 96def9d15b1b..2d23b5b745be 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -42,7 +42,7 @@ struct list_lru_node {
 	spinlock_t		lock;
 	/* global list, used for the root cgroup in cgroup aware lrus */
 	struct list_lru_one	lru;
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 	/* for cgroup aware lrus points to per cgroup lists, otherwise NULL */
 	struct list_lru_memcg	__rcu *memcg_lrus;
 #endif
@@ -51,7 +51,7 @@ struct list_lru_node {
 
 struct list_lru {
 	struct list_lru_node	*node;
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
 #endif
 };
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c6d2ca859802..996469bc2b82 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -264,7 +264,7 @@ struct mem_cgroup {
 	bool			tcpmem_active;
 	int			tcpmem_pressure;
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
         /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
 	enum memcg_kmem_state kmem_state;
@@ -1230,7 +1230,7 @@ int memcg_kmem_charge_memcg(struct page *page, gfp_t gfp, int order,
 int memcg_kmem_charge(struct page *page, gfp_t gfp, int order);
 void memcg_kmem_uncharge(struct page *page, int order);
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 extern struct static_key_false memcg_kmem_enabled_key;
 extern struct workqueue_struct *memcg_kmem_cache_wq;
 
@@ -1283,6 +1283,6 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c4e70e8481c3..0ccdbdec1e5b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -722,7 +722,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_MEMCG
 	unsigned			memcg_may_oom:1;
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	unsigned			memcg_kmem_skip_account:1;
 #endif
 #endif
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9ebe659bd4a5..5b63d08a0e43 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -97,7 +97,7 @@
 # define SLAB_FAILSLAB		0
 #endif
 /* Account to memcg */
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 # define SLAB_ACCOUNT		((slab_flags_t __force)0x04000000U)
 #else
 # define SLAB_ACCOUNT		0
diff --git a/init/Kconfig b/init/Kconfig
index 44e62e0dc51f..bcea6671a3ff 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -680,6 +680,11 @@ config MEMCG_SWAP_ENABLED
 	  select this option (if, for some reason, they need to disable it
 	  then swapaccount=0 does the trick).
 
+config MEMCG_KMEM
+	bool
+	depends on MEMCG && !SLOB
+	default y
+
 config BLK_CGROUP
 	bool "IO controller"
 	depends on BLOCK
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 37d712924e56..232bb637cf02 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -13,7 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/memcontrol.h>
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 static LIST_HEAD(list_lrus);
 static DEFINE_MUTEX(list_lrus_mutex);
 
@@ -104,7 +104,7 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr)
 {
 	return &nlru->lru;
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
@@ -297,7 +297,7 @@ static void init_one_lru(struct list_lru_one *l)
 	l->nr_items = 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
 					  int begin, int end)
 {
@@ -556,7 +556,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 static void memcg_destroy_list_lru(struct list_lru *lru)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
 		    struct lock_class_key *key)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bdb8028c806c..fc67e43849eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -251,7 +251,7 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return (memcg == root_mem_cgroup);
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * This will be the memcg's index in each cache's ->memcg_params.memcg_caches.
  * The main reason for not using cgroup id for this:
@@ -305,7 +305,7 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 
 struct workqueue_struct *memcg_kmem_cache_wq;
 
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 /**
  * mem_cgroup_css_from_page - css of the memcg associated with a page
@@ -2123,7 +2123,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
 		unlock_page_lru(page, isolated);
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_alloc_cache_id(void)
 {
 	int id, size;
@@ -2388,7 +2388,7 @@ void memcg_kmem_uncharge(struct page *page, int order)
 
 	css_put_many(&memcg->css, nr_pages);
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
@@ -3001,7 +3001,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
 	int memcg_id;
@@ -3101,7 +3101,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 static void memcg_free_kmem(struct mem_cgroup *memcg)
 {
 }
-#endif /* !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
 				 unsigned long max)
@@ -4405,7 +4405,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->event_list);
 	spin_lock_init(&memcg->event_list_lock);
 	memcg->socket_pressure = jiffies;
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	memcg->kmemcg_id = -1;
 #endif
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -6322,7 +6322,7 @@ static int __init mem_cgroup_init(void)
 {
 	int cpu, node;
 
-#ifndef CONFIG_SLOB
+#ifdef CONFIG_MEMCG_KMEM
 	/*
 	 * Kmem cache creation is mostly done with the slab_mutex held,
 	 * so use a workqueue with limited concurrency to avoid stalling
diff --git a/mm/slab.h b/mm/slab.h
index 68bdf498da3b..58c6c1c2a78e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -203,7 +203,7 @@ ssize_t slabinfo_write(struct file *file, const char __user *buffer,
 void __kmem_cache_free_bulk(struct kmem_cache *, size_t, void **);
 int __kmem_cache_alloc_bulk(struct kmem_cache *, gfp_t, size_t, void **);
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 
 /* List of all root caches. */
 extern struct list_head		slab_root_caches;
@@ -296,7 +296,7 @@ extern void memcg_link_cache(struct kmem_cache *s);
 extern void slab_deactivate_memcg_cache_rcu_sched(struct kmem_cache *s,
 				void (*deact_fn)(struct kmem_cache *));
 
-#else /* CONFIG_MEMCG && !CONFIG_SLOB */
+#else /* CONFIG_MEMCG_KMEM */
 
 /* If !memcg, all caches are root. */
 #define slab_root_caches	slab_caches
@@ -351,7 +351,7 @@ static inline void memcg_link_cache(struct kmem_cache *s)
 {
 }
 
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index b0dd9db1eb2f..400e26697bb6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -127,7 +127,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t nr,
 	return i;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 
 LIST_HEAD(slab_root_caches);
 
@@ -255,7 +255,7 @@ static inline void destroy_memcg_params(struct kmem_cache *s)
 static inline void memcg_unlink_cache(struct kmem_cache *s)
 {
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 /*
  * Figure out what the alignment of the objects will be given a set of
@@ -579,7 +579,7 @@ static int shutdown_cache(struct kmem_cache *s)
 	return 0;
 }
 
-#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
+#ifdef CONFIG_MEMCG_KMEM
 /*
  * memcg_create_kmem_cache - Create a cache for a memory cgroup.
  * @memcg: The memory cgroup the new cache is for.
@@ -828,7 +828,7 @@ static inline int shutdown_memcg_caches(struct kmem_cache *s)
 {
 	return 0;
 }
-#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
+#endif /* CONFIG_MEMCG_KMEM */
 
 void slab_kmem_cache_release(struct kmem_cache *s)
 {
