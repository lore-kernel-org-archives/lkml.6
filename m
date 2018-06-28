Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E22C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D78B273FC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EJcR0Fp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D78B273FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966129AbeF1NMN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:12:13 -0400
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:52034
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965285AbeF1NMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw2cd3x14LCHrsIbDn+FGB2f3nY1xQfa0Bc9IdyIIOM=;
 b=EJcR0Fp0QBAPnSf7ygSyVXT9SkKz3QF/4Epe80gG3WwEWzIfFdCRANigT6mOy6tQCPXXlCxNUQ6ecBzOKUHJ0V2Sh8JaCeBirkNLnobWXNfm7PJs5OrCYyrmBQbkPGJE6dDbrt5uHapRu/Fpp04CPmEdXA8Oez6TFszgGETLfLw=
Received: from BY2PR02CA0122.namprd02.prod.outlook.com
 (2a01:111:e400:5261::48) by BN6PR02MB2643.namprd02.prod.outlook.com
 (2603:10b6:404:57::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Thu, 28 Jun
 2018 13:12:04 +0000
Received: from BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BY2PR02CA0122.outlook.office365.com
 (2a01:111:e400:5261::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Thu, 28 Jun 2018 13:12:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT034.mail.protection.outlook.com (10.152.77.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 13:12:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:53403 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiQ-0007GQ-Ez; Thu, 28 Jun 2018 06:12:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fYWiL-0001yd-Bx; Thu, 28 Jun 2018 06:11:57 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5SDBsQe027107;
        Thu, 28 Jun 2018 06:11:54 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fYWiH-0001xs-Va; Thu, 28 Jun 2018 06:11:54 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 25B26B20953; Thu, 28 Jun 2018 18:41:53 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <davem@davemloft.net>, <michal.simek@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>, <joe@perches.com>,
        <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 net-next 3/5] net: emaclite: update kernel-doc comments
Date:   Thu, 28 Jun 2018 18:41:48 +0530
Message-ID: <1530191510-10310-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(8676002)(5660300001)(2906002)(15650500001)(36386004)(6266002)(103686004)(305945005)(4326008)(6666003)(186003)(336012)(14444005)(26005)(575784001)(48376002)(90966002)(50466002)(52956003)(76176011)(126002)(2616005)(106466001)(63266004)(106002)(47776003)(2201001)(51416003)(446003)(486006)(11346002)(476003)(478600001)(36756003)(356003)(81156014)(81166006)(8936002)(50226002)(42186006)(316002)(110136005)(426003)(54906003)(16586007)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2643;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT034;1:iLcz+NoX/2ipdNrGP0FmHup4sotDlaJ0wAU8EzqtzQ6prNh9eWELeGzghKM0caayZ/EtBHGr8fafGpvW0jWTs6SjdejnjPM7ooNbMCJOwILHWm0ijL7kD7c039Rd/rL6
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09de18fd-8996-4c46-66dd-08d5dcf8bd90
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2643;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2643;3:hKa1L9eVCgBXqvVWz4txKkP2R3eKHu351Cs0R7mGsbI0pqlsF5V8z8PLuGZnElR4ZvguZRV6hjp/pAV/bYty3YAMrdIT06U5sWuArgiEJQ2zWmssISQhXAwr3tGwee5k/bGUeh58xm/DpAfqnEh5YB99zzdfTkEjTB+fnea5whha2lQ/9Bf3MqPFoLIaCgEOwWPFe/Xa+zqSLo7y8aLT5Mw/AJ4NVLqSlL+7qM4GnzXD5g7rnT4mTYXhEIgQ2nuuON6IIXnuhv0RExrJG+HJo3r4W/WYQJewh52HbjQt97hzOOtx2KiHH2x1QOtg7bSG0CzTk/RsnHWPUltXbVjX5CXUIOiT6zOfkYo4CcBGEbs=;25:vsUSPoLYLnrUeJZowjZlPxRzLJrdugLw2r8G2f7hozWd9knR1+e4Zwu/ES2aQ7Sfvm40KwAZut/kxstkDIS72NsEqqvmTiAdo3f7JEO299KZucldFojkZFQPolo2tJBZTjQiHNDvRDzgwh4ccP1WtJNlEioadm+UtvCP0RjldSLLsQhEaeRfsu7nRv2gAT4iyXOE8BORlRh9AJ9BkpTynbgiuIXZIF89gXSBfYU5WZsDy8ioXXi2xLpbM0nRdTekXfHCbnVnnH74k1id1UWNShRg2J7lKlxTfVdzBSq6seB6dOjJFTibg6Di//E8wLtwOY0/rjTdKaTjxfZBa2AHXA==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2643:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2643;31:Q6MnC/C8gswhvM5hLOVJse/e6+3lDVsXopYF51CRADKJrdGiizvyn6mllFF8FJkH/q/s0XllC6+91PsuKG3TD8tbYrG9qChstBydEUAYC5F0v+h+0iYCmTVCi7TgdwATPIfotCf9CSksjzJ4UxGz1t2xnuIufR2N11Na3QlYPSOX93rjdR1y2aIaRyNLA9x/v8Sk+2rvqcSoN/2XAwYcexgWJxqeRgjzfYtaMRftmDg=;20:nOPlNO5LB+o2WJO+bwMfSUoZ/YUDCpisIIUV34hlODjTaro/vpgWLtwKMyVlq4mJ67xOqRnh/FZgd2NLwFmPFdD/SKHv0rHz3NiLswCSAmtnIvnKgUmJUVN9xFHIkVYBJtlP9wh5fJdIOcHCVECoqgJlWzDlpMFBoZICVGyL8tD125DbyqYdOuZ6ssg6vKmMG8Y/gUKKfhRKrIja/Cwr7bbkwK4SEg6r1HlMxWhTJHCRKA21e50LYR4D/LAld7goNef/SfmtOx50c+UTlUOdn6+eJV+aGxWgJ74vPpr4iAGOBsqf0FTWz9fnNUiINbTQK6vrqwCiY0CWVlzN6VkUzw5SbJCP/SE2K2/QxPJSr2zupTz4RiID3s47HbamaEWYzXwNC/BrjTuloVTxxel/VF+foYr+3tCDRfv2ND+9OR2xSGRxrFBfcm7ir91OKHQA9L40zZc03ZAoAnJbcwA9o/1AAcnT+khpLv6FprJ4uWb4iPM16C/AanamteSgFkmd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2643DCFBF4A1F1B39CB2DC41C74F0@BN6PR02MB2643.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR02MB2643;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2643;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2643;4:VVLGt/sx6gvztmF3aovWEFMA5kcklwdpns775QxG/vOvnY4INvKPI2DOA/ZZR842wvgDIhK+YfMXgSY5uFGZi6ggP5NWW7fORpzGmE0FlyZpZgJdeQiF8XEAR+U8vqilYN6r0fYVIa9tGKph2c4LLbnjwvBLwmVyWFzrsR1SeKpASv/TerJ1k6NOrdRjfIT88I/4087mFnXq95JyjGBas5tE5WkL4mLUXvu76HZXGJixpM0vgC6ctzMjJrRARBbmEZ4hIL7H7yr/6tAV1HlHpVMgzvJnpiL7Ba31qw0sneZMsx7ks83ymWIl/McLvetv
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2643;23:TY3IqqgOuW64xVyJauhfUFioe/cPS6S9F6EAqwfk9?=
 =?us-ascii?Q?IWIgBgVwY63yUWF7rhimjFKifkufLXcJaZ2KvUbOgJCYodnhs9U7oUqL+7LN?=
 =?us-ascii?Q?XRx3+Zz9j0nFFwCIxUSi+XafbwDf8xEOhkm/4MLa8SNBDFC2BwIjsqFtGZUG?=
 =?us-ascii?Q?z941Bd18za3Nlv6YdXI3yx6oLxX6qzOhAfcBiIKzIgPKdlZIwoW9K7+0eiSC?=
 =?us-ascii?Q?l3ys9MTH8uNCQ3jlxL5TEB54rINIUlw9zY6s2o94lcyFxrsynkhU2AMZ80rJ?=
 =?us-ascii?Q?9KLaXLCCrTxtTOyESS3sb1ZWekpFjbv0SALkGnLxnUbyNz+pCvx9tROKOETl?=
 =?us-ascii?Q?3Evl6mggVI3VA7IP6B8dEEr7266fV+NsM00UQJoFpy60nXTKtmB4rVUs44vp?=
 =?us-ascii?Q?aCY7q1GBhi3694RMCqDzCC5CgqU68GRP83kNSjlibG6Gt95+Hsz9C4aIHoXf?=
 =?us-ascii?Q?8wWEQuZz0rPn+bLU2Xr7gsizD83d0U350DRwTiL1RRCYVbmy/4L+mbDwJjC2?=
 =?us-ascii?Q?Y3bv8mkJHu7Xb90kI92QU9ofmLjybL/w8vFeoGAjc7elypIPpieNnno6imfl?=
 =?us-ascii?Q?1nFPJ9gmDuQjttI/XymA3DNP528sTBmXsZpu4eQz51WvfcrlDWVYIk63HYur?=
 =?us-ascii?Q?pG/FtQ+EABxo5se48SPzX9f6TOl+XGSPA6wKIC0QM6+mjj7oJaYFXk9XR3hs?=
 =?us-ascii?Q?bIelQ9vaKxx68FD34eloQ2jFbewWLvdMDHo3WIIxuK5uIAWmxna3iBttLPH8?=
 =?us-ascii?Q?Oo5z69R/PlFuZrWuIqgoRnqQnj1rvjtWOxEKl/5pbd1l1aSfaIK8fppRhU/A?=
 =?us-ascii?Q?EGnK5YnA/lTvYHVAxWVxjDVkXpzV9Blx2HtIdbAyzYxDHsMklOPI3GmNUcNt?=
 =?us-ascii?Q?GJ2JrlsJ1+1aBpoXuvRqoQ5ocE/R8ypBkkZpBPsRNZShoIT5JXa2jTS2Okuc?=
 =?us-ascii?Q?KLj4bBZk/F66hgjTE+LUyX4wZj8P3SV4A2iaYYm1Eh01owoWIoZrdEnbzPTD?=
 =?us-ascii?Q?3sANfkFhFGFOtvAs5bDuE09FORrRUfsuoIexKPhBHN/87P+lJq9v00DR4me8?=
 =?us-ascii?Q?x8gNmjPRo7andkLiQEzUaSg4Apukq4kso/Gw6w7izZzq1l0HweNFoqGxShko?=
 =?us-ascii?Q?DysJxXMiM6/TUBc9R1I9pb5oUQZSR1UBrhSD/a+tZahwOgWM7mR9YeoSHVSa?=
 =?us-ascii?Q?Kv0VSqpQcrOdsgnqD3rIrWIh+8STskb0YHEWTU0Om5docCE4tJFHm5WRUx/z?=
 =?us-ascii?Q?0aZ24iaq0wlJYdG860=3D?=
X-Microsoft-Antispam-Message-Info: ui8rWn2qU0B7WBzGWM3hhbIUKzoZuCrza2KE1usyJupGfkSlH/K56YBVRp2JWEKeiLFYCX5b/1C6/VkMvUBLPckZUXNHptc6APTgImVswzyLtxEBH0N0Aii/dZp67FYjjGhM2jzXkvTDbGVUq+jzF1i21s2FogY0c/V6ABazaS4LzJK37lhNER28myga8BIYhSq+iJ7wILTsWbMHxTVKVbG8gbYLn1rcfLd2TWNkoV5/Xiny+G0nlivzLc9y2z8ll80nf3GNAQgh6KJmPLePMDE1dG03F2DiaJWQEZu+xqLD8AbLrBBpAiELHfqsdzVa9j07hyR0pid/T/f4CEDOWWLz/T154vPTYwEbT9jwW0I=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2643;6:ueSftDSRSt+uIVs/8NHYL4Qm6sYbQXXQ5/olqlUWSrfL3LLPEgyLv+Lh8Ir+XFdiPZXQacSPn0ugVBB76cMQQQ0eoRGLZVQML3gqs9b7Ty6csZ/S3P65fXB03CO4dytQ7epMPB7A6bdFyMIk5+1WK42mCd/hbl7zfOnh0JTO0hzwYv9hf0hH/OhWcHFL9UB73SJ3zqSpFMKt5AHEl66sSOALvIuMjS4ijnJpJ4mNNuG4YFosb9Fy6d+f9dV1ru/hdCxt8QCRDx1kyD3u0LA2OX49aJNGFlecJvj/s5SsNqBM/Li5siyHI9ZnvnRLFg0/uC9GR61/3x8MogV/9me/dfNrgyu0z9qApYxmzZb/+8119B4bAGcQPE0yaxbvufg970H4UL356Dgs64rq6b+Mmmkj7T6Hm0+ISN9YpR3E/d+r/vrEumRcK4ZR6FIBwQNISrDU5rcHVg8ht7AJmZVaIg==;5:znbXayKmB5OCtQHgCmeUk+dJdu/jrx3YycCMjMBs4MCC8JBtJQVjWz8hslPrL7ioArYCxvkLFaLWpsF1/zbfY+0oFPzu6hCAy9/izEiwUM8REWTuURxf9Tjzj+GSgkjW9JplbPAl2L/FTyzHhtLr4cxsum1Qkv5InCc27UTweNo=;24:7pg76y9HqYLV70V993NFs3NaX+WrKsmb9iAqahANaHQWVwc28KCHTjEH4sON0Olsdm8h+AntxURV9gl/ZfTdwdQeEomeF2EkWevsiaxr4AA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2643;7:W6XqAzq7zwmwaAAxaeEb2WbglAafKvKMCDukzEGMrUOOl4LutI6+jCkL6VJRv8taUaFljiKTo3Lj+qCBzC56Tu177QtO1w8XGS/wAcu7vxYOP1KrI3cEoNXdAiuzO/YesYUex0ZpffLx+Vz2lPAXlrPxLwJtdeUVbhvUi5G/1u46vI/aN/1A/P98XU8XFqi5xrXPnrrNL/MTysrYhX3hqsIjy28FJ+U2hufCDooWtEPpMy9CY1BsWNFX7JJoSt1d
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 13:12:03.0494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09de18fd-8996-4c46-66dd-08d5dcf8bd90
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2643
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below kernel-doc warnings:

Function parameter or member 'maxlen' not described in 'xemaclite_recv_data'
Function parameter or member 'address'not described in 'xemaclite_set_mac_address'
Excess function parameter 'addr' description in 'xemaclite_set_mac_address'
No description found for return value of 'xemaclite_interrupt'
No description found for return value of 'xemaclite_mdio_write'
Function parameter or member 'dev' not described in 'xemaclite_mdio_setup'
Excess function parameter 'ofdev' description in 'xemaclite_mdio_setup'
No description found for return value of 'xemaclite_open'
No description found for return value of 'xemaclite_close'
Excess function parameter 'match' description in 'xemaclite_of_probe'

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes from v2:
	- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index b2c7afe..a17f0b6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -369,6 +369,7 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
  * xemaclite_recv_data - Receive a frame
  * @drvdata:	Pointer to the Emaclite device private data
  * @data:	Address where the data is to be received
+ * @maxlen:    Maximum supported ethernet packet length
  *
  * This function is intended to be called from the interrupt context or
  * with a wrapper which waits for the receive frame to be available.
@@ -488,7 +489,7 @@ static void xemaclite_update_address(struct net_local *drvdata,
 /**
  * xemaclite_set_mac_address - Set the MAC address for this device
  * @dev:	Pointer to the network device instance
- * @addr:	Void pointer to the sockaddr structure
+ * @address:	Void pointer to the sockaddr structure
  *
  * This function copies the HW address from the sockaddr strucutre to the
  * net_device structure and updates the address in HW.
@@ -638,6 +639,8 @@ static void xemaclite_rx_handler(struct net_device *dev)
  * @dev_id:	Void pointer to the network device instance used as callback
  *		reference
  *
+ * Return:	IRQ_HANDLED
+ *
  * This function handles the Tx and Rx interrupts of the EmacLite device.
  */
 static irqreturn_t xemaclite_interrupt(int irq, void *dev_id)
@@ -771,6 +774,8 @@ static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
  *
  * This function waits till the device is ready to accept a new MDIO
  * request and then writes the val to the MDIO Write Data register.
+ *
+ * Return:      0 upon success or a negative error upon failure
  */
 static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 				u16 val)
@@ -804,7 +809,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 /**
  * xemaclite_mdio_setup - Register mii_bus for the Emaclite device
  * @lp:		Pointer to the Emaclite device private data
- * @ofdev:	Pointer to OF device structure
+ * @dev:	Pointer to OF device structure
  *
  * This function enables MDIO bus in the Emaclite device and registers a
  * mii_bus.
@@ -904,6 +909,9 @@ static void xemaclite_adjust_link(struct net_device *ndev)
  * This function sets the MAC address, requests an IRQ and enables interrupts
  * for the Emaclite device and starts the Tx queue.
  * It also connects to the phy device, if MDIO is included in Emaclite device.
+ *
+ * Return:	0 on success. -ENODEV, if PHY cannot be connected.
+ *		Non-zero error value on failure.
  */
 static int xemaclite_open(struct net_device *dev)
 {
@@ -974,6 +982,8 @@ static int xemaclite_open(struct net_device *dev)
  * This function stops the Tx queue, disables interrupts and frees the IRQ for
  * the Emaclite device.
  * It also disconnects the phy device associated with the Emaclite device.
+ *
+ * Return:	0, always.
  */
 static int xemaclite_close(struct net_device *dev)
 {
@@ -1064,7 +1074,6 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
 /**
  * xemaclite_of_probe - Probe method for the Emaclite device.
  * @ofdev:	Pointer to OF device structure
- * @match:	Pointer to the structure used for matching a device
  *
  * This function probes for the Emaclite device in the device tree.
  * It initializes the driver data structure and the hardware, sets the MAC
-- 
1.7.1

