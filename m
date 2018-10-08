Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4768DC677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A2F214C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4lY4QDMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A2F214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbeJIBfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:35:13 -0400
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:11040
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbeJIBfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zluh1wbpyaO+xMytM6KSY/vV5L6gl6uNYYwKEUYIKoQ=;
 b=4lY4QDMKYSstlxe6/FPsx9w+XU+LdtUzlKgyJTF8EwPlH8rCJFBGu6exc2e/36p6WMwQV9q/R3ODFq/laMTcRqVRVSPO8dsK1cCKAJ5vperLUR8yemi9jrGzX86UuAXEug8C3LQ0qjSpRdXn/5w+gdADRGEs6VBfKEb+ywovG4Y=
Received: from BL0PR02CA0045.namprd02.prod.outlook.com (2603:10b6:207:3d::22)
 by BY2PR02MB092.namprd02.prod.outlook.com (2a01:111:e400:2c1c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1185.25; Mon, 8
 Oct 2018 18:22:06 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BL0PR02CA0045.outlook.office365.com
 (2603:10b6:207:3d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Mon, 8 Oct 2018 18:22:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Mon, 8 Oct 2018 18:22:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAM-0006BB-2e; Mon, 08 Oct 2018 11:22:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1g9aAG-0004DT-VM; Mon, 08 Oct 2018 11:21:57 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w98ILt2K014468;
        Mon, 8 Oct 2018 11:21:55 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1g9aAF-0004D8-57; Mon, 08 Oct 2018 11:21:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <olof@lixom.net>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <michal.simek@xilinx.com>,
        <arm@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v6 0/4] drivers: clk: Add ZynqMP clock driver support
Date:   Mon, 8 Oct 2018 11:21:42 -0700
Message-ID: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(438002)(43544003)(199004)(189003)(72206003)(356003)(50466002)(47776003)(7696005)(336012)(305945005)(426003)(48376002)(8676002)(5660300001)(81166006)(316002)(106466001)(51416003)(4326008)(50226002)(110136005)(54906003)(26005)(6306002)(36756003)(16586007)(44832011)(6666003)(77096007)(14444005)(2201001)(106002)(81156014)(126002)(36386004)(9786002)(476003)(8936002)(2906002)(478600001)(186003)(107886003)(486006)(966005)(2616005)(63266004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB092;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT051;1:txpKfqOajeT7Bb0RH8r03tH961hktEbaPsMxC2dDjp0xfRtjUZVy/nfWwG1j9T1vTyJQkOrpw7d+Unn99HHm+FTN9PNKBZpY+htGDi6C9LMSvEvZBRWIka/lnm8GTwmV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d08c5938-38f2-4946-e67e-08d62d4af36b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB092;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;3:0oOpdA8K3NaJ5iJgOo8r9/dWrBGSGNaLMNIxVpGj3wkN5xyvm1ym3mJhXcfltsihgCsgtVoDrmM1I7nGK8MUzQXCQiWR16zTLRtRkmLT3HLfLJ0AEo6OXlMMygytiMvUUAC1K2dC0+AuDRfEp5mC6FCeHNW4sDmNEFQDo4fgAsV5QcomiUpVn2ooRRh6iVdhFAS8v7wj6N+bYjMMBebsZAIe0KtxyRrkefRuiWM7wySGd+leMrcTyKQ4wuwiYonbwy4IV39S1Z+Sp+yfTqOyH76Qufl1RzJaCLGLjUAeTdK6/AAMabXvnBZgB/PejKKtKg0Avm5yCYYKxFTNZRQHbbZPnYXVkjlyPCfvAjm3mYQ=;25:Xf7bXcgdZzuqyY5Lanrv5CcaS1mcTCxHTMJiMcl+uDI4BssEXKEO1VQ+Y6nFCSD1/ybsxib917OAwhzbbfC3YrgNj1q52Kni3vhL4To+LqUb8A8Qf6Yq2qTJem5ZH0xIDLXT2fYNfMLg286RW0serUEzW0Q2k05gKk+nz2rkJuakQ1aSL20AJyG+Wbro8xdES2K99y4H+7E8SBCAqlp3sq558vKqP7r63F2drEtFlCYfxNSHXe9NVYigY+B75GRQXctTPBgTtnsGaqsmqeMoW2gkXQ36WZuxASf4y7bhxaNgyMN6TQR0q5faVuXgkUHe3my+/KirjQJAGGtVjyiXUA==
X-MS-TrafficTypeDiagnostic: BY2PR02MB092:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;31:Jjq9f+SB01zbfIzLuyurdbQEPc0Z6mvNoXYNEVSUvndWyUeEYeADZ4aSwwR4K71knbyQL3DfqPbyS2e5ftOZlUZVwwqTfjcJcUT9uYvLWviefMhe2SPqvyE0LQBVdkCqc7mqAL7asJuddxvT/Z7Tm+cOa/KHotlVtnuqwgSa5HNwaa2AW5coueYcv4uJ0HmNPSnZL6saOGpehO5oj5WjBfuYjpbTj2/Ugo0KuCvcOX8=;20:XoAcImjtWUqPfjRMDNnf8D2pLAR3clJ4lzyIXd0Y0b21EIsLAvinCeSXpCnKNSEWbD8bfB0pj8M5fmSz7acCW+1TcbOp5MMewLWsZOBL51C/52ZHFs9Y/pcdKmEzl5j/7H06DYZerTKi/qz2tAf4VXi3vaO5J6JItQEp4dZ5od6CC6Nszk2djjWYO1E06FGnAFrrr9q4UYPDNVSpETIeA+MUCHnBXsYqFP8Q7Ikp0en85bG3nQGPO7ZPKa/QPn3BoouRZHS/0RxTcaSfcgzM3LNhYYZmOIM1OwOTnYMoyr4LouoHdMvg6CyAtabcxCPvQoOGhZwF6eXfPlWLRs4L9vWRNSS1oZIw15aAxyOrZp7sg6xFiDIg9a73DxLpCYGAE7rzxLlarpyp/5JN1vUb3OsDVIdIt5A2HJ82FEAbTOOsKgznj5OvIQk8UlU+SdgGM8/s7O1i6iKRHwyaYDvPaCBWJaner2FIgUwkDdI6axCvn015Npnf7x+BlTfytHyU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB09278E1F7F6E75DEDE0309BB8E60@BY2PR02MB092.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:BY2PR02MB092;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB092;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;4:XkofbwF+Xy16nYIT5VDEF2oqXRKR8jLY28ycVGbHYq2tOZBLNqEUjSqNClvj0UN1NMhJjBFOlrDhdK440XQ+7FQy/07OUox3IV1f3Xj/eK+hn46l3v+dkHNkVvyJ+IkVWPa2AD1KhlWBRfZVZLI2Kh0zSHqjdDwTQyGq18lqYeJ6+5Z7bgknHqk6K/U/q+WcNUkPjnepJAPJv9s89qDRrqaVpLSQG9cEEQ6NFLebQNCHmE08/fQeC2KMCkLJG+edepwwgWPPKgit/nuwI7GPVkOE0vBUo6uLtIuoMRBCvGQZFMOXFJZEW87jyQ9NXDm+
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB092;23:b38e7Q6hMB6CS7ZvsmT76T8p5c71JSKmlwUDyVClMN?=
 =?us-ascii?Q?fltm6pafHpUvlxb5dFQzysKvS4E9zIfnWugrkzU53+092lifaSUBx9bMHKMK?=
 =?us-ascii?Q?hYYvLjB/uhAzCu+WfEfNZHAK2TmEDtl/brSSP36maJsu4Bdxyn8wyjd3ZDbf?=
 =?us-ascii?Q?xnRhcSNa+AmeDtaHLP7asLoHDsWWInLUnC+GUAjxXPt9/y5Aga2u6wJ9BAv7?=
 =?us-ascii?Q?RudvdZQW5MdjH3FdI97dxRw2cqyAqBpj/XqypNFRAGuwexZ1hhJV5bakSKBJ?=
 =?us-ascii?Q?GoO9tNNNWKjagW5Cfny74vQJ9VsyBjd4xZACloGYKSiguMhDDBeXVqHpEzBk?=
 =?us-ascii?Q?1MUgFgCJpPa46A3984ZCu41CYTNOiTt1DUqXaE7bwq7RnrKbXLLNUtCMSmUB?=
 =?us-ascii?Q?P5NdQbyaACYVDn6Ec094pvpk+vrdLh+17B3l2maVB5ig+MBBr+4fCVoUOF5A?=
 =?us-ascii?Q?pGEzGrY3zxstQ0LDoqWK7EP+IhTE0rmqd71Z/2vUNv/m2OV/PE1q1fP/uTfm?=
 =?us-ascii?Q?jcxHbg1mZ7PcELPC8mNgbG1V2rBJkhXMUcoZBch5pVYNsrdi8lga5K7Wjodb?=
 =?us-ascii?Q?UQGRV16xJLoLa4oAc6Y/JzpFMIYuDJxq+1OQMCxgtrNy04jmkGNs09tGJ8K3?=
 =?us-ascii?Q?+sXdp4jSCYZdgfiHOeDTDuKoTGhMFdCsGIssX4XkyX50VWtmha8l9atUtEFV?=
 =?us-ascii?Q?Czcz9hWZu7q1FKGkt/2wv9iixGqp4splAPtkpSjG/cO7gnNZs179lq5r7Moy?=
 =?us-ascii?Q?tGWABqdVY02bG+SQUxwai6ljx/002/UzEntk3HwGgOsKh2cMCR1s5DeDTwod?=
 =?us-ascii?Q?Gs7WfiEqDpjnO9r1mRgpETnaSx3sSmfpsIG6SLwvtGFMwzMZuIF1LmIAMPvP?=
 =?us-ascii?Q?vg2uit0PQV/fKomXNZNUHVRGVg2j+uJ3veIKXLEH6GIce3kRDcGPjQ/LTyWX?=
 =?us-ascii?Q?BNcx91uxNKz5VQFG+JE9vymA4UV+KuO3M/mzq2L8pjvGyEPaQIqHh4ZX7A03?=
 =?us-ascii?Q?vYZhWwgxzDX+YrxlakBZ7QegJCs6Nthl7eomSj0IwuxJva5VVjcwiAduRihA?=
 =?us-ascii?Q?3F87XS2aHVMPQp8NMaZAo1hh0JEeqqMZSro8BEzyLpbm4j10i8wJv8qeXhzj?=
 =?us-ascii?Q?PP4PdunuxKDuiCEsRzuMfdpS74Z5e9vPNY5CUG/od9agki/dMnT3NFV/1qWa?=
 =?us-ascii?Q?VD65kMaghR3og=3D?=
X-Microsoft-Antispam-Message-Info: Os1XsNyOWAYWbnBW/mTdpiL7LieqXTxDWbgLxWB2bzBsVDxRNK9lDXis9FGHS6AqIiz7aJMVaBxeHbKI3ZB+CDRohO4OVKM7Kj2z9wyI0N7kdlYBw6idaq3D8CGzx6ohAM9AoOdcPTYlZdKTUq7GALVCONP+lacjvu3rH5nr5T1DZuDWgd/JBF52sciHjGn1G2+7KdMA2oKbAj9X3k+73JMVRzfq9OYPMPf3kczJaQ9vOsOmnJL1BfOFpqqk8+qqbGIWu0tqYNBeXuUg15528YNMDNm89PWSPbc1ZcSzh8g/9ski1gUihc7ZI9YM6joAPD9CYPPgxIEboGUN3tkoEwT3pNzr60i8V2DKOjzitSE=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;6:jLjaeGltmM8IsQdb2FzRwYmB/jtTlHi8NqsNP5Wg7YS+V2ZPAk3cbF/c7XyrCUrizQRzdcMR5mr4UQK363YIPnjJBHaPOcAUfL1sOqFN027VNAJu92Td67oaF0dQp4As65lSJHyLPubZM7aiRTV6RPCJSdYRWJGWhOjP8YWQtCp8cUDyvU2AsYFaJbyAREpUhJjwJuuCY1gxYomBpqUgQhM7cRpxdCWhc2ot8TUmESvBh6Y2mE8aIzvrickWX/x+mtN/zIpSr2ub87i79Fy/lf4/BzzyYlDQqf9KinaupXQEOaftaUaoUtYNQtBI2hs3yFRscHHA/bHcxZQkDPhEWkUviX2edmMWGExI4/O2pV1gGSgU/tn3patks2v+pKeVPxaMH2vvy0f0GBXWkTy/7CvTyzQDO6cUcS/L6G5PhBPHff1O1quxkjGqEoLKAY1qOoGxxYjK1CW4C/UdcrBWQg==;5:56y8AfcnfzT2J2tFNi/QgGM1A3grMp6vNi0kuoxt6ii1GYJIt4RZflHN+LXEu3xWOOtHTgoafn01wBEQ6iHKF8O1jDoIitV468oxYyJgH/0ce+Ug5mC6h6r7ioOLiee9Rz/Id1BL9w0vMFz78nyZKyk2XN8qppJ/pbRIC0Hu0m8=;7:zneUexKcOouYjY7YOluxxRyB6/UxB+qeOC2vYyeqP45Tb4zjuPobtpPNjJKxl4QPuo6qcCNrLXusQdkFGmAR7Wdam16w2llJXRI7oN51sSf7mO1vzGsLucA5VVNMPLLWIstpqgxGnbWfO2T53zvWiA7fqg4NJrQuz9ZHwCW8fGCrANGPMX//d9ftqHejvrrTxLbG3PIMAAhdJb9vRlsC98A+kc3zr999LQi26Fh7L0oB2k7gkNtYHwO8syVxiYan
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 18:22:02.8330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08c5938-38f2-4946-e67e-08d62d4af36b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries 
supported clock information from firmware and regiters pll and output clocks with CCF.

This patch series is earlier reveiwed as part of FW patchset (https://patchwork.kernel.org/cover/10555405/). 
FW driver from that patchset is merged. This patchset contains only clock driver and is based on top of 
xilinx firmware patch set available in below tree:
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=next/drivers

v6:
 - Updated eemi return payload type to be u32 instead of le32 and Eemi ops in FW driver will be updated to take care of endianess
 - Added Stephen's review tag
 
v5:
 - Added "Acked-by: Olof Johansson <olof@lixom.net>" for patches
 
v4:
 - Fixed minor review comments received for v3 patchset
 
v3:
 - Added check to pass only valid ioctls for ioctl eemi api
 - Added eemi documentation including ioctl details

Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (3):
  Documentation: xilinx: Add documentation for eemi APIs
  firmware: xilinx: Add zynqmp IOCTL API for device control
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++
 Documentation/xilinx/eemi.txt                      |  67 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  10 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
 drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 217 +++++++
 drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  42 ++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               |   5 +-
 15 files changed, 1919 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/xilinx/eemi.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

-- 
2.7.4

