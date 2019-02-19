Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491F6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029462147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EPTWlhsr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="bewhjTnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfBSQPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:15:48 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59434 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbfBSQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:15:47 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1JG2Sv9006447;
        Tue, 19 Feb 2019 08:14:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=ApBM2J57rqBScVAoRUpEaSWuugOesFn+AgebCrjKT5E=;
 b=EPTWlhsrQCRGrWqs3d0gMzi94ozIaTiioIYInNM+NXDZVfdxgHDT7LzC2ubKCDUORJIM
 IvnMtVFT3YC6l44AWkc3FMgfTtQDoKUPO8ZzAzx6ve4lbP9PJ1IUXsJ1TPOy/56Snp8t
 JtvF2BlucXwPNeX2Msg5URgtBmweU2gLfiz3dOoBy69weD0R2NojwMF5ZGLB3OYWzjgj
 6mbZRoDRe7LcGFdsTMOVfAnBNShs56RfyQtb8vd2vw7m6pyb2Iye8WLdZzhrP4O688Rv
 lfxMWT++Sny1+daD+LuIOfltucgQJ0owBsVbLAQthFgZQxq6IRscJQxwUq+fX1cosP7+ fA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=piotrs@cadence.com
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2056.outbound.protection.outlook.com [104.47.50.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qqt6q5kjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Feb 2019 08:14:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApBM2J57rqBScVAoRUpEaSWuugOesFn+AgebCrjKT5E=;
 b=bewhjTnG30p9+PjPg5vWWXIpGZGYE1S2nZ8niZtxaBJqNz2xaSrokfEmeVpXf52Ht7KyOjn0ce4fdvE/2jOah0J6IMdkkmG+pZT43TlWCxWDpklL7A4PNjwmKtn+tGm3WJGmlbLh9o1h2GqkHDKo0Z2WU5T5Bpe3GR8xgI5B80M=
Received: from DM5PR07CA0061.namprd07.prod.outlook.com (2603:10b6:4:ad::26) by
 MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 19 Feb 2019 16:14:46 +0000
Received: from CO1NAM05FT051.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by DM5PR07CA0061.outlook.office365.com
 (2603:10b6:4:ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16 via Frontend
 Transport; Tue, 19 Feb 2019 16:14:45 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT051.mail.protection.outlook.com (10.152.96.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Tue, 19 Feb 2019 16:14:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x1JGEef1024700
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 19 Feb 2019 08:14:42 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 19 Feb 2019 17:14:39 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 19 Feb 2019 17:14:39 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1JGEdwx006864;
        Tue, 19 Feb 2019 16:14:39 GMT
Received: (from piotrs@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1JGEW7X006271;
        Tue, 19 Feb 2019 16:14:32 GMT
From:   Piotr Sroka <piotrs@cadence.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paul Burton <paul.burton@mips.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stefan Agner <stefan@agner.ch>,
        <linux-mtd@lists.infradead.org>, Piotr Sroka <piotrs@cadence.com>
Subject: [PATCH v2 0/2] mtd: nand: Add Cadence NAND controller driver 
Date:   Tue, 19 Feb 2019 16:14:06 +0000
Message-ID: <20190219161406.4340-1-piotrs@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(199004)(189003)(36092001)(246002)(356004)(86362001)(42186006)(16586007)(6666004)(54906003)(486006)(8676002)(107886003)(7636002)(8936002)(5660300002)(50226002)(316002)(47776003)(2616005)(336012)(126002)(6916009)(4743002)(476003)(426003)(105596002)(2351001)(51416003)(2906002)(186003)(50466002)(36756003)(48376002)(305945005)(26826003)(4326008)(478600001)(87636003)(7416002)(106466001)(26005)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB3980;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 085f07e3-4e17-4465-7638-08d696855d17
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060);SRVR:MW2PR07MB3980;
X-MS-TrafficTypeDiagnostic: MW2PR07MB3980:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3980;20:wBtq+VtbECP5H7/bOQI7EpJ84ygkRy6yLiWoigAbWgxItGgCSECzMdcnORvfI4P/Z7Z51NC04etw6cHN63dZAVQJaF/OUo8EogDB87B+BAUW8Ocss6b1q12ZO1jxXzIXMRM4L9oSql4NcRf+GjeyJOBSaAAu/2LAbUY/NbeiDtnfBL9KYQYTEXRF4NiiPKR+An6A+a/Ra/cjUOaLZyayGu9pD8Vr0xe9gEjj0PvbwhOKpO6SaLM6Y7TZef/zhwE7LGbELm/hgmLJq+K7bZw/0YyvDT2FUv+GIZEWtv0DlfEElHKvqx2goSOHkK659KjubBE02LtprBgybIsqwVm56dsyGQkXQzYwcWTrX5AJacxdBAgRMVLlKXl6AyX/dFiY+I30MyfCbtXl0hCHnk0iHwq5KgYLTcUAN7HFm+kLP+R/fGMZAAWOy/0DeVgG7spTRY+KhNspntqN4YirsuPa2wnA61v4bSmsIiLc3EYjKeeqEkD+1gIWgrvr+UDYvsu7
X-Microsoft-Antispam-PRVS: <MW2PR07MB39809B526283FEC25282DA34DD7C0@MW2PR07MB3980.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09538D3531
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR07MB3980;23:6SwAENKjz0MG7WH9MjiKD4IvkiFVob5OEr2dpx5RF?=
 =?us-ascii?Q?REME7Jld0iMzOoyf0tA/j29H26m2YVrRR+CzzuXzYQjJlq0fGTfKRnssJ6O8?=
 =?us-ascii?Q?L9xPFJFd1sljJ1JcUTZx0z0CmvR+r8ZcOMWq/wIc34KSbdnKEQo4JPi9gwWG?=
 =?us-ascii?Q?UoHfUeRAov+C8swroSSZEOLa9HCti7EM2j6yx0dpo4016pM+SecokHhJI0Pc?=
 =?us-ascii?Q?1E69cI/+B0FeR2teOF+mdi7RRW/4Q1iyLsW7IlQ/ET7CgkeTXsB0uUrDa4A8?=
 =?us-ascii?Q?4wHmNeTPve2KPKqhfVk7Rmce5tPUiGmuKnNJa//1TFiMf8bTZMUWSeiA8asX?=
 =?us-ascii?Q?8+l2rWuV4nYlsabohBsI4Mg/PvmXsZICnhHrm9DVx0u3ctxHXMmvcscr0z0V?=
 =?us-ascii?Q?pCXC6vQqqQOxVQzvLmnJx42aS+gFoRv0/UmEdE/K9drzwRsqpA0Ui2jr0P8S?=
 =?us-ascii?Q?1vJtzFA3nlsspEcwDOXY9qIycY/02iUOdQMN5/CxcKMF+Vc8yHdiByuze6xH?=
 =?us-ascii?Q?7o13Se4GFdiV7fPaNu/jjESqweXuvrhKn3Ra6YW8FdJ3fHQE4DzW/YmMv/el?=
 =?us-ascii?Q?74obKP2Hl07Lk8vXXQKno5ExcvXAmfARhV05COyqEVkruSRX06JeoylI3Qao?=
 =?us-ascii?Q?/35lRPGUuubqeOfw1ELCOYacMKfrvpLXyQckxXhv2feHsEz6/5kyY2OJ/akT?=
 =?us-ascii?Q?oN96ImDHjoYAdTUzvaQmh5EdGNVGTKeYFqbw+OAEalG6/cdqtz3p61R2wXIm?=
 =?us-ascii?Q?E6WUI549htKPzY/Nz2dplxGSAzshiwYQp0Jx3C/aCc6A2WBR0lBmqNU1pVet?=
 =?us-ascii?Q?b92JXLFRVF1Cl7yDfAZ73otdrXuhuIxzwb+evYrjIOPyEprFWKURiGxUPd2y?=
 =?us-ascii?Q?kN3vWI3GZJSRa8rCnibIPlB0tTbVz98uY2pBRAtrwJ0+44y+EYoNHoH3MW6Z?=
 =?us-ascii?Q?qgCRZNSrcmuLNnTOyGGsH2eV8vJ6/yuqZkjDcay2mKD4ELNcFIpKeRIvyFI4?=
 =?us-ascii?Q?AL2lfD+DQmSEj/dEYqV/aKPP0uKLkzBBna2INAbU8y4PCMMSoxSIXs9H7HUZ?=
 =?us-ascii?Q?DocOK8QmUIGBFDCLoN50UtaU7yl/yj3JvhGOFxCALqvFKAY2A=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JvP6u9CDGEL63FfdsI/gMMG/isaa1MI0uQ52g48I7ZOOsZQ75TpYGkWj3dJ042ZVcL7+g9+vnQYPbIt/smh/GqkH4108Z4LhsEf8k+fAW4HWZVOXACHWMSBjWVWrlWh9dbFX6WQhiiXQPbJuCs9ectHHQyr+o8OgdwKHOvKf3VzSR0nAWQOrmbQP5RaleBx5xs9MBQTEZeBZajzT0OxbQPcxoRO5dcNLadTENT/xQYiw8s7q3BlULaSu5F4O0pHU3KoM2iE1jgVw3b9W+djXB05UyvqDEMUdq6dHYh5lM8doIRg3Ca9GBXOPtWy/oz2Lq1RHJve5vvvyDuAin7QIX8vyJe34ORW6yysKeI6BVHkIHtmUp4lLbgzjwCZp5ay5/cmou0ycnjb0vgv1vpS0eyRBjFsK/4ngqAW1TBS7DTA=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3980;20:iNMAmJb1LVbMS17w23UANMIIVxDovz4DxmRkjrYQ81ZZYZhauKe2gLAeRHhob/V17ygHk44mM1nlqsLtypJMzhdrwkcp0C99mnw4inmrA2bmk7iAJfViR3G29y29yZ9FcUrShrOQDqfsPQ2yegqOkqoRke3CQLldg4KS9dwez5xghvClvEUXb88dNdVH/WRgy7jno56scRTvuJKqaUbzXevaVgVLXFDgXvjel55EnkVpMeOplj27jFoRfQyR99Lx
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2019 16:14:45.1615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085f07e3-4e17-4465-7638-08d696855d17
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3980
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902190119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver for Cadence HPNFC NAND flash controller.

HW DMA interface
Page write and page read operations are executed in Command DMA mode.
Commands are defined by DMA descriptors.
In CDMA mode controller own DMA engine is used (Master DMA mode).
Other operations defined by nand_op_instr are executed in "Generic" mode.
In that mode data can be transferred only in by Slave DMA interface.
Slave DMA interface can be connected directly to AXI or to an external
DMA engine.

HW ECC support
Cadence NAND controller supports HW BCH correction.
 ECC is transparent from SW point of view. It means that ECC codes
are calculated and written to flash. In read operation ECC codes 
are removed from user data and correction is made if necessary.

Controller data layout with ECC enabled:
 -------------------------------------------------------------------------
|Sec 1 | ECC | Sec 2 | ECC ...... | Sec n | OOB (32B) | ECC | unused data |
 -------------------------------------------------------------------------

Last sector is extended by a out-bound data. Tha maximum size of
"extra data" is 32 bytes. The oob data are protected by ECC. If we need to 
read only oob data the whole last sector must be read. It is because 
oob data are part of last sector. Reading oob function always reads 
whole sector and writing oob function always writes whole last sector.
Written data are interleaved with the ECC therefore part of the 
last sector is located on oob area and the BBM is overwritten.

SKIP BYTES feature
To protect BBM the "skip byte" HW feature is used. 
Write page function copies BBM value from first byte of oob data to 
BBM offset defined by manufacturer. Read page functions always takes 
BBM from flash manufacturer offset. It causes that for not written 
pages the proper value of BBM marker is used.

ECC size calculation
Information about supported ECC steps and ECC strengths are read 
from controller registers. ECC sector size and ECC strength can be
configurable. Size of ECC depends on maximum supported sector size 
it not depends on selected sector size. Therefore there is a separate
function for calculating ECC size for each of possible 
sector size/step size.


Piotr Sroka (2):
  Add new Cadence NAND driver to MTD subsystem
  dt-bindings: nand: Add Cadence NAND controller driver

 .../bindings/mtd/cadence-nand-controller.txt       |   48 +
 drivers/mtd/nand/raw/Kconfig                       |    8 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/cadence-nand-controller.c     | 3288 ++++++++++++++++++++
 4 files changed, 3345 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt
 create mode 100644 drivers/mtd/nand/raw/cadence-nand-controller.c

-- 
2.15.0

