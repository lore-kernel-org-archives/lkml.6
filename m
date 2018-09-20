Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F586C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B9B21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 09:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Jlhn7fus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B9B21525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732288AbeITPN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:13:58 -0400
Received: from mail-bn3nam01on0069.outbound.protection.outlook.com ([104.47.33.69]:10990
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731640AbeITPN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSrPiHLveJD+Ik28t9U35V9C2+WSdwK+UobgyTDP6Iw=;
 b=Jlhn7fusQi6YUH+SztZZdtn4Sfx3y5jX6xGcn+j5NODcU6Jcy0G7cHBozcK+AZELf55Kay5B7gFDAxgOas1suYhMd62VyViBTenIbfMl6bvNjTrtkM41TgaeVV2WbwU2mslBpQHyW9Lz6BBuW5U4LOzRhhgzLZ3gI4SrZOKHisk=
Received: from MWHPR02CA0021.namprd02.prod.outlook.com (2603:10b6:300:4b::31)
 by BYAPR02MB5111.namprd02.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Thu, 20 Sep
 2018 09:31:19 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MWHPR02CA0021.outlook.office365.com
 (2603:10b6:300:4b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.18 via Frontend
 Transport; Thu, 20 Sep 2018 09:31:19 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Thu, 20 Sep 2018 09:31:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIs-00015V-1U; Thu, 20 Sep 2018 02:31:18 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2vIm-0007oX-Tg; Thu, 20 Sep 2018 02:31:12 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8K9V7kZ013434;
        Thu, 20 Sep 2018 02:31:07 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2vIh-0007ka-6V; Thu, 20 Sep 2018 02:31:07 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 5AC7412167E; Thu, 20 Sep 2018 15:01:06 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <leoyang.li@nxp.com>, <jollys@xilinx.com>, <rajanv@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH v2 4/4] arm64: zynqmp: Add 'xlnx,mio-bank' property in SDHCI node
Date:   Thu, 20 Sep 2018 15:00:45 +0530
Message-ID: <1537435845-6682-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
References: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(2201001)(6666003)(63266004)(54906003)(16586007)(106002)(42186006)(217873002)(15650500001)(110136005)(51416003)(48376002)(36756003)(50466002)(47776003)(6636002)(76176011)(316002)(305945005)(4326008)(426003)(81166006)(356003)(5660300001)(2616005)(50226002)(8676002)(26005)(8936002)(2906002)(446003)(126002)(7416002)(44832011)(36386004)(106466001)(11346002)(90966002)(81156014)(72206003)(336012)(476003)(52956003)(6266002)(103686004)(186003)(486006)(478600001)(107986001)(921003)(142933001)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5111;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT018;1:/NjB0fByn4GZ+ymgwT/XGZXrS/IM0WinNBLv39FsPuMJ4DK+6Tb3VcuMRF+flWwLGffBUDziMB4QPwasjs9N5ab6/ItEgyxDda3kFHsctwW/4wdWQcajb6pGYUUFYnZi
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a626e329-b513-49f2-6930-08d61edbd21c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5111;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;3:nds8tTUfuEHcZPxTxppykD9EzPW+pd71D7Jyp3nIMAXZY7BnJdOLsWhmLZ9M0bMGmQjkXGZSPl4fvx+wL3B3C08XX1dStugSFpRxY6BflVry/wtsiaLrp9mM+X0kB2M5+Rx1TwItoTrgdIbP7QXPHFKZzquTi0e4Kpwo+E64yaWp+WiaTR8/TrqwVq5hvYxKRxy7ohGeSmE0QAjvb4c8/5kRoeFvaUzZS1GeZpB3jWimCWCbqttFBrVD6wsmbA4QmiUArET3X9nbWRYAtqia0srjlPwqOQL+3FFD4wzW0ULh7n4XvmlBOG2o4B+1i9xc/SINjZ9HZ30iRg5wquJDqb5DsX6+nCJAvJiuqBr7XNA=;25:vL92PkYpCCQuc+DX2TO3xTXY0DGbG5kK1eKuYZED4beARMplaITLkxDP/tLoLgHPQR+Ze1Ww2SJNPBhT/DFo6FUgqMIekA173L79XR4giG9HFiJanCj4u9zFAXlXRWrqRii7RuleS85Z4/XG+5mVpqzgHSe8MaBT2TnQ8e5CEvwHwJN9sHLUevwcDMVix8iep65b6ZG16DzbMqR7pHWB77b+NXEMeu5ta44ZQl7ojC3Cek9eI6q2/L9PqeHILku4GXyg+mwuvEz2CSXu7YUA5PQcgJt4eVXwvTUOzT8JAsJ0LQ4C1IMCvcrqAm96mp1tqWnrrCWO9s7SiKgx7wU8GQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5111:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;31:POo79j+iAG0LWmGIcTyL3JD7iBg2L6Mty/8P4tHRtqAQudHaVStX56R82LUsZbHo1KUpfKtZbfh70UMd+YRjR9uOcrVUXZcyLTjL2p/bPGmx55aB2hkVmXyM0w6JnDu5Klz1dGlN3Ph4cgN8A16kep6z7w7W7xM97YPVcE4l1RWdzvVqx1gFicdnt9nJbKFO9yFbmEwDrE7YraqHsqGfrk8EPJA63B6mguEPxoK2rnY=;20:Rrc601w0YvEV6bpPni/ix6q9PlCpsXRa70Bbp/HMbv4Gd3q04HpQxW8E/S8Lh/SLbtz5M9IMqPuyHdvhI/jAnICwva96vlYPKBlUuZF9WJbKJlyfSzxN4wDd2Lrq2Z+EdNn4tEznYTFk7+5YC46wQnbkI9pCUbOSJoOJ1U9KxS21YQ8BwlkFDm4reN8fmPgqrpRuoIh2Rk+VJ9ZPGc0G1z2FR+8VXUlr75IphAFWN+D8KNXb0owDRFjF7qNhdRNK7ioOtyOcebwiUSl8g7xn8CZzZ8FZQ/N2UdfXgd2TjFzQOI5GpJwfxTAtR3MU1/UX2tz0awu/oSOZOyjM1hn/vd+c512JJsbxRS92yqC8WSCVstiGDkqMYOQlgcI/TMElpC9OZCZv08hCxlOJq0UXPwNe49nh7nxiqcAe1o5AWv0qwdF9x5YOiu5HaJRo+lZihVnfFBiVXJo8h4CiwCGQgJVzrNrijc6fWsXcStfTC68+oy7pB+j0eA3HJu2G7Zct
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB511119E7B71CD6090D7F567EC1130@BYAPR02MB5111.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR02MB5111;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5111;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;4:WPkNjpACr/rTLYalad/NbzMKLKRgS9kqjbZM19vJwSj7RCbIWzkS+uykNb4hhtLYi41V6Pb6AvLR5ATs4jX5dlaBMbP2WFsnB534vJnPg0rVxIzx2o5vADAmT+3Fb7ASRyzWu7IhUuWmbq/znbgQFrnAwXV0TTIZo5Q5SfULVOwYjGRK0h7HVp6UsXOIZOxh+XxgCeED+b3KR11Zac6JjntdXcYgW45xdC2+bhvgncsbbQlt7rq7/UUtkGB9/oX3nILdfmlWTv95KEJVbYf2sBSWkKxQ8ICjLu/o/YichjyoUzxfWi+zIl18R4hIxF/aPmXEW6We0q4KLRtSboNZC56nWTQgW2PG/v8hGBjxFNw=
X-Forefront-PRVS: 0801F2E62B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5111;23:wmMexIIV+AwalhPoLr8qZ12aHjmMPMPkuW3z1Sfer?=
 =?us-ascii?Q?gv84lax+m8EWoAnO6SseWLMTP9BR3TU8hMFF5SBcPIAMJ+ffGjGK+laxZToJ?=
 =?us-ascii?Q?ypylmte+wwl4CXY2PLdXDQfUP14BkvvRNlJgXz5qGwLXT5nV8if4abWPZUV7?=
 =?us-ascii?Q?PPwSSzFlt8wS/Sb+unWbEH79/Eue/gY2cxxgue7RC9XYvz1Fg5ymgyLFyO+C?=
 =?us-ascii?Q?q4wpQBczLKqXCZOGkWGXuNL/FCc2p41yJRotkyqzCix+uL03b0y9A8t6hJY9?=
 =?us-ascii?Q?m/G883oe2BCEfX6R/wA1XwNrECbeay8x3ax5TlFwLBAJ/2FJlVmCkkhwOCBt?=
 =?us-ascii?Q?2qtnAjKjroAKhAbMzLDjg7nnXKh/0RkL/LDzAdBwoSNnyrXcw+Q7alr0vWFU?=
 =?us-ascii?Q?Shvc/qJKgWdYSNxX8FCCAaKFbnUXLcJ/NYRM9RUEtJ6c5b6wXLewA9wfyeT1?=
 =?us-ascii?Q?42NCpPqZJidng0f9P7YHODH6yfseHXoiMAE4BYdkwqT+o1ATjHnc5/KYcbuk?=
 =?us-ascii?Q?LZ/n82gzwdYyFNHxHTuipaKrAkeBCceW64sFNArkCkEtgJHwikM5Gk3XkDQ0?=
 =?us-ascii?Q?3WquFD6TmeDWi8tf+mUwKWhGIGbhrc76r4rTYPNn3FJ2XERJurtR0eABm1vI?=
 =?us-ascii?Q?pJFCtRrZnI9BTDP5dU4Q5W8xUfu0Z/Yu0YrvK75HSZQwcjnxOtFz3KGZOeOY?=
 =?us-ascii?Q?lznXT6b86Hvalxp+wSjRJjMZ4cvl/8MG7o8Zd+VIn4AMicB0w+aiRjbAM1GN?=
 =?us-ascii?Q?oIdCBvVdgNtrNC9H8mw+003G8++b2azja/X1vdv/eeFhmMJmZH1k/5letCga?=
 =?us-ascii?Q?TAXUMZtRWlS9TNVfbSJzKOY57xk7vaHmc7JjnfPcfb1qs/y4M/y1S6YltCxa?=
 =?us-ascii?Q?G6uMmuUlTO88Oe/p9IBlxxrIkzgc3Vog1bY05hfKmd394UohvtHp5D0ACytX?=
 =?us-ascii?Q?D57gOyZGvi/M+wiS8WvSVgher7HPXJ943oMNfTMx9ZG553xLyDq16cwPmHfr?=
 =?us-ascii?Q?xS1TxXivk5UMnriHvcSqOjb9Cys35Uu1mvN4mA4qoYA9nLhhNbts/rC8kMFE?=
 =?us-ascii?Q?0QW1H28vT2mcnjK+fJPi2jN3msvZcz9MgyqzBlagAKdGz13JwYBgTuhymhmh?=
 =?us-ascii?Q?EpaDpnyuVi+a6rKY0jRnkj8NzHE3XnMlhEgbVqqh4eUgT4/IzRiqyH9gpXRz?=
 =?us-ascii?Q?qH4c/bJtKVdJFuugrm1Fd0xYCQkdwQLLH4g5rLVsxXqEFDu9QHC6V31KV0PV?=
 =?us-ascii?Q?sc4dorx1WzaDlslLOsIG1Q5pMHjJMcrnhAz9IOMumpYIAO+B1tmKvx6KpmnV?=
 =?us-ascii?Q?X3gONamuHR3EYAcJhr4eYL2FuJ7I5DAtoBCRBN3YhFdLnt/NkIKuJpWZW8jF?=
 =?us-ascii?Q?DD9lgEWEybysP7oUgHyFPuqZLg=3D?=
X-Microsoft-Antispam-Message-Info: s8+eWUOzgyD78tuQOwy/Y3lFFzxyQcRFGdCmNb3dG4l07rXuRWKNHA7fXYrImfRgZ99ywqHxyuvpFv0XFMFdqcDQKERU5+bYs/8wPsFJoFHuEfc9eAl2wkEfXbse8IRwUs71IhHuMv3Fx3yqOUGkyZmBjMjamsqH3CS90XcVNq+mYHTeYqpx9xaDIcfIKjxXtKnclocCNYFh6/vMPz1/H7znW0UJO8GqcHZtZyifXxn8HhvamhecXpMPpdqV70tNwlTW85AtTfK4lccJRXRY1OnankSs0nTUD/id5CLts6V0qSPxdcylq6hzt6htkSViRz8uW7mEwTpyMwh+HN7i+C6JlUYmuJxpyHA8FikF0Rs=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5111;6:3mO6FfgUSoQfHZVMSeaNpC6whh95cZkGfKVXCAAXT+KIucZMQzuqaFggJcOXzwN/ZcSDhx96IOj7T2vFa7ran5GZ+CblLlX0ttkDOHMm+4ICM/UhQ5bemf9ps1AChdVKYXgrVx0iN7zWNaNB/rRGHAl506R1fNPwXB4PzuW54UFLICs0pSxi5vDcuaeLHx7Lf9WCh8tg09VzcPRxQCRcI9YWTpCvg+eez7f4nB9wSIj4K3UkfmQtmH7llffEwjnwAvsniQRGeVwcPkrBm2Yct4STYppGwUwOoiTs8OLTxJsrj2GX9rXLfzJkNEjlBIAD/wOJnxOcF/v3ywA2ENxYm5mUMIm+/oeGcikH+lV2akuawOnbeEoDCrPrecPGVRYp3/zLk1/pWvi+v8Fdywf2iZ0EDRsUUXGYxSakAD81nvh0JjLehJO7U6mqm1bMMkw3asaQLNAWJiCkoLVPnvCvcA==;5:Z9HfrI6f1aQ5mNou1DNab++1H5lyztQhw4E9hvL9XjI/8RmjUtQBPm7CZnNCzmG7E3OyrU/fOCoLGO67LO7vQGwfPXSnM06s35wGGMU7jQLUeyxVHb0eqV6Web+OegW/Q+bsxbkKEEEaZebm+cDTRr91cdR712EZ2w/UsssYG2s=;7:abnnCQQzJcUcPz98xFqMa4+xJgQ+jpGiaaJJ/jPbDwmjGai8znuWVZ1URxEOc8RflxDGAMX6hsMVQqAeeS627EuJ1CzLk5xKPd76mZ3MQopDTNW9mqq2Kjll9y0DwnMhA3vq/oWcW/cKBBoQ/XaBr6c6WVskExXoo5+93OanmWhjD4YuAchQ3SR1jBms1hZvZB8uRAP2VqDc054aqYC54vehvfkLjEoIrZ3abFzuXlQSCDZjviVNt7OskBAndquV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 09:31:18.5158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a626e329-b513-49f2-6930-08d61edbd21c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a required property indicating the MIO Bank number for SDHCI
controller in ZynqMP.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 1def7e1..7ef002d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -492,6 +492,7 @@
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
 			xlnx,device_id = <0>;
+			xlnx,mio-bank = <0>;
 		};
 
 		sdhci1: sdhci@ff170000 {
@@ -502,6 +503,7 @@
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
 			xlnx,device_id = <1>;
+			xlnx,mio-bank = <1>;
 		};
 
 		smmu: smmu@fd800000 {
-- 
2.1.1

