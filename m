Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4CCC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B923F218F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="loGz2hn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B923F218F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeHQP2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:28:23 -0400
Received: from mail-eopbgr680080.outbound.protection.outlook.com ([40.107.68.80]:58496
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbeHQP2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCG4c+MPOz6leC/slTpfhVWrPPFm3TM+1o9djtGHrr8=;
 b=loGz2hn/5p/n1TdmfZ2SMyjiKODaThVUlR/nB+vw93Je5xFUjivx39w68uMzsPVbAo3ea9HkSqjiVcVCLME6x+7clM/TXaksEhesmx+ZecwT7iVG0dDLbGfyBumLM0HDVfO08ipyHLUe31gCNFhwOQkV99nisXrGUJM1aqN6q28=
Received: from SN4PR0201CA0038.namprd02.prod.outlook.com
 (2603:10b6:803:2e::24) by BL0PR02MB4449.namprd02.prod.outlook.com
 (2603:10b6:208:45::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.19; Fri, 17 Aug
 2018 12:25:05 +0000
Received: from SN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by SN4PR0201CA0038.outlook.office365.com
 (2603:10b6:803:2e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.21 via Frontend
 Transport; Fri, 17 Aug 2018 12:25:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT036.mail.protection.outlook.com (10.152.72.149) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 12:25:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42334 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoP-0008VK-4a; Fri, 17 Aug 2018 05:25:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoK-0000U3-3h; Fri, 17 Aug 2018 05:25:00 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HCOvka024713;
        Fri, 17 Aug 2018 05:24:57 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fqdoH-0000TS-EH; Fri, 17 Aug 2018 05:24:57 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 89B8C60509; Fri, 17 Aug 2018 17:54:56 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 2/8] usb: dwc3: update stream id in depcmd
Date:   Fri, 17 Aug 2018 17:54:49 +0530
Message-ID: <1534508695-12642-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39850400004)(346002)(396003)(2980300002)(438002)(199004)(189003)(5660300001)(6666003)(52956003)(426003)(6266002)(186003)(476003)(2616005)(50466002)(336012)(48376002)(107886003)(126002)(36756003)(446003)(486006)(14444005)(103686004)(4326008)(11346002)(36386004)(51416003)(110136005)(42186006)(54906003)(47776003)(316002)(63266004)(2906002)(26005)(39060400002)(478600001)(16586007)(81156014)(8936002)(8676002)(15650500001)(50226002)(81166006)(90966002)(356003)(106466001)(305945005)(76176011)(106002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT036;1:ux2pGezPFr6/HvaN4HPmJgi1VN5CAebcVJ0Y2Oc/F+lVzP0D6nj3HfOYxpDejQlJtMUY9fazjkI810yWkYwm5zc6J4PXog7FL9/esltNDidQnPBYYnw93T5hVY0QqF1i
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e5ad8b9-a232-47ac-6d72-08d6043c76e6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:IiC7SJ4PnWI41MQtrJx7vUb9bLwnrTrqsAECuAHJUhOQ8v9iV9KgJywOO7M3zjk8tCQlCn01haVpgl1O4yWfUub+BV22D1e4H+E8+Ly90mlYIUDUupPzvhE38bycAQvh1OATyDdFzeOebeDA8ctpsKNHXYQb/Xfg+2j8m+8wUgDSebGRHu/tXsbTty31/qikYM3uBByFy6vVGIjt2x6nUwet/i3gzxODShHJwdtUY4S4AT2tkFyrFOBBFcpwF6zAo1zbL7cu+02cp2cglYgKIiV3WMt6eGgrDMfmHgSOmE4t6kT9Rq+tUmjBmyGPqcrD7pI1Up5vN3m0ylNYbuc3KoNCCC1JN1Twro5/pDK6GUM=;25:vlNJDMFdxDYxb9PRQ+uEtDFDyJD/CBwrXU2fCtg3YweU80c9aGHRlzuCLtyklp+J4hH9V75OvekaDpcTL3eLZg3A/BVMyPDKLbF0yaa8IVBlcXr4ymPHK6mFalZgk+JFOk2kTckB8dstHkKLf5LYZK654eGT6zgDERFf9sCkJOWfmJGwOuMpdEMzhH6N1DEXJbyQG7a/v8TZIzcdpXjNaje80AJqlxfoYJPA4dYs1+r2U4j4yfHlHKMdpgPF40ckA/MwGliqJbmd9ytgfvCAUwFrT+E36bReold0wVQnPGGJNqJ7WI8BAtNGD1iGt/3bhX5ADoNnXTghpBCMq680Mg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:0P3SbrKUQ2h5RkKIBLG+8NxWR7/JgNccx5NBeAKrdUnxXOnE0C3qTSrIShosLVvP4AZmZ2U5580ssvrDPhkAeyztU4op76dGX5nOcznOY0wNwYYMeJaf2OVIhXATTgTOvnUNB2kW59JGbh6tRymBXkEop7ebZeQmq5xNhWosqgEc2kcronRcxq4MWQk9dd62afZJ0vkISCNdUqZYHeXxgSmu750G/saru/do7Yav1jE=;20:GKDnl9Tf1AHpcqxOPg8c/yWJ8qsacIPDkaER/6n0BhtZWCNtqDE4l27mHNKtqay9CSlD+w4fJKnw4/B/8tHn8HC1ExGb9cP5aGolcuA9B7a/juAoIaX1aWsxKtWi0bv/vRqsNd0rsRYZ9J7mV0+Q7tT1J6LXuP4yRSvoPSH4Ep1KFJ+P2gjSm/+wpp9n0utnEcjkvgVYzPP7jaWoA2S3OhIDJnxyZybKw9e1xONpbPl4zy+ITV4VwyYxum8iu8Kp6Vg0FDuoMCxuxlfFK/emXtXO28plI6ZZ/idECxPa+IUxAePI5HJraxw5N46aJcgvC2M8n/+Z1AZsdBCs34dQZoela5EoKRZRoAJwGFfbkcXUnOM/uWwOQPCiwLqkSvnnVo1n6OWHGuXxDHbW0jWosKwaetf5QuWE4sU9s8jcJyITj5zUVuE+xwwnMtnKWl/01hgo4R3zeUA0LPamc2zYZYvvRg09/Lt7O/CkqLbCdq/dRnOEz1QQmuHQJuJPHDq5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44493466BF272A939543AB65A73D0@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:HswS9TdHnWO2MN65tj8eF0H6GC1AO3zWOdZZKAEy7jgsI8IXO99vkX3ozMA61KY6DvLAykCmT8gKhSDA5Zut66LCXkYVymFnWkmYB0MM134HfU3zxI1TXGrf2ecMH0J4z5GY4OI1FV2d5rXMkmYfVyBuQ1GVeAJ9yVGV4Xyd1E14DmsEvJ1oWOyy7TDVhYQhtnUunRk1Yt9SuXkAxbjlKRP/cZ64kwL98grFmHQ5/u0GKh57zxUw9sY0jwPLGPVAlc0XIlpQQ0+EaK1ycgaoCZUZh4mRbF0ikcsQELhrmaPF2vXIBvgm4exrUkJlOG3w
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:PPJKUP35X0E8D9MHNjsuvg3H8KXokZbFcx4ObOmaV?=
 =?us-ascii?Q?SanVu+6l4qKegUbjQqvg48G0NggdLBBCCGTFjhSIgb9nZ2sPk6WaFS1VD2aX?=
 =?us-ascii?Q?PSCNWOjQet4R1bn//AWlCADPg+FBmUgaYPnadXQOGjoa9OauJa1KMfonem6A?=
 =?us-ascii?Q?kf0ETiDacQbBzCdGMwpFXvKDUcTLeFfyDes83ArJObFT9mC5qK1Kogftazbp?=
 =?us-ascii?Q?glvBrOuDgYSLLDCoba4/kEP+8pntZyYwShw4dFHJZhhFJYqxVC+VQ3e9bkV2?=
 =?us-ascii?Q?G1nImMAzxMyodparZ9rp9v+wxR8mU5sG/Rg+sPHmzuxAXZAZ2do5rHjsAyXg?=
 =?us-ascii?Q?BxbJtp7mbpfioe64tjEhpbEuqF2IAI7fqJd2e2OnaLpOjytMxFYhQuXYbMDl?=
 =?us-ascii?Q?XUH0VtEMr8RGK7FFlijGq2Cnkg7IeWe9p1B+55GDGLZ3S+ZkiUEdmYbRBpKA?=
 =?us-ascii?Q?pFgDycU/KytKeMmjEBb0/YntJHeOxcC+FZn9mWw/QgTNqY/ahLGuDMKtRuBf?=
 =?us-ascii?Q?mzKN/p/nI8COniQzwpPAkfrUwLxhYiWC85KTR2wwL8qGuk7bTRjYMP2nqvKw?=
 =?us-ascii?Q?K72P8Qbf7rV7LjE1lL9C2YD2/UnzSGJU9uvgzs4p3qga7WDCIa5jtunVwds4?=
 =?us-ascii?Q?RJnvsePjMElug/wMVsTHU/x7rrrwL+5Kv1/P/RCCpeLRL94ZvewBN09nNP15?=
 =?us-ascii?Q?SCNMVPZPMfhRhVvjVkQnGDSq1kPIIfoxyM02HN8QeR1PcXpCQeW5yen6HZzz?=
 =?us-ascii?Q?AdPt+my/x3VjhA/Q/8MMNkVkq8kie6Km7r1Zy74ceeVkYJwLgcPfz+34aHEI?=
 =?us-ascii?Q?L2n7/mpMODZ4Om9xHUiokjNwKSEozc2dmh8ilXBxO34+h0wswd3WGX+vgUdS?=
 =?us-ascii?Q?IxYzKCDZh6cLj7TfW2+vd0y0iMCAudC9oHRhSyl9kG+4tYz5R8Vq5COQFprE?=
 =?us-ascii?Q?oFALsv5U9fcN6uZWXQLZ+iMezgBiKhfZn3pUE/fZM6FDPryalbJhQ83s0A1y?=
 =?us-ascii?Q?6h1pWl/Ujc9NgS4MzDZIYaq/f2EzL7wgXsGwdukQhGus+aY7UOm81QrVdol4?=
 =?us-ascii?Q?9e2MSm4la8Ku8RLZ5gphn1uzIVbXU88lYc2EY3YSEZvFJXZT/6BqyNAb365u?=
 =?us-ascii?Q?XC3Qszpvl0HSgPfzNwDw5thCYzSONLUf3ESDVnMzm86HwHvTVHsh16BiO3r5?=
 =?us-ascii?Q?m6316oAb9RQjQHeoSyfNSzYzZbAdEWAi33hlFndQopfCARThX20arvHHufXr?=
 =?us-ascii?Q?MY0h4DrQd8JfUsDI+c=3D?=
X-Microsoft-Antispam-Message-Info: s/gRceit1dxXbgZePrLDBAU17cbV/mvR3hMfJBQqnslX2JTYtENmbTrHenLt53jHi7emOAnBU7zXhiJCcinm8vyFe33TiwABpUH22G8ZG2KQPE3eidg6/QLiFS84fai3nKLqlK8J3XkaaUcbZ9knVMafnxiBjIwMzx+iZTF3rlTyV1eh+WwrlsJbFmaXBr3UggjxJ4BznQ+a0TiJ95U3eF7YGD/YCvg8q2SEDOXgYiqHgcAfAp+/BSv94QN6vTPWTlepAO8N1Sw3zSifMKN2pDuxBXPX5B4wPk/vEcuJT0JY+cX1diu6UlhguKgASAqNWN50G4GjE3ThWXlcwMXxRNDdAVqfuOHb4DxhifGViFc=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:tv0/hqRKNeltSYQVsmnSHXMxA05DXrZeJw1DOBP8su8ZsAFj6TiedlxEI/tujOsk7W45fDO/+LR0asfIma6nSDKAHX35RySDdU/HEXaEU3ycqdGZ4bPADZlH8vCsXnLoFz5N9Cfi6KAo3KFuHQB4ibdz+q76JMsKLmom6wcNJq9uBWvV+sHLDiRrBOVOD83Y4RWu/VHyzXaSFseVCovHXvVVKGshgUeB9kPI/qQqlsL50n5inhqeN1q1UZbAzTARe86BjNYUsCdIzAupG6Cr/5xWSR69O35NA82F0hARPHKlIcb1QsRz1Tyz7XBfffJmNWz6z3uSeqMHU8OQ8gauhjLuu11YI0pm7+eonzQgjAxiLilTq7y7mXivhE7gSTwVLPVh6vpzQfw6/cl4jycJVvTpAhm00ZlY99lijSMGIGg+oUp0W5iT7Lj/HVr9vIZPa4+zqsOK9B4wheKmipUgHA==;5:iYT7V8L8Ks5E3/7tnfkwm3tmKfUUrGV/vS3UT7YuHrjbykeyfKGGFh2bNEBzegm2vJVU0Ia2i8TwFCeD9j5sSfQCd4RiXFvscrITYWKjnVHLW2ME2BOwBoPhhAxatwt/RzrJX5sZJ9pdhMeOZE6ActR2k4Fl2vV+oaRI2fT6CI0=;7:Z5Y8rGxAKt7Hxx0FdWkFmtJFKXla6C7sCKiOI5kpNYY9hoI7VZTnEN/R2f/9JiNZJJnsX/oK/ZSyweEmPeGr2Wja9ND6MsGKhc2AoBSV2Ch1z9EaWA7/hpuHEOQEfoJfvGfvhk/P0xltZAfCm89QNBmjduiRsKfedxczrOyf430YVBT+/YNjAygUubwpj3FB6XYTt5xW2S0GvawJlNVQwkj8GylCWipNL/qKoV/oZUU4MbiIb/IKWP6LA898SVwf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:25:05.6521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5ad8b9-a232-47ac-6d72-08d6043c76e6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For stream capable endpoints, stream id related information
needs to be updated into DEPCMD while issuing START TRANSFER.
This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f73d219..efc6e13 100644
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

