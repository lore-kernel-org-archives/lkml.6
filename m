Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABBD20847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sHpM7/Z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABBD20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeH2QwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:52:08 -0400
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:57440
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727452AbeH2QwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky8xK087xyTPBLIrNYWD0tCmWLyqEksBGrAhLK/iGH0=;
 b=sHpM7/Z5bXQt1aV5SBfgUu0Faak6o0XsvVl+Iue40aAYJ8ZIuOHw1vCCw93mZvp8qwLG4i55Rb+8P6Rrz98U3SBnVCtGQeCReLAsI6F5KrK662kjYV3RUJTZ5qYIn7kYuebh+L2MBgXL9TZWHv5/S2dUJnrSXYx1HoMKt85QMoA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:66::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Wed, 29 Aug 2018 12:55:10 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        thor.thayer@linux.intel.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V4 0/4] clk: new APIs to handle all available clocks
Date:   Wed, 29 Aug 2018 20:51:36 +0800
Message-Id: <1535547100-25634-1-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:36::15) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7502b21-b78f-4e7f-e00a-08d60daea97d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4211;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;3:xVwvc5lpTE5RNB5ko6DQrf8FSQDdMwz+BuCv8SvENcD2FTaNqs7aX0J5K2+j6QsXiBH2k5rkEQjYyznheudK5qH84nnWUb4ZAT2F3ptPGkuRzLZrW9+1T7BuP1eTzn2bmw2IIJo5yrxlIgZLG6xyYQ4cV1QptPa1lTPgcc8wVolabFCZA3CdzLPR/xUFR1dKK+PSQAyhapi1YpwvYLAaGXCxKX5Q9+0GCJ/y2tcrOwZgI3wtBFHwENh+Ef1FzzYI;25:DODVZv+mTfL2nNEhvXaes+Cg4AMjgAzTDCVyz5unGix37NT9n8bGj9PUxUUA3QEpr3ZPRwk+LR5423TpaARzxC7L9gDFc1hJP27vU44N+zho2uTnoCZVAuyAHp4hCQ5p0RR+zvLGH+CW9o0wMXQGSGonbHPfNHoArUnIwDTQ+marvO40DeDnbRQgH1K/c2a6CwJvH0bLGE5DWtyfV0W9CbOXa2m19xR1JH3smf5i2ErMytPMg1pI7Bm1GddLyE4BX/BG2v55dNYYw/1+CoxzpOxI0MSaowKZBOjq/YkbRIqK6JwyIzJUtuklzHYclWxG0kVgn+JYhkiZuXGxNX7JaA==;31:FNXZRn9i9JYB7W16R5cIn2e3j2KajGZ4QRRmiBtI3XoswxVRYDZjnOCHxLsky1hZhhTFN7tQ/8LFPgiYpx0KlCBfjP9M++tK2opeXQgewan+FOfi5mHVKzusFEAxgXKoYjjf6zNbcoZK7fJHExyjQQS+iBMOfofqErmNoaqm41q6bnah0jaChAZ4RnUgCR674xSNj2AtbElD80wHtwvbOM+XtIer1iYyeLR/F7T8gI0=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;20:k02MmUnPlThf1shCrZ+RiEGw3QHq6uxhvW7ztZ28nNE8BFb+2kBfvsrIkSkuM/NYEgohq+vTs1c8Wo5ENHbdzJCRG7qIVkIr1j894r/h5wmZZrIbAmcUzKC3S+UYCmd8ZQ4zXk5vBcxboiB9LE1WSwx7zpcy0gNsSltRQPrOU94pLxvNke4S89JnryR9NB1T6KF5boWp2eUyNaB+m+085qOm+5U3xLEIMHYw22c8HBgKob/FZwzy/Y22MtQdMJmZsn05t6AhpUop58iCsfPMbI7QVF+xTlBY41ogXgRxh+TYWRbkdmMdi1bReYOXHQJR1+j35/vXmOWnRVn3mvBGJRZD7NF1w8mXEzTSTx6mpfuXrm3oGtrKVBv6c4uIX3Z5HEMkYxZhxx1661eHitoavTHngwnHCjDFQ0aFLOID6atolpSy7gw2LENG333LllhONJARgwDIa6ex16zA6gCuNim7VSTQ+G7k2J2e/ibyCr5QY0vZtB4LG0TteMYJHayL;4:1+JvuOdY8SncLjnrfwwt70ryColOlkaYAap0lR+TbO32pTuqTCE1oyf59TGyxA9MBan9rzHzP8kefkb5prHR+NmTC79yseLE13VnSkzxADoUvlqxdOARHw+bvUXNmkZGzaujz/NEWJWpB1keu/rafZkfbhh9pF3aETQqi35uT/4UGWoL3dzpbREGOiFl7/CY84LWtcUgnQv2xkps3SVeZUmY+wmJpV+r9wci2hUzRAOPshkNEVLlnfo1JWWvUM+hI/s3z0fiNMXvYemF21ubyg==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4211E5A1913D62F3D1EDA74380090@AM0PR04MB4211.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR04MB4211;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4211;
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(51416003)(50226002)(3846002)(6116002)(68736007)(2361001)(8676002)(50466002)(48376002)(2351001)(2906002)(97736004)(106356001)(105586002)(36756003)(8936002)(6306002)(7736002)(305945005)(53936002)(6512007)(386003)(47776003)(81166006)(6506007)(6916009)(2616005)(4326008)(26005)(16526019)(66066001)(25786009)(956004)(81156014)(476003)(966005)(86362001)(186003)(486006)(5660300001)(16586007)(316002)(478600001)(52116002)(6486002)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4211;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4211;23:LD8wBiMcQQyz7QMjrINQYF3moSXTS9fLtGTKX/AoG?=
 =?us-ascii?Q?Z+PoMgVHGrMcAPMCLkvrX5C+BQ36qMwQFmiTPAhXHkQZHovQk0h3SRrtBpxA?=
 =?us-ascii?Q?nN6cQkTQlPaNgn2EEYJpB0pAL49XaIzOlBEpYRVpv8DAe61sGZi1tUEMF7uM?=
 =?us-ascii?Q?Al8yoo7JeyAOZKlJKZRkoiw6m1jm85mgAx1G24ogHPOVRBrWKo7exXpqebwp?=
 =?us-ascii?Q?bI/kFqbypKZ6JDZKjmIujWAx3vx41U0rtzU0q75PDmfJKmTK2Pu9eiHITLKo?=
 =?us-ascii?Q?eLs/pQGztfB3ucJY4dSN6SJUmIuRoSUYMwLTBBoCyMwTYLnozfI/YkYHxsoJ?=
 =?us-ascii?Q?38znv0Kj6N5Xkn/BFcOfH+cXS9BJ39kqcvZcdfv9mqvYxpqjuixjqjmXDiJi?=
 =?us-ascii?Q?iABqvcaOX8hoLBPxZY3kIRGQ81C/6eVZQelUATpz6cjOyrqluXK8FMB168Ag?=
 =?us-ascii?Q?sb39g+Mqe00I8+VRagatl6L/9sbBSV0qnqTnCjPzE+69toVjCMECQMASjh88?=
 =?us-ascii?Q?T6E00ypqwdWHuz8XYwW8OJ2UyO2g/PyMHLh4WlayJCCj1k96IbibdRkrm9NA?=
 =?us-ascii?Q?Rv2vYD7O0U9uDTUbvBNv+nUACVdg4EEktPvH+9EJ2v84cWtewJVU75lg7oz+?=
 =?us-ascii?Q?odXECgRU+/LQJhweMBG+YbLHwiU8jKuEkIWpDpVsyDW/l295tgtH6DIKOO5j?=
 =?us-ascii?Q?dQlNEV90AS8SScZe77RIFbS5Jhji8ofO94PvbJiLPgGrfLLYWCrKby+v0ljH?=
 =?us-ascii?Q?n5nj0mtbJP4LpwShjaRhvH+L+kHCzc3A9PIJbLXu5O7b+qyOc5vDjWkt2kPZ?=
 =?us-ascii?Q?NB14OieL7yDLryBsguOsr51OL6kUjQe8n5ZizGuNIJeUCjDX9SuwFxlzxrdB?=
 =?us-ascii?Q?/YzYMUplkHL9jtr0OXah7ToavDRJoalfhfpChMidbv6zSHH8ZZIF8rToZguF?=
 =?us-ascii?Q?ADvrgQ4owdOHuHhdeQy+ZmTMQVRRmJpN8TppQ8x2wnOj/8oXVVq1wpMAH1UL?=
 =?us-ascii?Q?H/qsDHKxsEdPNuBj8WncuhkIBn22abhDfxIO0MizsfPQxeyp1NjW6JEHviEp?=
 =?us-ascii?Q?2sLGfjyIH1GVM1pCXKARvSV5zckAEda8L1K+WMtxCCwIM47OUavrUF6lB/rP?=
 =?us-ascii?Q?RkR9PYiTuAxUGTkMSK7V0j30vcRnSZZ9Sm04JLRn4u2uRSqh4USOwtQ4WMpT?=
 =?us-ascii?Q?trtbsUqVRVRdIc=3D?=
X-Microsoft-Antispam-Message-Info: O4Nt6N9uFrosNME0+CA4Eb4QKNRvFEE9oWLRHw8b60X70cxG3OGLB1jkGrAEbRSZtKIQQVYGsXy56T5UzZhbab6w/z71SM2wLVldcGN7gfERrXIDzeMnFOF9zrp9PVducffdnNymTol0PSpZbVyWWMoofOOCc7hnZ91JkFkS+FaP7Dne3kZO0ZISPnK9mox/8j5Gs9YN9Oq9O/DJGvXGYqpK2CXyZQRlu5d76+4FXDWOy/RTCNihbiuRczLvcQQt1L2EYydCytKNA6KeTg9fF52hWhnLv2n8t9HksOHaFru6xGUtfQ4yg/Zuo9qtU1Lwy0Mtu7DF68XGlc6bLKZi4KOCMYSN5/0DGDVNrGO1i3o=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4211;6:IOGz+zInTY0Dl4w5vRQNbijVJ82w9Ggdl/GJyi1lz2tkwlMJC8LbAwJlYz/C2yGLrYnILDSF47oDXB09Ju3KTYJnu/PzGMoUzXwbSvghJR454SpqQ0/4G7PIfrSbsvpStpJakNNFyiBD04TaMigjyZXVUmSm+HbhEJOGnw/NcR1kHTu/paR+maeub1CyAG47n5Mv7u3Doan1S54fDbqy2aKBTTgnQh1QnPIS+dMS2r8ZzcZE5+HaRlGXoXUotMKC39Q8DJcyJBR0KeUvr4FBnmz1akXUWWGQ9P29nypFthIgvHbELHgmAbPPd+OvBiaT976FP9NNm3ZiHpLpIIl+dfTrjg/r317aFZ+rfmnhI1EptfGcEQAo6LdpYxtj0dXR5slwKzgHxOingAZi/n8xyZH79Oaw5uPwEQiolJ747u2yEDO8gJKM3/fW4bTzAPBTtes3ImWfhYTu2vzQPj9o9Q==;5:ntuqanyeRE8aeml+lE6jHBDY+21+1VMm9Jmd7EqB/09L78zkuBvSn19PzErN19X+z/WYBivOr+5/nL6s4w87RscebnHzBQPyTyCUXUFbj0JWTLyiQlr64SLNrmVy4laM76iEQZVklWIPxl+b8XoH1lT3peSBrabUhc0gAVCHKPQ=;7:/LNvAe1zR9GTlaJfukbbXhLToGNKsHxBqXInA+UNLKnL+p/2vTWhUlM3odiIvWWgJtvIOHEp1qtQiqD0J0O2uW5SFc3QD57/Gk5peUJXbUEoYYRoqmZNMfU8F472Z4ixFM85aOxCI6XKc8xO3OmDmfXyxP8XQs9E1MMUMCrsXJCACvQ55Teni4cEJrmT7DBSqS5pK6IPGCZZCAv4ElvxeRy/nKKp6tslZkxUXGZptr4KU7gGZxrTAzWd9og8emZn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 12:55:10.5604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7502b21-b78f-4e7f-e00a-08d60daea97d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4211
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
 drivers/video/fbdev/simplefb.c | 66 +++++++---------------------------
 include/linux/clk.h            | 65 +++++++++++++++++++++++++++++++++-
 4 files changed, 180 insertions(+), 55 deletions(-)

-- 
2.7.4

