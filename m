Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1557CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66D92147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="B931lPJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66D92147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeHPWJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:09:03 -0400
Received: from mail-eopbgr730058.outbound.protection.outlook.com ([40.107.73.58]:43232
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726219AbeHPWJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghTCCfQ0IHN3Uxg4BQIdAKO6nKKUKdKzq1/04z4e/nI=;
 b=B931lPJJTQxrP4HPRrNAVqH1d3OleMW5Rys70UCUG+fmMC+a0bkqJXP6NgmRt6029n7k5emQhth3NIEaHmOhroiCGfnoRnYQwyk3off6FNUb6/0DC2QrGhFa9KKdVxVaHt3TY91mexdgvOnodWLkZIO+T3diZPjAVkXOzUYoCQQ=
Received: from BL0PR02CA0064.namprd02.prod.outlook.com (2603:10b6:207:3d::41)
 by BYAPR02MB4454.namprd02.prod.outlook.com (2603:10b6:a03:57::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Thu, 16 Aug
 2018 19:08:27 +0000
Received: from SN1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BL0PR02CA0064.outlook.office365.com
 (2603:10b6:207:3d::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Thu, 16 Aug 2018 19:08:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT023.mail.protection.outlook.com (10.152.72.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Thu, 16 Aug 2018 19:08:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNdC-0005ZA-Fn; Thu, 16 Aug 2018 12:08:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fqNd7-0004An-B0; Thu, 16 Aug 2018 12:08:21 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7GJ8CMT016984;
        Thu, 16 Aug 2018 12:08:13 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fqNcy-00049q-N0; Thu, 16 Aug 2018 12:08:12 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <matthias.bgg@gmail.com>, <andy.gross@linaro.org>,
        <shawnguo@kernel.org>, <geert+renesas@glider.be>,
        <bjorn.andersson@linaro.org>, <sean.wang@mediatek.com>,
        <m.szyprowski@samsung.com>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v2 2/3] firmware: xilinx: Implement ZynqMP power management APIs
Date:   Thu, 16 Aug 2018 12:08:02 -0700
Message-ID: <1534446483-12156-3-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
References: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39850400004)(136003)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(476003)(8936002)(6666003)(36386004)(106002)(50226002)(76176011)(336012)(446003)(8676002)(7696005)(2616005)(54906003)(51416003)(316002)(77096007)(110136005)(16586007)(14444005)(9786002)(26005)(305945005)(44832011)(7416002)(186003)(39060400002)(4326008)(356003)(426003)(50466002)(107886003)(36756003)(48376002)(486006)(2906002)(106466001)(478600001)(81166006)(81156014)(72206003)(5660300001)(11346002)(63266004)(126002)(2201001)(47776003)(921003)(107986001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4454;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT023;1:DeL+zQm3pV9XZriwgJW5j2MdaX89LbRTjj+aQ7Cd6asQK8pvlGVYKw/i1xciHnNb5LCAaLc7sm/GKPe+ai1MEQqw0fX4nslghaocK4ROaML/ygAsf4Vs5YgGSjPVgwSy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8ae9467-e8d4-46a6-ba2b-08d603aba5a9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;3:nXhrKvT/oZ1WhvWzjwBSLv6fHy7rNUg3WPQzD05xsqvncie1baDgQeKNHtRQPaaRHY5I0fqcHzFVLX9vBFCJ+4aIdgCJYYdINxfLQbJFTDWV9c26asl0UO4hH1Xkzm1IOT3RH4VW71TbN6S3xMNh1A8CxdqoTcma1NpIzoK+Qz8A2UskMlRQSqsIDQcC5SVBVsfskHqvgUDIKwKa6KbE/BnIR46+dEq/5Ds9VHcgV3RXhkDy8627PHI+oorhmVFNfaxcx+hzz0z7RzwyoNWkThvfYtWRBDN+rjuFQsE5J2s0PofhJnCmiHAM9gHBQZl+l2Mbkg7p04A7MSMOGb7CP6PQj8yy6NKmJH9y4okAsto=;25:lymJU66F3oGWFJjiZ17J2HLXzdIEUtH3J+ETMsrn4LuOMH44Kn4WzYYA/X09gIAUPAhKYp92SiWOvmuQE21L366A8zXeZGIybAl0mQW6GS/Ff4NopYXXqA/uNcPVf7t37Wap3jh0EGt5fIPKeBTDfWHQw7vUkIEmjmJpIodx0h5LOqG2FFCnH7I2E9/2tF3i8A0W/4KqZBgmZKkLlfi5y3u7MGwBpLYXLFqb+2qcW34OeeaXe8eYxs+zhJ2uby6utlfuaV53JsI5kG31jiTWTHakeWW+HcxgiTOXwQlq8kL7XSmXFoxpWIAnYsTOgYoDbkc2ik1h3vN61huo8HefaQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4454:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;31:voZlRR/bww+3IwF2OL0BQErLIsrRFaxhl8+m2cTFF/YwI7MjUWQXavAfs9mzX3kkfKVqU7OhG+9u2YsL6Cth9wEqmlmqoHvqLJiE5uZn2ZrvOYLmeK6SuqNEUqRrUojFEtBDk9czEwD6H7C6eusPF6KgZF23AJx+H4iMXQN7/wRNQP+3V+XQxd91fCbRjgsX/UxmvdU5Dc11pg8EWSnit6Apez+W8fNSULgVh+tqTbc=;20:ZrxY7pNBOhPrNy9nueejEAi6Nl6G6MaBKTiDk7jYWT616EhH0wdZE6AApXpHOo+6LEo1wJJuOW30IL235OSRxapsJ7zIbu12JFO5W8oOLMSOZj3cDQhV+yaAgSubNe+pXaFJX97Fs16fmDxvCc34PTthmmbvIbL3WNHdIIyKGcU9tdHyEu//iz+PVjc79nTTHf0R/4av/lbhslQC/2DQt4PAs5IQlDxIS3I+9w60ifTi/T4Y+JnZ1WGHx3cKOrHPlUuYK7AxwA97JRR28SkTgUu0z9pX2XXdS/E0pCUQwEAQc72jJgBQ2nmx1d1vPr3+bJw7cuf1Ooe9JmJjXiVBec+VmcLTZMDa4IpVfMBgOK0J3MPfIp0dhWk6J2/oB9MPumSAjK7hoiptK7UQWAd4NcGezaMwWLJgLDpdVViNs0dLudMqbBq1SP+WVAXtLFvexDZb6Byj3rDjoJO2DeTRI71wuVXXZJCNISN5R9nNIZX/Kdwg8C8fFogpvLIEwMs9
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44547BA6CF9D247A7745713CB83E0@BYAPR02MB4454.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR02MB4454;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;4:hptx1fR8Ff1LFrhaA62MPQ4mmLbkgSFCmL2pK4s7wHY7Coq9/NpiUXTGK8+lpEWw7rbHhIJJ0Hnux7BkZu703ZWqE9ZFVRtru00ScJqUUyC0rHkTxv+Wa2OuAueRDiFDSDyoTLLf7755gp9e2xM51/Mp0b42mV+IBW+IwGyleYYhqldH7xK1SUgkx8cvKk69eYHjnFQFk9Zpe6CHa1o0VW2q1Eh46lt6qmcCooOYExr0bD2ZrmOjqPq38nzsBp8oJQBPvvToJgzH05b00pJYKdcEzUYycuU9aiS9ddkE4r7ioQsCkjldfL/PQ+CvEhIy
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4454;23:fT90TJNWmarW5depsRMRJ0PFi8cZGdKAQ0mV3BZLq?=
 =?us-ascii?Q?gd8lGgS8A5w/pJvXyQEXM+4zDS/cadwXbyR2F1rWd2hIUXGEcQyDzc/Es/ji?=
 =?us-ascii?Q?skhN8IuebYZWXBgFdvoHkJTyY7PNyw+rqCQnxZc1Ya3rkfYeg9foIeR4GBdm?=
 =?us-ascii?Q?iQM5xPsHvAzmdrqdRwUUgUvyxMvifDVIhJEKExNErPMOiq0a0txe9TtcIXQj?=
 =?us-ascii?Q?dJUubq5GzptA9EigdSPQgysX7Hwo1ovrcTu8HleX40NbPN4MVBwwcRScAaFe?=
 =?us-ascii?Q?Z1xll6GCfJ2ENliPQlxRG0+2axH93OXwY/TugIXKIk4z57rOUFSu0hmjdzLr?=
 =?us-ascii?Q?TjrD8CnHKiSM82RNxpLQ3WFQJHnycqIPn0Uakr8pEdtiLPlXwZxdDvHB4ATH?=
 =?us-ascii?Q?LJUCzJT0xJu0cXGPAcD63N46VHr6VB5SmXYSSVdRxYry7Ec7mSFrfh3AxcS3?=
 =?us-ascii?Q?0iUHsEkLpERd4feaPxnbdb349gnhQ3MwCoRyoC0qin06tkRmppx6iAfGZLz+?=
 =?us-ascii?Q?G+Q35NWwPBb6c+NWgLEaHDj9bHODBcMneQxrPRJ++Kf6GDmKPf/1bnxryuk3?=
 =?us-ascii?Q?/oRQpc1QGwLrXA6j7+Oi4itgAxkAkN0DSreCLrK+l35Ua40u+F/fcqHNaEV+?=
 =?us-ascii?Q?+TXfu2+VaG7WHCmB4TChIC+Zk34ie7tTn5x9MQA8Li2ywtAGbiECnFnpg35y?=
 =?us-ascii?Q?FffRqEw+WUBuIGXErEuwiR2BjnrqLnOLBwY0+SEArG+UNWbAbP1NKL7UqsYd?=
 =?us-ascii?Q?yzkq4aGQr3L4/mbVNHA1waPRIe50fwc1VcuXmqlPY4wnzrpu/2EH9s618mCb?=
 =?us-ascii?Q?2N2tVrHiLKWt6jj2IC//dsu5wORBZrDbVx/OO8B8CR9ZwbobVEne2u6pg39T?=
 =?us-ascii?Q?Eh95CqtigTV4Vqe8h6R9mPA4QZ2aYGR8hrtzKoXu2QHJS/PBzP7oBxFZULPz?=
 =?us-ascii?Q?74RO3+S/yUrafujoE0Sx+IgC4gigHnUKONGCzM3WjAOb9ZDFMSMhu02a45OY?=
 =?us-ascii?Q?tfEZ7Vdd3ZL6Fu2y4Rw4X2Px7NswZNYDqL2F1HaQvlinLJwfEoBswiXzBavM?=
 =?us-ascii?Q?arF1ulqz2n5Yw43XGZCiLLLQH1sGt017ad5h6QIR36eY8QJ1wwY6za18l0mj?=
 =?us-ascii?Q?HvEbj0rDXUjQJBYD6adEGGzIUs0Arf2MdfC2RDnLp7YCxLWQAvywMYUusVYv?=
 =?us-ascii?Q?6gGcLaxa+Lh4TFGw1KHxbsos1tQ0g1jW/mZ65qwEI7p19CBewZZ7O3Ta593f?=
 =?us-ascii?Q?Kzu97u6BBw2VCdr9WpHve7zvnBNL/w/mVvHrgHe2CGceoUWPVMvBqVaC8r9G?=
 =?us-ascii?Q?+G3Uv06VXOf5EqqlCQaURs=3D?=
X-Microsoft-Antispam-Message-Info: E1/iVtfJJ8P6zuDfK0uT57Tguh6WgFLVHItF3eqFiWtSNe+p+yIlCM5IUIi9TJ4IFpOOeFOBAvUqKhgl429CM/cs+7ANYc112TWSKlHp43tsD5jr3zkKxDYxcsEmogqvm1Tp8dTD0se4zeRJwR32+reQBIIH8tWGmu/TgOhmihqcb8a+HGBcLvv1BwmC/FNTZCv+1cu5m5q2hOep/c1uz71bEG2HAy53uhVioluCWqV7//Truvi/9LYyHkeMbF6vkI/lP42BHY6MhhsJo62vuXsFuB11aoXJtscXKqW44b+imxETuGbXZfhu8ljaXWQ90p3k3vHK6yFp3NDlfXsc3jKv1ksrBbz+nNL4qt0nWhA=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;6:ABnPaExny1TvZuBiFX2Kg7EdfN7mFH3WJ1rD+uatucJkMnEMo5DXO6nMRFx6q+nzlZ21Za0Tx02Ql+sUmijWtEgFqKYQn99Ble7D4/HkHk1NEnDL9g0WiGJdsynAy+0zZqpzT0smdlFNKBLPWdXpQOow8WRSB3GPrZr8itOeTpAq6BUIbwaMT9Uj1ppHJC4rtPJDmBOeJVFaKncc02hk+mzYN2opRhHKCtpV4EL4aXecXbfm4EKcIMHrcP1QYaAIJsCLUxSKPPeX3pDhUGG45Z3/WqjOxQFkVrWetmte5cPokvQ+6pq8+bwp8jhJgodkeT302NIMALVU4bbJex/MGVdXrEyk2psjSM/OtK7ZUu/Yr3S8Y2lJvYSbs+baOppAPcymM09vA/A2BsXhpEgiqFp73HH5fOvuupR9+GH5S4aVkZKJT6CqGfLs2Af0yU8ZaSkatDj2WNPvX/hIM2ax6A==;5:xHchwYNzT9n8fH4+vceJdCqu6IOeFMSQBKiecEDznnpaJL0xTNNz9RjdG9HqDb1U6ze1JgoMUUq5OJzQNldIDaWE2ycdr33dMVBMeNsi8Ki85yLvRqftVz20DzbruRC4rtbfQYzo/SNuHBaxt5s1WJ+GGsFxrPMfc9fQr3LPtxA=;7:0g4xME0dzLDOdbT9yIhENpERhdbUdpuFn2GgSjyrTZinEjxsEL1alcUZfdzcs5w1I8Elfh9Ng2MALwBTDuEQA57UMkfCoLqFupwTRYqcs1lHBWYlQoBghfcSYoVrOaRxh14wluVEFU4rSL2j/VTXjdEnOYfoyS4i4H6Vx/RYzjVifdTLd0JlkI3fYUJ01NPSbqpN2NGlFXTHfEGPXYaZ7wuOL4c5XFKUvVwCdyRH3RSdlmvWVMuGtgeC5KLmDCSz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:08:26.8314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ae9467-e8d4-46a6-ba2b-08d603aba5a9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add Xilinx ZynqMP firmware APIs to set suspend mode
and inform firmware that master has initialized its
own power management.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 29 +++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index ce6c746..97818e8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -447,6 +447,33 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 	return ret;
 }
 
+/**
+ * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
+ *			       master has initialized its own power management
+ *
+ * This API function is to be used for notify the power management controller
+ * about the completed power management initialization.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_init_finalize(void)
+{
+	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
+}
+
+/**
+ * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
+ * @mode:	Mode to set for system suspend
+ *
+ * This API function is used to set mode of system suspend.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_set_suspend_mode(u32 mode)
+{
+	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
 	.ioctl = zynqmp_pm_ioctl,
@@ -460,6 +487,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
 	.clock_getrate = zynqmp_pm_clock_getrate,
 	.clock_setparent = zynqmp_pm_clock_setparent,
 	.clock_getparent = zynqmp_pm_clock_getparent,
+	.init_finalize = zynqmp_pm_init_finalize,
+	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index a3ef7d6..fd8f99e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -28,12 +28,21 @@
 /* SMC SIP service Call Function Identifier Prefix */
 #define PM_SIP_SVC			0xC2000000
 #define PM_GET_TRUSTZONE_VERSION	0xa03
+#define PM_SET_SUSPEND_MODE		0xa02
+#define GET_CALLBACK_DATA		0xa01
 
 /* Number of 32bits values in payload */
 #define PAYLOAD_ARG_CNT	4U
 
+/* Number of arguments for a callback */
+#define CB_ARG_CNT	4
+
+/* Payload size (consists of callback API ID + arguments) */
+#define CB_PAYLOAD_SIZE (CB_ARG_CNT + 1)
+
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_PM_INIT_FINALIZE = 21,
 	PM_IOCTL = 34,
 	PM_QUERY_DATA,
 	PM_CLOCK_ENABLE,
@@ -75,6 +84,12 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
 };
 
+enum zynqmp_pm_suspend_reason {
+	ZYNQMP_PM_SUSPEND_REASON_POWER_UNIT_REQUEST = 201,
+	ZYNQMP_PM_SUSPEND_REASON_ALERT,
+	ZYNQMP_PM_SUSPEND_REASON_SYSTEM_SHUTDOWN,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
@@ -102,8 +117,13 @@ struct zynqmp_eemi_ops {
 	int (*clock_getrate)(u32 clock_id, u64 *rate);
 	int (*clock_setparent)(u32 clock_id, u32 parent_id);
 	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
+	int (*init_finalize)(void);
+	int (*set_suspend_mode)(u32 mode);
 };
 
+int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
+			u32 arg2, u32 arg3, u32 *ret_payload);
+
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
 const struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void);
 #else
-- 
2.7.4

