Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7E0BCC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E43D208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vt86NZPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E43D208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936084AbeFNS22 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:28:28 -0400
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:23360
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755308AbeFNS2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjlQDjYGCQLv94lgYwW7ASkStGE9wm5eiuKy8hKUcuE=;
 b=vt86NZPo+doBa2GVEMUwziVXf6cjOa4zhsVS00Gc0nl4glJi/381H12xOXunE1kNmsjsNvqy7CEovgiJumiSkul27fdTqSy5WgFcOWnocUxRV2MeernKtEurXgmsK5jpQRCRWrgcwZM3c26n41NBgwgdjm7/04JEgUhXpg2+EBQ=
Received: from BN6PR02CA0095.namprd02.prod.outlook.com (2603:10b6:405:60::36)
 by MWHPR02MB2816.namprd02.prod.outlook.com (2603:10b6:300:108::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Thu, 14 Jun
 2018 18:28:12 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN6PR02CA0095.outlook.office365.com
 (2603:10b6:405:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyg-000215-Rt; Thu, 14 Jun 2018 11:28:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-OJ; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRuEa022835;
        Thu, 14 Jun 2018 11:27:56 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyS-0006F7-2j; Thu, 14 Jun 2018 11:27:56 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v8 09/10] dt-bindings: clock: Add bindings for ZynqMP clock driver
Date:   Thu, 14 Jun 2018 11:27:41 -0700
Message-ID: <1529000862-11510-10-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(2980300002)(438002)(189003)(199004)(107886003)(36756003)(9786002)(63266004)(50466002)(48376002)(106466001)(4326008)(72206003)(39060400002)(6666003)(478600001)(5660300001)(305945005)(446003)(186003)(426003)(126002)(11346002)(26005)(77096007)(476003)(76176011)(2616005)(7696005)(51416003)(47776003)(2906002)(59450400001)(16586007)(336012)(356003)(36386004)(44832011)(486006)(54906003)(316002)(8676002)(50226002)(81166006)(2201001)(110136005)(106002)(81156014)(7416002)(8936002)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2816;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT011;1:BT1rOXIxvx/YkPipOuHu7xbkQNTmSrBDTFwUEujolZQasiOMKU2MOW5Ap6T2stLHb78nvr6jqjwT0ioPPr7vwtaSWMRTxonQiNhgOQzJ8+OvdgBAA/LlVKp6L8LknUWV
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a33922c-5d32-4c50-1761-08d5d22495f6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2816;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2816;3:LldlAE9vKil2hV8R5PA0c/Rd+vP+8w00JK9FeevCaqLNhnYdmgK3hTqzSLpgv/VQcUOCxysIDmQVR6Ha9n1s7urtq5RBdbgIGM6N2it2ymkq5MQvwfaqXGj55tpIcCS53zZiNxx08G7jpLqnZxQcQ0aDuqDxNT0aJJ2R4VpxCBjJryFkF4F/yMSF6kIPdx/64zptQXLu2FParZLqbacBP1Xmmj4c3YefM6D0lbLmoQ663xxq2DA9dC1GIuFyYommYLLhx92ZeGjyuJoQmCFohynITTql4bt9Xab+FTawuqSdNgptftfKgjYSw55ljP5l3RUZmPTh3Yoeo36RoMpJY5cOlw8BYLqy2NMJjCk3vXc=;25:qK7gcAk3AvZJFADUNn+g/XbN58oExBCq5GPXP2Taxb6hlAowgQLIf/W+i+mbSVT/ND3PCRSopLi3ykRzUDabzXh9ptkPZTFXWm1xUleCUPZ2Ke8XPvJAqQu3eCJ9aBk6OPdjhzb+crr8P7Wo7+oFR8uHXYHpR/uFhaqmA1igb3OJC1hmxzBt7KXF+S0NAsooHIwf/vVvaE67QHcCbsBDdoXNFNvYUel43kYPF+kswUS1QgDuS4C0hAp/FnQmJ/EoWZurj224dmWat1ymF2JcUh6f4S/P6IQHEpk31tv2jEorpjACpd0TkNq8R+FsaTaXeGvGYjzX0nF5pu+8miCApA==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2816:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2816;31:w/7dYLXYFsgOFU9lF70XPgDnIPhgV4Bz1xesJJ3xHsKxHcOE0zGO3bk6odIGXLKSqGBfizRuplfE3TM+0xew35raz0I5izHKN2cmOzPWicJ8hbD1sloUxdx0DrgSkp1VGc/ha1YUcGeJOY5y2XL/+YCITATdz/WrfIa75TOUx3M8frt6PMp7pFbGLbEifNS/tGRHpeKdkjdu6WlhaNIMlosq/ORi5/WYYUOJJE5846w=;20:3llD3ddmClE0tI5eBgkbZEvaABmlRt661ZR6FDPgjZkh3fsQu3JkGyXn5CUBCCOGP274WQE2CfICGdNuvJqOlrZEus9YXDBGKAWQdW7Ny3s4OnKxtrEj8Rv4E/f6EUmWwUUby1adgEuC2NdPeBd9/NIWVB9OGbm5tJPHX34tSX7zqRBLIWxsgUhrFPCkiNO7s1fRiKw28a2vVZzALhWlivAEYvK/VCi5sfvfEP7BujxdBxj3Q8V6WvpwVe2MRQ9KVrtRoxOTQJ0NPhDM3p6gDXgqJpqTHbsM6nn4tQs2ys30czFZfCl+S50k1/jJ339Qlo2cfaYRd9kJkqiQn3a/r7rY/UXQup1Z5i9U3T+3oXynq9Fxb0TgaAgBAxhvV0OBq33XfVytc/Ze6mx4dZPlW1V+HIgr+D/ftttgJNmj9DtQRhxEA7GZaiJg58tJz2B1+vcBjUhTS12NAnh3Vrnj5Xa/BPSBrhrS3D8+dgyYW3Oliwc1Uvh0Qmn7NiGAh7Uk
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2816F716A3196A9A94C10819B87D0@MWHPR02MB2816.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB2816;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2816;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2816;4:YNWdEcLa85nBL6rA9+MDs1mXNECMZR1T3jAjJLEKJps2929y/58IcR89LPS1igWmnHN/JRM+HWUr3LyaOLCSZLrTTHSlaaGxmh7eRDcf7fRF5Q/Q+SFnlTSun6vO1MIR66y9FmIB7uBnEIN8nfWaNJ/oPgP7A+qWSYT7dBk+Ah6cj/+pSbvdXzjegyA85DipoFShhiPZ9cnyzCMiRscQvQ7+NRfAgoAG7B1p5uWfpRFkPN42MorTJdEO0NDedPiR1LxOuysHKpuqN9iEs8am4efD1IoqoQD5RJIU/gybPzGaliWDUVjaaKQS7PZml7Bo
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR02MB2816;23:QLKU+SWoQ3aJVuYGFFZ19cqijCsPLm8U57xfrTsgK?=
 =?us-ascii?Q?yH5Kj6RPuvzGR2CS6Qu+ZTgTawQTyei5voaRg/dxQm0Ro+h/1HVG+4FdXSJJ?=
 =?us-ascii?Q?L5f3Fq85iI8jVwKay+HHe5QgC4x0qm/jCowCnsk41Oqyxfn/gyNCzPQXr3wB?=
 =?us-ascii?Q?fVaWOoHhmSD24WH83xVhImF+tIqCBDSDd30kgVHSeGXK6F9cOp07ZXgF0OSt?=
 =?us-ascii?Q?ETLz0OZPxX5wfVs9s3nuVR1sha2DyQ0BJF9XHIJoyWAOfstmYsa9KxeEUtHb?=
 =?us-ascii?Q?x325B2XqAMAz1jL2/5RyTD5OsqL0OTTtdM8rEbX48DwnVrLDzuPiszjy3NNx?=
 =?us-ascii?Q?1D+5XFIMN1Bw7Mr03/goUtTa+KnnozbShN82a/mry+SJYqiW/15oGm2utaol?=
 =?us-ascii?Q?WDw36CKhFEtWXsj2G21wyDzwSJw+RbJAncM8SUGWrfc5xzzMfLDlWBHGwGIN?=
 =?us-ascii?Q?M1WLzyRtuMhW+o6oNv0b/cXM5GDeBI79mUZXnpG25RB8KxkC2XnfWux+bSrz?=
 =?us-ascii?Q?psWf0dCBvv2oDKjea8HZPnZhx3AQMbaYPGnkDK4VVltfmhLSKmXKRWMKRTHm?=
 =?us-ascii?Q?lvvQMgw9QkPChjr5GjsLvVCG7LxPWFYd5IuK6H1smZPZByBxMzpLeljlXb3e?=
 =?us-ascii?Q?UMwT3HDDq18m/MUVzpGGDD0KhjnYat8WckTmMI82G9rdyoFCwPbUyBiqasNI?=
 =?us-ascii?Q?Wji50/S7oyVApK9tSNhaPMYfViyIiUWs7WlUBvHgG1YQeAfaulDvAPLXm7qR?=
 =?us-ascii?Q?wOMQRctDyFq4ZJs6QwBNPbKSAvxASY2R53UOtSJtJbUxcZ+f31GCxvhepunq?=
 =?us-ascii?Q?pTLtFzZLT0d60najiCRP6ZKklmZrAK/wCl6UMP+xs3HsPLliugZgv58L1mvV?=
 =?us-ascii?Q?SGwsdqfA1QImb3NqVIJ6MdhxRneAomm0LFFz2wOoNKGInDURaabAh0LrVY2l?=
 =?us-ascii?Q?+rIdPAFFCq9Fbi0nyPC2n8qOjIvoVbh2diBypFaKTbi2hyKzreZkEPoEg+Gw?=
 =?us-ascii?Q?rNvofvL5sSX6qizI1wmL6aBi1Cfn5B2iqCG/xRXcAbYPwH1KWJ19WZaUu3Pw?=
 =?us-ascii?Q?giTLWYjFydTccIyGun6tb8Wr2uaO816DAa0HTZMKgLqZolgCbbFtMCiM3aB7?=
 =?us-ascii?Q?SqWsydRrLiw9pD8AHfdj4knVm1uEGKaTTfQEKPZ4rXCIWFrrmpvC4UErDs8o?=
 =?us-ascii?Q?ey/KBDmkKW/MHPQBdLpl/vS4BB3jYX6iXE6SO9QZyEv/BHUiDCSbWu8eNFVG?=
 =?us-ascii?Q?sQJ6yP/BhnbtTcqN+RG6s5xHhv8o5SIjMWkjnNSVtEGFNU08+lu7+F/vF4fJ?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: 5IpH1+oCLCYaHf9sIdTaSelB7sdfxAW+El6j+95QjFQbErov8aV/uzpBjcrdvzVOEEBcdGQg2QBXmJgPobhkDIVk8Xjzszr56sfZHbdqpK8ds5AYAYNAJ2bog1ruXKlSu/Chl4V+GM0xwXVwAmLd50EtO+Oh03d53F5ExJ9TfvGIaWZYO0Rw0eLDkXoNTbXV
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2816;6:b3xo/BaGqlbYz6DxcEHiRhXEeOkQESnNxw+U3Ero7Zd7TDyRLW2GygSWXWhqqqP1BytcXnPCctrHFfv1pF0lr2PeH3HCW+bPYODr0oY6fesnDxx67NfKxlpYkZvraN6CvFoukD1JBIQZBYe81Mkx1sgBnhpPsE5Rltetgl9K4vwr1OBjBZl45EP2dW4ztdp7Mjboo2mzzFb2Bsk8pigQ+sQEzZVAL5DPicCVUiybsOSElZqnnKqQ5tpFDIW76bBzGK7Fvbaz0LcKcj1bsfiELNBPsbHaJGDm9kg+b/q8TUsZV9cv0R/luDVXjWSIrhZVjeKu4j7H/n5xfGavr+vOKFGgXwp3SvWBeAQ454vlNzde/QIPjOx47oEb73a+T+Lx2cNAsDIUXspZfjHYevGkdHRx5VdhDK5wYVy6r6lbGkL4obaRZeNg5gO7SGOOgcV3XyNhB3+IpZQI6udbqrr4Vg==;5:bYJ5sHzK55EiQIpqzBirALTATquc36HZbyBqLapIUyIyj87U/UBCBK0mdRqbuVHJnEVflOlju6oIyNFnVhblq2RQ089K2aDWw5q3gq3K3Zsqx6B/kDGo54jUvecJY+zBFpVx5nzWwKtbS/zO1tUmEfhyl0rGVI5DdkmVFf9aiLA=;24:lZN/6pmmrmhYBTPC7LTq6cwcoZOs4afSLF15d+f2WNbArxSi02Q/DNGWrSTrXZV6AhU92gEX0EKZ8RbVcgps9jnWdZeUWffBUzbnK8hHlyI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2816;7:28brWztTRTzvq+DUm65QcjoeoXN/5EsfNZnmbQnLTXcpNfW6jUL2e/fxXKo2/Y3gZabr/63R33qEfWas9+hX9RiA3IqY60dtyUiMpOwBntRkpykg1NVsj/7INxCSZJTFg7k2B3vtoOItvDFr3T+hs1iZXAQ3GgYx48GTNZDePE2Y0E+wAxxQ0e9vjijLlDL094G9gOkWWa0CvXcc/bKuGI05txOsnnExx9JKzsHHsEo0sktNtBf3Yy5Elor7M8Z6
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:11.3444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a33922c-5d32-4c50-1761-08d5d22495f6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2816
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP clock driver
bindings.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++++++++++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 +++++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9..d215d15 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,53 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC controlled using
+Zynq MPSoC firmware interface
+--------------------------------------------------------------------------
+The clock controller is a h/w block of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+Required properties:
+ - #clock-cells:	Must be 1
+ - compatible:		Must contain:	"xlnx,zynqmp-clk"
+ - clocks:		List of clock specifiers which are external input
+			clocks to the given clock controller. Please refer
+			the next section to find the input clocks for a
+			given controller.
+ - clock-names:		List of clock names which are exteral input clocks
+			to the given clock controller. Please refer to the
+			clock bindings for more details.
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs. These required clock inputs are:
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source:
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks are registered based on clock information received
+from firmware. Output clocks indexes are mentioned in
+include/dt-bindings/clock/xlnx,zynqmp-clk.h.
+
 -------
 Example
 -------
@@ -25,5 +72,11 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_clk : clock-controller {
+			#clock-cells = <1>;
+			compatible = "xlnx,zynqmp-clk";
+			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
+		};
 	};
 };
diff --git a/include/dt-bindings/clock/xlnx,zynqmp-clk.h b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
new file mode 100644
index 0000000..4aebe6e
--- /dev/null
+++ b/include/dt-bindings/clock/xlnx,zynqmp-clk.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Zynq MPSoC Firmware layer
+ *
+ *  Copyright (C) 2014-2018 Xilinx, Inc.
+ *
+ */
+
+#ifndef _DT_BINDINGS_CLK_ZYNQMP_H
+#define _DT_BINDINGS_CLK_ZYNQMP_H
+
+#define IOPLL			0
+#define RPLL			1
+#define APLL			2
+#define DPLL			3
+#define VPLL			4
+#define IOPLL_TO_FPD		5
+#define RPLL_TO_FPD		6
+#define APLL_TO_LPD		7
+#define DPLL_TO_LPD		8
+#define VPLL_TO_LPD		9
+#define ACPU			10
+#define ACPU_HALF		11
+#define DBF_FPD			12
+#define DBF_LPD			13
+#define DBG_TRACE		14
+#define DBG_TSTMP		15
+#define DP_VIDEO_REF		16
+#define DP_AUDIO_REF		17
+#define DP_STC_REF		18
+#define GDMA_REF		19
+#define DPDMA_REF		20
+#define DDR_REF			21
+#define SATA_REF		22
+#define PCIE_REF		23
+#define GPU_REF			24
+#define GPU_PP0_REF		25
+#define GPU_PP1_REF		26
+#define TOPSW_MAIN		27
+#define TOPSW_LSBUS		28
+#define GTGREF0_REF		29
+#define LPD_SWITCH		30
+#define LPD_LSBUS		31
+#define USB0_BUS_REF		32
+#define USB1_BUS_REF		33
+#define USB3_DUAL_REF		34
+#define USB0			35
+#define USB1			36
+#define CPU_R5			37
+#define CPU_R5_CORE		38
+#define CSU_SPB			39
+#define CSU_PLL			40
+#define PCAP			41
+#define IOU_SWITCH		42
+#define GEM_TSU_REF		43
+#define GEM_TSU			44
+#define GEM0_REF		45
+#define GEM1_REF		46
+#define GEM2_REF		47
+#define GEM3_REF		48
+#define GEM0_TX			49
+#define GEM1_TX			50
+#define GEM2_TX			51
+#define GEM3_TX			52
+#define QSPI_REF		53
+#define SDIO0_REF		54
+#define SDIO1_REF		55
+#define UART0_REF		56
+#define UART1_REF		57
+#define SPI0_REF		58
+#define SPI1_REF		59
+#define NAND_REF		60
+#define I2C0_REF		61
+#define I2C1_REF		62
+#define CAN0_REF		63
+#define CAN1_REF		64
+#define CAN0			65
+#define CAN1			66
+#define DLL_REF			67
+#define ADMA_REF		68
+#define TIMESTAMP_REF		69
+#define AMS_REF			70
+#define PL0_REF			71
+#define PL1_REF			72
+#define PL2_REF			73
+#define PL3_REF			74
+#define WDT			75
+#define IOPLL_INT		76
+#define IOPLL_PRE_SRC		77
+#define IOPLL_HALF		78
+#define IOPLL_INT_MUX		79
+#define IOPLL_POST_SRC		80
+#define RPLL_INT		81
+#define RPLL_PRE_SRC		82
+#define RPLL_HALF		83
+#define RPLL_INT_MUX		84
+#define RPLL_POST_SRC		85
+#define APLL_INT		86
+#define APLL_PRE_SRC		87
+#define APLL_HALF		88
+#define APLL_INT_MUX		89
+#define APLL_POST_SRC		90
+#define DPLL_INT		91
+#define DPLL_PRE_SRC		92
+#define DPLL_HALF		93
+#define DPLL_INT_MUX		94
+#define DPLL_POST_SRC		95
+#define VPLL_INT		96
+#define VPLL_PRE_SRC		97
+#define VPLL_HALF		98
+#define VPLL_INT_MUX		99
+#define VPLL_POST_SRC		100
+#define CAN0_MIO		101
+#define CAN1_MIO		102
+
+#endif
-- 
2.7.4

