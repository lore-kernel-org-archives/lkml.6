Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeEBPsD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:48:03 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49122 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751461AbeEBPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:47:59 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 RESEND 2/2] mm: ignore memory.min of abandoned memory cgroups
Date: Wed, 2 May 2018 16:47:10 +0100
Message-ID: <20180502154710.18737-2-guro@fb.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180502154710.18737-1-guro@fb.com>
References: <20180502154710.18737-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:200::1:767e]
X-ClientProxiedBy: HE1PR0101CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::23) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:90XG/aNs3LRYG7VJkGUziOzRqwfQl6LLBzQfXb9CquSZd7/iM3xLlFesPLnmnaz+eGDDkWKlRmhbeFkvB/os6RiCNKx9ciziN2BpT5srN46ITXTkSmawGQuNT0rUrD+iGvXufcDGXqq42eBJXKx8fl9FWI6l7Mw0CZ+ZuVUK6Kc7HGa2CENeqejRVTJZicyNxoZXkVPqtgYZDFBdVVNpITwrg7Zzg5U4pGp1Zzbe1NKdQMi5dA+ZA6YAJWl9enbU;25:2tyogXv+XUxqvO0eL+reKStXMHlRFA9kH8yYiujVXswNcUzy7TU/0VfbZ5WoDah3c0KWNt6pId5dhdEWOvbcTvAV2cyUgcbd62oHsJDrH33T8S4Xfts4SBzXpwXq/LvdbxzBTHtpfrnBeLQlfOHFUBxsr6dftLXywYsm4U9kZKNdLa3/qHAtPyaLRlglOLtGFKPWcU4pM7tPu1Q2T8TcOqiJvBwumuST9P6pYS3VFuIBIDEnGpL9h/Mb392r6iGQT9rSZHd8LroqZoqdQEtA0kDeqVx7SjLSAH38Zn0XzEc7YkTYIsxqn9Fv5evS3uqn5bLZtQoqZB6A6ST9Bj2Khg==;31:ctFsF9XF24v9IxCxbd/ijrZqLfZIHoYqL0nBVdz6L8hQd1rVwH7yj9ky9PEt1u1PDF2m1AhnzYrKcIm1MFzmNIAE269g+5WJKZksw5q6NgLkNekReJs7HgCsAF7Fln0gO86MP+Hka3aBF7U4PvRZPJF3qJ//3a4JPFqF3B8alDB1X3u2Brvf8CjbwCL0al9hpp0llqLJq5Whs6txBUddx8eNF0w5OzYMXYWfOhtosbM=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:rV0YvuFgx6EGmIruo4FHuOQF+2BhHYUcPwpWrYZMs/1p2k6iQxgYx61e+/XVqULrfxJubCWR+fAyFvZcbAEBEXuafF5ut9j/pVFJDkxCtXpqnL25p5emXgClMIDRzFGQPTmrdb3iEydnrElDgrgORZeg8xtEOzTam6eWFsp/mu9e+ZbZpcjYXZYYnyYjnetBUoq4NRhEmu0/K9Rh6ATemXRxI9W/zK+YQ8tAgz4r3niso3/e/3xgSDO47GxvqFWzYrUoxxGcSNzYMwLgG1yB2QRN1ioklyiu3AVaIk/ReYNvKsUhbX+cclxk28ORIK2wO3OprAWWNM0Z/ne0XOv7lnkwLqKa49ULmZ5uxIUj1ISd72i4eQ8Ko74f1X9rudt8dnwzFebcOcQCyUehbjGLVnPv4Wzh9S/mT16cREVklqhR+CztT53MX2l1O+LUWcO7QLPwM2Vbnf3BzWgFTSoxTQVVNzoQGkSN1wy/Sb7e1tu7BVyymeOtXLWXGFKDoAhD;4:JlUxpXLX1wJGgnjIQ1ZLDi89K0jvk2YnzpyREBgjvu8xi40sjCHPmTY0Fko+vN6TTF4HP2LS9xhGe4fRq/tKFp4vvt/IA1amcKwWzOZ7AIau7j+Oh3LrlYehovQBIPkGZBOdqeMgXFPsfNMSNwh63ZJ4bPVNVlY6aHFGeIds7XLOGYQ6uPx1DWBYbT/Od+8kLqMDOc0PhirVqKKbDVIWIlgufxSsaJ+QlADfCtD8KI9Skoms2Ku1pztgw5U9mpgqNDkj+mhIfpRZhz97n8mJwLk0/sntbpcwyKrrpmjWUjYhKsr8p3NtK8emDV2y4RZqhHW5pF+gGb31pD2AyDjIv4lq7t+i+Dmyt6/2hhHjhJ4=
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077F6BC1B4F9E8FFEAC6243BE800@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 06607E485E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(486006)(2361001)(7736002)(305945005)(47776003)(106356001)(6486002)(5660300001)(53416004)(8676002)(2906002)(2351001)(1076002)(6916009)(6666003)(81156014)(50226002)(6116002)(68736007)(81166006)(8936002)(446003)(386003)(6506007)(476003)(46003)(50466002)(54906003)(48376002)(2616005)(59450400001)(316002)(16586007)(105586002)(97736004)(6512007)(39060400002)(16526019)(4326008)(25786009)(36756003)(69596002)(76176011)(51416003)(478600001)(53936002)(52396003)(52116002)(11346002)(86362001)(186003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:Z7QKJ5IM3/vJC/1+3vO788GrRSSaLj1ZOUwbbBr9c?=
 =?us-ascii?Q?cCXeBRc03/9PZvef0t+pu92PxEdm8XbHI3cshjo0aCObeZf3+AAI5slYDYSI?=
 =?us-ascii?Q?LfIY6bpfD+iBZ0YJiHPjWqGFBgRRRpmsR/3OWWBm1tLxcvKD2avELDUmNgls?=
 =?us-ascii?Q?c31eIJkDTwt6T2GMqSkAbZ4vP9293AqLM8fcpaJ6I0R2hHtm2zKqoUd8A5Ue?=
 =?us-ascii?Q?PfKf0FfFeQCCM06/vm+IIDypOlRHbkGDuquxe6sRYVojpgTge6IsejEVx0RH?=
 =?us-ascii?Q?JF4RG+/6sZ3/QdT8iOleemIM+OlXLROdWBjOSNS13U9K3E06olYxU+27ULJY?=
 =?us-ascii?Q?6pbzBjXjveYteElELw3uz5Uy2rL6dqdf4w+3qr4GI9aE/vfPlAkaT7XGfl4N?=
 =?us-ascii?Q?6SPAW9aGpXJ0FQBtXdPCRt4o0t7sKK1gv/QwocjeAiCGVyZPluh+K7RhmVsR?=
 =?us-ascii?Q?FHQXoGflcbRKdouT7GflhtrHuwBQx4ZXbYcMn1Cs9+qtTLvEqcBs+6P3pCim?=
 =?us-ascii?Q?in6Zp0Dc0YW8S6R4Mcv1Yu1aFzoh/JXwOg2pOJ8pxW3F2ueILB+xmv1nV27I?=
 =?us-ascii?Q?tf9MP/nRb+DlWc7WcGFTwv+NqT9ztcXQc5uDDOsueQcGsZrzMT1d/uYrDmKW?=
 =?us-ascii?Q?zleYAYZQtuxKNcGFECHhOE1pO7Cwbpxv6C+OMxCypoLGzSyBj2wJlfBiUDvO?=
 =?us-ascii?Q?CoO3/6xs6VNWu0zPh7V6y+tOVd1hLm1/ERtwuvsLskAyPX+DeZVuD9TzvAhs?=
 =?us-ascii?Q?1KLrectr3pogx0QsY8WUH9KnlW0SAT/tytgCMzFPzzgNw+HtjZlQm14UhNsh?=
 =?us-ascii?Q?Y+83wnLwp9TRdVU15ZQ7moyVZlTDpteCPWZsm/rwAf7jrgLyeQIlzT/IXllJ?=
 =?us-ascii?Q?BAISN5w0MnK+mncF7AyYepLZ3YueUFiLlHdK66mLZMyW/T/wd7OsBmMb8+qZ?=
 =?us-ascii?Q?Rb4+7DeRavyTSd1HkNetlALiqi6MXLETMeTlTdAa5ORUxbFrfueX6N8I26Yj?=
 =?us-ascii?Q?+RkKrtP8cOb9v02c7+ynyF0UVDmNBTsyYg9QhcyGTl6nk8r0QkMHYOrMZxte?=
 =?us-ascii?Q?y3LumofWlUM9mf8CIcFljEBkuQReu5ZzSU13pHBIGbrxUdfoliGO5eGbkR6q?=
 =?us-ascii?Q?LN4pGRk0RBRtmGf8FXL5EDTijRdOZ44WGWvoPvwXrQ8mb0QW1Wlv8qFQQYFG?=
 =?us-ascii?Q?Wuh0HkzU/kosEca62AH9nq3rI1spkkd5HX9aWvRzjeBgIT2XOPu83+gMX0av?=
 =?us-ascii?Q?ZxY/aQLt9zfdPVacO/uqSkSDb7sVbftR0G0lwIyqJrml8KbmCRw6qfyXC3MX?=
 =?us-ascii?Q?6JScGZkNr8NMMyOWl+nQASUpsv6HZ8YyR08yCHRIqr6?=
X-Microsoft-Antispam-Message-Info: G1sL3TSaMhzBhXeHmag2ZIXmQej40fS2LCdn+XE+JZXPd3oBLEXk30dqAM0+sekOXFdUU5pwCV2a5O+VkV8Eam8rZop6VO2LU3ipIAVwIbUJQ9UE8KU95c88JT1twtE+vO2i4Zvfe60LV9pKQIlLCNnEJKqXtbReLeGDjndl/ny9k5nNT3ES6kaAyAwQWIVN
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:MkfloiJAOUyaTEi1wQR6FalCj4l0bzqCD3vZGrTcw/AfE05Qpblbo/jso4IXUv1CkAq9cYSC0NfNbnXPSNP4B8Z4PXjdySRrMSKbhVpoR/673Lk1cUMVccEvLymxoJUglt8fmnARoE/LQuH6mVU1/QSP4H6kPSteJeOdtl2ACk3UCZCxBGcGEOJEAiwuAtV3tbLqtkKOPwsWMVYsKgwCJWpR6hU2qA71mtgsFuV7/usi8T8tGC4H+FqA0KdWvgd7Y8HR4g/T8dL/YDH7IBYRogo74OTpKtQp6cRUHCzxqQMdIe3pB63Sx7/ZJd8uke8L+ULNPpYzHyx5CacgEBDJONKDEwD6byVspyLH+zpATYQNU+iaR7Hr+lm0tJbEbyICnLp0edtuW5x+f/NDITPLdBIqEmmVmALLcw4MW1mzsDmBl1prIxMD4J6iTGcFzX3DAKuXsB5pn+LS58rCEOR3Dw==;5:Wpz1lJbAnGpYt2/qJbMXX8MAB73M1yTCRTTdw7gQOeL0AZ9Jx0zcpem4AWzwq2jazqTcS5//hUT036TFTMjIqmrlCgiAoAEWg+mBx5gpBEqqBF4ipc4qdWxvn3HEy2VUkarN8cg6dTX0GdZbXErlult9yNUCJJSsoE4a1D80XqY=;24:JH8cpESdyjRY9MedlL3SiWoY2NAM3MQFRIYMS+LavmWcYea3bzdJ5XCktS06tpbQ4EzOWaIZEZb5CccQKxUIPRg6F0MwcCUQ90jn+JhmbJY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:+ufombtE2haC972QPluP814+msg6GnlksAUpt1epP/txFfk6dRaGp207P5cMe8Nmc1GpFGHFJ++Kqjsy1iYop6mX6ARMgCzpVX4mznimtdymT61WzHCSzW/emByZ/7OFhgl609MEy/9jogcDRuUHU+lJU8a3MUqlFkujbgBKzFXXif5E2aIQ4UPNsvrhcACG6aX1VVIGDnVsNb+CSQZPuH0mQSWgR7O7PwanNJad+6cq1CmZzavL/o91RnDC5XHJ;20:pyhteS2wtqmZJigps9+aLdwoKMPQBs0r3lEL6yj3Vulel+FDrkBjuTtuujtkv9MG8LGedbe/jvR90UGsOOWoOaeARqymbpgJWYSP4wSDj5x+AWzwzFxMEpWlMzGrwHno+IPRoyMerQE1GrDVYTDWyaHdJdT3JPdwWzmSy6Y4A5Y=
X-MS-Office365-Filtering-Correlation-Id: 53307a7d-877e-4d2f-126d-08d5b0440c23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2018 15:47:42.6462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53307a7d-877e-4d2f-126d-08d5b0440c23
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a cgroup has no associated tasks, invoking the OOM killer
won't help release any memory, so respecting the memory.min
can lead to an infinite OOM loop or system stall.

Let's ignore memory.min of unpopulated cgroups.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50055d72f294..709237feddc1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2549,8 +2549,11 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 				/*
 				 * Hard protection.
 				 * If there is no reclaimable memory, OOM.
+				 * Abandoned cgroups are loosing protection,
+				 * because OOM killer won't release any memory.
 				 */
-				continue;
+				if (cgroup_is_populated(memcg->css.cgroup))
+					continue;
 			case MEMCG_PROT_LOW:
 				/*
 				 * Soft protection.
-- 
2.14.3
