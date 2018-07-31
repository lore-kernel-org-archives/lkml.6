Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66BEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62308208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Twa+YwBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62308208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeGaLnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:43:16 -0400
Received: from mail-sn1nam01on0072.outbound.protection.outlook.com ([104.47.32.72]:19632
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731511AbeGaLnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah900ZJto+VHAnRcXT5QLB7FNUeiikk4Va+HPMQ8f1k=;
 b=Twa+YwBrZ30cCqYpJSxaZjgsKvbgptacDrB9WhRJcZWUzA0NwNm4vrwFGkpK5h2rbm5OV2I9nrvVYkQa5U5mW+WAP9j6SuVW1apXLTp/Z+mcfV69B8Q54bo9WJDqJwbmUlXZZeqZq/RsrTrbSueTe3+V/CbqVcW++VFj2GWRA9Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ganapatrao.Kulkarni@cavium.com; 
Received: from mypc.cavium.com.com (111.93.218.67) by
 DM6PR07MB5308.namprd07.prod.outlook.com (2603:10b6:5:45::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.4; Tue, 31 Jul 2018 10:03:20 +0000
From:   Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        mingo@redhat.com, Will.Deacon@arm.com, mark.rutland@arm.com,
        jnair@caviumnetworks.com, Robert.Richter@cavium.com,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com,
        gklkml16@gmail.com
Subject: [PATCH] perf vendor events arm64: Update ThunderX2 implementation defined pmu core events
Date:   Tue, 31 Jul 2018 15:32:51 +0530
Message-Id: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: CY4PR14CA0032.namprd14.prod.outlook.com
 (2603:10b6:903:101::18) To DM6PR07MB5308.namprd07.prod.outlook.com
 (2603:10b6:5:45::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c66bc3-92c5-4838-cfbc-08d5f6ccdaa9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB5308;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5308;3:AM4RXyDtRevaun6QJUGsF80JhQ5JNte/O2vrf4Hxhzkp/u8XPB//lkCvr8ZXl/VCtE/XP0rn0kjSRFzVtIi1+sMA7mnFHRi64ETabFuqGXd9m15ggU07yMYB4gu+DC7fvwd6MCada3bKkEHMqZ/OhYdxpqzr/4aaApwkZzBvKsZnWSCfGLYrOX6cqUWbLDnQvnRGuinYl/VL3AoAf/wp81lToQgrc8jPhV80NwkzO+dEaT6dZuj+NrZwu+qZZsVy;25:8wFasz120dmyCUnVuGUKkDaUWls005T4ju3UsdxW85nXUw+Ctyl3aNBq0FT7q8v8T3fjv7yvy9R6obkTzpW3iTi/pNZDkZCdFI9dFmyZvpf3qiB2TmfpWCmpsasfXGOuyUobc+YPfRnYdKi/S8UHYovgx30zuqcvXyOR71y+Rd6Y9/OcjQwRyhFUNwLs7a5tTt8GLb1rcZXIA/ZS+RwlyBfClr6vJ9yXj5TfWZxGMNh7AjiC3Ygei3yoZHc11WdXqyD+i1mM4kkN+YcJY7uYEorFmWs+dHLGd+i/vuabIyhrJdFIfc8FkYEjYWFZWg/nhA5XzlNqWO/MC11j9BkCEw==;31:6rF18U5p9gILjgOd1mzTcmKPd9YCAoBRbrg9/2oyPo00ZX/xWJ1IU4kTc60YNLxq38tI3DbOgn0P3w2AzjO3L6z7MmaisefJX/GyxnyOP8e9TC5EjdGrEh7ztgzIuDG3IoLnpmb2NbFI0SqwpVx9Mh+k3MInuf6cTi1Swk9m0NgvNqFB/ynOtGLefbnfeHWfmvmEJ/qy3g70898PUTgDFJ6XT3munMWnatFOvZwg3Co=
X-MS-TrafficTypeDiagnostic: DM6PR07MB5308:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5308;20:aWqYNl/K7Eo4kfEHkPnoW3LhPEimgfnvExdaGtgxw5QQTK+zp0ACa2Be9DuK03fQnrwjSRry5aeBcabKjACjCTM+iBW2hCKafu4WwI9hCR3E9oEP1yfrrOgJ2XfhwbphWxpH4QFHHjo899ot8+mmILK4TPN3a7S1/NmUNncUnwpEuQmwJKU1W86WbVcGbk5vyPMvGTq79lAX4EtrEgijIJuemNFKmmrO9MfCOb33kDxgfTrZxMoE1nzkS8viySQNd54TynPFSDJ9jAjttGEExhs+vDzQLCiKwM0JPWJq/Gz75xH/73IXIxR4+bPsODM686WwL/JjP+sF/6LKs4abtLk2W4Ehtc5PM1jjYH2yrIocNi1gmUJg7K3+N5NX4Wp0O2VRiRJMgso//c9FIoXnNYiU7qDICbtBKguQvYHaCp/jDwwPIa2O/DQxEVqzMo+rnJKrhmXRoA60TknHqUtxM7vN4b4YHSSdTP5ZORasREOWNUX7dBr+GhdYdJ9AUoua;4:hDdJj/Od8qnr+E3f7NOJaPZBQ6GrbodSrUbl3a53pWWW3qw47Nk70/h83mLbdErlWlN9atpLsUD1hFjwNMCyg/Ub7oFOrxp+EfNc9ni8yGCU+Xko6a7Gh9sfcRgKfkqJj6wywwTD8L6tKbPXgn8B2IMgkmpphhuj+FrMq9jrRWIFxSf7eL6a4wEtRLot9WyhN+KBDNE3F/oWsLxtdyNY+MoBXviOHqcKef32aJmEFTXcfx+jASQ4jLhM6m1buO8Qya/QQ5qqo5uOkzJmpcxiVw==
X-Microsoft-Antispam-PRVS: <DM6PR07MB530817F081929F28DED06AD0832E0@DM6PR07MB5308.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB5308;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB5308;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(136003)(39860400002)(189003)(199004)(2906002)(476003)(68736007)(50226002)(486006)(72206003)(44832011)(305945005)(6486002)(6666003)(66066001)(5660300001)(956004)(8676002)(81166006)(1076002)(47776003)(50466002)(6116002)(2616005)(478600001)(5009440100003)(3846002)(7736002)(52116002)(26005)(97736004)(86362001)(7696005)(7416002)(53936002)(106356001)(51416003)(25786009)(105586002)(14444005)(48376002)(39060400002)(316002)(16586007)(186003)(16526019)(4326008)(6512007)(8936002)(81156014)(386003)(36756003)(1857600001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB5308;H:mypc.cavium.com.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB5308;23:61zsgaw/fT0RwGfuTVM5fUJ2c++Z6b4K+edeV43VB?=
 =?us-ascii?Q?0U4uscBwRGHe9vGyG3eQjJtIApuaORg1A/3Udf6GfX65A9gx23YFL0vqonjG?=
 =?us-ascii?Q?VJ88d2fCfSTFQe+UTeYVhPyDtoH5dCpBhliBkZeqhBygnGHM+tLxt9W522rh?=
 =?us-ascii?Q?ukfVllRD7mep+8T7jLBf6UUzIXByBOpcDr6tiOlWSVG3XzG6/C1ZBHD9V+Tk?=
 =?us-ascii?Q?FjXH3K23exNNKjYFqIr4FjQGw8aqm8FYbWbEtB3wkpXT/Hejkc0dzmcyOVc8?=
 =?us-ascii?Q?9uh0IOW4p70xLCKQDL6iYZJ1wYsSwhx+DgCzOpidi59zL94JpiQgV0mhCsEM?=
 =?us-ascii?Q?BlJ7QeirM0zgsEso7M7WQQ8YT0Qm7VN+GID2aDvbf4D7jViETwwyTqhI75dV?=
 =?us-ascii?Q?wnlXkGj+f2n4DGQ50O/9DvQG4RFicudvexzgJ3HQEtRFhYNvEl0fl+P0f4Xe?=
 =?us-ascii?Q?47DMtioSuyruHIEvT7WXKNYiwaXIeH5d0oWRO4I/W+AHRQH+AlwtbjfFvowg?=
 =?us-ascii?Q?E4c594K2Pp4N/a4IsNxKBaGSexOrfV1K2omD76wM8qBQn2azCu2UxmRXolaE?=
 =?us-ascii?Q?PQevndr2MJhB1Bg9y5ZixvDGRho/A66uq/yVTx8gSrJLDfN0q60CbHIrwtuE?=
 =?us-ascii?Q?DykEXsVNwVQmxgiR7QEiwOsgCqYr8bgXIYkrOYl2V4zbBTI6ZHe14gS17ltk?=
 =?us-ascii?Q?6L3uJ8kc18vvujhfhDZIvzn6h1/c/GAsKtwxIODImhlxjC2D5cZisxcN3Jvt?=
 =?us-ascii?Q?i+9oeMpSb5SSFaZxm/Qg7E8v/9GJcZt7O55vK27qB1sUZKu6IY7aVmT8ZTxJ?=
 =?us-ascii?Q?y/FdCBKtZmw5Azs7ev9GAy5OsHGDqZgRrxlFpKOMOllh8pYh16f4DsjMW3YF?=
 =?us-ascii?Q?cvvB+odd73yUOWSX3ayQ97zVnlBYrsQO5fV/L4Yl4OZRk29LUPKjuHGfSGVt?=
 =?us-ascii?Q?ynl0IehzEErcCUyCBqzke3Du9Y9AKHVWWISZZvRnYzPAOTsUKo0cfEqje5B9?=
 =?us-ascii?Q?uwWiAwXM5/z3yNY8ekcIPBBbxK4AwYK4vBgm0IM0gNTvLhirAYuEex57ao4f?=
 =?us-ascii?Q?4y/+cNcEWotNDtKHtG4Thpnh94tpT0zj6zJlqiQDjs/veJ9A2GB5/+OH/lih?=
 =?us-ascii?Q?/15+HvgDXrx0fnO4axguvWzZpE7zfDpLZaKhXNm8k2igDXVKoHixpICxkgd+?=
 =?us-ascii?Q?gNVERIcx6nEk70L4wL7cDyftJQrJvVHQtBaPgJwA4sStpCJPAjl2jGBKDtzS?=
 =?us-ascii?Q?GwqGP2e6lVYayQq0H20VlNLziatZ2de4uqWgr6o4C5v7QOHynAtZRXYRGUHq?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: pDwt/HWqctxfuTlj5IKGq+oyRo+TYoVFVrmUneusaWjvl3BonGQSRkJLMigDVtgEvb9Lbqtrw0xwOIO4nsHaENjwxtA5f6Ek4hMoTFtFfJF1sbgxRwfopvGJeZkw1ByOl+igFToI6u46A2xuk9yrXnXLam7y7L1tyryBdg65/yaF0pbNOxkt0Kf6FonxIXMt+GfLBTeCaes6EeVngydVXocIOXu83Y08XZTjZ9KLBEugQgANlfGvUhKZNgYxA6jg7XB94Kd5ei/pbHJOYTdbCFLhi9khsefBHdIc2xs0TaJiYUzF/57QxS7k4jJkszDMoM1g0/e0dPF6Ivi7yMrCn5i72NnQ1K5aaX/nez2PFEs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB5308;6:tW1G7IVcDq+iZiWpTgmYQaTHTupPSKQwnZJzCB/Bdlp6yWsvERT29Q70BH1YkRmlJO267VeA5KOf5E+8s07C3uHcyCCZCJAD1OrkoDu04101blsRxknDnWB5IMFBJeWfkknTV8qfcTWHfJF3mbh1EuTCJXLg4MQe6koVJzp5X56ze4P9yfVWs7KNVzWzbu5AWVCton1CbNHjm8e2PDB8K4rM8DDlDYR6WLIwdmDPSTLmq40YrcJT2uxZyPnGHKoGP+DNgXeBmwLxyn33N897MSids4aQ/iO388zPW5J4brM/vymOi8uTB10x18Z3k+2QDonC6fyZCp9tTuRdckBP+3usjk8f3/cgZq7BBuGWT1CdZaWpvl9LCMwcefYz3XivnhWOZLmYEMfn0qelPGHHwXDNyvnzSlan0BwBk8A7nl6i+dmMKfwPCPB4FHdPzp7xQi0jvNXJRZhwfXT3loGrwg==;5:enqbWSlOJkuHrNxTsQcSzN/Hs+I99VKRn2KFL2AVB64sXXt/NFQXYEG+p0gv7IVgKyeJVQT81RD/JpusnBXbGpsl1bNWK6yhOkrwgFaA+8gh/ITsOp5FlBgOpNekWlHBU1eF74arn+PMvejzZBF2tYrhzByZL1T6/bCfAOmDu/U=;7:udw1TOSffxXjlOusBUzqPZ2E8pOfPSRPrGPYYBOq8g4cocM1NlF0l33FRpcLpoRbPEpzi72HdMmYVaPZfHY26qHbOUwHdia7QfNBirPuFh6kv61FOqnmGHtufpdIN3eYf84vCmVu0G5MN+8W5ofnAc7Cm1a9naQkre/hcRQcARBu04woXihj0I/Bp8aIW9YIUi4K+3QGGnOaQfVM7n3r6EtlSAXwcNJ14/EZsTHvt1WViJ92K1HxjRmCLtBwCGzm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 10:03:20.2545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c66bc3-92c5-4838-cfbc-08d5f6ccdaa9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5308
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 87 +++++++++++++++++++++-
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
index bc03c06..752e47e 100644
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
@@ -12,6 +12,21 @@
         "ArchStdEvent": "L1D_CACHE_REFILL_WR",
     },
     {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+    },
+    {
         "ArchStdEvent": "L1D_TLB_REFILL_RD",
     },
     {
@@ -24,9 +39,75 @@
         "ArchStdEvent": "L1D_TLB_WR",
     },
     {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR",
+    },
+    {
         "ArchStdEvent": "BUS_ACCESS_RD",
-   },
-   {
+    },
+    {
         "ArchStdEvent": "BUS_ACCESS_WR",
-   }
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+    },
+    {
+        "ArchStdEvent": "EXC_SMC",
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+    }
 ]
-- 
2.9.4

