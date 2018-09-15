Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58434ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6C1206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4B9vovhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6C1206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeIOTtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:49:43 -0400
Received: from mail-eopbgr720070.outbound.protection.outlook.com ([40.107.72.70]:23912
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbeIOTtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmuiNfXtLOQBbueEAC368aZ+Xvulp1Aj5ZVIQNowiME=;
 b=4B9vovhcPqO2ye01bTJmvpwHeg+yxB3WORPz8QcuFSD1R3MqfIfEaWa/t2StL0vjlxrl32QSPTnpRYv5Q0JOMIRqnrGaqff0QJIpLpjEozBph9HQ62XrmtLdoIZroTSOCPDxQCT6z+54CLaAs8B1cFjgS1FBdq0RUX/d9ZsUANY=
Received: from DM6PR02CA0005.namprd02.prod.outlook.com (2603:10b6:5:1c::18) by
 BN7PR02MB5107.namprd02.prod.outlook.com (2603:10b6:408:22::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Sat, 15 Sep 2018 14:30:31 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by DM6PR02CA0005.outlook.office365.com
 (2603:10b6:5:1c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Sat, 15 Sep 2018 14:30:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Sat, 15 Sep 2018 14:30:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bag-0003Tp-Gl; Sat, 15 Sep 2018 07:30:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bab-0004qu-CU; Sat, 15 Sep 2018 07:30:25 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8FEUK1F024944;
        Sat, 15 Sep 2018 07:30:20 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g1BaW-0004ou-EB; Sat, 15 Sep 2018 07:30:20 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 9FBCE604AD; Sat, 15 Sep 2018 20:00:19 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 2/8] usb: dwc3: update stream id in depcmd
Date:   Sat, 15 Sep 2018 19:59:55 +0530
Message-ID: <1537021801-23896-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39850400004)(2980300002)(438002)(199004)(189003)(426003)(336012)(6266002)(476003)(126002)(4326008)(186003)(11346002)(446003)(39060400002)(90966002)(2616005)(356003)(36756003)(305945005)(26005)(2906002)(8936002)(478600001)(5660300001)(107886003)(14444005)(103686004)(15650500001)(50226002)(6666003)(486006)(76176011)(316002)(8676002)(50466002)(110136005)(16586007)(42186006)(106002)(36386004)(106466001)(81166006)(47776003)(52956003)(63266004)(81156014)(54906003)(51416003)(48376002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5107;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT037;1:xsAFvtNKpD48MjXZyw6ythsmyUAi5yobcRk4BEXsyYDDH2PFWD9EFQIHGM68UqnqHq+0ubg8hX8HOh0qr7EapTcJGy9acCOhFmQrc6BodPYATWz7yZhTiW1AtjqTeVd8
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dffc09c-c83d-44de-e70a-08d61b17ca51
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;3:85rL8y0n7ASBlx0XBtDwIpSDi0EYKxw5C1yBcXZkWOWtf3sU+QXbokUJgYx3zsjmBOtbQiXkFL0MLVqQKgwNcu08ivg1281S3RYKDsv3hPaRy8h3lVYWtIBFpUYPbOPF9/MPSHqvMn+x7zWeOx7NoA7CvqwPGA2BHdElINmRpJhnwnphPX8ZhO1aGT4hGM0a1W0q13xvPO9Vzy3E1Xw84/yH10oB0hPSVrj5kPCL6VvQkgyJU2yAinWpXUP7/CsdVX6aRYN4oe64pPRYlDwreL12NMEtXurhfAzqryU/kRNuYNnKmewN7GpDohrn8D7ttnHwVrjfrfQosfTyVuCSowoHjeSfP0zyBlzhfOBQfbQ=;25:R0+OPvZnHd13OW+jkGRw+bfxfivssQl253AX+EaPbpg4eAbjvVH3ag+M5SjosVy8RlFtmF+/j3rMyh3RsL09aGtl/4Yl4H4Y/hsxZ4bQ/tdq/SSyfkN+1gFkYpWyaA+jFzTIr53aM5yXpSbc5l8mcHlQ+nBteG9gQWdkzeWy6qFrWvS5thb9DwEAOdAGfCK5KOTp2cNelXXwKx80wJkPbUwhYNP1oeJNXyG+k16b3gqmCrOeZvPSyUvj1VbiYvQ5mCM1YnoxDScyIGxLi03aW94EoKnw3pQ8noxJ2mw52wWp8unIrOIuBRP+0Ai2afc095kXrSWVuWPJy8ZlkAslIQ==
X-MS-TrafficTypeDiagnostic: BN7PR02MB5107:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;31:WobXCmycBcAvQbtFyNSZplBD/PVbQ8qBKfH9utChYTgB6nVi1t+7mEfdsIk2NMLXs3wDRVxju7vC0GvSt8FzwSsC/wH5u4hr8znOSZpM5+FwAww4xc4s4tWcte9w1PkCJxJ2velxmek4FybVRJgpAVVdNZEC6kqMjRc35icV0LGXpeiAmkM38iA1kBYCegUelFRs+5/3qfealGBE4rgodLZvv7Q1DXI6Uq7mkwnKSJ4=;20:y9Ot2W1OD0JgThedNGuoMuUDcH0c6xjaBSBEQx2Pej2fb6Gr/7o1j9ir/WuDvqyG0OpodVWJMIKaZstiZdNxlRL3N6BDokBZjvDmWRxKF41P2Zun2+EVEX7SMJyi76pFdkIKfWo6tlY1bzF9QBscYUy6IUxtUNeBPhbqKKmhHiHWiVI9uYkdfBU7RxcT2VN7B+yE9jbUmKPgIwdBVArVLikBF5djF7LAy4Ri/OFczCDSNw8CNH/KSP8Qz3Zk3b3KBkQyGt2Pspst6fL4AFY4D86vFiHYUQUiEpsAbkoBzXIkUjETTMe+zjLd0Ut3G32dZb2foL1LulIh6a4osClm8C26/ccDSIHYoUc/eA9KoDKBi0pQLWsP3EvMkTW0/stcREwSuPTYu5YgPMQVsAec3lsRIUt/KLGrPP/gAqdEe6X5YYgD5uVltwKsLq0tLEJkffiY4VF4Cc6mJ1hmj1QTNd86TWqLggKa+wIXJklyhfdWx4Jq3KcERSKbzjPmCsJW
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN7PR02MB51075821056BF0047BCED5B0A7180@BN7PR02MB5107.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699050);SRVR:BN7PR02MB5107;BCL:0;PCL:0;RULEID:;SRVR:BN7PR02MB5107;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;4:j0cS4QGho/XJdEOXtwimxa4XWiYuqxfdLSEC9AEKNWCGWC4M9zTmrHUK31LwjZQkZTiEJhb8qEAW9pEeZtCsTnCL7k0ZWHxbZY+LYq9j8oJEpcitPZLkf8l3SiFHMvqiaddzU4QMmTuR4llBGlXmyPdZJq7YTn8Dz3B9wHdyUqp+4+toLb188B3veYt5TpHzvbCGnLYqLsFcIcp8TDm1gsBcmOawiGkGnReU0Ow6uTmItHyys5A22GAEepsZMwQtBeQ0eWRtceEu0UQcfrtYI/GYPyiR9dpSI/t7t5t98FUSvT/6LJ9yace0Evhw7A/Q
X-Forefront-PRVS: 0796EBEDE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR02MB5107;23:ux/zYtUGDkKl1BEkKxEjbyW78x4WoWzfP/Z44w4ev?=
 =?us-ascii?Q?p4VsnwKWG3TpCOaPyCXWMtgTZRnA92BRmulBB9L6zWGwpLyQXywH7x+nuZdz?=
 =?us-ascii?Q?bsDnk7EkbWTjrW5GntnsDFpWzTWVbpj0H+mVEJ4mLQpGPgOFE7OfyhhmAjBF?=
 =?us-ascii?Q?c++PL16LqOnmJfhW66CoA+QeNaO/qyL2QFoSZfUUClgfAXKU927W+m9prSTb?=
 =?us-ascii?Q?erHnzYyqyYRSxqMjNMCB+x3uG6po4hrbbFnMp3HS56m4SfG9/5ThY20DweEv?=
 =?us-ascii?Q?Sp/WtQK/UecdcdQWsJ7lzi7W03zMzMfwfDOSxzAHYZOINW2wSj1Lt+CBW92t?=
 =?us-ascii?Q?oOVUQn5w2JbrVq+Pk6jOEkvhmrBkufp3jLbBtjudFGnfzGIJ/qSNnmPvnP0O?=
 =?us-ascii?Q?ekXZS1BMssSuUJo9zJ5AgfR4U9bPl2TDrNidnsp7KyQAHS2G9BYNCQlO6TI9?=
 =?us-ascii?Q?iIFqo3mwfle2LiB4oiy63CooXEXp2jzoWm3bGGf8Njr0XO/B9izA2/t6FooT?=
 =?us-ascii?Q?V3Taq2mxcXeUSrIXX3mPZUr23ydELW4OqCLpOyzuzd7Z4EsQ60f6QwcdnAfc?=
 =?us-ascii?Q?NYWke1jocqSjSRFLOwvnPYi5L4npTmxHoa6T+khIawibWkqxxe+0l6Ofttp2?=
 =?us-ascii?Q?7wPEPP1NhsLtN53QgDmrtgeUYeTPcLUZ30uxcEL6wCnRjv0hCS6fY76GAckT?=
 =?us-ascii?Q?Wnpx3iOK3KlqYMKsA61lsS2aOqZkr24bQd3TXY+mTpc2EJip61oNL1qZMBbZ?=
 =?us-ascii?Q?OoPfLfyM2JsjDkrbjSJ7UaTpY05Davnk0gy637NTW1IStpPepAjjALMaWQkj?=
 =?us-ascii?Q?evuZN8puOkdmHARGvHXxIelP4edA4FhpffbqnBPWzuu2Jd3m0EoQz17unWnD?=
 =?us-ascii?Q?yTnPXGeYSvk2U/fLsxQKY1vBxFvRQQTgggQAlfnAm6ymZbAFXNN6Y7/d3b2x?=
 =?us-ascii?Q?PfH/EWjG8TKRz6jmYmUOhp8nM6zq2d1guH6btVEmFdaNeTIc5ATI0j3l4tZP?=
 =?us-ascii?Q?Wpuf5fFgqwJcyDnN584Boplmksd5iESPaA82ANsjhEndXL/47d47ZnvjbCgv?=
 =?us-ascii?Q?4C6etmZDsrpvmD5LsyvrMA9xvOwFgNaJRZibYJ0cqjHfXKpTRByjyCSuEhtj?=
 =?us-ascii?Q?P+iC1Yjuvh314jRFokOZ6EDq8PWlXi8k8m/Bec8YxwUYBKjCDW5RhnMuIcIo?=
 =?us-ascii?Q?SqC2Dr63VqlfVhFAJWtJYTG1WFKNM1xrqcMbP/XCDdXkqc7cDi/5vnBoQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: M5yV5tGiiqACNqsHn6+0a63jKDKWUbl1FTMo7fCVexaC+GU1QE2jLMecwWRENN+EIMjmSp809UOH4DudrzJZsdWui3VEkhfCXTVN7tjuEL0XUIWVu3x4fkDBDyDxUVqzo+1EnsRVaorIUKLisy0y1k94aVSnHqkZH7Wt3ev2yBy3JsdsPjSuzyT3eq/rNgdpYHbWf5Rc1fg47T2aNREXhPBmmB4IQmM1QwoFLp5YRo80V5WE1Xvn2U3q5QBed8k2fXvs9NakAfTA7u5P176/cj0sxkR8lDfr3gEGXOuaay44f0lLPfkHzK48tZe1BTuGgPsA7GIKmpsdWypzCP8tRNASxGoRhJVqGmyH8s+Q7ck=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR02MB5107;6:kW7Ogm2KT5d6YWjQbWDT5sQ8nfUcLMK2v0kIk7LpUVQP3Wac2RxT1r47XPyH50vWtrziT1qzcdXyjHR5r44sfyfcez4OGDy66ITKGcLFHp00ThqLhMA0UhbXsOZHX9aG7o4mZkjJ++OkT+KHPVj9dW3mGCIzomzRuXdHA3H+1iX7Wz9LXvuCLzxvJ0cfnFnMo0Kk38buh6FienFEOazXLTKHar3xgtdeqBdEf9JACoz23y1Okvu3dagNj9ZNOtk+T5qmSwlRNIibKg2AMVY4wfJkAMtkV8vOQ2223FZ8ysLp3lY6c2Q+x68b0BJafRRKW0KFSlthYGf73sQJ5dOqg4oAhg1yvmV1WNmX6jfVRoFMOLRg/OaNR1SQVgyCpF5sKyhd+vZq7ZbOWaqpGBYI6P7Da/Jb0Y+gam73aHsTJ8cPJQ/fJCHafS17v1YqNGt+a2JsCaAAJ6rcP5ed5FA7/Q==;5:AE+JCz2sOqrQzE5qoOfXyymd8jtl53tYZQB/xzKfZSWAeA6s38Qn9AXtTgayptOR4zn1lEGDfR7aeKb+ICfY2J7zP0ZN4LP10xAhfcCI8F8n7f24cHS6Nt/YLFKnjcJZ3rjJ5uURDjDu0qUwS7jGE3ptlsJSqmp7GPcGF0BnShE=;7:jOQ4AK9F3P2gPjPLsHi81osli6ElgFUr96iuvsmpNsDyiCmD+Mr/vh8rzHB36qIqSqe5JRduAagGxan6AZJOUgWDvCVRz9EaQFSQtvf99Nje4z02BCjcWpOOEkPsitgehROz1U+KiZeTpM9m45NaBCBCz7il6hYVxerqkRr/yuH+BhHrFeZRo07xEZjKuJdzwXaidTEU/5JLCkxsW/LXX7eq1MFYY1/oMtKMZSHL3SgxBTQABFZFjdtc/c2634Ik
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 14:30:30.9254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dffc09c-c83d-44de-e70a-08d61b17ca51
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, stream id related information
needs to be updated into DEPCMD while issuing START TRANSFER.
This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8a1622b..43d63a8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1224,6 +1224,9 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		params.param1 = lower_32_bits(req->trb_dma);
 		cmd = DWC3_DEPCMD_STARTTRANSFER;
 
+		if (dep->stream_capable)
+			cmd |= DWC3_DEPCMD_PARAM(req->request.stream_id);
+
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
 			cmd |= DWC3_DEPCMD_PARAM(dep->frame_number);
 	} else {
-- 
2.1.1

