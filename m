Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2053BECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 10:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AA9206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 10:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KEpLdMVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AA9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeGULVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 07:21:21 -0400
Received: from mail-bl2nam02on0046.outbound.protection.outlook.com ([104.47.38.46]:20992
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727422AbeGULVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 07:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWnRNi4IotDrpPxwcjgBF36pJITK1s+aFrYuuN5nKWg=;
 b=KEpLdMVOcKAKwUhEJ8JIL/NgXGhBo6yI02l7YPKx+CWfSEyiJAK1qFFJ+gLDP+UkpsOPuMKKj91mxqK+ko3pP6ZbL+dBGJ81XxO/P/eZVT7YFGqx8hGLvYz60eh620faUC3qZbVRW7uZabTVGzUP4NcysP5lLWanXeUgNbKMVoI=
Received: from MWHPR02CA0059.namprd02.prod.outlook.com (2603:10b6:301:60::48)
 by BY2PR02MB092.namprd02.prod.outlook.com (2a01:111:e400:2c1c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.952.20; Sat, 21
 Jul 2018 10:29:00 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by MWHPR02CA0059.outlook.office365.com
 (2603:10b6:301:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Sat, 21 Jul 2018 10:28:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Sat, 21 Jul 2018 10:28:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fgp8E-0007UK-Nx; Sat, 21 Jul 2018 03:28:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fgp89-0005g0-Kg; Sat, 21 Jul 2018 03:28:53 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6LASgjY026745;
        Sat, 21 Jul 2018 03:28:42 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fgp7y-0005eL-7i; Sat, 21 Jul 2018 03:28:42 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 6788C604CB; Sat, 21 Jul 2018 15:58:41 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <balbi@kernel.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH] usb: dwc3: core: Add quirk for enabling AutoRetry feature in the controller
Date:   Sat, 21 Jul 2018 15:58:40 +0530
Message-ID: <1532168920-3269-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(2616005)(106466001)(356003)(476003)(126002)(551934003)(486006)(186003)(26005)(1857600001)(336012)(51416003)(47776003)(90966002)(305945005)(107886003)(39060400002)(4326008)(6266002)(316002)(5660300001)(50226002)(110136005)(48376002)(54906003)(16586007)(42186006)(2906002)(103686004)(8936002)(478600001)(106002)(50466002)(52956003)(575784001)(63266004)(426003)(36756003)(8676002)(81156014)(81166006)(36386004)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB092;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT036;1:mNFYa9v3OBh275SZaOofOvjBAbVMfUXcCvY+NvOFL1rKfTOG7cKgu4DqbMHzg8myHeQL0az4HxPxqYe3e9Wm1P612p7IBAwGq1mveo1LgW1ZsUmHJjjIzJjJr/K4/Fc7
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 119c013f-5926-4396-b03e-08d5eef4c574
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR02MB092;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;3:3+7rt/D2hZMc3gOLm/q8Dk3Y711nyaO+uDzlDQ/qyytLXjn9SMuulpqSesEq3w3YveUh7bFMHmjlKQ5n5MW+7HrPugDuswS8cXIchxqKfTvzZnyTjJjU+n4QRogjhvgN/hZdtP/GRoY8h8x/4zrZ+Ou6zJdw2w4oYuy6n4pEuM+oWM67LVPWFAfQyMHeHVSl8Cg3UCtWb9GDTzVNtX4EnCn/Yyf/w/0NYrVdqMc7XHl8rRf/+U+ixexct65/7JJxSMsV+Ym+WwP5KGXlIA3pFl6+9dMx0KcbbXCubLt/bORwul4gzRaenCxg1TeJ/LqjlW7pPfOOve/M4Zz4OvgqcGemFW1FVZtkQ+LqERNdu/s=;25:tg/ALE5+yLgN9JdHexW/R4CoXy5edgAcz7pKsTsaBC0Wc2DI06yoTz1Q64u6lSg4qtJmzTlt0FUXIh338ezb5nW/7yAIB7r2DKECrYEU541zinYzzBf29wJPhq+VFhzw+7vNEniU2NMUU8lHiXFe24i3J/o+gxHbIhFylgdYn1oBUJKBvPYXhxCZvQjQOA2Qgrvi6rcWT2jGidGGMpeVF9ICL6SkNm6YuUCpxmRkbONSQaN1Mpyz+8k46q3LyI8a8F/aStPMmEEs/R3g9NE6RntauoLXg6i1NjYocuJeDPdp0XHcRkzO3qk6EfoUMoGVYSBouwqu0N+ye3J42GdGsLg/8YJvER58njYO6jfEwKo=
X-MS-TrafficTypeDiagnostic: BY2PR02MB092:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;31:+uOLEbuVxRfuDEzXcrO7hsvweh1t7TlUCjIhuWB0zT/EJXa4/ZxCozRILhKxiev0Z0ZE50z4yQJEFR+meORs21uZbeuJhM376SWgnMfk/9Zy7mOBx2oc3gbw6xhBCe1jIahYbbVDa9CdDElJ1DZt1HtVqNyH9FT9D8yOlcedXm5sSa9IeWX/PnlT89K1h8G2gNPIY7fTeOy2x/NCJGdepV3WFcr8KwkCR36P/8QB+is=;20:T3xI8w5XY2M7fS5YwvDTxYBIfS/upbQf/hlOU8EvAOxQD9Q9is3JHrI3t6amTM/jkmDsZTXvuJghE/D8cNsCN+2fB+nAKGjPDGAJE/0pDzFFQxkOM24nLPYYQ0bEtvmPT+8CLHSGmD+RrmC1rpILrC3s46irOyxAYZhPsrVVkk1SJ63OCzrw3EaGoiMy5NZmERrNqexDnxAgT+5wq98BGyOsN9guPcYIs0Ibl7aLdDj8ylA8pHMPcJ9KNrJYMa/lrYF2B2IVnhZ+qxC3XMkCXpdhuVmBtz1Nz7JIBKuSdBN6fKwHUK9VnXq97sQYuO9Jg6nztkh3ijq6Mw09G8nCJpRjx2+mDAjkzPYhnb3vHbWvBOETQYS+0stWi1h0xX7zg8dDmrzXaQRrPvsrsLLYO9Y9c/KP27qiN/U5qdPbB/WrF2DR8/uQ0/Fe86kKRAo7ugvXGWIgYHGxn356qA7zqnU2aWC7dMoJi+xRKX7XF55JuBmi29znAdqtxb2YnEV2
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB0920ACC146CAB6291C17F47A7500@BY2PR02MB092.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB092;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB092;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;4:QS2d47NOcPC6qXPBYOTgjdHrlvPR1DkV8EROawlZPJQltcPH02bGQl5mVUXbIE2VcP30kfKTdYETAhLwhH5WBdRd+vcqz7HgN0F0dJOlLPJbO1388YJK8xbyfCQgO9/6i/o0ZzV4+xb/2SbfSxznt18Rb+xgGYkqtcs48M1+cIesH8HQzEegot4dfU7Zc9WFt5VkoYGbU28fMUUKmMGeY2EWSbCPHwj2G0z02LSsokjWEcab1wtdlEPgWF8ws4OjlyvQCTTTlzJUHfHyedpF9t340oFHnjaCwtlXuinQnOeT7MLz8Q2nCKWbHJ3LLQH9
X-Forefront-PRVS: 074040B844
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR02MB092;23:zVDI/71V69VXemA0S4IUkIUzVxBPS3kIJHApOFiLp1?=
 =?us-ascii?Q?B199rIIMmYhbHM5tRZROZQsVRM/eGJxP2S3Dlqkx8bIJ2THj8K8lXmboHGWq?=
 =?us-ascii?Q?Scuf8es/720g6HPW1Gt8pOjcSFp32uLnTYAHHlyEzpYXWEOr+IACP4gswCeq?=
 =?us-ascii?Q?nYeBfBef6Pjuf9gOrgFpwzld7AT97ao18h4WuypSD8zbAnP2ShVFkmD9L1YW?=
 =?us-ascii?Q?ieYcfNeDb0SAyj03zhgdrrRYO9GmhY0MBONbDyQ33Dwxbxbvvjv7iqRWcA9K?=
 =?us-ascii?Q?12IdrCVBWXSwALsdp5f64aRFoFQT32UzlcBFpI0H5k5/81nu4q6k+197AazQ?=
 =?us-ascii?Q?VETSl7U/nqXzWZqMvn7nWaVUuU0PTPMCvY6+kcnM8Z4el1I/MmH/XZdlVcL5?=
 =?us-ascii?Q?YVYn9W2gIWFzpI3Iq3uftQ7GJVpEXrL9Bi0obZ8DX6ulJ+sjsj/dtuDiDteO?=
 =?us-ascii?Q?KfjcqVt1cK2Z3qdT5tdcNaiBi4tBQOwjLFloCIEnuWiIMk+8OO80lTuUl2kL?=
 =?us-ascii?Q?mhzftIvmW+VXw1+00ZQmeknOQBor5gJrq3ivkR9e0ytS24tBXboYI3sdu/jM?=
 =?us-ascii?Q?csI4U4npSRgDq/mMs7Clt9rnIOR6bG2o2P7Vz7Xosk2lvonacUU4To3vjWWD?=
 =?us-ascii?Q?nXz6QqqAu6C/D1EffK44bptqvHl31ItvxAg/J9EHytEgXW2tfpXYf2w+Ud3s?=
 =?us-ascii?Q?43HiO20Ye7C1XEX/XLEjvEdEp8j49AA+LjGXwXv9X1f+vmI6DlMMi2E6hyeP?=
 =?us-ascii?Q?+BxulGtUOti5nAhmw7J3eiVOxaWNj8usuvnPi+PKis0gkux5g8FyTI3uabgW?=
 =?us-ascii?Q?UL9wk23flP6PnMcEFVjRFUCCQ441p/DSIeHynPnIVotBj5aLiRXd/3iw/G1L?=
 =?us-ascii?Q?gsk3D2//4/2JH3LqY/s4CVR0BZl2plIT4FpQhiZT+ZTXoC7bGQ56sDotR9rV?=
 =?us-ascii?Q?DMGpmKWZ7RjaveS2TwiO4rwI0JMWRaECSBIaHdDsGrqyM+BQHGCOUqyBa9Lx?=
 =?us-ascii?Q?e2dZLh1lkp2iyubWuoolenBArdvEzp4dHqPE6x9xnb+0RhTcTB5KYIyXcAvv?=
 =?us-ascii?Q?77vzttlS9D+RXcw8u9uTWXxKXnAmOu68Qet1g/r7jyvMchUgw5N7PcSowV8H?=
 =?us-ascii?Q?JzHdevo3MMYLCFMXWXAR9dijknjkjMI3zeFQrI1yPhbYF7qkfvh+Yeca+AZH?=
 =?us-ascii?Q?WkIyZyzFxWbGc=3D?=
X-Microsoft-Antispam-Message-Info: ZEnlH+OjwBl9hl0srsJXOevLP78FwTlud/eIo66sLceTve0OJ67EIQ29mRkPmOsn35ZfGAWig5SQMzl05j/mMv+1uxo1s6qiuGdvozOB/Wbt1RIhT36NKsjne6GbA279HZfv+uMGroGnDdkLLAzDpwej18vb5+8CHl7Cf6lsMsQ6KIyDRJeCBLHIH7cWzPSS72sK60R9iD5u1W35t7saoYPvdXwOJYQVtVd8Ltzx1pk2i5D4dk+MtUPJVYS7guqs34wu3+ivHEye1kEqh+SgQOmydhQmseAPUV+RwhwJUwPj9wvFlR/2t1ZAvxjOFggY0wI1P7Th2ReI83fon9+nPeaNAFig4k6bKNOR2HK0ixA=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;6:emy0qWxURr6vXLGATBlMzAUUpKo7bfsqND1Tj40qUH0IbtJS6iujWFcEqODIPzVeeDGHCfY6+nHgphBLJiGy53CM0xh9OQUiy8Xqg9gRLte1v2WUZEnubJmSNYynMswLaF9SFyMPzxsQYuWbbuOOkqqkHkgQ4yBzx1Rm32blBKfe3pbX/04wXAEKuDKsxezABZk5CukpU78wFbdLkE1ZmtZvVBOWlIPMewqx5XKsAYyHihRVVw67bewdf2cHM2G+HtaDN9PaXaHGLDiGwi9E+SdABNKHo80wQr2mLKdvy1qg8N76vZVThhUQYgoQIDuJCfFihiwEZA/7YUJeoQAbpetmhs0ectAimMaRHxotbHRSEMwyPy1oQzmBf8qzj2nYKdmGWWU185PyjasfIv06xEHbU1oFMzEgIb42HY8PYdhX8LcqAAWFHgxQ8Vc4J/WnTjg82T9QFbfvTB2oJbGN+g==;5:jk+cBTU+4BR2VYH4aNREIJ1KMy6fEEZcYC+wJHv50bLAcJbuu3ZqigoGy+RGbTzpgq1uWRJQql7x7RCzAiYYEFBpydPMYBxlTLM5UzgvKnC+wMTYdVjwtH1ly+/31yDGVmpvhnulX3GJjUz976dxUS2BOXiSeczvDSAeFdOSKRw=;24:/K38FD/bN/eB4xGUUBM+kaqIVpfxUv1A69nsOu9uRZKXiiamvu5C9hERWu5EzOo498dDXmVP/Irue0JmwlrTQaUdrX7RIQMON9PmjpNMKTQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB092;7:meMuCqgQMSJ7wstX2dDtFGqN2V6OyQLHUnOC0vOgHT3FzsTa7WmO/RXmWXxBqeHrPpESPNprebMLBL+5Zw1ncKCILR0T32mYvZRFL2d/nxmIkmU9hgn3D0ikEcMDt8M4zwr73y+WLJojcgT5vEvYazjzpc9fgmVzGv963cxf4D0nq6uqZ54OWuxfAQWlqrPyIJQYmqfGInHBfcYXIihPQs8Fm+JxCw8hw6cWwvdpUVhv+sCBaOQ0X9l798IFhtK6
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2018 10:28:59.1389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 119c013f-5926-4396-b03e-08d5eef4c574
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default when core sees any transaction error(CRC or overflow)
it replies with terminating retry ACK (Retry=1 and Nump == 0).
Enabling this Auto Retry feature in controller, on seeing any
transaction errors makes the core to send an non-terminating ACK
transaction packet (that is, ACK TP with Retry=1 and Nump != 0).
Doing so will give controller a chance to recover from the error
condition.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Documentation/devicetree/bindings/usb/dwc3.txt |  5 +++++
 drivers/usb/dwc3/core.c                        | 16 ++++++++++++++++
 drivers/usb/dwc3/core.h                        |  6 ++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 7f13ebe..2ba2bc2 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -94,6 +94,11 @@ Optional properties:
 			this and tx-thr-num-pkt-prd to a valid, non-zero value
 			1-16 (DWC_usb31 programming guide section 1.2.3) to
 			enable periodic ESS TX threshold.
+ - snps,enable_auto_retry: Set to enable Auto retry Feature to make the
+			controller operating in Host mode on seeing transaction
+			errors(CRC errors or internal overrun scenerios) on IN
+			transfers to reply to the device with a non-terminating
+			retry ACK (i.e, an ACK TP with Retry=1 & Nump != 0)
 
  - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
 
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 1038075..1c1ab93 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -883,6 +883,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
+	if (dwc->autoretry_enable) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
+
+		/* Enable Auto retry Feature to make the controller operating in
+		 * Host mode on seeing transaction errors(CRC errors or internal
+		 * overrun scenerios) on IN transfers to reply to the device
+		 * with a non-terminating retry ACK (i.e, an ACK transcation
+		 * packet with Retry=1 & Nump != 0)
+		 */
+		reg |= DWC3_GUCTL_HSTINAUTORETRY;
+
+		dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
+	}
+
 	/*
 	 * Must config both number of packets and max burst settings to enable
 	 * RX and/or TX threshold.
@@ -1179,6 +1193,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 
 	dwc->dis_metastability_quirk = device_property_read_bool(dev,
 				"snps,dis_metastability_quirk");
+	dwc->autoretry_enable = device_property_read_bool(dev,
+				"snps,enable_auto_retry");
 
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 285ce0e..558dfda 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -227,6 +227,9 @@
 #define DWC3_GCTL_GBLHIBERNATIONEN	BIT(1)
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
+/* Global User Control Register */
+#define DWC3_GUCTL_HSTINAUTORETRY	BIT(14)
+
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
@@ -984,6 +987,8 @@ struct dwc3_scratchpad_array {
  * 	2	- No de-emphasis
  * 	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
+ * @autoretry_enable: set to enable AutoRetry feature in controller to
+ *		      give an non terminating retry ACK (Retry=1 & Nump != 0)
  * @imod_interval: set the interrupt moderation interval in 250ns
  *                 increments or 0 to disable.
  */
@@ -1153,6 +1158,7 @@ struct dwc3 {
 	unsigned		tx_de_emphasis:2;
 
 	unsigned		dis_metastability_quirk:1;
+	unsigned		autoretry_enable:1;
 
 	u16			imod_interval;
 };
-- 
2.1.1

