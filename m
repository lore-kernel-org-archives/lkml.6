Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZpzy6nA/zSg//9FPGKUx5p71FN1HF8z9teh0o22hdmIQi9W3muxVe0gXiGTvWorKDaQc6k7
ARC-Seal: i=1; a=rsa-sha256; t=1525867067; cv=none;
        d=google.com; s=arc-20160816;
        b=GZdmKy/Ydj/eA89JaJxtHEkhKeQws8txfrUkgx/EF8YRtp9A4fk1DmF8inkv01a4eh
         D68hwRF76j20YA7bC8sQqSoB2yldvEvOx7AsR3h/9SQB3DnuOuaDmYmMhbukr48I2vpX
         QAFK4DvSYt/LOL7iEdK7B1T18c99SP86iYH6vfudqqcUKYalIv45ZeWKUau9ds6Ztm32
         Nhbaga3X1y3wRzx/P2A4iM3OS/i1kRv4fh92zW832tWG1L7L2BqGPpb53VDR1+OurED2
         JBXLF2pC7+cNMiYiJ7incRnUtCAJHfkWYSL8bv0xzqGVTk0tlYxw+w2DKq9kh6ezRzLl
         s4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=V/kvH+irehEmPuj2/nwW3XE9Z85uAHg2skL11L+/yTw=;
        b=DWWcf4jW3OSz/GvQyDS/H+SernRW+F+JtD5mA9SJKfr0Ru0Csw9gQi5s7DTYsiw/mx
         CwMkoc+9cIN2a0VM8PwyRKY3k9g8i1QMoA1mayoopPILHDiJ87J4Ee5wqxCb9p4CsaJ0
         jHxf5/OegP1Hp0Ag8uSXJbxJjH3B0oEj0rsfOre1V0Bdy2vGRDzdBBez/Y08jI5OnM9G
         wZq/iA2xIJVWVN4BhQj9qBR9KLm0+3iHwKqzuoUIUrkoXYI1JyGv8VqhbroGsOXS+bPc
         6ytTfkt9Ox0dT4vf3JEmBfpHhSsQxnxdjnvPhVx8AfxCMfsAoScpweux3JAY3Tb5h0Dj
         iQjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ZMyLvjnd;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=ZMyLvjnd;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.1.130 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 05/13] fs: Refactoring in alloc_super()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Wed, 09 May 2018 14:57:39 +0300
Message-ID: <152586705933.3048.9193770835306565439.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::39)
 To HE1PR0801MB1337.eurprd08.prod.outlook.com (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:h2abKOwAjX6aGMRwdj5UKMqHMAh6oFe9qRv9f5w1HNf+DnT+ukJIGw3S3zM0st9H06XZbyBGt3JouQMYIddNjBNowxjZ/h891w8athM0iTvaMeNu1vDzeaVDRiBB10rGTHnZLkYD1+O7rjhcOFvGtHdXQor8osg/583AHLEBqUxfm+nw4DWJmqMACcI88O+KnAQVCwNd8AAEG1L9DFvz3qmviQMHpH/xKShh4WVsEC/kGaOmuqnQ1dfD8VKS54N7;25:hTqeFCMQrkLB8Eoqqty76Cz/bTTwb0dJyTByo8OOos5dBkQpkYnr0sRCYBVDg/mIOgujvgzmeXzIA5NgMmIBAiKp0eyK7KUVxXbOLhoADadU10KF0vR4LEmC2VSRb9TPlQL97REALA6+2MCbQikjVftUfeASccfwiICEnVHPFo1qZl9BEXc72ufxwz+dGQ3aA99JSZ+0gdLWa3C+bQD6rQO92RpE9jl0u4FK0bG+dKrkDFh21zXNeDNVpNMk26PCB+z5WVFP+Z8WI5t7YoVvWDREmg7TWO22lWQxuMUfH5o8+tLAndUspo4/28RYuIqhK3qeFysN6sY7/dpmoZr2+g==;31:QVmIA+kWqQmGoJfDtKiyP/gaO4zY13PBtxjwtkHxmgoS212Lk1cBZyt9dW06SZK3eGdK43CnuidLBPx4nascu1H0rLwLXgAOAxFK64wGHSFJ5gW8R7ajKYGUFvdcGNCY/rcO/7jPQT6hTPsIRTeNuq8N4fQ1LwDqh/+4OKz/Sr4yv3BPj4Wh+S9f3HNpg1/DbVTK5a5HTIH7KmWe+dq9kqlAaYOAfSvI9zIqQoO9QkA=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:mIfxgq0q7KUkw1G1QF6zioLnCb+88Q2kuzg5eq2JptZiwkosVbPo8adAszM37VCk2RkJHM7s90boluB8JTKmCnmf1FV+uJx2lIv/LscIH9AT3+7OEGrqhORYEypo2voPcCP37bNY2J7yoB8jHLHVQhYFgEvCguPr0yX99IWXrW7AICzwbqOyKjGyA2dAMuvdS73Y6++LRB3YhlnAFmrCjrssbrkBz7sjTrANj+0B20tvu5XePUCUUnwnVT0nyGmdMMG3cgRTNe3sWf2jThRto/vsFIHwOkKN1Cc3RQ1826Ze4wj4ddwUwOiz6Im5yWGWDPafucnwjNtzDMThdN0ePq8IQ6q6BL5LyNprMaiU4tf5fEmjbe9R4pGVzHfB063MSrvVGZP9dKGz/kokGCVMKAqed0E6FOh1GeiDV5nPGZSMxcpVO7LAPkCLO41dL+c/y4EMfy5uKdY112WDtPZIgcRjuCIlKYVYP54BqgZbE9/bpJ02Y06go5mjtzfckQ2L;4:nBMjfh2cZJf41cdbEO+rwzGjIpeAS/5iQ4rfIzBDB8LAeKxTDMYacZMHG3je91Rv55XmCwS3J38ddOT+zG9HCRUFVjzBAEJWhueoL865G+YY2ALwqoiyncnYLm7odv2zmKwuyL5IQphdThsg7IMyZVFe4eUeuRr6UdG9ZLc8HCAUgv4xx+awaNruIbEcNoaMTPH24mYKqimg1LzomQ2rjtq3YTLIUbYGXnswZbVjLu6doTAY9RezmP9/zHmiSai7/oVvAwYDtfbj3DPPPszaxw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13376F9DCE4476F533A81772CD990@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(366004)(39850400004)(346002)(396003)(39380400002)(199004)(189003)(86362001)(486006)(316002)(76176011)(446003)(3846002)(7416002)(2486003)(2906002)(52116002)(23676004)(478600001)(26005)(66066001)(6116002)(7696005)(105586002)(106356001)(7736002)(59450400001)(68736007)(6666003)(6506007)(386003)(8676002)(25786009)(55236004)(6636002)(39060400002)(47776003)(305945005)(33896004)(61506002)(5660300001)(956004)(81166006)(97736004)(230700001)(53936002)(55016002)(476003)(81156014)(8936002)(58126008)(9686003)(11346002)(186003)(16526019)(103116003)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6UDF3R1ozSmdQWHZ2bk56L0xYOGVUVmxC?=
 =?utf-8?B?QUhnQ1ZTUzlOdmViRzFVeFFMMGNjamhlSmVKTkVEWUthaGpXTFZCbDNkdjlT?=
 =?utf-8?B?ajRJcGxlWWc1cE1iQVllT2VoNTM2bmhzcFNES1p2c3pPcGpQb0RFQ0RVQzFw?=
 =?utf-8?B?Qk9taWNUZUY4NWJ4RmdOMmM3V2lES3RDQi9IczdBV1FESkFDSkFucEI0a2Q5?=
 =?utf-8?B?OFJhem90MHVUTHYyRjhKR3d6ODhsaVNEQVljeEVHNzBidE1RR1hVWFo3SVdU?=
 =?utf-8?B?NTFoOTl6N1M4V1ZuRkZnZU5xcElPK1ZGTWhCQW5mR2V1K0tiZnE2bjF6alFO?=
 =?utf-8?B?dDlYWmg2NjUrS2hWTGZ3ZXdZMjllbk9rMk56S3liZmdJTTUxVFZsY0NpRHdD?=
 =?utf-8?B?NmhyYUIxWm5aK3JRM3Y4WFpZZDNMM3FXd0ZwbzJPRDRjcUNZeXA1R1NlTENJ?=
 =?utf-8?B?Y01NNERMV2xsMDZMeHQrRElpVnpoMTJqUGM1MW5ad3dBWFduZUxxazNRUW4y?=
 =?utf-8?B?dmhZTTI1eXZMdTdkbGVqeE1hOFA5bi9IbW51TnBFYW1MYWNmSy9rVVgrRUpX?=
 =?utf-8?B?dTdLYUFaTkprZGlTS2JzTWs4RlpnVk9EY2I2eUlDcnBDWHdBaTYzMFBnRzM5?=
 =?utf-8?B?NmwvdUFPTzgwczhHSWhtS0tYN1lDaHp5eTR3OGhBN3g3RnZUcTY0SmxZS2U2?=
 =?utf-8?B?MUNBcXoxZTVoNDZ2Y2FUV1NicTV4OXA1RHEvek82eUlkSnNrb3hZWmFhVHps?=
 =?utf-8?B?S1doNnBUQjB3cG5keWxtOUdSYWNERlZGNmc4SHdaTlNFTVRUY1JEWlV0dFFJ?=
 =?utf-8?B?V2ErU1g5YU0zWVVCczFJaVFUbDZmUXVtQVJsWWEzNHpvN0pIRFpRTFpXSHpS?=
 =?utf-8?B?Sy9pTTlBNkxFdWg0dk1wOXFEWjlHVmkwYnJpWjAwWGxSNE5oQjd3NDZHa3d1?=
 =?utf-8?B?bUFEVC9JUmRFNHlWQ1Zja2l5RjlVWW1SdUJGT0hDaDAxOXpXK09Xbk53Ty9p?=
 =?utf-8?B?Wlo1TEphZWdud3VxWmlkSDRjQU9vbGFqTTBGZkRpaDVjcWRmMzhZZEoya3ZJ?=
 =?utf-8?B?Rm1PMjF1bjAzTzhHVzE4T1JOZEE4VXVqaFVHMkpCTi9oYmZQLzVEZlU5OEZN?=
 =?utf-8?B?WTB5Tkp1N1pPMEFQZStINkxEcUpBaG9HYWpGbVNzQ0pmVjFXMzMrdVFYbWYr?=
 =?utf-8?B?RFJpV3BuRVFFN0xNQ2FxRjAvY2N0QzNQdFJDRVRlWU1zOEplU3U1Tll3cW5S?=
 =?utf-8?B?dkJoZndIM24zZW1ZTUJKWU9OVVRQRXRZMHhwOTFvT1dBc1k1N3B4SFJEVVJ0?=
 =?utf-8?B?MVFSb2JzVHJBOGhZRnlSVmpnNFVXcVNkUTczZmNML09na1hMbzBjcm4ySDRO?=
 =?utf-8?B?TzBhVUErQTVOU2pMcjBiMzNwOWZqSlk1UFN6YmJOUWtkYVFOZWJrR0lsbGZK?=
 =?utf-8?B?bjh4cjVadDY1QkI4a2FwcGphaTdCc0JhQzEvNXZ3aUVIOGtQV1NWbjFMOFBX?=
 =?utf-8?B?a2ZKRXR2UVJaaTNRcjZKYmtjSEkyTXo1RWFzYWFrRGh1Q3JvV1lhcjF1UXBO?=
 =?utf-8?B?b0xJSktCWU52MUR5UVVBcXVFWFEwUW96YVorOTZiTElYSXkrYjFBRkhnNTBQ?=
 =?utf-8?B?ZU92QTVtSkVBUkljdkwxdUdXQWhxdk04QVd2Sml6UkJlQU1xSVgwTjhzNlB3?=
 =?utf-8?B?Qk5JM1lKd3VBRGMyNFc0Yjl6eUxzYjMrYXRLbkk1d1oyMlBhYzczQVlGM0I3?=
 =?utf-8?B?S1dRUTluZmQxSGRQMFJFREFxcWZLS2o2SzVJL2JhTWhGK0wvT1pkYTFidXRu?=
 =?utf-8?B?ZTBUZkpnN2gwYlQ2OHVhdC8yeVduN3JCRHFHOEQrL0tpWFNpUT09?=
X-Microsoft-Antispam-Message-Info: KdnFR/st85vZHUf3FlFedznMtCg3OjIQIN2VSN/oyxRqoTfkpASXFm1UHv7xhqjeSYw+z1hEg0JoTyWblwWSeoTzojcrrFGQkzDpcgj5ythbxXihhg+FJwKjGrjGslDsO22/ibJyG1wOhJbV0MGFNMjJanpUqLxjcFgfC95XTAtfrGJ+CSDwihoFeLfbHx0z
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:y/tPKL6ATErZe+Y4SQOxyH5EOnQDWmFA+zVS/38aNWXLzBgE5h6QTm22PABpoYPNwRcZ/i0R2pmC1tHBQL7jHVPy+IJRiHuQAiO7y4m8a6GezZp4QLfoFE3m+2gXSWy4LVzFCd5eHJRzyfNmBNCesDvD8kO0KsJuNlIotjT7aIl+IdrDtKuDwZLmUvTsfOaPnrWd/6Aa7KmlFMUmaKdFE6Ob+FFPr6+DMS/GA2ZAUN2Y+dF/ozxnsOaUinMLlMfIMU39eqCtQfwPB5RDidC7+jv/riC17REGR8J339NIh4Aq3UehnPArFuypBGRu59hb0vuVPN4ZL+7aV1WSgZUTBdkqCsdXXxpUwpstwYVU6QaAtA++Yr1MJcYkJaw4plC5hivRBMHUYsYQsk6jv+OqG41nn3pr06fwF+zzkNTF3z8S66xFgEfTPcssYer4aqogUsuGe22WpvAvWRDY9yQ5Bw==;5:xn2sxJgGxxTNbMgy5oMOpLDbG1JnpQN0zERugNFHTHOn6hSGiqX9Slhec/vAeEh3C1zcIaWYNDFoonaxAI56SQlMXjlnLzLgoGqmRljWVSRKoHzE+do2gVjLzpBKDqIx/VzYUyFvN84XrdUGLTBXlLA8wrp9RVly0aCJ1qw5nbU=;24:FB+zS+yak8tR2uoYZ8vcXgvEuZVoHxjyNa3QI1RIjTMztIO4z8yYz3yAc5LNSl/aWcVgY48s0Kqs4Wqvh4CMNsudOqvENI+YFtoVdhNrKMk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:cp8rW0FsnE7uYlwNdoZRHGh2XOyhmLPs7oP7kqPeIiOrsNv3jXyf1H5GOf2cNI0+7A3vz8BlGHlyJW3GMSD39cdBtBF/IJ+Q4VMX3kWEab12WTrBkuf9nCAUxi7DOqpeDFo9sb4Wz/Kd9Ih9NL/VX4wOr+WOdUQnTC9skysfdn/I1uNKXk42OfTgQb+1whhDXMn8VyxjT3xsImGIUwnbi83y7KVCk6K5QiL5fDfZ/OKi+cDEZUua82wc6PeRxvzh;20:ZrUvx5KpARQ/ZjAoFUwQ53xOwmK4k/rJGPQ+P/X5O8eg1p93Ljf9PGUjWF7sLo7i3Yby4Gc+OY2FQhAaHb5M2RDp0vmCgnY3dziA50lHJEx/3hSymq8luC4Tk2R33tr176bWQczs0HrLY4U0/OFrjVjp9HSaPJevxf1awi5S8Sw=
X-MS-Office365-Filtering-Correlation-Id: 02b92624-ad6c-46f1-a927-08d5b5a41272
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:57:42.3279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b92624-ad6c-46f1-a927-08d5b5a41272
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987586373346747?=
X-GMAIL-MSGID: =?utf-8?q?1599987586373346747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Do two list_lru_init_memcg() calls after prealloc_super().
destroy_unused_super() in fail path is OK with this.
Next patch needs such the order.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/super.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 036a5522f9d0..d95fa174edab 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -234,10 +234,6 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
 
-	if (list_lru_init_memcg(&s->s_dentry_lru))
-		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru))
-		goto fail;
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
 	mutex_init(&s->s_vfs_rename_mutex);
@@ -258,6 +254,10 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
 	if (prealloc_shrinker(&s->s_shrink))
 		goto fail;
+	if (list_lru_init_memcg(&s->s_dentry_lru))
+		goto fail;
+	if (list_lru_init_memcg(&s->s_inode_lru))
+		goto fail;
 	return s;
 
 fail:
