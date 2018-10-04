Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC38C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D962D20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="V1rU9qot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D962D20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeJDWaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:30:19 -0400
Received: from mail-bn3nam01on0089.outbound.protection.outlook.com ([104.47.33.89]:25621
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727740AbeJDWaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyMAkILLJW4ETM49OKktK74BjI0dbUhZNgvTXIYgT3M=;
 b=V1rU9qot5lh4OuzRrynNSn1czEXUNF6LcYBA47dASXKh7fetP2r9ISeIlS5CvDf1RSL21A2BgORJdufcdzWOv2DOH2d1U+U6unAnIUDBlgCSR8hO6t9gaJmBMwh0cps/cZZFWm8es3Axlwq8HpQOML7pT//PaNhmtU6thYhM6ic=
Received: from BL0PR02CA0099.namprd02.prod.outlook.com (2603:10b6:208:51::40)
 by DM6PR02MB4764.namprd02.prod.outlook.com (2603:10b6:5:18::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.20; Thu, 4 Oct
 2018 15:36:23 +0000
Received: from BL2NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BL0PR02CA0099.outlook.office365.com
 (2603:10b6:208:51::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.23 via Frontend
 Transport; Thu, 4 Oct 2018 15:36:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT058.mail.protection.outlook.com (10.152.76.176) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1207.19
 via Frontend Transport; Thu, 4 Oct 2018 15:36:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55976 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fp-0002Yd-Tj; Thu, 04 Oct 2018 08:36:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fk-0000Gz-Q0; Thu, 04 Oct 2018 08:36:16 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94Fa4tG031116;
        Thu, 4 Oct 2018 08:36:05 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fY-0000Dm-1z; Thu, 04 Oct 2018 08:36:04 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 396D71215BD; Thu,  4 Oct 2018 21:06:03 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 10/10] edac: synopsys: Add Error Injection support for ZynqMP DDRC
Date:   Thu, 4 Oct 2018 21:05:28 +0530
Message-ID: <1538667328-9465-11-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(16586007)(36386004)(106002)(6266002)(476003)(126002)(42186006)(356003)(316002)(6666003)(54906003)(76176011)(11346002)(4744004)(426003)(110136005)(81156014)(8676002)(5660300001)(478600001)(52956003)(72206003)(2906002)(2201001)(81166006)(50226002)(8936002)(51416003)(106466001)(63266004)(486006)(44832011)(103686004)(4326008)(26005)(47776003)(186003)(305945005)(48376002)(90966002)(50466002)(446003)(2616005)(336012)(7416002)(14444005)(36756003)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4764;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT058;1:DfFLzTRdUDwGQCl7Or6+MqJtCvSJoONJYrz/q7W4fldsiqjpW6dhAlfBtMlLxXiC6XT2z1Pk24OL63TSIRmE1VqJJhUtsPSQwsdI4takgfv1pTd70JsU2Uc71Wq6Hk6c
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0225e99-d624-426d-2374-08d62a0f238b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB4764;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;3:rUSN4caGFpZtX23U4Ky+LKrPEOsyLO6zmV5k/iWWVFaXocVjEfEUJHglBn2mbzSNS7RGisEIbbARdHl6LJcMmvsTYEbkHhq4AMD3e+ZFJ4Ug0GGJKKECNVbSRMe+XflDxtgPPRUdYNXAnyr/Z1V7Zd1RNY1wCq6SfM9OcLZVP+MQro1LFJLWj5OIq9hyn14X86yjsANJwhSoQMZDWr0EoW949ZRNstrZmCJ7NWWZd1vlHi96hU96h4ZyZEzgADSYjHt55ZTyIOnDzv6J4xkRdeNMR02wq6bFPiO380yhYkIWS52AnHQQee1risjKId5lfhHHSEBkQat1TXj2PnAe8uUZN4wAULZetgeXoITMwmg=;25:kJuqRWenVp0qD+8HjUl30cRJ9te3PPCjjYjZJDfHxJFeW7qhCCw7hgsjiD4kezSTR2xZ6be1bSLa7IFUn68qQ5dWqHMRRRtm5Qzl080yw8DUOWk7OvkQuxiANHpPLdhQyzX4EN6fSCRQjUq8OwcVBfTv8GhIGAk/J6Va0m3/9ipFiU/Gh0sPt9rxT2N5bm/e4ohhwnDPkzU6kJtkK010K8BqnoRVEABf8D3n1PSrIvFf/h7shGCvUd0iVxXsx9wwJ8jKXwFfkg7ZLLcJn5q7W2z8j5r9LKSmhX0Dcs1y5t4YE6uCBXhH9PGbp5QDP8vNbND+2GkZo1C1Cc+7AdsBGA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4764:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;31:qpn5SmWomKUGV58hsNeJ5/S7CdmkBv0M/nPYTAtQSPRhIklUl1lKCIVm/Ik8LKCtQ1zPpQzRwtSKToTRpT5jEUV5Dze91maEFQy5/xfqpIClIsAXoqQjEMkFC55f/doUfyM/7hf+pPn+/Z6mPq1Nu7x1Nl4kulnRGc0G46r0nDTJeUtjUwnx4y6C7dq4uxvaCdUsXRMfv5citC0EPP3a4gNAPb+Kf7TVNEZtlXId3gk=;20:58x/ebUvX1q4fmHYdLfO1eCNmUz4m8RtvQuq/0+iC5k0yt33wEqBtsCKEPCBKvhzvqQsw58+MJYSi8zFDRb6prE79f84GdPZb6taHrOWLOXJHJAvbqKuUyZTuzYZODfD5C6TA0g89/Cg2J5I3AJrCJnf25gTWqE9vf/Yp6cZBtOkIL5FB1WFrfsE0tKA8zDD4oFKDE+vAC0pSywq693EjV8juSZo/3N6JWhri4Z+aS3eIiPvmHRBk+R9RZvXaJ7DDSqj4WD9erbUwkZK3VT4cJQT7RBUpyoasNKQia/wnI2RmPoWS70GpIeG7IZzGdR1aWl32wpe71KfxoB0v1d8aAhVJ7Q6bDWlyl559Sa9mnNW90K0v3VXh3+3crnWN0I28GNM5b4NgO3WJK8sMvYsJWF5dmlQPpX9w+VaiiUuOVzOCiXbERFuDirWiw5+AYpcTrcs6ZvKophle9jboxbqVgbOdGoEyjOvN9M6K2v7x4BmQPSvkZtGS2pNkom/ytC6
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB476416926A493523652294AEC1EA0@DM6PR02MB4764.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(105169848403564)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:DM6PR02MB4764;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4764;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;4:Ybu/MDSSMkRbpJq7C15e1E3osOFlOGTrmMZESIeoGs7pwxRkeS1G8ECBwFrBPfu47CoUofuxHS8ykzRYMHxWX7zaodh3AsjGCATUJgsuScJjQUuJ1Qglb4oQvF37ml/lLQ0s2mLSbKxihiDQfLZ1vm/wy3rh1ZtU1bALxfj3exSnpiTaNfDE2EBNXBwxg/oAF6hqpz+gD+xHD869jw+wQnwq9kNpvesY0Tm/FfUKjeeUStImR324TFJph5jaO86bNjLhNnJR4cHhsu1qxexTxm11HhW6eOQqVYZIFQKOyLw4OvFUJn0K4W1SpiTAYejagujNx6XqsLyJAqHDmx0SzdJWR2qTmNtm14vMbosrVMo=
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4764;23:HWJuDOIihXAVTmZW3a4pk8IP9uk8j2D5zKjF7UqO0?=
 =?us-ascii?Q?tTEE9f51ZRC3ZubmZ0/f4IhgvvdnargpVbm9df+znr6c/UMIRU/dM/gbLItV?=
 =?us-ascii?Q?f7Zi8aLafU3ZdOzTIrDlOsy+9rlD+xgCJ+QOS178rKrCY0l6s5xOeuG9oaPo?=
 =?us-ascii?Q?qUL0q3tMBguS6QRz4oSdDj9NDWFUcpDs/vhcBAFe4JQe5VPZJYPEPgf9LiqP?=
 =?us-ascii?Q?5DtS3vgWX/4czj6D77XlETsMcu0wLm0wCthVKvNz/m5ewWy0P+GAzQbsaT/v?=
 =?us-ascii?Q?UagWxp5T6mW8vRV6eT478T/7AcYE3CaOQ9TYNPamWo0MYxDd7Nkw2bSLFBkb?=
 =?us-ascii?Q?tSv5Hm3dbaV+j8dIMgRsv4zAwtLqSHxPLXB0+D5fVkIPQblNBxobHTIHYX7/?=
 =?us-ascii?Q?N1GHr4GBI5agNAn/G3gy2COEZCcJskMfcOplZ9VNNXG9gbvFuypzIJEXKsrr?=
 =?us-ascii?Q?8C+6TIFqlEFk8bGsAQg465Jf1w4dzLUe55k57sRcBOdz9qf62lm4Q0LdSvv0?=
 =?us-ascii?Q?tPzNWi8OI3chpdlLvhDaBrsDepD6CJ3crpcm84nFzHqAWXaTUL/NK0/CXIhY?=
 =?us-ascii?Q?+IqTi0tpxn8kRSHz7Fk+tDUrncsky/h/rpW4ns7MRRrdE7arBFaGwqmnnUSS?=
 =?us-ascii?Q?6oWqfYb68JWSM9k3CNwKEqYoNL/5sNMreGkIHM4gRfIez37xBGh7pnY4m3MI?=
 =?us-ascii?Q?oZPBFNo/XVmm+yXaUcbEJKCjYZtpMBsILeFp6EI5fjZVaUmCHSIENYfN9g18?=
 =?us-ascii?Q?ta9ZssmDJ0jyg0u5qO8spuFopr5F1FHfDb+h6Hfi2KhaICw1GIs0p9oCP6ir?=
 =?us-ascii?Q?GL76SOMDHkUz4y2FKnRsO+jMWS+I1QK3g+OJ013YDglLQogkcaiKFjcSwU7e?=
 =?us-ascii?Q?PLT3v9vAViadWBSIxMOL5BEGCKDvG4d5pXfURnueoqxFwFFQrEY5EXxVqI0b?=
 =?us-ascii?Q?GeCkR8Ngoq5ZDG3u3I/zC/FeBtMQhy5Na4flz4GVueiOUUKqbpiY/+1JNS4F?=
 =?us-ascii?Q?6IluADo/Pwxi3F/kC5gCGZjyM+Q+aS9nhwja2RokOO0tTl7AKJ1CAsJU8WT9?=
 =?us-ascii?Q?GfHQHjqF0mAt0GgaGUUJ9vOKLAv/TMH420EEYFrQt2j/m0NowHRvIBGT4/51?=
 =?us-ascii?Q?uTiPUoL6EGW422qNUs9pujKhyzQTlL/3bnzatdxjP6uqeUev0gl9AfdQ8Im+?=
 =?us-ascii?Q?+hXE0aCzfQUdDn105hiBm6qW0RDaqrcZwsMdC6Kq4TtQ7rEBntYQ5W7EGq6n?=
 =?us-ascii?Q?C/ZEnarNatYOXetOmMqNag3BnGUPg1gNiop4QAUMdAepVmqk3bRgjiK6j27a?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: +awWwgCI8aey6un4mTV4Bc72LgcFEeDXFBE9/9/weNn0SjWNXuW163Bf4FtGgWY3cIlOsG0zsMeeVUf+Uef1vQYMNj+di7+YxOE/8a1FHDYNq2CES/zra9Yqs9kRIRp9zaYhePoeUuwEtuXvFVUqkBWkyN/b8Y4z+i/C4ED2Jo35KDk4CMrZQCpofXgShAh+UO410cO2SU8cy4L2TqsXnS/B47ULRWCFCJFZmu2xrixZVMpnjRvQKrZOZBNa3Nh0lzHDNTNwUGppfIfjh+8bU3dOSxSX1Ind741czxi46xiyYh+QaJWscpWQ3uyeAxdWLgiUjqh0n2Drvs07h8NUo9EobFZbtE9ev3K2VmbOJMg=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4764;6:7BKus/ZvW+hZ4TPFU2J7mfhDPjC5oa7UsZyNKi3CtsWuzc/fm2Np2wUO98ZJtlhB82T29zPPhqSSpoxWjXr/b06q7JNbgJupGX4BIZthgnXwuOac6S+PO6KAt9DTGqO0P59lV5SA4V0RNFrq5qEFM+/WP4OXFdk1tJm/Ia9DLbl1ICTtLYKit/8Tw7anauGAIeqs3qyiCrlg64I77qT7wU4MJVltODv8xcCEbBRCJWM5JOEySjPui94zbgIS+bZUz1aXv8Pw/+K2g05S4ivUFzJQvLlEfEISH/+KaajUxTfkDQly/aB/cs4EOBoPNjM3EgRRfiDh3a/BqylMCGC9K2nxkOsarIBZgtZeyjQtyKChBK4gg9qwvPNASgRfQTKQ5iOX49Mp3A9QIHz2dn3seW6Jgve+St6ePrL6vABA/o6fOaz4pKXj+LyRPNZrsS8uBau9jy0HDW4gxrP7BogZqw==;5:X0ZUrNQLzoW4rP1u4so2ta/05XJbGq3Pzkp/qrwSjcKN3tBt2zkStwMr2Uqi0vrLx8jioEzOrvYAeae5sMUV/Tdib4r4+LpdqxMG3ut0l8FrTfDFiGkDZl/7g9yNfmQD50T1df3rbezG6Xoze7KPJcWuAzHrmygY0+AgU2tNA9Y=;7:tlYgDBANnNr7/pvVJKVlMV+uGJdfMH7tj33Pi+MDhjVIaZbKvAi7DfrU4qKudrAElLZ+uOmCb5J6XEaEgP5zbPboV3o3ueOmiAsFiHQ6Ej121n5kH0idvTJEGQdOkVp4Dy3blaWclOw1uajgOHX/yKMv3XUOUsFYAWFdUH2wHashj/GdC2xAaEnMeuwDQFlfw35A2Vn8x4GRr37Lvj8NVaa/MM+eFnUXR9jGK3xNwgspDSvDtSVk3wjhdvOB+98T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:36:22.5107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0225e99-d624-426d-2374-08d62a0f238b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4764
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Error Injection for ZynqMP DDRC IP. For injecting
errors, the Row, Column, Bank, Bank Group and Rank bits positions are
determined via Address Map registers of Synopsys DDRC.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 421 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 414 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index adfa3bb..b64de4a 100644
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
@@ -882,7 +896,11 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_eccstate	= zynqmp_get_eccstate,
-	.quirks		= DDR_ECC_INTR_SUPPORT,
+	.quirks         = (DDR_ECC_INTR_SUPPORT
+#ifdef CONFIG_EDAC_DEBUG
+			  | DDR_ECC_DATA_POISON_SUPPORT
+#endif
+			  ),
 };
 
 static const struct of_device_id synps_edac_match[] = {
@@ -901,6 +919,375 @@ static const struct of_device_id synps_edac_match[] = {
 
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
  * synps_edac_mc_probe - Check controller and bind driver.
  * @pdev:	platform_device struct.
@@ -965,6 +1352,20 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
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
@@ -996,6 +1397,12 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 		edac_disable_irq(priv);
 
 	edac_mc_del_mc(&pdev->dev);
+
+#ifdef CONFIG_EDAC_DEBUG
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
+		edac_remove_sysfs_attributes(mci);
+#endif
+
 	edac_mc_free(mci);
 
 	return 0;
-- 
2.1.1

