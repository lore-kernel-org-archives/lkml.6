Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDB6C7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5780E20842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4cdDEggu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5780E20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbeJONOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:14:19 -0400
Received: from mail-by2nam01on0045.outbound.protection.outlook.com ([104.47.34.45]:50400
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbeJONOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajKUw2DpSoteqDej6wK91FTBBclwrY8WED2YNpk2LsA=;
 b=4cdDEgguDrLPsguZEqX76BoUlfelF9x3/uJNvu/eljBYvwegrq+t+Pf9L7MZqRajoF+hBCAMOdhZi5SpU7ATpnd7Bg/a4YKgREfZSLs57vBNme6OmhuS7Fqbg7/Vp2O65rBP8k7CrTCt2xWuWszIhrx4TO79s1ibQGP2Np9wcGk=
Received: from SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) by BL0PR02MB4324.namprd02.prod.outlook.com
 (2603:10b6:208:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.24; Mon, 15 Oct
 2018 05:30:32 +0000
Received: from SN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by SN4PR0201CA0056.outlook.office365.com
 (2603:10b6:803:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.21 via Frontend
 Transport; Mon, 15 Oct 2018 05:30:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT026.mail.protection.outlook.com (10.152.72.97) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.11
 via Frontend Transport; Mon, 15 Oct 2018 05:30:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59637 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSU-0006bP-Dp; Sun, 14 Oct 2018 22:30:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gBvSP-0002eW-8N; Sun, 14 Oct 2018 22:30:21 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gBvS7-0001hY-9b; Sun, 14 Oct 2018 22:30:03 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id DFA13121624; Mon, 15 Oct 2018 11:00:02 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <amit.kucheria@linaro.org>,
        <sudeep.holla@arm.com>, <olof@lixom.net>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v9 6/6] edac: synopsys: Add Error Injection support for ZynqMP DDRC
Date:   Mon, 15 Oct 2018 10:59:48 +0530
Message-ID: <1539581388-23963-7-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
References: <1539581388-23963-1-git-send-email-manish.narani@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(346002)(376002)(2980300002)(438002)(189003)(199004)(44832011)(446003)(36386004)(426003)(48376002)(476003)(2616005)(11346002)(336012)(486006)(126002)(63266004)(50466002)(316002)(42186006)(106466001)(2906002)(76176011)(47776003)(51416003)(356004)(6666004)(54906003)(90966002)(106002)(4326008)(81166006)(36756003)(50226002)(14444005)(8676002)(4744004)(81156014)(7416002)(72206003)(2201001)(5660300001)(26005)(103686004)(478600001)(110136005)(305945005)(6266002)(186003)(8936002)(16586007)(52956003)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT026;1:qgB3B9oePu42XUlpAtizxQLMR0D3IdqzjfJqKpaUo2d024kUa68vbrriXI4RFnVSJmYGsb+j42CviKEk/CefmyBidZBpidtdZ8szdGw6x7HWuPZAXO+i1C+421ZcLb9Q
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a10f66ba-c296-4839-2b5d-08d6325f52e5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:eF2jQKzb2skjO+gyY9P4smhh83nSTM3YSXC37b112g7uiZO3UTv05Lys6cuDKcCubWXtFVwIgLODGRhCNe0XqHNZW4CntiyVEaMYzcPZLEc/+ff+7OZm89uBTrq/Ya7ynpaw6SvWEClGCSnu/twsK0rh6jsvISBaYNfEiQ1IxRuYj+Lp92pVRPsJL2KgIsgPtsxvvTiRxes97qjTd7x/rv6tpq5o1grx2PS0N7N8qNXejG/kW3qQekoTe6xWJ/xPuikZN1GuybV93jSeKr2YFHkr/EQJbt4m2wN7NcCmO1jnpIN1OBLn3jk3hufxBRTGCOvyzjmHU04d3inkcBOmYWg1gNK3wufRI81WusYzaA8=;25:Z1QlxyeqY4rcsQVHfkIEdqsMdklcb+TlnXmPr1FSf5kmkUF+qKcqkMjBYkGE2kVuktRxBXl3XwI30q3xNqufyHjW/Egy9FHuJ9ii4jpTkD6YqrrjEQD5MprHay9lf6FWRy5Q7qtEIL+BCWnXOUyTg76pSbyiu0WgOUG10Olj1I2EnHO5ryKyoVvPgkMxWuA0S3dNoBHdM7TboJTNE72BgQ8qo69B6/dQu7bY/v2FbydCdW9M/TT9T925NZ1RpTyNXzjkLLKDoD9b0P+IV1FM9ctbP/T4RwIqhEforZBEnGGbS3stwGvksUE0C7WwyMbKQW53uz2GwJC9GRN49G047w==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:3GwlYFZToR1xjm3zXWbjk1F/oaXOGWa+MoNOQRsMNFuasudVG1BZZyImt4UZifYEg6jsiBORo/18iNBmaHOvboKJZrS/Oof4MHJpl2z49uykO3RGItKAc7s5bYGtA49dJZwkE1EWIqe+A6ktMsvi1xcigS2qrF+J6xxX4IAaX0h0blR37Zm4vTgdvNNn6On5UBkEzfnG/1hAXHmLNd6uRfQ7Hale8Pu2LBd0kSAwV5o=;20:CcqLNnfqlAC3to1u/Ja//bgBi7naJx1o9sjz+nqYHP45BH/y+IcNNC4tgbA1k03cpGlGJGJlS7bTDXvm8touvUplRqyDNDpll1L2mBbmsM7AY5qsiaYLDV1X6TT5SG9fyyJLNETxWWklor3hSJLt2ou2nqNtsCcgACUmYMQkDLjcil3g7ASfDYPtGh6V9hBolRLbwtTzzms3RSYulDS1MMvQ2gEHvSlT0oUkZI/MbQ9Q0rSU0gva/dPMphq6RC91XwyrnwkgBUc87OQtl317/RA8r9odyoBLIr/CDJiupCZ+HX2ZFqPxgjMUOY1mcGqWuAQ/4bnFVpf5Z6Hk8f3ZU1qyTxzjHyy8k3RhXpGEXb+5P8llujMDSeklgTZECQX6MZxW8uy4essiZTW9dssGGWsWIVS5SibqxRverZBG/49WyW2BKRKEn9dpfYidkTkLcaA/WO2xBcbNK+ldFGEUvaKf34eomrhqdGdZDD6+C1EC7AI+9Umgh7RPON3GZjot
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB43242B88B26EB78FCBD172A7C1FD0@BL0PR02MB4324.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(105169848403564)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:kc7nKiPpL0/aYDkTTI4A9W413j3eScQmrNRrmLwhHuTF9bMRD9kEb1j0PJqPl157Eeb4G8zIFCumFMYL5MuvxGWEAspp+eCoakbMkXJ30zkZb+Hu+WZJqphsRC9CJtnJDyr/3RoI5sPMJRwPMz1W0PjdR1DWj7IcWkUkloRTM8Dms2OZw4hlYXhEW11vt7IgHS8TKSD6BOAXHpvB+xC0EwOP4Q2wLR3fAHm1Iby0B05TVxWqy3XqYrr/taRZVG7jiVEJ8SUNq6onHzvulJtpQ/UKfHDQrBmFWGSuuMWLXPHL6nHkqlbQlyISUniGgljF+42UyaAAIQ73ukXQGer+Mr9M2OD+oPdAizeidYpjuRY=
X-Forefront-PRVS: 0826B2F01B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4324;23:ciHNWA77mU1Ccgd7tTpssa0mVwFHOTfEBfHtjZsYF?=
 =?us-ascii?Q?O+CITjRhAHYd1Uh+bFqXlSQVlDWFN74cQX3oa/xABqHrjJBBoH67BUqIvaA4?=
 =?us-ascii?Q?1p6w6QFY5FwLWENfEInNCXpPQueIXspishSuN2yr8s7mAdSnZNWy+E/85bNe?=
 =?us-ascii?Q?Jfg4pro2YK3fOTYteB1VPuvD56PdCNJX9ZGCBCLOQBLeoCHF1gF6DWdEasVL?=
 =?us-ascii?Q?PwAJmGaV4vZGBlS3B71DOaF6B1xM4iQR7G3N8gt3K8XVo9N3azLrb1Y3rFoy?=
 =?us-ascii?Q?oSfpCYXNllixD8F9Goe3eutLNC2YOsADrVCrTFpG7VpZhEypiv93TkW6O7rp?=
 =?us-ascii?Q?RZeU1732mTrbCdLNN7A0uylRHVqni1Jg5CRe1/cw3TTAJDiJa8elBx6hCAxC?=
 =?us-ascii?Q?DifdJAqHfPrdFHLS6X1KimrPomSRWUYY074UTV/iqRp+WxQtklK327UBn6Cs?=
 =?us-ascii?Q?JmQtrdUwRmgc6Bexc9Tej41x6bdSc0s7Y63rEc7gFDLxgWoXwhuoT5vu5XF7?=
 =?us-ascii?Q?mwVzLcD+xYVqpIJBx5auuWPcIkgbI7jvMaMFUSCNYkYF0Ft0BBPHVy9Co5I/?=
 =?us-ascii?Q?50D0mQt4MblBtZIYIaIwCX6gRw4kEzLrizg5T2E/RapnUOAs/iSOG7htMiGH?=
 =?us-ascii?Q?xsAH53FTweBdoKFfO4ZQOb3Vwnkfg2wEDXlxXAtHJPh8ycjdBgaHy4fP5Wba?=
 =?us-ascii?Q?Sk9gPESt8qBMds2TXGNPXRCZD3h8XnKp3Dy0nyseaceImvlkaGojoGM41cfR?=
 =?us-ascii?Q?EV5vmwFR3aOTD+e0vkL+UeSxwjzgoJsofHupp7fcM1QzL5fO1UR3Osomayak?=
 =?us-ascii?Q?VdnFn052ZIaXUIy7IOyixl3M+4nbxmk9cguY/fd1JHTZzQH1O5iM+BbOweTN?=
 =?us-ascii?Q?9mhf6QU930Z41ZHp5fo2WN0rxZ+h54Zo7cZIuZ6EqSrE4qrz3xVuTrDx/+4G?=
 =?us-ascii?Q?e6sMZgImKRZEPIYLZHOIlxuNksybx2acxvMMTplGIlMqj8Lu6x/5oPx/UD1z?=
 =?us-ascii?Q?sL2TnL3gpmO5nPyIRB8PwVNjdIOzaygbWyITnJaC6LBYZoV1gqXHfO6p/ASf?=
 =?us-ascii?Q?42EnS2KuLe4RtxrST4h0OGpxevP9zHDXSdaAloSpOO4UIsLoD+nWxD9PyJHq?=
 =?us-ascii?Q?R5eqLVDdZ3Gf4IFXEe/cmNN5A9M4h0kviM+azE85hvo4ocp0Jlf9oeu3+Rkg?=
 =?us-ascii?Q?Rrt02P9KokaI3hN1suPzJ4E3MXbTwG6FDqg4FovBCrkQcWrMFYCWvGHTZ4h7?=
 =?us-ascii?Q?kn2+10V6FTwAjPQ3hxALsHrptSfbOHBnnLB63IHRAZ7DJMAD6PdlKHzP/A4E?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: nIs0tVWEp0opq+hElF3Pdh6zZ0qt1vPBMg0FBfuRfvNzF1DEIae0HtH3kojBghMR5epUKJ/n/qjxPdQ1fZGoyU2puuVAAgtWs4/ujGjUDjJuqdAz+vxK3xBmHcldiluRdAAlo4TvmWZsSCnCJOxPiTwDYawNV5dZMmR2AQTyuCm44Xsr83hf3Z8iMW6dtwKQKSdXXNW3mnMYBqYBuGDitNb/z2i55vIHs/V6oMMZ/Bp8G1STOEO52QOkF8AsZPj1kv2qzMo/kVzU6EN/kDLdW+BogZnB1mhhu/VToDRUFKiB5/zmjB8CG2MS6OsjkO0+4/ogb7RLnumXNzrqb1J/VmkA/qF4bgekRTFbyy7iSBk=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:pgvaBhSOKgmZhwKMCTH9yAsOwG62k2q1LwTLl92l3LgBENNwaakJbvBTtppemS8I9uWnlYjnMAJEqHbhZiJXhjbg2RUiNLWgZfZOT5tF+wGjX993UJYM0naPuqghkZgyc9+EvPwYRZLdv3boC+KX7N36Xi/jsuZdx2ABwd57LhHrCzoFLYH+7lj37TEoMRuVaB0a2GKbp+BAmGlExXwADkj/6Rql/gN8REX9qOZ3xgA2Ta0ryXRTXzJax506EfOzIPkq0dhSGwXJN+f1iJgWGjfCwDDsrnHJHl6UiThkKbKQKlU3zGe8ipz29NCzBoeX30DEoZLq7aPC1f8S9r9sTzeuplvtHY7NiErso+s9YjqU+Nr7C/6V5eSLOjOn9/J6zkt76Z/KHpSN47+OHGGvxwSDB/w8lTO9xXGHegM0j5CuaADQwVLJ9B4NdVrcQ+BXnm9Dnu1VuV/cxJMCYH9Tfg==;5:d9DsmXc71qVNFig1HuKAbQJeQdgjsKpTR0up1lroxJKn77vtAKq/2NCbOxTTk9Z3Dx6F+uQdxPqQWffr1in9jkc6G+LKLIwT9tUWG/xQ5m9HuJdHsyigl/LDLFaIw4v4hYkCxhoWDpJAKl78k46+9E3xC8qNaPhOYF5hSXDh1u4=;7:c7fqUifbjloaieyu5R2kYp8XHdR/vw0us392BVURWtqTRkU92VQjtrAklXcc8u4csAZiiBStz8U63QUIwcboiAMTcStPuOnss1EmdP8YhSQaCd+mRDX+Rjlsc7kSf14FVmdfNop4oBHKjc73LvewcUnAYOzyl00WKyLkevjHqCijuOnNi5+lkCR6JrlngLIg0Z6RdAifRaivGo9svzkFmqv6jG8bo7ziyKWsOql2leCXhzf0t49eh4hULbgrWfUJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2018 05:30:27.1191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10f66ba-c296-4839-2b5d-08d6325f52e5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Error Injection for ZynqMP DDRC IP. For injecting
errors, the Row, Column, Bank, Bank Group and Rank bits positions are
determined via Address Map registers of Synopsys DDRC.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 420 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 413 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 603c4bd..1f86d5e 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -302,12 +302,18 @@ struct synps_ecc_status {
 
 /**
  * struct synps_edac_priv - DDR memory controller private instance data.
- * @baseaddr:	Base address of the DDR controller.
- * @message:	Buffer for framing the event specific info.
- * @stat:	ECC status information.
- * @p_data:	Platform data.
- * @ce_cnt:	Correctable Error count.
- * @ue_cnt:	Uncorrectable Error count.
+ * @baseaddr:		Base address of the DDR controller.
+ * @message:		Buffer for framing the event specific info.
+ * @stat:		ECC status information.
+ * @p_data:		Platform data.
+ * @ce_cnt:		Correctable Error count.
+ * @ue_cnt:		Uncorrectable Error count.
+ * @poison_addr:	Data poison address.
+ * @row_shift:		Bit shifts for row bit.
+ * @col_shift:		Bit shifts for column bit.
+ * @bank_shift:		Bit shifts for bank bit.
+ * @bankgrp_shift:	Bit shifts for bank group bit.
+ * @rank_shift:		Bit shifts for rank bit.
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -316,6 +322,14 @@ struct synps_edac_priv {
 	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
+#ifdef CONFIG_EDAC_DEBUG
+	ulong poison_addr;
+	u32 row_shift[18];
+	u32 col_shift[14];
+	u32 bank_shift[3];
+	u32 bankgrp_shift[2];
+	u32 rank_shift[1];
+#endif
 };
 
 /**
@@ -877,7 +891,11 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks		= DDR_ECC_INTR_SUPPORT,
+	.quirks         = (DDR_ECC_INTR_SUPPORT
+#ifdef CONFIG_EDAC_DEBUG
+			  | DDR_ECC_DATA_POISON_SUPPORT
+#endif
+			  ),
 };
 
 static const struct of_device_id synps_edac_match[] = {
@@ -896,6 +914,375 @@ static const struct of_device_id synps_edac_match[] = {
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
+#ifdef CONFIG_EDAC_DEBUG
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+/**
+ * ddr_poison_setup -	Update poison registers.
+ * @priv:		DDR memory controller private instance data.
+ *
+ * Update poison registers as per DDR mapping.
+ * Return: none.
+ */
+static void ddr_poison_setup(struct synps_edac_priv *priv)
+{
+	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	int index;
+	ulong hif_addr = 0;
+
+	hif_addr = priv->poison_addr >> 3;
+
+	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
+		if (priv->row_shift[index])
+			row |= (((hif_addr >> priv->row_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
+		if (priv->col_shift[index] || index < 3)
+			col |= (((hif_addr >> priv->col_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
+		if (priv->bank_shift[index])
+			bank |= (((hif_addr >> priv->bank_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
+		if (priv->bankgrp_shift[index])
+			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
+						& BIT(0)) << index);
+		else
+			break;
+	}
+
+	if (priv->rank_shift[0])
+		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
+
+	regval = (rank << ECC_POISON0_RANK_SHIFT) & ECC_POISON0_RANK_MASK;
+	regval |= (col << ECC_POISON0_COLUMN_SHIFT) & ECC_POISON0_COLUMN_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+
+	regval = (bankgrp << ECC_POISON1_BG_SHIFT) & ECC_POISON1_BG_MASK;
+	regval |= (bank << ECC_POISON1_BANKNR_SHIFT) & ECC_POISON1_BANKNR_MASK;
+	regval |= (row << ECC_POISON1_ROW_SHIFT) & ECC_POISON1_ROW_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
+}
+
+static ssize_t inject_data_error_show(struct device *dev,
+				      struct device_attribute *mattr,
+				      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
+			"Error injection Address: 0x%lx\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST),
+			readl(priv->baseaddr + ECC_POISON1_OFST),
+			priv->poison_addr);
+}
+
+static ssize_t inject_data_error_store(struct device *dev,
+				       struct device_attribute *mattr,
+				       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	if (kstrtoul(data, 0, &priv->poison_addr))
+		return -EINVAL;
+
+	ddr_poison_setup(priv);
+
+	return count;
+}
+
+static ssize_t inject_data_poison_show(struct device *dev,
+				       struct device_attribute *mattr,
+				       char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Data Poisoning: %s\n\r",
+			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
+			? ("Correctable Error") : ("UnCorrectable Error"));
+}
+
+static ssize_t inject_data_poison_store(struct device *dev,
+					struct device_attribute *mattr,
+					const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	writel(0, priv->baseaddr + DDRC_SWCTL);
+	if (strncmp(data, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDRC_SWCTL);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(inject_data_error);
+static DEVICE_ATTR_RW(inject_data_poison);
+
+static int edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
+	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
+}
+
+static void setup_row_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 addrmap_row_b2_10;
+	int index;
+
+	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
+	priv->row_shift[1] = ((addrmap[5] >> 8) &
+			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
+
+	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
+	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
+		for (index = 2; index < 11; index++)
+			priv->row_shift[index] = addrmap_row_b2_10 +
+				index + ROW_B0_BASE;
+
+	} else {
+		priv->row_shift[2] = (addrmap[9] &
+				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
+		priv->row_shift[3] = ((addrmap[9] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
+		priv->row_shift[4] = ((addrmap[9] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
+		priv->row_shift[5] = ((addrmap[9] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
+		priv->row_shift[6] = (addrmap[10] &
+				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
+		priv->row_shift[7] = ((addrmap[10] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
+		priv->row_shift[8] = ((addrmap[10] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
+		priv->row_shift[9] = ((addrmap[10] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
+		priv->row_shift[10] = (addrmap[11] &
+				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
+	}
+
+	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
+	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
+				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
+	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
+	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
+	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
+	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+}
+
+static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 width, memtype;
+	int index;
+
+	memtype = readl(priv->baseaddr + CTRL_OFST);
+	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+
+	priv->col_shift[0] = 0;
+	priv->col_shift[1] = 1;
+	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
+	priv->col_shift[3] = ((addrmap[2] >> 8) &
+			COL_MAX_VAL_MASK) + COL_B3_BASE;
+	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B4_BASE);
+	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B5_BASE);
+	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
+					COL_MAX_VAL_MASK) + COL_B6_BASE);
+	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
+					COL_MAX_VAL_MASK) + COL_B7_BASE);
+	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B8_BASE);
+	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B9_BASE);
+	if (width == DDRCTL_EWDTH_64) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[11] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		} else {
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[13] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		}
+	} else if (width == DDRCTL_EWDTH_32) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		}
+	} else {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[13] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+		}
+	}
+
+	if (width) {
+		for (index = 9; index > width; index--) {
+			priv->col_shift[index] = priv->col_shift[index - width];
+			priv->col_shift[index - width] = 0;
+		}
+	}
+
+}
+
+static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
+	priv->bank_shift[1] = ((addrmap[1] >> 8) &
+				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
+	priv->bank_shift[2] = (((addrmap[1] >> 16) &
+				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
+				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
+				 BANK_B2_BASE);
+
+}
+
+static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bankgrp_shift[0] = (addrmap[8] &
+				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
+	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
+				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
+				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
+
+}
+
+static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+}
+
+/**
+ * setup_address_map -	Set Address Map by querying ADDRMAP registers.
+ * @priv:		DDR memory controller private instance data.
+ *
+ * Set Address Map by querying ADDRMAP registers.
+ *
+ * Return: none.
+ */
+static void setup_address_map(struct synps_edac_priv *priv)
+{
+	u32 addrmap[12];
+	int index;
+
+	for (index = 0; index < 12; index++) {
+		u32 addrmap_offset;
+
+		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
+	}
+
+	setup_row_address_map(priv, addrmap);
+
+	setup_column_address_map(priv, addrmap);
+
+	setup_bank_address_map(priv, addrmap);
+
+	setup_bg_address_map(priv, addrmap);
+
+	setup_rank_address_map(priv, addrmap);
+}
+#endif /* CONFIG_EDAC_DEBUG */
+
 /**
  * mc_probe - Check controller and bind driver.
  * @pdev:	platform device.
@@ -963,6 +1350,20 @@ static int mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+#ifdef CONFIG_EDAC_DEBUG
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
+		if (edac_create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"Failed to create sysfs entries\n");
+			goto free_edac_mc;
+		}
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,zynqmp-ddrc-2.40a"))
+		setup_address_map(priv);
+#endif
+
 	/*
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
@@ -994,6 +1395,11 @@ static int mc_remove(struct platform_device *pdev)
 	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
 		disable_intr(priv);
 
+#ifdef CONFIG_EDAC_DEBUG
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
+		edac_remove_sysfs_attributes(mci);
+#endif
+
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 
-- 
2.1.1

