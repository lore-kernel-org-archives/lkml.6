Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF35C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642C520661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VAn1CnK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642C520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeHaIzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:55:10 -0400
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:35083
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbeHaIzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtCExRLW5aonuriSXlTRg565FfW8BDJ9qiAkMapuozM=;
 b=VAn1CnK8jGaaQAZJYYArspySA/uAMYU8UK4BqEjujmonBfv+MAaorNRL5+sL/xP/xVzFZy3w7y78Unm9cLhOINqb5NnttQBCqgZjkqpYE4HgHlppom52JLked9zyzuExnAn5waiRTV1UccG1nO6ngGYUohbJLl7FzAAtbEboEDM=
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4212.eurprd04.prod.outlook.com (2603:10a6:208:66::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.18; Fri, 31 Aug 2018 04:49:25 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        hdegoede@redhat.com, Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V6 0/4] clk: new APIs to handle all available clocks
Date:   Fri, 31 Aug 2018 12:45:52 +0800
Message-Id: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:203:52::25) To AM0PR04MB4212.eurprd04.prod.outlook.com
 (2603:10a6:208:66::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3db8f21-5011-4ba2-0ab8-08d60efd22c9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4212;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;3:/An6jHlBefwQGQdiiGky2xyb0ClkMipBGoTDT7DCH3IYNkMdicENhI8/tlPFUz+7ovGtJ5vhkkVlkctivthBRYyH10Vty3/K2/0j2qj8EbfIWtBWC1gMTG8M4z07k5MkRhcQ9hjz+1PNCdxVn0kJMyX/ssKmta0fNzA29kndS3TQqGG80jPWiyTEZnuQtnIPtfdijJ6Oghje0c8rqt7Uh10rWplwnSBTXngtWXQceKImMiTX8+wQW7d+7Vw8wIeM;25:xZEb4DiuKCcgq+IP+dCyZ4nvlF18KkOK6dSfpbewqlzNsIHIUStif+vExb/ysvTNbQXroLMtEYpOYdu52MgkyJkp2/lVlpzDbplNEvFfdTmHZcZZ75VZLP0YTeCG2MU6OzHHPjo9FxNF+rFoSw4/wYuLXv3D4LaZZGDrqkSLPWvIhV9vrXffOJpRYSr04wxz7mPFXUAYX0T7QMAOmiukUaTGWqA9DPmZG83UocS40cDNeXa2oGyjFqFnDd4zrUSpwCexU+h0mTqg7YnaaLF4+pPUqqKdILcF2bRtq7RG+OIQcXjLhBEWd47fEc0/FuSUbSSu0SDad6XDiWMa2Es4Iw==;31:wT3o8RFeaUzo7AsRGtwzUcFV7orFDInrzmVjV9qC5bYwat6NZe+eLhQKm83sQfWYfGgtkEiTTbnzttHYO95DpWpZfIhS+w+2L/+ZJZUFTYfK8Exo+Z8QjKQu5R/A6wBCivk6OdhpHliJetUNKU4zr4r7wjQoGldRYEZzD0O/5apss9uqbNmJXnx7oNOCAHtDrXTCb2sEMUgw7Ngr33bKUcXTuiC1hizEZZu46c1idAw=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4212:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;20:EGJP3+EU9sCvYX3UwTIjNinfwkZ0HKaHtI0IMo/nJMcK0SNt44DTgHFBJrObLaHfGZfdAJvlsU3EEqQX+eSKWeYx3gny3uJVfafXymfzQovrPvDNolW4FOjkanguvaJFYivPgAsfBThfOxrcpQEAyWZvy7CHuJ8urloqt2D9fnSBed3lLZfTpEot8KKQRzywkqb2vCzRemY25A0ADD+GilIlTJOcbMf9+uJB5NTWbbB6KTZ7ZQH8h9MseA6sA63ASaI6jdhHyg0Tf8tUJhPkhHU0BePTeKS2x6Tt7DyJgq92iIfuMqOh5zZHjaCn8tk8BUJIXJakSrNhT3AjkvIb3n5VQBvAF2+S1SYJOVI/nql3Yj7B3LD5H+H70wFBH34bta3V8dNIlbvYrU28Wo/rl/P00Yu3AO3m4ieuraLnvqqoA7mTxyRrpO37HGnjubkqu/iZdQYtkN5Hw/Cbek89XUBLNXecO+VFXmgyUCmJ4kUAZ8qhnm3NqmVd8El3nvuZ;4:TkmkCMbRCpOVPU0kwaeDLWPp8tiSE1ad0cX8LT0AwG376NbceVSE6JZQzbNDN0bp8emLuL94XMj8iNSfb6N0B6EJi47dc0WXl2J61fmrxnn/EbgmYAssENBUevTmHnL+7fBeFIGJNjCGtOiA2l7K+OjjZgBDuWK7SKm1B1NA0havfWJpUnLqngEv1wH/IW45tULBx8hLC/lGL9dfMUxk4pl4QI13wzgvcz6YkrZQvF5nb6ml24UrwqKxn8jEMESBkhPuvhBS4BdHYjUpyJ7h+w==
X-Microsoft-Antispam-PRVS: <AM0PR04MB42121403FEE2679660BB5292800F0@AM0PR04MB4212.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:AM0PR04MB4212;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4212;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(136003)(376002)(199004)(189003)(5660300001)(26005)(52116002)(186003)(47776003)(966005)(16526019)(2351001)(2906002)(6666003)(386003)(6506007)(51416003)(53936002)(6306002)(2616005)(105586002)(486006)(25786009)(4326008)(6512007)(476003)(956004)(36756003)(66066001)(478600001)(86362001)(6486002)(106356001)(316002)(16586007)(6116002)(3846002)(50466002)(2361001)(81156014)(48376002)(7736002)(97736004)(305945005)(50226002)(81166006)(6916009)(8936002)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4212;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4212;23:yQBvx16o8aqE2tVcggZBVHC4ofptZda371gBe9gxz?=
 =?us-ascii?Q?jRCAd8ObA/t9Aym3qAEQcSRCMTJqxaFRdxxeRYymLPJIjmnTddHkcuYOG0nk?=
 =?us-ascii?Q?SWnUjKCJzUAFfD0NRFhSyRCR/VRRs+6WUgKnGHvMd9OH+tJi3f6MtEPa4XuZ?=
 =?us-ascii?Q?r2xsBAllKRrdC2VBj9+niPjIQ3gNqS052YjNaKyFTvHOJ5vt0MVz/rqih9vc?=
 =?us-ascii?Q?Zyd6G4/0cPDnNGrx1HdKcg7o5MiIns+4+1hxkibJsjsv1zKrYMvtt6/tJevA?=
 =?us-ascii?Q?CqxR4nn8VIFkGbmsNkSQ4RgYOvryT49vVAGLjRApv16NZyDLA7jrZ3qbTjs+?=
 =?us-ascii?Q?DFALQq727ztRA0udrCZC8Z8O3I7dlfv4v4J32mRQoMQbdg45E0HXOKhUnMvf?=
 =?us-ascii?Q?K3UiLTJA+yEmGR08HoSp73s4h+75wu7+GAVHmMk3mNKHHhQmMO5K5t/bIgMO?=
 =?us-ascii?Q?NjtiAuGX3jwY4M1x+XT52+JcjuVaOnwGcoN9zg2UTkHdX8XM7xrW5mvCntNK?=
 =?us-ascii?Q?uE71C5u/TLHOc5bk5POxhtIYws6y/t1JSX6T5IhHfORq404wbexc5GPZFJOq?=
 =?us-ascii?Q?Fzn7Sg1KYJjtdNUCh5IwJmZ+vb+x0TkUKM5P+h07Em/BfmbtMuezYWQpU24j?=
 =?us-ascii?Q?RlvPZ1Wsybcu0XmMuGDH62fsNT0CFv4g/AcFAr0oFwHWEt+3iD2/tPnxCuyk?=
 =?us-ascii?Q?EWJHg0T0EBgxi9ux9x3DqjjzKu1TtvrxEd/Ln8w6kTTfXJ6ZdzxpBiH4pnI5?=
 =?us-ascii?Q?DW/SdJCKKLxz42rNC3lfQ5IeK0pDBR2/jhPnOeT/HdQdwFoPq/Yriuh9nTDp?=
 =?us-ascii?Q?XZW59Iv74aqGtsA0z1u6plKIXgHgI+457UZqXAc6v1RzFwK4N+aQNySnrho5?=
 =?us-ascii?Q?YF9eJpBn+pm79gupEssvR66phP16QU0sJjFMqYryt9WPvCUNLgHjQ8Mutzo4?=
 =?us-ascii?Q?kIETdUFBzK2b569r8gAE814dBnURg1V6/42qartJiXL2uuUbO7aO4Wpkfijm?=
 =?us-ascii?Q?PBG4EfeAzuc6xCms6nsjbcsw4MqnHcbTuY85cVGwldy3LY5YS9JNZAq/SBC6?=
 =?us-ascii?Q?krfMu1EgLNTaBIcfq/oKmJyUNeET3A09yS1GIfOurYEYgIf0adey2FM978n+?=
 =?us-ascii?Q?EHkbsOQJqDgRdE5M5MNDUI+/RYGc45IQvps/bo96HlXMXE3LLlru2BtoIR9g?=
 =?us-ascii?Q?vq3exbfxrtfWhk=3D?=
X-Microsoft-Antispam-Message-Info: +es2PYxTLm81dg3NJm8X6XFjsikj7sEdDYxzINDwMnnVaWaxJ38ncB1J5weA5n06OG0Xz0Goxe1z2qFrgyyMi6q3sw6Wk/OIqav8lbc4kW2C1H12hcX8BpBz9uV/JJ5Xbv0mIpHiMYsQauxKmqYBgBBfzKa9GoUQ2h8NSqErLKth/vYlehXsR/BHlAxLbfkdkoyCfjB1eqxFqQWJXG7UxE7lhg76x1tsyy+5+x6yvG3ow0PZulLNxT6qYDh+hYYLL/pY4wWybnPYXb94+/tM22VvZyRnx/FsJnjxks/4PoPv83uINzbOK6v8PZaVbXsUs+tjbtIRkEnnL7dG0/o089iK6lPT91/hHKlsBLVwLAE=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4212;6:K1tD2PEyYDhTY3Rpczmdis3KVTg+1CrXAZuFjy3nf4SxVaKg3k7MYnqNZij3zUjJRs5hDmdFUkyh7fsdA8fQ1sQnvfe12RrhNxu6GKDwvr74BBqlXy5/LfdO5z0PFzm3HvWRRPTiDkcpIpUp1dSR6hox1NUiv7mo9nl8+8QYrypgF7aTlLeOO+BUiYFL7rtZOyBkt4Gia1VJTfdX/Bs4QowlsdFzmtGwmawaziGksaBwHrYHEGgk710BJfdvwzj4zEKLcXUdbmZ4MzhmC8SWr7V1bXsKNQZAVrkZk9jWHk5xGH7KFkQ65WmXtVarqnuQS5AyKP1wkUpNJTXHWaBtIOsVCEa9HoL02NuPts4zNXS891Qfaa2sloBb7ELXmCbT0rgKNsEN1mKTSJ5XjA3e4z53na8sm/kufzJNTsUCxcndvOI+yWskof4Hl6hXEKRCWe9aJHI7D6uS77LNSF0iog==;5:fOkXmRwjl5muS2zATcAngloNOPD2BTnc+gi+MS31kIFg7SpxxyKatWANvh8M4O86AHWhzhaHFmnr8vbccqxa//F87vdvGfipbAQUegbU2FUF6Nre2HQvV70Sm9g91knMwdBRchjQ42f/t++ORDrO80OExwT8+GwawVX311l/hjE=;7:z7q/D0aAy58D/yb/SKU5wFWjXEu5LVpsP95s/DFGnnphr91stKyr/evNUsSunGJj67rq88mKhDef4QCZD4dMytvRMPKmQfdaZLWnMvvz76mEokkqLS+IYXBnmv3uaUniroML+i5CvNxNE3scxccLxY42DxM3ohk8VDfsJ0PVn+OnUrrQqY8ioK4c1JZfAJ4f5EWPHaaNGcBgeQck18fNudJdj/mu6moVL0eBHyS7Al+2qnd4jsxrSEOT7U74H5tC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 04:49:25.8556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3db8f21-5011-4ba2-0ab8-08d60efd22c9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a continue of discussion from here,
https://patchwork.kernel.org/patch/9986293/
that some users may want to handle all available clocks from device
tree without need to know the detailed clock information likes clock
numbers and names. This is useful in writing some generic drivers to
handle clock part.

Note:
This patch series is tested on MX6Q SDB cpufreq driver with a minor change
to switch to use clk_bulk_get_all.
But patch 4 only test compiling. Hopefully someone could help test
the function.

v3->v4:
 * improve 'devres->clks = *clks' according to Stephen's suggestion
v2->v3:
 * address all comments from Stephen
 * fix build warnings on other architectures.
v1->v2:
 * add clk_bulk_{get|put}_all() which only supports DT platform currently
 * remove _all variants and the wrapper struct clk_bulk
 * make of_clk_bulk_get and of_clk_bulk_get_all private until someone
   proves they need it because they don't have a struct device pointer.

Dong Aisheng (4):
  clk: bulk: add of_clk_bulk_get()
  clk: add new APIs to operate on all available clocks
  clk: add managed version of clk_bulk_get_all
  video: simplefb: switch to use clk_bulk API to simplify clock
    operations

 drivers/clk/clk-bulk.c         | 80 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-devres.c       | 24 +++++++++++++
 drivers/video/fbdev/simplefb.c | 72 ++++++++++---------------------------
 include/linux/clk.h            | 65 +++++++++++++++++++++++++++++++++-
 4 files changed, 186 insertions(+), 55 deletions(-)

-- 
2.7.4

