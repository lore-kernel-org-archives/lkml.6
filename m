Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE13C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16671208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h+zPrCFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16671208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731689AbeIXSQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:16:27 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:49822
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731803AbeIXSQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENZf9WlZ9JcmInlc9Gwfp+dVJ9b/6YqEJuylq7nmdis=;
 b=h+zPrCFHgHiVXSGCLC8ZTqTaVOea0DD5Q8MfY3B+drXIkPRYq0RtC2LU8nOHVSqNqa/pLJnf5yh5fwKySTqkO0kn3p/Z+1pQ6EQ+tKk+3YUVjpfnPUuuZoOOSz+cJnX6r+SKoDsRmGDWl7tbGhJC8mQ6mXg8XjK6UqqJ83yO6JQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4798.eurprd04.prod.outlook.com (2603:10a6:803:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 12:14:27 +0000
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
Subject: [PATCH v3 4/6] drivers: clk-qoriq: Add clockgen support for lx2160a
Date:   Mon, 24 Sep 2018 05:38:59 +0530
Message-Id: <1537747741-6245-5-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::21) To VI1PR04MB4798.eurprd04.prod.outlook.com
 (2603:10a6:803:53::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc7a5141-5ccd-4f9b-6c23-08d6221748d2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4798;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;3:U+mxarV0zakVBtJaqnhk426VgjVPKjMgvqBT4bkR7e756p6iIEjMolr/GRL4dxTu81/gJOozgpBX2D05mE+SdpBVgMOYn7mLM2N+NaG/5XajZYOOod3AgZZ/TMWBlt++j3GhXLFrepZMhDv+MPqe4KcAskvrvGk84e2qNT6YeSuPfAXZnZg08hWG4RFoOqlWChMprvTUlXisJH0lzMXfuzgSsfsRoAzQxhbAXA1eMDR64Hl7K1GJTpiyjeqv1SJY;25:vw/N0KcAhqrHjWlzBGk39RbliL7KzH58p+uz/XLXmIamZ6diSd+9K+xNYwxvAd6Dta4fHIObmveSQG5iZFW0LZlfnbPBoce1e+4N4p1IM1UrBUouyPq+4degFXns5CHVTo+MEtFwjpbfJqLEHvji2vbs1KGnLYOfTrBdv4KqYDjgnD5eMXIffsWY60oPOYtYLAK4wVOWeezYwjJkMgj0WnzqhK2jsiVUt6hUIeMMY/ZXpSJMX98EssIo0tFDXnlqPiPOBg3LaxNOB1wV7wCsDD2uXk+IbZ2gw2hXAvViutSxL3Crzc0UwTzenfpyk+7CJMncgxNwWFz7jWQC2TokTA==;31:9AMzQSksgsFNHNC6Sms9asNMjBmYwq3QXYj4lvAkH9pUDYUpXrVciYvLbRhnwoZc0nU3PftqFJccMzua1C6fSO/LhYyZ99NrcNVK7mNDq7v5agYE9g4lUZIxKGnqgRd9ZlrOqTtQI+E3scs3LXdaNMSwtX8ys2jeRh0eurSlcVP3+4XoE20SztyqzHQhbsq9Qr5MzBbwcvG4TM7wCt9+vFPvqT78EPvO5cGNDzXp+bU=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4798:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;20:oybqXRkN5F0UNtrJE+a5+GM80yptUaP8iY0ab9l9fDLSO7lKN/J1PqFLBNyDMXEeF0+eoT+9AU7H3427qDPvV2hmPQeiL3xhWfn1/ppfMtkLrOnoh+3E3kYbEe7yCg1QqG7g+kCcFdE9YMVJxA15IjSiqjG7itwNh7QWpAtmH8aJquxIfhueGjKBB0ET2rsnwGYyVsE9RfjJuYlsvjjbEvIkdIetRE2+TMr33F529AgRnWztUe6O3zAhDz2idKGP9Z9d6sa5CiKEl8r90GFosF388rTi7WlSTkbCzP9bt04YeJdG3wRvDYZl+aO43Uyj3//Sr0Z1a3DLJoVmHQnC+0nFpONlL1zgZgK0nqqc0pjXeWgKV6KzAVsX/254v3AeAUcc9X/EMF8lxbXa0kdpJ4nYuXNGk8TeYtWPHce2CRkmSo+uKlZjl1w2b4uD2avlkv1UaTC3PqItlBhnxpundHWJFwSfHtkzDMmbOM7dlf0FgwprnGpza/++ZVV/0yPR;4:jIallgblV2c7nD856WQDj0C6pGFcAoW9FCKVzbVdk6TIj15cCwQpl3P7q/DuYOwbQzyVUj2JWR18sqXzzb8XAKtpVMGxGmGeVi7oKOxgJiwfJlp8N52oeTRPQznEzJvMb8y1wNXJW3NgmP+erZKra7MVpMKaimumO/wbV+u+fdWSenF7hVpFMOjiYNEgrj47p3GPpzoxdik0qU8ASZf6sKw/gz1qMPZCICCaaWkJVKBsrW9XTiiXfEM4Yg0u1maaUxV+oGk8xRSxkjqO5+AxykYP718mgJf+T+KAqw1IHy9n5ZhmjlQdFAx5IRqxvxcB
X-Microsoft-Antispam-PRVS: <VI1PR04MB4798AABC652657A0B9499BDAF3170@VI1PR04MB4798.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4798;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(97736004)(5660300001)(6512007)(48376002)(6506007)(86362001)(47776003)(53936002)(386003)(6666003)(25786009)(52116002)(76176011)(51416003)(956004)(50466002)(186003)(7736002)(54906003)(81166006)(16586007)(7416002)(486006)(36756003)(50226002)(6116002)(44832011)(68736007)(5009440100003)(26005)(446003)(305945005)(11346002)(16526019)(2906002)(66066001)(478600001)(106356001)(81156014)(105586002)(8936002)(2616005)(316002)(3846002)(476003)(8676002)(6486002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4798;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4798;23:eEZihD4JBmtA1A55HYMYfEHhyPKyJXjIoiMIei10A?=
 =?us-ascii?Q?ntlpUBzi/Sil7q/vzqQBES0fm0d7hqHasLONujnFY/qcZJYgW28TFX/2fceg?=
 =?us-ascii?Q?MJQbIJNKpETEyeEXDmLZ4to11+z6x6nvTqsCZAvrychZHaRZEpARac4GKEph?=
 =?us-ascii?Q?KOWHoprZubnHfojAIwnRlnapL3cWfbRfjSDtS4hT9PHnKyxWvlYVv44o3hVM?=
 =?us-ascii?Q?LTJ8bom1EhKZZAT6ZJ95pYh68fO0uduhnzB2TPGB6gTgpmVfwL+CsRwmvqTP?=
 =?us-ascii?Q?FdG7YOedFnPjcPTsDfDc05bxy8gpD78alxN+Kd5lxymvXvbo8Mww04Cc5L9O?=
 =?us-ascii?Q?DfPJoJMXtI/z6HqD07VAqjHovgEZalm9kGXWYRsMrChKYkYKq43XN96aTk5S?=
 =?us-ascii?Q?hJAM4YZos8NPGDLHqt8+twmAb3L8FsrCYiAl0svjFnvFEXNTKGqA1Jqml1ve?=
 =?us-ascii?Q?FzamS7At0Hu+6MZWHGXd7ShsMqkYnGDJY/zMCJnc1fb1FGtlWR09e+me8H91?=
 =?us-ascii?Q?YO3xamzdtN/jb0Rqjk4wmJqsIPNDE8/vkIvEwh1M44gvLCAGDdaO+A/4Q0a7?=
 =?us-ascii?Q?o787LS8WYsyAvcELNZc1Nrj8KctfhKoe4/KGGpV7L9FN0ISM7Ki5KhGGIB2n?=
 =?us-ascii?Q?AkkApPh+7jjK4XAJiK+yWGD9PrBlcKbDy4DPrBSbHuwtgJeL20yS2Ij3p9ef?=
 =?us-ascii?Q?5k0d34qUaYJV+RoH0+m0i4BjFtJaYnDhrFYedq1dU/WRKZQQzQbM+J9WBzAe?=
 =?us-ascii?Q?HwPea/zbFdVbQ2E5wXG5kzjAW9mOFt/yrWgkveHTB8AGp29o0G5KylfFv4IG?=
 =?us-ascii?Q?7ZY5vJWJrTxyaT5kzlzpRk92HK3KLBvXR3d39t5JTTSa1uivCBuHhZ/dURmo?=
 =?us-ascii?Q?GUudhZ77aJMdHuF8GS1PaxL1pOp3NLQlPaQtlA+wXm1TSgf8Oq5Sh4rbwErx?=
 =?us-ascii?Q?icy1PvQxFTFxZk/UoAIQUVK3AdOyAxVMzL4blPaTWLOXkpUc6K8uo0NZUqcR?=
 =?us-ascii?Q?lYYPgiJqi8iDD/acMQVkxYIWaqPUTGXjG+55/W7Fj6G8krl9ncEdKC+cBqz+?=
 =?us-ascii?Q?CEhtIBs15MVklMyRdqsOs+CNacFilmheK0BtREEuTM3MzgWoOsYaQyfJuPLW?=
 =?us-ascii?Q?LGkda/iJlWMIusx3mg9/y/PhlH5ruCYrWnHlz9HkYz2GuMACpSYYuqhOLriR?=
 =?us-ascii?Q?RZgidbS/77amzAeRhfsUfeipihBaxwtHSXYmOq4HfEAdvkPQT9RLohjKbKx/?=
 =?us-ascii?Q?Svx4pFIcBRajk4jJP562an0ES93daINNzuPwoW5BsZaj6eFbxsH8zJ7qPCRh?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: ic/ZcH+PY3EtwTU1IVDfIvUGJ8xXBQw52b8AJo/Lvjq+SdATDCpNlcNfSa/5IBE/iXOKB6bDVJhiXyUusVSW0AW8MsLl8Qluekwu3lO+CWkKYlvy2VAk8ceQ5VQh+/28ahSy4xcfjlOJiIyW7RLjvTH+sHAyExOQBcovl7NzKxh4jdNQYFIvyp5SAhk2IBFnTyjwGgDSvDlOOgnKOFMuh7Xja1hba3pp9N1XPkfSe1dw518BAeFRg0bvKMqtpszgYFIwtMfFYMFkEdjdAPBWAiJRS8DyAUWB9aee1dsdBMNLel2B4cHJMSHaGStNwa3tMa+/q9d1MYG+rkVMrDjeVVUOcbVoSZ1xh5AcukkkyIE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;6:2LEa6WrgtqxZdIJ7ppu5IgMgfEB4cUYy8x9XO2heEshBIpIlfXGlJ3OS2Bb9YB2WffCQnN/uZ++CzHt7MU0NpmZSJNxlzK5PzH0TVaMVdNtW2/ZPDzy8Po9PS1JnFmflNOh3D+sWUEAznn+UjM0mSMF5iLZh1IO1kBkcVvdDqlbai8LyUGo7yhkXtYYVrqMFBzq1MeP6ocYkNs9n5xJgR0u+mK/WePC0K1MgqpyHl2BTniM3rKFgNaqhUYNZVnGduOzXY8EFWaxtHHl+dWpC2fI6dvTIf/R9/uEtjqI14RoNVHtj3QzIGOlwF0JeIwrISWLb1L+CBB4NHOKyZ+GlgDKj5ZLhjUP+GncDHWHQL5Y7qMolTwpeBk3eAy7OFacJOg6q9CfmRIdLsv+khdw9/6C0CaJXCdBeE3lx9JFvaK3IZTqEI7gLMa6VLBMx0DnfmUJ8r5ghADP1Nb5fCmOZMQ==;5:9e2irt7p1PlTE+F/sfLEI55Ljlh6A1uCTqg9ChWKtAbHP2uEOHbwgU8Fq8G7dRcUFd+WYdBISDBofkT0BBTvsPev8jYSzCjligpcte+qW3R/nUeR/cKp4HdbpEtnFIDcydBq6nunCmwvsYwpxCLO356ErJ3oGvsK2pit3dr0Szk=;7:HXhw22Dz7olC+kStbmeKTsmR1cy/3QMTbd2X560cMP5jJp+KSL0S2XthNs2z92tO+lq+erHZKVZ3XRUIdSlOLvo+RqSg1cCiyFHRNaxKpPMaVkL3aZJZ+JRYzOP9LfckehWGeV6YEVrdMh3pgQx0jwk+uv/xn1GSc2NU279NS7mdhrKfnVkc3uXGA9I6KDkQYX+sOmcTSRTIWWMAn9Y8QUB7F+XUwJdcwhhyq7UmWlhBZHQ1TaxH+67JZz5PQiN3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 12:14:27.5688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7a5141-5ccd-4f9b-6c23-08d6221748d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4798
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
 drivers/clk/clk-qoriq.c         | 12 ++++++++++++
 drivers/cpufreq/qoriq-cpufreq.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index e152bfb..99675de 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
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

