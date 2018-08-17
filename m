Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2114BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9977B21473
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gUQPVOcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9977B21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeHQQ1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:27:04 -0400
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:43136
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727058AbeHQQ1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppfOxrfZlEw4CpGrO1UKtDVfggbi8zBK5qtw4Y9bVT4=;
 b=gUQPVOcYmrFUQc9IIC+VPdohTXsBpZRotTsiLr5qbys4sYt0x2VlsHM3oqg6nYOBpZWdIwMGjB9YhvpAaAPAToadrXuWbS8lryQv9+kb2HBCPN77BUD3Bhd7SBED8G5cT8f06ifXmKiD0GUXfoNHsBqYSYii5MystjmDZk+RcR4=
Received: from SN4PR0201CA0069.namprd02.prod.outlook.com
 (2603:10b6:803:20::31) by DM5PR0201MB3512.namprd02.prod.outlook.com
 (2603:10b6:4:77::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Fri, 17 Aug
 2018 13:19:46 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by SN4PR0201CA0069.outlook.office365.com
 (2603:10b6:803:20::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Fri, 17 Aug 2018 13:19:46 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 13:19:45 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53550 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fqefJ-0001is-1f; Fri, 17 Aug 2018 06:19:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fqefE-00062K-0Q; Fri, 17 Aug 2018 06:19:40 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HDJVCW005704;
        Fri, 17 Aug 2018 06:19:31 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1fqef4-00060p-KR; Fri, 17 Aug 2018 06:19:31 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <kyungmin.park@samsung.com>, <absahu@codeaurora.org>,
        <peterpandong@micron.com>, <frieder.schrempf@exceet.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasureshkumarrelli@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v10 0/2] Add support for Arasan NAND Flash controller
Date:   Fri, 17 Aug 2018 18:49:22 +0530
Message-ID: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(2980300002)(438002)(189003)(199004)(26005)(2616005)(126002)(63266004)(316002)(486006)(426003)(106466001)(54906003)(217873002)(6666003)(2201001)(16586007)(476003)(36756003)(5660300001)(2906002)(110136005)(51416003)(7416002)(7696005)(106002)(478600001)(81166006)(81156014)(8676002)(305945005)(9786002)(47776003)(356003)(8936002)(50226002)(36386004)(186003)(77096007)(50466002)(48376002)(4326008)(336012)(39060400002)(107886003)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3512;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT016;1:JOjbyy+isxbUu8HCcXcsybKEK89/OVAXpZXpej1T3XpiktB+7Bji8aw0WHFOTRdbr11imZ8tyNltRd6nGhnLNa5PT1JWVWWmJrv1KZ47/ULS4SInyXLctvBiSPl5rmfR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2530c0f0-2f39-4ae2-15fc-08d6044419e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;3:xzb198BNmPw+uVlierJnVm/pIqJNM9K1rxnxh89jaVCJ70r86Y/tIui7sl+B8Ii2e58cr/yBIfHnBuhK3fFRiPkI1yeoqv2nahChjICygeoqxlrct/XFtgpoMBDMHFuvemY/TNEaDofrunRyc13vZXYhFlDf61HgWZczI/Ez1wr4DBFnOVA8nWbECTFUZHQ/jYV5psiGSkd7dzMFWUS0EERPzo2VJFoMgsH9ZROs+0G3YukESmcNWb4wTAOB7RVixy/VuZalebbWkNrnN6Bc3rxq2hDxxA+J/gkeNiPHquKpBE1Ew3CDEgTERumNQMWHK/rc58B/SsmPnmJ3a+ZT89g2K/JUNQRX2xUFyBhRE0I=;25:AOIP898p1mOc8STdqE5wqV4wLFdgB3kz5fqKhdcXvcHVqSAIQLCXkl7tLIG6c+HdZAz3gKzg+xOcOYFiWh7PzxPqEpvQs0s9fOR3DTACsQmC0hH7n5nLCmwri16S6HnfofD35toa2i9tMJtLL5oBXUKFUuvyY1COZoaHCKuhaaSh8lTDJu4jw/NdB9p6l9hxwYn5rK17GAY3hXj3NAMhFpekMmDNS1hhEOiyno4/96mp0TdVbKfyFMm94JrA5zCW96c3oIaAM3m7eMOjZBvtMZmpd/D4J9xuGDD22HdiYPrBDBowuicB7RPouNbIh74BBrQVKrViAQsBvEATo53F2w==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3512:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;31:1+1UtEZHqdZaJCVh8oo6AjyMd9Kwef7cHbLkeRMbxnF9qgFqGM40gyEXL/lR1iMJlJctHiP3nO+Wm6tWob9fCd1590wnoSuqZposPs39NRnjaV80K5duvAbI/cwkavw2/LTDIGMFYY5dICGSMbKdALttHCWNDcbD9s1tI1JDghWshEA8ZYL4vynMZX4rGSgoNgB3RFvE8VD2jLYH6h781fJehtSarBCOlBOiy1t4Umo=;20:huq00it2fb47M8w+wG1MCDjmjTbb3AVjOc8EzCJ5le+LlzSlvFWQPe895CPb1gSCsJsMWV5Md8sFjsh8Xq3i6ggikWTdcUclGGVuO39pUYPHKiWMpubzErdfAOgqrXIruSetp5mq1fse8EJtse0MwVcIWa+QZ7Pp65eFIzWq7Ghls0dZwQd/p2S8QuCEYD2T8p/n/AQuMEBbwqCo9koXvxOL58BeyvDc5mI+zN3m8YB9MW6vsutZfn2mYY/EGr/llOVQOV2jNqges03l71Ko9Tr/Md6TpsYE9kZA6Tj9bVtElzLkMJsx75h6NAz1H7vxZB4ok/5hoU1e7E3uY3OVd8ibCTZGw/i/yIfLy7QGeBtRa4fNFEYREaQKdNF+84nL1AJswaws1jJiScbCL5EmhH0RhF8QZL8euPRKIkrgS1RinIUIuvCnuBPqIz4x4ecCF5nE/OVJwuiROuGtR88ATduOj/yBmUa6/uREjGN0fYh74aVvspBiZs8cM7GHYfDx
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35129E21E5998068E1DAAAB6AF3D0@DM5PR0201MB3512.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DM5PR0201MB3512;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;4:Lt1YG7r9Prkn6rCsCDyTr6GiECV8FICNq5NuWcg/DMQdJ2bfGXe7OpW4uFlbWmr2MnsAyAAY6eBmg0qnrZTDb9qUgrCGa0MESHHkw+Deves2pDgzCMqO1ZrUbJu8XsQeya13HgE9++Jm/7mg2KyaM4lZWrnFsMEDid0yPnxOdCdKmnJXPknwuSn6lOxvsudJ0E1TXlI8KT8Ftqxb0F4sYRDhjicFDDk35tjCrJJRzwQZrQsM0N9QAI1symjxurie095yo94a8v73iysprZSV/A==
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0201MB3512;23:9pcluzsAraTid+KhPuoPPn75o5+C4PefvpruYgP?=
 =?us-ascii?Q?r7CB4XI63gr2tFMF34oKJKdbL4ULtA++CTosCc2wI+9anfLX38/WMwukJnht?=
 =?us-ascii?Q?Abp4cXY2OdFzxX+Sutx4mo99B1jx/7vSGk88TUG4xZBPIKyvhtVyf1WvwufO?=
 =?us-ascii?Q?Ece80m8sr6BbMjXAdjhk+mWB4bMm05YfaKnUWca8gA5BrlMWMgVXEV8vog3z?=
 =?us-ascii?Q?Ou1Pl/+IutzADSaB4ORgZwORsTIL31jkiIeErjw0B0YLR0BmzkF4Di8K/LMV?=
 =?us-ascii?Q?NzgzHexQ3Un0ub2wzWvHhcdeiOcXrOXnPaVg8qZcFStAhOW9cNwxFSiyiqeS?=
 =?us-ascii?Q?/p/0opmAxVB5GUb/vtrzBzYhLR9HbYjYkuE1a0ECWy4iAwffjULQTMV8YH+N?=
 =?us-ascii?Q?mcbvhXVlzYiFCJC9RD3UlpXVGWFuAwYHYp+AhiujimsvZrDhZXqIW+/I/Zel?=
 =?us-ascii?Q?uqHBcQew1zxtOZRFQEcCKvyODGaFq8FxFbnzkt4rlfVyxxH6FmeRdcglzhy6?=
 =?us-ascii?Q?Y02uejoc0eSa+kRQRbf5PBgb+if2I0vyFQ2YzyKTYCc1MVnIFzgnIJJBT23B?=
 =?us-ascii?Q?QEPkZcFLI1yynqlbXoyl2+fJR01rUYo+fgwK1jjbndIvZczOcgyCoCvCzbuh?=
 =?us-ascii?Q?KOJQXAX64kjTGFSIZ6M8L9ZURE4ACER7wSPrjgqwQCcg9mG7cES3Uwv9T32z?=
 =?us-ascii?Q?CQij0G6/SjQTZdiDYCzZvX52nYUbT+BeNac88MudoD1MM0W5612FATTPcLea?=
 =?us-ascii?Q?KMd2ZTaagyv/SJZgKTJ5t3l+akXY9Z2NPiczgpbhlzzJ9CsMqqQKQktobdXM?=
 =?us-ascii?Q?TVwdWWl+6o1WhcfWk2DO5stNnjJcR9887Y7i7uHVp7cXoK1dXE04NoTaEXVm?=
 =?us-ascii?Q?bTMxRKbuPEoj4i0iYwGBkSTAKP5trqYDMxlHYqhglUZutXmsLNUONe9ZQ9H3?=
 =?us-ascii?Q?MRfTSKQxxc06DJb8aP+7J7hTd20Q0NEEjKvPhfpSYURE8GDuHrPMEYwCc0sU?=
 =?us-ascii?Q?DtwqoD1KCS3h4iVpM37g46cT2VnON7kbU5Jbg1b9kpm1naszGkL8UiG5sjwd?=
 =?us-ascii?Q?33wGJCgowz1MCslNH5+BkNGbCVLw863+FXC3iomBynhlM1MrTgmxMcoj8yid?=
 =?us-ascii?Q?IQu6l5dDtsjBsg1GhyHkVq9pjrZ9Lu8wF1b9LxtJxGSPTFNZb1hubQ4xfrOM?=
 =?us-ascii?Q?MMB3yFS4j6IfS3vURNSd8F3p4bJFh9GpQzhdC?=
X-Microsoft-Antispam-Message-Info: iB1h69+L5ejsNXvxF0Cr2tSNr6DgFqomk5MJrL/lHU0QDO0VusWHkVaXTkzIv7NDeLc0xy74WiJwVCc+kVH3hYXHIUKSSa/oi2jYXIJp9hNcxb7irQdHPL5KHyBvBK2Bx9y0HqT+5MLFI0EPDanOHTKiDf49mvGiMjK5joEdDmJTw8fsuZMFGiU/EHEWSUz0bPDo7w7YagoVnng2j4az4sbajM7ZqyZ9Vbw6K4Rm+Dg78yxke7H93DEGcWVXYm08vXiKL6n0iYsBV47mu3FEzNJBdTa0ss3a1jfHtgtknDfX402qRElBjqLs0JiTjOXK0IfR+rqkUVwtH+JRA6DEXnJchPKxli+o0ZOlWrb7wS8=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3512;6:Vvg/4AQC8wkGGH9AXRvDGIbOu86wKGy4H+kATkke6Cd2sqeHNSaIzstsOgQVHhHwtELiZPKU8mG4LvEHkY5KTWUK/YezWyzZHs8istjZKFH80lwWuFb1P6lABPJ0beary+sJRQYpG/y0HSc6yORVPVvYooiH3Ev7vO9JTjJ2MEtwJwqJC6sGn1lQHEqu9uMb/E13kgGpQPqgEgoA1VrE9r177ddV1Jy+XZMS9DTcVmUdScat9P657PCQaGU0AV5ItkBjQaJT+mc9ry/A6S6Wz+SC21PLvLatKsUmps+zuD/jJGHB47LTONEITkWuI+cGwOkdBpXXJDVS+zKsHAf0B4ejytBIjTexaRP+PVfTLmobSWtmV+f/ltU3Z1pJJyybGdabZ2RgsKRu6u9TEXQDLKZH7NPdZZlIGDry5qD1bjS2H8is1TeE3obtDi2ilFqykIvpx7pm7qhigGlBhJZYuA==;5:KZ9kSfcTJhsFiFhHJWNmaktu3IatLV3J/Mwm0ispOYeeEK6aoVCcznlIS0soUDglrKZHfWRlbj8YEC+m3HrgjpPgTb7ekWoMU654+teWZtIUNo5GzVy4pbWqtEzV8GNAcUmTddxGTVED+mshB29DTLrM15oiLO8HtH3MVYBpmrw=;7:93lSeFLHmoKc7GJCf2pINncSFYjzn1f+kTzV1NkC48e5AAvTzmMHvGd8bwS6XLBor2lGAwWmm/FZHOaRmdklM60RotHFTK4Z4AQjXdhBMdb/QoKCH2MtF2I3nXow1boZ5olBSsSTaOwe28BkK09+M7QhbrxqV2uVq1zJy5/KEJ7kP+DJnF8HqyNytfa9ZPoprzDyti7ALUKUIn/08X+EyFRLi9jYbFsyO8dFny19SZZY9ZGo5Lk008GpvC4AjRwB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 13:19:45.6319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2530c0f0-2f39-4ae2-15fc-08d6044419e2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the basic driver support for Arasan NAND Flash
controller.
We are reinitiating the patch series by fixing the comments given by
Miquel and Boris.
Major changes are exec_op() implementation related.
Rebased to 4.19 nand tree.
Tested MT29F32G08ABCDBJ4.

Naga Sureshkumar Relli (2):
  dt-bindings: mtd: arasan: Add device tree binding documentation
  mtd: rawnand: arasan: Add support for Arasan NAND Flash Controller

 .../devicetree/bindings/mtd/arasan_nand.txt        |   38 +
 drivers/mtd/nand/raw/Kconfig                       |    8 +
 drivers/mtd/nand/raw/Makefile                      |    1 +
 drivers/mtd/nand/raw/arasan_nand.c                 | 1350 ++++++++++++++++++++
 4 files changed, 1397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/arasan_nand.txt
 create mode 100644 drivers/mtd/nand/raw/arasan_nand.c

-- 
2.7.4

