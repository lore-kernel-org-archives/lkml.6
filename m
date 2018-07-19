Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50C1C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EE220673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="e/hI/Wy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EE220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbeGSQsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:48:51 -0400
Received: from mail-eopbgr30131.outbound.protection.outlook.com ([40.107.3.131]:36654
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeGSQsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+SGadqdRjzyLXYv3c41QzAS+KqabPiKpgOMFXyw/RY=;
 b=e/hI/Wy0deq722wIS6Q5oqY6Cs8ykghg5mXssVyD1Aiw3BLv3kqlXCdYFZcrDVfllF96Wuc4Gjh5+U5UQt6m4zxgJyJK0PQqZMQBpsvAW2UfGbsu5SStD4hhAWl+WhgsqieKLvhociPfrRttQhmIpsmOBFyb6PeCGbJOUGZLHSo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 VI1PR0801MB2029.eurprd08.prod.outlook.com (2603:10a6:800:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 16:04:54 +0000
Subject: [PATCH] mm: Cleanup in do_shrink_slab()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, ktkhai@virtuozzo.com,
        vdavydov.dev@gmail.com, mhocko@suse.com,
        penguin-kernel@I-love.SAKURA.ne.jp, shakeelb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Jul 2018 19:04:51 +0300
Message-ID: <153201627722.12295.11034132843390627757.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P193CA0006.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::16) To VI1PR0801MB2029.eurprd08.prod.outlook.com
 (2603:10a6:800:8b::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4d65de5-57b9-4ca7-a8e3-08d5ed915e44
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB2029;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;3:pYOBe4EP1BEuJmlzOOfxwLCT4ON6xdZVHW6Fm4lVQ+YjqvLNCLyu47FZ4pXDMxk0bVmfPC2AP35CgQx6/saSQeETUoCWnw1V9iJhw6hQ6ImVXdGBLJONAhlNpoAR65N+yKpy0qWunFqpl+BlTsPkE7RRyrLNYxhL6H2aominSjUdc42D4Bg7SCCkRRWnkvvivz7cRhdC0HyHdPkOigm6FtaJUisAvhkbccg/ew6ixAcAs8SXdi5ndL0rIP6CumRD;25:4s4diQtKlibPfd+lrFeJ5KpC3KQkUZs05lSuscoj28mix62iCIgVivZ/vC3FNJaTyg8Wb/iR5Cq39/FAmTnv9Nwj2c8Y6wfe3K1dK1N3fM2E/J/xNdxXipW8z3RsuiD1nYJlo/17rWJl7/8waYI0MdLBPNxFcflpPIb62RWMQGYk1ZUH9fPDa+XbLQejc1HC1dJqWhUo8OyupgUWem/4ymaEciztC9BF+ETICRnEzBDfokjRok4M/oey5/n+fZoJDKzDYHBJBhVBmw/nBMxSQKHCXHUJrP6Pf+Byntet7qW07yOR8CPMwSGnFoux2Xps8Xd4eBbg9RN0PM+2Z89pog==;31:qTt1Bd6trERQqMWlIXk57PnXrjrBZ0aUPyRr51Y8I+3NLZE1KCyc6cSczu4dI+M2cPH4/OubRT82knAhnJ7uuX2hhoZJKs065E+8uIySEgLtHpo/c7TBUWDV1jbvopsDZIuhJ0sB7ovxfTxEQlFosAkGT5o68dDVI0ogxIJCP4UiYv63MxJf2JnKgLUE0PFXsWAjW2PwhuJwItgCya3d6Hg4LC4f0Vo2r3W2TcSA9eY=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB2029:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;20:Y0j4CH4y2S08YOp+iH+8ks2BrP8BzKJVrD7UMwJMx7Uk3Qaze8NVCbgq/pGpDRi7IvarwqCT72Z3VA+2Xujn0+5FcG5LZxuxCG2TBc6Xg8+row8dF2AMb9rrsPwaudPINsWaYC+f+TvDJ0vxQIe0DXtvaIf9I4WMl8lXxp4jfgUZ4fSxxQHx3UpMS9Ce7ho9CrorR3rz/TGmciENsPIWji54LMBMwr4uPpG/YGl0W4B2y+YolOnqTpFa/r68XQibcz1PCUOghgbM9XL1EXGZFzKAJSnnBuv2Std/Vl8/h79M7p/i91PM9MV2a7YQEPzO/Rx0KN8SX0Kmiki1zaXTDxXghDoPcHBjsBwqsEiJfNrnGEoHCpZoLgDxiDYi705gapVTNreGpmjVbdCv3bUzmEYNLxUUI3bhgVqLa7K1zlvP9bGjVZbZBZC/6m1XjyIKxBNccRg+iiB1/CMIFM89/uBgLUxGdFixNfr47VMJoXI6r7GHxhB64qnHLjvA+6/o;4:m2QVi1FHhfEHaUUhOmUb3EJcKaZMV7huYb1a8nvKa75fvEY18+BszuZeapqb60BJDkz6zM3ziOP6Ek6EmOZpdg8TSwxXtey6KblUVQ7qv0svc0JjWlgQ4gSC7uyZ7lMRe4tylMMu1+HUrZX6b8aIWESnJO8ndKu+fZ0Bp7Dr86HVb2T9rQGFegrZopepkuhjFw8GzAaYhezdgpRbtvXmbA9pjL78bUKtJPtBJxLSU2SwrVDOU0CVhQN3q9eIlMgPdsfEDT34s17lxFO6NmaxRg==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB20290F38FF1F8C42A3F3952DCD520@VI1PR0801MB2029.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB2029;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB2029;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(366004)(39850400004)(136003)(376002)(346002)(199004)(189003)(105586002)(106356001)(33896004)(53936002)(25786009)(23676004)(6506007)(386003)(2486003)(52116002)(7696005)(97736004)(39060400002)(3846002)(50466002)(6116002)(230700001)(103116003)(55016002)(58126008)(2906002)(9686003)(66066001)(6666003)(8936002)(316002)(478600001)(956004)(26005)(86362001)(16526019)(1857600001)(476003)(81166006)(81156014)(8676002)(186003)(47776003)(61506002)(486006)(305945005)(7736002)(68736007)(5660300001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB2029;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjIwMjk7MjM6U3ZaZUFVZW45bzJMNWQ5ZCtBbnpUZnpY?=
 =?utf-8?B?N0RvWWlOdjJiakJQb2Q3cHNHTm4rR2lTN2ZLa204d3hzNzNoM0R0YkMxQzE0?=
 =?utf-8?B?VGJ5NVE1WG5LMjRLVG54bXlPMnlEU1Vmc3YxRE1VTVVRa0dDNTkvOUZ3TmFO?=
 =?utf-8?B?RjBMeFVRNGhIeUVnUVF1NXJUbCtIS0owRXlUVHR1TWpXN2NjRllJTTFlZzRP?=
 =?utf-8?B?QisyKzRjenNyMkdKWGtVdFAzaVpyS1FsTXpOZEhQSDkrRVYxVmJxanMrYWp6?=
 =?utf-8?B?MDc1YWlrb0pWZ2tPYk4yN3Ayd3g0OUdSZDFKeVpOOWlzUkRuc3BjTWJKUk1Q?=
 =?utf-8?B?WDdXVTlYcVVmWnBlY2tPRUhucEtPZ2hjMTFZeHc5RUFsQmxKNkM2UExxVUVT?=
 =?utf-8?B?NE40Wm90UkJxOWtneTFhaHMySVQrQ1I2RXMxcktMcFNuTm5EN0NJRjM5c3FV?=
 =?utf-8?B?WEIySTRsMjBmTUxFbE9VMmpZRThrNFZZZzI1bER3bmZIT1B0ZExjOVRySENw?=
 =?utf-8?B?dE11dk0zcUhJODFDZ0M3alNBY0hvYysvWXlYV0hkd2hYNkozcXl6RWJDYTd6?=
 =?utf-8?B?OGFvVm42VGx5VVZtV0xzenpSNkcxL0NsY1NKTmtiOUZFOFFCK3ZzZnVpTnJB?=
 =?utf-8?B?djAraDdsR1hvUmZEKzdQRE1rb1ZVbjJJcHVpNEliQjIrRklSaTliRWVJNHVy?=
 =?utf-8?B?S1ZoVTI1NXJYUjFCTU1zT1BZL0NjdWI4YkZTb2dUZlVXSFNtSzhXRURvaEZr?=
 =?utf-8?B?c29qc1NkSGdHc1dLUEI2R1NsQ3FEOFFKMnBIUlBwaGZWWFN0SXhqcktpblYv?=
 =?utf-8?B?cHhuQklRQlN1cGQrVkI2c3RqWUd3UUtLSW8yMzVYSm9GRXplZlZta0dwajBI?=
 =?utf-8?B?bFBrSk9wVG8zQ1pOMWg2NCt3bFZUejhFQjdTY3BJMTJWUHFNaWltZFRicS90?=
 =?utf-8?B?OHBySEU2T0xYbVVCYVRWUTNqRG9FM05ycjVoSWpyQndzZkxUWlRuN0U2Z09a?=
 =?utf-8?B?bkJDeURGdHo1UkNIZEdqS0VwRkNUek1ub0h5aWhNMzJhZGtQYkkyUDh2MnJT?=
 =?utf-8?B?dmZpSDhvN0xia3lRYStPWTdVbG5vang1Wk1mTmc3ZnBBR0JTdDY2S2NjclJH?=
 =?utf-8?B?WEVvWWYzR1RIRU9HUmxzUEZEeHZmR2NWYnk5bHh2TW9lb08xdFNBTHFLWGFT?=
 =?utf-8?B?M1RKVHBkaVJlVysraTNaTFU3eXErQWJFTzlWTWZrMzAwWVhURzRVZVBTSWRW?=
 =?utf-8?B?OEdVaHB2bkhqTWN3L2EvR01FSzdTVGZEOE5YVDhCc1NKb2JTdkhZdVhWc3VB?=
 =?utf-8?B?b2RWcERDUjB2bk5ab0s4VldhS3pSb05VUzlzdmNTemhqVFJFdlU4QTdLNkVo?=
 =?utf-8?B?V2tuZU96S00vekRIcXhoZFVIMVl4RloyUkY4dzFXTVhseTFRSjlGL2RENXB5?=
 =?utf-8?B?Tk9ZRXFzSklRY2g1RGxXSkFNdXVoVFBkSWVPTVAzWkNNeWdPZ2pxM1ZKZzVq?=
 =?utf-8?B?UUEwUmJrclI3WUZjNjk5T3FvTldYekFKOHZGL0UyeS81N3lCNnpBSURuMy9P?=
 =?utf-8?B?Wk1BejRQM25JTU1DRFJEWnQ2endnVkFIR3l5VkI0OVN6bjlucy8vVzVvSUd4?=
 =?utf-8?Q?FVAlYiLoiRD/kuzbkYnAai?=
X-Microsoft-Antispam-Message-Info: Rncmr8vhkq89Mh3VwrCKdJFaVnZXRuwx5X5LGe3F9tXBo7LSw4Xo15KwnJQKk4df5cG4U2QyV8WAUlxflaDWxFv3BwLbgt3mN3EDYJaXE5d6JRply7G152POfWa4QeqYG9YXK78iu9DKGRTRMqjG5+w7aS8CtvLI/2pzJEbrW9NPbls/NuyAJCsGFw3RTlfgaC+pLTuPm5h3l06HVvJqUmbEcQzsxf6VxymKnoD8t2pgWZmYyyLbaFwBQ7GnKTbfRGeEv2/E8mFF691T02Aek6UMsM4h2Nz/9okumzgZ8sW3JsUZE/YlipEYbJGJbx/tBsxzO35y7nq9Y5cRwlOt3Hi8rhLCzJAF++2MWbGfmVk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;6:rXNZ+S0Qgyinf/vv6asGoFGER9aOJFLeYHcc0ZzffsBqRzp34XltY4xUIgFw8RnL0gPvzJl0sdyhhVV2qVuCfcBnt8v7fqfzAum1cdIZELPo4DxiPfJluQ4KalKU+dRg7UUGWxlESVJblyG3/2jenAOX5hmAdM6J9o9UYeOCVFFJz3/YAnt80eVIiV2nB8etdKK/R+lsGvyWzqepdx6pJe3v2noqaI19bZYZxPPTkD/OMsjwO+46CU/nOsLgpPXcWgBUstbcL3iJfnUS0hRiu7SvSIx80sBJYmbnzJeOP1RXhcdsPXjlRzteEzkgdEozwxG8BFxGNTP1R8GIuj1OQNgIJg9Dr3CL0eUBpTIIgaBnZg8GFUUspOEmJcQ1TM8oEMYVCQKMsyNriy1ssAEIm6p3r2LgKJ1LEZf+klSHMrT148/gMXcpb4uxJ1MzeFYKKcLlnosieqyxOzxNv8+Hbg==;5:QjUTpKUIDWyr7QQ8Zq3AtQ9QpKDmGaNw+5YWcuHJx5a58hU/v0rNSKxNFbr4SM5tP9kmQgR2Zsi4X7bUzxVg2bnNoS3tISrmaICCMkwCQlGU9BM1vPy/jN7tkv5oX0AONyxfa9HzEgzdeaHL3FeFGLw4M8aBk8o29KNBxxM8XVI=;7:ZnV9ed+msKskWwKMElu904J7eaapMulkoXqHD5iXCO4nphUNm0KwyBqZC9y/IIoLbbt4ozZfRiSHzn7vhlXz1d/jeaSBalAEuMGqx/4b353gMKOqR6fmMAxjd0nIrmAeWJVm4G4Y1p7LuU9AnIh2dk2WYzkwgXBUyqK6ie2y1trz8rP9GlNwpge/XqonWwvOql239hgIxL7O+8FUpBKTxOCI6YTbDZ5m3GY9qiwQ7eOlQo3p1IV6wuWRjeKVWgr+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB2029;20:V4aw879VD16arvujTQYgQtFRihg6NVgqw2RdGctqNJWJAPwBpEy8q6dx1N8rVEcDEq5BUBw3xXQHp33j+w3E2KHiV0ajJWYnBUR9JBjPEZJZoi9U3VmOEEqv1Z8j55zMzyQ2of9IfLWme+knqHTHcH+8VMNGxdWkzAG0CTccJEU=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 16:04:54.4547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d65de5-57b9-4ca7-a8e3-08d5ed915e44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group long variables together to minimize number of occupied lines
and place all definitions in back Christmas tree order. Also,
simplify expression around batch_size: use all power of C language!

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9918bfc1d2f9..636657213b9b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -445,16 +445,11 @@ EXPORT_SYMBOL(unregister_shrinker);
 static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 				    struct shrinker *shrinker, int priority)
 {
-	unsigned long freed = 0;
+	long total_scan, freeable, nr, new_nr, next_deferred, scanned = 0;
+	long batch_size = shrinker->batch ? : SHRINK_BATCH;
 	unsigned long long delta;
-	long total_scan;
-	long freeable;
-	long nr;
-	long new_nr;
 	int nid = shrinkctl->nid;
-	long batch_size = shrinker->batch ? shrinker->batch
-					  : SHRINK_BATCH;
-	long scanned = 0, next_deferred;
+	unsigned long freed = 0;
 
 	freeable = shrinker->count_objects(shrinker, shrinkctl);
 	if (freeable == 0 || freeable == SHRINK_EMPTY)

