Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2333EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27C9208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="DUy/ORt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27C9208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403862AbeHASdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:33:18 -0400
Received: from mail-eopbgr30116.outbound.protection.outlook.com ([40.107.3.116]:19424
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390188AbeHASdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xv4J+O9A2tix2Bhxf1s8dwYd6viC31F4LeshOSMr0g=;
 b=DUy/ORt7AhU0LkgQ76IQnkJTMZzmJK0+V+NhL0yXXhGBVryh5RCjnfL6UsALD/31VwWcK6x5F51bG1wUndB6dayfmVYJYSi3hLEaxijeZ+1BLMAokHWgNiDaGRZCoyUUjMaziBA3fhg5VH1r10ZQ9HjG2OoMspnpncuK498YLgk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from i7.sw.ru (185.231.240.5) by
 VI1PR08MB3263.eurprd08.prod.outlook.com (2603:10a6:803:3d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Wed, 1 Aug 2018 16:46:38 +0000
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: [PATCH] netfilter: ipset: fix ip_set_list allocation failure
Date:   Wed,  1 Aug 2018 19:46:29 +0300
Message-Id: <20180801164629.3621-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM4PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:205:1::44) To VI1PR08MB3263.eurprd08.prod.outlook.com
 (2603:10a6:803:3d::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30607490-cd0e-447d-a149-08d5f7ce5a56
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3263;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;3:Bwz+MQ4F11yiKhZmZWRZwGK+ok8YdzU+S7/LxhkSUQqCsCdjG39AQucbLZWgzrURBMr3b9U5x8Xfsz7uO7Vs4muencvVOurhcCtAcoFNDS27gVDJlFHtvPQ4/IIojLBhRSRNSbptA3hw87HuwGvR501uTPsPoaLfj1Dea9zFbw/j1MxAFKmERtORwNvo6WHahv7yYWsCU5OTk3uCyovLA4reovFvIvvyilZp0JxswE+7hMAnt1VgPrnuP0J0Z2+b;25:NGo5OjDFOTHGpIh4+xrLNBzITktmxVOtR38pRy8lAQCGCaxHVr9WXL8aqUTnoo4XFpIqv4nRH/OIX/3RXLkZBkdkTwA+5MnHIeo/Bz1/sB/c0rZ0gb60iJ/pDnQUtD7vXk9yYy+jErOGs5d/43UPHW51KHTYyQX+M/riY/08gSqq+vUShmSkL4r4DW7xu3aM0T8zIYkSaXWtj6i28Cikx2KG7ApELPgFKLEeQjuFdlktfqq3NFcWwP6gUoytAt6pGXQ9Bf4DBLlAW44asz86+781LOXl8yb6UzJrTwLuCqbt3MSlM6sL3RZnlA7w9tDjh0ThvK+CeEjoC4gVtE/EmA==;31:XPh3+Haw2dDH7oKzTJYEVlHOf3LYKr0bRQgFcXJ4rxWQpJF+MGJSaiaEP4ADakz4W9U+isRZ2AqqbZKbFZKUdYB3mYwZ6KVMQPteZhqGWSd+MJvx1Dg5W5uBKAo/pMryJQVEMu0XXUZOy9UH7phpajS3J0Bx8HY5Us5cmu6i4WPqdMO9gtvl9izpYPUzGMoNBypNjNACUhB4GGkwZgDiYBJZr/UDsS6L8wozMQ8w450=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3263:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;20:g4Gu3YKPSrXjciN23B1lh+ha80Dfd62R6W4YcwkEy+XTLSDQXGISAxj5hiTUwLKFTnZh+pFHz3twIoWg6CYbzujZIk71ikRgbpdwMx2d+eXvgwaCK7AG+tiIgk8jiX37T0HijyQL1SU28yJ7ks1Xi0082BKoNGGmFaBj/RKFQByRfzJcF0zVjDhDRHboSG8HOp+ugkmOdHKhqDUpHfOihjHDh7QRz5RWYNct9isMA2Is2zzaFei8K48EalbdZV/vCyfuL1MDq6sSfVjDjJCxYi3jN0mYPT2M45pPjYFa8UZTczu/5fduPwybdXBkBSNnkyUZVW6K9wGAa9KnTmBazLxdXuTsA+YTY4wiE7bnT99YMuxIQ7lQeFLG0v/JMxgJejf7fP6thaVJZJ7DVIGb9OCWjP7q+lf4sgDK51q982uxjJB+STF228YBztZL8gDdiVCIacqJxvK+W5d0t3iPJne/BeB+twpjHc51OrXsiru5qOathOh9mIAMqtxl2FuZ;4:QB56U6xNJC6XxT7n6TgKvTdaM/4lZoG7h1rA11r6Jm6UFm+3KlgM6micH/Y+Fs+9eGcCw18TDRilngT4+QIrBRpu5bMyk469K+/ddJmZs+wuZOS+o/hdi2bBv3h7xP+SHO/qPFYwen4xdeihTXG3XuzwhVc+GfXihJiR9Lxfw30l8TlxIN+PwHwjNkqrbENw+gDjINjbADGfY4B+kQLm8wjyRzk2SyLuXswBspqTD6fWhP0N/nff5fQYMMryt/jiYkQGrHC1xGNWSfyiIkXt0A==
X-Microsoft-Antispam-PRVS: <VI1PR08MB326376F4C9179BEED8C222D9B02D0@VI1PR08MB3263.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR08MB3263;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3263;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(366004)(39850400004)(346002)(199004)(189003)(4326008)(6506007)(2616005)(68736007)(478600001)(1076002)(81156014)(8936002)(50466002)(48376002)(50226002)(81166006)(8676002)(14444005)(26005)(110136005)(486006)(956004)(316002)(54906003)(6512007)(1857600001)(386003)(186003)(16526019)(2906002)(3846002)(6486002)(53936002)(86362001)(305945005)(6666003)(53416004)(51416003)(5660300001)(66066001)(105586002)(47776003)(16586007)(25786009)(52116002)(6116002)(107886003)(575784001)(476003)(36756003)(106356001)(7736002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB3263;H:i7.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR08MB3263;23:NHC0kk+2Ws2su+xH93bvv/3AeIGvkKraXSDY7L5Z7?=
 =?us-ascii?Q?vDW6tu3rkV9CyKStFM3aAKDC4WKKKOAHH1fQp5r/YsiZQSE3lNwgl97MGC6E?=
 =?us-ascii?Q?9ZvVldV2KLY9q5jITKnWZf1CNJXZ0JVwNpKpCAsMQGazlzn7jrbm+pRw3QZg?=
 =?us-ascii?Q?b6Iv0CbEQwVMsBPAQ9n6c/J8SVVcKgI102JpDCLf/wP6FbjJtaZukLUWyTwB?=
 =?us-ascii?Q?82GLoGwV+UcoLyFj1/DuHfxo7m/QRyWYn5n4HGATaZIJpXnhS2OpmctKcSPv?=
 =?us-ascii?Q?8pymm3R6oYCAti03cuSBv14IvVLfBivDCKFtTrAkM8lEkg1CCdRcUfrqMUt5?=
 =?us-ascii?Q?OkLkubUCP+5z4kC3pu5Q2EevHVef2cXsmkeE0AjJ3RNHBnsUFwONU44LR3t2?=
 =?us-ascii?Q?vnClWYZEFbkdhQQQcsMeqgNUg9KtZqIIYLe38f3yWCct/fUh0Ef0hhGvkKoV?=
 =?us-ascii?Q?x3hOVxNsXOwNNW3LuIbLGzm4KO2yyRdhIeeWkgXVq8oSKemsWeUigPjNbY0p?=
 =?us-ascii?Q?J5mGeubUISOYWaJX+6LrJn3KSgPHS6dm8G+4t/SA7WmJL0U5ymNG1LEWgvnD?=
 =?us-ascii?Q?zJqp95hXhCURtNca7Z3oEoGq7aTJxmv+ncecbH+TR6ig9hhkJ3VmbVxOCube?=
 =?us-ascii?Q?Ush6trzKPheDR8csd4yeg1RjuvGIORkIE4njXGuJm29eQfXBwUQecQesLjPY?=
 =?us-ascii?Q?ceVlXUjrF+ysr1WwYMVGpAdBXEWA/rDgXaz5SXixezi8nIucN1n5ut8pD8/V?=
 =?us-ascii?Q?T9f0VtOwRZmPDDQqE5TJWYQOBGxdBBnB+XYWA6xYiFDSgbcoAZUbU5Xi/fBc?=
 =?us-ascii?Q?6JTqBa8hIeFnGsHSrcbuWYcAhUyMjVfYk/r2lUYn9+eaCFAHtzo1diJa5NkB?=
 =?us-ascii?Q?ycYJYQgDo+EzGJ07/rJcSKHaKT0gyTKKT6v/l2TsaQwppsbGQdltH+YRQqs8?=
 =?us-ascii?Q?OtfjlK5D8rIvv9mWUkxMUQqV+chFrgAMa6WXeoKiQe2luPFYifbXCzfqfitq?=
 =?us-ascii?Q?c7LFbkGM1+ITrFnkN2Y4FalZ470ZRFjUKWN03mZtXtCH4e2FeyAEhs8ZTrLj?=
 =?us-ascii?Q?WDvhreM6nsw4nOYaMVy4FLRFS7yRV1iYw26D9wqLmmjhr+ujULEy32aZpBFS?=
 =?us-ascii?Q?cj74YaUlIvFW2uDi8LpT/8EizMACQuRLyVMhj8KkTil9TCHPmRyYd6aFiUWB?=
 =?us-ascii?Q?5p1T1nj5N8Bln271K8uHm78U9j2AnmD++6G3n5nIq/C/Q4fUkkj0xu1JIjw7?=
 =?us-ascii?Q?nw8NZYVEU7xc6bf2X2WLAFC3EftsNf+RNZO2vYC?=
X-Microsoft-Antispam-Message-Info: bW1RRs2mRIF1mQ3hgXsd0H4XQmZpyDl3w/wiyZCXtscm4RlEY8yJTnk4IxzhoaNKaws589hYv8+tZa+Ddm9FORJw3CqLKYgeSu/frwF5ELEddk2Woz3m5CGO0gw4K+HxbaYd9zSYi15XkLFlXgBs6pfi6vI6qWlDEU0Kd3LgvT8/KsfG9KBzN3neod7R9cKaodh/1T6s+4rfaY9buZJcxEVu0nftpOLSKESbcR4REAVakN7BjvbNqle6WXRMdH1C91+oszLMNMhoZy5Gt6mkvOgeH9z/lIvIGa545GSuhSDZL2VlsszLrVrIFEhJtXYfwKOL5bIwA5j/duA6CCbVxf+G7EjI/CtXkd0M/gjjxeA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;6:ZjKwm+qVtjuzcAcfBXt0PFtZN+Thtu67NP1UFg6Xz1YmX2yQ/JPEz7ySXob2DhEW1Ha0PNunlqUShQSQNEaQ2uVJP8E7qfG4nv0rGvVPcleZwUPjalwO/7Lg3/0s07tVUJz3PcJ+TIjZ/BHpgNg74GRYYwfsGdf9ZwqUZdNrKuQsCxFS57AAVmpRKpqq/z1/w01l50lKkxaajDS+fdyLtl8c2vm4LdPKitX12XhC8bhBhQ8AkgJOqBQV4Tw/lH7ZW0+U/o6V4L/gRKK4G4EOBZtuodaksUsUsb4nFZgmrtd/C9v0fWaCj40rvJBgv94lN9x/Ae/ndekC87XT6E5qdQj9aRnGry1EPMNk6Tx0Zm1ZHrGkXe5MgQ8OqutOlKApfSaXX3+dyFDwuxSu+QAuHR1vF3gPrxa33QYj1sZSHN1lj7Joawbkywk3tmL5HqpJ7mFfc0NQB0RHlppRhAt06Q==;5:BNGq5vku/MRVQzvzK6Q8rDuFhgbokHHfiqSv8WYzFlkq60KA9Xb9zsXxVXt12/rdDtXRtkaGxq2NcU4scH9HbE3DLuU4otYTcZ1fXVVYrz8Ce98eINnJRKK7d4aiHz/2yuewnAXxHMqjab060gZDS5XhuyFzNwm0sP3kNM6vJag=;7:awd2oN3POjb7zCjBxtuXGhhVWAeAnXOsEchDv1tkwA4UzJTHts7k7xhDnv8JbWh2uuvYEkLxNv00gcifkfKMkVIvbX5CxZ/18KdKoB8zrDjjRCBvmlMHuaT2sURhtHfl+1t8xK6n9fTPrs8b35W8Uf+YbCjak7kj1XA+ffd7WC989VIVDp1YNUgzeJ1UlD8YGB2XIheXpU+Lv8x9me2u9dzIN+pNnrzrFjtSZxhPSPXATaw/K1pO4/BTYi3iMbxN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3263;20:7MXYSnkEY3nGpE8nu4z/zQN/GQmTeXHLzsh7nGLJgU1CS7em6kxnLheJVwlDYJfLkLrUz1nKXxTtJqRoplbNks1DKfs2x4xwf4jfXg1F8qgohuwLqPId8BzWpJMHA+YH0WktqxzubD253q4ueNY7Ac8/DUTFuUAJWuPvsHtWK24=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:46:38.5717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30607490-cd0e-447d-a149-08d5f7ce5a56
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ip_set_create() and ip_set_net_init() attempt to allocate physically
contiguous memory for ip_set_list. If memory is fragmented, the
allocations could easily fail:

	vzctl: page allocation failure: order:7, mode:0xc0d0

	Call Trace:
	 dump_stack+0x19/0x1b
	 warn_alloc_failed+0x110/0x180
	 __alloc_pages_nodemask+0x7bf/0xc60
	 alloc_pages_current+0x98/0x110
	 kmalloc_order+0x18/0x40
	 kmalloc_order_trace+0x26/0xa0
	 __kmalloc+0x279/0x290
	 ip_set_net_init+0x4b/0x90 [ip_set]
	 ops_init+0x3b/0xb0
	 setup_net+0xbb/0x170
	 copy_net_ns+0xf1/0x1c0
	 create_new_namespaces+0xf9/0x180
	 copy_namespaces+0x8e/0xd0
	 copy_process+0xb61/0x1a00
	 do_fork+0x91/0x320

Use kvcalloc() to fallback to 0-order allocations if high order
page isn't available.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 net/netfilter/ipset/ip_set_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index bc4bd247bb7d..96dd57c48b1c 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -961,7 +961,7 @@ static int ip_set_create(struct net *net, struct sock *ctnl,
 			/* Wraparound */
 			goto cleanup;
 
-		list = kcalloc(i, sizeof(struct ip_set *), GFP_KERNEL);
+		list = kvcalloc(i, sizeof(struct ip_set *), GFP_KERNEL);
 		if (!list)
 			goto cleanup;
 		/* nfnl mutex is held, both lists are valid */
@@ -973,7 +973,7 @@ static int ip_set_create(struct net *net, struct sock *ctnl,
 		/* Use new list */
 		index = inst->ip_set_max;
 		inst->ip_set_max = i;
-		kfree(tmp);
+		kvfree(tmp);
 		ret = 0;
 	} else if (ret) {
 		goto cleanup;
@@ -2059,7 +2059,7 @@ ip_set_net_init(struct net *net)
 	if (inst->ip_set_max >= IPSET_INVALID_ID)
 		inst->ip_set_max = IPSET_INVALID_ID - 1;
 
-	list = kcalloc(inst->ip_set_max, sizeof(struct ip_set *), GFP_KERNEL);
+	list = kvcalloc(inst->ip_set_max, sizeof(struct ip_set *), GFP_KERNEL);
 	if (!list)
 		return -ENOMEM;
 	inst->is_deleted = false;
@@ -2087,7 +2087,7 @@ ip_set_net_exit(struct net *net)
 		}
 	}
 	nfnl_unlock(NFNL_SUBSYS_IPSET);
-	kfree(rcu_dereference_protected(inst->ip_set_list, 1));
+	kvfree(rcu_dereference_protected(inst->ip_set_list, 1));
 }
 
 static struct pernet_operations ip_set_net_ops = {
-- 
2.16.4

