Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E354AC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880B62086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 15:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="NtpqAjAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880B62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIHTtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:49:33 -0400
Received: from mail-eopbgr720079.outbound.protection.outlook.com ([40.107.72.79]:26506
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbeIHTta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyLkM6QbB2yzCrofehve3bPwdyPV0eE/SOxTK9QWomY=;
 b=NtpqAjAzQpguD0dGFpIsZb9P2tvTxmrMBxTsTJopbkzUUKPGLEkz9pg4o4lMdHKpwJ561/WeNthrtZJ1Iz0hn5wA/8MhAtvybnommC44vMn88mFc25MZJVuMR1g1nzSnhdoN5TPCvf4KI3m01EcjpwcM9FBIqEiVXrxJ9kWA7g0=
Received: from SN4PR0201CA0058.namprd02.prod.outlook.com
 (2603:10b6:803:20::20) by BYAPR02MB4936.namprd02.prod.outlook.com
 (2603:10b6:a03:47::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Sat, 8 Sep
 2018 15:03:22 +0000
Received: from CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by SN4PR0201CA0058.outlook.office365.com
 (2603:10b6:803:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Sat, 8 Sep 2018 15:03:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT050.mail.protection.outlook.com (10.152.75.65) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Sat, 8 Sep 2018 15:03:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyeld-0002cj-0j; Sat, 08 Sep 2018 08:03:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyelX-0004pQ-TS; Sat, 08 Sep 2018 08:03:15 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w88F38Gx031600;
        Sat, 8 Sep 2018 08:03:08 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyelQ-0004oT-2c; Sat, 08 Sep 2018 08:03:08 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 43BD6604B8; Sat,  8 Sep 2018 20:33:07 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v4 2/8] usb: dwc3: update stream id in depcmd
Date:   Sat, 8 Sep 2018 20:33:00 +0530
Message-ID: <1536418986-16609-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536418986-16609-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(438002)(189003)(199004)(186003)(11346002)(54906003)(446003)(36386004)(103686004)(4326008)(42186006)(81156014)(39060400002)(16586007)(48376002)(2616005)(476003)(486006)(478600001)(6266002)(126002)(316002)(336012)(8936002)(81166006)(6666003)(26005)(63266004)(47776003)(426003)(5660300001)(110136005)(50226002)(90966002)(305945005)(52956003)(356003)(36756003)(106466001)(14444005)(51416003)(107886003)(15650500001)(106002)(8676002)(50466002)(2906002)(76176011)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4936;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT050;1:vLv6Y/OHvNT04NTdk95a16QSk3XhjsiaMrfapfctaxVpTSgLGkPyeFKTl0bbszd7Y3r6e3C66REM/dr5QTphA/nOyEhGE8OlsxPBV22inHgtlHw/78FGUNJV/6ZPrmci
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7942ac6-cb7b-474c-184b-08d6159c3808
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4936;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4936;3:3J65lL6Bsm56sT4CrFLVNGP53uX4xrjHmL29I7hBs92Ost56u03D6aZvfqAI9G1+0qFvnz9v4yYN1VJS7HLI/yX1G79VDVQigh6dkhwmowYyxl1JI80Z3wMWhb2z0o4WXIbLG1X6q/RGjuQXNl94zxtKzDR492hmEBdn8kXoFaA4rNpQ1lttBVQ6K6caPOrTyCo+fMfIvLcnHyNbI0b3jSSWsmJL+iuJZKqz6BmxxAqfhMJPr41lfHSeMFSH9T2n3vDbMG1P5WDc4fDHyb6QFhh0S3NintJdUdQ+tH0ZGex5Xl7hwv6FGKS6BU9DwCKyiJE+vNNKHf1CKzdfujIdyK2lvMLJ2vAQ3kZLChP7bcY=;25:vwSH9KWhTeTBwTOUqBjPEQqsTO7PMwN/uQu1kYE3LCow9FMoU8WeCgulbY3DlZC27ZnkQfEgcaf3oN+3C3vT8/+Ypfk1wvvwdpYzOFWXzdgOk5DVXCzgk3ujBsivE1p+yhlNT6EpFgtNCuB8fVmaIGNtE6MiRDt70B929sDyL/LUCI7WqPYbrjdmKrEZHLUoWKdYH9L6sgaFF3rJJ8qsWP8TImdbYmAmYzUU2aZSYuFSst9cNyxdBLsZa/JflbVHulUShprUqz0zoPc9Y7mR0il+i0dVhP17R4gPRywtAG9t+v/3SzcrgIOnG0Au0fOH5ifdgRwrOJ4gylxrO1Oe6A==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4936:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4936;31:s1vkqU3lFFqIQc+dWgc7Ng0opCJhH7v0Iorp2gwgvA2TMC3cjUxEieTF+9fidLcooERT1XkZcJnXzdNUXOaN/av2gg1aoMFr9Yk81METvFODDgCJOJsEB4rjIr3/Hzk6kXTUJKPavkSx4Bj6+s6wOso6NSUHzquNfAO4UqXjP9Een751VjNt/A189LuB4DAoRXfZbKRck1dhpJqNAqreLNID6CjN8U8a+W8qpq8aN6s=;20:UOt5Y9FGFk+l5GQNSBzrbUjuw4AH5X7W3FBo4JpR/eA/WdMW9oX7dVBIitgodjGw6w0PML4AUybJzUaI5T/4+OzuA8k5+1XckXCLRzIzHNqUUFXN/AsHh7coEwC+uRRPAI443clgkvEFcgKlp1lxqUu9cSQGS0/g464dqE3syvY/ZZWEBppEbzlRFGOJGS8jUX2fvbp2mRotVDHFp+xcikCo/yNVAeUs61IZoILcoNi9dboEyiSrNWolgMQn1NW1kLsW56IS7AhuCaam6yJ1J7BKqm+5QVf3ZpRrMu3Sy74YmVkPPHo/NV5xOgyy91F5Q6wGmlgfGwsSmQUqMTroiAqopTKhnzv9PfYQHALAAiCqJ3x/Qnj5rOglhXCR5UapM1y3C1A197HZqWH0xpAIlOsTYD46UJeQbVoc4ZigOx80hrzTOwdfkUaihyWC8UOuRcb1xhLgkALf0aN9SrzeMx3lqg8pah7bPctC6MpXeqvqoS15l9GHsSMu8l6eL2GT
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4936E3DA56D3D9E42F6FDA69A7070@BYAPR02MB4936.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR02MB4936;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4936;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4936;4:L57mwtj+KhBLweNgcOHYMHBgFw7rihNEHJgpfqfnrKdlvxzCauEKmkKXh2SLjjvjtT3kArYu61DYf52lP7SpaOS/11JkWylrTnvdVHoEtwAB3A1KkXhdR1XEiQrjD0ZOOU1wTiSKhfub3djmJ9zUIkrG+2QpSQrPWz78JDA+iWJXBCQ+pNGzPVv1CF0PeG5nhPsNO850GrUKyFaMwNv7QcQQGLEkpbGIXV+z1Zvsm6kNjMR1ve08+JmnI7wH2GPFqEHl+V/FChx8AXQpiphGqYLhkdlg2SrFjLW1D9X3wdP9oFe742mMYcsdNT+Tels3
X-Forefront-PRVS: 07891BF289
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4936;23:8T1NrJnw0eqt9Hsit4uTvOMorOXqszMEfTtieyUx3?=
 =?us-ascii?Q?fH7B+knwt39kob1weRXDGAUKVZeyZDoD0vTA5xJRxrAkv+eNcIShM1r+vQ+f?=
 =?us-ascii?Q?ZHUzgZFYD2iJ6KADx7/XMCWKwXqvf3Wu5Y1RlPQX3Sz4VYMKdtTBbqjNmooC?=
 =?us-ascii?Q?IS8GTYgQcaZAnEtyqsVWrld8nOrBgHDF/GKPcCbLFZDOv87qYH4Ae79FLviV?=
 =?us-ascii?Q?ywamHR/wHrqeGFRhhxdadLAkHiWyavnx5lE1F1/J6NOvayU2Y0wgo3wDx2nR?=
 =?us-ascii?Q?Mb95PudxaSHGdxATiwrcibMRGxzH2KS4D6GaqPlhTK1GLC5BTAcprcXP/hpK?=
 =?us-ascii?Q?Dcaii9pQczIngPV0DnLmOTjcxp77aNdbouo2Km49nvwJBR13L+43SkPiR55X?=
 =?us-ascii?Q?/Rw92YwzhI+5GBtFLEeTtx9m0IbTkbQiw2bdzxqGM+QXJ5kojntwfQh4LUok?=
 =?us-ascii?Q?zF8jnikKniEY1GdFKg3YEwCNIXIBMuHwNDmwwtJ2EZQRGWoC0EKzhrJxZAzB?=
 =?us-ascii?Q?6tGCXX+jWpEA4jELdiAhXw6oCyOnfzk0n9AdcLt5V1Au6qi3KrOuXiOm/I3T?=
 =?us-ascii?Q?JPqkwHmQmpV/7mWCS5G9NU7Jf2CuS0DlsXuhIm7uioq1PCYf7N0WFzgx+zvw?=
 =?us-ascii?Q?87ZasMs2amjQnG1M4EUPFECZcKlu3YX3U1C1/KohclwfOSEj9RrhmQCs7lWU?=
 =?us-ascii?Q?nbCK4JiOJlu6XwuRIPx4ZzTPeC3sWwrbfnrmKLMvLPtuHvoJd7SwkFJ6t1Mj?=
 =?us-ascii?Q?LFUVK3cSsH8dYOMfZQ1TRMm78QDWwU3YtpFXx6aAd0ue/HLtqyoSMyB1/Wb5?=
 =?us-ascii?Q?s6f44xzafDXZldE9uBpJH1arW93NiDbOlMfAicOfmWcT2STWLHABsFCbsXtk?=
 =?us-ascii?Q?Wp1MpmKx1YefP3MJ/erbroIDL7TMaw5OyaafHyEE2MnHiFG1SNGJj8aMdMio?=
 =?us-ascii?Q?DLoJFyW1e8fyKq76CvW3OnQonRXIjtKCYN+eXYiYHTGgixf8R0vRDLNKeWQn?=
 =?us-ascii?Q?6sCB1CAtRDs+ffA0+TXz/IgO6hrbrAA9OSjMAYRy1aLEfTGs1ivM6uxFFbMf?=
 =?us-ascii?Q?khKJyV3uc5LXfE0auphd8sarzfWgr3GAhVJhZQBmAe2FYQuKgdw1KgUzPpSU?=
 =?us-ascii?Q?cM6oMxL5u+3Y0aS//D3/dCVm8DNpGPf3I/w8j0ilEunmmux5GWNZhab2jUWR?=
 =?us-ascii?Q?oV880/YDURl7cRgR2KGCsPE3KQPuZxL6OTaUEzkg0z8F+S6mpzS6xLwyQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: kwsUQz46gd82UMHS0Ot92CA1I/jQ46rFr0l/34xVNq+kDHAqAda2EBFMfh3dxq8AUHzagYKvHx2/cVP7o5rpG4m1wCl2e0too33KXoghHYeUuwGddgF/BFhUccruYfXIVHax/Lb/0tGgDRYSENdh+RN879WTip8x2B+WNlZ0K41o4He3hk3pChpkGuw+Qiq07tSvw9i9rsjfqMuKJeNu8glmuhvMZj0x8wF0e/qjei4aRkmgmTAb8SpsDOwhnzU/LIlGeGm1SU46kgL18Rp8KV3OffjTj+UYVQYtodrBiNWdfsprB9PmDVqd53/fRj+SJ4gkZkSWmB1mbIZXdr7KAoEfpUcPZXdRjqjgsEdK13U=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4936;6:MP6KCtlyuPbERC4siSyi1YnqaqObfGgYFasYDJKtZNl4Z8qTe3MHWp3U8QsygTVO8xZ4LJgdPO7DfzWv/666Jl3bqpc3mzgl+TYQ+NZRoHjuOGgnRbRXx8p5gmWWm7lb+44W14Am8FhkOen+HJqOx7KcU5FAFIABZtU3fJxYdV4HSHD+EFGs2XLHlGUz+2R0Xr8Hfv2uJI6X73VIySksy/IjPtDxKXNGPaFhOVueFaOoO34/41uHF8xA2lW5qlVYs4am4TLVKiufy1JbA8ar1SZgwmyYFeiPouXOEW/xwAebNN7QsSejsyxkmxumJugmMe/AYdoEN9GEu3D9Zcl5o14HXRNNzpPjQVKfadFOmJbcrzDdxwoz8mRdSArDUAbpjfRKHRk3k/R5Rz6ATKmmGyqYOasuAmwE3A0/FxkllRNSdSE5HUL3/exkFBhGmSTzjjfo6yvk0OGX0LDm8jYg9g==;5:CVY+uFUcU+zeE0OPTvHoUNxT+V0ILqOm8BMML+Hhd9o3b6mACbQj2dBg5GnHg+055OarUJ2ES36RMcoFE+cbIqxsMsxvawTArMIBUl1qj6QupEqLOIL/DXB2oFyYg2Dj9HD60NH4Kj2R6Z+ZOv6nNpIr9jvk98Jf9zlEwdrca5s=;7:NUqOP5t2kzkwaIRE2zK5/aI4emZhuJ0rakVm2jz+BtWaTLN9N6k5mAsu7iL5qHOK2EFtuBuX2z/SXfFCO3lFAZL7IJVBSLurGMoXzYM3l5DyDLUncZXLFqihshdaFPWQVuFK/2oQz/Alanb3Pcc0NbJfvb0qi75tFyLztHoSmzZWrswG/3+DrTB7zR6Oe7nz5LiuquDjIus9ovV0XN2zGTALOvK5+9tTKCYkHqfEN8rHWWk3dpFwfxWEr8VKqoNI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2018 15:03:21.4889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7942ac6-cb7b-474c-184b-08d6159c3808
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4936
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

