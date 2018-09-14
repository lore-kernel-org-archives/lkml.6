Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182D1ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D5420881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 19:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="T+w+Eeam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D5420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeIOA4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:56:22 -0400
Received: from mail-eopbgr700040.outbound.protection.outlook.com ([40.107.70.40]:35328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727598AbeIOA4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1VHz+IFkZjuLtKIvJ89/fu8l1cntsR3ySRpTLC8EWk=;
 b=T+w+Eeam426BTzKrpYtZMpj/4YYhTs3UsgLrOCHSdf7ku4x+5GrRCxOPJhQ7f89s55ga+BlW9kyNzVUZ/OPW5g0NYD+llvKMpMoPR2+2WW6z0LdpDl696vMT47szC+sgjrNHu8eRCIdGN0IW+NO4IHik8m+n5Bk2/3QpzQFGQuc=
Received: from BL0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:207:3c::48)
 by SN6PR02MB5118.namprd02.prod.outlook.com (2603:10b6:805:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Fri, 14 Sep
 2018 19:40:20 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BL0PR02CA0035.outlook.office365.com
 (2603:10b6:207:3c::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Fri, 14 Sep 2018 19:40:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Fri, 14 Sep 2018 19:40:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0tww-0005SE-Kw; Fri, 14 Sep 2018 12:40:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g0twr-0006TC-H5; Fri, 14 Sep 2018 12:40:13 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8EJe2Pc012221;
        Fri, 14 Sep 2018 12:40:03 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g0twg-0006EA-2l; Fri, 14 Sep 2018 12:40:02 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v4 0/3] drivers: soc: xilinx: Add support for ZynqMP PM driver
Date:   Fri, 14 Sep 2018 12:39:47 -0700
Message-ID: <1536953990-12755-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(438002)(199004)(189003)(336012)(7696005)(63266004)(316002)(7416002)(51416003)(54906003)(2906002)(107886003)(106002)(186003)(36386004)(6666003)(5660300001)(16586007)(486006)(39060400002)(8676002)(2616005)(110136005)(126002)(50466002)(48376002)(44832011)(305945005)(106466001)(72206003)(356003)(4326008)(966005)(36756003)(476003)(426003)(8936002)(50226002)(9786002)(6306002)(47776003)(26005)(77096007)(81166006)(81156014)(2201001)(478600001)(107986001)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5118;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT062;1:N/+rTvdwRpdjMjLf4I9WZ64/kJ9Qq/6d2XIYdvy20cJD+mk95g6fbmfV/wpdGNqaRdX5lXd1bB9/JRTdRh/fFEthcIFLJhopTLc+Fcfn5dZu4VQEgBWoOLCAxB8yAu3m
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8382aa73-d2a4-463b-abca-08d61a79e797
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB5118;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;3:5I2jn8um/KEnjV++Bgu+HuIKlvnteXpsxBzbevT0AGjBf/lwYW59JDZ8wC3AWS4F3Cmm5uowAwZr7cj3wa/T4n79qEJEkxx6vPG4hjMzXwWxsSC+j7SO1YE5EOvoQBg8IrWWk7rfhQa96cvalXdGq9EUZAlUIqBtNft3mNC0cBUzdh00NcL9WOjPQh57GfOkdppsZOAlkDuZUORe9Lm1byFZagG2Ud7TFylkAuV76fdxOHdA5Iy/nqXcfH3xyNS3kt2pdGXGULnryU49cn4yMYnbLs5PEgQ/Mkmkg8q76GnZ2XZ4qFSifhdtWeDFeXiYMEelwJwUQaRE3TroXkmY34VhsWQXAhUf6lEqPgo6bHc=;25:bsea68S1mk5idDaeqiqBV0xoWuHKu5bCtbLbR7nJKqQRKOt3bVjZ1UgK13tv0WMK/zuNF/GZ5TtYssIUZdE3Co84GB27E1u5aY1OQhNvyacdnOzL9smoX2u60WECfW29+9ZnQ3+/OwPu2ewsbMKPBqOoHYcCSlMd3QMiUPjbB1hAMdRC3J+ENX6gLbk2sIbwyxlMpbOmcFMtnY+hlGcyKrssCl42/0xWwlBFKSRIDt7J006/dK7fWrOnOv5OinDSa+s/KxtNq5izYF5w0xdUCYQsEceWtUzV3Is2Eu4brMOVM3BiRURjvSs8Y81DWofj/b6eDgkw9cepvB5P4MVoJw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5118:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;31:wh8SvJEZWtGz6M1wlMRzffrxpI9nImjg7thEcfKYncyfNmEU7hKaXzMyc6My9h0H3Ss/Xlx/z28wtZk5djEEOwFdrcOPSriAqR09l/UPKusCZ/9cT5v6B3KimdjsV++gAkoZV07nUiep+6fyCuzQ0sBOIJ/A0arqs+PzEHVkTDLWV3Bx5TcoiSGbFXRN+198ihHGoS0rfE0osJdPu+FZva/bTA5rBn2u16tgDLO5RFg=;20:nwwZRiZOWsJYltPqCxeu6rupaP3/C0qRs3p6EGCKa9Ve+JhO0yyFYbr3BloPFjBR/zZUqGlKKo/gIZuuJ59nsCuitfIVkjC3Nzc/0tMqqT5BB9XcwofioeD5mWNWCUrfJvc/SN2idaaZ43/jD4nIkCv7AvzRTB345rU2pKP2qryctm3aYTbTknY9HIXuGit8ZeTKMoAba5som3SjUR5OcU7q5VTAlMca8PN0iJsusWC0hAnjo02NbUGrtOWacMvLAI+/vgcGF0sB58IAwRRAr7zbHHQNVjyRTVD7epuciKuxjZzZix3g60Tga173NrLiHS2Emc1dSzO9juGYA7Po4fsMSlF/hcDz02vUV7QpAHGS7FgQftwX5yN6YV2T8DT/0531nQYHrwvWgWTdP64aMl0mTWO4cNdoEx9k4sei6+QYAgmx/wYx3Df7G6yZLsrTNVTDoWU0w+Ka5hK5HDrrjT0lQygZmFNBbYmI7haMy6b1EcOr7mScoT5lnZeGeg2v
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB51180F9275706373A225B027B8190@SN6PR02MB5118.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:SN6PR02MB5118;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5118;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;4:uWjAZ27Z62Z9LiQDJq/FfvkYRCLF4mDPhUFxb5STgtnx0+lM+z5YUFjAfnhNhaEgiNdXmL64TTXbZW/wNyHP4J21sEcRiIra/ghn3eCehBrQBRCs9QAhCKgbDYlR1FDlJn3dcrg9QBUQaDirAExThHXDJGml+vIdgdC3KbFf8x0jM7i3z2z1vPHrNetzU1QMZyUYIKTBFO6k9Sj4eR8fFCvtrMts5CvDhkJK2H532848nTfRfGDuvNpbuxbD/09mtFwc1gT8mTNPvfIF/sJD0g==
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB5118;23:8Vxx5m4o8aOes24/Klk0K3kY30ENmNp1F5xdUFhg9?=
 =?us-ascii?Q?YIHqNC9J9MsDgB9JCAQD07HsYHBcaFgT31s3RJ0FFWFVRZPfQ2WsL3DAtaY3?=
 =?us-ascii?Q?4gG/rWHjc8fOGHW0Iw2v3bbX0c/wZFXbCCs7Aglwb9KWrcL8he719kZsjIzP?=
 =?us-ascii?Q?2RH6upysd6dh5v7/DdSfQ9GpBAK7Pm7f8TtYJBu6dUSKfwYq5ViNG7HlaP2j?=
 =?us-ascii?Q?zkF4ABqykfUNG9VSEll1n+lWy0ploUeZL2ccyZervKw7jueKScTbeM3Gm4Jg?=
 =?us-ascii?Q?KDQxuOGRcPPd0+hGfcK0rKQf3fcFPHAdWNC8EFJk9MKfaE4v2V9rgl4itRP6?=
 =?us-ascii?Q?crxeXrxcd9MHDdY+xQePeH1gU5nGSMDg8/iVmh1+gKWMAyf3JTllOwRvcliC?=
 =?us-ascii?Q?zFjkTy1NCFAfzau4AfpISS8uHDIpesvPyfk/ttMlZrZyOqJ20myrEc1koK6p?=
 =?us-ascii?Q?D4W7y0dj6d8BQmfyDId9zoZ1Jabt6ghBXYCpMCv2JCr+XZF6YQ8CuKibWDq0?=
 =?us-ascii?Q?U8lE3EWLDuoKAxUZwgvvIWTsO9WtMYog9cnl6aO9uTCKaOkTTL1oV42+LMp2?=
 =?us-ascii?Q?kwICfVWCpd3915KeQ3AfyX/M03XJtVDSssKDsIwkij4A3vSJemHqeY4d2l1N?=
 =?us-ascii?Q?A2Rj69l5AaFR/Hw3r1oinBNjVIEpLZTpR+28Qa0FHtVnvgs6P+s/FPlSjYh8?=
 =?us-ascii?Q?LDQXLn7ATk13eL23KJQDCXiyr3FaeSkZNckJFWPXUAxWJ25iGMzkh0tGPw72?=
 =?us-ascii?Q?rJNqz5dUIMnvBuQZw/XKAUHTXAxNGRnfB8bnCDO3t7Ue3YxT8ov7xbtui8Xv?=
 =?us-ascii?Q?PzQOlIBEOr/bhdUl4pkaVoL9ZWpyGsjJIeYmXObj+t/tdGXzdQYFY5pfDltx?=
 =?us-ascii?Q?UGiiAuMlYKcIuuJKiBzmvBhETlrYcttwZWJTmULpWIQMDV6L5y9YzkeMh6Cl?=
 =?us-ascii?Q?gStGMvjkNXwFvrVvx9Zgd3GW63jk9XBbg3PVA5S0b1feXfMcp1Ib4HSNeFsI?=
 =?us-ascii?Q?PdEQVNm/mnXGBtxNmp6qBVXL3GUlPkbXO1ByzvT/GAaXZzYXTTVELcjMGQdY?=
 =?us-ascii?Q?f6HBgLEPvxNNglyWtSNDqCy0cW/U2nUyECilAMO2PNOLNuBWjbcQhifh4GW/?=
 =?us-ascii?Q?HeWe+kEJWDjM8S7BMSXFztsqaUJ5ctSRsd74eEyUWN3cyyulVFvebONvCrPE?=
 =?us-ascii?Q?1TauTzhbfFx+HO6bSMWYrw5HNIsPnAGBJEOoCcn5wvYosdCr+N5LlvwkHrSN?=
 =?us-ascii?Q?zFP3I8xY3JoKAN67Z5meQiHI1SHUHEW1m0cR75lKj2KVWmeDIQ3/2rYEe5GK?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: eS20hSHxzDcy92YVL4XgH0+hCgAk2XJZKfzJpG5X7E5LgNpalsXwRQmG7WJa94BDJJlEXhkiLTMxfjdg+a7cK7mSCIexU+Awuad8W+/cyX46SIZuucPaF05OnaJ1wHTLjTobL2VSWnOIxaeALh7QiQtU2kExat40sR0sq9mEkl7OQ10sPFvahF9hibomZNL0gKHuaUgujaLDLOV9A8w0GE1Mf0VCEJycIP0mU7WZRyrOfoEjhx6m12/vYzpG5/pe75XbcF6n5MFMuXMml+rAtMC2czBN8uCs5jsYDLht3vy1QLyj/waTtIBUtlcIDMfofRJYmjVxQa4kh9ggF/rTAJYkvCJB9L2LCCZt8yupiw4=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5118;6:3Ab0keWvelQqOhauL3LUB9alqC6iCVVmZVDADybuQpZ4Ld3De0M4e2ihDEXWdcAQNFakdiwsH5g3R4UutD5yEKWDCI+TLsNiZerdPj/TqHVfLZS0JkodzrViYPw6B1h31xf6HnzGQtF0f1xsVeUBBTcIM3Q8d1V3rteB9yEGuKFxwLC383gCpBwVychxiAZzspDJMY7u6eTDzZFYq0d9V0XRuwncVAY1Guym36PR51bHSk1xpMl1Xc+m7gNoIHv4orrcwCCt/e8YGfetlZJvCAbr+tW/a419O/Kq/mAUT9udTCduovjXknTkm1qj9pGzN7TrA966D4NZmrcNULkA2a2WRxYZMN+z6AvE/r58pGVPPLpTvMKE1hP8g9ImvDmkzVuk8GPOvW0CZou2AWD1EVmMAbAY5rkiNkN6PgBQ3SELMVTQxypDBiDgAsPPZS8Tl/cKsq0xdlufJgZpVZ6ntw==;5:DWB5CkWHfKIhnOvqRsxfCJQiJrmfBZ99OZl+q/LOyWdSnK77E4malyLRBZy4DcBhDWXi5+XulBOEtms/F/V57ld7jGP40AVcAcd0G8YHfOAFMoafYmQ/oxBGRx8PF2CEyivcO9cQUZI+r9GYnhUBlPD+G2ustdUDBvueuphDZnI=;7:nVw5/m4RsTmPysICjg2Ezjwynr06ii28WcqfkC/wN40B4BvPMF8AWxn9aJyfvdxvS7p67ps0R/o2uDFLk8srS0lVGZcmS4XpfYJyl4VtfLNrOmtuyJNDO7yk6ibNxXbaM4mFpp0ard+ah+eScPPfLezc22lZ7QGmq+7Ox92aFl3wD6o3NFkPFurjFEQnmJXYWI9skYCjraR3E60n/wGcElkMa1y8ikN3QM1gKWJ1ocFxfGa6qzG3vGpq+xwVLya3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 19:40:19.1314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8382aa73-d2a4-463b-abca-08d61a79e797
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

This patch series is based on top of Xilinx firmware patch set:
https://patchwork.kernel.org/cover/10598195/

v4:
 - Minor fixes to address v3 review comments
 
v3:
 - Updated DT bindings as per v2 review comments
 
v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver to use shared interrupt instead of mailbox

Rajan Vaja (3):
  dt-bindings: soc: Add ZynqMP PM bindings
  firmware: xilinx: Implement ZynqMP power management APIs
  drivers: soc: xilinx: Add ZynqMP PM driver

 .../bindings/power/reset/xlnx,zynqmp-power.txt     |  22 +++
 drivers/firmware/xilinx/zynqmp.c                   |  29 ++++
 drivers/soc/xilinx/Kconfig                         |  11 ++
 drivers/soc/xilinx/Makefile                        |   1 +
 drivers/soc/xilinx/zynqmp_power.c                  | 178 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  20 +++
 6 files changed, 261 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.txt
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

-- 
2.7.4

