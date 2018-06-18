Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AE0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3EA208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="K4OSnMMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3EA208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965351AbeFRJpc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:45:32 -0400
Received: from mail-ve1eur01on0110.outbound.protection.outlook.com ([104.47.1.110]:46080
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755091AbeFRJp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 05:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz1edjlLoesrcj1TJbgogzpJaej9F1Z9g3jkD+bPpaE=;
 b=K4OSnMMZkxwW3HUUSHQ3n9P8nZuwkIMncX6uJxw0h2CKpdO7fpUKPh/ddxaYEVU4JiI823e+BmWXi9wxkqibUud0hsi8PS23uYcsJlfQw5ss22OBAJms/kLuQQc8AJrEeDp32D3YW50My0KmnGAVRCtIh6f/kwMFVAtK9tWN2rw=
Received: from localhost.localdomain (195.214.232.6) by
 HE1PR0801MB1339.eurprd08.prod.outlook.com (2603:10a6:3:3a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Mon, 18 Jun 2018 09:45:22 +0000
Subject: [PATCH v7 REBASED 03/17] mm: Assign id to every memcg-aware shrinker
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     vdavydov.dev@gmail.com, shakeelb@google.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
        tglx@linutronix.de, pombredanne@nexb.com, stummala@codeaurora.org,
        gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
        mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
        chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
        ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
        aryabinin@virtuozzo.com
Date:   Mon, 18 Jun 2018 12:45:19 +0300
Message-ID: <152931511969.28457.16645798841790418186.stgit@localhost.localdomain>
In-Reply-To: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
References: <152931506756.28457.5620076974981468927.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0802CA0015.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::25) To HE1PR0801MB1339.eurprd08.prod.outlook.com
 (2603:10a6:3:3a::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d49424fe-eb82-448c-f4c2-08d5d500367d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1339;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;3:KucFE9ZjDXNkJSqKfzFnlumIRn/sCTW8AN6XuSO5XAnVteGXYo9TVfzJc/TybTObexjdLmEZiObLvqIK2iI9YR9+mMJyxkbtZ4uVMQ3U5GM6QV6/cJcgUazWXaWGEsOgNpwQdpoiDKUdhpAuIRCUHK/rbcByYoHTbw5IPxbPOAaHez5fDZ2lHOYAEFC58H6/lRR9U4dKhe6LQLEEv+hGTtz7cvEkV8aGkXTNnMg7oW6JwVnQvzrVhS2TkSsBrfk0;25:7Y48AdR958qzCX3QZbo1tb2U/T5VMsmgOmY0H5XH1GPNcQPOZrR5kR3Hc8OlM6GkEBz6wJQlJOyJBCJESV1Z8uyjxJQXRomSFxd/fNToPNwOln38ITCoTVnOEKYLXYGn+czp4GrpiEXWw28umZq2Ph/vk6chEAJXn3ofC4Otbs1dUKKA7EwKkRlJRNe8pj9Io5B5HM+O/pS+P7KDXOQsUyMxhPL1avP88J/FSh7Snz+ASptcxKIu25F9K1RSGxxh7SSFkWctVKS1sJBd3Ci69S452byRT287agCM54BH9p8E/rDzQ3chG0q5aDaPM/uVLgj8j03ZuWDblv+W27xqYA==;31:9wnOzOYGCwRp2b/RvKQAZnZwz7feG0RG18Fut0qhZnDpzrA4K/hoGDiOALZ7Jm5Arg/7ysneiK+w+MZJKrIoNnRficiSlpNkMez5ZhvVr67HjobkVMMw14OT7ROiwSIHYR6rEzhh5QIlX5dPZlPv4/ZG+3rlx8LC6nWNfLusUqWzrlqJw9TRrtjFegs3yMwQababsVDVM1B8/1C6jujk8IUQ8zXVIxlVnS7/RY7Krfc=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1339:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;20:x9PRnULj07UhOBnS4k2oL4z6zQSYsZpZnuWL4K5tO5ypfg0sVF1jaVKJi3/we8Ye1NqvazVEj6aXXS38L39Y2DiClY763a9Iz05Kvs0OrqtQ5iPcSurhLpr1BQs4XqfjaFSDleRKNIFMUnTCcc9z+Xo5L9jLp1q4gSQlmxf7fyRCw8X0d7TNnklDHr22hcuOugab4PZOTDtTS6bqS1qqcFWL6D8qPEBZHIbuFBA+LPRECyqLwteUeHKqHx69H46hWgja0fQPRp+IAD2y8erEQXGfGZC6MEX/YLyBiHbLjxEdXPt5fEfZ+HkAF21Goag1bEMdj2UluhOHlKcALDWIk5SCMcsUKqAInaHqV0/2o7toVRjR2+hcA7r7pzLJOBmLKhcYL+dPjznglqTKD6PJNwX6tZVkfrY6/MXAWPtRrYl7mrYbLTGeVOcJ2Xl9jKI+e7XN3ry2fioHTFgXCygxjz5ZvVd4aTEFzteybN0ce8Ik6XjOP4xl2kljT1ljrFcG;4:hztHOHXsfwccILXYkkiw+c73fIKOrbiJZhCdAHGcJdHLkurSdbGu13ZLcJGdCs3+tQW2TSUqFt+V1FcELVMiVWEBea9oWA6t3UwdhHGHu7ZewvQsfb8Wq6DOk7pUYJKzD1USAqGXxe2HLYZTVOdEwFw6tJW0dBx6Ast45Sr9Np7dkl2RmhpX8eOKrA00Omj2WgeFtEHOjrkrJnd9QgiCHtwz/qtSET97vF8ujR1nO1283JT/wYTM6ZtXlDNwYNJJOf3nBuKfKtEhzPnMrtOdx4C2oFAwbw5bjz9CUQhU6tpJfbzkqJ0JgQJ4I6Zpr4HW5y51FZlyMt/8lwdKyA1mUMxqB95QR0rY6cCeB0W1BdfOlXoUflN7mdX0X1uLt3HM
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13393853A9F4349F7010A053CD710@HE1PR0801MB1339.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1339;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1339;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(39380400002)(346002)(376002)(39840400004)(396003)(199004)(189003)(476003)(11346002)(3846002)(16526019)(26005)(478600001)(9686003)(186003)(105586002)(486006)(6116002)(106356001)(6666003)(86362001)(6636002)(446003)(956004)(68736007)(103116003)(2906002)(53936002)(39060400002)(386003)(8936002)(23676004)(2486003)(52116002)(8676002)(76176011)(7696005)(7416002)(58126008)(61506002)(97736004)(305945005)(55016002)(50466002)(47776003)(230700001)(59450400001)(7736002)(5660300001)(81166006)(55236004)(81156014)(33896004)(66066001)(6506007)(316002)(25786009)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1339;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzk7MjM6MFFMUTY0WkxPRlVuVEdWa2NiV29oMmNz?=
 =?utf-8?B?d3NxOGJ5WHp1VjFQWldPV1RJYjZRQllOZk9pb2JVWHJoNUJsTlZhWit2VXFR?=
 =?utf-8?B?UTZNZHU1Ui9hbzYrdmRsVjNsQURGV080UU9pNHIrMThMZjFaTnM5VUFGM0FB?=
 =?utf-8?B?NWtjeXhvUmk0TWJ6Sm1aTFFGRjhaa1drbDNueUZpdFFjOThKWmF0ODZGa0hm?=
 =?utf-8?B?OTV3RzNQVFJINnVxajJuVDV2cEZpcEhPWWVYZE9lZWRhMWhITDBUNGZMcllN?=
 =?utf-8?B?aVJxclUyVWdydjF5b2Z1amFXTDRIZStEdG1ROXErN0RuQ3pZQjdXLzVpRUxT?=
 =?utf-8?B?dzJyL3lVdXBYUlQ2OS9PeG5BMGtRZTVPTXQ1QWp4VitidnBPNTFKV3ozWW44?=
 =?utf-8?B?UWpjMDlaSXBvK2FYb0VwYVQ4aXVFNms3dEgwZElRdlhkWlRDTWc2NmlJdkFJ?=
 =?utf-8?B?TGtqcWRhc00yVFNNNjhGZFFJUUl4bG5UTkdoUlQ4aDhhRWNhbkc5S1ZjcHFj?=
 =?utf-8?B?cDdVaE8wM1c2dVd5bDN5OW1GQ3VYNXlzZ3RiYzVxUVFraGVacExwMGVTN2RC?=
 =?utf-8?B?U09WZ0xqRU1wTzJwaTB3TlFDNTdsSEVweXNyaS8vTDd4aTBqaWM5eVY4VUhD?=
 =?utf-8?B?UW15WE96aXRzc2IzMkx4eG1WZjQ2amgzM2JYNzRFUmxLSmFhSmNYMno0VDBZ?=
 =?utf-8?B?U3pTV0k5Z0RUUjM3OGtBS2tkSHFkVTlYcnRwKzZKejYyK2JqQ21OMVlxVk1P?=
 =?utf-8?B?Z0M0cFEzVUthQmIwaHBPWEtrTHJocWNVNzNMa3B4ODNIckd2Zis5MUgwVWN0?=
 =?utf-8?B?akp2eXVXV04wcWxmOXZIaUhWTTJsd2RJcTVVWmYzd2UxMEwrR3RBaEpUVzBK?=
 =?utf-8?B?dHF4MWlQTzNlTkJySUNuK282aEFiUWRVNWV6QnpSNUZGaGQ1bHpqVGdpOGo1?=
 =?utf-8?B?QW1INzVvZ1pseHNKdjlqd25KaG1nMmZySFhEWHg3NjRNejF3dWI0bEdtNmNn?=
 =?utf-8?B?TlRwNklGNkJqNnpndmJSTUk4YUI1ZW42ZE8vYnRabDIzNkV5V2ZWMFNsQTNq?=
 =?utf-8?B?VmhoSHBJdWlabHNENXU3Q3B5T2lvVmhiam0yQWtyNDd3UTdVbHd2U0VxNW1U?=
 =?utf-8?B?bnZiTUtaMWxxOXNwMmpkdjJtOU1UR2NKVEZ2VkFXaG5ma2N4ZFBBV1dzY1Vh?=
 =?utf-8?B?ZGkzSGFFM0xYeVROZlhLSUo4T2lncm8wbXB0cFFEQU16K2FRQUdVcnBQc0Zo?=
 =?utf-8?B?ZGJqNmhuaURuWng1a0xiZ1ZDQ29iZ2ZBMGRTTmx3eWtYRWJYb2lwa1NOaHpK?=
 =?utf-8?B?akFVQ2FhUy95N2F6d3hRcjdxNlJ3NnB2N2dnQVVvcUpSeW1nczF0OStIb1d5?=
 =?utf-8?B?cWlLaElKTGpLdWRIbDBZRXlHWHJNZXpBS1FFQ2N6OVJ5L3hkbkRZRkQ1R2Fq?=
 =?utf-8?B?dExkdmZBWkJDeUNkeVBhZ0lQVkpqV3pDenhOVVFjOTYwendsVnFNVzRIUXVD?=
 =?utf-8?B?NW9Na1ZMZC96dXE2ZklzTmg1dmRHdHJiQjMvaCtzbXZ1cWRiVmo5bW1lbGd0?=
 =?utf-8?B?VW04WFYxWWZUQnVvK1Q0dHpQR1ZsdW9rT0R0ZnBhRXc2MEFTLyt4WWhTZHpW?=
 =?utf-8?B?YkxSOXVLa0hJcDZvYnhFQ2VIY2FJeVZCZjdFdnJqV1JNQVVwYVYwK2k4UEdz?=
 =?utf-8?B?Tm16cWpwaFRyQ3l3S2FYTmo3ckZNSjZydkIzYXFQN3poNmJLOUpzREdBRnJ0?=
 =?utf-8?B?MUZ0RGFZTG1jWFlOVStROXNrL0p4ZVhtUU5La053M1pIMm9ZRlFCYVZaYWRU?=
 =?utf-8?B?bFRNMDZ5L280RUNDREg2S2RITWU5T2JZVnJjUWxJeDlQakRBZz09?=
X-Microsoft-Antispam-Message-Info: mLCXPoDlyKNn+aferz5MdQ8KyTz0jbTKE7AECBNIrpocAbS438lhtjbtiWhEQFuMjf0yO393qJIiB5DbVqzS2oQGUhLfKjB4yE1O0U155IaMxO0VyZNV7kLWZBlULQ2ownA0kbamEAXPQz9E5NMeryVsTpuOlGLCrENRpqpagjckyc6nV3ZyOb3cz1sn0BJM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;6:aFuddwXssYtgVVR3NDX3qj1khrLLO2Q1I8JBmmGv+qFXXESw+vj0j6iAvf5DRpAfMBgrBIm/+FyI11XYSBk9F44ZaAy9TX1kEO69Dbc75RIcugQrLSZeqpdBiX2QiA9978PTgIfy+yZMgZ4djLKMsFEQyb9sTWlLWlRT0BqeEEt7xvJdX+IkbB5P2zurtKBRCGf9VzszQqeI1cXRr/sNRfiFTeSpjRmxm/qwpJTN++sKrayG4JZBBFkei0m9x8BTKOpDR48BQxr47fZ0pBewVdZZ/No0ByNOlvgPr4W445gA7yGaKkZ2Nr5oS6m8e4n/klX81GYZbmOapd2aqlfIL7bQwdDCjvaZ/L+RC/L/cg6g3fCrnDqTn4tehrS/ekw5L8M6X2ge6vyOKf8q+WKfUdZZE6eOmaNddpMD8HxgoYPzA7mOmU4i/t022qtRBMohjdiCdGuFyBT9cwbns3aNRA==;5:oNUNpACjGB7pCFluXSdU53DpsxcJLvTplNaBxfZUMNGavGSoyb3iU2xj4RFGb9SComi3EaoZ3ICMDw1QLr3+LJHO6lRuDhsfQlSAT8Io+Ti2Y3cTpnzC8sIzLvrnjJhRof9eIkXD9UCIbo9QwGoq0qQbU34VHrucGHa6i9wCMQE=;24:Svc2nfNwH7SNBPhq//qHb4cqsHcRdIBAh+PtcAQtEaJ3ucZyV0TOT6UDvWaoXalp8XhdE6pEaRZkQ6djEYnnA6coSxkwzIh6FYFIIaHbXJA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1339;7:20SaB5GrfMP0pEepJGLLA7iYJn2c4vDR1fbMPNN335v3eU9yRTNqSbuAG/giF4oCWqj8bWIrrrWkrnuBN1SHSWd3GG8KjayXlhj0LFQBe8Pmju6FMI0YTr7SX8Hi11SqVsN8m8GA18kAVOTro4pxQy6cGZBECa1C+ChQa+yhybNoIh5xxHNjVKZu7WNyUNRLwCucx3gwEz4xm73hlLoD37trUIFQdbtuHOKUJb0rmSz4vHaAQLVZy1JxGPyx4Nfs;20:wK+A5TvonuZNRAYM5kbAV4nhfohP5/V0zjlfBtg8zSHXAIX1sbGZ4CSJkiwgxczLmQWsxUp4qluKNUq4wVNKSxepqWs8y7AukCL2AHWmS9Rzbk0j63ouFg18qY18cXm3IvQ2fittArgLQC0Chh+c9Pz3AyQHx2tjc93PHKAFhG8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 09:45:22.6017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49424fe-eb82-448c-f4c2-08d5d500367d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1339
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch introduces shrinker::id number, which is used to enumerate
memcg-aware shrinkers. The number start from 0, and the code tries
to maintain it as small as possible.

This will be used as to represent a memcg-aware shrinkers in memcg
shrinkers map.

Since all memcg-aware shrinkers are based on list_lru, which is per-memcg
in case of !CONFIG_MEMCG_KMEM only, the new functionality will be under
this config option.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
Tested-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/shrinker.h |    4 +++
 mm/vmscan.c              |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 6794490f25b2..7ca9c18cf130 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -66,6 +66,10 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
+#ifdef CONFIG_MEMCG_KMEM
+	/* ID in shrinker_idr */
+	int id;
+#endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
 };
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f86f288..f9fe0915d71c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -169,6 +169,49 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
+#ifdef CONFIG_MEMCG_KMEM
+static DEFINE_IDR(shrinker_idr);
+static int shrinker_nr_max;
+
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id, ret = -ENOMEM;
+
+	down_write(&shrinker_rwsem);
+	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
+	if (id < 0)
+		goto unlock;
+
+	if (id >= shrinker_nr_max)
+		shrinker_nr_max = id + 1;
+	shrinker->id = id;
+	ret = 0;
+unlock:
+	up_write(&shrinker_rwsem);
+	return ret;
+}
+
+static void unregister_memcg_shrinker(struct shrinker *shrinker)
+{
+	int id = shrinker->id;
+
+	BUG_ON(id < 0);
+
+	down_write(&shrinker_rwsem);
+	idr_remove(&shrinker_idr, id);
+	up_write(&shrinker_rwsem);
+}
+#else /* CONFIG_MEMCG_KMEM */
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	return 0;
+}
+
+static void unregister_memcg_shrinker(struct shrinker *shrinker)
+{
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 #ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
 {
@@ -313,13 +356,30 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	shrinker->nr_deferred = kzalloc(size, GFP_KERNEL);
 	if (!shrinker->nr_deferred)
 		return -ENOMEM;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
+		if (prealloc_memcg_shrinker(shrinker))
+			goto free_deferred;
+	}
+
 	return 0;
+
+free_deferred:
+	kfree(shrinker->nr_deferred);
+	shrinker->nr_deferred = NULL;
+	return -ENOMEM;
 }
 
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
+	if (!shrinker->nr_deferred)
+		return;
+
 	kfree(shrinker->nr_deferred);
 	shrinker->nr_deferred = NULL;
+
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 }
 
 void register_shrinker_prepared(struct shrinker *shrinker)
@@ -347,6 +407,8 @@ void unregister_shrinker(struct shrinker *shrinker)
 {
 	if (!shrinker->nr_deferred)
 		return;
+	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
+		unregister_memcg_shrinker(shrinker);
 	down_write(&shrinker_rwsem);
 	list_del(&shrinker->list);
 	up_write(&shrinker_rwsem);

