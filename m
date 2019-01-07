Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB1BC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E5F20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vA94g9sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfAGJDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:03:19 -0500
Received: from mail-eopbgr820052.outbound.protection.outlook.com ([40.107.82.52]:9036
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbfAGJDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgtOhEpjxZ23xN+LbEYJrR/hIcAfH0tB3MLTLXkdBEQ=;
 b=vA94g9sCG8cIfZUXvAKEPFBZOEFBXoGyAt9M+SwEKC0i6s3EtxOtTRbEKp2tLkW+L4FGk1ufe3IbBk60L+JPmmogeM4NrJICEGkNVgGKB9232+bES2p71UD7ikIzlvmFv3vwoBzaAXfWdPiBvu80boJrX+CJZaJpJNJAnPDiyu4=
Received: from MWHPR0201CA0062.namprd02.prod.outlook.com
 (2603:10b6:301:73::39) by CY4PR0201MB3506.namprd02.prod.outlook.com
 (2603:10b6:910:95::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.9; Mon, 7 Jan
 2019 09:03:11 +0000
Received: from CY1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by MWHPR0201CA0062.outlook.office365.com
 (2603:10b6:301:73::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.7 via Frontend
 Transport; Mon, 7 Jan 2019 09:03:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; davemloft.net; dkim=none (message not signed)
 header.d=none;davemloft.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT042.mail.protection.outlook.com (10.152.75.136) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Mon, 7 Jan 2019 09:03:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ggQoP-0000nI-TY; Mon, 07 Jan 2019 01:03:09 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <kalyani.akula@xilinx.com>)
        id 1ggQoK-0001lU-Pm; Mon, 07 Jan 2019 01:03:04 -0800
Received: from [172.23.155.90] (helo=xhdengvm155090.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <kalyania@xilinx.com>)
        id 1ggQoF-0001j0-47; Mon, 07 Jan 2019 01:02:59 -0800
Received: by xhdengvm155090.xilinx.com (Postfix, from userid 23151)
        id 4B51A8009D; Mon,  7 Jan 2019 14:32:58 +0530 (IST)
From:   Kalyani Akula <kalyani.akula@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kalyani Akula <kalyania@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>
Subject: [RFC PATCH 1/3] dt-bindings: crypto: Add bindings for ZynqMP SHA3 driver
Date:   Mon, 7 Jan 2019 14:32:54 +0530
Message-ID: <1546851776-3456-2-git-send-email-kalyani.akula@xilinx.com>
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
References: <1546851776-3456-1-git-send-email-kalyani.akula@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(189003)(199004)(36756003)(81156014)(90966002)(106466001)(478600001)(50226002)(63266004)(6266002)(107886003)(103686004)(4326008)(36386004)(217873002)(2906002)(42186006)(316002)(16586007)(106002)(2201001)(305945005)(47776003)(110136005)(54906003)(48376002)(50466002)(5660300001)(26005)(186003)(51416003)(76176011)(44832011)(52956003)(486006)(476003)(426003)(11346002)(446003)(8676002)(336012)(2616005)(126002)(6666004)(81166006)(8936002)(356004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3506;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT042;1:6IgxXmvRO5wC+xw4tSdk9D+KDq+3E25tO/1rVWGT++Yhm2AUZpoi5dX1zDvtg/7KPr33/jwTRp6JozOgXjRrjPophRT6lmwhoTviSafTxJyf/FTGoWbNBgoZ09VFFutY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdd81509-08e6-4829-eab7-08d6747ef2ad
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;3:FcZFF5COaHA6JQWC/+4p4rsGV4cuVK4AA96ztYS7xgKMESQlflm5eAJIX/3Uxg+zwEA2zaYIbNXL96qonGpa3l5Im14HYDHT4z5+7B7OrD3t3rL0k3hBNlmVFmaBGbDhZ42uvsIqnBhUy1sWE+rsF+8D+cLAdbtmRt/tBO3cxoDBkY/M2T8vwN30dncvcT63D6GscLlqpYbDCMqcfP3GqFA6x6eXKR/Bg3exxgjaXoA0yaKQzaDcMhZAeEYgnNwkBINcza1F55nxxY3fsN3eWO+oJvaNvSAtHOchnelZBt/4PvLB0HMWEw8ig5IjUSFtjxCXDjHhjFMDOAOH1JEHenzd1oIC01Nu2r72KchmKQq42YYbEOXtEnhsr5fN4PgG;25:HUTUZuyRy2LXurXYk7SZjhZ1sglD8+BveNiv2tY8+0mbq3Y9URz7LIMZLIZloaRJ5rco69oHE28/z6BYrHA5Nf2PKS1o/re0umZ5KYlmW0QfxQcTqyVY1v/jVph06vcePDlnNUJHavkcPQzW4+pRg70R22kINN8RP+8YGksVn1EBYmAWFsYx57v1t2K54kwr6qql4rawsJ3IKlX5GnlwfLs1Rc/ZNs45/M0UCZ47JBsQLTW2nfZFOjyyQ6X+0IWjFDkbgVkVdseON/17bS45jLIHpUYXWWH009x2RuwfDgnZ2X4aPzBIr30NiPrOTA18foUyecCd/pDXN8LbslZRyA==
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3506:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;31:GtxrmtqQZrzR9bVsXr82Q3PWuRtWAGu7fGgSw2T3SlFw3XVlNUzpGRg35ck/+9HliL5+dK+Kq8iBQSxn3BrQWfOkvF44fG0DFtQAss0dnmnbdMpWpbW2ffnHt92AfHUBWbvU7wIyM2CEMn8aC8YlCWeZmIslkjyx+Z35CrCp3OzVAu3QpRTYai3uCQZZW24NHePEUo7FHx/Nh4Wt7KP8be89K/V6mtbKeMGDzrDVkg0=;20:9nAOZKeKjx2MCRJHGzcDXZjpMCxXzgIzjdmNC0xlyxOBqAhTm2ES5Gu70z8egGBqkb8nFirDiRefHrxXqMQrJWlzW80EPM66QVdm82GBbdtWyA53lcZwLDFsroqWERaoC0IJAg35pEV4b/th++ou+DHQmitkaHCox94Je9RwJIhPYCPRkOblzyFEUU1dma8A2rcaOxWh8pxYr+68mXSATqkzvKbUB5dayZNjxxG6pyOi/nc0dtVr5sz3yg+KiaNgJlu8z/dsKFx5rmon12h83WUVsxovImRIPN/edV0em56bH8ZIjKy8skiqEk3E6CkqFtC1zPlMtysGZUBjHp3H9q1sYzM2xk3+3Ip3C5r3W+Dd32R+L+Y+luDeie6o1cg0PTMiYjMbEjxNPbQenXHSLArMdGm9AuU+rJii6sW+xl1Sp6ryDatwkWG6zK1cHFT2Kdv4+UH7I+KvKBkbH1mif28BcI0sjFnphSBKL8e5JTRd03BQakcYvMsyZgmLaf1P
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR0201MB35067CA730B1C4FA04257ABFAF890@CY4PR0201MB3506.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93004095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:CY4PR0201MB3506;BCL:0;PCL:0;RULEID:;SRVR:CY4PR0201MB3506;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;4:u6DSOP4AnZdJwhwZWtB92dO1ut7ik3scnybc1ecCXeGpTnWu0i/5fvI3xGN0gu9e3L7C9R38zH8Ai+hOohR9BCt65PZeLDSLSxdxp2aTMmOr+ff7n2NNbkBt/zZT3wQImlbM4/lcImE0x3Sj+hiaS9AqeBib3+eLOCbZvbC6Wcf36BC3S4XtkiD5Tav67m92cs1UVvp0pL+Hmv3WTWAdK5QCwo680liJJ8prUtwAqJVkntcNClSfJwAMyAVqc74hfgSqRcX3e4LEaSqGxYYrZ++Uqo1keFuMd116wwk87bX57AHellAzAlpewdw2boF9
X-Forefront-PRVS: 0910AAF391
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR0201MB3506;23:qxRPIRFGfj80KGIMnwAbh6TsrN106S1JJ/TncAP?=
 =?us-ascii?Q?PBiWLokhIHQweemNot4Smm0Q0o1tRfB9KzyBIKa5vepYZpDyzJLh8reGcipw?=
 =?us-ascii?Q?rVH32NLaXetSSQEGgWbjIVnomw6pkMCTPEkFvJdnBsppDZ6ZPJ289ew8pBnF?=
 =?us-ascii?Q?KtBU+mWxmBZsBh82iaN21hlJcdzl07h/u0YDPPAtz0a3iOq/f5UGS4r31mhB?=
 =?us-ascii?Q?vknR8MNi/EWxOAGf898HTRdLydieYys4hBu7UrcF0vg8pf7zXhiGZ+hdUqMx?=
 =?us-ascii?Q?x4vGlJCMkVWVYs7WRbOVEAGJHI/YSd9mIeOgOYBwFhMaWX9NrA2fu1Hkm44L?=
 =?us-ascii?Q?FTjrbZpKSrAb9GltdhRkLP8vFrz/xVGbiVval4RSiYn1X/u2JN3XGacWw/Zn?=
 =?us-ascii?Q?HWL9E+YaCMZYoEqKtWiCfA8Ucfqx+HGjhEKoHhE0Q96jZkNeo5HUx6COAsJC?=
 =?us-ascii?Q?ppDsi1ZUptfLhFze20w/XZQ+tL+X/mrTQiw+w1W15vEZHRzo9Bze3WB6nLCN?=
 =?us-ascii?Q?YsoE60DeokA4Nzj+D46jhwdPvoFpdS8qeX088ogXgVGPvVEmTiZRFsOx4CYS?=
 =?us-ascii?Q?APIyHMwWQTesWCs19MqYEASv0zcoJQU4fgduEuI/6AVk9QLBoBZ3GEEM8u0Y?=
 =?us-ascii?Q?U4RHGLsVsnqt8MgGCE4evHC9uu78eOTRA+LBHUL1exmeq7e1uA91NQHr5j/s?=
 =?us-ascii?Q?bl7sjoofiazYuVwsYDbWdtxJ7BY5D3BE2EhXsyRBGPhSraTqYBt5bTLH0/Tm?=
 =?us-ascii?Q?vHPGVUUWBMHCS22ByjS+jACyqM5gtoo7RcA4kvf8rt4vUqIyKOL/fOBdanEC?=
 =?us-ascii?Q?JfGbda+nL9THcflibCtaZEwxWo//o+qXVA74tUUBzyybqo/4AEhZdlZZw5/4?=
 =?us-ascii?Q?WpzgUJ1Mm6s0DRz9Tbj8Y/TUpt/IEmcw+tC2XhmstO5OD78GbrELHx4z1UIf?=
 =?us-ascii?Q?kjb79Bmgpkikb8v5RD05CxeTij9b9a64GOlOEX6s0nUD3Jzfbf8Y1DCP5zJK?=
 =?us-ascii?Q?aHcpgaQEsctmS03roJ8RQC/FXWon2rO9gmIX72RU6lA4JhriUNa2Z8hNNJEL?=
 =?us-ascii?Q?gSgth4viou5cprTsinIB7bi/0OfO1RD35wbutDJtk/YIYwbbXZ6f8tYPzudF?=
 =?us-ascii?Q?qpkZHAxwPQmMF5xcdLcXELEAVtoJps643rSIU8nApZHN1kQnDxHoFMjZyRMg?=
 =?us-ascii?Q?gWsb+7KHPOyMblpisqitjqGUJEjE+bner2yUb?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ql/H6ln1NoQJHbHFh4bF4LGPNaTloIpH4YrO4A+LaGz43JbLqqWuvRPPlzwRNwW/+9aVyTQIJG5oFcX+oi7tLAW2R5X3fbgfvGPGYZnjfSQiWiORqfve1EIBhlQRA01jzK+5h4dH+N9zvf3a7ajF5fmrSQMCjn3SmVz6CFtCHXDJgDSWiWdHt3ecFwPFRUv08/qAg268AZOGfwnRYHSo3kEDMbQLx1fL4YGEX+ok5mNcXX8+77PncdwMk8uXafGk8YigmpuyiRYoxLW7tedOzccTcw00SFvBMXF/ldsfVJch6K9DIv1Pc3w1nwandnCS
X-Microsoft-Exchange-Diagnostics: 1;CY4PR0201MB3506;6:zItK7KQ4Z32lIuEDbXYZl1xlO+WoP3boxkVm8PvroIWQqBXr9eqysBoPDYx7FNJXIKFMR0ZrtAOAOorXxkuymQGspzcnPzhCFz0B23ElzAsRpHggNEFEUTbmZWbRfCjsEKxwFco+Ax3I0APWPbV+ZIDCXO5cj5yxucAi+CblmBUy96ZzJeDbKoRbr729y+HYJcWXTr/GBS+tYQgbTK0WPCVtFFPM+i6PzaFGUM9L1+iBjaDQkhfcEOS//odCLRRIrf4AU5pUtLHr1tl7MwF//zQ2t0OCN99N8nw+ckBeteqCRYZb3kn7Tgcuf03RwX9mRxudt2BhSZWLFXXWN4n0i7KGI60H2Pb+jguxDaPHED7wx4xRSmaIFuBc/FX5Ore98NnsCKOfi5p/KMpLRx5wNlO0qPI9OdTKWBQUOV4Px+xajhonz15AsPckURIOHNiJW9d8QjmMI5ov9pWvz9PsrA==;5:k22w+stVbIN4DRwfrkyxERsXm3toe0+9oUdC5BQ080rg4ZzeEKj6uu2/TB7C3upTH/1Kt2X0ebR1ZQm45AB/cQiyZrcOjOCv9tq/pKm9NRRDOO0IJ23bAXwPatxOx2GzKjlYW9R1DvazerwpijHU9AZPRCHxGOgHeaS92UfDC4Zctl/c7U8tsxuTPdMHbkkYuFmAZai+Xp9sSEdLLPBNwQ==;7:0KVV5G5BZLieIhFhcJ3sA/ouIjemIfNAEsaeTiQlhSdslHzUYZiS+SzE/qs2uJLKh6VrcdAM5hVQykS1cSqUjyNMgJ7u1QOqDhshVOcw9TYNcHCZY0g2beS33IVhO8dJwniY7z+avshYOy1HV3CjUQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2019 09:03:10.3189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd81509-08e6-4829-eab7-08d6747ef2ad
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP SHA3 driver
bindings.

Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
---
 .../devicetree/bindings/crypto/zynqmp-sha.txt      |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100755 Documentation/devicetree/bindings/crypto/zynqmp-sha.txt

diff --git a/Documentation/devicetree/bindings/crypto/zynqmp-sha.txt b/Documentation/devicetree/bindings/crypto/zynqmp-sha.txt
new file mode 100755
index 0000000..c7be6e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/zynqmp-sha.txt
@@ -0,0 +1,12 @@
+Xilinx ZynqMP SHA3(keccak-384) hw acceleration support.
+
+The ZynqMp PS-SHA hw accelerator is used to calculate the
+SHA3(keccak-384) hash value on the given user data.
+
+Required properties:
+- compatible:	should contain "xlnx,zynqmp-keccak-384"
+
+Example:
+	xlnx_keccak_384: sha384 {
+		compatible = "xlnx,zynqmp-keccak-384";
+	};
-- 
1.7.1

