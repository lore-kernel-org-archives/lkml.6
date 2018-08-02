Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820ECC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247712150A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bl1u5Mp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247712150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbeHBO03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:26:29 -0400
Received: from mail-sn1nam02on0072.outbound.protection.outlook.com ([104.47.36.72]:20960
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731447AbeHBO02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urA8dkFJeYNZzORYJDNAXAEb+crdebiiyRIM1/UDZt4=;
 b=bl1u5Mp+Xh+JVqfChPqvoLF5tTM3woCsBviYr/np4J+DSTEw1HR4VCdJTxi7M/TGOqycR0AElDQmPYY6Nhg2FxnPTkc9YzyVB1MfR1ysloSzj0IGoLIahEYt5T+zhWRYHlQr6513MBGJgABCSdKCUU6BOPQGcRyQcyOgfWLhZkQ=
Received: from SN4PR0201CA0071.namprd02.prod.outlook.com
 (2603:10b6:803:20::33) by DM6PR02MB4458.namprd02.prod.outlook.com
 (2603:10b6:5:29::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Thu, 2 Aug
 2018 12:35:26 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by SN4PR0201CA0071.outlook.office365.com
 (2603:10b6:803:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Thu, 2 Aug 2018 12:35:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 2 Aug 2018 12:35:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp6-0001wS-Cw; Thu, 02 Aug 2018 05:35:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1flCp1-0007PR-9A; Thu, 02 Aug 2018 05:35:15 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w72CZ7m8026477;
        Thu, 2 Aug 2018 05:35:07 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1flCot-0007LO-1y; Thu, 02 Aug 2018 05:35:07 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 3208D12144D; Thu,  2 Aug 2018 18:05:06 +0530 (IST)
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
Subject: [PATCH v2 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys documentation
Date:   Thu, 2 Aug 2018 18:04:46 +0530
Message-ID: <1533213288-8771-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1533213288-8771-1-git-send-email-manish.narani@xilinx.com>
References: <1533213288-8771-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(4326008)(76176011)(63266004)(44832011)(36756003)(126002)(486006)(52956003)(476003)(106466001)(2616005)(11346002)(6266002)(103686004)(107886003)(446003)(426003)(26005)(186003)(48376002)(2201001)(47776003)(50466002)(90966002)(336012)(51416003)(16586007)(110136005)(106002)(42186006)(8676002)(50226002)(2906002)(81156014)(305945005)(356003)(7416002)(478600001)(5660300001)(14444005)(6666003)(81166006)(316002)(36386004)(72206003)(8936002)(54906003)(107986001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4458;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT049;1:OuCHSwDo9JjmJ3xZGvYoa3mzb/9LzKGvRjMY4dzPnWZixuM835Xxv9IibwCW5DvVbA8OVrdL9tcCZ85JAtlsCE01HvbRkuQWodKXC4ZG3TG8Xsk2qXXDkiB9XSAE2WC4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e437ee8-44c0-42a9-9040-08d5f8746c3e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;3:5tNAjXo2fKJ0f//+3IlJ3LeNiiXHBta8K0Y+Cbxo1ndZcp27pJzPUWYCQ5a7gzfH8DwLeW4QOlhz4qWkBddJVYZVMPwXRQYiCS2qLmK1VtT87XpIrDQKBC9qDukVdh99g0f1S/rS5URKYhAuHyGum4blBXu5LYTXXjejh5rCOm+cQt/w5AvdKoEziwdLTuuA3Im+jvlnZ4loztoC0aTQF7FRBIr42L74CyOWGpCjIxXBEAzi9cPc6KOiX3a0qLncILlE1aOWm3pOqTIHxoiwFejulKIDbauAa9nwn/lA9mbvzzAx3BqcGeWC7K6Pj1G4CAH7hclZQ4FbeYfjBkp9o33omxR9LblhA7ow/hj4fbs=;25:ysjM29nm2e1jGMdfTBszHwXERGH+5KYbwFF/9LwGssXM5p34VykeyxxW7Dcxko98fqFYO7MN/OzeCOonte4DWnYkJyiUyfZRlBHl3TgG5hO3HplRyiV3SaXFbm8WOvK24EQW9Vx21y/l1z97sPRM1S3a5wDpKyAqyBf6dkuMHwlFhIylP0OlPHehJjG0UGdnvKzyb3+OLu6IddWx22+F8Sj5SoTfo0W3YB/Ryye+9yTRRJ+NYRbRXELDvMFZpYXo4r7uop7Ls1t1hUee1DO7NpYwVx0b04RiLqaf/2QcjSLg4ofp1PEcPsIwJWgCkGJ4lb7i4JpolzcP8qIzpIP3tg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4458:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;31:uOfaxfYMMrI/r59f1nZT47uu5u1KLXgCJXiSHvle9DHwmWvmG5cix0AXvapqtzjVSwFOVbvLgvXqH4Us2v0ASle6sV842QP/LYoGvQ1VQjrQxgN/6O+xy89AQHUUbfZeM5M7k05UmKHjWDJh5m3EmF1bCvKEE0mFHQ9k6xVVjmhsOINB4QObtNDWOqGxCpEiwxBFmW4aFe/jWqpkyt6KgmkQH17byhdM8hpufNXLfVE=;20:r2mZf6hQP6bL9LRQuNSMmO+OA4gzo7NbLHRxRzGL0k1nbboaz8EBVZO0hbWSgyHwrQvjaD5X+Jrc+ISJWIxX6IMJy+uE2PlaMjTaA/9aKqbpNulRNY6a3k1bJjBIrZNNbCca78+De16bs73ergKDciUHNMlpy8dJ69BIxL7vm96cQRbgB92WcV+irahvsmE3cYPACVKAbilmyC0zHBOGkecTzlErHzEI6a70gQYI1KAPDUq55hYlTbS3bUcJNDMW0QXy5Eg6i/mK4cJufzf4vHz9GYvS1C1ApM57Gl/eyby2hDH3bCp5HQn//N7buvYw4+0erw7ZXQKo9Nmww7jhsSiIoGbeBtclBNR0VQLk7I7VFkmqcSPkSnEmoZNRP+/Tk6sJGejsp8alCBvFqG38TlaUC0o4f/e83p495xLnPxII1ly44i99HxiUs3FIAYDfaCqnw1e3lSq2IoWdWVyP6qY7bWwdBs+lzkT42O6SE6QbCC4GPBk0RvS0hdWfSGZb
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4458758BC8530C3BAD6B68DEC12C0@DM6PR02MB4458.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4458;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;4:de+yMhs/t14iRYgk92CgLdVfM8FwI3YoFc3JSul40DUk7dmI9A1Hi2rMNGU8IBBrGlmJ7TG69B7e67jhfYDW1EBNHXRzBhJD8+GwmpUiBv1GTjTfHU28IuMZK1dSAkqJMuBe1VoI/gmFEYNckCCEVp0/eywdixnTzjXhYbMH4J0SlQrzxYJZlM3WYc4dUEGoeMWI6pHUmqqmgeUIQQmrUIBxKqkq1AFZgIOYR7zGDQM6hgfWBL9mVwif3IH7Jf+mWLCHuiXY8chb4QENdazYEjZSPOZAcfWrbFibTU8Uif3DBNgxyAInhNax2uZ3KMJYT3l4XnFN05hHZO1KQlEb69BbpdYyaP0aQuoXPvnnXTI=
X-Forefront-PRVS: 07521929C1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4458;23:l26EGCHmkz0qaTGNsHJx53BUYgK6lxqXSyZDTAsPz?=
 =?us-ascii?Q?U/hhTPF8huexKnq7Ad+hlVwT6NwGY6YLFF4Bi4xs3nu+dCapOEuOepQy95uP?=
 =?us-ascii?Q?84QkFj03yjndd6rzuFwX6v8nalAuBMTNn334Pwr1gCwVSVG2/dg5nyuix+Ce?=
 =?us-ascii?Q?ONz30hId4yw6ZlAZujrz8wlrhtDxKf9ielfWcVFfnzzls8h80JTe+pv7lRNs?=
 =?us-ascii?Q?u9NGZZ1DKAWaVeBqK8jne/khddOjHHXaTf70OzM0nn9Jjij12NPymEbpxavs?=
 =?us-ascii?Q?hQ7GwjCz/lBmqs1DwmdXZITJg8IynYNcdOv2HiF9hQgMmo911L1OT7ogc2Tp?=
 =?us-ascii?Q?MA4QIJyLpTv7byVlto4bhma0gOjqrm74VcXpTHSes5SlMPauW2WI9fIhTsvt?=
 =?us-ascii?Q?k72hQL3+8GSkz3JwynBksWZiX2zZqfnmRk9glqzRM+Mfk+rOItJkK7Z7ggl9?=
 =?us-ascii?Q?iM129oNzTaAnaEZVSQ7HxEpfda/L4L1Phd2h5PFHO9JNETtlGuhJRpnQYO/J?=
 =?us-ascii?Q?ATn7eXe2oqHZhBUu9zhr8TjSNAviqKrwe9UTAKYrX8LwGX2C55bbxRWxbsQF?=
 =?us-ascii?Q?0xTs9/cR9uj/RToReH9Aww1sRjMGjQlSHc49ZBbSktvwni25zre6JGuONO+D?=
 =?us-ascii?Q?CCuSHY2nJp31fPyUKmIpgUmzWHyi3fzMeFnKWsX9R82FuLWbH2moPbZIuiRP?=
 =?us-ascii?Q?9HgjUQmLc/5bOPjJ9x6LI9UwKbRFzr5VC7G39uP/d/vtiFbmCOLuQFY3qxTZ?=
 =?us-ascii?Q?FvWw14uLZYktt5InPIXsnd3W7d8krBrFWOXZ41goCS3pyjdAt+bwYW+xAPHx?=
 =?us-ascii?Q?8B77S1lkj7FRhSAa9m1Y/lmEdqaPGs9S3b4yQkJfBZa+Rx2KjIUNUEhykvOd?=
 =?us-ascii?Q?n7OiLSXGtgVEKctAuyvLN/R7wsCdIWHzERO53h0v2ppRWLwxU57EhpCqMlZb?=
 =?us-ascii?Q?bpiTOycCvLkxaUDztlbfjJZHLpP9t1X/kOF0TYltGoo+ia87J1W+pw/T5mpv?=
 =?us-ascii?Q?aZeVEVYNJYpqGJb5UKMUjGWG99Im8p46TUafxEZ0JuK9CUEw3dmIHxqe5csl?=
 =?us-ascii?Q?a+p1uOSO/gOtiruTOaZTpsRpGUoLLzFgipICzTSfbC4K6jiruyUAoHgeHHtZ?=
 =?us-ascii?Q?NJMliqnskHciU8qdIpiQE5CUNxxITDMJ2DJB+1CLwI4HMTknwVZuBIKSrPs8?=
 =?us-ascii?Q?3fT/2FWYPIg8LIILeooQ9iLd/K99J3sorbauZwIcw4WWhhuTgQKXwUAOuPEi?=
 =?us-ascii?Q?W3IVLiBztRRF8aDYW+Cbec1cy21VD6gFxUtBWTxcmT7ZvyYL/X6Xul7fJQpU?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: 8rxqHi/ZrIaguJgGSRplQUb0M4mYbr3q9hjaZyFTOQg7kZE+pMTsKZexFF3MuTS2tKRnEvScVLFAUPnojiFwIxMHocIgAt+IZYo0A5JfJfgwM6fKvlnYW8MVgJdbnpuDH3SDMhi8yDZ6T7cU8mFxSZXvzdj1PSmE+vFmLgknJIxPRvwVbt7S8laVMDC4pfPlQz/9Ea4o61olPy4aXS6ofu75JOETRe32dqeznPBabC3GkYUoDXjJH8RJtfMMEi3Zu7esHjxL4Oyi8Zugr6H4DYtIG2wr4g0eRNK3jEpUbqdbB6lPybm1Wxw48VLMXj5fqUmt8a+pP2aLztEkFoQK7znNEPTMjmbmwKMZiOlDxak=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4458;6:J2ZdChmroApTmVHY/8/ONozgidYrxordQnDWnb/XMdy1hUkQgclIJ7StCv7o0a6GRRMywxkWJbs8BrzHgHdAGd1akqLh+QKKji381SKDprvxdF2uIwLelW8rQV889749jfxnzdtMEFw0xlglZ3RGkMj2mkVdnwMDi304AQ3L+cT85x/PhDVqWDYYOAMRbSKxzjBr8YshsmtF10V5H/j2gKlQ8o+gnwVCEt9r7Zy05I8yVnfTpSH76kUW3hIt8tIB9WRNwaobyX1R90OYh5h99ZfCQ1WmiClpLTagE8YfnLrucknRmmcTP+Z+mX+Fa/1+3i7z9tTgsqo6ksKi9fNDdt26pvXJcaFNkJLJ0FrhWj0GEyZuYvtA4ouOLdTDdzBuWei58br2ijGneq1tNxb5dRwzRDvV/mdb/Ne3CcPuY1gbOO1oIjw4kwiOKGvhC8oeT7xdoPHrNdLAcoaGU++mMA==;5:mOJnT7RxB3hyBHhDCQ//OYwgIwy4TiXkddqIsHrMzp7RF97S7UEdhXUKJACpgTFIFRXw9s5AfjTcK52euZxAcJkcMC24ye7HBGtTbbtfSxGYxzrCDhcgv/35H8I8ddI0zFJ6YAUMpI0p/xqO6EmS7CwExi+dB+irD8ER/oHLHEw=;7:WthGEjGqDnPUEJkXr/Lj4HFTIt3tJAgPo8evsVsOZano+6IfufLZ3URQ9kTvbRswI1BOd7sJ6GLQUEkrVNU7LCoRby0Dn4pE5P7lCzp1vdkxs0RxTI5kuqnYWRP85CEs16UEJ0x6qF5WaEBEGdR+y9unvfFXkxbzVMLCV0dpiO8foH0kcHUqS8kWssk3/de+J0r7SQul1gv1MezPCyiOw7vA1drkVWhzEgZChjcpZiafL8M+/TCDHMfUYbQFBI5R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2018 12:35:21.4194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e437ee8-44c0-42a9-9040-08d5f8746c3e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents Synopsys EDAC driver which reports the single bit
errors that are corrected and the double bit errors that are detected.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../bindings/memory-controllers/synopsys.txt       | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index a43d26d..9d32762 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -1,15 +1,32 @@
 Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
 
-This controller has an optional ECC support in half-bus width (16-bit)
-configuration. The ECC controller corrects one bit error and detects
-two bit errors.
+The ZynqMP DDR ECC controller has an optional ECC support in 64-bit and 32-bit
+bus width configurations.
+
+The Zynq DDR ECC controller has an optional ECC support in half-bus width
+(16-bit) configuration.
+
+These both ECC controllers correct single bit ECC errors and detect double bit
+ECC errors.
 
 Required properties:
- - compatible: Should be 'xlnx,zynq-ddrc-a05'
- - reg: Base address and size of the controllers memory area
+ - compatible: One of:
+	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
+	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
+ - reg: Should contain DDR controller registers location and length.
+
+Required properties for "xlnx,zynqmp-ddrc-2.40a":
+ - interrupts: Property with a value describing the interrupt number.
 
 Example:
 	memory-controller@f8006000 {
 		compatible = "xlnx,zynq-ddrc-a05";
 		reg = <0xf8006000 0x1000>;
 	};
+
+	mc: memory-controller@fd070000 {
+		compatible = "xlnx,zynqmp-ddrc-2.40a";
+		reg = <0x0 0xfd070000 0x0 0x30000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 112 4>;
+	};
-- 
2.1.1

