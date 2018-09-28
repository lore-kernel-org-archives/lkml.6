Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AFC2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Cmk9k/O6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AFC2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeI1RwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 13:52:02 -0400
Received: from mail-eopbgr80092.outbound.protection.outlook.com ([40.107.8.92]:31932
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729255AbeI1RwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 13:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vldumgOPLmlUIg7tZUj0e+vLrc3Ljq7CdIVYjOrxO0s=;
 b=Cmk9k/O6VM+gloyIG4U83iWryFLNj3KaO2nopMpOA5H8WpVAceyBmUqOpAObFbQtS1DyF9aztsPElNGn7ar7ejMtk1qPs/p6dIPMWvhlWcSqNybiv/35zeWAzyVYqi0h3iXLqwoa53lRj9XkCvZD0vDJAqLw6X7cKNk5D2IxvAc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from localhost.localdomain (185.231.240.5) by
 AM5PR0801MB2018.eurprd08.prod.outlook.com (2603:10a6:203:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Fri, 28 Sep
 2018 11:28:35 +0000
Subject: [PATCH] mm: Fix int overflow in callers of do_shrink_slab()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, gorcunov@openvz.org,
        ktkhai@virtuozzo.com, mhocko@suse.com, aryabinin@virtuozzo.com,
        hannes@cmpxchg.org, penguin-kernel@I-love.SAKURA.ne.jp,
        shakeelb@google.com, jbacik@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Sep 2018 14:28:32 +0300
Message-ID: <153813407177.17544.14888305435570723973.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: LO2P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::25) To AM5PR0801MB2018.eurprd08.prod.outlook.com
 (2603:10a6:203:4b::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6490c090-09dd-4390-228f-08d625358830
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB2018;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;3:FGBoJPl5QU2eq9VKci8FnnpS7vBa+fRTK1fAlanAKtfbXEhnZE922HCXrb1q1JZL1D/HdTY0uyVvhTVeHuxLOnxQUZNtdPwBvuoi5NVd/prbW4Po8zCV1FLX6djnaZEScamExNp5fS+qBufmkq7RKdUHsrHabjnfkd4pDPJjbV3c9AFMhlAD94MIE060fK+0rMBjcqBLbEC6Zwjf0+/MeGMelVUWQmU0C9guocjj0Sxyy5jQfLNWfSXd9Mb/fWUE;25:2WqvVXIaXVwIMsbbpDwQgrWJRfMdcKvFYOU7c6LVjjHlTE4ceJo5D5hjMPT+feEmp3OVPxtwDNJhNZAjRE3d3tlWYzuhAI+h72B5zct75R3YUKR+8jgIo5/f0Lt5D1Kyzj9fRGDE0NgjPT1hNgda9205nwqWekRuJp+ArVm2FoVb/7xeurxg3qgNGfdSHjfsNqRXaijawiMUIIpH+/FIWl3+jkpin6IPNosrJXgJ1M62o+apT7CF1gQvdh34ku8nXyoCCx+m9RdtXPgIOqxGaNDvrlj7vDmHKwTW8MSBIYBIbwMQjJjzA5RtxVMG7wFaC2JyU3UGGme+k8aVqPIYJA==;31:hsm5Vr/k8XOCC6irXMEJnJhI9uqV6RUGTXR/G5G7pM8tHLzL7YaQtB9HuyOalyEatZhOExcH35ZZSqn2ZipPTeiW/+y/jrcwpp58Eu8fHE38w4rB2nrMInmMaviZWhu7LIZ84F3DEs4Y/gJ9leZmsyMtjmA7LH2LhBfeP+kWeVc+AHPaYiNerORiUAALf8Rn1jRxrostp3nqPfGPmE1/Fix7LHIZjzAFfh+a5bSZJQk=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB2018:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:Uw7zMA565b6/N3O37CMkwUgal3KpbYhBqYRcb1R+K7v89Y78x7CCgRDHtbGpUVvpxQd6VJSn5+JVs/XlbdgmWeKBp/ecGZQSXQhoIrFakW/x7C53fBkjHKjk1sQ1rE2WVQ0xvMyoFGDOLRHqNL5sLFGQNm0yCgfwN2Wfrhg1zyauIN2relszQoMOIl+ugiVROq1KeXKyRdB4xslY4GzJC+hP7ZqTdz+bmLV72rb4iAVIDgXjwruozT1Hv6KGoL4qp6uhSBzXt+CSZ3lel/rv0UO4S7w3gDWI4H+zLW6OH4FV1aQyBdwma5kn18V4mOG2t5l9K9HBJ8+UihBd1N/zbq0fYbJCFW5sY94uHZB8lhIuK1OEx4m1DW8cXQ+bJFxFg1dKXkdSCA95FTr+irtrGyb1Dj/WtIQIscU4D/Jl2C24dOVDN5M1LUOz2tzIMzzkkWjUAQBngMxEiMguGQMcS+9CgfJx6ZTOl1TI6DUeBz2cX/YxnxyEfWlkC7sH+KNm;4:VB/nO/80RROSyN3uwLEthnYgxwx9KxwPJY9nSEEQjJXa069LOjacJruWWt5mQA8GaEpG2rc6+GzhW/AmuzeCHvDZgp1Is8WG+T3d21R2Sdjxp2pwoA87bn+5ygRJcj9oHP3IBrqSfUtXJQmDnWs7zS6SUaiKsPnN71jffeEklh4BFCdHnAO5bvdWVbUdrM9u9fk1rSEeepTd+2W+OREixXyFcJtir+o/lbU/pdpiBKmqW9/XGVOS7fed55R+d4sOgRiOIbWMnEedjhBOeyLwlQ==
X-Microsoft-Antispam-PRVS: <AM5PR0801MB201842537A4F0603DF276B47CDEC0@AM5PR0801MB2018.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:AM5PR0801MB2018;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB2018;
X-Forefront-PRVS: 0809C12563
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39850400004)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(103116003)(8936002)(8676002)(2906002)(6506007)(386003)(486006)(7736002)(34290500001)(305945005)(81156014)(106356001)(68736007)(81166006)(53936002)(105586002)(66066001)(97736004)(478600001)(956004)(476003)(9686003)(25786009)(230700001)(47776003)(52116002)(7696005)(5660300001)(86362001)(6666003)(55016002)(6116002)(1857600001)(26005)(33896004)(2486003)(61506002)(50466002)(58126008)(23676004)(3846002)(186003)(16526019)(316002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB2018;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjIwMTg7MjM6SGdPZXlIeGkzUUZZSURtNTRlWHZySkY2?=
 =?utf-8?B?bEtQZGwrMW94M0xveHhlUU1neDBhd0daSVFxeERaTDNmZmxzZUFCbkJsakho?=
 =?utf-8?B?aFI0UVVSaUxOQnVMYkVBR00vamxDU2NvLzRmNVM5MmtQc3NwdERNbkg4NGZN?=
 =?utf-8?B?UzRHcDFycnZ3YzJKTXJZSmNGZ1dBQ1d3aVd2c1Zzd0U0d0hxalFHUVlETHJM?=
 =?utf-8?B?WEtGNlp4U1FTdVI2YU5iM3hNSi9BUk1zQjFrbTd6MFFXSHViSjhqcFNRN2Ry?=
 =?utf-8?B?OG5CVkVJOWZDd3NpRjYyZHVHbWlNUndtWGpEcFh3YWk0QTZwTE4rUnNML3dO?=
 =?utf-8?B?ajBvUzZ2aHo3Y05qMGQ4b1ZOd0hqdElMYitrQjVpVkxMUzlIS0MyS2IyL0NM?=
 =?utf-8?B?MXVMaGhRdFpSNU1iQkc4ZFQ0UmxuV2hCV0t2QU01Zm1wdzhiRHNxTTRKYWIv?=
 =?utf-8?B?M0IwaFhueTdSZ1dxdU5RYjJoUFdER2ZJeTdLK0tKai9KSmowcG1TQStRcWtC?=
 =?utf-8?B?dWtYVm9PbkVxbThRakY3V0lBc3dMTWZvbHc2eVpMZHdOSDNVZENwdGZMcTdS?=
 =?utf-8?B?VTNIMHIrK0VQUDUzUWZseUx6em1ua2pFaFhyOEh4RWtsVjZQK2h6SnZBRHgv?=
 =?utf-8?B?ZWZTTFBmNVExUUJpK2xOUE5adU1UL2RENVN2dWZPakVEVlpZR2hNNWZLOVla?=
 =?utf-8?B?UDhmcUQ3Mlg2OWdJNDBwOHF3WUQ4cTFFVEY4RDAvaWw4Q1c0b3pwV28zamZD?=
 =?utf-8?B?T1hmT082d0dYQjhnM1psTWNWK0hQa2VIRHhUdEl4WWtHQ1ZpUW5ObjhMK0pO?=
 =?utf-8?B?bXdNaTk0QUp5VWR0RlJEK0VmZG9QelJzQUhrdG5iVFVYTTZqMno1RjlnY3Uw?=
 =?utf-8?B?NUJXQklZbFNjM1h6cmttaENZZXh6QWt2MG44c0FUaUtVdnlIOVpSZStWVTAw?=
 =?utf-8?B?WkhSelhTMUhGZUdUQ2U2UElONmV3UmNzMFdDUXppaFZVNlZ2b0pSZmp5Y2l0?=
 =?utf-8?B?bk1mMXpobnFEdURMMjNWaXVaaG9DQlg2M0w1dzNNTHhPL3AvWUtsT3hPNHda?=
 =?utf-8?B?Y2RMR1lvL0htMUJJYkJIMTJZU0VMTklwMCtjQXErWHpVL1l1NEN4LzN5NURH?=
 =?utf-8?B?RUU5WW0zWVg3VE9WV0NadGlEb3pOQU1QMHRQR3NDOFJPcitEdytzb0ZNT0Rw?=
 =?utf-8?B?cldjaVJ4azYxd1lGZkw4TXNHQnB5UzluMCsyMHM4VGVneVV6UGQ5bW5ZcWFO?=
 =?utf-8?B?cEdMTWJhc0FOcnAvWWJySGtXNjJEZG5uZW1ndGFRYmZSdEI0bHpEMk9ZRm1k?=
 =?utf-8?B?bnVjSVd2VFhmZXJGSE9XNXZibWZ6cUNBQm0zRHNicFNRTTNvQ2xoVlM5T0hq?=
 =?utf-8?B?aUZGbE1YMit0N2FHWUFKbkxnaFJ1akUrU1RJOVpVOFFXVDlZV0JtcG9ya3pl?=
 =?utf-8?B?cmlyK0xpSlhQbGJTTWMwb2themthdWZTNTlGbG84MVllUnJSNi9tclpkZGlu?=
 =?utf-8?B?clpCWjZRbnZ2T0ZOenNLQzlocXljeFN3M0pFblZBWXFtMUJrSGNQekdqQjdq?=
 =?utf-8?B?TnkrWWtia3gvY2lQemVWKzhxcFp3djY4Mm9QZjJpa0grVkYwZk83b2UyRGVh?=
 =?utf-8?B?TCtPdnlLcFQ2RmJ1WFhCK1lTREFPUGtUUUZpWU95NDRqc1VyQ0VlQTdTMVE9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: TKAeK9CWnH4kRvSAcWH2t0eD/YeGlqZsnQLGb1RiDNFyUyATrm/gwGelwC4ay87H+n1QaQgCw8RHQg/IBqre2+I/oQRuDxAWLv0pjhEgJJD8M2laywjx2CnLiDe1YaO4RqB0eIPWHrNoNMif9MKPX47QjnVafTJWIJj3O/SOX/NMRNBngzyS6vUlRm4pcJvuEh2GIbftGyrto0xPMpcZwBjBzNI2clCL0xXfrOJvs7rX1ID46H+zJQyo3/VMnnihhELTFfuz5NHM8kDHd7MWCwGdAsKq1b3bIuWlnl3+Jj2bb4ZhJmQAlsuP0QfWSuCuRNow7/3zHVAgemugucJPgchefNYaimJW6vHHSzumWlo=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;6:/M/9U/+ApfaOENfhuvVaBJLoIYYpP7JKavlLhqgnsYsSVqolSIpBXrKhXjIQgzib/rABbBTbAxE7I1qRhbgiJ8eh2Fky0zqPK/fgq41mRnk21vlTGQFhcqyzrBA8DAPiU8fYKpF/HYOs2FVs1Nv0yeCbd2+dyxqeW4fvcinOZHYdT7jggm9x95uPYBNWjM3hj1zS7ZUujjSPKoGRIcxieZCV8JmF6DAbaEW8y87HczXFMwrqa/7d1z8HESjgMWxU/EiFLbPtsTcHTA4Fs8bwTmCwjZ//AEZ5yNibDQKeTt7SaSu87ioXWNn3niEbHL4bzqHnlvoErWB8zRIeByJYaY61NZ3srRl2mhd6/KVhVOewdVg94s1lG/6vKRQ59r8N2iJHFygULPsd4hFDoE0F70+mZCD8DTRG5dT3T+hi5ap5A89c+ou0nylYo5djX0cF6duXJ7aJA5NZMYg/ROoeuA==;5:N2gre+mHtGL7KyZdeACxtN+8wxmBU2Eg1uejeRhch30LBxSeW6bXl+rhqMwnCT2VPtSRYaKF4i+kMyhohGXJd3XoVP9r/4gf3q8TeWOrfRzKZxqQ24D8vJBXp9e+2SD0zJUyp1T6DNo+yGU27I6eryvTTeVgBJd84i9FCxJax6o=;7:xaBdOTFstZNGDgbdM1H7kDZ4JW/0ttfSCUkm6PueoDFo5bwn0ZhmvthuLaPlOmaTeqt9OT9IKCJNc8oTcUl9DqQy5vWPfCCU1nM3f0dm3sJkKiuM6aGKp/HJxefBi9+6QpODWJ7F0HXVmOkr8ieVjQSBFgWXn9zSQRZukiecJg8xohb/P+TM+WF7u2zz2Gl+mD3ZHQCdRNAV6WZ1rXm9Tq5gl8Q/r4MkGcXJBX8ucpVRkb69MHLwNbFv7ZnlqVY8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB2018;20:3Nmm8jeFoAzF17kCWdLFFco/TB6le3gTCpfDrnn5IMaDwzHaiTRZ6Dc92u4k/pY7JJwsJ1R+nJyB0txCnw3pyEYP24W18EDUUPxY/4PxOXN9sNQSxKN6xVRwXa8nM5EE0DI+gd0qSf1grsabpmjytFxU4YlZQEwkG0H6G2ZsXDg=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2018 11:28:35.9797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6490c090-09dd-4390-228f-08d625358830
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB2018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_shrink_slab() returns unsigned long value, and
the placing into int variable cuts high bytes off.
Then we compare ret and 0xfffffffe (since SHRINK_EMPTY
is converted to ret type).

Thus, big number of objects returned by do_shrink_slab()
may be interpreted as SHRINK_EMPTY, if low bytes of
their value are equal to 0xfffffffe. Fix that
by declaration ret as unsigned long in these functions.

Reported-by: Cyrill Gorcunov <gorcunov@openvz.org>
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/vmscan.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0b63d9a2dc17..8ea87586925e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -581,8 +581,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct mem_cgroup *memcg, int priority)
 {
 	struct memcg_shrinker_map *map;
-	unsigned long freed = 0;
-	int ret, i;
+	unsigned long ret, freed = 0;
+	int i;
 
 	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
 		return 0;
@@ -678,9 +678,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 				 struct mem_cgroup *memcg,
 				 int priority)
 {
+	unsigned long ret, freed = 0;
 	struct shrinker *shrinker;
-	unsigned long freed = 0;
-	int ret;
 
 	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);

