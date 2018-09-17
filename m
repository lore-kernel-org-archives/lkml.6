Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70A0ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0542098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="CLZwSgdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0542098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeIQTxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:53:08 -0400
Received: from mail-eopbgr700063.outbound.protection.outlook.com ([40.107.70.63]:9696
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbeIQTxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=raZ6Uk924v1xDT/b5VGfzq9EWiiEWa293GxMnUYXOus=;
 b=CLZwSgdqkqrcTgDGtQcamnc1KBcT0VB+07cTyBz/HbT13LvPsLQvMyPIHb4J0OWP2ZoLvP0zHH8+BKeuJw7iu0UuVCVtXR0sx4L6AlB7M98zUwXqsztkDFpqcJFe15JTWq3Ol26r4P43qqkZ2rujinieHD375quFvT5lgL+w+OI=
Received: from CY4PR02CA0036.namprd02.prod.outlook.com (2603:10b6:903:117::22)
 by SN6PR02MB4479.namprd02.prod.outlook.com (2603:10b6:805:af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Mon, 17 Sep
 2018 14:25:31 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR02CA0036.outlook.office365.com
 (2603:10b6:903:117::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Mon, 17 Sep 2018 14:25:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Mon, 17 Sep 2018 14:25:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uSv-00056G-Kx; Mon, 17 Sep 2018 07:25:29 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g1uSq-0005LT-HB; Mon, 17 Sep 2018 07:25:24 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8HEPH4O007834;
        Mon, 17 Sep 2018 07:25:17 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g1uSj-0005K9-2S; Mon, 17 Sep 2018 07:25:17 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 3FC59121463; Mon, 17 Sep 2018 19:55:16 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <sudeep.holla@arm.com>, <amit.kucheria@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 0/7] EDAC: Enhancements to Synopsys EDAC driver
Date:   Mon, 17 Sep 2018 19:54:58 +0530
Message-ID: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(376002)(396003)(136003)(346002)(2980300002)(438002)(199004)(189003)(2906002)(42186006)(81166006)(81156014)(50466002)(106002)(6266002)(48376002)(8936002)(51416003)(54906003)(110136005)(50226002)(103686004)(106466001)(4326008)(476003)(63266004)(126002)(426003)(36386004)(2616005)(16586007)(486006)(7416002)(336012)(44832011)(36756003)(305945005)(6666003)(5660300001)(478600001)(90966002)(8676002)(356003)(26005)(72206003)(52956003)(316002)(47776003)(2201001)(186003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4479;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT055;1:447P6gZzpNdpJ8gw7/W36UXixRw6Y92s1mE+OWd+S7phNnrYXNU6SUw9X5Aa/GsHRZxa2Ih8QfS85h+gXVraE0uzNA1UDKtq4z7gj9eazntdYU8qA4KY+CSt71ASga3y
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c1ebc34-67e0-48aa-ad47-08d61ca96c23
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4479;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4479;3:WK22L1ybHH+6hG+9i6hlUBpDgozw09fyN/lxHLN4UH8M5OaIXg/TtWjfdW8f2okeO+al9LL1R/UgNY73WsQs9wxwLDkqS6tPd3kCU/qZZ8lyqGc92LfIfGhmupW2fZjIr4l17D0uW//NL5aDaxULHoBYIunyn5Ypme8bbKiuJFrtyT6qg6mBuFyzKW38yKv7lhvI3y4UNq5s4xNGnyyYTkelQL2gr+1WHIGo65Yf4JrOqTpdh79SYLdmI2FOiHWHxKF++vNil3AxxsCUnQ7/sQgF+cBPiVJrZHzXLKATbi01c6fB7B69NsbyQ+J2v3XzPi05ExnZOjAdu3xNhRjsvwGeNeYbuEW9pVJPURQeWog=;25:XPl1Ty3ndRZC+Z9wkTtM67Qp0N/wu8PlpTFOjYoHg6lxE4CwBpOsDnY3EcQCh/udMGAcbZkHEsQT5ORGjE3En/bwLSNo3LUWWWZ7kbSoVTfi3Z5fGLf9B75OEMf7OYgXvem3J+XDNVhH+4vstnB//uJ9DjdGttKuVS58VahmpXOiJKbWz4aX62ofhzYX1UMY2TeNmfboDCSIbBmK8zqMw8nf0wn9rUJupLaCSZ11r4S4AT1a/gaq6wp7ubtL4OmfbrSBjsCU8XZA66b0dRwRnVhxMYPXbwlxQSWZ0a0M9BMvSHB/P5oSXySbiLSH3ihav3A+gJklSGtrRB9fIReCMA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4479:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4479;31:BfbotV76VFyymCp/VkGjkh9Gn8B4omo0Q7rpFccZ0VqLDlKbIrBKWk3rMTuEoXfJ3Xiwk2oAhAy5q++oeoJ/X/6Bz6fkzBCE72DmwjIM5nNR2eWoOlqayM6MWPL0mFE0MU2NIEzQYaSSSOT6GKJOu4DJRp1Th8ka9Ku7bj0UXYpJ7jmlrDBGMubSQkU9Z3DLROeKJt098bmC6/Wx8KpgKY03Obz9HRezr6CSY51eYAA=;20:gzdjrT9tInCi+FPkydEvzHSl5I1eoHhOfEzc5qEOE0zj53fL6FV5oq461bhjXcInDLtpW4tgjGqelpOKvaj+SSU43SpGyrHXTHkvtbrjwJ2/yePRGGEg1k3YyPUmYPFMu78LaqyhKVG/JP5XlgzChk+lZUHzXVcb5at97CCgYBybMj7x5I+XFtcFw0TB14T6yyPQocIbs+xUbpIkCUFhqeVvl4qm8jZlVUgknY7x3y1MSV45UvFvNrH7aGEy4cZJ8VNymJdmpZG793QrFTU9+ZsJ8g498gU3HQ7uMSyjFJB/H5dJ+pQIR9CfWLQhRzIDFKJ+YJkydvSPi2xmWEZ+RHfYpLuJromI6KkSPrTVJ2X4vDYxAoSEK/A/xkgiBcUK+Sn8GXFxHE03USOyThzqPyW8zUJ9unWDdsfcZR68ngDqe0Ja/A7rbj3sXWxXsC+Evr9w41vIVzsEeqqLNXR4r1hmm2JlaAhU+2QnfMYadHk/qfWkYZ6szkWzAFb/Di7i
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB447991C561ACFBB5ED88AE36C11E0@SN6PR02MB4479.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:SN6PR02MB4479;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4479;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4479;4:R/W54JufCXQlNAzWNKfsCUaPiHnwuRVB502ee3yjEUf4h0MLknQOSahlYKqUOqmNaj2EKzPbDPbiPKHFrASDYdqu4YKiKOlHTUynBbN0ArKVXLE8DsYY8D1c0DC3nlxGKIR1iQO0N+DKlzMYGvE8mL2FPEWcSF3V4Fk33q5dCFTF6iq7KWoTmAgGdOigBWTX345t5NxF4bmPZS14RT8G7I3V/7VM4MJnP97wVFxUpudWkI2zAlvdgDL+CT7JmXasadMPGoz2z/C/evld33iegw==
X-Forefront-PRVS: 0798146F16
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4479;23:jOt5a7yjlAD8QxJKvhzqM7MDKncIh6hCqdcXPxxUk?=
 =?us-ascii?Q?NZK6RPq/PnG3m8GhDHqK6Z9PEeBlbY4HjuzsTqHVhkT8NLjcM3rqjLaXsdKt?=
 =?us-ascii?Q?qDpJwHE2y3dmhpU73b2XZ7nzDWqLgBkXI/ZPiIyZwR35/3Po7LC+2AoiVvfq?=
 =?us-ascii?Q?E6nH2h8zxLR13kf/vMy9vWKL+ZWJCMTWE4oH7A4V2RUrkn01QIg7iJgLo+0P?=
 =?us-ascii?Q?fBIq1nvMRmra2SbwYaAhf0rKG0JtLiOEogQ851jjbydRfeO7K1oB4/NlMXzO?=
 =?us-ascii?Q?dJF+pM8azA4bgKLW013EptFNeNjODwYNa9n6jj49STfDlyvbq9fSNsuW6KGK?=
 =?us-ascii?Q?x6ylgDP75W3bc+6WPSX6WfaWgyl7gFkLj1x0HBwp41eLOhNIOr48C51VpwkO?=
 =?us-ascii?Q?gzLJKO3ktVA13Kxw4a63qTYvBJyojkoOq+NefbrtMTyzKke1fCPR2sgurzyc?=
 =?us-ascii?Q?QVQVEz1DrgB+o9KxOHjuzMVkl0kuziMlPV68rdT2Y2UOv9L3hU9kHp5yFVHq?=
 =?us-ascii?Q?h1shUHcX7PhJcAqUBESi1Ul5A/Rfbl+uNiBhsbxmG57jJe4iS2WV2Y34wSxP?=
 =?us-ascii?Q?yaQwXpgsZm6+mLhm1XqnRJtBKazRM+vGUEZ2XqzYJYtLIyUSrvcrHzwjLvp0?=
 =?us-ascii?Q?VaGs04WT2rnNT+xogaSk3fjGcVU+Tf6euWx3IojSuVszq4QI4SNC13N7NaWY?=
 =?us-ascii?Q?FBtZ6yCxDuRQHHPTRoEfkHs73qdPbSrP85xy+QMSYY0q+zhQZPmuoLueZDdH?=
 =?us-ascii?Q?TUJxQRG9XeTUX0WA8p2Mfm7EcX9ccQc8yNG8Y/1KETlY8213zF6P0DWeYNM/?=
 =?us-ascii?Q?+MzYGAai19rJt1Dm0rhLcyTQ4LXzCTa92fyTk59fTv1DrAeutYESlUVx5rVq?=
 =?us-ascii?Q?Q3P/F4ahZTJ06VVuotV2yhRbnVV67Ahpnsi0R51G6dz6XKGBg9GhfUhVjfr+?=
 =?us-ascii?Q?5o0vqch2feVCDKGqPkWIweloa4c7BX4gVvJ9xJOzOHU8hGWZsSTfIzfN30E7?=
 =?us-ascii?Q?wf6qUMaC1tckzSKoMUOnwlhW+3+pobWsE4tB3rcPFSSLbEr8erBLqpPxwONX?=
 =?us-ascii?Q?RHlY3/WxsBsN9yTtOhBiXtKAryMgXgDh9PEQB8xOuCV9F802ogjKlMmRddNS?=
 =?us-ascii?Q?ddhi3slKxwXtWBQRtg7yG7k9VUXWR2mz1olZ+sUZF9rwiIkQDGwrw=3D=3D?=
X-Microsoft-Antispam-Message-Info: t4UGYT69+Cm6eVErxvhKmMFx6zgTKFWdwQF6W7r4Yo+kn27AhVug5lGugfxOPM7bSjjP1aPSeSzj9wR8VkRRXkhYyZTSt6r6w5+J+kK/IF+i7FvmFRZveVFYFJKdWzpXFLEU+k6rkj4KygNJQwUWi6K8JswQ95KbBee7mFFN1TNktzFCztzMbRs2jXu4MWt18PfwhDoO27hav7CDPeZ3yDShGx8/U5naFV8pDkqxVi/DFodFpCylCX2GjnJTtw9gAHHxc3nTaXEcjTWluwiuYA4jow5fJowkL+u9al8zAgKML9ol3EJyb00eNYeL6WjSSFC1PA8qB/aiznEdUOGp+cyzNrEIhAKtEdnrvHrWQvI=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4479;6:hG2TkEncctOUTj12HnLjFokGIBBESaw/F/goLQkRzrpcyUmTppt5287N9EqGkDeoCIRui9sKqAQ+SUMo8cgEZkA8wkLNge7l3xqDJ7QS1F5oiLuQ6VB6d6SNInDgINFfBBH7TxF+PLZZzO/ZQMTWKP4k7YB9ar8mc703i19JAXJgh2fNXC21clZ7YojmfdHjSMZaD3iFxrgdnrBiClg1w0sdnZJDi2+9zTv/awhcjuSPrr6zxVGmqFgiSoNkqRmoa3IU0HgmVVJWqB3IfGyvMJgHNpcHIOHMyv6mNg2MupP9eSG7JVQDI0qvCyMHjGGtMcn3d9gmkWkVJlH5YJNYTkkxbFRE5vrkMF10o8IXNP/DwBjQb2/njniwfyhzBl2SkWnBLBbXnA/K5AkFYirhZSRFWMir32rfJT3P7xk7tOiSdK6Xn9kGO6O7C91y9EjMM3js6QSlcPSemoA2fG2tGA==;5:RqydHpAnityUXjSNbvlP6mo5wVPzOW+MZnEfhYChuJif+LtPxU0QdICdJIwKM8oIYsN5OBTdDhjT/O5o5iMeNXPJwrtQlcObXm1lNoS2YGgJlAqD9gSrw2Aa1bOzpd1uZ9DXLMOZInF11pjDiMtigrTD31sdS9MLq+7FjAtUfuU=;7:Ig22z4JorZir7F+9VjkFGnkZG/xIeDv2Xh9f43fbSQTt9gRuERcGn8tK7nz4FI2Q2ng/7qIHPOusYdMEwl7n1knt5/WZfgb6ZJ7O2RyiibY5mRupNM6m8e+reTLmzyZtWa9t7+nrkph8ctAokG8l4K5stItsCxLRAuSwqk4L3PDA0ZpJm1UzkN40LmSJYVuaBZchXFmdEPesiyjzBh+zTv9zJtdcybvzaOJpsPwcqXQ9RVylc/R1w6vM3LzlOHYe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 14:25:30.2738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1ebc34-67e0-48aa-ad47-08d61ca96c23
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances the current EDAC driver to support different
platforms. This series adds support for ZynqMP DDRC controller in synopsys
EDAC driver. This series also adds Device tree properties and relevant
binding documentation.

Changes in v2:
	- Moved checking of DDR_ECC_INTR_SUPPORT from (1/4) to (3/4) as it is
	  a feature of ZynqMP DDRC
	- The Binding Documentation in (2/4) is modified as per the review
	  comments

Changes in v3:
	- The commit message in (2/4) is modified (Synopsys EDAC Driver -->
	  ZynqMP DDRC)

Changes in v4:
	- Updated the commit message in (1/4)
	- Renamed function pointer names removing 'synps_' in (1/4)
	- Shortened unnecessary long lines as per the review comment on (1/4)

Changes in v5:
	- Updated the commit message in (2/4) and (4/4).
	- Removed the unnecessary check for match data in probe() in (1/4)
	- Some Indentation changes for better readability in (1/4) and (3/4)
	- Removed repeated code in (3/4)
	- Used 'zynq' and 'zynqmp' instead of 'synps_enh_edac' in function names

Changes in v6:
	- Splitted the patches according to functionalities
	- Addressed code style comments from v5 review
	- Moved the Error Injection to CONFIG_EDAC_DEBUG mode

Changes in v7:
	- Included DTS patch (6/7) which was missed in v6 patch set

Manish Narani (7):
  edac: synopsys: Fix code comments and naming convention
  edac: synps: Add platform specific structures for ddrc controller
  dt: bindings: Document ZynqMP DDRC in Synopsys documentation
  edac: synopsys: Add macro defines for ZynqMP DDRC
  edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
  arm64: zynqmp: Add DDRC node
  edac: synopsys: Add Error Injection support for ZynqMP DDRC

 .../bindings/memory-controllers/synopsys.txt       |   27 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |    7 +
 drivers/edac/Kconfig                               |    2 +-
 drivers/edac/synopsys_edac.c                       | 1098 ++++++++++++++++++--
 4 files changed, 1014 insertions(+), 120 deletions(-)

-- 
2.1.1

