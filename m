Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeBARZn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 12:25:43 -0500
Received: from mail-by2nam01on0056.outbound.protection.outlook.com ([104.47.34.56]:29504
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752439AbeBARZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 12:25:39 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf: arm_dsu_pmu: convert to bitmap_from_arr32
Date: Thu,  1 Feb 2018 20:25:07 +0300
Message-Id: <20180201172508.5739-2-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180201172508.5739-1-ynorov@caviumnetworks.com>
References: <20180201172508.5739-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [42.107.64.135]
X-ClientProxiedBy: DB6PR0402CA0024.eurprd04.prod.outlook.com (10.172.243.162)
 To MWHPR07MB2911.namprd07.prod.outlook.com (10.169.231.135)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb93a4ce-3133-4f8d-2f6d-08d56998cea2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR07MB2911;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2911;3:3VBURN4zwQjqGXsw7Jkwruh+CJk4cntAei0SSnxs2chY09LhYqQ7tLUcA0GrZ4SRn1bqh0bm3uDBOCrONz7rkXwb1jsB3ScPgChMnM+L+KkmSJqi0xH586USl/QUzxKVaDlqpd4J70VKPMXQ4sini8kj/OzJwk6WNEqoNXck3yt6nJJIE/1kPSeBJdJCQ1aAijWSdWdVDaVCIH6+89djROU2GTEaDqbGQUaLZ+NcG9II9sUay7F5rNtqkLBksVw2;25:hWsfIGExLU6zRCQ8U10722xCOCyVP4UGlG0lP2paEA5BVOooTyUzCegwlokkQSLHsoWbObmyd6Gr6f5SpZaeRbvJupng8w9Xx/OYLQC5/6/SonbN2CkouUpqN/a6J8YVcKAr6TkMT7NBWEpJthGsntcrFVHIsm4P6x2J91pDgbDPUDheZYj5gVt6e0LHkypraUKZJOgCq141VQqoaOSd6Lp+jvsP6Wz0xfRNlMZKJU6ibRIQCss4O5HEIIuGWENSRonBl6By9FpfO7v7bxAuGd8cj8SWZwBb3m3xYqdz4l/zlHdAbp+4a5mWNknnZNI69rfgZu3ovVgVXPpbWz7YsA==;31:73EAsIqaatvqgTVabyiV/oRZC3ezaerDQSy4s8t4CKRS/ll5cROpI6Uw2vzV+re/WfnsyiMZjddO8ucooMyRH3L+6dppWLpznYeHaXJLNOWC0TZiGlU1AC2jpAodOVgabl/OQjP82bJalnfXAxYgGEzSSdZAObkmyyZm2GJAcd9zsEy/JsOcy5T7L6Z63zWkiaeVPP8pmhCebILX36E8nr2snF2PFG9RMCiz7egSVsg=
X-MS-TrafficTypeDiagnostic: MWHPR07MB2911:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2911;20:TrDj/VB+8E7fntG+rhkuhehLh/1pZYTWek5TVxERD0sSKvbxzptBPNHmLJ9RsDTWZrMgctKgr/Y7yBHqi6YN6CMKR9X+xddoScmztxLbcTYonNEQYtOnGNMN8Y09ZX5LxirrHDcYHjgM3jf4cMa3cGu/ZRw2+Xpzv89VbfUeC+T119th5qS/gAGXtUQiVO29t9ouXE22H6SRYSgvVK9uRqjj/tE7PMlVfChYRiE8Xnl+3H/rMboVP0gawXgFlSKBrx3ybUq75AhozRS21S1pa+llH3Y37jdNmTVxPFF5+60SIWoubYiTP/fWkM57+PdEKO6BM38ttOEzKxsRpjvNjTuawAepXLeMPbj8IrNFncV0EN+uZ9SD9FthuRvI9WepvNB4KBEqSauiGlkrI4RHY7mhnjN7wZke4ATEN7hkLXwBuKrEUuac3xa8/tnTQuq/z7W3Qfq6e+qwZYLhpFbyr6OBoAecY5+KLDlmWB76u4y6BYuwlwAP+oeLdYplWIxrGdOynZsdm247NVLtSFZt+vFu23BysrI7dtiSJQ81HiNaUIv9bZQDeyL14W6Z7ThOF7IQFeWkV/CCq99VMUH+IOtJ/Ukf5maQBtznlJpciWI=;4:eQWIenzMmg9N8DAZGQQn77qDQNa5f2dV5PobGlCfRDWa1p6CJrnLGlyH19OSESHIQYY0SRQFAwttRxLSN6n5stJlZQdeGphGIB2uxLRjWIdM4VA6+zfYVj87Jx9X5i8AN04t5bW3NUbT5LHoQ3Me7yRHbbFM5y+/zBAOZkw6U76XZuP/PRT7kZ7zQORa2WFPh4iXZ25bjPN1/uoUFmiIM3B9FaMr7r0WTPFN2sX1EfLsfrXmp2cIsU84yjzMJgg0fIwrGW4iBCir6rigcA+nbm5EwJjKxaqEZ82tLUz3bsG6XDqbq+HIZ7FGY5MJeGY1
X-Microsoft-Antispam-PRVS: <MWHPR07MB2911239EB93AAE4266D38F6DE3FA0@MWHPR07MB2911.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(3231101)(2400082)(944501161)(6041288)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR07MB2911;BCL:0;PCL:0;RULEID:;SRVR:MWHPR07MB2911;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(366004)(396003)(346002)(39860400002)(376002)(199004)(189003)(6486002)(15760500003)(47776003)(105586002)(6666003)(81166006)(2950100002)(42882006)(52116002)(8936002)(106356001)(50226002)(1076002)(6496006)(48376002)(81156014)(5660300001)(25786009)(66066001)(4326008)(478600001)(72206003)(8676002)(76176011)(26005)(316002)(16586007)(36756003)(51416003)(76506005)(54906003)(16526019)(305945005)(7736002)(110136005)(186003)(386003)(6116002)(50466002)(53936002)(97736004)(3846002)(59450400001)(68736007)(5009440100003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB2911;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB2911;23:cDlE7k9RLWK7E3ul+V+SWrcQMypohnZee57kKI/ET?=
 =?us-ascii?Q?Kqp8p53rG26cVh6zk+sXPhBoXSAthT9vfZG1+iikpYHAk4DqLw1bPd8CT0H0?=
 =?us-ascii?Q?WVIwRlo490x/Dp4osRdju+/w4Lq+ER9a7RmrwKBhPH7O33a90lr03KAo7QCG?=
 =?us-ascii?Q?SB8IU+O1BBl5Z03xH8pqQBC4tCm3tFHbgoyXnVzqJsLCh+O1nB0DpB9DpVWm?=
 =?us-ascii?Q?gf2D0WHLGS+eQCVH/uzNAqpDWtr9ilJp8jmFnBeMZVg6Cz5N/bYLm+LbODYd?=
 =?us-ascii?Q?c/O1fNJ1shsyLE1JNoka0FD/6PLmn1QIa8N7+M3TSM4JhGJOorajpohXr0TY?=
 =?us-ascii?Q?jsZ0SMRCIElVrOxoBokrd7dBaqVkxl16d7gaKYrLR6tN8cR5pdJTAXyOkWM4?=
 =?us-ascii?Q?fUTslg/Sbbrkmd3kEpKOt/+mMAcbl5qP42qw3e0kkFhsByuZC/95RX9ofvnH?=
 =?us-ascii?Q?9lNJwfQsmaXkbdDrt6+XjxF78Bxt94IreP2Snmzxc9TJjFOSGkf6AkeRuSQQ?=
 =?us-ascii?Q?CRI84x7n19jBFbySUdPt4V02spUTQvZbgn2uSG+bw7HcvF/NffKAa6g8yRZE?=
 =?us-ascii?Q?TDg4jmc9RkFivwlbnpXO+3faNISteSMbRqMs3k5ULNh5fx2IMnbk/jB3bMVA?=
 =?us-ascii?Q?XUTRmxwEQKBvVVLdmVyvGL2133Y650+au4SrJBscrmOiThnHvjQ/CqkCfOcG?=
 =?us-ascii?Q?W2cHROI1qWVYXBf1V+crdhRD0l5gBIUc1o7eAaxnOIdnWjvcWsg14OOEOhfo?=
 =?us-ascii?Q?G/KoUGqWsd/MhsW8Z6KmqOO51bLhFMgqObGLS6ehttnK8hSMqFb1DW6gIboh?=
 =?us-ascii?Q?u/N7vW+hMcBJH/vpbWipPpK5YiPoksr2PBbg17zeezhb++xcZyVuNaYlD+iU?=
 =?us-ascii?Q?mg4RhZ6l/q37Ux+KdZlaafocr+tUfvvmvrxIsD4RlCTU8MeMYL27mrfNrWs/?=
 =?us-ascii?Q?aRMBZdAkHerD3geSLxq9ebPRv2IfKFlYUGR5c0iFTpo6I5gxYHefdLpsmdq0?=
 =?us-ascii?Q?wjFBH/2O/1yxfXBW8u+tCdbDo2A3vp+tRWNQzk1cyEO1JA2eYjzlEtlwFQ8+?=
 =?us-ascii?Q?xCSlYk62XDrG7BHZoH7HAE5COnxJxfSkinuYkxobllfqfnDTieK6cZQSjNn1?=
 =?us-ascii?Q?nt/vFdhjsKOIeBjTF/zjMRLtgBKpSWKbu80WlLlC6EcDR+RqTlPp9M99lq24?=
 =?us-ascii?Q?vYFv4H0FaL7HSnHnrJMt9+qGC7J5qYpsK/tIinmfB8ABONecdhUFkNr3t9XM?=
 =?us-ascii?Q?UKtozk363QjGXpAprTIiVWEj+VRw1T+8hx4Ih3y?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB2911;6:3ez9f0BFXxN4efEFUik0cYMvyh+iGdu5qgt17k/BGFU8Uif2IEsFwJmqOX3+iipWdDxMpj9kvRH0CtvdaqEmJFCX2DtaEJgr1ZvnkipaUvaoxvxdNRlXJAlxK7j0Pcz6xp/FkzVzaN5DlDDA+01tHoOphCNIC2xJwS/aKYfxe+kJmQ4guY6CkPUSPq7wQ+3ZOQfnI9Ct62vseWqEstX0gQk+e3+OZdryoDu68RYK5U7mT5fFyM4kROpNTskCxtCDUJVGArb2snKh9MHDZ+/xqTpmQDpNSsMRQunsGJvFur1e5ncs2NlRVWQv/fejMrNgRsR2eCsqOohHtH6Y4mSiI3urZ/+K5j5owpDz7Z/ZTxU=;5:cWYbN0RDpGiPtFZKjv3uF/U/fOExcCkOipPeldomsSqvjcZwJOrkmhZE4xQ/FMGX0Sha0laddSi8S1BKWx0KyjM3vC+4X4BWj8hkFcCD0kqzDXUwRURly0PVlNxGpiKYla/VBpujUw/FTZ0w10IBWIn1YikrB4P4mKB2RX80vqI=;24:sQ1rOzpw6c5heJ1LPjb0VPhzxUMUjviaZZeC75ZgwzSQNwk9wgm0GefrBlMvBTKI6bjYMTXlzxG2yIJq/dFEN/jBPzsqYwuH8sKL0iZ5Gfk=;7:IH1kB5FlsT4CgS6K3uuAtYZfIZX10spfpxEbHs+FgOTEc9ivhCuCQOODu5mL2K92fH8Hn0xJV9jLEQZDjIMnXapvVqswFC7MOO6aQsr9JA9aAzk9DmS83N0cO1+IOSWH2eCFUMe1tH6UVOl6eGdRe17K0SXDT28UYTmxyn1fuJPHLZMsBBIxelbtE0ulLry918zmuLiCJV+vf+EGA50cjrEQX0MMhiaATurWWXNVN4oQ1mfnz+sXzgDrhYAP7g6g
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 17:25:35.4692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb93a4ce-3133-4f8d-2f6d-08d56998cea2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2911
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The bitmap_from_u32array() interface got replaced in a global
change, but the arm_dsu_pmu driver adds another instance,
resulting in a build failure:

drivers/perf/arm_dsu_pmu.c: In function 'dsu_pmu_probe_pmu':
drivers/perf/arm_dsu_pmu.c:661:2: error: implicit declaration of function 'bitmap_from_u32array'; did you mean 'bitmap_from_arr32'? [-Werror=implicit-function-declaration]

This changes the new instance accordingly.

Fixes: mmotm ("bitmap: replace bitmap_{from,to}_u32array")
Fixes: 7520fa99246d ("perf: ARM DynamIQ Shared Unit PMU support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 drivers/perf/arm_dsu_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 93c50e377507..38f2cc2a6c74 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -658,10 +658,8 @@ static void dsu_pmu_probe_pmu(struct dsu_pmu *dsu_pmu)
 		return;
 	cpmceid[0] = __dsu_pmu_read_pmceid(0);
 	cpmceid[1] = __dsu_pmu_read_pmceid(1);
-	bitmap_from_u32array(dsu_pmu->cpmceid_bitmap,
-				DSU_PMU_MAX_COMMON_EVENTS,
-				cpmceid,
-				ARRAY_SIZE(cpmceid));
+	bitmap_from_arr32(dsu_pmu->cpmceid_bitmap, cpmceid,
+			  DSU_PMU_MAX_COMMON_EVENTS);
 }
 
 static void dsu_pmu_set_active_cpu(int cpu, struct dsu_pmu *dsu_pmu)
-- 
2.11.0
