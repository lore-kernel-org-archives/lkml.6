Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeBFKUW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 05:20:22 -0500
Received: from mail-eopbgr20103.outbound.protection.outlook.com ([40.107.2.103]:63426
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752710AbeBFKUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 05:20:05 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH 2/2] mm: Use kvfree_rcu() in update_memcg_params()
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: paulmck@linux.vnet.ibm.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ktkhai@virtuozzo.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date: Tue, 06 Feb 2018 13:19:56 +0300
Message-ID: <151791239671.5994.2058061081618636334.stgit@localhost.localdomain>
In-Reply-To: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: VI1PR0202CA0003.eurprd02.prod.outlook.com
 (2603:10a6:803:14::16) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 756d8ada-4a12-4731-5cce-08d56d4b2e3e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:/CalB1iCqbI/7wZvFVY9IbFIRpopBWLmo89OiSLUDYjS1ACPtKWncHq8n5umjFFar7n0kQbDuWxeCzeURYEygV8tk3/8veV8tBTaKpZeE++B+i2FS3M2PX+OLKOZBuKgMCwWGYDymGe62rE6l1SAZGZVzwmynYjexQzIgTAGwjjbIHnB6E1sO9AeD0169QOkg0iI4wMBtvdAnpOPqcsYsefIJUseioG/uxmv6nzA5Aek0Yplqhr6uQymgnDhnxcJ;25:U5tpodWcHsJ8DTlHXBnJmFEFFjxdVR8iWdxE/TyQRCzBaGceqFgUctE94AuG5dsylRxtTcQj2LyDUnprN8Zsb1XvipLk4H6uDDrF2aPqK8q2SrnWobWgd/6Mr+w7S75iO6u1NNNTPF6UnXxgi3DZjAV+4JmaD0WDEu6vbHF5B/SWgU+A5zxE/U6+A/46KHOinqyFWhIHwVRdGM7yNT0EsJ2NrGNo9FzGDuWZF89jHkEbhRph/QzNmFtDRRfPs3ZZXmvneJdKRkGaVP98ZhsrwOfeiajV7y1yJMa+vpGUqHTT+F9cgeCOFMYObxEzl0tB/0//b/K3rgYrxx454PGWtQ==;31:kdLK1MrmCWiuwSyN39rTB39ea9mCU4hq8IIiFarWuf8wYgwB70eBFdaLnCmACzTaYHgJXdVFufrDnNbeyiMGRhc0icaibb5OjhMP+A4Ewd8Igdbi72Fl4jQZoFd7CcZdNEv7AFqTnSBwU8YGCOcnTOC676N0cwrgSOG/363LDPtQL8dlj0yVZKgW6B63GOubJqcAs1GCLeG7CSqhJ/spUyzqXwqWf+Z3+7RR7bNopd4=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:TEBhRGIA/A3u0PfK3lcH0NF1Ybvk+DV2DF6i31kk7o1SSUfITBT33/5B99SOJimTW4fF7WE5aIcWSfJq+FkWSJjUpmhmNpApPB0JU4BLg8cLM4yHVCtqp8SNGx3Rn1/VgsGopNYvuZ565uUPC7fC/tLyOhxgJ+zG48PSw2YvuREcMWhXy46CXh957xXgKLUHZ+cvxyABeDOx0oMDj4dT8JPVT+U4hxxa8hd+D0cCvx8EJpqgIvmlcekejZ1tIKcs/dKxi0KKylPhC2zhPa1GM24LxlgwNlziQVg5fRrXVb+GC+bK2CX0PspyrfWgjPK3n4qi86Fg42gWglvNfMHgVysmCQMrumGYc/muA05p4rC1trjJAAywJzZ0J3CukbEAG9Er+omlOIew0pFVLxjXFm4ZRf8yvZZ6k7X/lJmh1i0=;4:/tUGj6DL0AaFXGjyjej1L0Q/yGwATc3pBU0pKtlgbrexOHDipO60OkcqmWsuu964jkUFW/LmEbZw/8X1KTex9h+BtB4jklKpS+hWsbmJEwG5Xz8oSOhzLdO68/RLD6vtvwHxSJjwds2ZrbPhNkTUb+tMvcgRoLi5ADOyPIdESw2OsS+lgpnTHIdbBLpP3mpTW/oSpoi7tgl1gdEZ058XztrS0Tx7XJSU7Z2S5qCOWDN2Xc7FxH3ATNunrT747e7yDfhkB0/3YNohPGAICtnnew==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1342B8819239766B121E7384CDFD0@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(6041288)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0575F81B58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39840400004)(366004)(396003)(346002)(376002)(39380400002)(199004)(189003)(8676002)(7736002)(305945005)(81166006)(81156014)(8936002)(68736007)(39060400002)(53936002)(105586002)(86362001)(97736004)(66066001)(61506002)(47776003)(2950100002)(25786009)(6666003)(5660300001)(7416002)(15650500001)(106356001)(6116002)(103116003)(3846002)(50466002)(386003)(76176011)(6506007)(55236004)(52116002)(2486003)(23676004)(55016002)(33896004)(230700001)(26005)(478600001)(59450400001)(7696005)(9686003)(16526019)(186003)(316002)(2906002)(83506002)(58126008)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6cnhlZkhBVTRjZkQ3OUk0VmtXempES0hC?=
 =?utf-8?B?M3BGYUtvZUdvL1JuRnV1ODlnZUJ5YUw1aXA4UnlIc1E4d1kxeFcrNDFMYWtE?=
 =?utf-8?B?UlJwWVpLeGJhWllzeFdpUG5YZytrYXJRR1JreC9OZlRCZkY5a2k2TEVLb1lN?=
 =?utf-8?B?cDEwSEppWDZKRGpQZTJHaGdkTUsxd1F2RVJEeVNVK2p3ZnphTUtkY0YyUTEv?=
 =?utf-8?B?S3BGMkpmelFGVEtrMndIeDFzOTQzYWxiVmx1V3dqS0pXdkUyYUszaldiODdE?=
 =?utf-8?B?ZE9LanRwd2JINEsvWitpN0V6d2UwdURyd0dJYmFBc2RNYmpqM1NxYzlKbnJw?=
 =?utf-8?B?eEVEeCtvLzJFWVUxZnBKVHZJMFdSVUJtVEU0M3JRNU5TV3BXVVpMeGlxMGky?=
 =?utf-8?B?Z1ZMSzZLbVlXQnhPRmlFMlhSb1VvSENZSmV1NU02S1JGRlY4R3hzUm5GY05w?=
 =?utf-8?B?NGplS25STkFpaEwrRkczcUJ6YThEZmVpVmRWeUNzVlFlclZveDhwaFRZQjhp?=
 =?utf-8?B?KzB6VC82RHdPeWVPL2FSWW5UeHZBMTVBQVNEUzk5MFQ1YkVzV3hYRTF3dmFo?=
 =?utf-8?B?T2JRVjdEUGM0WndlZmZISTA1N0FwMURyYzVqUytNSHNlRFg1NzlOM3dSbGFH?=
 =?utf-8?B?NldaWjkrYnVCMEJpY2s0RGtKNk5oMEFBQlZlUUdtY0xEU0hPNCtrN3k1OGRY?=
 =?utf-8?B?MGpRaWpkS2xkRXdXWEZOYTEwM0Y1VjBjQy8vTTFaSzd6VmZPWFAyQ3krNUpq?=
 =?utf-8?B?cERtZVBMaWFQcUlxeFVEcnJxeWN3UVdoR05QMU9TV3poS2pCRFRjUEF1UHgw?=
 =?utf-8?B?TXJhdGZHVHlQQld2eXdka1dZNDNSTFl5algvNzlVdUEwS0FIVUw1ZDdueFUr?=
 =?utf-8?B?QUFZMlZsellZVWhCOVdydm5QRjJyR2VtYmExZ3FkRWczUDh1UjZWaldCQTFW?=
 =?utf-8?B?T3hocUt6WTRVSzVYM0RydjFmZkw0ejBRa25GQ1R4Qkp0cEkxZDE3RnFoWDIx?=
 =?utf-8?B?SllFemJjQVlDeWs0OGo0RFpoMVYzYUt3QXVLSzRtcmIyOFc4T29rSTVGMGow?=
 =?utf-8?B?VS82eTRhWlcvT1I5R1oySUliRlpKR3pyYTRMYmZUVzBRdzVzSlFGQ3RsY1Fk?=
 =?utf-8?B?cU4xdVp5dmpyQ0JrSmFQK1VrK3NZZVlHZHEyTTVtZ29vVUI3aUp6NjFCN2Jl?=
 =?utf-8?B?MEhOVWY4Y2J6dHlqV05lZDFuTWhkK21NNTYyZWJ0UXBMQzJoMkViSU5MaUd4?=
 =?utf-8?B?OFhnZmlGYUtWU1ZXSXVYN3JnRzRlQVl6amw1NmJBRk01YVFCTWFpOFNRdW9y?=
 =?utf-8?B?cmRPclhuMG5CTmJJdU1sRk9kU3pJNnJWcWRUQWlVRWJrUGQrZGMvU1gwVElo?=
 =?utf-8?B?cXk4REhLeVc5d0NpaS80L09XK0NZSkY0YnppeW03Q2pETzRaQ0dZbUFUbnF3?=
 =?utf-8?B?YVg5dkhhSWluelIxbGdSWlFTNCtpZDEwQk9QRHkxb28zZnQ3cWJlUys1a0dw?=
 =?utf-8?B?STV4a2Z4M1FYVWR6eG9IZWpZczd4UlRwbTFzTFZDYlR4cHNCMWdMNHlOOWUr?=
 =?utf-8?B?NzNUdUF0b1BqOGlVNkFSUUx3Q20rclprNnJuVE51dXdybHpMTU5XM3dQbWhM?=
 =?utf-8?B?ZmtHNzcyYk96cS9KM3BObkt5d1VYWU96eU5YRTMyVUFyVGFibVBLQnRFWGor?=
 =?utf-8?B?djI2RCtjQlNHdk44anN0c1VsQzlvS0M4OWs4b3ZCbC9vOVh5alRCNE1xNGhs?=
 =?utf-8?Q?tzQAQgNE/6m406tVUIVmwDfHreqvlmsG82sKI74=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:XC7zg8E1f5P52s0OMIffJYKcE1KtXKT8ib1/eEkyqwlA8yZTrCabvcglMvFo9Bd3oza2yQcn8Aca2UpbU1+uutJZ1kXoqUJsjYh1ZRae3aYPqUIh4FjFYRktNypPAuylN5CpcnFF0e/KQbMHTQ9ERNukcJgfLPzkeA/sr/c0Apwcq4B123t+8IzvDArAv1ScnwMXV1zCt3igj05D1urxMypX9Ag73WoLkqxNxmbIA1ai8UiYq3mP90M/U6AwziyV9zTJxgf5sfBAoN/fT+iCIBUbipNCcse+ZBJ+mn5CPyd42eRPtU5L5CBwWUTFaKjwM9yWzJos1nYSzIXZei2HldEcJ55YrhZigkmsm/vYEWQ=;5:X2/E+rdhdYNuyV9ziQkprIbhiu7dboiEX2OFvtXmHn7UJwEwxFg78K/0voCfEstYdyKJL6iHq9leYCdURaBjFoAFYbZpkTen0tb8t4VFZjOTBVKQPISQA8UlVfWRz8XRY0n7aJIkPRrYSe3rC5THhc2mnv+QL5DEfRKRKcbn5tk=;24:YXQOZtHcAQTALYP9+Bmaf+LlHDce686TI4iw6xi5EX7Wa7Q7MznqZWNe16uclcIDoehXkDirNKuuKeSqjUnOTX+hhqDdOAy76aEeTgaXPoY=;7:9glKnDPCoSJfKwwqatUb2zYtlFdlwzvPD/KAGlrlFI1kDw5Rsugqi0xCG+5nYsun6Jn3qnXUGHBPLd8Ng1pyxuMCB1hVYSe5NAxeh6prfsZK7ap2kUI7ubbBtl9Pn2oUhWjnEjEtJMg5gRK5X+Zi/j9aSh4mKJj44dlnFtg2NdoVGwUgz0r9TJ4OARk0umsOMViOParZc1cksdXp+7/dy8go+si/b5tP5ocqK23efXH3MmmrQu7yJLO6kB+AVCZV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:snzqFpmOuniwr8C8y++MQUNN5GWvQb1z8N8I8lU2m2xBYfJRA8o0IC3TX4Uc6OSy4jSKyj4QpABuVQaWjvVgvqt8kFyd15GoLmXZFnf2axG61aLVJIlE8vb72NtdzsXu0kV0UnW7OvC1TzDaweIb0+sC0h2i6YMFmHdfviN4VXU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2018 10:20:00.0012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 756d8ada-4a12-4731-5cce-08d56d4b2e3e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make update_memcg_params() to use generic kvfree_rcu()
helper and remove free_memcg_params() code.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/slab_common.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 10f127b2de7c..92d4a3a9471d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -190,14 +190,6 @@ static void destroy_memcg_params(struct kmem_cache *s)
 		kvfree(rcu_access_pointer(s->memcg_params.memcg_caches));
 }
 
-static void free_memcg_params(struct rcu_head *rcu)
-{
-	struct memcg_cache_array *old;
-
-	old = container_of(rcu, struct memcg_cache_array, rcu);
-	kvfree(old);
-}
-
 static int update_memcg_params(struct kmem_cache *s, int new_array_size)
 {
 	struct memcg_cache_array *old, *new;
@@ -215,7 +207,7 @@ static int update_memcg_params(struct kmem_cache *s, int new_array_size)
 
 	rcu_assign_pointer(s->memcg_params.memcg_caches, new);
 	if (old)
-		call_rcu(&old->rcu, free_memcg_params);
+		kvfree_rcu(old, rcu);
 	return 0;
 }
 
