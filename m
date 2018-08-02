Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B20BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7249921501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DCgiEHmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7249921501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387548AbeHBOnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:43:31 -0400
Received: from mail-eopbgr680062.outbound.protection.outlook.com ([40.107.68.62]:7392
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387444AbeHBOn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9qoUpOg9ZO9st+BmqgvKZw1O9Rbwkwlel6/FXDGjqE=;
 b=DCgiEHmM2AoKrSpets1yc36ypx2wIdEmDcOiaXVsEDF7dhT5daRku94thM81bTYGiPXVAF96dhfh3HU6sfwT1J7YCoiDMD8UHjgjL8bww3gY8Wq2gd0Wk3XCOfne2Ch9YUUS7VqCy1l1TecMpGhy+w/0pKJJ3xKCVvDhvKtS4u4=
Received: from BLUPR0201CA0006.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::16) by SN6PR02MB4461.namprd02.prod.outlook.com
 (2603:10b6:805:a8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Thu, 2 Aug
 2018 12:52:19 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BLUPR0201CA0006.outlook.office365.com
 (2a01:111:e400:52e7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Thu, 2 Aug 2018 12:52:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 2 Aug 2018 12:52:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5R-00022p-4F; Thu, 02 Aug 2018 05:52:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flD5M-0002XR-0d; Thu, 02 Aug 2018 05:52:08 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CpvWi011590;
        Thu, 2 Aug 2018 05:51:57 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flD5B-0002WD-Ei; Thu, 02 Aug 2018 05:51:57 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id A16851213E2; Thu,  2 Aug 2018 18:21:56 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <mdf@kernel.org>, <edgar.iglesias@xilinx.com>,
        <shubhrajyoti.datta@xilinx.com>,
        <naga.sureshkumar.relli@xilinx.com>,
        <bharat.kumar.gogada@xilinx.com>, <stefan.krsmanovic@aggios.com>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 4/4] arm64: zynqmp: Add DDRC node
Date:   Thu, 2 Aug 2018 18:21:22 +0530
Message-ID: <1533214282-9977-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
References: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(189003)(199004)(107886003)(42186006)(103686004)(36386004)(110136005)(51416003)(16586007)(5660300001)(478600001)(36756003)(6266002)(72206003)(316002)(90966002)(305945005)(4326008)(2906002)(81166006)(81156014)(356003)(476003)(2201001)(50226002)(8676002)(44832011)(63266004)(106466001)(47776003)(6666003)(54906003)(50466002)(48376002)(14444005)(76176011)(186003)(7416002)(486006)(106002)(2616005)(26005)(446003)(52956003)(11346002)(126002)(575784001)(8936002)(336012)(426003)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4461;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT025;1:+7tfPC9LumbxmpBsKrAF6jIENF6TGboX1lMUuwBLVAG/SSPXYUNzsszvVVhw1G0fFQNR8MnBs/lAjLiZSKMdVJPbeWm5hepzyY2Jb02CVdyZmKZZjdGqaGBCprKrCPJY
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c576b166-af82-4e18-446d-08d5f876c7bc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN6PR02MB4461;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;3:l1MWpLmFZy++C+r2D5X7YtFjtViK3JLaByyY3cvlDBwB8mWfpuQgKS4UeWpxH9LsiNd7OkwyGe6fUY+RQleOY5MTJtK8FQC1zJZsmMiMq4eSPJEYa+GN7CjazLi18W81/ebsWRrugPJ+wWsaRVIbdFZkvN//kfq3v5KMccHikknPbbcwF67H1FK72hcxx7CPLMHl4PnpEDov2QWKbTYRWpHVP6CZVGnm/WURGJKtCJYPGIoB4tdfDnuNnSW6lBqWmsSU5I5B8xzE8S6b6KOM0zGw/ZKQ9fKTJc6NfbpQcWx5qbNBBld7Fpz2wBgDgVpKODaDqneLnHyNV8PLmtj7hg+SjVSoBeDSL700toW800s=;25:BYl034aDp8fLiQ3GUDxNrST029bnvAVH9x1Ioibwe/BVdC7jxBeakrxxUicUzZNUb5nJNNh5/Qyqu4tYT4T9m0w/JJjEoWF9lDeyJ5Z9pBDedteC853LoNfiwr9yeVyekjSVMgM9I4NJF3Mkeo5NbPQSGpFossTe2vTh9QM7TP0CE6f0OEkWLhwf4DOXUtGbFLqUC5u3Y0Vt1aQmb+p6wVsk16F7DrZcH1q8yV/UBb96kgZ+4qBxMxetqopZnNQtJFuY8SsYl71ud1HY8TVM3H+jvdslFvPRjzZwevcfEWsMpwQVcNJbHuSTADdrVVPUtk/2geUOiWTI+9cApSREqg==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4461:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;31:bVNIXgSgfX+oNXW0RleWp2bWnW3oslnRLC/Pg8EJzgmHtH5ZSs7gAc23u4C9XkXRiGfBE396ek87+eTUeeXn7/icGVrZ4cxrpRe5a/S9DEzyvqchGG/By0X1B0PiV7rKRMhW3jgDRcd63z4rG9Ru4NlZNciaKurDmvFDkPGd/ex8PtbD1MpjyFE/LDd+4WItrd2ISDiEu+MWJP5hjOA6HnuUVjJyXddnA5sMoNA3xU0=;20:UE45cqUpjOhpn2DbBDCGSIssZsDnYgM3Vv1At9BmxBeWtJyocRNjvkEOqG28tJgbYqHzq/rlkjygh2k2MUNv821hohOgvrAeWsvQxwGk1X4ZXN7ZELC04TryltP7DtmyZoezqxVeFiRlIl3OsY8wv3GV37YzIXkacJzKqvRVAzSCOorITh54IDHQxV4I/4SA3oArdTbuafWi4zbkqWHoZjxrQlIfoH8FbuLih8ZWWHC7iunucXMz10B0Js8YNysmSQcOdZzwpTnNhYAzYSW/TvncPRnomCSp001NRy5TbIhIFVLTra6PRQp4CbTrD5RpyrpHGZojFN7Pl2DDcja+scsQy9XGugzKfSVTSiAtd8c0WqnHBrltO2T/dFnmnRlBpvaIMN78vnYQI/feB3QWhZtYtk4P4EqHDltBvQn0sUTwVV0KWdMZ8001DprWNgFMrELyQ3dEDHCC2B7BO0puHfFN0ngO6WIhkJW7rYbosfrHWUK+5gd5QQncd9ZxvueZ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4461C074CABB3B3B5DBFE17DC12C0@SN6PR02MB4461.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4461;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4461;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;4:RAve4lDMYbBi+Sadhfu1O2BvQjgwMc/f/dBsu9uF50JQuz4xmh4GtcI3kZ3rsxTVOju8VJ+3l7+Zg/KemTO3q4xDcsqZWjoOYHRzd7DHgdnA6XDY3oIECauiEd977PAZAkBO0G7S4EAjhTH/vNub0IhLHr4FnxVNcZrZ9o0xpUcitftC/oOG9iohDUf1mTMb4dN8lyM2k/tCeAhW1qL6kggXwkDs7gerpVo9hWR/0x58foNteVzmltfFH5dzfvGLDmZf6wAMreU+4UAOs9zLldueW+cj6FfPh24+lPpkQfOiPUPcWoOn7OjZ+C0syIEv
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4461;23:HoZWhM5QGtjown7hB5SfZaUdT7p/nwTo4HyGy1b6B?=
 =?us-ascii?Q?S6DBhAv8nSmB+wcRI4rhvU42PY8apD6Gc7e/8dtuKG8V4dlbV/WB2MO8xDa7?=
 =?us-ascii?Q?obi6VPbY1a7S+fmuMkl+O06k8rmn/KVocxqcUGRn/bmK60PNriR7qG8ZFi4Q?=
 =?us-ascii?Q?aSLbgibPdWVWWe/f3a1EsKs3ztd5x80H83tBhh5Lt5+UJe+35qYCsswen1by?=
 =?us-ascii?Q?UVRm108215iKsn1yQs3XI7dKVntxiYGqtmdy90+Kq9hy9jLEfdVMsfyf9gAv?=
 =?us-ascii?Q?FGkKdtlp3RmNM7r5hhtln70YCu/9DqILReyjYgOaF9ybc2LfalrXmwBAjE6v?=
 =?us-ascii?Q?sycKEY9FX4KNSZbIUIABG1HXKmaFm4UoYloFWPq9Y2qaz+BSQ09T4jQ4Ctjb?=
 =?us-ascii?Q?LVJsmAuXk4bu1dckjsCbX5/2nsatzwPVmMWuHJKk16hhHKZ5wjzq0poPjdp5?=
 =?us-ascii?Q?HazAQrmpBSHH6+YWPb2q+bcIW777fVi63Iy/mVn6zVPnQ3RCknK3CGls5YLc?=
 =?us-ascii?Q?ceNKDYf2kLLJfZOxjY9svDzuGN90rpsBD8/lQsl/por84yBmNbgpGFFujcMv?=
 =?us-ascii?Q?Cm7AyHIvaLeth9HekdLdjD0Mw0TLgIBzFz3F4pukw+y484dxwMfYp7PBKSdz?=
 =?us-ascii?Q?dVr0x4XJM+gqUCrQzjweHsEgdeGWRcurNpYJ+rYYI7scvW20iqFyQ5tfHta+?=
 =?us-ascii?Q?0HUgPMCdJbOkRsQjVwSnUIlV+oiCV48Gt7rTWcrTiIvBQG48xA+FYiLIZObn?=
 =?us-ascii?Q?k0QrUT30tXCNKBeAlEn44BOFO99oLEgPZxw0BH00LV4af2lrI3/MscLmP3B8?=
 =?us-ascii?Q?xezfcxmeMr2raagpV3h8Oy4DgFFdaHyrLzkozz406ExKwb9UZ2CncbNjVenV?=
 =?us-ascii?Q?+TU8FVxcxS+Ws2jJrRhFaHNZDZQvCXhJzbSY7CosUdbtAtDj01eP2nYjz5Ki?=
 =?us-ascii?Q?ZcxLZjfEKd6Alq2qaEyKp50tdd+DMGI9svl76lMShduy+PAmiwXxRGpEbns2?=
 =?us-ascii?Q?OnMa9gjgfejrZ8bK4DIxgjePxhx8WfRxNODNj+7VxIaTgJCi/2hzU9aZz5Wn?=
 =?us-ascii?Q?snJZL6JKJzUHJjagFYmdEC88GXnN1ya7YWnGVGRdOjP4lzxzcNjGMxk4aEDw?=
 =?us-ascii?Q?mgV0O/IZGwobFY14N+mkOV+ehjT9kSwTVcUoUX/cfYBXGHbe+lp9Mej8hPlr?=
 =?us-ascii?Q?y983KkdgCD2MXlct26CXGW84s3J50k2yNaG4qday8G3p+nfYR9KgId7pSgdG?=
 =?us-ascii?Q?Er5Pr4WiPrEOLrPTJEu2iBzcC5cyCf2DRnpCOSfmeS7nwxEsocr1uHQVekYY?=
 =?us-ascii?Q?G6fEJUT0ibmvxASCfDkVM8=3D?=
X-Microsoft-Antispam-Message-Info: sLDD5+fIadf1ot7W5tXVYQ1zDlahdyX5VXmHzLPMQP8Bvw+2L+IG6OTzd2Qeb7NfbWkQDe3CqamdphW8bKMN655/AqMlcnUYM51Sz3toXS351Bm+XzG4cO1kHC8l6rJX/abjN+B1PKSGl3oiPxSomJ3jO839kIEbn49WHw5zDnRyt97IRTl5XQtXrjjfUMbQGG7ibywv2TgvvEtntKJbyVmOZOLTCMJ0n97bZntQvqmX+/1GJGVn8nt/afj85hSsiiNpAXX7Z8QYMaIcaKwtKISWcSkNAZcF0Yi62uDjZYOJghodcud1LAV66Qxi2BCTN7LnbTgBFsWiabdPiagahIH8Cvbqg4iL7S5R73XjgDg=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4461;6:v1ElcW5F95kuZZ3lKtKON1upCOI21rfNpBs9HX48XpsQpQLLYcZS2KiVK6BbKJ6+Vx+q4qvI8oywIn8mDDWCB7cnhQh5mR56LkBgdBoeJH2Q4rwAE2wKkxX0nrPm9oWe7Y4ZMSBJkxZzhTJbuTKh1UNLA3Wwl09oTNEoDgw9xDuk4/vbGOKXAbOnNgDWkXHA3AqEDmEADVdVaAIVP1j2LZ3pU9au7G6TmAfDCqC7x2MRXMRtMMG5QqMa0XLZl6hspvVZP7jMA7ZpSQHPEg/QXVhSjMzOcrm1e40whYtRxIGri7XLknmN57Y5Zk8BEZbh0PuiKbbZzmDCfXoilZ/AJG5M3Hczm2iLar1ZuCeMkMRz3FUHqncqXKO2irP0L63Aa+b3vcMnW1mtAJIvyYY7Ie3Bl/EX/35Xw9nFr3AlQRWDa8HJTQepZ7QoQhdxdu6ZdOGyeTUdVO1uisdDNaRxYQ==;5:pkw5ZaBb99ZT7AlYLjC9iq+nA+7oOurzYG8kzUVpWEhdRRze6owL47IE8mhWH+KwfMdHYDO58XzE7jH+0bwDfRfBbuR8b2Xx3WbRvjpC5cDeVn47OBJ0bcjEyEIlnCKGKuGfgBd6F3vMhHV0fM7MWUIRflHxw8NDRZXWdN1ntE0=;7:9N7lepsxUWZ+A2cvICgb24mbLo6wqmjg+7ppr3eA2qaHKLFQDyWdFdsnxWzfHHx61kBqYtk5Vhv3gRhL8udUx1yB2ggCvy4NehPqJPxKIHh9UDJWmQwVxpxZS++1sMi1provZ+JGp7dC6hmufIbE/gfiqLsQh6T3r5sDuLYrBGcNJwTAq/OfdEyp6bgBfOo8dY1gXgUNLK/cfnJBx6XnqDvKZzSHE3K7btino1U9Vz/bZEPsMtT/rSEDPJurjIn4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:52:13.9407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c576b166-af82-4e18-446d-08d5f876c7bc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds ddrc memory controller node in dts. The size mentioned
in dts is 0x30000, because we need to access DDR_QOS INTR registers
located at fd090208 from this driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a091e6f..7d6a3cf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -355,6 +355,13 @@
 			xlnx,bus-width = <64>;
 		};
 
+		mc: memory-controller@fd070000 {
+			compatible = "xlnx,zynqmp-ddrc-2.40a";
+			reg = <0x0 0xfd070000 0x0 0x30000>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 112 4>;
+		};
+
 		gem0: ethernet@ff0b0000 {
 			compatible = "cdns,zynqmp-gem", "cdns,gem";
 			status = "disabled";
-- 
2.1.1

