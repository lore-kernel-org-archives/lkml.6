Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC580C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E842086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FcTjeUmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E842086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeIYS2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:28:19 -0400
Received: from mail-eopbgr730081.outbound.protection.outlook.com ([40.107.73.81]:48160
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727531AbeIYS2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo/CT5srXkGKGrAsBIOB3iI9FibiQ12Et+tBFrKsLbg=;
 b=FcTjeUmDnKbziPxsAYPF+i1P/BleXXI23CtTjVy7kLgNPbEVS3El/KWY4sUDsd4fHx6Z9MMNq/OemPo0Neyf1kb9+z8AMucUmcrRirpjg9WKTgtiIVThR4eGUZ5QRhkmElNcHiLD10PNRNRqQnZUicfXdhopPF/a6CiKThshQGA=
Received: from SN4PR0201CA0036.namprd02.prod.outlook.com
 (2603:10b6:803:2e::22) by DM6PR02MB4764.namprd02.prod.outlook.com
 (2603:10b6:5:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Tue, 25 Sep
 2018 12:20:59 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by SN4PR0201CA0036.outlook.office365.com
 (2603:10b6:803:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Tue, 25 Sep 2018 12:20:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Tue, 25 Sep 2018 12:20:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40231 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKo-0005pW-0m; Tue, 25 Sep 2018 05:20:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKi-0004n6-T5; Tue, 25 Sep 2018 05:20:52 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8PCKpiQ007553;
        Tue, 25 Sep 2018 05:20:51 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKg-0004mH-KP; Tue, 25 Sep 2018 05:20:51 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v11 1/3] dt-bindings: mtd: arasan: Add device tree binding documentation
Date:   Tue, 25 Sep 2018 17:50:29 +0530
Message-ID: <1537878031-22253-2-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(438002)(189003)(199004)(39060400002)(50226002)(2201001)(9786002)(110136005)(2616005)(478600001)(8936002)(5660300001)(476003)(7696005)(8676002)(36386004)(305945005)(77096007)(186003)(26005)(217873002)(2906002)(356003)(81156014)(81166006)(36756003)(48376002)(51416003)(6666003)(14444005)(336012)(76176011)(50466002)(486006)(426003)(316002)(16586007)(106466001)(126002)(47776003)(107886003)(63266004)(446003)(54906003)(11346002)(4326008)(106002)(34290500001)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4764;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT031;1:k4ZqqVwQRQ4dthS29zzXuyz5ESDh3MTj6VuSF7pmIVqohXPxArDrguoFY4anRFD/VDzhnMhYxOw7JF0FWNadpQlgILhro4XU6dXKyF626zSCa0XlGe6CQynBlincqhmK
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37b1bdda-9183-40c9-841d-08d622e159bd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4764;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;3:deIibC7icd06ZDTP+GW4qFwr+yI7HCJDOtLm7uZib28pG1ujwRJihDpHWXBNiUz22a2csuQKlK9KmeJmlqsMnszlgRP7zWe6kDDA69unAkW4+P/nKFnbju4N0cUH49Hf/+uxOLM8sz3abPuSAZK74hOPKqoqcGhdRS2NfPtJewWXYRFvxPbZME+gpaZe2xUsv7wy4LQ21Q374PpfHk8CjlD+qkFYSGcPVXBLPpmOt2qh56ELLTM3vZBic8aazQYh/HShIUbY5FYGPFmdWqXG3wtRg0nr0nGO7d4/PRDpLgeWQJ/wpCHikT1zdUJG5OR/yFk/uooTaWhGP+Ogf6t+dBG3xVt62IDo97X9Pvaw8U0=;25:hMtDi7KVOVGEXThwoNw1n6vEncBLekrLCiK5/nD/PZzJvOeBtSbLxXl+G9QwY7y9pAGxFBvILsjWsaZGKb75nRvtP4PSdIe6AA8OhtB0gqki3Jhdq0CjcF2fkoE6YXVngwv2KNOQz8ad329X20aLIYg+hszvs1+o5xUkS3VrdBi/7b+RYbvxthigRXT+p0W/GnlD3pvGHaJEHk4Ql86WqBExB4RZv4CBu+K0vqcUvPVi50zI4Ggzcz54jeaiPi9k84UOdoTxVCn1Rhh41Clge8riXBQQwqeNRTN4R9VGik5A0olrLGopDMYOgkCkmhP0jixDBfxvV0Koh1DKlbbBTQ==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4764:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;31:zZNV95dXtqv637Rsr3Iq2CroFXES3KiHaJCcAHU35E12LgnQWXp+yM649xglBQ3fRUP3IZOe8mseAWJB9PkeGsQOigLKYTOjj/dfl4dCcMIfwTlKpCQ3P8yLEesrpHB8zqQ4cVFMMJdpjm067s82wUVowefB6ioPatnZfX02yjPK3l6+sbOKW8GOYhcQaHlXKfLxeCRvmjJK/WEdoTud9jTFyF8jsGRjWqWMeYK+n2E=;20:sVKlDYxUdd4P2M4vBgv9meeiz5Ps2HLcSBZFgnn1FstAMsW1L4p65bvQluFK9qsEkb0gL5KbI6qYXIis9tE3s4/3rYqFuonG02Fv/H2iUDZ+Xlw3JhLT8/VB3HuGReBMCz9B7g2a1+iDV/cQixse1OsrxxMBqdOQOufXPqNt6ThBgHNrR/edj29eqL7Wc3omON87T6GyXesY/Yl51aJqaTY29XAY+sArGgaDBWyDJfdvtt7UsWrEgwDj9FRw/8vvUgyMPUem+QFQC1G8Bw1hISvr+cIaGrwC6v0tFmYXKx5Vo9bkT3Tn61nbkydTaZ2AnFfGlpepzByrBPx9iy54ji16gmE3CbdVNqxICPM9TDB+0bj0ztFOf7rQz2EmdW4k9zBfcieQ00frt8hGikDw/9dSpFLgLecY/8KTkT+2pAtodhmH1bhAeGH+KZjib90RD69WYi57DOb1nvsbNXWG3GSYICX/5GOo3V9E/Mf0rBCOaUjtO8koT9UideDRPwWr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB476462F671D945EFA5C41B5BAF160@DM6PR02MB4764.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051);SRVR:DM6PR02MB4764;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4764;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;4:n3wa8cYXUtYoDtnza2iDPNdG67PjmmstnhgqG/vBSY2tIH4DRnVp3SIcb4wFsTaqQUvSkuLPnUzMBRIXnQp1dWlHbKunT4J5OXt2C4RXTy7lmlOHZeWhkrXSGBxBIl86ub53UtOUULGNw2EYGvZ2/AZSB4SENEcyLJVNHmMr2gN3rLz+r++VKkDzs6EwkIX3N4RLjAcKPoUbOIWLNIC8rVK+sptyCb2fU0pcPdhVOgxpeQw1A/Df0QErEbp400EARfnePPyHKNZytomMMm5/JREBTTNjjg5mxe8GZhxC6a6rIoltQCWARq412i9io8PA
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4764;23:qkOV/B1g4K+AVbez1ZuyKcD3d/lj1keaSaQVkeD4I?=
 =?us-ascii?Q?ZsaOOHFKSyn/+sPM4vnIaOOrNVCdRXO1LAZ3tg1+uDxuwgqb3mlwdKyY6cxo?=
 =?us-ascii?Q?OSZjIlCAh8i+6dbvb4dSp1tAt2sBOyE/ivpCbYb2SjkspQpbNH8CW4Z0S25m?=
 =?us-ascii?Q?DPogakfi5B9nsfFb2puTbUfd0gXstJ2uOLpHzSCF3U7JCRx6hByPaiR2Z7s1?=
 =?us-ascii?Q?WhhysAoVrCzIU69fcp22AsiTAIZ6cYeggbabcNH/cGIighjqX/h2Kjq74jIz?=
 =?us-ascii?Q?D8TGYYMVIPfFldUOb6q0AaNGA+WYQKfIjM9gEBlomKLQXI1IDE3T0DuzGOm/?=
 =?us-ascii?Q?6o/WJbxuSozmUl82H/DV9SP9g3+J3Z6F+viqbZYVBZbhd3TUJSKLfaVYMrIv?=
 =?us-ascii?Q?0yrzJLKPH9thUe4m6D+Nj6co+RD65lM9zx/eZ/w/DlgMTG2asEpEF6q/qCqw?=
 =?us-ascii?Q?zrcBmxb8nIbx0O13rk/3rnWXlgKck5+9JcERxTIqN6Kb1K66kE90I+iGkqbw?=
 =?us-ascii?Q?PRrQWIdLG1KOnEOLI0AFPh/hZzyo6kIOGO1xNxmT7eId0bcfFgl7QnoOJDvZ?=
 =?us-ascii?Q?CHVssHNQW6pAiDEFT1GT4zB2gU0LBAQH5hggH/HzNOzs8HAyG0XliQNUVetx?=
 =?us-ascii?Q?VW5gI1iy76oCuxkND5EyYT/2FgbaJhEP25ds4avcMtbiQqyhkGWw6o79MiXQ?=
 =?us-ascii?Q?N1xvJLfn3Ei3N9gRaak+RaJl2ysRxBTPx/wNcfv08daozmLGwxgwSRS/EQRR?=
 =?us-ascii?Q?+4CF0H52nSc2AgLAUf+8gYdKRDUtPIFJ/2OncSKGQnS77b2pf3citiEqdIwa?=
 =?us-ascii?Q?Icek+yhLiq46L1KtBPv1GCg0u+ycuxQETFiP/5b1O9lTEwZ8sdn1PgcbxALp?=
 =?us-ascii?Q?RWKBVWdNecP6cZdS5CP7MTF1tyDa4dCPEmsNx2Q5jDtAF628sdrrCU9eWn1k?=
 =?us-ascii?Q?RfPzEBlV9wwGu2GsjLWWeqf2kOSHqQZMV+MRoJkQQjQhS24KB+ABevmf6Rcb?=
 =?us-ascii?Q?UWp528EnS1p5EQfWXfMFSewWaRyJ16EK9icyB2cGSUaxQqNniL5g9W1fGIRS?=
 =?us-ascii?Q?jIi1zuPfhiKZyVoHFnRbHMdKokJQFrLroKENQmpZobphf5BmgI/JJCIpGj7L?=
 =?us-ascii?Q?ZAff65o9oicsZV2hrue0h92gwosBTMlCgvMduLrlfq059i8ybuiwvvA40yjI?=
 =?us-ascii?Q?9Tsf3Co0xkKpC09vtwnMEC3+YRs2REAaCJTDrchXzxaIHQTW/l9RtWxVsM0C?=
 =?us-ascii?Q?9iGhtGY0ol5nM1Cvzc=3D?=
X-Microsoft-Antispam-Message-Info: CuLAoD5DlawEl6T6kQawrWNlp4XduXYmyiuhmML14y4VYNsBTOfnw8yNhL5Yu4ckPIMCQ34etE+SeRDxjcK7JOTRoV1A7RIyZlSHe56ZrAlZRtrd9EMoIYtpabFXVu6i0vnVhSCgDFwmsvo+0yaC9yvjPegptaanp+OAAJkRbi5ns2wXR6T90/WGzx7b9ttDueQc8CqTaZtuFpVHgjJRSm8Iv3NiqUPLux8JAbZN1/M92OGsrjpYrWboUV1hS7WI7zIWuMwjW5Bj5Mb9rdKf4NyvrnBPhkUNNhj3fVEXm7E5clBgi7Hyh49tckWgXjlI/GR13zLHAEQtFE2M4DEwKJN9DOCP1+JCsdFbVV5vaIs=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;6:se9ICC0xtThlqMBLRcLt/s/oUvX8T8JzmasijN6j0a6qfRzGLRcr175FHgWYMkpbDuXOqb1ze7JRIa/CvK3jGDOSiyLqldD/9TjSDFqBIfLKSsf0c02FWTwygFcepW0OJeCU7HYexLTw4AMrnDzAnI9mZ2nyv5oZyZWeOyACIYWqtAHT6vctcztHZaxuOXaIcHlbqfyqTHPMLn/nL03SgGAOtz33RV+2M3Ga9RrpN6ldrMdPIfLbjq+OKv8wEvPbjmiFwfuTXnpzJmJ1KmVvPeI4D1NpqJU9scCkvmkQDiOCkS25/s8QhM0t0Cs0kghAN6FMopa4x0KhBiyAeLjhSM6ml/C/dFG1rqVXSLdM+Qx8T+rLFXXgbB+hmPwT+hYK0eivaqQnIM+uCHzNbl80QmjASPCNHjkDawAQw/Gy/BFAgeS/erIvi9rg6LxXEZ7uwLaAL5X2xGV9WQWMofUNjg==;5:0VzatDzrf1d+Kd6Q7IzgY+EW4pNr4ajnlZxvoxUSQsnNm8KAEejLkz1lJAzM+nAdVXSm33IlQ5z2Zmc/dIyDtgo9NNeQAO48ZfycbH7KDlKJHKmRIF3ELakCLDYQzXod5P2xLu2i8Ep+d/+HPs96rIzDuUFES90nu4zksOEnZN0=;7:tYqUcv3PGF7SGmC5MF4ZR/iFP38ZlQy8H4Usr3PA87bnfnz7z1dsx7vk8D4J0oYewgtOShFZNr0q5KuGHBMFKdDkcapDU4tGh8hrRCWtzOPiw6bOJsUx+/dHyASNnOVB6lsHLpajnydZ/INa3tcfmmLD0jkTUxqz3/syStK/c198ptjAn3H3+v3qHQITwjdRkvJbsJEI9aTaf094n+jVHYz6xIoBCXb70dzDkFP2njYdF3SCQi+HkX3ZTftinn1R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 12:20:58.6207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b1bdda-9183-40c9-841d-08d622e159bd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the dts binding document for arasan nand flash controller

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v11:
 - Updated compatible description as suggested by Boris
 - Removed arasan-has-dma property
Changes in v10:
- None
Changes in v9:
- None
Changes in v8:
- Updated compatible and clock-names as per Boris comments
Changes in v7:
- Corrected the acronyms those should be in caps 
Changes in v6:
- Removed num-cs property
- Separated nandchip from nand controller
Changes in v5:
- None
Changes in v4:
- Added num-cs property
- Added clock support
Changes in v3:
- None
Changes in v2:
- None
---
 .../devicetree/bindings/mtd/arasan_nand.txt        | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/arasan_nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/arasan_nand.txt b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
new file mode 100644
index 0000000..546ed98
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/arasan_nand.txt
@@ -0,0 +1,33 @@
+Arasan NAND Flash Controller with ONFI 3.1 support
+
+Required properties:
+- compatible:		Should be "xlnx,zynqmp-nand", "arasan,nfc-v3p10"
+- reg:			Memory map for module access
+- interrupt-parent:	Interrupt controller the interrupt is routed through
+- interrupts:		Should contain the interrupt for the device
+- clock-name:		List of input clocks - "sys", "flash"
+			(See clock bindings for details)
+- clocks:		Clock phandles (see clock bindings for details)
+
+Required properties for child node:
+- nand-ecc-mode: see nand.txt
+
+For NAND partition information please refer the below file
+Documentation/devicetree/bindings/mtd/partition.txt
+
+Example:
+	nfc: nand@ff100000 {
+		compatible = "xlnx,zynqmp-nand", "arasan,nfc-v3p10"
+		reg = <0x0 0xff100000 0x1000>;
+		clock-name = "sys", "flash"
+		clocks = <&misc_clk &misc_clk>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 14 4>;
+		#address-cells = <1>;
+		#size-cells = <0>
+
+		nand@0 {
+			reg = <0>
+			nand-ecc-mode = "hw";
+		};
+	};
-- 
2.7.4

