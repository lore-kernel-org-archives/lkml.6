Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A02FECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D4B2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 13:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2OZlf79J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D4B2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbeIRTTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 15:19:03 -0400
Received: from mail-bl2nam02on0078.outbound.protection.outlook.com ([104.47.38.78]:12672
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbeIRTTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 15:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA4PyVv76X9qUVB0fn0yhEZDKgoG2DirthXCcfPM2Vk=;
 b=2OZlf79Jlf5NXMAJlbJrO59thcyqnmxkwMLPhABobaRisn5XyWeekhumCHofsUjWBz4u42ZYnEOOPdh13zVO/AOzXnoyznUGCFoT+JPB3bP3fhLj+BpClzmpekRGqH6CxgKh5yEnSxlOEcUMgcDUwFEMW/qeH3ETQY7wvwDZbUk=
Received: from BYAPR02CA0004.namprd02.prod.outlook.com (2603:10b6:a02:ee::17)
 by SN6PR02MB4477.namprd02.prod.outlook.com (2603:10b6:805:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.15; Tue, 18 Sep
 2018 13:46:18 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BYAPR02CA0004.outlook.office365.com
 (2603:10b6:a02:ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Tue, 18 Sep 2018 13:46:17 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Tue, 18 Sep 2018 13:46:17 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKW-0007Zr-RD; Tue, 18 Sep 2018 06:46:16 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g2GKR-00025e-NJ; Tue, 18 Sep 2018 06:46:11 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8IDk5Zm006095;
        Tue, 18 Sep 2018 06:46:05 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g2GKK-00024I-UX; Tue, 18 Sep 2018 06:46:05 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1A9F912142C; Tue, 18 Sep 2018 19:16:04 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <adrian.hunter@intel.com>, <manish.narani@xilinx.com>,
        <leoyang.li@nxp.com>, <sudeep.holla@arm.com>, <olof@lixom.net>,
        <amit.kucheria@linaro.org>, <rajanv@xilinx.com>,
        <jollys@xilinx.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 1/4] firmware: xilinx: Add SD Node and DLL Reset Data APIs
Date:   Tue, 18 Sep 2018 19:15:36 +0530
Message-ID: <1537278339-9257-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
References: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(438002)(199004)(189003)(217873002)(63266004)(81156014)(48376002)(14444005)(6266002)(36386004)(26005)(7416002)(4326008)(186003)(50226002)(2201001)(50466002)(336012)(446003)(8936002)(126002)(486006)(81166006)(2616005)(426003)(44832011)(11346002)(478600001)(8676002)(106466001)(42186006)(90966002)(110136005)(36756003)(52956003)(476003)(2906002)(6636002)(47776003)(6666003)(16586007)(76176011)(72206003)(103686004)(5660300001)(356003)(51416003)(106002)(316002)(305945005)(54906003)(921003)(107986001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4477;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT014;1:huCDE6RySQ+UjiVUREl/x8+pBtGOJa1Sp1lK3gtf2seHCRXUAOvgBmZDfxR9Ql2tpa8vzLtpoEx4qONRm+VsR8m/cCXrKGO/cu43a/adCzz4r9yBoXSws5BCpqVAoXIU
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8b7073f-ad5c-4644-907b-08d61d6d1bf4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4477;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;3:3Ti1HFahbzGFAMoOA5Q6PkTpubUnT5rxu2YiHVB2+rBYIyPECOcGBtm+QhYT7YCTlJ8BLxzuDdo+c0/Qmo6hK32/DTlvOHS50VUPW1m16Qk7ttR5pXvAYyaTLGuQM2yQRuZTlZ9CXrMrN9Wos/nC7aYJcWr8zBP7SZB09au0xxyxywqmxF2kIqx6RvjgwsV0IM+n/vA+rmXxss7v5VWww3i3QYqBzZfX95aKIR7CVRxVBWGqTUOMVl6RnC7sRCsyltfl4vc3BcjYGMr87psAe5H5BdEjiKm2ToaTBhgJh4+aeWrH3Ohdo49BZrDnCO/gfdAyyL/X4WGatRHWecbkAEg1q6I0dbvC6lo5Skxkx7o=;25:7ChrbvAYTVfEM+PMzR761+OtIVxtLM+sfsI8ot4kl/Oqh3T3i0CiZP5/ARkBYKgHNdNKdv9SnpdXNqDgX0YDysmsibxQKfKHvAkq5XtaGDA6o7/6k6GWuI6bIFaZysd/sIAGsUWUtIrwPZQYau9m5mI3SfdeBwSJ5Hirby/yMUwP9g41eEx9+lleetiSQe72/yS6QC2n97RiGzYvaNtShtdwgLKcCtzNmBnV0YNiOYUNk0qJ+DHMTOGVO60CpBU5H5K2vpTe53tto+ngnzsTlIS9+Pm292Jhw/BlvSq/M/HisVc9MiMJ3xiMc637xyFqFbMjOt+N27LAIp35TSngbA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4477:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;31:m5g2xafkgnhLWhHOUX0fDorcQ+6BOR+pQ2K1i5/Vofdta0I/xW44aMtmXBPC1FUEWHRy7SNX1KARDj6V6G6Qi0/uGezb01zhuK1V9R/kcpl14fcsm3vvUKgKq1N1SoNpdGExghUr/UARL9eN9xtfvekNK227v7q2ok8v6cTe3yQFAyMfLOKB7Il4iTXzfTa9qLRnkUE/NgmIIHU64NE4tTV2F8yifkmEB8QRSOOf+Jw=;20:L/IP0MuQj27BFHN5zWLv37Do/SkLAkRyX21fO0n6PfTAw+x/sKhCYaOhQdquvWl+INlIY1ICWTwW9kL3QwCBuhmxaaXsnU1w9OUfCWxZ78ZtGJhuXn4BbdXqUtsd9p6hXvk3F0mcykMs482Le+GO+cWkH4WJvevRBLKWLmYIQn/kevi1jFQSbDvDklWz3BFFuH3W6RVzFqLMIa77lKZlEOfQTN05en+xUIjs5TsHl7mVfRxmh45oUHUbiQ/+WAz8vUxGJbjpnnom8xLo4SIImKb6oU/oMoYx0GZQ7sbf2a+Rxrr0r8LFLD+ro1mLV0PBAz4/5XJ5v8pTR761ZdjasawkQ9WYb+fXI1tf27/qinnfHSxJCLYx/QJc2TnMTWEPor85lUfXw9tI5uD5eN09fEmLm8ARAIdfGQILoBeaAeK2dg+J186NGyM/n2ogWpCrnP/6BVFFwGQvjt9jIwxzc+g4DoteBzlet1lj79S9qUIceF6WAyA8oEbl0FmGin7V
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4477615333E44C45510E1FB1C11D0@SN6PR02MB4477.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699050);SRVR:SN6PR02MB4477;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4477;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;4:skqHXbJpt9xjbNljtqaNp5PE2gBPHsQf3BHHbfPghVclHJ/PeL182IxQWrO2FYhBByr34pCS3mxxnMxaqW8QRDHjhTM/Q1vp6IlqvKrHZGYnZbGyVwaLwH8TTInTGl2ZCK5BiHEWodXyZcXgTDaJ5wH76Fdm7d/lf6mE2O+OtGD2METJP1TjnLUkT0sxVaT02YEeHA4s/i6jHTssEN5zh9WXoHM9hnFDDvacuA+gXpq5tJxRxoreyI7z8ZJPOBxKNobZ+jTQxqnppQV4juF9w3991kEMhJB7acX/I7kyl5F+RREMK12gyS/l9i1BzW6A
X-Forefront-PRVS: 0799B1B2D7
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4477;23:gRlFVlUja7NEmbaPr6DaQJq3G9JFvi+VK52Y8g4Kf?=
 =?us-ascii?Q?nVo12d2shrNavlNjwx3Mrh79YeqfRcQ/y2YJura52FNRrQw+78v7rus8o4eG?=
 =?us-ascii?Q?9b8X0ZHpvyr/8ALSoXHeBAx0Tu3eVI6yhSGEVQuNJadbFhA4mL92TOi92yRf?=
 =?us-ascii?Q?vioLsa7zlL39aEI0vi446WhibnzJbBPF051Z8MdPfdHv2CH/KFkE00fGP3zz?=
 =?us-ascii?Q?dYQKHh2MQWSaYI4vYPYdhYQp6uotmjrCUsb264tnGWaSMXQwRtTYy6AIq7Si?=
 =?us-ascii?Q?CBaYnAINVpf9kIZn+staIMYP1icsqI9B7174NKnDx8/t8UZp5LRYnMGj4QJu?=
 =?us-ascii?Q?krK5xxpMFoVw8kzXjWHp0prYsBBeU+noyAd9zyoZM6u50nDbrGrnhNjQS2fR?=
 =?us-ascii?Q?8jZZoES5ziEojXk8fvUfKvu5rjhaZfx6qCNndethQneuZTc3MXRm1Uoufh77?=
 =?us-ascii?Q?dccR6Kn+829QpX3yQUvYtdEyfAcMR7QSRe4KWEvSQ53lQpQcTJjyB3OgXKiV?=
 =?us-ascii?Q?98X/JYkS01LohAvH5EZpTziOgtGD4SucdGEL3g4vdvwNJ5/0y2BhUBq+8Igu?=
 =?us-ascii?Q?agIpdVlxkrnh6ccYw8NnWXGLc4yOttmQChLTMQ7+pQ1ttxAaJPMtPcoo5WY7?=
 =?us-ascii?Q?WuUOMj3DoDJ5/ygvIA2bbfu6ulVwA6nq3NbINzI52vY0tb7xYZP5+UpJKk1F?=
 =?us-ascii?Q?kneMdbDfIEyoiJJJSckeAHmQNmXBOJKX7AOnB+zGVKYV59//f9QJdi4rECsP?=
 =?us-ascii?Q?h4DkE88YobA17FwRpeSmBHuEjgWW/uZMAHac0h27SdpDz3srYtsxowBqxWok?=
 =?us-ascii?Q?YKaZz988QLRsdBat7SVcZL8613qBuGuLEkvmXxFuFYqyW3kVYI2dAJjawDRY?=
 =?us-ascii?Q?sjn+HmDB+d8KnyD5b3HuDW/Tzu33EorHdxiIZJV2/3whaSIjgdTKRakuPYpx?=
 =?us-ascii?Q?nCxY0Dq2KIag4KqofE68Ik9mYnoFYG/F1VcNRBSCMB2Ptm1I1nGpeJTBR9dE?=
 =?us-ascii?Q?//+bnVEtdW2WW8YVv+3LNilLaFs3wpo3E+KtwA5996vWXrv1VmrVs/rfW8Xa?=
 =?us-ascii?Q?2ZGwz5w+pD2XRYalhC+63lwChwdYHZtYrGSw4qwLUux8BsnXhPAdQWlLteVW?=
 =?us-ascii?Q?zzKeuaJKZnFDFWbVJecYh/tWvYPZxXGGbirYXK3UPHy44q1vNUGWJuz83/1h?=
 =?us-ascii?Q?dEkn/TaiaOr7/yLC9y8F3RtCBByPmumNNp1qssK8twMoDAngPewDaFQWEU4m?=
 =?us-ascii?Q?r2Iclrg7cWzkBKPMYwn+ZNV6lVB8GrQtXQmNqioughNg4xAv1DCKvqmxFPZ4?=
 =?us-ascii?Q?oI/kmxK4rFelQmKB3/xcF8wT8OMEzDNKIKAo0AnySYv?=
X-Microsoft-Antispam-Message-Info: PyTvDZSbU+q6CjEswAI1kHK6UtX56otIcmVMwKGDePUG33MV3T8oygbxZ3xcuOoWLfdlwifjr5UQ2RPqsbnBCKZp0w5T4tPbhkZYAOkSPppgzzph3Vbs1Efg+Dx1/SstV5/yySf56bpc7Y4eYBa0Op5RxNRKn93846gkoi2zZKKvVQnilC77dTa/nYI5fTkDPNSepRVBhUL7/BagMx8Bu+zFHlPS2uZvIeyR6KsafRzk/E88ohR7nUaZSykdnb4JeenuvPJUZU7ghBemxLdG+HSJ5tABGsv4U3cWFNnZ3AgCl1SgkiYKZoHSbE6sLtIKSEV/2QhUMuI1iOCDwdLBOYllFnQYI7uDLgzK2VT7/DA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4477;6:kvjAHV0JT1YvODvLYF7DTZQA/VeoubFS2aiGW2H/ieoaj9hqEn6828VaF2jviQDh9uhe2iZnKM7dLz/3FiYjYXSWuYPniC5mSSA1SiiFnSBHy5eIJJACniFyCPtXDxgBCLwLQY1BHxbDYah7xnkI19mMJ0U09QQSq6aCdImi+V7r9Ix25hBg/qLdNCaVMetAa5WYCUYRs+VhMO1pXIMosUwDkIvcUI2IfkzbaqRiTm8+JQj65RQuBaRui7zv0XiAnUmOdr/jEDzOc0mSTzbziAQpBiUqLdw7UK+anhA6a/qzHUi3uEn+ViFhOflidsXrngSqUn685SzM8kRQ5HcPRQTGam+mfsNCufacQf/0brhN5uNSk3KGzWQXpeHPt8dW40RX6Y6TjB/Q3w9/4wi21NBt1S1X37BT+B+Gd5j52hlAdqH1QA9JvfwhQDxBOvLhhZgPMbXYUREmaYaBdsTXHQ==;5:+Af/OQWZ6u0V0P5n2CEaXYdlWUyFRyiahwJRupJyh8ULn6xOV8S/TeuaSRU3XN9n+ttg1htaWvRnXY9VXkuFw7E7LgLr8SGpDL/jmrJB7yH0utUbs7l5ks8EqHyyBp7md3zfEBR8DqxBw0NvmNWlRt6/A93q1sQj4fIiCbr3KmQ=;7:NS3raXPPHPIW2krFyRL2vdzWb0G0aOdwOi7fhNEuyGaNRb6n64/TbpjCj7EXAFHhxTdSMKMVe52QXPW8ADmWHJHdLD3G4qHFu8X1i8c/n4wmunJoMVCfmDi14aC+OIQgtw58d0Sv9FSl3Xemc5JFUnuHl1X0v2177IToJCq1xMTsO6s3pABlCswpvBfEqHU7rZSP885RKPOwxEerEVyPxwRjM4Ply9hi0Jq+nojo9ge2O+cLE1y0FWIfb7flKcKM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 13:46:17.2313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b7073f-ad5c-4644-907b-08d61d6d1bf4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4477
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ZynqMP firmware SD Node data API to be used in call from SDHCI
driver. Also add DLL Reset data API to used for DLL reset calls from any
drivers.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 58a7478..743687b 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -58,13 +58,25 @@ enum pm_ret_status {
 	XST_PM_ABORT_SUSPEND,
 };
 
+enum pm_node_id {
+	NODE_SD_0 = 39,
+	NODE_SD_1,
+};
+
 enum pm_ioctl_id {
+	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
 	IOCTL_GET_PLL_FRAC_MODE,
 	IOCTL_SET_PLL_FRAC_DATA,
 	IOCTL_GET_PLL_FRAC_DATA,
 };
 
+enum dll_reset_type {
+	PM_DLL_RESET_ASSERT,
+	PM_DLL_RESET_RELEASE,
+	PM_DLL_RESET_PULSE,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID,
 	PM_QID_CLOCK_GET_NAME,
-- 
2.1.1

