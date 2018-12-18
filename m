Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB95AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E56218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="1EFaIp34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbeLRNp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:45:58 -0500
Received: from mail-eopbgr730040.outbound.protection.outlook.com ([40.107.73.40]:15936
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726379AbeLRNp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbx0xQWgO/yIjTk2fcB1S4RIVnc0S2HjlR1t8tekUKc=;
 b=1EFaIp34BXKFTrEkrJBIm4dO9C4gKZy37T6J7SBw0psVEFcNUXVbtSfcqVTTZNnD7ShmSDIunxiJLYjAc5B2mWjmCwK6WF78xgRaVN04qYp9tne1sIv0K7PqfLvPUTRcDlX/bZ0nywGDDD5e/qoKLtQB0+O5keWJW5Wm7rCtCSU=
Received: from MWHPR02CA0015.namprd02.prod.outlook.com (2603:10b6:300:4b::25)
 by MWHPR0201MB3513.namprd02.prod.outlook.com (2603:10b6:301:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.20; Tue, 18 Dec
 2018 13:45:53 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by MWHPR02CA0015.outlook.office365.com
 (2603:10b6:300:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1425.19 via Frontend
 Transport; Tue, 18 Dec 2018 13:45:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Tue, 18 Dec 2018 13:45:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gZFgy-0000gg-4a; Tue, 18 Dec 2018 05:45:48 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1gZFgt-0003k6-0n; Tue, 18 Dec 2018 05:45:43 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBIDjZ3r024450;
        Tue, 18 Dec 2018 05:45:36 -0800
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1gZFgl-0003hW-9h; Tue, 18 Dec 2018 05:45:35 -0800
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 7B207604FF; Tue, 18 Dec 2018 19:15:34 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <kishon@ti.com>, <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <vivek.gautam@codeaurora.org>
CC:     Michal Simek <michals@xilinx.com>, <v.anuragkumar@gmail.com>,
        sundeep subbaraya <sundeep.lkml@gmail.com>,
        <apandey@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 1/2] phy: zynqmp: Add dt bindings for ZynqMP phy
Date:   Tue, 18 Dec 2018 19:15:32 +0530
Message-ID: <1545140733-20689-2-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1545140733-20689-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1545140733-20689-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(189003)(199004)(103686004)(39060400002)(26005)(446003)(11346002)(47776003)(90966002)(63266004)(356004)(107886003)(575784001)(305945005)(52956003)(14444005)(6266002)(126002)(486006)(4326008)(476003)(2616005)(186003)(426003)(336012)(110136005)(54906003)(106002)(106466001)(36756003)(8676002)(81166006)(81156014)(478600001)(42186006)(2906002)(50466002)(8936002)(5660300001)(16586007)(36386004)(316002)(48376002)(51416003)(50226002)(76176011)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3513;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT006;1:qJiiFZbFnqae/yqZXHIMiedLzNeELhCniSlJqzInduhtseeK9AkBAs5deCV/+aXhnLwAw62eHKIZaK/koFeuyZ94hVAaijQ+PiqaSLjKeloxQIreXG9eDiZhqe5rLejP
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55b5ebeb-b6b3-4f2e-1595-08d664ef2058
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;3:VxQcdfZmfj9E81mmh80Iw5diU8LxL14xfeLFgAaF98IptZScSgTZTHfnbIxf/BezE2MgZDy7qqCXEmkpB0WcEe+hNei8jt29FEWDV2fcXbAUIsGDPkvj5fBM0OTGIbyIu6b96RW3gYqd4Mu5sb4vVvs82dOm1miV1Omk+ak7nP4S1YeP6hva9asxNnrHE/1L404LzrqZaBWSaaECaY04AtFJPTX2EbPuhUjoVQvy5UXLLtA69clRbRulmLgo5yYCuOpT5WKrjDIc2EZew+p+kVtv4/VsR8krxR1VxXpLbHrpkhLBjEBARuhChtrQszksgml7ZWD9aJbYUapeL9abAE5o9G1rMClw2c2lE6pTk68=;25:ZQHrUJZFczQROqI72dKMj6tjD7ogfY+K6LOsnFvx7G1cAUQJy6WL6eSJ5Lod0nFpavsZTCsZMzk+4Lz3NDbr6WOOR+Evf2rtm4aL8tzQ5rLBXsjkoBLt4w1vN+hOsPIqhzVPbAn8Jul8ujber+MKvb2JOGdM1EA/+kDzstkxnRS4YMe2+kunm0ap3g9uOXjI/v9iJMwH7eVkhal/OGI0tpE+INqmHVQW04Xgfde1korjLwzaBu7cA9Iy9I7h4Rdt1TvHN6uCfsIfy/YvDdac5zoK2lkge2WT6BNKJN+IJFS6LH1xby897s2GK7nmdPYsNFopF6FHOaJnScX7XAzaEg==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3513:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;31:M35AyRa+dw3hDWYOsuUoOhSqb1Cdma33QM55xUEFSPsxGBZt57haSR7IOkk/RvtcoxfD3TziaVZzBfYs2fmcQgTnkBaWYDqjwTX0o2Wv9v8jQcBQnsMlLL8uJaI6BokAzLNnBCmhiz6zntAd5m3WbuUoQEFcW0nYAv5NUY7gFvrH/oG5wKK3GBruHcpAgS+vBtdnoIioUjkmh8wpiKWBtn0KkOyaIKfmqloYvppRNm4=;20:Q5gZa5+jVvkmap1+/Q728Xzln16bvBAxQtr4AVhk6MUzDvqBp6tJNmwLdX5WxeTh7UZvWkRphSgXC6zPeNNE5/a6VqI9d4woiGuHFiiVarxqlneSPLR+0Yvv4CAHUMaenRvcDiqDv6TnAUbdtylza1UcbavcOwpxRAx2NKFnEhtlhTxNMTIre58e5TLIUMmthtFrfdOAgARHcZE5P4iIQNr2AHNN0j6+fxnIa2hkd6wHMjgapJbqAs8K+NMTo9zeCj6G8dnUrOVde2g9HsTtySRInUk/CNBrckiJ+Qegu6XtdZHAFh7TeWej+PPCorLJ53mzXck+tTGsRJAK6WxBGoT2i9tNK6l3kjXnOI5m72SxeYnXZhLavpUN100VgOLAlvFQFJyWqWb8V2mUowJlEyVbcT2rA30JXqCaX+VA12sI3HmoZdv1NoqXqemva1/c9bUedNobTJ5lwKTDG1mnKquT0UpsvMA4CiZ/MnDY7KpdzwQwahDhdXmYp7Y1K5N2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3513DF9DB89B8DCCCD882EDCA7BD0@MWHPR0201MB3513.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:MWHPR0201MB3513;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3513;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;4:TNlrlIk39dnz6+/z+meP5lAKB8OfW5bXrIGRmD1GwZNl59MFVqPDIdo8DEs3PFk8hHX56qeND8tdU0p8jRrs+4S6I0wXD1Io+acrE8m3vUJsHY865eDUt9UaR8ioPEAJyte20iq6roctVCAGV8XIKLEh5/KgUG4lSoY3bi41cJHFjSAGnw/JnmmqbAGb8nzW0Bhqamci7BIaFi6L6xxu7UjUBcjnyHZpX4829Ra0wqdzY/00z6G9cOIgFORjXZXIjt4tgvLQLNIgkVgV/ZYJzw==
X-Forefront-PRVS: 08902E536D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3513;23:vNX5tUZkw5SxBnz+YkPu7PaTuu2T+W3J/sTKidE?=
 =?us-ascii?Q?v+GCAxSL99gm+ElrT+S++EXrZw0X7Q/g2fOZdIZAyvvu7jkgZ/HZWiL7iEXq?=
 =?us-ascii?Q?cJSBELVJtqLfMODNTGYNNFttlEtRess9E1aY+HFDjUv1sLNLxuvyKaJ4JQZ+?=
 =?us-ascii?Q?+E5RykLBNLbRbQqRoLgpUzc3aXoLzWiKzFnoN0SePtDMsyUIdpUkkLanHqma?=
 =?us-ascii?Q?rvmXixDqxXaRwegDuI43X38TBCIT3+XCgkOCpKbjTMGSGFyfzl7yjIVYz2Fh?=
 =?us-ascii?Q?dnWFiBxJbN2IE1s2DK/poMBYhM3QF6VbMh7bcPqc/l1bn+eGIIVWyuVt0r/Z?=
 =?us-ascii?Q?pA4ETK8dQZfJRHjsBcPS59YnumysnENpDGH4FTaq1PL39sBRCDr2O4mH0an/?=
 =?us-ascii?Q?JGNUcEIT1Pd+cF+f44u9X2rFkJO9ya1nPsNurz4wrbeQya/OLamqFGksgBPO?=
 =?us-ascii?Q?oDPtYHfwbvQoEb099wcma/Ry6gptCf8P+p+8wdv6WVe8fS5vbgxVBzcfy2Jb?=
 =?us-ascii?Q?OT57F1e9ut97TVH4MoiPFvjdy1+W78n5a4WWmdrxTi+7m+59YD8z+VwMDPiV?=
 =?us-ascii?Q?Qngt49rUJRuW72MdNTiLVqYriffw6cCv6RpnNH0+9xJ2BxA3kcYdM/j6iB+U?=
 =?us-ascii?Q?lgnXzxXA7X/zHkp3R98GEl5euhv3ALjmE/YK4CWMjId1FXx6JFTkPvt9vSUH?=
 =?us-ascii?Q?xcX3PT0rclZX4QISadEuNvEQkybVsJcJoNoqyR8TOfOcZP5oB6yokRdc5q/9?=
 =?us-ascii?Q?e9ZXAulpVnmyWK65pcuS/NJM7i5G/pa1hSencQ63M+SnDoy1Lln8Yssy7g1y?=
 =?us-ascii?Q?7ruR3y45ThgMmU1+g55NQrc+SaKfqLFBY8dO45MDHk+lDv6QquHtAwmhglUd?=
 =?us-ascii?Q?ZhMOtllJQsG5gh3xtfhQGG5Uaj2TKLwLfbkezQnQ2ai4vtVz8sVM90ZfMigc?=
 =?us-ascii?Q?YLpwMOhxqoI8kmCES9qY0Annv+Li+6Fw9LZ1klq3BA95rTooNtiZnlFsts6h?=
 =?us-ascii?Q?8wRJ2kSDUprzwa6M2QaYjpaS9rNtocBbe+lQAJ7KMS7P5jpBDVrZKMKkmtfa?=
 =?us-ascii?Q?/zT+xl7KVfUskyoztvVnm4q7ZFnJXOljUc0N/oWYvTLJBu5AA8HrkhJaYm26?=
 =?us-ascii?Q?HUMWG2DezZgVAywDYPvpTtPDxZjDrKTFqsLLFL2P7wv4dXRDJy3tXSapTECv?=
 =?us-ascii?Q?0VMSnumJ6i1qodeo=3D?=
X-Microsoft-Antispam-Message-Info: mdYIL9ylmC9kPiWkWH1jvRpc0LQv4RC35IU6F1XR8U6Z3aGrNC97NdH0IgvGTw6NAjqPL3+KHgGgPaHdmNoNSRxRwB+qH4Je5pi/oai3BU9UwTZr77WLv/EuLcOhVJjoPqoVdhdtc0OhttWbttO7egj9MfCdreK+2yRZ+AHMWOGEjX18lq/aMU+PfajCXUtYjSfDPrXYYkXnxWhlSfcegKVj8xwLzLRCkgaNRsMgpUYnwHAgttMhxQSLmwgniijewbHXFyYmPOL+Hx3qQANoBLGa6WMfhCsK+KWB3128Uznc6TddnZbVr+fUBYJo3zFW
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3513;6:uZ0ezbgdx7rDwDOC3uCayslXKkzmYTHZuaHQQxQCmkflrZlaluq9H5pcpWbiVV6aFcNv/WjORBpUirCiCV/szhQSwVMAgPOdXpP/kwYpvTiH5uYEzpmCTBw6kFfha5BvzrBcqZ0YHAAdNE1OdfwpP68eAdgQsuaJXyhaY6P7ugDbNSxsPqQgn+Ty1LlWfZE56DcOJMZqxU5HsWNsUtIJPC0umjHbxtJ93zURr2p3rG3AW2Cikp/Rvx08T10zwoFDEvxld/i6vaCttMtV8R+9uHBFd/2IJV2EH0yfTAOJJ21WZR4vs/JTEaMS1SWF8Y+oxSzsIKsfBx2WF0G9sk2+Nc75mn9BsgMO/uzV4/LjjwD1TuVvCnd2UPiBpJnlgiIHTX5Xxp1Iur1upo0sYlWn8owMOrIKyTJOcazfEw0YazVlsxaWrvB5E0tmEPUSAG3PyKJyjcE7I92f4ZGecEQGTA==;5:KzPPS1QTvrldZPe2UW/Xg4Bl25+4Nh8b9DPe8pPxDDdDN3LIl1rMj1dTUBqblpuXdmIuK5YS2LDc3ox0ptRuRBoVXh92lU32PFKBbI322h1l+ELZ5FRrMUbzIC1pktx8p4f92KxYM7kyN58hHrT+zBfjclJMGPsH4B18eiymBZA=;7:ifVWb72ImEHDQM4Pq/0uqf9azc/b9ZT3zHKt77N7BG6yls3c/EhxJcVjadp3GSVBv+Fqvub4T06EYh5fEZA40FL0U4PPsVFrGNBqLzymJt337cXDaHmN7pnnmwRilRRu4PPSEQN6vQv0ArGUBWimAQ==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2018 13:45:48.8670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b5ebeb-b6b3-4f2e-1595-08d664ef2058
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3513
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the document describing dt bindings for ZynqMP
phy. ZynqMP SOC has a High Speed Processing System Gigabit
Transceiver which provides PHY capabilties to USB, SATA,
PCIE, Display Port and Ehernet SGMII controllers.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v5:
	1. None

 Changes in v4:
	1. Fixed the changes in phy-zynqmp.txt as suggested by "Rob Herring"
	2. Moved changes from include/dt-bindings/phy/phy.h into Patch 2 to 1

 Changes in v3:
	1. Corrected the Documentation as suggested by "Vivek Gautam"

 Changes in v2:
	1. None
---
 .../devicetree/bindings/phy/phy-zynqmp.txt         | 109 +++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |   2 +
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-zynqmp.txt b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
new file mode 100644
index 0000000..3605c5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-zynqmp.txt
@@ -0,0 +1,109 @@
+Xilinx ZynqMP PHY binding
+
+This binding describes a ZynqMP PHY device that is used to control ZynqMP
+High Speed Gigabit Transceiver(GT). ZynqMP PS GTR provides four lanes
+and are used by USB, SATA, PCIE, Display port and Ethernet SGMMI controllers.
+
+Phy provider node
+=================
+
+Required properties:
+- compatible	: Can be "xlnx,zynqmp-psgtr-v1.1" or "xlnx,zynqmp-psgtr"
+
+- reg           : Address and length of register sets for each device in
+                  "reg-names"
+
+- reg-names     : The names of the register addresses corresponding to the
+		  registers filled in "reg":
+			- serdes: SERDES block register set
+			- siou: SIOU block register set
+
+Optional properties:
+- xlnx,tx-termination-fix : Include this for fixing functional issue with the
+		  TX termination resistance in GT, which can be out of spec for
+		  the XCZU9EG silicon version. This property is not required for
+		  "xlnx,zynqmp-psgtr-v1.1"
+
+Required nodes	:  A sub-node is required for each lane the controller
+		   provides.
+
+Phy sub-nodes
+=============
+
+Required properties:
+lane@0:
+- #phy-cells	: Should be 4
+
+lane@1:
+- #phy-cells	: Should be 4
+
+lane@2:
+- #phy-cells	: Should be 4
+
+lane@3:
+- #phy-cells	: Should be 4
+
+Example:
+	zynqmp_phy: phy@fd400000 {
+		compatible = "xlnx,zynqmp-psgtr-v1.1";
+		status = "okay";
+		reg = <0x0 0xfd400000 0x0 0x40000>, <0x0 0xfd3d0000 0x0 0x1000>;
+		reg-names = "serdes", "siou";
+
+		lane0: lane@0 {
+			#phy-cells = <4>;
+		};
+		lane1: lane@1 {
+			#phy-cells = <4>;
+		};
+		lane2: lane@2 {
+			#phy-cells = <4>;
+		};
+		lane3: lane@3 {
+			#phy-cells = <4>;
+		};
+	};
+
+Specifying phy control of devices
+=================================
+
+Device nodes should specify the configuration required in their "phys"
+property, containing a phandle to the phy port node and a device type.
+
+phys = <PHANDLE CONTROLLER_TYPE CONTROLLER_INSTANCE LANE_REF_CLK LANE_FREQ>;
+
+PHANDLE                 = &lane0 or &lane1 or &lane2 or &lane3
+CONTROLLER_TYPE         = PHY_TYPE_PCIE or PHY_TYPE_SATA or PHY_TYPE_USB
+			  or PHY_TYPE_DP or PHY_TYPE_SGMII
+CONTROLLER_INSTANCE     = Depends on controller type used, can be any of
+				PHY_TYPE_PCIE : 0 or 1 or 2 or 3
+				PHY_TYPE_SATA : 0 or 1
+				PHY_TYPE_USB  : 0 or 1
+				PHY_TYPE_DP   : 0 or 1
+				PHY_TYPE_SGMII: 0 or 1 or 2 or 3
+LANE_REF_CLK            = Depends on which lane clock is used as ref clk, can be
+			  0 or 1 or 2 or 3
+LANE_FREQ               = Frequency of the reference clock, can be any of the
+			  below mentioned based on the phy type used
+- PHY_TYPE_PCIE         = 100Mhz
+- PHY_TYPE_SGMII        = 125Mhz
+- PHY_TYPE_SATA         = 125Mhz, 150Mhz
+- PHY_TYPE_USB          = 26Mhz, 52Mhz, 100Mhz
+- PHY_TYPE_DP           = 27Mhz, 108Mhz, 135Mhz
+
+Example:
+
+#include <dt-bindings/phy/phy.h>
+
+	usb@fe200000 {
+		...
+		phys = <&lane2 PHY_TYPE_USB3 0 2 2600000>;
+		...
+	};
+
+	zynqmp-display@fd4a0000 {
+		...
+		phys = <&lane1 PHY_TYPE_DP 0 1 27000000>,
+		       <&lane0 PHY_TYPE_DP 1 1 27000000>;
+		...
+	};
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index d16e875..09cc0a6 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -16,5 +16,7 @@
 #define PHY_TYPE_USB2		3
 #define PHY_TYPE_USB3		4
 #define PHY_TYPE_UFS		5
+#define PHY_TYPE_DP		6
+#define PHY_TYPE_SGMII		7
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.1.1

