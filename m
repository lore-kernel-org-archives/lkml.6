Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeEVKIc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:08:32 -0400
Received: from mail-ve1eur01on0095.outbound.protection.outlook.com ([104.47.1.95]:38048
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750733AbeEVKIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:08:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v7 06/17] mm: Refactoring in workingset_init()
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
Date: Tue, 22 May 2018 13:08:15 +0300
Message-ID: <152698369501.3393.6857643130952291774.stgit@localhost.localdomain>
In-Reply-To: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM6PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::14) To HE1PR0801MB1338.eurprd08.prod.outlook.com
 (2603:10a6:3:39::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1338;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;3:CjieLITjX1Ppqs82j6XTA63mdC4ZKEQTBFosZwz26sE7FiMvu1WKT4aSv5JlVGlhzp58Ev7bxCiZee9dQ95z+o3e5SOSs5WlurdUugVzWp6+9T6FAdWyWpNGJEW7vmsDlaoC4YnGM0ZbynPeHyPtYrggx5w9jB3hUHt7mrVru1IxsTKI3y6q0aOP9S+Uq5UWu8yJZdZOZdFz4xGPFVxWpyLJ37TWgTnUGJjb1l2UUtYmzWfowMWrx+1w/DobC47i;25:aFD3aoY+2FRHDe2qCAENMGFMu7FEq0xb2pjx8o3KwcYgJyAuJqDiTEc24ITpk9ccAyRV32Wbow5bxzS0o52IXWSuuo48c2SeArecEReoMGrWeJP9HI85cH3OfCkRgWji++fowvFakM0TvEs8wm/tq+yks/0pJ5Olw1p/ScFuubQI2FyEhIMRVou2Covsx41wVEw5Kp4PvDbqDmCrU5JcNQrb+iCZ4eYIOicCICjug51oR1y2FqiLYPjySVIRvJkGXXzB0Eb9kZn01ekfVfo9SOOqZaNfvh6emWzWB7pU0Ep5tQc96h3E72fVnl4VjWFDzJAnapCET85PQflsVljsZg==;31:0V/Z+/Nfymg+1Et6mhz5afC6312NF3RLOQZsSNaPq88d3DsW13RZWxVQGHVrMgH2+Z7YMMgASr/ReJlNmDXS6hmBtgzsaDnSYAEZKC8GawUBwFo5xzHlFcOX/sMvUWwSSFX+MIOjBPsPYFvHNEoDwDi7z8rQO3ZyiHjVpnMmDZkagCxheWpORm7xKyDBGRn7XhbCMoVClzSkGRZ3zNMYShDhCv6N3CGLfzUXRn9of2M=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1338:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;20:tHMQiFvv0hrSdEUijAgPRSYLMDx0H74Q4IlhvxvU16OLUEiVdEpVZo21msJKeqLQPqVarM0Y7Xi2RC4ePjbAlzxqZaMk4tfAXFsESjlmr+bYFynSXVqVR0ovRgtmHnfaEQbKTIp8KZKL/xfF77iv7pPiXPpzrzc3tZzH3UgPJSPzPSlEiDaB9/Djema5sRPJbAkHOAytiZcgC9tUDYbU6Iv6vomUI4rF8Zj/3v1CtbGRbRiyDLimqcgM39GZBH6R2ToCksUb1ltExttj1UJVeHlZvqCt1obDbdO0iGwbnS93TN4R3RTr5MeI1joI6TAMIEuogaOyr/1cH5S/DAT62zlS03SQnENY8Zpz0t4lv8UzqmO7SarsuO4PAU3+48uzo/gB5MR+pWOhUnGUZhQRPZ16ysynj98mTBQ8KQcQlBptrN0nKEPKLPIKJgnYby4G7prekqY8RcVGQcx+ImTpR2Hx5fFsPMF9nZ41KmONm5jxxje2iYduHQ4anE9cIyy5;4:NQCYA1bMDaeb1aGjfo0e1MIxhWmwXBvNNo9Dd6+zsCfB5U07vxcJ0laFgcPEcvqTneHI296F3XDesJWechXoaoFMkvb75I5nNQNEkXkHHhicx1mBMhYfnmJGGCYzlcrqegY3jdsSnE0PRePHyKf0M8ecQGnkrBsVzp9Y+NsEtWogCGuv5G30PWKdQhOoMF/Mqdl3Z8cNtMMdW8+/Pfvx8VO06ftpCBCtKcrs6MYueyJSaIWA8MmM0fRY4eeOP5CKbV0w7SbYO3gD8K41xeYd0A==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB13381D181178286141BDA167CD940@HE1PR0801MB1338.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:HE1PR0801MB1338;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1338;
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(376002)(39850400004)(396003)(366004)(346002)(39380400002)(189003)(199004)(50466002)(105586002)(6116002)(3846002)(81156014)(81166006)(106356001)(68736007)(25786009)(305945005)(6636002)(486006)(8676002)(956004)(476003)(7696005)(23676004)(11346002)(52116002)(86362001)(2486003)(446003)(39060400002)(76176011)(9686003)(5660300001)(7736002)(53936002)(103116003)(97736004)(316002)(2906002)(58126008)(33896004)(61506002)(55236004)(7416002)(6506007)(386003)(8936002)(47776003)(478600001)(66066001)(26005)(230700001)(16526019)(55016002)(59450400001)(186003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1338;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzg7MjM6OEtrd3AyZFp4L2JtWWRJWEc0cFZJWEJt?=
 =?utf-8?B?ekt4dkd0VkRERFJWZTNHSTN4RVhsVmFyTWw1RGg2azIycmI2M2JOTGc0TXA4?=
 =?utf-8?B?T3J5RnA0aSsrUnBBVVdEckE2TE1hbENQMmU5bHM5d2owQ0p4Mzh5VVhWRW5F?=
 =?utf-8?B?b2p2SVoyS2Nla2FDdWhzeEZuamVnYnRBMXhXZXJFS3liL2JmOE5pSnRDaXR4?=
 =?utf-8?B?NkNYTlBva2thNlVGMkNYaHNjbmxSMmJNUUtaK1VrZm1rNEhpL2I3NzdoM1lD?=
 =?utf-8?B?a1RBWFhsOEZZdGtBNnU1UVUyV1R3aHQ0cjhFcmw3S2VhbFRXbFIxNVlmTnUy?=
 =?utf-8?B?bkpFQ1hjRkxSNlltOEhGNWp0TDJOWGhoVVJIZUNxUE5LellyWkJwMFZ0SVlJ?=
 =?utf-8?B?ejNhYTg1L1g1RTZ2WllhZXhCb0JzQUVQZ2pMSnFHemNFZmNGWnZyS0lRTG5S?=
 =?utf-8?B?ZVo1NnQxelpyYnNWQ3NtODNVeEZWbU93K2orcVU0bWZCbm13aFFoWnpab2sv?=
 =?utf-8?B?cU9DajN4RDRic3JaYko4R05Fa0E2NEZNM1hUaythQU9TNzhlQlNYVFp3Ykk1?=
 =?utf-8?B?T0JKNkMyMVZNQ2xqTE9GMmI3c1lTVHM2QjA4NU1Hck1Jbktnb2ZMR2gxalB1?=
 =?utf-8?B?RVdvcHVDUmlObTlVMzYzUXl6ek9odm9QS3UvT1N3dDEwUlZHSG9yQnYrV0Fq?=
 =?utf-8?B?bEVmdGdDYTBvODF5R3BtanlHL1ROK0lVSzRaVnNjWXludWJHTlczM0lxajN0?=
 =?utf-8?B?ZDQ0bk5vWWN6aWhPNEVuVEtDeXh6MUtqTjBiR2NJMHgycXNvZjNIQ1M4TWlF?=
 =?utf-8?B?YlJSRDdiOU1LUUFDNTJTVkVoRlcyMERPZ1BlV0dTL1BydHZCeDlOdXFsNlcr?=
 =?utf-8?B?cE1iSU1heWtob2dDTEF0blRPNUtzL1hDZ3V5ejlDVnl1UGF4MVZFYVl0TmVQ?=
 =?utf-8?B?bW5FaEU0eTQySkZLU0xtS3VPOEVpZVdCZjNFTFBYV3VhYlB0TnJROXhSNzFD?=
 =?utf-8?B?b1RkaFdkQ2s4TEIxeUZ0cHZLd3Z0Zzl5MUtEV1V1Y0cxaUowM0xlU0xXV25L?=
 =?utf-8?B?QTFmZ1Fwa29nLzVkUnkvYU55ck5uTFJnVnR6Q0dXNU9kR2tYRjVpZ2t0Mkw0?=
 =?utf-8?B?WllkS29IaFpPOTJIQVdSaEFMVzYvNStHc3QzSGV5NHF0UUJvQzJDNk1sNXRS?=
 =?utf-8?B?MU55RW04dXJYWG1zL0RNK1RFYnp0dVBnL0NZWXA4Z1lDVHBLanNaRXJxWW5o?=
 =?utf-8?B?WHZpTTI0dGh2ekVDSEtqVE0rb1dheVprVWpqMkkvRFc4NHJWTFp1ZWhrME5Y?=
 =?utf-8?B?T2hSSUM4WjJNTmtqZ3grUE1IY3VYSWcrdWNuUEdSZDVDdXJ6b2loSGZEVWZl?=
 =?utf-8?B?M0JmSzMwTlB6M0hlSEtERkxUT0czdVdXcTVOWjRaSTlSdE51U2ZKVVFULzNq?=
 =?utf-8?B?ek9RQ3d2K3dnYXQ3RVUzbWdzczZBVEJ1VHJoWFIraUVOWlJ5ZDBWNksreGxt?=
 =?utf-8?B?WTUwWDZLdFNDQlB3Ly8vNndJZitxeFpWRmFPT2lnS3NaWFluWVdsTFE3RnBq?=
 =?utf-8?B?eDVmcldtSWNlWnFzMmpqNnAwUWdZK2tXUDhHNVVGQ0k3WVZMRUN0SGNyU0hJ?=
 =?utf-8?B?SmhkaSs3T0FlK0d1K2xGS1Q3UkRJQlUvSEZ3SnpxUWhWV0dRWjJNUlEvQ1Rn?=
 =?utf-8?B?ZVV4NEpFdlVZN0cxNFBHblhpV3p5blRFVVNtOGZtTjVvNVE2VkljNnExZUxR?=
 =?utf-8?B?dUl1UHRrT2p0ZVlxYzNyYVJ1SVU4RDZZRDNQNGl0Wm1yb2RFS25UVmk1Rmlm?=
 =?utf-8?Q?rNWhMZ4zpnvfg4Y?=
X-Microsoft-Antispam-Message-Info: UDq7dwsJcneIHp0oO+QXejMTVC6LM04+O69m87e/Qz8XS88PA8pI70rO15ZFLxgCzml+E9pgcw9KR5ejnlIh5duv1S2/Iu5XOiQS99ZRWFrALKvy3z1uzo7jvFo+8tDn153r9srAeUHcp2yz4IhWU9I4cyIrxbOOiEoK2V/Hn4nzSyAfefDCGkORBQqJVTij
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;6:NOWDno+Hyy7sYqeH8gQFSu5wWbS6zmgRVpn5BNgLOuEY8n0Ohplb3ifRxkR1dqxKE27gntNBgXgHj868+g9H67UkqspGNS5E+5RKE4Bl/qvoNnSAIWtOHfGkPK5P/bjgwkC0D4qno20JX7rtChlH318diMj3d3VR1NeGIIc+5eCpTuElb136QJKCYm4hKbphelkeUTz16hIqsd+NTahsSAWiy1nt5aZPvdhGhtejfn7MXCPth5XGMI9gfTWbZx12lg/swBAcpLsikefxeajqtqT4J8d9xdbZaMH0zSp4ILppW1vUeLmAjI4dDdtTFpRkRfbKGnMvq90vQJwF+5iiQXvHGIm0X0s/hrwCmmaKb4LESHJqf4oR4YR/9pARQ+XssyOoctZdKo0qJq86LUAF64d8rKy3cTpZCog2CB0/p7duuyc2tKi3wc5YUdq5IocoMSKuDV5xKIL6hZWhfXIAZQ==;5:xVWDJAcywtwLI7m7IXSjvKT/vpVA60aQbekn2OkGNuRcm1pgBNjxbthe5tcU1Q7RuYzrwr2GcJb++Ha/s3cF2uGeL1fJ1aX0JdgSN0KO3BLd84mds9OYqfcdRHdCBlBuPaa/95qFmNRXA8R7RbDQeiGkLlGrXxGas0sVc+CR/f8=;24:TEosPPsVlyn5OZMYKGkOcpK7XXkhVIQyod8y/ibJMnfaUFH7LK1OuUvPCTIbLIo0/LJ9Elr4irYP6WGcczhHi3U7VPava0S26Jm/JqxdZGQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1338;7:Guua9L2hjBQeDhZJEjZkFdGWRo5LQtPXMa///TWnYF5ZWlhLsC6ww41gYCmuKaZS9uOrI+e6S0zQpZKbSH17MuPj8AU6io3WIk+sABseUAfHslcPk+ixSPN9omNLd6RwnxrqNgAFcisGr0ECeYwqetsDjEzAlp2loV1kW+1UJKIkkuTUhlzcNSJ/2Autf2HW8e0CzK2LUssFonLjJJrRpmuL/kR0S7WIpTomePtN00JsF2r4u28qx9PHQ+9n3LVu;20:HEoGRIRGbzw0yi4vTR1EvR+SMiBxwqTCALJTGl2uClhHG1NEtyYo7qMf6xqVyKXnGpiTLpZ5kwSA31RQVUfYsEBbiYuCh05xLgZmPcb3IJuiVTwsmECWD+/H/89K7/8zb6jA2sLtBcMfhmOvrMUzEdyQfHp8+MPXGKrKeuAXY8o=
X-MS-Office365-Filtering-Correlation-Id: b6ba3227-2d5f-43af-6467-08d5bfcbf1a8
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 10:08:17.4997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ba3227-2d5f-43af-6467-08d5bfcbf1a8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1338
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use prealloc_shrinker()/register_shrinker_prepared()
instead of register_shrinker(). This will be used
in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/workingset.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 40ee02c83978..c3a4fe145bb7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -528,15 +528,16 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
+	ret = prealloc_shrinker(&workingset_shadow_shrinker);
 	if (ret)
 		goto err;
-	ret = register_shrinker(&workingset_shadow_shrinker);
+	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key);
 	if (ret)
 		goto err_list_lru;
+	register_shrinker_prepared(&workingset_shadow_shrinker);
 	return 0;
 err_list_lru:
-	list_lru_destroy(&shadow_nodes);
+	free_prealloced_shrinker(&workingset_shadow_shrinker);
 err:
 	return ret;
 }
