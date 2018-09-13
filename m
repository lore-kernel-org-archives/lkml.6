Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2328EC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA93420882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ICw/Yyup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA93420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbeINN4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:56:47 -0400
Received: from mail-db5eur01on0060.outbound.protection.outlook.com ([104.47.2.60]:11232
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeINN4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wnjIXa3cREPnaxha3ldsErork7cZy5Ebu7KT45YFaQ=;
 b=ICw/YyupcJLe8jJ6oTgoFqDjZ9t3YhLvb9+NgnVQoLFdmkKYRfG8wTDwszRAHgf5bON6K6MJdFw/hfHBRQVgHWI51dJ+1z1Uq7tHkyjQmwE5Md7Pa6eD+EqFXvh4B8pkb+5zZDcSd+0S9ZOZOmGWj0cIOPctLiwzOHpGMuVxGlg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:53::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.19; Fri, 14 Sep 2018 08:43:09 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     sudeep.holla@arm.com, oss@buserror.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Tang Yuantian <andy.tang@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v2 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Date:   Fri, 14 Sep 2018 02:07:53 +0530
Message-Id: <1536871075-3732-4-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
References: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::23) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 620c298c-270b-4dc6-3781-08d61a1e1c3e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4800;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;3:jXXIc3sDvvNi+vCzd0X5LCe7GC0QAj0BZ06SKJgPg5f9f573sXDthxsNNtOM+mX+/wRS0KUUjWbeInSVUUTtWNYurI3/z7K1uEbFhQF7pMx3+zQTmzErRjq6CMqOF96Ql+Z7slwRU+KQCYvjzOxLH7c5xP5aQx3NWIBm0KBgYyRGnmg3xhJpOyQdzYWwdgRuu+XxUQSnmeS/KxLDtVPSol9wyCEdS4nu59AbaPVnuU+adLJhsBtqdmGqbispOwJf;25:lP9h/K///GgxDFBGLil5/Lap5m38wV6hAD38hMHC6M8VNs+nsbrEYhRSTIb4PuvXgx9OWpq+qpK3PnirB4RaxCQ9uaeAf6VUivGppLNSEuTrdkQdBIvFhub9Lk2SB3X+ChIMja6TfWam6AQFxiCXI4jKeRfsCheawn75xFRqWcTuB0wdpiCiwRhPJAGxuEhZ0L/qJixdU3scUx3/+y/gC/L9pqrc83jZp7n2+1mXMeK72ceMwdqRp2fl29756ER7fajT42fYhVz1jqMfsR6CiKZuVD8hJmUi8GdduBYl7BOwO0KAAv2Nz4rDyCoa589jH/JvIjZRy2wXkN2CMNdfFg==;31:v7iFA6Xrquxj0Lv6YTdz9FEqhi5Zs1uYlfLgRkQy8W9eMe9UvwaWqfRSUJIm7i1jYt6cZJ/a7hsH8PvsSngQKgDWKLRAWMoYRgxnUVRUqEVEVi336vNbnoXGUohCr0uqgxi1gRhgsfo5uQpgwvMokQW/k46nzZfiZGUwmSWl8D3DRxEE+ERO0oOF2WECG9btUT0l3j+a2ilL3TriAkhO2fNwv20PyPNo5lato7y/phk=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4800:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;20:flyz22dJzwD3zNCgN4/cK9474x5Tf3qAl1KPL/T1aGrQs2spWoW3NHDuNk8hwa8l9eKO1S8aKNOYACSKLSHaCiSihXi/oh9YnWKWIz3cO8NSduP4vXw9D3CqFl5gMNYuqkrA9m4Rp6yofjvSW6tYVHRifZNPXMAogBAwcipZe+o/6kAn6cw1v9D5Jqqek/hHL4cLt/HB6EkjwmpcFB9baeQhWjLWAy3FmDjBoMwdrZL4Pzfz+e7RHvSPirsEHZYDuOj4rxAhZDDmECh820qss5dplxdEwglRvwf1HRUixFNucTmKVdJMwXezBU/lJMq6qbxq4BHjcUDISJwkk8kNreclrqvp/rKgarQBdBEqkXModB9OTzv24SYxpqGUjHN2axJ9/EnkPjI0e88kbdRgnS3IZz2C6l/rYgrZ6QFXgkaBW1ouciAsXviFswrTY5oO5ri2M9TMRtEk9mEJmxxqENi2Qrae3Gorjg4ivLMjID+naQOHZlac4ZB8Wp6JC6au;4:WdPuHSzn4g7BsH8AvAYnCIZAeSZ18smWz7CfpDbUd2esWFaDWbAqS9jaEMufkuTSk5UvYZlmB6g92jrgpUEQsOFGcrBzvULxYWUR56CsLPmq134xVhEQAlegBahGrTRr0tZe2cI0rkJpntk7VzBp3iKdy5iCuIgr84tQdVxX5tvjtRTvEdJ3b8Qn5Hn4ESuQDgYMkduimd9t1vXX4YtK1XYJlBRvI4DwvWeYUIBPFgkfZVrTHnuNY7VvANvkVUXW7K4HyjzNzbOiv/m2RWjv3af5xppCs6FHbMy7DxqXmSoeaB2dznxDDoG2NBYrvO4/
X-Microsoft-Antispam-PRVS: <VI1PR04MB480081118C3547F1AC2A3BCBF3190@VI1PR04MB4800.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:VI1PR04MB4800;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4800;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(7416002)(305945005)(7736002)(51416003)(2906002)(76176011)(4326008)(25786009)(36756003)(14444005)(68736007)(52116002)(54906003)(478600001)(47776003)(81156014)(81166006)(8936002)(6506007)(386003)(55236004)(6486002)(50226002)(5009440100003)(86362001)(66066001)(6512007)(16526019)(105586002)(2616005)(956004)(11346002)(186003)(486006)(476003)(6666003)(44832011)(16586007)(8676002)(316002)(6116002)(3846002)(53936002)(106356001)(48376002)(446003)(26005)(50466002)(97736004)(5660300001)(110426005)(921003)(21314002)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4800;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4800;23:44mXU3y8FfND3sZNt73ZXMf0edazrclL3vHr6RT8i?=
 =?us-ascii?Q?f2XOK78X/xNBUK0IrVQMWXSmw+n9r1NWEwnVdE3cfsg2I+bUd/uRAMHpNdkC?=
 =?us-ascii?Q?IZs7z/y/B/0EGHdzuOL6jS047kVTvAK0u2UAfr+eQ2MhZXREy90YShHRufvE?=
 =?us-ascii?Q?GGSANQT9J9pC6yCuQgwk46KDVYJFd21/pXXG63otfZ1YLqcxaVUtONRDzSNd?=
 =?us-ascii?Q?ZegvWbuWTGeViYmImP5MRjXmVH8zMaF+GUjmII6/VZE2bz6tVFVq1OuINHA0?=
 =?us-ascii?Q?F0vFM8ydQsr7gX95Q2CTcN8ySymqhDiTYk0/FZrUPAY1uSB2ZzPBqENw99tg?=
 =?us-ascii?Q?YdTuAmfGiSnZSiR/zj0TNMisr0JdBRsOH82m7U3WHN6MDV7ojHXm6c5idDWD?=
 =?us-ascii?Q?ICSHamkCTBXrsTI8FR7Z7+Lsb5MKOvs0kQprtVKkfjffZL7eA9v05Xy2BZHe?=
 =?us-ascii?Q?F3gsEAYThfo20AUurhKCPAG5fdvafUTDQmjguzPjzi0/eErr3dxsMd+xmoCt?=
 =?us-ascii?Q?f37lx91J4Fx8mJwjxx1k14BpUiG/Q6PH2q6GHRReHp7u9qgoO1HYaicZyhHc?=
 =?us-ascii?Q?LSP5NzMhSFAj1HCZuJRk+mUhJkWy2UlVbIOsq5r7mDzIQJegAja8HB4H8Ei9?=
 =?us-ascii?Q?q9aJr8Fc+7+VeHFnx4FS1RyXHwwr1w4oInN50gpfOokF9SFfE4FnQ0YdyAg4?=
 =?us-ascii?Q?dTKL1aVstfTnDwRV7g6HRXun9oFCKPhUAofTKcpep746xQmuHVeAFkzyySIo?=
 =?us-ascii?Q?OGq8ecN0h3v/w5pKFIyGLOeVqm0fB8s5BREa28VJ0gJgcjRqMGpwR/93IHQf?=
 =?us-ascii?Q?q6UfqES2l1EuYhRBpayp2xYoz2cvfyIF+IAtM5g1pc9D9edPQCgfqhUCx6FR?=
 =?us-ascii?Q?3LCpIvZECJ3L8z43bHhhSHVyto53Onub4fn1esE2ev+yDmGtnOTSrOb1kQ5O?=
 =?us-ascii?Q?I+sSGqubSrx1/mavkStBTLRykp36tsF2vLOz/h/FQczv6NbzUnuZQEV1tdN2?=
 =?us-ascii?Q?gpGewCXIjaEfVpPoAsGP36DG5h/qsZqbebocUBKab4kxoTv07zOQwxVFoMcL?=
 =?us-ascii?Q?mK3ZtufEx/eunTlL/8Tvcp/L9GUYjOvWslZv8+CxOpl5jhAI44Av2J+DYsLA?=
 =?us-ascii?Q?DlRkuV13Re7Qzx7WZPN3RNufLjC3N+0EoyxeD3+3NOfyc04PXpAyb0jdVkF1?=
 =?us-ascii?Q?mmDDJn1HFGxf036/4tBuMKCs+SXqdAQ9fHu/ImVUDopz7P6Qyur/c3DsmnPk?=
 =?us-ascii?Q?jdgOO9xtpNiWn3HhkZ1mXwhD147a30ezq+iEnKbOpOt/ynCnEySmE5PeR/8t?=
 =?us-ascii?Q?WloPCKmNkkqxcIHx2zk++FUIxA3Hz75KjCWMFd1AvlodH2wCW+vrroVNBORy?=
 =?us-ascii?Q?YjW/g=3D=3D?=
X-Microsoft-Antispam-Message-Info: m/tGgNv7T5ZTy7s+iC0RptYFZ/g8g6sD0emHufKMsPcssmTYHm7H8eRNQ3r/tEjbrwTNDwfBmEwqr40Z9HKdXI4YwQpN7ZJJOSF+9aue/L/3lMhCVrMTjL9ziJWMvKYtGiLccRsllYR0QPQpfrFigGH6oxxFGYAchdLzp8FZ5JoP2rWi4HqmJGtl05SRXXAaF3UptgsgMm7JxWspU6Hz2haRNiMaSVA82JhQulYyasuQ6t0+L3CFwN42appDg1Qwi3yybMsGlU9+bQrgzMIFjs0f++l6TAyOiVasG5iQmFMUIDc4NUrEtxFwn5LA/4sc3RWgp7ic0zX2vfgtjwx56DrlLlLsHwUJpoFllAIZsdI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;6:cNlxQHhwvJDxuYZs+hr9sTSiVMNKIwbFkKDPlTJmoOjh7JxrqR7VsoPoRzowC85rjXcK8le6evQh5ooCMy4gzZ1NSTV+aUedpTnpxkMw8VzbX0+dhdVO8STKqIKMiKbPeINfySeLkCULkgpJi9l2BPTz9LPn58++xIxMlXsfvzeEitlwpBx+B7r6gcrf6QUCy3WWp0diXZPKOHNM0LdD7VxoiWtBN3KH7lulH+Pa9udkJcwXAClArSSJlmfPZfRfJ6YZVojYII/yHXmO4TMqD+yGdEkKKTgCETO2RYPzwCK/rlA2A2MA/tzWA1SERgQsPZjq8IhezVEK8TX16f7KUVItlf8Qp8rFm01YWNcsczR5nadoX3wib0exmMdrQkO9He3deQQ+gcm626ZJF1r/6jwr/oZHHIlPbXDf9EesRK0AtJjlY9OysG9+wgsoG44b8ODTyEXqZm869VPUIWGwHA==;5:x9sIm0ZwA8ir1HTzMCPbCYRolxxNOZOf6P3ZVOgBtxHcQ3gydBE9X1iS86nLewQhtpkA0R/PCtcZ32YYyQL5HS7wH2CPExKNrErowfXx94FGFj0RSgaYFyV9En/smIWsUrOK5uSS920ODi9YexelrlQVDo9LF+9uFRyG5mj0R/U=;7:NAqfqOZFydxoLcBPREhOaPIvWf+LsvhAO2NFOFBW+FhRcXiUhr5EmPVu9gEpy3tLjQIVb4iboyr38RNQ+jBdXOs+hxrb8Y7PxFsRT23MtRoRkEehcHx2OtHmybyB4JEjbYUxQ40za2zHz7Y0AD2axIojgQPKh1wcVnD2OR4g9lwSpwwU+7ySUnyqUUXA0PlsfYo+K9AqtQOw8sGfjChH5ufd4xHT+wU1qvLGx212XvneHuM74DOF4i5ibOj58q4O
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 08:43:09.6599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620c298c-270b-4dc6-3781-08d61a1e1c3e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Add clockgen support for lx2160a.
Added entry for compat 'fsl,lx2160a-clockgen'.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-qoriq.c         | 14 +++++++++++++-
 drivers/cpufreq/qoriq-cpufreq.c |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..e9ae70b 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -79,7 +79,7 @@ struct clockgen_chipinfo {
 	const struct clockgen_muxinfo *cmux_groups[2];
 	const struct clockgen_muxinfo *hwaccel[NUM_HWACCEL];
 	void (*init_periph)(struct clockgen *cg);
-	int cmux_to_group[NUM_CMUX]; /* -1 terminates if fewer than NUM_CMUX */
+	int cmux_to_group[NUM_CMUX+1]; /* -1 terminate if fewer to NUM_CMUX+1 */
 	u32 pll_mask;	/* 1 << n bit set if PLL n is valid */
 	u32 flags;	/* CG_xxx */
 };
@@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
 	},
 	{
+		.compat = "fsl,lx2160a-clockgen",
+		.cmux_groups = {
+			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
+		},
+		.cmux_to_group = {
+			0, 0, 0, 0, 1, 1, 1, 1, -1
+		},
+		.pll_mask = 0x37,
+		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat = "fsl,p2041-clockgen",
 		.guts_compat = "fsl,qoriq-device-config-1.0",
 		.init_periph = p2041_init_periph,
@@ -1424,6 +1435,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_init);
 
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3d773f6..83921b7 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initconst = {
 	{ .compatible = "fsl,ls1046a-clockgen", },
 	{ .compatible = "fsl,ls1088a-clockgen", },
 	{ .compatible = "fsl,ls2080a-clockgen", },
+	{ .compatible = "fsl,lx2160a-clockgen", },
 	{ .compatible = "fsl,p4080-clockgen", },
 	{ .compatible = "fsl,qoriq-clockgen-1.0", },
 	{ .compatible = "fsl,qoriq-clockgen-2.0", },
-- 
2.7.4

