Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42042C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFF82146E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 12:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wTMD0LyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFF82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeHQP3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 11:29:12 -0400
Received: from mail-sn1nam02on0043.outbound.protection.outlook.com ([104.47.36.43]:8548
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726544AbeHQP2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 11:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDENqAbDNVofKmdyJzDafRqsk2UMvDhBNU8Dvr76AUY=;
 b=wTMD0LyTXl097HXArhjFbEVaJWHnHaR8jmjsPavdblxwYxBk8C45WDV1lFKS1OLEGjZzRxHtemt7GsCRwbF+f0ureaoBRhZwtsCPKdYxuMo3bILlHNHgzsDcfexX+EwyiSHvAwhQ6V+bE4ZzYwxhpzDpMoJmKvEMz0vWXHXqzbY=
Received: from MWHPR0201CA0016.namprd02.prod.outlook.com
 (2603:10b6:301:74::29) by BYAPR02MB4328.namprd02.prod.outlook.com
 (2603:10b6:a03:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.25; Fri, 17 Aug
 2018 12:25:06 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by MWHPR0201CA0016.outlook.office365.com
 (2603:10b6:301:74::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Fri, 17 Aug 2018 12:25:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Fri, 17 Aug 2018 12:25:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42340 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoP-0008VL-7v; Fri, 17 Aug 2018 05:25:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fqdoK-0000U3-7P; Fri, 17 Aug 2018 05:25:00 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7HCOwW9024717;
        Fri, 17 Aug 2018 05:24:58 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fqdoH-0000TU-Nh; Fri, 17 Aug 2018 05:24:57 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id D2E146050A; Fri, 17 Aug 2018 17:54:56 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 3/8] usb: dwc3: make controller clear transfer resources after complete
Date:   Fri, 17 Aug 2018 17:54:50 +0530
Message-ID: <1534508695-12642-4-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1534508695-12642-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(2980300002)(438002)(199004)(189003)(6666003)(5660300001)(356003)(81156014)(81166006)(126002)(8676002)(50226002)(8936002)(90966002)(36756003)(426003)(305945005)(316002)(476003)(103686004)(26005)(47776003)(2616005)(11346002)(446003)(110136005)(54906003)(2906002)(6266002)(107886003)(4326008)(48376002)(16586007)(36386004)(39060400002)(106466001)(63266004)(486006)(50466002)(106002)(478600001)(42186006)(186003)(51416003)(52956003)(336012)(76176011)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4328;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT060;1:yPWjRW5da0etNB+iSf2JacMydpsd+6RviY/77KwPSXw8SvbEeyycT9MzUyEokjmiOTE5/7pFGOBJRfU6BdexkcsQeExSo928jleMyrJhjRVnvU5P3mzQCv5TAbCOoW9W
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1acd8534-02e7-4e0f-2da3-08d6043c76db
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;3:cByNbAJ0IOqgYtp++BfFhrNL/pnzfUCzmcfF1pgeLHCnBiNnC35NGzEJXHfG5Swr9HBCb/iZEM3HySOyMzq9T3lmtQfUtzNtkxkove96AcFvAkcBpOTuYbRgBU5Gz68Ic/+fvcn4Aj/CCU45DBQ58Lin5owzn2WOw/ndG5giFW7HqraxYnl589kSdqI2hK9LoBLk5XQcZVzKPSGXBMwu8QpoPm1PM/TPKcWjxrdw7hUZDMd6HESiwuz/w/jykcqaY7s+YOjmuftzIpSl4yyGoXxGV7GcwGT38L39Prk3YenCXul2nLvV+yd57NX8wBs4Zo7bnqYmkYlrIXCkC3tfzDIgSRHtitBb+I//jYAnVp0=;25:0iNEmLOGvjnSWYzlaclHrjMQXyBtd+MEfaQxbyZX8KkUYUEKoEp9eST4Nbdz0wEsTNVdqC4Xjr+WTs2j46JpSWDOyl4lfrCsPEhgtQlctUAQp9L3iZTBSheI2U1PXBl//JOiciRmraYExJ7viW+yQGxVzHm/BiYUSxFnz4sTivk30RBDa+WA0+cQFtxWP7fIPMGZ92yd09cQxqsfDl/jXF38Z0J7H3xcXALxagnc2aSQXc5obKm/2mWfqRY/ucpizeOzjsMmc+H9x3QYpAYJzATQIX+6+Pi/PVBkrINxRcPp4UjK4ncB38bGF8GKI5qL19Ug6U0eSsJHecRdrYUbdQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4328:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;31:KTWpnQ36ZOrySZvab7zaWrz7zso4SZWUdBadxUBModPU0WMogikRPT8wdMrYK7sT9bnCqEMg/aX8DEex3/TTa7VGpg0/63iy+pt9IWr0IPNpdaV+fb3ErgURsCt+9sfwrJ+Le0ev9gNZANmtbNWA3lGM6yQTxZ0+huCrP/oeqCjAtdZLz99E51IkBBW/uas145WgxxEPfsHaKD57dQSjTkQwjxlZBAWWSO2aE9sTJV4=;20:6nJGQ/SnOtAkSOIPontzNSnKuG+zMk617hzoEQNmsGQd/taTaM6lGCua80oF8j0uFFFMfnNf8e5OciRG3cBZOFGaYKVmfLfPRK0bcjRfjbvAOeQGW01Y2ROmyyd1wEUY2GUBwoa4vKgUVoe16S51wp2xTwPsWAZLzm7QLYVJe0IUYS7Qvvd0j4cVDDCjx17vihdXXrwUgTr1PMoPr8Dehrb9HIazmjNzsGSPUz+mfzkrHDwbIyJYoRHQeK+UnWgBECB2NZEI3KpKpZtI3ZtjqwFM6jYXCXZChFJgaSdsH5XBfa9zq06MV26guOBOh7CWa8nu8u/OZWwrBY8tUz1QgpdQzmFjawDHMCHaLaA+boHb0Cul9LxtUvJOYd5eziGV643huVG6zLzixR8GEm6MxKic//LM+wjPIsBnSMq0HVQDRkHy6Z5CMu3lex+eRqZZyw3GQg86eEqwL9sHlD+JqL++A9Zlryq8n1zZb8MZLLgnXq9SYQ1DZi1pufVNKj8J
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB43288AE8F6155A6FFBC34ADBA73D0@BYAPR02MB4328.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR02MB4328;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4328;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;4:DQe0ztSsqwtC0P4m5zYt+2wp0DlodACmEhIiXSWVtYmWqQwPGLcuyWpcrNoPdKBxwRDPW/zBkzcQrOlRPNxbcXWHgQPHiayyxXUM2tPZZuLeZ3cYk/X+tttDDYZVdcUS6nizBzfnQdr/NNTdQC7j3+c+nO5WZR470uSsnYjmNdUpEAq4SkKls/leL+o0P/wVYSgAuGvMcDg5rTSV7znQ36kjct06CrhSVGQ5t8ofWiQCQkE2Qg8HOQhSQB9v5QxRsczBufkt1OcP7v1D8hGOoBus2dYym2ntEYetht5xUS+lQdEZv8pvoIz4UVyyCubO
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4328;23:lDon+Em+BF9wendBrtSB3FT9YKmC8iEZplwkWc/ug?=
 =?us-ascii?Q?/GBdyfrKnPhKI6fXyDsCPvuxkidHnoMb5fmFBbtkGbo0Mreu1M+1UMRX69s1?=
 =?us-ascii?Q?L9dz2fp5OsOx79QvulpMcVhGz+0oYObdA7FfQ6BjIXFoYEtQTLuPa+f9JWPl?=
 =?us-ascii?Q?NexrJBv/3kWkr7jjE3kyrOiktHZrPCVAjPmURCohZmOEdQI5gBuaqv9l139T?=
 =?us-ascii?Q?rg9QR7Xj2jVG9iy/aQMUmc6owrlpCXJVWqQbS53GODp3BcQmcSeIr0EvG9wW?=
 =?us-ascii?Q?5m1MBPdXqjpLPuqkXy7qCMxDqf4qId+RaqXn05sU7B/BBl6oSaVzTpUGQ9zg?=
 =?us-ascii?Q?EmeliR1QUf1xVS3yM1vhIDC8Bxzk01Va1fKiPMOSMzfruV1xn1IDnUyJPgd9?=
 =?us-ascii?Q?KbqKPRGFhewiA9VC+FUIEwCWEMJFSipVHcg1+EwOs4YIyR/lGNHseRdsPd47?=
 =?us-ascii?Q?kDJ+1WHaXvZXdkAZFUPA6FYY5zs65Nqgw9bMNPfKsFc2rl2PAjyD5RTQqsCd?=
 =?us-ascii?Q?ZlUEgTFUcSliK831WK5+geOogqE+B3uTP7ombzfSa2mDuHF88KMAYk4Zk8um?=
 =?us-ascii?Q?JMVn2tj7XwuWBPzcne46AKCqDiltX+YViwmDTUGtKpma1TI7kQO5o56584RO?=
 =?us-ascii?Q?1p0Ot9EA23FbQ3n5L5SDTUN9/GJKQHGEKi15PUcP0j1ZB0yg7HFScteWWB6S?=
 =?us-ascii?Q?t7qP0V3tMfcre2L9GpELxdT/Q+x0T5ERHotQ3+xs2fr0DZkbwCNE5Atzbrpn?=
 =?us-ascii?Q?MatFhSx4Ytywzu1gnaOKOc7TusR60+7HFhQI0fXSTAeq2ZIKosqmRJkPAnm/?=
 =?us-ascii?Q?umLXAfbjvsc8cL/5E2eoyvYXnjGV2eRqn3wAInu807ccGUh1prM3V+c3XmZg?=
 =?us-ascii?Q?BBmxBF76O8ZUGCO1Zr0oW6/2VqB+BF+gitS9nrF2XerQYljWdKgdj+ontOfc?=
 =?us-ascii?Q?OvMkDP9QQRHhR4X9zKBXR3LB+KQngi4WG23yOKZCEVbOKxtao+1+aoahbJRK?=
 =?us-ascii?Q?IvqyXb/N3m9iTqsFowLEPJF589dxDn+wbz0HjzewmEPXGcvs1dc7tAyxyx+d?=
 =?us-ascii?Q?vNYQ8Y/0RQJe4kO/j452Dx8a5sbNdQiMf8jMw6NemS8Lo0YdkgnX0uvrvL05?=
 =?us-ascii?Q?tyweYpgrhMHbj6+Ldvq7reV3Ng79DGdy74WvwV3TumYDBtCkvWm1hq5v1our?=
 =?us-ascii?Q?7Mi8fyNmCbYDHhkWcqKdIMPiOUPCaFo35Nv?=
X-Microsoft-Antispam-Message-Info: gAwg8i1js6IRRnV3ztK9SDxyZdaAASft95gWB0brYEWheTKexbKKBSX7awcdzyhwkO0uJK1MR/eD9AoA2yRZoCNLFPaSl/bXAADRURseKrh8paPd9nCdHcQ+NENsPHX9OUNbe2lepOGncXL9oWWoSGR0K0oZJRQpsbz9ltmu87CKfOUdEeDknSv2y5UpLF487KInpZuJVd8KyeXy0WXKXrIWFffswjafhg5ZT1NJ0LPn9o6ypSt5rG2STanBci/oTd4BKI4tpx+hFFo/x2/jJYZnf5KDCp0jR2j4pKpBtr1ZdCqP7apfaSmh48RTGlFHZXTMEF1yJhwDHaKGgv2g6R7XcMoKeYxnLNYBJverjfI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4328;6:cdeWXQeOFNvb3x9ceVuGv4Fa+RTe+pmAfMIqo3AbEZEHJdg10xFwDuc5ODpD63FtSKaRx3poS/61f+khIbQUvtjGmld/hVgbJiFCE14Y73bsMwmLIwnyBY88INXhfueTm4mJoX3zPOXWoO7Cg2mtSQ1yUy5yzjBDRuKhtso+MkvRTiuTacUwK0okdAPYzqi7i6SNuzBLd/ZYii+r/BhLV1X/yLkdqPwZd4OcKBBUZw5FyAKh15VsaxyVrHbrB9IqJWDJ9sYDHScAEYaEnoEa9dPHC2R86YqQBlvNyPzN2r/bQ5fYjPIPOKCkk5reiE/rY2K49FJIC+oNAT1LPUskFZP0aIn4EYvMZ8ADUKGwSiqAbLSkSFTHM0fxfU9F7JLi8GwqR6mqQlFyJNkIhXdCHvlDxtfOP+5Gr+b38ACYucyHNZLTA0gheipjWEp083JYSNMVkmFhbql9zK6PaC58Ow==;5:Vnra8t4mnZgoU8uSQtFp2eper02lnawjq1OlxPbKRxsXFtAawgTA/98FpLzdZG7eWIhDBzkDdzANWhBK85c9XmCCvYhy611efjzGxI0zVMszonQbo7j2RkIq38KMaJKMC1/GUNV59bkXYcLVqAuuK3mHYuxeUnydxwjMnFpTRUM=;7:r3cbb/Hh2/BbXFiS0RTENEep7RgXrd/5GQ5J8SoirK0uf74Wu410iNJRcwyIpFg4NSyj3ZSJjH+bsYGkbY804TXm0GXlNsc9t6FhuBOtTBG6DxZhu7wEXuIV6ZjeX4Qv5R3UMMVoeLmUN7FTW8tyTF76hiTHU3xRMcfj1KKM0Z01UkxvQSLe+p7/Y09JvOy5lTZyNDT2nJXFY0zE8Bcn44IePGM4gQSNQfjm4gnG/9zA5HBRCPA9XGuzkNcxzz2t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 12:25:05.5784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acd8534-02e7-4e0f-2da3-08d6043c76db
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4328
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To start transfer with another stream id, controller needs to free
previously allocated transfer resource. This will be automatically
done by the controller at the time of XferComplete Event. This
patch updates the code to issue XferComplete event once all transfers
are done by setting LST bit in the ctrl field of the last TRB.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index efc6e13..b3e9e7f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -571,7 +571,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 
 	if (usb_ss_max_streams(comp_desc) && usb_endpoint_xfer_bulk(desc)) {
 		params.param1 |= DWC3_DEPCFG_STREAM_CAPABLE
-			| DWC3_DEPCFG_STREAM_EVENT_EN;
+			| DWC3_DEPCFG_STREAM_EVENT_EN
+			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
 	}
 
@@ -999,6 +1000,15 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
+	/*
+	 * To issue start transfer on another stream, controller need to free
+	 * previously acquired transfer resource. Setting the LST bit in
+	 * last TRB makes the controller clear transfer resource for that
+	 * endpoint, allowing to start another stream on that endpoint.
+	 */
+	else if (dep->stream_capable)
+		trb->ctrl |= DWC3_TRB_CTRL_LST;
+
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
 		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
@@ -2268,7 +2278,7 @@ static int dwc3_gadget_ep_reclaim_completed_trb(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_SHORT && !chain)
 		return 1;
 
-	if (event->status & DEPEVT_STATUS_IOC)
+	if (event->status & (DEPEVT_STATUS_IOC | DEPEVT_STATUS_LST))
 		return 1;
 
 	return 0;
@@ -2457,6 +2467,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 
 	switch (event->endpoint_event) {
+	case DWC3_DEPEVT_XFERCOMPLETE:
+		if (!dep->stream_capable)
+			break;
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	case DWC3_DEPEVT_XFERINPROGRESS:
 		dwc3_gadget_endpoint_transfer_in_progress(dep, event);
 		break;
@@ -2472,7 +2486,6 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
-	case DWC3_DEPEVT_XFERCOMPLETE:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
-- 
2.1.1

