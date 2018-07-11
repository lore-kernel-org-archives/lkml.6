Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EC4C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4212077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tTWFOMQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4212077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbeGKMRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:17:21 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:14816
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbeGKMRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOYoAna5aLv2L6x53IUKu5QC94NMPQcMrX8EH4BCR4s=;
 b=tTWFOMQfInnNstQ0St96qIK4AYkx43tswTLRQm4qa7ZgP8c0uRnvkOYshLA6Y/zH9cInqrh3ixF85WLiQ3hYS9xcnqdTP/G4rIxGh9HlW80ZSgk+jKlxtDW5+UdtFgrk9I0z1lR8mDAjdghtxav/jC1vtaUGkaoA2prz8m0oxdo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4295.eurprd04.prod.outlook.com (2603:10a6:209:4f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 12:11:31 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH v3 0/2] Fix imx6sl display power domain
Date:   Wed, 11 Jul 2018 15:11:15 +0300
Message-Id: <cover.1531310547.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM4PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:200:89::27) To AM6PR04MB4295.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 928b82c0-104a-447a-8316-08d5e72770ab
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4295;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;3:o7DP9oQ5Nc39bdtCGkZNXKDnxLmr/18KFy/9vB2Zx9sZ6RbrdgSHWeBjn3uKEWs5t4gZfbx3MWjK3oSP9R3OgGAV9+VA6LHWghGk/hdJZFr9YwmWptcHM6moqppf0LLD6I7ZJxXZTKuM9qEWYn8W37tLRGir7M/tgF588ctIlUN8R10Z2gXJgQodl0xSFssxyQfnHYw3kPTRgRL6M8z3s4jgoucnlhmAANng8TVKFQ7WP5WsNjLp08iK4zLref8v;25:nY8zDH1dMfPK77KIrtbUbDwQZYQDPlLUtqQV0Wlq/Rt3ZXeaU6EhobEiuxyj9C13xzV7dIy/pabzVFttZKUIWt47uNqkWYJ2zPkM78QIsgtuyr11QbnCXcL82FJBSz99qypB8PScsHyygDH3d1U2jBo0K0VVh73frBtPYC9Eeb8UPxY5LiyITiObT7DgBu0tpBWI6VXPUSwjFIfcMFbgNwly6JkG4+qtY03+fvMPx0aINYVaIFucz0DpoJECXPb2nzxXCf5EqW9OQsHjN+6nq2XlVHJ1/HOQyOLK2jp1opBsmkL96R70eprTZXBrQ2UmOmlRlNMUyXePk8z/6Nb/+g==;31:R2o+eYYLGuz5yrjt9J+bGyFOR8bkmi147MQGRPymb4Eoi0yWcHdbxbZLxJKEkjDnVhX/u+Fsjhcksxmfb1mimfgyPZAneA0Ld85uri04DeTouZpAAWfuj7+1dAF0KS+T0ZlW4rP2g//f29M/P6WLpBf5IJUYV6tfX/j0+t3dlUXAsH+r0QW1mMb7SVced+d6nldlpVvxqfQ2D++jycmk6Q3RBhqy4bwhevXUS6I3MFQ=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4295:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;20:WQP7c9hZsaKTAyBBWBtp3ljRIbA5CPXD7xfvhaHj5QFgGRyad7UZrMuZjnPzorVScYIBjngKV/mmWpCIIghiGPCWDbKBuNa7dlLVUtr+pu6ZK9YNIGAccMo0arXuFwaxxxvIRKHuWWkG2bNImCq708d7bF/qxlyBC0QBQKW00GbxwCkusGvN1vykuza1V7ipjQd/ISa1JxCo4E9Ycm1Y21jkeJpNkqTcGm7Tpt/wFaRs9wEpuaF5bvTwh8TuZNxw9f38Sjch+hE5dosEox/AL9/pnHicefge01//5rOy0n8Q/ZzHF55ZTXubkpMTJBoBR+VsfemkT74BcA8X15i18YCZExb7lQmidAvr/R/Tuqg0czf07xQ49XoKQRFR8piRD8m6RvPGfNZRwRWkkpLx3la09D1K/OnhFU2pj+HnPOTjl8S7MsRmdkB/IoEtWdnNrjO6ziJz4pWpuJPu+p8GFzd/aPEDjLkEd3bbMbUgi/e5Pl557+kKGtVtL6aGIEFR;4:aCZaF3MPr+YJFVfU9zNk0EId6z6o9Rv7lZ2Ret6aCJpD2EPcDfJfpEE4e/67rLSQY5D3SqVPEtSx4pGXKwd4HYhwFPmsYUTvJzQFBvj7CVC2AsNUP9DMcoAvhKpQHE2j+vj0GB6dtjaJmtnuZgE0tfFUIChZoRr/0Oc4aPZ1HMJ+FUqxuapjCa9OQ5i5xoK2SWHMFXkygOOwDMBPe/JqKXfBm1FtYj2MRohVcMCL/uZgLc2rChZRhYbA2DkrSMODcQSfN8r7FJlo99KcDzGVlg==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4295C171B17692DC88AEEA67EE5A0@AM6PR04MB4295.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4295;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4295;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(316002)(186003)(50466002)(16526019)(6666003)(26005)(105586002)(53936002)(86362001)(4326008)(25786009)(110136005)(51416003)(6506007)(16586007)(386003)(6116002)(52116002)(97736004)(3846002)(48376002)(7736002)(47776003)(44832011)(2906002)(956004)(2616005)(36756003)(6306002)(6512007)(486006)(476003)(966005)(6486002)(478600001)(68736007)(8936002)(305945005)(106356001)(5660300001)(50226002)(8676002)(66066001)(81156014)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4295;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4295;23:gUlEcqhbNxqh6UfC/h3XM6eG8fIvotXJwMVh3u/6E?=
 =?us-ascii?Q?RdUIztwJR7TpUHm1sva8scmHZTuIfSjIQY/OeB91wRSjCEP59+cGSuqJWj+S?=
 =?us-ascii?Q?kBrFlIdb6aU6gdRR/L89nqzc4r+dOtJUFsH29Hrvb1GFxwqYSgWVsTTz5mcf?=
 =?us-ascii?Q?SsFyc3yXsPjPjn04nI/3lEwYE8kB0pRofJhx/EO5zCEFNETV3io2R9Y2uxTX?=
 =?us-ascii?Q?Qc8JypB3zK4JpKPqPHff0ZfdjNHbz+rqKtQRAGzDNaePnfQNXVjjehTo4N9+?=
 =?us-ascii?Q?CiKEYKdLVKH7+MTmCUaLkHIzzYacyZks390XbjwXA4st/XAK6Aj9QlPtJWsY?=
 =?us-ascii?Q?x0UFkOWEKcGNe9DgWB/cIDglK0tIU9ZlsJJRlHlwl8VVoJccmhOpClFxqDm2?=
 =?us-ascii?Q?Kp2dLE039b/F4zXvdajRbgq508aylihRl00Er7RDaHH0oD5CZ3s8RPKiufAD?=
 =?us-ascii?Q?V+lctnY/sU+6fxJ0qw7g9FVcoW9zQ1pyvh9ElPWiWKJZWc7uej9oG9P7BtLS?=
 =?us-ascii?Q?7wteGJ5uabcnq0BX97Saw0LZxS/0WR8aAWaPV3hRPPGvdL+CPgibvl1lKhft?=
 =?us-ascii?Q?bYQwsZpYCTbCM1pQvi5i9I/znODpDec3/8eL9oditgA/2VmsoMlqWPyQnp72?=
 =?us-ascii?Q?BLAjDpf5GfWwyQPC7hGxF6XopqarxdFnq8sOZXkkhJ6MSVYVHGnlbvwV0XwT?=
 =?us-ascii?Q?neeCvCw0k2lYRvKxKXriveI33gOeihZVOtgqLpb+vHYF3szGUbk8IPZ2WZeZ?=
 =?us-ascii?Q?m/E+8BScQDVCMNqs8M+5CbDmympDzcq/FnYP6rN9lKIX/nr/nQMgB0XLPtkB?=
 =?us-ascii?Q?oe1XQfdjpiBvUCdfkqyblVK/SNQ9Hc6fEOE5g4AC23ntZERsRqgqO9qjUrMk?=
 =?us-ascii?Q?Vr2IhKw16iMofd1+wqOVy1hHgWavCoUSMjhxc/Pj7B25kUxfwr8VPMalfLdA?=
 =?us-ascii?Q?3Cr4AjhyFbmUfcWn5wrZmYh3edpCFyusfJxPzK9q+B16JwKNEGJGRf5HXTDR?=
 =?us-ascii?Q?ktU2WkyD0Tfa84nXbHXqCkjm1wc9pHYImY4usE9LuXR7gG5fDDNlQ/YrNYel?=
 =?us-ascii?Q?Xh2zEbtOTZIO+CpD61lOtVhzNY6hgOSxgFjnCt140TNzxleFa+OMdIceZzAL?=
 =?us-ascii?Q?PLWIdTe399K4QHZ9Ah6IL9aykldrwCjk2keyu+SHgj0is5QG48SOKKZbkhJJ?=
 =?us-ascii?Q?ZvmQJLuDpCVCLcLKU1HpDknopEFFVG+xe4+?=
X-Microsoft-Antispam-Message-Info: /pGofawh8NA77gVhSyGhIpyz2+x9NPkcEJGtV9ZEqsb+E5o0DthXvyrp2E8HKigjfVi1Adop3FPKKV7WJbcLRdUHnK1YunHj3K48nnnyfTY6gGc3VaA2WtENTHAkV1Ikwsv4mfYS6dzGA/Tsc5M8aWwdde63oV6BUELWnwTgjRsjZp+F9o+1TxRcbISUm4ydt6D3Qeilnkd8Rg0d/VUSo3WV7hANCB+l1Xm/tXUOyaM4ovkAS7S8FULHsIV5+R5PhBNkxTDanqvueGEWOg36ZY2fpbvDdEXD67LwF3JN8SUP1b9QgAY6fzFFD+xCEtgZ8qX1rvh3ZhlKujwH7ooXn1Vl0XZRLr4mjBqPiWMjKtA=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;6:SXLyxT+z9uXIHXhTPoApZbq9DCoKTJhd8bJ0rFQ+qP+kAGlydJloql/Aw4RY+oPqSxFPJaHMLosxpupYpBN8/wWNCOld6Mh60RaRvASa0k1G5haFN3750bZMXMyjk11ss6/Caw6uyb+BqOdJ0tTopBeGqb9hfn/giI4D0ORukG9ZW9YPjDQSv8sZeN3tekhORwsvhi/3V+A0VHV5vfNE5UnTNn4awZ4JB7akin0Am1+o70Gp9AM2ub+86+u4WPuahYBO6UX4Lzp+fb+FAVAE+cXR4jZPns1gGH1ofxOmH1sDkdNp+iB3HxZ1xcrLP/djWd7AJ0sKlYUVu/B0tlJSGB4Rj3yWTG7GY7aZv0jxJzLE3J+zupfRy+vVD54UUbyp0BBriw+RKOGWykDSwAicd/WedUi1S/m44UBHA67stHhygcgk1HT3KCO1YtvD7Nbt11oMZt/DdNdZr/S4tgflBg==;5:UWiGFmfAPcENQEUm47f7N5RV6fEZRkxUb8N5qAyyHqLwBg6JmqD0vIRXbOg1gE5xxds0MTHjsE7yA8G6vgi/FG6BCCaBGQgZhlvyL0n9GbLru6lsRMGfCvo44zJaRjTvYMTQlUZEhsO+ONfqBFPC+V7sX6fEn+15Y5sRUqyeYlQ=;24:qOYPaK1P/w30aqe5zdyns+EAmolXVT9IbYaa2ivSU272PMf40epnNNw5PuPeJZkhgTcUR122X9kdgrvp2eFAGxpGk4tVl4pDZ30qOHHKuhw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;7:CjED2QY/lt/J7sanYodAlyRUH5r/XP1sP31q66AJdRbiYxmcThOomY+xdEUXQ2G2MVp1qfjQArulIYss+X5OKt6NBQ7bcq3U0l7lQTsWmtNTIlimz57JNZSGGY31crfgf4jAYnCMyTZgIRyi/NBtskpc92AocxQBLqKm93/eYt9pvckpNtjOB5RWqtTru7Wg4Z8w/8dj7LBw0OVtlv/nrKR1zchmI1PQJL3rwDv5cDj/Sp0DoShOBjupAFIgmWc1
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 12:11:31.8099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 928b82c0-104a-447a-8316-08d5e72770ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
 * Don't mistakenly include IMX6SL_CLK_IPG in pd_disp
 * Use GENPD_FLAG_ALWAYS_ON, as suggested by Ulf

Errata workaround could be refined later, however the power savings are
small and it would require a lot of testing. So push the safest fix
first to get basic hardware support.

Link to v2: https://lkml.org/lkml/2018/7/9/447

Leonard Crestez (2):
  soc: imx: gpc: Disable 6sl display power gating for ERR006287
  ARM: dts: imx6sl: Convert gpc to new bindings

 arch/arm/boot/dts/imx6sl.dtsi | 35 +++++++++++++++++++++++++++++++----
 drivers/soc/imx/gpc.c         | 10 ++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.17.1

