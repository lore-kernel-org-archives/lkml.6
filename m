Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeEVKI4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:08:56 -0400
Received: from mail-db5eur01on0101.outbound.protection.outlook.com ([104.47.2.101]:44868
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeEVKIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:08:47 -0400
Subject: [PATCH v7 08/17] fs: Propagate shrinker::id to list_lru
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
Date: Tue, 22 May 2018 13:08:36 +0300
Message-ID: <152698371665.3393.13441718686811755204.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0402CA0024.eurprd04.prod.outlook.com
 (2603:10a6:209::37) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:Ky0sQ83kC6wUuIuUsr9uaKb68OW+lK2j2JDMAj6qscUDmkP06UcCIBsncC2eauzHeBBmxx+hizgNXfPMYE8Y0barfhiYGtVW2WFwFopKbpTXTsdKOu0FG1xcOtjmPdjaefMGoPDEUJBR2kyMVomgXLWMstpZ1Q+alFg0GzoC9xNUWxR9RcO/RsgT+5KvAppLbdG0w/sIj90G6RnBJzIxpw9xqTRecipgrGU4Xot6f/KwyXlEJ5BPKkeFSLSN3gHY;25:DDe16HmcT9BmdHKbyBJMinSsmeu+OZw8YYFjpa5GyZW/D8UpiPgfCuJYCdE7Mes1PNlRt7E4BmBkNk4EjucD3w33sZYuG5vwdvWgY3IlTVq8tObxQYc554N5+M/ccPFd00B3buPvpDhNRa6464ai7yn++PcUnk9CbRLcfrVEIdm5chta1R/VtBMrTm43j/TFy/ukVqudxFkQgMeVud5z3kuremAA4E4ix/V+1jhLmLaRlW+l4q1d8dzKD9A2PICdcsD9rAGkq9e9zM/Xp1qG9Q693Kf34McpY9wrbbqG2o0AA1fcOY6qxOrpwmwObi13oYfqNw2YTZ0R2ZxVm8JcYg==;31:p5jwjbfZmLjwfMbjHPTcclYJ1zjhPPjfZjRxHvgOjRzSXzaGXXHHFqPkrM5EWCN9XaOG/iJtI4u6rklyZz/A/qsJSy10mBKZrvcJtoIZOhD7rYxCVt+UwUCI5Hyo4BNKYLEkDGq6lbo4jSAA/1LaytbGXkiREbp4sd61PhGtZPJCpP69r3IdinBDWprpJhy3ycfW+FAd9R/53ZBsPTycgp0wKo8qAfarpKiCK0AhtHc=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:Ppzgbhzg8EXyzMPzaBKQl/N8WQBLGEQZjX0K8lPzgRNOA5SDkuou2sGAVlzO9CaFDzOUEQPJRHTT5NUUVjooYZLe6rlWJaSHhffKGe33y8/DHJNh8MzMj/vYjsA1RtXEUV8hapHWCa0D6vBBX4uudLpQIvOMX3ngEU1p9MQEXBvX58LePyDeU20vVWbfh/C8EMDA+oWy/A3Ri1k/uto2D1P37BX8dS/M1xtaEHZbRRJ7TSwbSwyamN8o4y85k7vE0REaKE9S3jdzGubfQRQDJ+OBaO0MNTy1iyfJcVJXgLeMrnbkYZu4nr1fMHC9ULrmBJXWSWsmhnEJZ1JMY8rebA2q3XF6Uocg35iicKSwRt2qpD5nkWv4tsb21ntOWs0cpLsnCTYQRDN9OF9i3RXZC5nmGFLgUthyES4yfeEWQzJe6j7drbqrKU4KXgz7ksp51HGnjb+PoB+yhSzL4tPB7ebsK+A+hS29DE7Dhw6u2SzR93e+dHFRQg6HbZh8ZfoG;4:wabBhGxMSD9on0veZsI//fkRLHOQrEAkgYQFAafktsFzPhm1WIpVlCc6uiEsbtf63YPcA1n8klmDYjbBAnRZ7IrD0BIi9/WXLYIIbCDPtuue8ovMZk0V7qAkMJMP/whBQhNFTjnoI96+9mEPz6V+588TGBOZqm9Gjz5tZL3jMJfApECh153SV/hgmJSigln1bhzauLkh12yre1eeB46EFhEg4Gu/yCKrTgFKvF0Qg7KXO/3KjFxKCb+mWzV3yWkyTywfO2gicq/xbhsmQDLGlw==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13349CD5A79186A18315F6A4CD940@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39380400002)(346002)(39850400004)(376002)(396003)(366004)(199004)(189003)(11346002)(486006)(305945005)(81156014)(186003)(230700001)(55236004)(6506007)(386003)(16526019)(8676002)(81166006)(53936002)(55016002)(9686003)(50466002)(26005)(6636002)(2906002)(6666003)(23676004)(39060400002)(2486003)(8936002)(86362001)(575784001)(476003)(59450400001)(33896004)(956004)(7736002)(76176011)(97736004)(446003)(52116002)(3846002)(7696005)(6116002)(25786009)(316002)(106356001)(5660300001)(478600001)(68736007)(61506002)(58126008)(105586002)(7416002)(47776003)(66066001)(103116003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6ZVpaTDRRWGZBcTVnS1RHaG9heHVzcmdU?=
 =?utf-8?B?QUd3ckRFSy9BcHQxUHZEYzlKMnlCUnpXUW1GZlVqdktpNFFyc0ltaDlVeTJw?=
 =?utf-8?B?ckdyRFVEL2o1QlhpM0ZnS1hSejFVajAwL1BSUktXOFFTTmo1WGt1ZmpBNXlJ?=
 =?utf-8?B?ZGgwdlR6czY3RUFpTFBNczFaMFg3Y2NnMDZBVEtWa3RucVlYeUthYjRIdEd4?=
 =?utf-8?B?N1VyNzJKYTZqTDd5N0lLQmtQbXd6dkF5MlNUKzhLTDhIYXE0ZEhKZnJzSm1H?=
 =?utf-8?B?dFVDMEtyQld0YmJ5enI3dEJaT3RqL3NSYlpRQlQrY1lIWEMzQ2RIVmdiY2RG?=
 =?utf-8?B?WnVRZmN2Q3REM3IzYXZWcDg0RTVTczRNd0tJZjhFN0tUUVZPNFY3RlgrWU5U?=
 =?utf-8?B?czh2R1hXMmJvcmpsV29QYlloSFB4dGFqQm5Gc0NwUzhHVVV0a0JYdXIzMGl6?=
 =?utf-8?B?cmRRaFhET1FvZnpXNEIzckZ5ajlkditka0UvSUgzZ3d1QzNXakxSWjhzM01P?=
 =?utf-8?B?dGRlNk1kSHBob3hYM0NVTy9LYjYwS1doeDdXZGtMQ2x3UW90UHlhRldwZ25w?=
 =?utf-8?B?MlJtblBSTEJGc0JqcmEwbHFRbHVxWEl1cFkrS1g4REdnUk9uQURneW5WL25k?=
 =?utf-8?B?VHVTVGtEaUFjUGFpSmhxZmIxeG4ydXFGOVh2WkwwR1BjS2VlbnR6c2JHRnZZ?=
 =?utf-8?B?Mkx4RFdrUGFPWUsrUUc0d2lkYkxiRHNCaTg4UHlSTjVUWHJoY3lLQ2Z6L1Ri?=
 =?utf-8?B?VVNvVHBpV2l4TlVkbktndkprYWNDZFc0ZTR1cHhzYVhvTTFTMitSZ1ZzUEk2?=
 =?utf-8?B?SHFwdTVYZ1VxSHlPUC94aC92d0ZqTzZsUDd5czVJV2p0a2tLRnVESi9IMXpK?=
 =?utf-8?B?Nlp6aGV6L04wZjVkWkorMTdlUENXQlN4RHBTZlV0TVl4U3NCNGRkUXVaVHYr?=
 =?utf-8?B?emcyb2JqTkp1dFVmWWJ5M1RMbW5UYWxvcjdybXVLbGlCc01jQnBrR2MxczBU?=
 =?utf-8?B?TmNUMVRkSDdSejRpT1BCTDlmeDZmZWNvVHV1bGhsR3p4TktmTi9RMU02bkUx?=
 =?utf-8?B?VnJDRTJEb0h2YXAydmZHcUxldmdMd1VRSjIwTUZDdkN6YTBObDRDKzN3S0VP?=
 =?utf-8?B?cnpNZVJGb0VCaXVwWjExTkw1am0rNkZ5aVk3MXBOYlRlZlVmSk1XRjZ2SzA4?=
 =?utf-8?B?L2dJSHNuQnFIY05pVU1XTmFrbGt4N3NRSy9ENmY0R1I0Y0R4eS9wZDVSRjVM?=
 =?utf-8?B?Ung2U2VUTS9FN0FqMTA2alQ4bXVobG9EVFV3dnRRbGxNWmwwQWwyY1RncHF0?=
 =?utf-8?B?ZFdBY0ZneGlYem0wbkVFaFBTSUN5elEwUUgxUmt0cDdFNUU5WHFqWDRsK2hN?=
 =?utf-8?B?RTNOdUNrVlUrSGF0b2loenllaEErTkJPdW56YnBkaVdVdjU4YzVoV2llcXpZ?=
 =?utf-8?B?UkpWSkpzbVc4YXRrQVNMSHFUenRhQlh2UFFNclVjRVVrVlFjOWE3bFEyVkdi?=
 =?utf-8?B?TU8wanhZNXpTQ2o1Z2xub2tIM2lnek1iV2lETEFwQ3pWZDgrMndzZ0Q2dEV0?=
 =?utf-8?B?cno3Qzkzb1g2UmFkdUc5WnpOSFJaU2IrNStLQkJsdUpVZzF3WWNYMGZUaTFq?=
 =?utf-8?B?VG1IRXRPRjdrSVN4NjM4NTk1d29FUjNUcEowUHJaY0VNZFZkWFFOVHNlZ1Rk?=
 =?utf-8?B?dHk2QzBrM21aOFJLZlhKbUMwL1RHaFVtbGVLNmt6cExqNXFQSlpOLzFkeXpQ?=
 =?utf-8?B?R3dOdklNcEh5czF2OGtZYzVxSEV3WTBBV09vT1JDcUVDSlVWN2h6djNOWjRj?=
 =?utf-8?B?a2M5d0t5QzZMd2RXcjhuWG9GN05zdGM2M2dKdi9VVVNLVVBzSXE2RTFOQWlI?=
 =?utf-8?Q?BpM4ncOjPfQHs=3D?=
X-Microsoft-Antispam-Message-Info: em6DCvJTxSdtOCeURH8cpNBhlQdc4vQ27IjrQDmuluLrLurXyHJ7LZifdxpNVECQ+8+d9MVCJBWsSV624rFYBzZT/AYwsp5FwzX0KEkUIy2a1OjAP1aUBlYug4/jwzR86plshHy/x88r+am3g3a5ATHQcfIi32h4BFHrCz6QRVECPPe+P9A3WN38uEp5Lj1R
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:lMOP3iOKAEFRqFTyTmr2o0wiGisaHCNmIc/zfwVAzhlcmhGCZJaGRkmCCFkl1omfgYB9vv8YFJj+ABYH+6rFe3ruLjovy4TugLDg7QQZdkBxi8iLwkNy7x04MrEffFrTtM819NBdXPN5bdDk2417wn84pd0v5AkhBAgwlK/+JXKwcVLr0+Y1vHNWH5YAExed2Ac6txSHLbXjzIP8T+r7HQgGpYvQnKaPQ8ojAIFnhprDp9S64r98z5yqzuJDwLQmZHYHcBbNjgLTqa+ROrLQmfxqY4nDyMGyT3aBKYFwwjAsSeJFKsTZWm+JYMIsRYjzfL0l00wqTZtEVUw86Il9mya9nze4WHW5Fo6ufJDuwKEUrGyx9A8s5AWmuqwZifefD1BPQv88+Hl7i/LO+0TpQV3RKzAhId9MpD/yzrbAxsPAdnBgB+6CU398E3Zq41CA8P57tvcWLwxNlpH+QlJRqg==;5:QR6iAFVJJf1Exh/1q0Ln6xD6lLaTd83Jkw50H41mKKQ5T3rRbZagAktsPBYT/EbQmaIwwZgkwbnK0Kt3aLx36GCZSF+4ZrN17Iv5QzA39lruN6qfhYUqdhihFhkKjhZG9ZDEecjEstB6V8308p+LywqbsTNiVTAT75h/SfMAR4Q=;24:zaDmDkb27brQcLaqH6fDedgjHiyJG3Ksdfthzy65O3QnImMmPfIxLXe/m4SzEUpCSOryPOkikTa7wcuvhJrbgUJlO8JSgBfuCc0ckHA43Ks=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:4PyrYr8bxS9CvPZvzKJr6xKykS+7z7/CtUuTP5aLbx5r4ZYb56eC8XxR4tX26t1KoAxzBT/WeC/3of6FQ+oILOr4EfAOrt9MbVBtlRXrhGpSb5d+GJeDBEbgSDo8OIi4XR6rbK3Q9FYwIl82XEV6nVfrt0mfcfSkxn8Skbt6x1a8Ymuu2hAlxG/vxVbvQM1h88yf4h2cvYeuOa5Oxg/2xJizKJfWx+MBnHw1KYm+HcF1v/03Q/SqAj1Cxd8P5W9+;20:/DVZY/JiXs9UDXUH9m4eeNjY6i+df8ETpcewoTCatDOQOYF+6EJBGHE4mTQMwzQii+0SOVZrYM2bvDau9nYwUxm6LPQLQdaFgH6LTrtayNwDx5RErxcw3pWOilHXU8W4UeG4nJTeqp2xY88iAeM4rMnXMS0suqZU7Vg1J1bCJbs=
X-MS-Office365-Filtering-Correlation-Id: 0eb7fcc3-8b93-490a-35ea-08d5bfcbfeee
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:08:40.1270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb7fcc3-8b93-490a-35ea-08d5bfcbfeee
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds list_lru::shrinker_id field, and populates
it by registered shrinker id.

This will be used to set correct bit in memcg shrinkers
map by lru code in next patches, after there appeared
the first related to memcg element in list_lru.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c               |    4 ++--
 include/linux/list_lru.h |   14 +++++++++-----
 mm/list_lru.c            |   11 ++++++++++-
 mm/workingset.c          |    3 ++-
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 78227c4ddb21..f5f96e52e0cd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -261,9 +261,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_dentry_lru))
+	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
+	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
 		goto fail;
 	return s;
 
diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 2d23b5b745be..9e75bb33766b 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -53,16 +53,20 @@ struct list_lru {
 	struct list_lru_node	*node;
 #ifdef CONFIG_MEMCG_KMEM
 	struct list_head	list;
+	int			shrinker_id;
 #endif
 };
 
 void list_lru_destroy(struct list_lru *lru);
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
-		    struct lock_class_key *key);
-
-#define list_lru_init(lru)		__list_lru_init((lru), false, NULL)
-#define list_lru_init_key(lru, key)	__list_lru_init((lru), false, (key))
-#define list_lru_init_memcg(lru)	__list_lru_init((lru), true, NULL)
+		    struct lock_class_key *key, struct shrinker *shrinker);
+
+#define list_lru_init(lru)				\
+	__list_lru_init((lru), false, NULL, NULL)
+#define list_lru_init_key(lru, key)			\
+	__list_lru_init((lru), false, (key), NULL)
+#define list_lru_init_memcg(lru, shrinker)		\
+	__list_lru_init((lru), true, NULL, shrinker)
 
 int memcg_update_all_list_lrus(int num_memcgs);
 void memcg_drain_all_list_lrus(int src_idx, int dst_idx);
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 232bb637cf02..dde9ecae7cb5 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -559,12 +559,18 @@ static void memcg_destroy_list_lru(struct list_lru *lru)
 #endif /* CONFIG_MEMCG_KMEM */
 
 int __list_lru_init(struct list_lru *lru, bool memcg_aware,
-		    struct lock_class_key *key)
+		    struct lock_class_key *key, struct shrinker *shrinker)
 {
 	int i;
 	size_t size = sizeof(*lru->node) * nr_node_ids;
 	int err = -ENOMEM;
 
+#ifdef CONFIG_MEMCG_KMEM
+	if (shrinker)
+		lru->shrinker_id = shrinker->id;
+	else
+		lru->shrinker_id = -1;
+#endif
 	memcg_get_cache_ids();
 
 	lru->node = kzalloc(size, GFP_KERNEL);
@@ -607,6 +613,9 @@ void list_lru_destroy(struct list_lru *lru)
 	kfree(lru->node);
 	lru->node = NULL;
 
+#ifdef CONFIG_MEMCG_KMEM
+	lru->shrinker_id = -1;
+#endif
 	memcg_put_cache_ids();
 }
 EXPORT_SYMBOL_GPL(list_lru_destroy);
diff --git a/mm/workingset.c b/mm/workingset.c
index c3a4fe145bb7..79099bc5c256 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -531,7 +531,8 @@ static int __init workingset_init(void)
 	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
+			      &workingset_shadow_shrinker);
 	if (ret)
 		goto err_list_lru;
 	register_shrinker_prepared(&workingset_shadow_shrinker);
