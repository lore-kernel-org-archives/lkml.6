Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA805C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D64327054
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eA8/nYqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D64327054
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965127AbeF1HlV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:41:21 -0400
Received: from mail-dm3nam03on0082.outbound.protection.outlook.com ([104.47.41.82]:36469
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933985AbeF1HkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFSggHwdG7nvh9KYZA41ycqlvu7/5RFSBhdpJ4ztS6U=;
 b=eA8/nYqZruDGAURoBh5i/qiFFUF7p7POG8j3MBXo6OkLMRCHHAQqaa8Rui1Sjc3u48ML2McPITs3vE6CfdI+EXz6F8zb0+6dUQNqyeCoOBu3WNHoYSErS5OW/w3fXOmgoXCyAvwIiZ82SjASHHT0ihnfJLywwiwdkMpXbXlHWPs=
Received: from BN6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:405:60::36)
 by SN1PR02MB2157.namprd02.prod.outlook.com (2a01:111:e400:7a48::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.23; Thu, 28 Jun
 2018 07:39:59 +0000
Received: from CY1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by BN6PR02CA0095.outlook.office365.com
 (2603:10b6:405:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Thu, 28 Jun 2018 07:39:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT020.mail.protection.outlook.com (10.152.75.191) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 07:39:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34936 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRX4-0004OH-0N; Thu, 28 Jun 2018 00:39:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYRWy-000195-Tb; Thu, 28 Jun 2018 00:39:52 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S7dlMd022788;
        Thu, 28 Jun 2018 00:39:47 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYRWt-000188-CG; Thu, 28 Jun 2018 00:39:47 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 892DEB2067D; Thu, 28 Jun 2018 13:09:46 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] net: emaclite: Use __func__ instead of hardcoded name
Date:   Thu, 28 Jun 2018 13:09:40 +0530
Message-ID: <1530171584-20673-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530171584-20673-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39850400004)(2980300002)(438002)(199004)(189003)(81166006)(336012)(36756003)(6666003)(478600001)(8676002)(5660300001)(47776003)(575784001)(36386004)(50226002)(2201001)(186003)(6266002)(14444005)(305945005)(51416003)(356003)(26005)(8936002)(2906002)(126002)(76176011)(50466002)(106002)(426003)(103686004)(42186006)(106466001)(81156014)(90966002)(11346002)(52956003)(486006)(316002)(476003)(16586007)(63266004)(4326008)(48376002)(2616005)(54906003)(446003)(110136005)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB2157;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT020;1:2+UgbRxpZK5wai/uSsgW/vW+KeSrFHf2DK/+hNuaYscE81OHaemAIs27E0hz8Rm74F1PfM/UhRnDlRAQPIIGocmbVLDsYszgTA01oQvZMGPyLgUU6dQfdtK/IMYKVE5m
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c23c0b00-39c8-4139-9925-08d5dcca59a4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652034)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:SN1PR02MB2157;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2157;3:XNAZpwl8Pv1nFoyEQTHZhhiTS2we7c7Mg3ZoFJQL9XjCAkVA4N6XjG1hyAPpHdUgJq8G0/FRmxbl9c6ftIhXdZDxpj1JqsLy+pveS+5Ac1DhoB4RR3nNxM1Sxe5lEEjqjw/nEhA/Z2G9HjPAjZLuz8JVIGlWE8MG9MtAxJOntipkBbpBFHxLd1eyCihI/ktiuehsoIFW0yd4nZUUiFnMIn0vQSJIuUbr/peYXLVDWCc5wSvQ/L8BtQvOD6eI+B/qdJBJvNjWQAIO0osyaCUQyHVjxWbMuWljkUkHtnxiuGaYJTFUD5aT0jGBJ6i6LMJiNk3Gj2cJn6Te4/o41LayjteO/Ml9LOEMGe58hVRwKpQ=;25:GYfMvWGnQgiImWKEJkiOMHuQDouI/NE/G8sqSA5W7Z4LhH42MKv3aMy/cxgs9SWWUa7RInGwT7vz/A4UMYacvZhbmRfkJj9b4JCBPAr2dUmS27Ip9Gnqpq4MiepRA5ZiABjfpfTX6mlvFWVyE9bWt36Y9+UEJKO5PFNnOHKJt2RcKkXsYSNMTK8YeahJkDgDe/rgSq6enKWQG/aMe+vMz/ZJ5mbFcOjH96r3ZHAJk6pm41CXfs/qpB39GV5RlhS7/Ufr2bWd1H7/WYDrTZWwbJOG/2Y6ZBEV79EFA9EAe+fJqHuYB+YdScFgF+XwWDedBGbIheQUCiiBWZUreojI+A==
X-MS-TrafficTypeDiagnostic: SN1PR02MB2157:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2157;31:dcvxgmWPC+0fCvxkwvMwS3aYhm011q6ekC2OwfVb5KA5ozlRsjJFoKT5CsTdyKtqypG7550Yn97Mt0zXxQIZIn6y69jlgZ5viRk7kfLeQmrro+DTDlQnWkJ/QGVrsUnFfxu2Z2G1b2P7VpX7wZiZFhFaq3LibBmNihuPqXM81zRrFWMASV8/hFIbhkQv2M7sjSeo6P3JettybaMgRuU3tnUQuyI8av2j3IAU8/zBVVE=;20:D9ehI8SV6NPlvJ5YPV1/CMP6ys1GRz8mQlaFS3cabUb5MfoTnxttDqD89/kOTqGS5ASnB/4yyTgV1seuLwAkMuYIQ2SpbI5UxhYdQaz+9FR0IKBPzcQYJy4w+dE8p7ZwD4N+jRzVvlzQZSrfTNssqAAzeUnd78CDxtEssnRNJ5cie0Q1D2lBZjxl8xbJnTGeRPM9e9vNnnYEwd0bmcWpaGkNyxK2ZvjuSOBLzu8ujLzbdaawbAR8A0y/t5DFO+E5lhtegQgTQk/jHGjTf6EwvRmNozg84Ms8BWqT+f/KyeOzgpDG3ulMaErgovu2H7FuE/q1+mM2QuOi/x1BS2GC68gbcf/uvk2x0QnALblDUb88WcfJ77kR/ykPu3ziRhW75QQ0NH9j8B9ZdGs+KQTim4ateUbsFYy0GSWhtHbT16l4fzAIaos37LAg6Ly3dkGl5bnpjJPaYcm/bdvcz9exKyovQTRu+7a9yn7W2bwiAfhV89YEch8B2ANyoZRFTrUG
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB215703BB6736CFF67289C1BEC74F0@SN1PR02MB2157.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB2157;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB2157;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2157;4:6VVUIvNNtXGu/FSrodiY3Y+zZGeZE6QILEazHCt3VCJK4Ia3vZLSY3Vpox2+T0244voGkpSOVZ4TOoXkw/AX/94ZcR4lwOd1IvOakIbdhKPTmCMZeD/ljemsVJNdgdqXd1fyPi9tx8/0A/TdoPzqxQ4EPmLwsFmu+JzmqKa2/9k5qXskpjNqB6FRSf6ZIqdohjCC52W/rqSQAMXBEeNuhhml2z6Z7LWiV9xHbWQ7ud20ucTM+xf06n93dZeQrnU4b4PSJNuk2ryBIjZgvFA5womY713G32tNMEppbVO/zH6Fo8y2MAu+f7MdMGpeK0fY
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB2157;23:yXAQhKFPW4FSAgkH06+C7FtgyTeegBeEe/gNYi2Ww?=
 =?us-ascii?Q?8JWgjeqMvVyrpKPirsS1ramC+7FohQvG0rroncgZ3gta/CwHHFYNaVMh8mD/?=
 =?us-ascii?Q?PaF5ZsH9Ll3aopk4MFPBnjqfrAxPaqRBtizjvvtXNTN/xW3PjGV1wSeHXU8o?=
 =?us-ascii?Q?TyGaH96UnTuzVLP036MCsm/usaOMgWo3MEfnTzV7MyNJEulRk8BIkmGjCe2j?=
 =?us-ascii?Q?+DFy5dS103BU5nUuNALm4+haVvuEj0afl3pQcN3CpWkukdH2tarMImpLgaFM?=
 =?us-ascii?Q?ue/yOyb3TZJANNZGSqJoGaNcufjZeEXCm2ekiDXuA45k3URRdf6AlKZQ2aJK?=
 =?us-ascii?Q?sk/un+az4tQxx4p3hmOmCE7BRSMLbZrgVDssQ1y7QaB5iYPQXJxINtkcycDK?=
 =?us-ascii?Q?gPjhFDFJtIrdEz//A1zPaj/p8ufoJiI0AQPYxoz12FEp+JlJLg7hhzA7lg9k?=
 =?us-ascii?Q?JNpo1tl9YSahS0TY7DZ+8FGwajPcSdU0Q8YcbQWi3nELqDLQvxJvIkUC87rL?=
 =?us-ascii?Q?bb0XZAAcnfhM2fD9jNS01pFGYNy9oPyQWe67DKcox1ZWj1esnZgD9UmcIIbv?=
 =?us-ascii?Q?7h7KJkcmzYwZNInoiZ1+bOOCVWArT6Wiui6G9nPkmzopOBCplm7iVwoMWqOr?=
 =?us-ascii?Q?tFp/G4bPEoBWPYmgASRvf5Ca6cvKEGjyhUOJaPYsM1SCE14vfQ7Pi6ojFMMi?=
 =?us-ascii?Q?xHgNZPhDi82pf/WVXYSRwarZGiJbQOaxTOEqxsOMNxFQjnnYvFMD1R9UbKis?=
 =?us-ascii?Q?sEXBcyIDI252onqM8DdkHdO1LCIRhvdabJk5BEBt2SOS9ydVvqLJbud8K7un?=
 =?us-ascii?Q?Dg9SRg7+e8jGOP+dNXnJdaAnxuCVH11nRQKHo1LMRtiTRFEFfHI6MXDpCpDo?=
 =?us-ascii?Q?3XAJMt3020fFFrzQjc7yRGMOGqvg3pUPadOHJJsEYBg4VFf0T0+8lb2SEH9a?=
 =?us-ascii?Q?oh6WAMBgQC3vhFNUjEAX6G1kcnWhO1fxEYOnG7THOU3QSqQ2lO/MFS5Zbpt/?=
 =?us-ascii?Q?cdIVCN9X50xM9ovh+QeIBpeSNdfHurEhljZ81s12EA6p3aIriGqyFpSoHUgI?=
 =?us-ascii?Q?oyCuibzGhjRpvl+mU4lwtpsNVqRSV814Sc0OdfNZBOfnA00QCkWwPeTzY8m/?=
 =?us-ascii?Q?Dn1JEg09hr/qLxFqwYq8b1yxTklEGDgKYeOOPyti0IA9wHrKlMVIod1dDraR?=
 =?us-ascii?Q?tYOs7H3xrS+jfbv8fatwzVfJtY++/aCf2nSjIBqEP0GpoCABW6rBlM8jQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: SC00/36J3nOp1XJ5y/1t81TXlWWhhL5dSdBKjqLMPrgrVJK6uvoBO32Y1TepX8GguT+mTTnWVpn/LxLKz2Qp5hi6IMZOT2w0IHiWoM7ZQSjjMjewXC6F6+9CeC2F0RJsmdy1xiz2pEMv9JY2RIZ7TH0R3TGjtkkPaoW+SaL5OPcqQ2NOxTGrpZkGp2qI23HHOVOEEz7/EnrkZ6ii02QEq1NN1lTbHxVi9C6VjosEs+HhyUzqrp2aZqQcdgbFfyw0pwBRCLxL2FtMSKjQDhoVx9KjtbecY2haUekVkVhkSWZcu64H/Mft0Qt2f5v6JagdGWl2OiS1YDSFk+2ICsbT5XPC9jJliINrQvJD/8j/64w=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2157;6:o4cCSnB3PatUGk68GvBxb3qAQwvX0H8iJ7Vy469OcyDOYZI5tIT0ajU0YvYHjrSdm/s2cokcbrKAEmQMHbr9mT8gU9kJBiCMxaUn7zdJxBvCpqA6K6J+wk4BDe05x/HvES8YbKuF4NOh95gkdBn40qUGHJAjmGwIFwJaL0A8JiUEzxujUp6mGK+TEXhEYRbLmz1dJaZGgbDGx/64U3JXUQMn5FEbQBJUv28Fu34S3rcDgSU/PEcvvA54xc+OuIDlfMO7YRdQi1LU+l7ABs0lingtTJTNf7wLEZX9Uhf+vo8jiB0/ttRJNzb2ne5Q+5hs9rzE6P5Hq8dwvWj0wYb02GqsomvXCQvHGk8CQgoSGPDwJI7GPBw3rAvDq1IkZO5IqzTA2L5Y4VoZ+81mef2ricPIQ76GjjxzVc6R3x7MjXF5ANvtiv+gN1yNGSCSkITMOVVAJkGtZzMBuLujyEviEQ==;5:N6DTeflV1vN1lCDIDN2q6c1sZSe3Ui6rcpGjyCphR1vH9VXuKM+cBAIUktp0VVqqU5f1EUAuAa5ZQvjzhOlaBM6a7Gsi9LsJY2o5uIc3donaB/dnxOSiGhlVcNfQTixRlgIeWPnvre7Dvg4YhiBcol14Lxb7Q0krYqN6We8Vrmg=;24:DrQBLCGH8q1M9HjtklabykJKqCJhrBtPUCDdAlOmopl0Km7WBnshQQnpLO9apQ2g10kXnr6sPjCTByeAw3xlBPvOOqulhnPmcp6a7Wr4UqY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB2157;7:HEqsb8nYnePf7dFQeARjXkSl22Z7XUAphiHIJvMs6bz/EXi9+NKrDI1VWUoobjCQAJM4ODmK5+d01+M4zWoeujEeIfSkeZ/SiXLPn+D6e0YFBePH3p4y5QQHUqhq4kkTmM/3x+F6es3sERYLjMiSDEyUWDTHknne8ufchwOgjgjLnf1R+EtTOxWXsuzd0yuxa8JQZq+dMl7KzqvmnUdRy8j/fWEGXFRZc5DSdC0oIslg5I/yl6yfSUbK+MOvuZlM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 07:39:58.4663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c23c0b00-39c8-4139-9925-08d5dcca59a4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB2157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch hardcoded function name with a reference to __func__ making
the code more maintainable. Address below checkpatch warning:

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_read',
this function's name, in a string
+               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_write',
this function's name, in a string
+               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes from v1:
	-None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 2a0c06e..0544134 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -757,7 +757,7 @@ static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	rc = xemaclite_readl(lp->base_addr + XEL_MDIORD_OFFSET);
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
+		"%s(phy_id=%i, reg=%x) == %x\n", __func__,
 		phy_id, reg, rc);
 
 	return rc;
@@ -780,7 +780,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 	u32 ctrl_reg;
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
+		"%s(phy_id=%i, reg=%x, val=%x)\n", __func__,
 		phy_id, reg, val);
 
 	if (xemaclite_mdio_wait(lp))
-- 
1.7.1

