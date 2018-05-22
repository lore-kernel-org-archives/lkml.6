Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeEVKIm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:08:42 -0400
Received: from mail-eopbgr30116.outbound.protection.outlook.com ([40.107.3.116]:20619
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751229AbeEVKIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:08:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 07/17] fs: Refactoring in alloc_super()
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
Date: Tue, 22 May 2018 13:08:25 +0300
Message-ID: <152698370507.3393.6943904031776030931.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR0102CA0007.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::20) To VI1PR0801MB1341.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1341;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;3:KLA6pR9dTWdwWDq+OEjSnIvIzLP9OWm6BgSVtdOP2ddiWxMYk7VeG1p/4ztTRSLn63QCVyDB9xGhlKoqOC3TbmO9g6V8/IPc4r/C38uye4yzHSf1pSSFFQ2Tm7IynREaRQaG0j7+K2OS9BRDNIiDLMUlYU7LlLPLVUbfJa7LuynStVFyT8vtZpZfkSE7+EdRQZx4a2I0Pt6PR3e7HI8+1P9j50Au1UE+FJFx2eNwp4RPkvU+D6RWBJhSYQcxXY9x;25:3pmCd243vGJKe5UFiJueYcrrfpE4uxKtS8gO/magLjA/m58DLbXTl+42x48tSP1rHLlw8C3pTvksM3V7gRWq0vKloIvBHDnbUdXs8P0ih/kk4YEYgkXdV/HRATbCPkt9l/B3CR1LUrr45Gw8pfbpqMvASbpVX18fHcNjcktDBNvAKyuLRiqZBOup0IvTnWrPGMvewqrvJoj7eO4u9sdUpYkbZUHt0IA0MpDvpcawJ5lzDPqtvJm4riDKg6Yy/1gRN85wMvVP3BpSo7Ofs7Hntgpc2gTuiKlBDK7M9H8WnFUHKuMR1Wp6hZxhAdPKgYyfxSz9Lz3Wyk9dMz0lDi8lgg==;31:IwX0Kal3KRZRRvrTyfVaX/lXF4RB59O8/bCJT2xjQi4PQFX0RNxjExGZs0YypzN3OnmlJV0GbE9w8JfO2ZY4z07C7882Na6YaoPK4WCBXhNsA1/z0Pm8XbpBGBT5ZMWI1hvEDFNtlaGh0V0ZlkDyWCxCFNIkQ9EAPUZ/F1LoRSyviudMV91F2CZjVo83K29iOf8TisfkkgcWpKiEiKhXzB7PXmMkkJYB5JVEidhc4Kw=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1341:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;20:ofn3uikveu2QPY9Bsp8Rt2EBYTsIbjPd4fT2VX3fDrYNbJUfAhTO85vG3TAZilScOuAfOfitNfiljYNOmACvrFFboPSTpLctMC5SIzUWjKZNBVkcycfS1zhdO0o49460OQo0hhR2wilnlUEAHr/O+ubZmYeM6R0qRxN+QaFbmbkqDc93d2aW0iOGG9z8TRjGRAQ4KvIfb415HCV0dGwOWTiPBjJy/osiTtPCwsEe6Ic+KhmocuXKYZmnGG5/TQX8CO+nvZ2mt71PjLQw8kw0fcRhegzniaYO7cuKrl+WFAZjjS1anuYmGNxo/8pS+CcZyJZS0NKsMAzK7qi+Xmaje6ldOWx327kjxKyBggyxyXFNlu2lOvl/bZkU7Yol2rD2DPD5a/zQBBU8T8E7XmfY1VtzFM8t15ysUncB6lzgeZtW0MB4mJY/jb61bJh+gQAOc4iV9hyiLltV9QkdvINx6+jXziuEZD9vQAmTpVudEnQfQUG/caAU9r3tMf8X53qz;4:rrKFjSy607YzUO8B0+zaPFajM3QnBmNpZAD2b4sex9eoQgpI9nUS4+uDHI92ngregmjqhwgF97O6oIo9U0R+VFvG90rO5EtOUGpRmLQkVYCIqFd3dGBLDhC0TTtuHkfk6RKXID4Q76HvtXEmSOkJ3cHclqiw12EMi9AEh7p6laXWAbZvhJ8XoY5zlhorzeUKe3EGpVv5S+tvj16pdKHdB52lwnQnVdEcfwJ2xGV5gFX3ej3XQcNzuL0XHxgKakr2ucdpS6tLbOi1rSL4/0gxLA==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13411D4D5BF867CDB6CD0862CD940@VI1PR0801MB1341.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1341;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1341;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(346002)(39380400002)(39850400004)(366004)(396003)(199004)(189003)(58126008)(105586002)(316002)(478600001)(103116003)(39060400002)(68736007)(8936002)(8676002)(81166006)(81156014)(86362001)(52116002)(2486003)(23676004)(106356001)(230700001)(3846002)(305945005)(6116002)(7736002)(50466002)(97736004)(6636002)(55016002)(25786009)(11346002)(486006)(47776003)(476003)(6506007)(5660300001)(9686003)(2906002)(7416002)(7696005)(61506002)(33896004)(53936002)(386003)(446003)(16526019)(956004)(186003)(76176011)(59450400001)(66066001)(55236004)(26005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1341;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDE7MjM6QWVCbGg2TzJkTWRsOXhXclo2QnpHcHRR?=
 =?utf-8?B?QlBDN2VPaUpIcm1aNVpPNXZoSjJtWW9oekNrMUdKOFJOT2Q4T21EdlBZK1p2?=
 =?utf-8?B?N2tyR0VxRFFqd1p2VC85MnZEektMM3R5Zmt5T0o5MndtMHkxZW0xai9Idi9M?=
 =?utf-8?B?RUVVZ253Y3FCTTNSZ1p5Wld2OFh3UDJoME53SmZ6emdISE9hZ0s5emlVWTZu?=
 =?utf-8?B?aURJbkRGMFVOT1ppMmVraFZVWU9MUnIzNCtqcTRGMTN6MGJualNQb3lQQWx4?=
 =?utf-8?B?a2dldW5Bam5xQVpCNGxQZGdKekF0TUY5c2F0SmhvZlFKV29DcXRrQUJTNU1y?=
 =?utf-8?B?NU5PQVVpbzBVUWFRRGxsRTJmZDNwV09uVDRERWMyenc1Yyt1U2kyMFdPUWFw?=
 =?utf-8?B?SnVwZGpiV2F2QittdXhCMUZIYkRMVEFvaVI3Uytvb2QyWEFraU9pU2NNOVE4?=
 =?utf-8?B?YW9Fdm1EK2hYSmJLN1JpUWhvZ3EyY2lJTWR4TDFBY1VmSU5ydTY0QnJFeGVM?=
 =?utf-8?B?azVPZHpsNFM1Sk1IOWdORXh3UnhOamh5QXg4MFpxSmNYRm1SbjhRM2tlUTFE?=
 =?utf-8?B?dzNxdU9UT1MxVmUxOU9wSll1dW9iQ1lWTGZCek91Wmg2UFhLT1lNZGdLWHoz?=
 =?utf-8?B?SWpMbkZTNUxsZ1ZSdkdDbWxCRnFleFY1MzRLNDNoUWpnYll5aFBna25FS0Vh?=
 =?utf-8?B?dmpuNDNaaTJOV0dkaHp1STdvRk1wc2RwR1pQc0toWkZpaENpYzZzSXBDeXVa?=
 =?utf-8?B?bHo4MTRZbjNGekIxbWRISWlqMEdwaHNPOEF6UGZpd1ROTkZoQnFIL21TSnYw?=
 =?utf-8?B?VlRNdWFCNmpNMEFNNFVpZzdQT0R3OW5reWNBL3JISHBnWjBLQnVCOTZySzRI?=
 =?utf-8?B?REtHSXJpSk1MQTg2dGdQc2txNkJkeU9PQ2huWU9VYUdXMHJKU2RmUytoQSsv?=
 =?utf-8?B?UW9FNXBxdU1LSmlVT1RMeHdpWVJjNkFBek54Ukt2dVdoQUNOenQvcmVPRndY?=
 =?utf-8?B?V1pDVUpGRHg4NjFXRXNrS2VMQ08rbzArVi9KZUgxeHdwYlBQekdHTFlBS01m?=
 =?utf-8?B?UVNrSFNDamhmaGdob2VGbndVekhZOU5NVDYwbDNHZCtHQ09hT3BVY00vRTBj?=
 =?utf-8?B?TUJROVY4eUxGRkF5akVqektYQ1BMTEd2VHJFdU11dnozNERVZXI1b1FYanFy?=
 =?utf-8?B?aTRyL09YUDFFSXpDckJoaW9oZ0RJd3o5R2xQUFkzbmU5c1d0UHJwOEJMWDhQ?=
 =?utf-8?B?T0Q2Y0hvWWpGQjRtdUROZ1l3VnVCZ2RnN3JxaE9vdVFBazU3KzBHTXU0aS85?=
 =?utf-8?B?cm5US1VOVUFaUnNFSXZ5Tm8yUWFqMXFrVXplOUtIQmRoZkJud3ozY0VWRXRu?=
 =?utf-8?B?N0taL2g3RmoyZ0VBZXoyN054Si9TbXJoS0d0bW8vYkxpbW5TOXZzVDUyR29T?=
 =?utf-8?B?a1h4OWpQcG5mTjBxWVo5VGxTZTNFV1FmanJweFNhMEtZbERaQ3RjKy9rZ1l6?=
 =?utf-8?B?THBzVnJEZkRkS3U5UncvNmdvVFFwb0NIaTBFcmxLRmRKemVRZDBjUFRUUk44?=
 =?utf-8?B?MnBIK0UvbkFPUjZGenJXU1BkaXMrV0tHdGdFNytxUytiSjRlU25pTjZqV1Yy?=
 =?utf-8?B?MnFmTXYrWldCY1FpSitSTmZBR2ZPU2pRaWVCY3g5QmZqbytCQXlWZi81WWlt?=
 =?utf-8?B?ZSsydVJ5U2dNTmxXbEJvdThNM3o0ZElCcGxHQ3liMGRLbmpZUHNSOU9Gbkc0?=
 =?utf-8?B?TGtYQlhoMzNJUDUrT3hCaXROeGo0WnRYeXZERE5JYkdsMEJkRnFVWVBJZmFU?=
 =?utf-8?Q?8hP6s/9aJF4/vGw?=
X-Microsoft-Antispam-Message-Info: NlpptwRMaWmDnKJUNuMZRCz9O+An0z2XCcfGZnOX9xWlPsxzqQTXWWRtLpTbLTCsRz8hciVcVWpk61FlP4+XPkiFb4FRpVkHBhHVwDsfrOxrbKkthvhHAMXMIFR/Q78Z5aZ5IVUnSreyv24KHEyUNtzUWaDf73y7pBsYCCMumIaoSo6PkOBfMEwfYFZCSXKQ
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;6:yuh+817VO3cRkO0h7W2YOZSeu4WwR6cFFzbHh5vfWuVswbrZ7GkQwgjlXByl4tW1DSOt8ftUauxUvKrmX53qJLyNB/MTwcFgAuhf7lZhLQtxWXzFHnP/4apP8rZtiF9UnHuKauLlHPRr488dB8knaqIWgryYNCpeC3hHP8mHpoB2k7TGWznLeZE+RcnuJuRgbzr+2dfihhiHiij+zxnppkkJJn1yYUsdqwPfo5o5ntK0BVVyQGeRLoGohCXE3dZgS6xMMC03wpeXIMG5txwGzDTZ4PFZRY5BqOsNkgz+9hpHAN9hL9FQBqcbokLfSPDRu5CNqZXjv9ttM3Lv5/JWtt0rN7r0zNsOLAWnOew+EJLKb5nftF4+X7qKmy6IRvDsTyhgPaGmsLXmbbcEKQ0Fho2r9u59CMuqfsAXjhqAvQi3ny+tXF+TerBOs2EjP1aOmFOUaH4iNfx2r5k2Pc9phw==;5:ao5A0B2xuc3FffQdp54v6ski6SChllWqjP6KMQ+r9LQdGixdQLofpTfGV8gjBsN8xmWeP6KZaHWAqhRp7taWaSEvtFXC1oJvACLEtiuWjz6EbfZ+yKnAxxDb9OuZhY6dn2cm8mCBPMiMrbfWzqOvfY/Ik5L36Ha7kGFCTuBBUCo=;24:OlF4ekMRivZBm+wGm/gwSuObKXt8GDsRAr7bL9JjR3Z9tVzZ5bWOHRNQqwsyTJmuwn8tYmT4XwhThl8PoNq0YVO1c2oCXC+JZj59ZNcuY8c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1341;7:j9mI2PhAWajb8jytgoyzb1q6OQqFeVUM6/17jJXgEIHXISKcAN+8n8PslR5qXUsZ42KO3TU9TI42H0RS3SzRe9UWDATAKq55mpFADm1q/1Gyzl3oBochhe+BNHjt1Q+XUnyIS7pzdAccSoRCp2J+Z1O85kjQeSwYJ8fyuBxawrn+yJOF51E2zgzIzuxghnFjthCdxRVPbBvvJiaCPolnTTlSbO9W2vuvEUB9P9Z6mO1DZzagIzRR68H/ceJzFdmX;20:JPCYriwW4ZBxwwJbkEpwfNsmJR2Etp9dpMrRMQWnxSJ0plcmMGNIInwUB0urqFKtequOTtnz4VHxQVbcxDWwEPWzUKf+nUQIvHD2LwNbg6FKejnaZJbg23CqsjoB2ZBaweLplF7tFybm78FPG+VWQydLo4LOpcUBZozlsMDB0to=
X-MS-Office365-Filtering-Correlation-Id: b7c33fe4-40b6-4a75-8f20-08d5bfcbf890
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:08:27.5406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c33fe4-40b6-4a75-8f20-08d5bfcbf890
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1341
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do two list_lru_init_memcg() calls after prealloc_super().
destroy_unused_super() in fail path is OK with this.
Next patch needs such the order.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 50728d9c1a05..78227c4ddb21 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -244,10 +244,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
-	if (list_lru_init_memcg(&s->s_dentry_lru))
-		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
-		goto fail;
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
@@ -265,6 +261,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
+	if (list_lru_init_memcg(&s->s_dentry_lru))
+		goto fail;
+	if (list_lru_init_memcg(&s->s_inode_lru))
+		goto fail;
 	return s;
 
 fail:
