Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD981C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749A32086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VIrUI1PJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749A32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeIHTuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:50:24 -0400
Received: from mail-sn1nam02on0044.outbound.protection.outlook.com ([104.47.36.44]:26688
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727601AbeIHTuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtgUiMPY42sFioY/cOHiX5zjEGuTN2r8MIcQSbtRuAE=;
 b=VIrUI1PJdtSjt96lFDLHRZHwOl55/sHAdTXn4teXCfq7tudsXIijsel6iZxfOWEFw9N5jF6aQ4Ygc1A098kWG74/kXhFgc0bnaZqsmzSW3zzSIq5EC4X/NOnRkOpyHHkVsXLuylZZLmOyFLA80uQZ47ifJc8FgDAqFkVvz4JGrc=
Received: from MWHPR02CA0024.namprd02.prod.outlook.com (2603:10b6:300:4b::34)
 by BL2PR02MB499.namprd02.prod.outlook.com (2a01:111:e400:c2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.17; Sat, 8 Sep
 2018 15:03:22 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by MWHPR02CA0024.outlook.office365.com
 (2603:10b6:300:4b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Sat, 8 Sep 2018 15:03:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Sat, 8 Sep 2018 15:03:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelc-0002ci-SS; Sat, 08 Sep 2018 08:03:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelX-0004pQ-Oo; Sat, 08 Sep 2018 08:03:15 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w88F38NF027663;
        Sat, 8 Sep 2018 08:03:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyelP-0004oR-Q1; Sat, 08 Sep 2018 08:03:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id E383560493; Sat,  8 Sep 2018 20:33:06 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 0/8] usb: dwc3: Fix broken BULK stream support to dwc3 gadget driver
Date:   Sat, 8 Sep 2018 20:32:58 +0530
Message-ID: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(36386004)(106466001)(48376002)(186003)(50466002)(63266004)(8936002)(52956003)(26005)(50226002)(36756003)(81166006)(81156014)(2906002)(6666003)(5660300001)(14444005)(356003)(305945005)(8676002)(486006)(4326008)(426003)(316002)(42186006)(51416003)(107886003)(16586007)(39060400002)(54906003)(126002)(6266002)(2616005)(110136005)(476003)(103686004)(336012)(106002)(47776003)(90966002)(478600001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB499;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT004;1:cuZEzmCHQcqbpqXrhgkE623bpO/WarODrFiMdiSpNVXR36NguwcwUUm8Q0P6aktmLoKcM5NgC/ABEhEC71UNRHlMWvTVP7+ZT8/zGDNaywXJg/ZLyF4+NgpYo5C6JZR6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4cf648a-2b82-4108-0752-08d6159c380c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR02MB499;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;3:GmCbaxRHhlljtj8JZc/soL96g8KvrdNKw5kUwD9TZnvyFrRGBQtSV+8CMQu7P7Fv0uKrvzo4K2v5krTzybxOOegS/1wiYw6NVKe3CbVoEBVRhUGklGFLIvLjpp2nrIbvp3dGxt+eoWduYDKAKg70gHHZU8MpoIIldxsxCxi22L/DJJTt4Td4n42FgeVYftjoYeSzHel+XjfUiu/ZzdQyTlRQA8cggSNvBdLjDUTeylbtmYwSWJAJXFuSHLRk2hh9jm4/+vgx+IerOeMPFR0ij6UBDwkczi4Ha2IsCsJeE8Lqvw9b6OVktBbD2qBRYCM1gZ7dwvTq1uEsWOS5OlyeobWspFK4j77pwikuIsD/hrA=;25:E25OJJUxiZymp2f1PtbWqXXSf3EVjI5NQg7Yz13hx9ztqVFyRZuqjgX5y0xWgTHffhqaIo1LBMu3q5cKw34iIoGxOx3Am5vax4DrC3SWAs2FARIO3VNDcUb2pAinZHO2b8ZKXTTR6LxKG4VP/yPez3xnzuoz027Aq+2dfdjJfqRsGNy6Ee60KuGlVK2/gW5fQiLUG/XTLsgaKir7goFxpX5np6M4oG//Yv5FVl1NTyP12NWiinExs2XeNuKqKG4AM0AW19j4OeJuFQ2tMkwTue7phgyGJ9Xj40UJxt5eA5VckCkGVlTPGLhj2TR2CJb4ShieAreGFlwTiF+dNj8aAQ==
X-MS-TrafficTypeDiagnostic: BL2PR02MB499:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;31:reJ3ibFWMMPdqoqLTqq+AoLR+L95moS7eXRVHhfXCbYWqKDWYoosHvigF8Fxlm0u5eMQ/kqpdv2nijfUe6XgMCznbpOddBj4XSfALI4axAin7LzsPgCfGAeFiGcLpLzJpnQ8rivi1o+K3gBsmZGbbL53np7kiwCjtTy98np+kDwPQDRIsdcnFFBueMsVlb6mIfXLiTIgPSKjc0PwdeL/lUmKjuK/ByiUkvhgMAXvzM8=;20:zQLHjfQ7TKIhq385cCtK0PXXsppByU1HWTZuPCl+/DzbX7rcQil/t7VWkT6W4Kb3ebx9a0F1ZrIRF5JtueStd3r05+YL2xxKnfIQEMECShmk0HmFnvjdYGFNrbcTutEE8yKfICwI0SXvCRR38EvkYhZbewO+ZeTWjNoFZH9vrwLqD1PXYvz5jHN68V4/02U9HxvMjm5+NFO2IHKtP3ur5juEWwiwz9Ef/kiylEvKOUjB/DFhbbeBa8yL5IF9DMljSZYWL4Z0rWKVlE5PQMEfzZ3QQRUdWY4dpig+kGv78cvuSt01U7n76e82Rw/Nx/LQIfq1mwkLNwPpSBsrwSFgukhWu1o52IvjPcqnVlOKysRojswSWj36tkJYndjdDCubjGwhCdC5IXHhsNpcQE+OyZcW5aCGUo/dw0p8eIy+UnHWrUNPaqg2l9ijwYjJbq0MSnMVfla3Ai62xyfYH7kLbjwBthdLV3CC6Krg9zckqxJkRucaIZ7neFczEvz2czrx
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB4992C7C21B54E7C62A532B6A7070@BL2PR02MB499.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:BL2PR02MB499;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB499;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;4:aA5ZUttpg5fASZjR+hmOUpq350Gj+L1Lw0KrJ5fKCX7sXKXWaAUvGlMcuNmdzKXaca4wX0FYVImnGyjHBVcDatGlSmWFKr1Q4saxYpN0M3LqrcHEGna3EZZGANn/+qgBDyKjfJ/FLAgvEmw/GrHFz6j+Czr/TbGtAMD93X6vf3ttdlJS+SROdBM4M0AF74MWMgtwG3rer0pSbtArZUgUdBbxyNaf8vzltt/G+iBLydIcopJY0dFYBEfAlxA0mUpjiJUmqII0klf1si07SvWt3A==
X-Forefront-PRVS: 07891BF289
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR02MB499;23:mk0lBr3ShOZY4SMshEtVzFXmKTlVw23utX0s4rS1rB?=
 =?us-ascii?Q?UNZQ2LQYUYMgmOVtTrd2h/724LhmELIHWZWsrK7gQbVx/NjN7cDjFsTpSSe8?=
 =?us-ascii?Q?heo4gnnaqtF4DJ/yBIsLNbKeoyJ67+yR8NohBApz9s/77qhKQNz+rmlCXKeX?=
 =?us-ascii?Q?0BhpqOxH/afinzQwJ5KrbxA58FIUhpVFg5ildAUIpLsm7XwZIUciDWMUGFcd?=
 =?us-ascii?Q?Fux5Dvq9lWpYxGxUTEPfWxyjW9ceQYDLNcKPS6ny0w9MKE8DH8UAcewomAWk?=
 =?us-ascii?Q?nVGMYTG8V+CF8wc2Hmsu3W9bSL+5XFG0VC5xNdYLLOh2RKBwzu6JY4rNmez/?=
 =?us-ascii?Q?CR1wp22xY6rTOZk437DAq2yTOQu6Jb7GYCD0rNjgqJFlh8WJZH4g3OsSFQGf?=
 =?us-ascii?Q?++eqIrJPQS2H4IKO+Cd3nkL98jgVYo/xU1MJ2ophfEJmPPu0hyq61IQtQ0NM?=
 =?us-ascii?Q?UbzgV0cD9dBm6Rqv8kAYaDDGBSW17WUIeKGtJjqFStzBeI2TYknA0hVRB3hx?=
 =?us-ascii?Q?dTaVCS6XysAAwiwcj65YwCeXGU1IoPylcOatCk8lo62C5LOvpWBmKQTkVhJm?=
 =?us-ascii?Q?Q2ieiABkrXyPHCyOJLAq+hve6R0KrWXQuiElpYUh5U8kCRA4FyPsgdfWoS+p?=
 =?us-ascii?Q?7uM6XmOQcFEhUxw4jmCWWbFLVzmVKDzjloy82wansyDQbjr3v3sbJmgMFini?=
 =?us-ascii?Q?Kg3j196tJQieMkSdGC8m/l1J/MZmSVujqqqDNyfqmfDf7p++rbEi6IiLRQiz?=
 =?us-ascii?Q?WjuH+oUt0vxWR140wJ5Oy0DRr1q8Qi3/dRMjWaBWAbqIK06IZ9IO5bROa63m?=
 =?us-ascii?Q?7pIF9gMxgF25j+8luR0rIcYLjG/b2sRGVPX0oFwADIUbvBK1xD8Qyj9frAIC?=
 =?us-ascii?Q?JmQJfJJl2E3ijT0M5j2V37cJvIZifOYYGWrg3wXKM98dazSqBfDEcg5Mo8zC?=
 =?us-ascii?Q?oTRNLkVrv6/gASJVvLp+qdfPSsZG4ttrTPQKpzYpd500V4VOrK0zshrxTGSX?=
 =?us-ascii?Q?bXo3jAWM6OGXl2Tes2TX4l/lk+dPhFXovzcABoobTdLxQE73JrbmJIozcSrp?=
 =?us-ascii?Q?rEey8NMiafqn2HHQScrFPzyaXm1vSvw0/lzU/FmyBLamFf/Vn/VIzHYdECqg?=
 =?us-ascii?Q?FOuL6aKVbXjIOGvNA27zX0NIBixMpy?=
X-Microsoft-Antispam-Message-Info: cwOooVvCEYgF+cx4IFZIeqS1jack8vjmI6B5+bvPrUu7BKx4FYfNxRN239h3uypzgFKi1+gZ/VtDmAxtnU9QbszpvzQG+VWRBhz80/vlFb3lff2eW+ruveh47IbtJIyxlY+C9tUznQevsUagJ2IDhboNfydCk7onyjvUyPbE7T0vjXB57B5nAkKef4A0+4xzdYUTwMH9tujnG/cY2YnxRpQB1kAImq7dEkeUGkS3lMAdUVBbxXM2XqvA9M3LbpQ9omM4Hqthmqh1OBCqN1Ay+52Ia24k5y6pz6eP9u4RNmzOKpZm+peZq9Yv/yOf3iGD8tzuYem6H41R3uvY6nwUWIzxyAgsNRObcL0+3hp4L/k=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;6:+B0BM9pP13gttjJeGUHL6YYpPvxmPH5sAph0r6C73wfEXiQYfFBuPOs8SeQZ/TBndq5lDVQjRIjldXueeYQOpS3G9qT8P5SjxMGqycvQMfT0asJ9bXF7wFfUppcKFTeK+flb6RT3UkrynBaFKV+JCo1SMwFa53d8A2qLqWJI5IV1XQsYhIcelm5ezch4OQjuLwxJ9dYbZPiaxysrUVKnaHLLEBRiVUtFWLMIz6hYx5dKNafqi8ooqetcp4dp13vo7MKokRRq28iaC1HXr3fudbQSfKJUiwK4Mc9aQeI2+iNsrOIcDjKcoLbigOBLBgiWiBaa3DjQPNERTIubr6gIQRyHTZdPaNUXRXFF7O8dDv9ffNq/pQ2X0OhtmFFSHKlBfUVikjLc1Eupnlu5EfPPcjSA5zP/XUGIeb/riz0gl/efpFv5cK2rO3Ctr69Ovi8MRNBAVVWvMBpnPxR1T/dfYw==;5:ff4un3IEsUJlfzgfT7wnwRjpPAIDBYw8X248KdpWqMJSRf5G+Myq5i5oJG+x8T7zo5XTaYjdsRgr9fAnyKEAlMEUgCBlmJodFySNeA1/+7vyP4sSbW8ME/Y8Unq/UzhXtosaFFMc6oHq/WNpBFtJOPliems28xHgBUDcMcICAiI=;7:Tftg1hdzcnqblbk134J4NnVS5GCH4B3GxQZ7qa27rzXZkdbchUrx1liNQpYf3WXer71LLrGrpVPZQpGzu8QDOFwDGyhPWAtFFv0MWzdN92V3/QEkYG66hoLYqN4GG2G5oeOxpRmAZvf5L6WpkU+Zj6wwSHRKxJC4D6Qr54gs/1gWXw3B9S79utwZjznNZlIlhYjylKmcYbh2rISxFq7+URGTWlditDB2TN8gOMortNYdavKlSrwnToUWiTT3UKwo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2018 15:03:21.5147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cf648a-2b82-4108-0752-08d6159c380c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series fixes the broken BULK streaming support in
dwc3 gadget driver.

Changes in v4:
	1. Corrected the commit messgae and stream timeout description
	   as suggested by "Thinh Nguyen"

Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

Changes in v2:
	1. Added "usb: dwc3:" in subject heading

Anurag Kumar Vulisha (8):
  usb: dwc3: Correct the logic for checking TRB full in
    __dwc3_prepare_one_trb()
  usb: dwc3: update stream id in depcmd
  usb: dwc3: make controller clear transfer resources after complete
  usb: dwc3: implement stream transfer timeout
  usb: dwc3: don't issue no-op trb for stream capable endpoints
  usb: dwc3: check for requests in started list for stream capable
    endpoints
  usb: dwc3: Check for IOC/LST bit in both event->status and TRB->ctrl
    fields
  usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints

 drivers/usb/dwc3/core.h   |  7 ++++
 drivers/usb/dwc3/gadget.c | 87 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 86 insertions(+), 8 deletions(-)

-- 
2.1.1

