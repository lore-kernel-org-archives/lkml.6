Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF0AECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEEE20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 12:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CS/9aMft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEEE20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJYU6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 16:58:44 -0400
Received: from mail-co1nam03on0078.outbound.protection.outlook.com ([104.47.40.78]:55472
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727244AbeJYU6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 16:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw8gAFzjyZUfQ7ttHyn3sX5wOYy+HzdyMfQqSqCzNyw=;
 b=CS/9aMftZCeR5lBK37Hx4w7ZmSbcurHyS72SXMDZn6eHvE18WUGU2rUmcTgOqPQaWTA8TPs+GO6XiMLoHU/1Bxcc4sk+GAB2UJwI1UCFbmEpBUdBew3jJkUrnSbJkQrb3tpSM2BHGi5yPgLpAt7E6P3hHrUfAx06kvjqrR6T4k0=
Received: from MWHPR0201CA0024.namprd02.prod.outlook.com
 (2603:10b6:301:74::37) by BYAPR02MB4453.namprd02.prod.outlook.com
 (2603:10b6:a03:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19; Thu, 25 Oct
 2018 12:26:07 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by MWHPR0201CA0024.outlook.office365.com
 (2603:10b6:301:74::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.19 via Frontend
 Transport; Thu, 25 Oct 2018 12:26:07 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1273.13
 via Frontend Transport; Thu, 25 Oct 2018 12:26:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFeiD-0004dL-R1; Thu, 25 Oct 2018 05:26:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFei8-00057l-NE; Thu, 25 Oct 2018 05:26:00 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9PCPx6q021632;
        Thu, 25 Oct 2018 05:25:59 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1gFei6-0004vY-Qy; Thu, 25 Oct 2018 05:25:59 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>, <nava.manne@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: reset: Add bindings for ZynqMP reset driver
Date:   Fri, 26 Oct 2018 17:54:23 +0530
Message-ID: <20181026122424.30831-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181026122424.30831-1-nava.manne@xilinx.com>
References: <20181026122424.30831-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(426003)(2906002)(106002)(16586007)(5660300001)(316002)(110136005)(48376002)(51416003)(26005)(7696005)(77096007)(50466002)(76176011)(36756003)(47776003)(8936002)(50226002)(39060400002)(63266004)(9786002)(81156014)(81166006)(6666004)(476003)(8676002)(478600001)(11346002)(106466001)(446003)(126002)(356004)(186003)(486006)(1076002)(2616005)(336012)(2201001)(305945005)(36386004)(921003)(107986001)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4453;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT011;1:EXTjZVhV2Tyk1qKmHX8VYd038Nikil3i9oPu7ZNEMfxDxjOSikELPbd9+sUrj+YWfw2WH3+qfTA6T58agb8g4QJ4XG8KEHiHluuLAvb3e5YciLumVLj+H67CAeY3F7SJ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5ed227f-f24d-43a3-cfe5-08d63a750994
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;3:Sy82i1TsI0xmuBH3D0FiCXc/ZrDkuwGxZMsBhX+rgjIpFcw/zmTX+kg1mXatpwaZRDUcwkHtKCywVSNj9IUpoIRWyV22vo3ZFYp+LAE7iYhq5WJwZ1wIi7AEVIEkTzxC5bd3Y5+g6+OsvUVJD/PGe6FtWqgCyUlyVJhcuk7CIbi8Bxaq5lVI6v+t4tAGQEXe4v/NEn9fjFw7oNptejw5R91kwll/edsDZ7apFJCD0LwSbcmg0dIhbnYRw+twZrKlll0VkIGv6ESKc+OnDvoAyHXzLXsg+K83Mu8ZSC5xGj5I6ETrrvpn5iUJCAktuv5olRNGV/vitixw5u957fOwmv7qVPjETvl96dGljgR0Yvk=;25:SBLKtkPMZqHGAPGgHwpFxKWmBlknzYDSS3QRMkGwt3DX3r4XXPl0mXoRhNr7wuWnwQfylROYAYqCvb6JT5pEB/BpdRx8FpfTxjOPKstQXiC5gG6r7QUqHiOOvDXkYDWwKE3J5NYv0A0unNS8s8gmBeLeEbegXeU+t2H4+7amCMA7F5foeEUTOrHBZTKijsU0VMjq78jvrmIY/FIEdcUeXms6j3X5t3Ns5cyUKeQAxrudL6bR6o2mE3bU/zIWwc92qsW4ejwIHyA54XWfHUVhC3JZ/ziJeaptYqK5sLCo9KohNb+X5Q6lRWYQB+INcLmfWeoN1am1f7RU2ai/ekEwfg==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4453:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;31:caaVxZZxQRymMD7xAHwl3N4Q8wrNEoGDi+mSka3HaE5xSQCMcf1VoDx+v8JPSSu+zMqYUjVnUnupeYEPvKoVU0RgJY+9mfpid4UggWYZOYwVDnW3YMsYd/U8TxCog2vIWKf1w7ot4YrKQfBM/x66KCrBgtJILfcoeBkfSDSXI3kvQ8M0gX2gGFeqzOhQKVDiVKbpOLcUrHBHx/ieEF4qx6ETHA4ASHsgrUtjFynhmLI=;20:lp88o85549CsX36EhUNXNBup6wVFZeb7fXYCPHfuvXGjAwmvo+ebT71zfxLWe9al2SBaFax1/Ug6a9LkXxqLDtmymlh8HXtnOQtLrjn2QneRY4oaPm4U89aumVII9cTBQUZITey1gW8oF48uJszEyfxti3EpAASDoBX+vsQHhtZGLifLGYnZOvQbi58q7z7hmDHUs8Iu34z3V8GNKOcQVY3HugGwla9gzS/8k+OYMQU1xtBIUC47y2pcg7waiFFgT1kbXFCV49TJ4/Q4akeR7LOQdHtkLynFxkbYOX23oBzwJ801nEqI4ocs328l8hoIedGrsVcwJxqfjlukJ+XjhrTm1k+13eFsJKoUMZrwUB+/T7+qKG88GiGIeKVsdHfQ3aKddgSOhWUR6K3TX/4nZg+GTUATfuWXWWI6gwG6omdbc2KZWCA3o90YgczObiLd49+9Z288w08gv5rkQuZcnYy5Zz9OR8sDbVeO2Bn4sdwxd8zj7Az5+EV6i2ijynt2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB445364A28EA27A647EABD08AC2F70@BYAPR02MB4453.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4453;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4453;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;4:fWDQIn6cfv9fJdngFr3UQovTuC1xvu36FhIljo0IgZs31cLOazElCQM0ptsbf8N3vyyJmzKkz7GNsO5oOQrZYiBKhJImbMaw/jajAeOPqBePfSGkYe7cQ6PP7tOT66wqw2P7BqT+vRhRaBkvh1yRIzgBIr87sbjvq+nF0g6Iebwf+ZEnp09FDbvUuJeoegtLPWA7aiQzDUGThtoFBoQWDVHxIvehWSj+NXH8p5ecam38dbaquPsibrmHozDNPr2fYC3XM8UE80k2O12XxtUXwBIFm/okBkbQElG1ORMPWc7i65DYIEy57Baof86JpieMYDtRRGnFGC5W2P+Hvg5z0wDCXT9ibb74gLjLPwO4pCo=
X-Forefront-PRVS: 083691450C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4453;23:ovZWHcz2jofAKDWXfs/ntOMej3g8sr4XmlcF7eWXv?=
 =?us-ascii?Q?wktIy+4aSD8BEKarY/L3W1CBaxqtI0MjnKIz9OPIHQVa+3OWXsnJpkI7gOKK?=
 =?us-ascii?Q?EvtRFanXNj+aTR+0ApwVkpRuLltHclviFDrNz/YuGoYyjDjS0l6d4kRqpcwa?=
 =?us-ascii?Q?qaBscXYYxYON9pSMinNpvT+f2BIF1ounDvaxMTZDx2JJKsXtC7PgAbWfw4VS?=
 =?us-ascii?Q?fYb6nFMQ22iGAYsfzxZX3rVVTBmfB1rUSJjmFqSHF5G/3rrc44jqZyUEOxXj?=
 =?us-ascii?Q?gvmoHpks/UCUggdpAE+fkKH82KZUgqM9Sg/RjByyNji0SsF6MBksWYSk2l2Z?=
 =?us-ascii?Q?ZcIyukBLWAq3p+Ojl/jHNc6lJlHCWVHAUqchNFBKywrebDGyTL756xLC9qTL?=
 =?us-ascii?Q?648+38YsjSBlmfVZ01CXYIovQxox39vPw3Uy7vuip2GnNEP754YnSzUb06wI?=
 =?us-ascii?Q?/GKZy7BcVmSfv++kPS0Tg/ywOV46j3e8wAnQY3lQAR8QGmRoPBOmK4X7v8G2?=
 =?us-ascii?Q?ERpjbP5dSw5x3UOewEIu0BH5BO7wNbIzwLl6dQ6tqXhOnXyAA3n7ly2MLLH+?=
 =?us-ascii?Q?ErtgVzUvvOeai2d5bCbqEClVigFlasl+tdnGPcya+tAtdmlGMH52f3AXl7+Y?=
 =?us-ascii?Q?yI5eNY+Q7Y9xzGtT3ynFyAb9Wd5OIwOyRTOc4ZzswciEmZ7Onz8fwkfkHncY?=
 =?us-ascii?Q?pVVs+bdpSY1lQKrnYmIyovInUXsaRQ8WzRTJ0kJl55LWQhfsJ+Xzn+oTckcG?=
 =?us-ascii?Q?Gwe0VtqCvuX+qe0oJA6NYcyVGhqlcNE/ApEnNtonGh5Ln+gTA0dc5/eT2XLD?=
 =?us-ascii?Q?KKB7laYR40X7/yThE3Q0SG5+E0HiCxfavEfr6eJCs8lIp1ceViFnVPEbvAwt?=
 =?us-ascii?Q?kfojo7qoyx0kIUB8xFs2+QQ4om0TSygQtrCcvGFforBaK23o5zzWHHOxXzCr?=
 =?us-ascii?Q?q/hTN3psCXGtHMilKhEDabe0JnttugtyHfypHCIIys+P+zcVSVNcldXhp6ZG?=
 =?us-ascii?Q?nTxexDsiv0H3lNDuCroyieaAMahPvYcqhBnpBpXVf0liF5UqF3UilN/ksMBM?=
 =?us-ascii?Q?b9qiJDstaVUiLRN/ko7Fk+K6koK+CfXtVbjYxlpY0sl5XNJzPTYy/R5f+Nff?=
 =?us-ascii?Q?Q1ZDa6uFN6LzpNK+wc5ULeHXI8FMC8VB2zyuM5SRSKV9ttoQd7dCEBFwC8tK?=
 =?us-ascii?Q?KKCm1U4HvoQlz8=3D?=
X-Microsoft-Antispam-Message-Info: 5SqbsDnNFt5jGR7rc3kF8wMSZcGPMMKoFxxXhgfIYJjH/OYqjzV/GND+kqpX32iroIhVHom36boId9lR21c4JIhVhWoHPrj+NQ/HhmYBGMqDEkep/1uy5jXkJdXknFZ3dKujCQgd5vOEmFuUXNP3Npi5jf/fwTvCq8xgvC3g1gnaBgsne4jakJ4zlBEyiqwq+DFzsANFqPumIdQ3OxuFGPdwELWQQ/B0cmOEUnezP4vt+wgKNCZRGhHeg0CUEzHblYtwQpY7NywBW6G8ruGfFkaOWwJY7hpnc5zCzSngwn3Lf4txS6cnFBxlwHxPqtDVd6+CBb2l3wTrq3yIsvaz64zKRS/F0KlP3qatwheYB3k=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4453;6:NpQ5F6IHZCObucReT8MciNt6/+JGEMxK0hYh2BNO5ztthsu+iAYpyWO8oABhgpt8cuS+KX2Ls7q1QJmmQoLN74TDzECQikWszG8FCXAs81Y8SpmOHYbsnSEGawoLGKe6qJEwT94bYU41V1kSx25xPAKol9gclxuQXkyFu8O2TK/kS1/EVGCgvLF6u1iMGeK6RPouhF3K4GKsZuL0WKhYC4ZgyalXRvwYB8vnB0Upk6AADyEQ92aCWIQANqZFjcxUeD+HeBG3EUtvNMsTBqdSP8xOBInQ3gD/Yyopr3wyFQ0eofCG4ifDx3wiWfJji98O+FD20l/uxlQAS1/07rxk89hv29RRLekCtQGOmjqX9dsBU/lzgSKZRlv9ji6aAF/qKmcWM9zFFxE7jIx0BUEc/EEe7sqIhOl0TgJiHx2gk4/Leoo9kyV83nFD/4n4rZ8lfEWqYsU2WgncnsK8KgZTWQ==;5:DPE49wpDQH5QIhrTVL4htYfPXFzUGwwOSQzqax1cxjo885l1+TfC8cCX/DLL33JU1OqlE8+5BAbFov+g63UrEQh63m0r2IvdJT06qxCqAdu9djkPvKShqXSxwiN8D/WtbK9zLhYYMCEuz+8Tmd/ofn8yYTy9oFT/nunmD+4A3wk=;7:004yV3OSXvTMAj5vb7VQfI/h6S/rEj7kSSjOq3JxDO9zMV93XAY7c016VDcG/cC1kn8zlYzcIbWQStLqNZ+xtT1ev43HnnecrgJEz+PFinE05m8xqnZH/wUx7+uFfqGRZ3oAWsL2Q4rsa25ryEcMfw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2018 12:26:06.2086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ed227f-f24d-43a3-cfe5-08d63a750994
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP reset driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-None.

Changes for v1:
		-Created a Seperate(New) DT binding file as
		 suggested by Rob.

Changes for RFC-V3:
		-Corrected Commit Msg.

Changes for RFC-V2:
		-Moved reset node as a child to firwmare
		 node.

 .../bindings/reset/xlnx,zynqmp-reset.txt           | 146 +++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt

diff --git a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
new file mode 100644
index 0000000..c42b6a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
@@ -0,0 +1,146 @@
+--------------------------------------------------------------------------
+ =  Zynq UltraScale+ MPSoC reset driver binding =
+--------------------------------------------------------------------------
+The Zynq UltraScale+ MPSoC has several different resets.
+
+See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more information
+about zynqmp resets.
+
+Please also refer to reset.txt in this directory for common reset
+controller binding usage.
+
+Required Properties:
+- compatible:	"xlnx,zynqmp-reset"
+- #reset-cells:	Specifies the number of cells needed to encode reset
+		line, should be 1
+
+Reset outputs:
+	0   :PCIE config reset.
+	1   :PCIE bridge block level reset (AXI interface).
+	2   :PCIE control block level,reset.
+	3   :Display Port block level reset (includes DPDMA).
+	4   :FPD WDT reset.
+	5   :AF_FM5 block level reset.
+	6   :AF_FM4 block level reset.
+	7   :AF_FM3 block level reset.
+	8   :AF_FM2 block level reset.
+	9   :AF_FM1 block level reset.
+	10  :AF_FM0 block level reset.
+	11  :GDMA block level reset.
+	12  :Pixel Processor (GPU_PP1) block level reset.
+	13  :Pixel Processor (GPU_PP0) block level reset.
+	14  :GPU block level reset.
+	15  :GT block level reset.
+	16  :Sata block level reset.
+	17  :ACPU3 power on reset.
+	18  :ACPU2 power on reset.
+	19  :ACPU1 power on reset.
+	20  :ACPU0 power on reset.
+	21  :APU L2 reset.
+	22  :ACPU3 reset.
+	23  :ACPU2 reset.
+	24  :ACPU1 reset.
+	25  :ACPU0 reset.
+	26  :DDR block level reset inside of the DDR Sub System.
+	27  :APM block level reset inside of the DDR Sub System.
+	28  :soft reset.
+	29  :GEM 0 reset.
+	30  :GEM 1 reset.
+	31  :GEM 2 reset.
+	32  :GEM 3 reset.
+	33  :qspi reset.
+	34  :uart0 reset.
+	35  :uart1 reset.
+	36  :spi0 reset.
+	37  :spi1 reset.
+	38  :sdio0 reset.
+	39  :sdio1 reset.
+	40  :can0 reset.
+	41  :can1 reset.
+	42  :i2c0 reset.
+	43  :i2c1 reset.
+	44  :ttc0 reset.
+	45  :ttc1 reset.
+	46  :ttc2 reset.
+	47  :ttc3 reset.
+	48  :swdt reset.
+	49  :nand reset.
+	50  :adma reset.
+	51  :gpio reset.
+	52  :iou_cc reset.
+	53  :timestamp reset.
+	54  :rpu_r50 reset.
+	55  :rpu r51 reset.
+	56  :rpu_amba reset.
+	57  :ocm reset.
+	58  :rpu_pge reset.
+	59  :usb0_core reset.
+	60  :usb1_core reset.
+	61  :usb0_hiber reset.
+	62  :usb1_hiber reset.
+	63  :usb0_apb reset.
+	64  :usb1_apb reset.
+	65  :ipi reset.
+	66  :apm reset.
+	67  :rtc reset.
+	68  :sysmon reset.
+	69  :afi_fm6 reset.
+	70  :lpd_swdt reset.
+	71  :fpd_reset.
+	72  :rpu_dbg1 reset.
+	73  :rpu_dbg0 reset.
+	74  :dbg_lpd reset.
+	75  :dbg_fpd reset.
+	76  :apll reset.
+	77  :dpll reset.
+	78  :vpll reset.
+	79  :iopll reset.
+	80  :rpll reset.
+	81  :gpio_pl_0 reset.
+	82  :gpio_pl_1 reset.
+	83  :gpio_pl_2 reset.
+	84  :gpio_pl_3 reset.
+	85  :gpio_pl_4 reset.
+	86  :gpio_pl_5 reset.
+	87  :gpio_pl_6 reset.
+	88  :gpio_pl_7 reset.
+	89  :gpio_pl_8 reset.
+	90  :gpio_pl_9 reset.
+	91  :gpio_pl_10 reset.
+	92  :gpio_pl_11 reset.
+	93  :gpio_pl_12 reset.
+	94  :gpio_pl_13 reset.
+	95  :gpio_pl_14 reset.
+	96  :gpio_pl_15 reset.
+	97  :gpio_pl_16 reset.
+	98  :gpio_pl_17 reset.
+	99  :gpio_pl_18 reset.
+	100 :gpio_pl_19 reset.
+	101 :gpio_pl_20 reset.
+	102 :gpio_pl_21 reset.
+	103 :gpio_pl_22 reset.
+	104 :gpio_pl_23 reset.
+	105 :gpio_pl_24 reset.
+	106 :gpio_pl_25 reset.
+	107 :gpio_pl_26 reset.
+	108 :gpio_pl_27 reset.
+	109 :gpio_pl_28 reset.
+	110 :gpio_pl_29 reset.
+	111 :gpio_pl_30 reset.
+	112 :gpio_pl_31 reset.
+	113 :rpu_ls reset.
+	114 :ps_only reset.
+	115 :pl reset.
+	116 :ps_pl0 reset
+	117 :ps_pl1 reset
+	118 :ps_pl2 reset
+	119 :ps_pl3 reset
+
+-------
+Example
+-------
+
+	reset-controller {
+		compatible = "xlnx,zynqmp-reset";
+		#reset-cells = <1>;
+	};
-- 
2.7.4

