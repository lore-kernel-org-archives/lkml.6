Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE4DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0FC2176D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ZyQbyPAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0FC2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeHCRdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:33:17 -0400
Received: from mail-he1eur01on0107.outbound.protection.outlook.com ([104.47.0.107]:3248
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727297AbeHCRdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gyMBorfs7ZkCndYQJ+wjATxfbIcBVkbzfYlbu3WK2M=;
 b=ZyQbyPAvlE0DUYj6glAMjetmU32SFEAmuTYcyD138maNdfmdLwvyRaQ+e/zbL5iGSXlDQjpBgGayKgic9/JR3VwSXPLP935rSX0AVgsajn0gT1fkWgMeGV4wh6qc2d14j9Z/t2CjBuGLnQBoc63g8T6nPob0E9TfisyMdJGgiOA=
Received: from localhost.localdomain (185.231.240.5) by
 HE1PR0801MB2025.eurprd08.prod.outlook.com (2603:10a6:3:50::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Fri, 3 Aug 2018 15:36:20 +0000
Subject: [PATCH] mm: Use special value SHRINKER_REGISTERING instead
 list_empty() check
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, ktkhai@virtuozzo.com,
        vdavydov.dev@gmail.com, mhocko@suse.com, aryabinin@virtuozzo.com,
        ying.huang@intel.com, penguin-kernel@I-love.SAKURA.ne.jp,
        willy@infradead.org, shakeelb@google.com, jbacik@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Fri, 03 Aug 2018 18:36:14 +0300
Message-ID: <153331055842.22632.9290331685041037871.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0112.eurprd02.prod.outlook.com
 (2603:10a6:7:29::41) To HE1PR0801MB2025.eurprd08.prod.outlook.com
 (2603:10a6:3:50::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 851eb3a2-3d78-420e-6c18-08d5f956dcca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB2025;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;3:y7SouNovPNLffsoPShggfaqy+UXc6HfS0uni6JKifhdiUogzmyZNa9gQ/gXojFkSJj70ZUQ2WOo6kJ+OWSIqqBbFZHV6GvGSzm70KTHOrbYxENKaOkdqYUAA7EebDJd6/PKtvI9bagnI/JHwTe54DrM9GKEhr8s/WpDoP7KG3EUGeVxMVl/DlKvK8smy3/cWMGJ8/tz41rUGkW4hRabgz4tYSdo9nsK6jDACMJolzWhYd/bG/R5Bo4IWuOA6Sso2;25:bZM4i7ivF1BjV2R9EQNVKQrhKvlUteGYY2wW8U3c9r5dXuDJhmJx2f+sVuU+fdB5CTNFSEES3/pLCpDBW44V82PkAFIrpCzbauFmElDS93NL430QxycVDRyFkkXqkWDFwnG2TB2jd0wAi+DO5BDKzOGxYBnyzzUzqjKUo4nAIVeXDFpM6efIVJH3zqfHS7lrGVg/9d/5DVqQeXV67KuFh4wFCwUMU6EjUBKo3zIzlJmEcdIcSeddi/TgneO9IjlnMLB/BgaMWwXg+oPzHjTr3xCLe4lmWUaVT839JVrqg1fGH4TPqYAm4lwz2g73w9YwWQDNNOkm50G/HNXfJpRhpQ==;31:dGZEw714M95lt11wcCEoW8bXw952gDbS6uRK4ktzsqIeiFgnrPBf0G772khBVt4ynmUE1P+B5zGIFWZvZNJtnBmiVPtiG15wueNNj0a6LH0/38pcqZRFhpv7InDwfAlEb17TVV9UInbz/PpOaNVrbjMjydPfoNMDo+FwD0KmrtKRcEZPfgABxuezCId/ilU+a8V0kL7pkPegcNt63tWFe1GW/teNN4xIAc9+dV7vdHo=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2025:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:CwBWBlAS+oOVYoa2OviJdgrXXBRp50PWHQoZOypFQ4bMNgM00lX9v62JNWHF2Pnqa8j4z6P2DAwBc6WbJuyeT3FOvE8NOGHGtXvcr0pYMwORvZNhVQh/KK6kNLIqFvz0CIWVx7Uj+SRTKhMGohaDawt2jxinz5JLjoCwU/UEIFrPT54wIHzLzL/VYlBmNFqT5NJutp+L0wXqOYZwJV5MtT9oS6yJXJcUA3cfDh3ouTRSrUCHgZjHMb9ofqpk3rW/E8aQZ5mx2+1GUd5txxnRJPuyPp3fdvsfwkC3kjPOAAqMkT/b/1QfpIPElogJrZUy5G53UAsOM+uAgQVJ6INtyPzEbfhRI06ffPFvLJwThfIMdPH/TXhpe6MUOTMe9DMQgPme4xLGzqvIzSHHF5E70nV1qryJevoy4GMJpQnoZ5staih/SPTAbMeGtKwFBLpNwpL7ZZ1cd1+e5dQKHv/+SrA/a13gJJBr513iL5wFTOFCdulIA7l8gcv/hv5X6NCB;4:SsgWotE2rlzN0yKwEVPifZhe8Pe1hhqatHFhmMteAirI5YbdRHgguS7H4/VPDV+WuOR+3kXRld8zUs6l78o5df7NFVxTLe6iza1YV9rki5xYKzQ4IHMJV8kuzrIHgkayBjvMAyFNmmbWES6+yVTFVS51pgW5kkckTTnqmpYbTZYMBRECN4JnXknwrky8MZmSDEOZxtSYR7SiO5LidYr7VTEASaTCdGk4JKsgXXC7Rmb7Df00IUicxnhOtinGDSqUmPXOZ8D/B9U4un8d5JurCw==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB20257FE4253445327CA6F946CD230@HE1PR0801MB2025.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB2025;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB2025;
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(136003)(366004)(39850400004)(396003)(199004)(189003)(39060400002)(26005)(305945005)(9686003)(7416002)(16526019)(386003)(186003)(53936002)(97736004)(2906002)(7696005)(6506007)(66066001)(7736002)(52116002)(486006)(2486003)(8936002)(81166006)(25786009)(6116002)(1857600001)(23676004)(61506002)(14444005)(55016002)(8676002)(47776003)(81156014)(3846002)(956004)(476003)(478600001)(33896004)(5660300001)(105586002)(316002)(86362001)(230700001)(106356001)(68736007)(6666003)(58126008)(103116003)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB2025;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjIwMjU7MjM6dmR2aDlYNG8rUC9NMTdEWmxvVmpEMHkz?=
 =?utf-8?B?R0oxcWw4YnVic00wYTBDak1wNmwzZDhnZW1pNVdrcWpPc3pCVjR0V0JjbjFL?=
 =?utf-8?B?Lzl3azhIUUE5SEhrTlRZbFdzSHZlVDBVYzVNWnRrMm14ZC9CRXYrWGhIZS8w?=
 =?utf-8?B?eitsak5BTDBpc2Q2MHJRUjJrRHpocHNscjhxcGNIMGFmdkc4OUdHSmpVeWVu?=
 =?utf-8?B?VENvSGRiQlVQcmJ1Z1FZRThNM0kwOGlhRlYxZE5iWFQ1T2g1V3d3VE9VSVU5?=
 =?utf-8?B?QVZRT21PRUxyb1dLOXZ3S1B1RnhoQ0R1Qm82bGZqNko3L3NSL0VHSi9qZkZx?=
 =?utf-8?B?Y01RNStJRHUxaXZZNUYxWDN2ZEkydUhWQ042dW1lQmx2VytYUU52K1hNQmRJ?=
 =?utf-8?B?NWtmTDdYTkVPQ2g2cVl6Y2RBRUg5VVU5azVYK0NUZW1aME9uV1l0MlJuNnhQ?=
 =?utf-8?B?MTV2VnQzQ2ZKa3NCZDhweXk3dk5HN05zVWdVOEsxK0x5MU04ZmhvZnZxMm95?=
 =?utf-8?B?bVVVV09yTXREZTFlTjNCdTJrTWVNdmoybTJOV1NIdklJL1RIMG0yQUNUR3VL?=
 =?utf-8?B?TWFwdmhEQXlyeFZ4ZU1GaDFkY2ljdW9EVC9ndlJseFdHbklqM1BGeC9BbTg0?=
 =?utf-8?B?dUxkWUhZMmZDNUN2WWxYam5lY3FDeFhzbGdQV01pbVYyTnA0WXBETkQ1VFJ2?=
 =?utf-8?B?SVpCU1g3K3ByS3VKVHZxNVZqSVFnQVlmMXpSRXIrZ3JLVEYzL296UFZXTTlo?=
 =?utf-8?B?NnhsTzRRMmtubkNMVy9VbXhnSEplRjhCUG80dllCMW01K0FDSG1FZjMzNmNx?=
 =?utf-8?B?blo1WndIa2VKK2RDbEFVTEpsSHNsaEVFNjdBWWtsaEFzckVqNU14ODR6RzFF?=
 =?utf-8?B?Z3hkOUE1eFJsTTJrZjJ1a2JteHZqc3AxYXg4dnZNTXArZmVLVVpkVG5CbGFQ?=
 =?utf-8?B?SDVrVnZOY3ZZeERIb1Bpd3FITjNVNXdoQVRGTmdZbTd2N0I4VW1nS2pUZGtD?=
 =?utf-8?B?b1FKLzhRZ2hwZ3Z4NXp1cXJqZzNBd2c2STkwajNia0tjNmtXcmt1SUdyTlBh?=
 =?utf-8?B?ZlN3NzFHcHNJUkpLZWdrK29MUlZtVUgwbHIwSUdDNmpGYjlkRU15UVkwYis5?=
 =?utf-8?B?ZzZkVW96N1FQV3U3NmZOYkJTbVBZWTJZbURVQ2FFUU5Mck1WL3A3Rkh1bkNv?=
 =?utf-8?B?NlNUZTNzV2hzVWR3MDRMVDFQc3JrT2lxWU5yWnp5L0M0S2Z3WWNjYUN0V3VO?=
 =?utf-8?B?ZWlEdVVqYkxOLzFwOC9ZNStOQ2lsOGVrdUs4YmdmT2h3U0FTMHRGRUU1WUp1?=
 =?utf-8?B?aUV3U0tQeDVrZkptZ0RvSTY1Q3R4eVBjZWVTN2NqSlJOd3R6UTNIVzZYSVVP?=
 =?utf-8?B?TndKckx4UFE2R2pabkc0ZDFYb2MzTnFTb1NQcmlPNzIxc05CMXoxdTM0Vzhm?=
 =?utf-8?B?R3hVYW43cUUyZlhlSitQSjJycmt5MERHaU1rWEljQk9RcGJ5ZitlVHpBQ3Aw?=
 =?utf-8?B?N1pLakVmQ1BrNHhLd3NRU1gyMlhneEdhR1pJSUxpRm0wSTRuV0paUnRwRENV?=
 =?utf-8?B?YjF0RWltODZmWVZBMW13QUpoa01ldG1NOVBzNUNjTW5MV2JzaXRCYUdiZk5J?=
 =?utf-8?B?UHZvYXZ2ODA2eVFqVzZsaTQ1dUNURnlpWU9haDRFZXF1WkkwaTI4b2hVZmVD?=
 =?utf-8?Q?Igpxf68bc/zeQp9nsI3wZBpeX1yQPEdV+0dU2kxvI?=
X-Microsoft-Antispam-Message-Info: W0KCmR3LALXUo01zw3oVUk22xOf59DUUFrlOA/Jn2fBGTIpThZJWPPnmIwThUAfg9Nj/h0rSpdv939Rhzgq242i+7tsK0OVPxfh8fAOigEY/MNaQ2qL9Re3W27kR1c7PJnSir2FwE6gVtdOcP7jtVWzon/5+d1zadpUoCvjozfF2ef2/M6/Sf1GbuKX8iHLlnh5t5xT/6uxK3DysgOCDsGulPj3DXrzXN1KUE9QPjdeGnwE9Hne2Bdk46JX40xETfdXpsDqGzbHK3fjHafar/umS8QOD95SeHwdj+f1ELSSoMNq+EhT3ow/+4OyvtB5/L3paVduVXikCPCnVB+wCBA6gpzOnJVoZuLa6LVTbEdw=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;6:hmlJ4w1kqT5/1QbrFMglt9JspGe57tmL0xbkqOAaoB5Itz+p8bQcLTrjCOITAUnmDHv6aFdFzfvw+E3CouWNsV79wmFWGjUj3WrQHmtb0uU2/T/k5drglDrhPekMvXT+1c45FTFxAuUvJLQ6GyZZlpiw6cESvY2PpyAG4Uz6wgK1NCmqjmJKldHqOl+Iwng0kpTb/1ySPp35ZqtqxSQux6DDGfpI/bIM4cdHgFlqu88HZ4pBovugBIcOr2TF7jphp/cpCrJXzlQojkxUCQSU4kULjdMM69fABa4Ehz5UpOGkLOYYD52YA8iJaMuWXJYz8AZ7CBtVkREXURlWCEYE8jkVdMZlpw0YORsPLOUTWNzbuT0/iQ2YGG0SH+lI9fUa5jdxrzJIfxmFTHTjq+dY7mnvIhRXrEiHS4Lx8K4IdAXd//ViXWTOW2ILxhCLmUFbn97dyZQk5fl3Q5cHJSzVFw==;5:IODdBN7uyIPxIIdFrXpN4fVSo684rm0MNknQ1iTYHt4Mpu+ZKTsXoLui43+ydMX8vTf7uGx+9EWJnMo9VPbAfftSgguc1NOlbAxFi7ErvFkokrzuROqlc8QcV6ahV85eCcgDxkSu/BNuUxOOfE/3AnCRwIpq3msp1nCR9alHrvg=;7:YJwJuGlvyniwPgUqV34kTfPIsrCpFsoA/GD7ljFk5hJlXMlbXvQa3Jx+o+HGrEY7/upNv0jVclRfdxggbniy93Tj1jVUYRCdyYip3llqAReRRZCXcS8fbltrISYN8I4wdK9DFgc04tDDoVIFuacqk1IzN+jjnknnldQSzAoweBaBBlPZxTQL217dW7S4N1EATT7YbGCctdSWxGuKEfLvWClvQDno33WUGQfpNFd96sP2AerXW7X44rG7bdIOjZhv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB2025;20:/z82b4ka29IOaPC1lFZWE5f+p5+1+GmWo6K7iEOk+hPcR6f6fIq0Xh23Ob3I1g2Gt17TUyqxAINROKspcXSJdPjftaBhyY+QnH4Oit4FFQPewgOGRpPRKmsk4CBdP85nJj/a8frgFCdPMPMCb91bxO+1MMincIOyWH9KHVxr/TE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 15:36:20.2704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851eb3a2-3d78-420e-6c18-08d5f956dcca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces a special value SHRINKER_REGISTERING to use instead
of list_empty() to detect a semi-registered shrinker.

This should be clearer for a reader since "list is empty"  is not
an intuitive state of a shrinker), and this gives a better assembler
code:

Before:
callq  <idr_find>
mov    %rax,%r15
test   %rax,%rax
je     <shrink_slab_memcg+0x1d5>
mov    0x20(%rax),%rax
lea    0x20(%r15),%rdx
cmp    %rax,%rdx
je     <shrink_slab_memcg+0xbd>
mov    0x8(%rsp),%edx
mov    %r15,%rsi
lea    0x10(%rsp),%rdi
callq  <do_shrink_slab>

After:
callq  <idr_find>
mov    %rax,%r15
lea    -0x1(%rax),%rax
cmp    $0xfffffffffffffffd,%rax
ja     <shrink_slab_memcg+0x1cd>
mov    0x8(%rsp),%edx
mov    %r15,%rsi
lea    0x10(%rsp),%rdi
callq  ffffffff810cefd0 <do_shrink_slab>

Also, improve the comment.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0d980e801b8a..c18c4acf9599 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -170,6 +170,21 @@ static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
 #ifdef CONFIG_MEMCG_KMEM
+
+/*
+ * There is a window between prealloc_shrinker()
+ * and register_shrinker_prepared(). We don't want
+ * to clear bit of a shrinker in such the state
+ * in shrink_slab_memcg(), since this will impose
+ * restrictions on a code registering a shrinker
+ * (they would have to guarantee, their LRU lists
+ * are empty till shrinker is completely registered).
+ * So, we use this value to detect the situation,
+ * when id is assigned, but shrinker is not completely
+ * registered yet.
+ */
+#define SHRINKER_REGISTERING ((struct shrinker *)~0UL)
+
 static DEFINE_IDR(shrinker_idr);
 static int shrinker_nr_max;
 
@@ -179,7 +194,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 
 	down_write(&shrinker_rwsem);
 	/* This may call shrinker, so it must use down_read_trylock() */
-	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&shrinker_idr, SHRINKER_REGISTERING, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
 
@@ -364,21 +379,6 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
 
-	/*
-	 * There is a window between prealloc_shrinker()
-	 * and register_shrinker_prepared(). We don't want
-	 * to clear bit of a shrinker in such the state
-	 * in shrink_slab_memcg(), since this will impose
-	 * restrictions on a code registering a shrinker
-	 * (they would have to guarantee, their LRU lists
-	 * are empty till shrinker is completely registered).
-	 * So, we differ the situation, when 1)a shrinker
-	 * is semi-registered (id is assigned, but it has
-	 * not yet linked to shrinker_list) and 2)shrinker
-	 * is not registered (id is not assigned).
-	 */
-	INIT_LIST_HEAD(&shrinker->list);
-
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		if (prealloc_memcg_shrinker(shrinker))
 			goto free_deferred;
@@ -408,6 +408,7 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 {
 	down_write(&shrinker_rwsem);
 	list_add_tail(&shrinker->list, &shrinker_list);
+	idr_replace(&shrinker_idr, shrinker, shrinker->id);
 	up_write(&shrinker_rwsem);
 }
 
@@ -589,15 +590,12 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 		struct shrinker *shrinker;
 
 		shrinker = idr_find(&shrinker_idr, i);
-		if (unlikely(!shrinker)) {
-			clear_bit(i, map->map);
+		if (unlikely(!shrinker || shrinker == SHRINKER_REGISTERING)) {
+			if (!shrinker)
+				clear_bit(i, map->map);
 			continue;
 		}
 
-		/* See comment in prealloc_shrinker() */
-		if (unlikely(list_empty(&shrinker->list)))
-			continue;
-
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY) {
 			clear_bit(i, map->map);

