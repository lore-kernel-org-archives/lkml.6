Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5798AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087C521771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WuKZh5+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087C521771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeHHS3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:29:53 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:40736
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbeHHS3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGtuODPpmnUjJJ+boj7Gx3h4cqshjSe/YDdJ6kzzJj8=;
 b=WuKZh5+27klUbnhlsZaN7KKCvaF/U6/HyJ8BMr5cKJGJ6s9nk4Ba+DAn8buFMzzoUUXu56nYv4JcjTPRSiPWZ6u1hdGanhxVF05BMfl9UVk014+FGlR2DUOrhlz9ii8ZO+rFabemVcNlmRJhugp53ZZATYzthqvYkEjsyKTe0ow=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4301.eurprd04.prod.outlook.com (2603:10a6:803:3f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 16:09:26 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Date:   Wed,  8 Aug 2018 19:08:57 +0300
Message-Id: <cover.1533743954.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: DB6PR02CA0004.eurprd02.prod.outlook.com
 (2603:10a6:6:15::17) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ce8921f-ac90-4693-3004-08d5fd495148
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:UF36lloBX5EYVj+BGZXrBphHMXqOJNanhvYdoyUlGMTDoeS0VGkXA0cm0+5vq4Q3d7TDDXAIcOqCsY+mJ2SB4XCbks4ALgiKaFIXDtI6e3MXB76Ck25hhQz6/QhyCNp7gdYrq3Kkncdh8QwLbF02j2TAvmfS2PNUHR4RONJNozBeZgg+zT3sKSjEDEOBA9h7Lkjhi5PQQlaylv8jsGPudvm+fgwiOs7hbuAJonExZIFPP2BGie9Ca3W2g4xJKaS4;25:v17ZS1f20BpJZPbt4qXhswlyxNSSXGuFEBW1IA4O/0j6X0n41GcO2vw/ouWI4LTYk3J4VLTmd2cgLlZ9n34BBCdKHCwGaT+HegPt79D39n8oeOtn+wjs/nd8Ji64d7nWAztlhZcZjpu93XnlZ1zfey2z80KRXw2SSAkALDmoVJ7Bpwz2/Cw/RSzO9Fm4GIz7E4ap+3yoyfIFW/zEasCil2vykhwosIfAMr+peLi2l1k1a8Q7YZ/Q7aQTBPwbFnrsHPvvbBwI65Oqen/uZRJHuUxfzVkkvDxA6ebKPR9QFIeiJ2M/OufpIKI9o4xZNGMALrDFrLRM7GgG4Kuqkx4vlQ==;31:ZJ76EXRBM+YUwnETLKURoUy8hx/5HzvTFdCoUDiyxGvtiyD2pbvr0NE3X/va/DZp7v6Fw6tSeKgCcZgh090iN84zNkkjSSjn9iAMgpRVfdnyeC6d0WBVClSrE9uRcOtIgSKcz+phMu9aagKPFgFsS5d57weLi5HDTV60djD1IeRvkXS0CzC9qHkUKcSScurnNhbI+jRvgLYECZC4QcEDSGj231Lckkfp2NllXL89AO8=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:w/0Xiv6a8r7aEj7j+eQbaoCl4RhEdY4bKjuyO5BJCOA+YrL+7t3UIauK/pbVExEt1ujIz5jSva6RrPJ2g/9us63+2zUpc9IeMmx3JbL07GwKRH00rgJjjgOtLv3+/Cg9RoKW0254DViYpoW+4jMrsnggRbTYGg/h6u3r8MkskU3LT+3lMFtg5vBdRy7Ci+VvqNHSSDf3no15EdXHOiMJPlJzXkRiC2pKV5DUajT1odILN03cZK7SiSfC/sLHDbHYaaDDbv0b+dnFPRlJCqqOt981C3xZB1s0Os2kyXwbuI9wSK137XGuaQUNxrCxUa9GT+IESFOPS3d6Bg4M/bn/4ebD5SIUuVO0/p1PKuSjUN3HXxqWkTAtC/sIB6Dl4NELHXqXVfr+uV5FfDfUR233Za2WCqA4ClQPoqVOSy6dhhQGlwq3EhVIT0Y2kOLSTgO/6pncg3j16JJVraBpD2IJNuN/254fabDUFN+gCpzRzKQR4bnwSN9A8icyceJE2IOF;4:BTfjz2g09lTYk1MrDKkuGky4xv8oEcg57QR0b2RahbfwhEizsYarHzgm3qQJ1NFPQRb18rhOK8fQ3whnownIEgcGba+Vq1xwhpVvkn2IVXVm1JjOkocG6eNEQm2Ok53OxkbFT52GNxIUnwli3bzdJUd5gvIWDTLHfZd6OFt3mYjHPokR2y47RzMu7/plFwCPthgDAZIhVcD+NaWdrg/vZZu+mJuHEhg12ej+k7dmOAR97n6m99UtonfGYYmqQvmpoKuvxm7RPJuTNbhu4TEHUA==
X-Microsoft-Antispam-PRVS: <VI1PR04MB430148A71E01D67BCA2058BFEE260@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39850400004)(376002)(396003)(346002)(366004)(136003)(199004)(189003)(66066001)(7736002)(47776003)(6512007)(81166006)(68736007)(81156014)(25786009)(8676002)(6666003)(110136005)(54906003)(36756003)(5024004)(305945005)(6306002)(106356001)(105586002)(53936002)(50466002)(6486002)(97736004)(48376002)(86362001)(4326008)(966005)(3846002)(5660300001)(26005)(486006)(16526019)(186003)(316002)(2906002)(16586007)(6116002)(6506007)(44832011)(478600001)(8936002)(956004)(2616005)(50226002)(386003)(476003)(51416003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:hjxDHEsOpyYT7ZK3Wx0n3ntzhinmF9jHcUXFdJEs9?=
 =?us-ascii?Q?4wvyQopULzSpbrjW/Ahd60JmABUUkTibSXbtXdQQXJCD7a/MQ14LEg2i3Uai?=
 =?us-ascii?Q?yZGDDcoui+zuldrHel3/OXW/xO0NIAXAOEzC7qlU38CX6LhONvpVJDQwUVTk?=
 =?us-ascii?Q?bpoTvO5jgIgLAiqRTCaa1VS/u/7Yc7JblqzE2YIpfw1XTo7RylR6fQMECCE1?=
 =?us-ascii?Q?pQ6Zl1oKvF/B91dCGKaaCASIpr8VUh69ZBVftKOHoxJl468RiTcjBqoblX+j?=
 =?us-ascii?Q?g2WqZNKx87ZzoatSgzNmVqddBl/ECccjspaieEhQ0fO4jCQEx/qOf1eN+TyE?=
 =?us-ascii?Q?U0FcrLyJDnjmgROjnbA55GcNYeIt3TCbCmPACAf3Rq2hQfkphLLnE2Q8zGjl?=
 =?us-ascii?Q?32sve99NpHK/DmxofgHvYmsanRdOmokioWgKV20TZ0PM8/zGH32vwKutLmKE?=
 =?us-ascii?Q?sl3LoKx8OK3y7lztZ/53c1nyhPbkH9Xc9KtF5BBFlAKUaq67pnCDP33QSjfd?=
 =?us-ascii?Q?/GOWrDC8oaMuUgrfUxCAKSRNrQjdsEJshrWSbg65VgKkwmPbZxWi+2+hqNOQ?=
 =?us-ascii?Q?uTPghclEK8c9R5VLMeTyZpWLgM+Fc9tVZZPXfR6O6H+J/7aMne0Nxulc9fnB?=
 =?us-ascii?Q?xCAifV3isnYxu4ApkKx/NxiyX372iOuBk+UqeWSnh6Tr2XC6Tv+92x8eKaCu?=
 =?us-ascii?Q?qPf99zsBp5waFyR2/dNvVDZsEw1ds51IworMv1FdEQcYE55vKsoZYmWC+Jwq?=
 =?us-ascii?Q?tGyA7Nj2JSYGnYM9nxInuwhxx7tiX0RNnwVGEKWOyvKA48Hk7Fsob2hRrKJy?=
 =?us-ascii?Q?7g/Qj1cXnsRKf2JVMU/6SJ4VtBq3/dDoXbbegKudU+6UV74YHRtFr3Hd0EPr?=
 =?us-ascii?Q?br5kmBeikzn1QALLHDklf/N/Chh/DXpzRWstgU9QxqTXoeRFj5y/AcYKJrnK?=
 =?us-ascii?Q?hP4x4Y7reVAtHxe+OXenEpz0pspNpPvP9oOZvhq9WwwNNiAEsrkWyKqrac1G?=
 =?us-ascii?Q?o33afFixYydmp1VndlnKPmu6ZCc7+bxF6ddBlCVWEIyF+jKLjDO49Qof/0C9?=
 =?us-ascii?Q?63m3GUoXwPejcSsxqt9ryKNIhsH8oVk3artVZYiN4RvRiSTNhk4S2yClEvz2?=
 =?us-ascii?Q?fObS9ueb28G6mwEvBkc7hJnWlFmirNji1naAHngBXDS/88L3BHsKriLeGLxW?=
 =?us-ascii?Q?ZbxpjVMniB+svHPKkODa/VMGsu2mOaILxrItmYNWytOS/iS0WJ9FTZj7w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: l3RvoweIbK71MVhSi8T3xXmi6OoU1cM131uiFIeTR+Wt9QzX5obALXWlLLVb7UpJnRdg/LjmoW44cYLPjfh67+62OdfDMsW43MOSL1jf3zrGL31qsWvQdel7iWEoBEl+cXGrDDeTOOLAmqM5LFRVPsQsLCIM+Y1+Pcin5ewDKfJnrkjfU2ZzjCzmFwPE5GxfHfhe63s4lqx2J8ahb+ttS/tpuFvN+9RbfJUi05D637f7PiEoBHVTH8peSwFFuBgtSLpTZuPIFD0i626j6URFLs0RWJu0pxdUZjc6oHUROZUxbjSantlkPsz5iSOCj4x3YSSeTKHAjmEZTGJWVFcjOXpRAYFbQ1Glh9rROc+7TWo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:LW8ty9SbmQEsTG+LSfj5RYDUCLHcLTtoqI60KZfnVzhxse5uQZX5N2CiVOn51S2wJxX0a96BYnCw6MsI5wPCRDUKayPOj8AVD+oVZHxVUc9hF1javKiO83nab0RVv7tm8189d7L1LdlnAy5Cx6kfwovj2TegYHhF9B4zKS5i1DAs6aEcamCb8vhvfWsEIM7bfvyIsb3VU5gMip0K5AwGjwXpawLm46QOIryEGOJe4mdTe48BIxXbPEXJoc8WKKrQZXfDGtTP9OCUQo1y3D57qt4d1WzO7aGgoGEExLPGfIcAeUqJzkGsPckSccBnO+hz8EzuhUKVDeoFx2pLfQWtBmJgC+bbkagQpkXRAfCIoTXSQtzKJjenk2SSPUyMcg8x9EDM0+4mXK9RaP2MTdOf97wP9jdr5QpYoiGGlvLk38GRe0MzFLUDpZdPG27fYMnFbXF8U5rTTpgiX6HwZ3gSHA==;5:DLavz0ALdA0UVptIBJ9yjMMvUgdsj6x2MlVOAW9mdAS8JCK4ONSeVxHyS/z6uWhWdqzBtTd1KhOF8Yh+kvwZdtvaNEgH8jXHfZDivuHrfwtxp+EVu8i+ebB02NHAa0cQxWKbe1+cSuuK21tzAA+/YYRcKtSnX8TTLXI8MtBiJzU=;7:trJhKxuvOp/7io8xhsdYSA5QJSMSuckHeT/ieNZXOoTAo0iPhfNEVn0WOf0gkk3CjGYipM0seDFL+6+boh3ZrWDqeMdA/BHbdyaP11rmi9ltz4iGCHF+tHXFHTFZAfM2maiUoqB/ttiZh9LgZqab30mJ9gpkHR6fn4tT4/lnCfa0vsoeQo8SHiWl05aJu1Hg3w+hr6Sz8cQIFvkdDCI8B/a7H4P6o43bS4hbkwYWyNyY79ArbIWrgutxzQupk+Qp
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 16:09:26.7793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce8921f-ac90-4693-3004-08d5fd495148
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding lcdif nodes to a power domain currently does work, it results in
black/corrupted screens or hangs. While the driver does enable runtime
pm it does not deal correctly with the block being unpowered.

Changes since v3:
 * Don't set initial fb in mode_set_nofb, do it in crtc_enable
 * Simplify AXI clk handling to allow setting fb in crtc_enable
 * No functional changes

Last 3 patches are identical to v3 with review tags attached.

Link to v3: https://lkml.org/lkml/2018/8/6/728

Leonard Crestez (5):
  drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
  drm/mxsfb: Fix initial corrupt frame when activating display
  drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
  drm/mxsfb: Add PM_SLEEP support
  drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm

 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 53 +++++++++++++++++++-----------
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 40 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 19 deletions(-)

-- 
2.17.1

