Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D35ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BFFB208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="brDPKvBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFFB208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeIOTtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:49:35 -0400
Received: from mail-eopbgr700073.outbound.protection.outlook.com ([40.107.70.73]:6336
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeIOTte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNRpazEuGNHLgXsN9n/WYn7MQtV4ZVJUZLU0bTeIuI4=;
 b=brDPKvBQ2uP29R7UbNv1Wi6EsbEQmf6ovQqnV1/ueB9+aiNTMh6FVki2755QYbqWbe3M9aR94hVOFWjOLkAcWvmIBx3CxuCOC96fPb9Gn9c/Xrk85sqfGex2AuvM62xsdq7G27zj4BaNBsEVFZ9m/XAnMg+eRTXbzBOsiJN2B94=
Received: from BYAPR02CA0058.namprd02.prod.outlook.com (2603:10b6:a03:54::35)
 by BYAPR02MB5112.namprd02.prod.outlook.com (2603:10b6:a03:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Sat, 15 Sep
 2018 14:30:21 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BYAPR02CA0058.outlook.office365.com
 (2603:10b6:a03:54::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Sat, 15 Sep 2018 14:30:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Sat, 15 Sep 2018 14:30:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33783 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1BaV-0008Bz-S9; Sat, 15 Sep 2018 07:30:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1BaQ-0004hn-N3; Sat, 15 Sep 2018 07:30:14 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8FEUAXh031311;
        Sat, 15 Sep 2018 07:30:10 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g1BaL-0004b1-Ty; Sat, 15 Sep 2018 07:30:10 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 0F30B604AD; Sat, 15 Sep 2018 20:00:08 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 0/8] usb: dwc3: Fix broken BULK stream support to dwc3 gadget driver
Date:   Sat, 15 Sep 2018 19:59:53 +0530
Message-ID: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39850400004)(396003)(136003)(2980300002)(438002)(199004)(189003)(103686004)(356003)(50226002)(36756003)(8676002)(36386004)(90966002)(305945005)(8936002)(48376002)(50466002)(107886003)(81166006)(4326008)(81156014)(2906002)(39060400002)(5660300001)(106466001)(52956003)(6666003)(42186006)(6266002)(316002)(2616005)(26005)(486006)(126002)(476003)(54906003)(47776003)(478600001)(63266004)(336012)(186003)(16586007)(14444005)(110136005)(426003)(51416003)(106002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5112;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT060;1:93MyD6c/Ti0m7Pz4sBOp25xhAIEi8xBl73s9+zgcoiNZYTd8LPcfNbwblvpjB6RExRknvaGZG+QtCE6/j0TYLnAzeBFQ4GfkaoF1K//aMMHwRslJttAV2ypEw6YTPwbD
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e1f5d8a-7bbb-4d39-50e6-08d61b17c436
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB5112;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;3:+O5VQ1scQ9SQOxx6H45cK3y2gW4Jr18/5gLh31hXBNWOd0ogyAPPRdPp3pzUiLz3+MzvHJkwH77k8N9Xl2TdfySpBki8dTW0E8fnepZDjFFFray3deiqsbpqxYWfCtskTo5zbU1eh84JyjNE34GPd2EWNxbL5CfGZmiwmTrRUN8P5VxzrL1ECjmjMJVMHtjKiC7b5/3d5IJqCwFRIvzoeH1S3KpN3TXGN38n3JKU6hJbvd9I5q1TyfVmMv/2IIrf9xkeWseaGMJzfxZe82MNH0ga4YAzqx0b8ennrQZGqjBJHOE1dN36GSIDnqVicBoi+A8uiPyK7MNHsrodJprctgwpGSpw1Kiz9BvA7c8y6eY=;25:jPqZlDTlJt1pQXBeNx31GVQ8P4Se5IChVqoYPsQh+9T+6vvnRXcV2ydCSr1UqllTsli8GFaoKaR5RFzsbEc/huqSq+8yMFpXg2nZ43E2HTUlaJKkePxhYKPD6xGoG9xxZcnkXzZdbEEjnV+C9czVMKCr2GAWrEgXiQAmmsVdFfhKpkU3WNWOUEc7P/wOLN3xEic7mBk9A7Vow8iFba091gBRVz5FxPwaXoz21QHazcD/IlV4X2EtqPEWfZpcl+ZTBFXmPm2/Mzbss+8r33oCDLbePZhTq9YJQDe8FD4Fq5kTVhC2+if4VsJ5W6qP9ifOus5BsFUnOyAL+wCc2/SvMA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB5112:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;31:fIp9KCcfvXrt+VikGWOyDUtyjVY8SmyUlJqDd3J5YaTwJWvNXi7+A9y+X7r744ty4MJj8ds/UITCKzf1RxARrzjZBWtzRvJyeUhXEjcYtM/K1Zl5I2lOqFrZlS5bkDMge9W+59lINf23HR3PJVQ8sYGem1zBDkKnquNUdc5/dO3EprN59HlxOezq8e22wTH5WG6rfSFaM/QnYN5M4bzcT20zMC0ac1CKZvcQh6+I1WI=;20:2aSy5FdN/KqfC8GjrdQH/vcYqZWrwgwhfljaIo+xkcBheRyTRByi7l2KUr5TdafvLRkXLC1hufg2Mb9lpPGas7geeQp+Pw03a9oHo6n18Rz6z7JLjM9GpnE62XwOiRPYomXkaDEqsa4Nwm6DqaOGd7E8LNUYpOF9DELhA5Uqb9xqXlybxP53+Od3iIRjCOwhq1iNSlQ0aafXXYGHaWq/SbYMn0z92ODXdMQ1GNqwKDASSNOf+MiCm59xnLMuV1QiByt9Wivx4M4UPIS6pbH5MHoFSyMNaypAphClK526KxcOMtfzGXAdx/fzXxm+R5GvLx1IzEQDoDVEWyx/KNJVLWc+bm0wEndNGWePJwPByq8JJWUBoXrdSR+MxGR6eP8PG0Iwj5bvoHHlm95567GyofC2YU6HRMbznIDciSJeNfdZzrm7VQsOFm0WfZPkRoSZDCyhGcgTl1bOz6kQwZA5pD+DH1o0F4U2fHGdkJRJIx/KbwxCEXI/XmAuVzvk41Y0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB511278906E1016CF17BA31C0A7180@BYAPR02MB5112.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699050);SRVR:BYAPR02MB5112;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB5112;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;4:s3dZS/MI2Aiz3THkAnGBva4qyKrwU8HgTZlaU/fIC7stcOIuWcZcjHxMpIPPcDlic8IJNrwiIwyYjcgxGfR+jLdT3eERulrI2L0Urwp7PGzL0ddRoPC6ODgFP/qrXrrAJCtll/QKg3+00YWkZzaprOIk6DLE2F0pJgZfG79rzmkmzD8z9DqQhV6QrWADEUnCRlaSm+Qz2Ij5qS7WvLw6vyeQl5FbMJRuFA2ItC6FQpvyzY8kqa+TGYibhgbpDWnaWvHfukxXoj1/iTMW0xIwtw==
X-Forefront-PRVS: 0796EBEDE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB5112;23:gyN24PNr4Lc/X5jhfHuX1PYz9mMnndurIiUZpTJhz?=
 =?us-ascii?Q?8UY04QS3wBdp9kgB4plqie8uMQm3wVkh4/UC3OINMOQd3vK0hJAh8GLQatTj?=
 =?us-ascii?Q?2oVaMsFajWknJrF5vEaVimkPQpLgs7Yn76hEPYSus7MJHTTj6PFgqM9YMxt4?=
 =?us-ascii?Q?Ib5SkFp0jDq1scM8fjvyC/tN3LHMvQgl1Ip/J70R4BZ5zi+TRmPS++ddPVm2?=
 =?us-ascii?Q?WXA6Sw4SAzU6eKTBgVRfKxMTvIxF6kVhuP3tusTwSAWWZtdTkMo7oUvIudey?=
 =?us-ascii?Q?khf/eJTAxvkj7CM0dzYPfiqKFz0cpn+ojUmjnn0GZ0kGisISgIP+oIDRtwUi?=
 =?us-ascii?Q?l8SXxTSF3CNMWm5xVflAFog1lhw16+uGHQlp5wBqeaK4g33u2or72crQjSMT?=
 =?us-ascii?Q?ZYt9imSDFMsx9hYU5/mgK2N1ZNWlOW+XSiVe8Ujq6HR37GEthTaNjqZh6Uf4?=
 =?us-ascii?Q?PTLIIG9b6Z5m5yTdgWJI6/5uJXmQKAfNzqhm/HC7Md3mtbOm+UF8LjIvRf9h?=
 =?us-ascii?Q?L1gvssS4YJMxyV5zyEXvLyfiu13+GY4uhmBUGoxGqpdDa2cs8FG+Jvsb1cDR?=
 =?us-ascii?Q?oLkb9hsLm8zzZh0Rc9eFRY/NOn35KE3//QtitvG4YFXQTOYHKY2D3lMKewZj?=
 =?us-ascii?Q?2MAwmA5PKicuQwzDMH8YjiIQ+SBLZY1Aus4YxzpQSU+u6fjGqpFPqPxRShLj?=
 =?us-ascii?Q?1d8RlHcKV/G7DubzBMIMKXrOqWA3+calTbC0Y50KS8owvm6IWtCUKm2YeTIC?=
 =?us-ascii?Q?b2aSHjES3341Qi/ZZ55xPCL0PByR9iveieAaxtx9S/BGEV6bHdyrv3Mhkz5U?=
 =?us-ascii?Q?IzjkaSOz0MbRcLMTxMt5Y3kTkew9+01fmQjZi93pJaOu1D/NpDVicEjh34vy?=
 =?us-ascii?Q?XkAdDzVwGMHwJaGN/uxeu/DAlGyNr/kCbo3lDxD1bDQtt6D6GUqGNaHWzMPY?=
 =?us-ascii?Q?ufdLhCx0o+1Ye9k/gd8RjLLjPH7SPtqZev3YCIwW3NeRvJ5jd3qOYgX5pZZe?=
 =?us-ascii?Q?NfwLuNhEB0EVEzqVCVulfVVbqEjJMgqvqLi3emETZuHyODF+f3GyuZngO8R7?=
 =?us-ascii?Q?Z0rRqHFtXl+zCncdteBXOZzG9W1lOVfrWUSVSunT0XEic5BOXjBpbhhexY+K?=
 =?us-ascii?Q?aBldIxrwhl4u77KsEd4acMRA44MvyQXgTNEopRAVxmnUj9pX94WLQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: ywI/lLzM1q3LbDjQg0THgpDpcTUBVD4UgUYmuwqotEGw2k1NWEVahEESmdO7hsF683qjhSQFJUkW30/970tlmZ4pfPoNrl8G/2DuYzNXBdq6JcAXyQPvnGdIX1YGxK9Igmq+t4lTmYFSxZyw6ZY6AwR7CDQEX7ZY55/KMB4TcRGCsH05BNqPTYRP/k/iXvbZMpBK1CZ5erhJP8T/A+vPdh4FiTzXBfz9vRJw+DyMi8slGI7G9bc8slBcOJNZwp32xxPqaq99FRdZaRD4j1BDoVvB7qCAcWkBCtHawVVCLcuLFymUnAO4OrxV+6EmnRxxoC6GV9+kHa+W2NWdX5ElaXMIINxaOZZ6rYfEzW7f8I0=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB5112;6:ngk6BIRO9Dn4QoIbZmSO/BvOxTZzSGQOwwleEhXZSs21ODyjjsv+QkdggZtKOrfuxIuAI+vogs7kvY0Ct6CPoi5KJguATFwMmyT/Q0H0E8l32NvxixSzgnQj7DkLD6ihU1EdjooCJoNfSoTZqwWUV/TUKJeAwyXhoj2QSfMdDtcYVaj7YMIA6daLjyYueHundxY3ZY8xzknCp228exPxdOUiSbKwHCVjo41Ck3of2X27m5SqZ+wPaJ98OVTg8bGjOfiez4DiJ5p84JfcP/v6UFz+BhrylWG/ovdFCHtSbWGJxTWRhnp/qZlqQ5xCjfxi9OVPZefQPYvNTYPtS25hbWrvrFwu853AuKVRFNP2BqRmCY0v1btkjI/fmXb4LtxJEPSGlWo2GTOG3nLIjI9V+or2veCgdhlgbWU3xaSy9C0fBSmOfzxVA81x4Oi23qm6QnFwdCqm2Oz/h2eNnhdpQw==;5:hpRkaUNyT8L8Vu101DCl8ApNb+nOV33Czjjb9eBvXjvHx9gBGDhzbJyoVMa0qPlS0FmS7pKnYBeAmA+h8aqgGjakQDad2swf4d3P8XdRCWwWtivzzKgJNXnnHosbQXZxxD10FnmKQgj1S3TOZzrP+Mz2LGk6uifcPYWwY24TRHo=;7:HO0Xi+pghJEmpiKzMi1nxJdHyCeQGJDf1ZkDFykdKUHG+7RV8Yh2Rz5Se+T9EogajtWUVet86XXJ60PxJbDbZ85Dj2TK6Atmpemd00t0G0NmS/IzSHKCUH0o1DpcUVvpctpw12IBgGDYTIh9uBUFjd7iXhuG+i2j3Ssy55PFpjZFemllbSIlXdXyhPRaSd3MDJCNjU5/j2U0u6ByzqI/5TVbTkOveptfT+fiIVnvZ6YqLy+UMIafO+QRmY8a9h/G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 14:30:20.7877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1f5d8a-7bbb-4d39-50e6-08d61b17c436
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series fixes the broken BULK streaming support in
dwc3 gadget driver.

Changes in v5:
	1. Removed the dev_dbg prints as suggested bt "Thinh Nguyen"

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
 drivers/usb/dwc3/gadget.c | 85 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 84 insertions(+), 8 deletions(-)

-- 
2.1.1

