Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7B8ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D812086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="B3CjUCgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D812086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeIYS2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:28:31 -0400
Received: from mail-sn1nam01on0076.outbound.protection.outlook.com ([104.47.32.76]:30160
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727617AbeIYS2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L3yQzsCP11nu+T0f7VKWDJI0Qlh9s88ey0STRs6Luk=;
 b=B3CjUCgWULxEK1e/+W6TanXG3mjjPt4byf0f+6Up0qiwRvvBd7kE80TTckxHD9c/Pj6q3/Eamlwhp1zCwtI1lzxrStIKxoiEtVgY25DOg8KkbBGPCU5/3BedNSaRG2mSFUHLssig8XlPC5bx6368Fbxv8/TKTYXIWU6e8QMTr+0=
Received: from BN7PR02CA0014.namprd02.prod.outlook.com (2603:10b6:408:20::27)
 by SN6PR02MB4767.namprd02.prod.outlook.com (2603:10b6:805:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Tue, 25 Sep
 2018 12:21:10 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by BN7PR02CA0014.outlook.office365.com
 (2603:10b6:408:20::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.22 via Frontend
 Transport; Tue, 25 Sep 2018 12:21:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Tue, 25 Sep 2018 12:21:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKy-0008PF-8s; Tue, 25 Sep 2018 05:21:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKt-0004sS-5Q; Tue, 25 Sep 2018 05:21:03 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8PCKsQd007563;
        Tue, 25 Sep 2018 05:20:54 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1g4mKj-0004mH-W5; Tue, 25 Sep 2018 05:20:54 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <boris.brezillon@bootlin.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v11 2/3] mtd: rawnand: Add an option to get sdr timing mode number
Date:   Tue, 25 Sep 2018 17:50:30 +0530
Message-ID: <1537878031-22253-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(438002)(189003)(199004)(11346002)(478600001)(81166006)(2906002)(186003)(9786002)(8676002)(81156014)(336012)(8936002)(50226002)(110136005)(54906003)(106002)(77096007)(26005)(316002)(16586007)(5660300001)(7696005)(51416003)(76176011)(48376002)(6666003)(50466002)(106466001)(217873002)(47776003)(36386004)(476003)(2616005)(107886003)(486006)(426003)(4326008)(446003)(39060400002)(36756003)(63266004)(2201001)(305945005)(356003)(126002)(34290500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4767;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:owucEd62TXhhp5B+eaVuUOK5HHKAkqNtsKEFy8crfztlArmE/BsXpTR3rkhaxDP/JPUdwO5oJNjUAuda+kDWSc0p1+nkeImDroZyvUkAT40+8s8RycJCEDlpJJNfoYR3
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fe758b9-0781-47be-d6d3-08d622e16045
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4767;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4767;3:Y0/VM19xlQG9xEqSFOpyDgyJQeLQ7js5YBWE8x0SvMtHLNl+4Go2gSiTuvC7k/6ksWfm5Hrt56UZ6A8ji0O6v+qTClOJiFg6wK/D0cpXKnPYBXoNUlIDwnW3YS0nCXWbV1Dhkj529uHJPRqsC+/EJxZcIKI1CNG3HvaD/7Wso5cVEun6CG3L7URx1UNHoynmsGJhhTebs8Ur4hPIHSe7+l+CZZ69oV/3KKB27WIMbS933VXWTQX6L2Niq6EyxhDGDPKjnEAaPHOaCu4XOzTXpnmXmQXNm8RoLL4OGkiwzGn1IKH1RW9LYYWqdtZ4h7MjMGuChxvKW0jsDBHUnzNX7FThllEdtJorp1WHPrhUD1g=;25:JhB33Llv/jUz0efbuGmtR3l2KVkcLYEwxAYo/pzCPo5pE6N3sKidLcsmhFxYu6iQMEzYM2EqQW5Lu+kaQE+erqXRUvZ0M2kYMMWKm23c2+SjONcNSh7UknwsFw+sGWxnoZK20gOn6wNf5f+9iAwyp9CwmKy5IzKY9xkk+OR/0mWh7GDBTZwabOojUSn6we1d4S39264LUBHSMq+XhOo1GWHM5uqSOVfIEdbddH5849x/9TJT5ga7knSh5jy0zLnHFDa6T/aVoLa9tfqly5gNvQo+nSCw+7M6tvJdDOV4ZiDfuW8Ca8WoPH9gfCiG3SWJJbXUlkicvo/VHqvqiK2DqA==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4767:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4767;31:ikr6S/gOEPsn6U4opacxHf5B0f2VJXGsrwPO4gweAPiVsVaeTDQmqJSG5mEP6dXlmbogt0yo0TN4gUoLzO3pKIBSsE+ePytP+U+uuPlw1WCcKLovX+3skJWkAgOgobZAQGxSACjGEvYQdQE7Be2S/+iwchGdD7XnZNDFHkovQAtaHSFg7pu5pkMrnyOUNCZ2/RVayn48nWFSUWB/TZ0Q2cMm4/bNwxL1AEYTGkpmCJU=;20:KQqWHRokgN2BFp8y+MjAkZRhXhCfaYfnW6e4azE7HlTGQlyCspCVyFYe3jzjrDxJ9eJyJb//XcTXzIvf7xY4VJtuzsw2zbQpLMtFkwJXBNihrVxTwae1kO5Zn91PRMOUDN4a2SsP93tttBaESZLwV9ZeFmp9kdLh9depMTBD+ouXJZT7k4Fv/ps00y03MR01zPiS/E2adfQn1MY2dOLCB3aEx2X7ZJ+FYOObnJnP5e40/bWjp/i3/gdMu8lLUsBk7b9tAw+yTcvuOaB7rkevThC3c9OAvPn2aZcFQeupfh4PMPdfM2WDu8sDnRFPUfwYJxuXdazx8vrRKfyddBoGLhaKB6o5XT+sjr7/yEyavltcXbjzDkpQSSzlZ2KFFE9pjK5iX9yVJxsyqapEmDKkUATtR6ja31ZHPYcGD4DgLygjKivYPnLMsJKh70qwdeLCBtdACFTQECEOFrO/WP8rnecIPwcssGTJRfCGdb2O38ND2IatUTq+6Hfe0cQe8gIx
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4767A647C2CBCBD544FFDA5DAF160@SN6PR02MB4767.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(163750095850)(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN6PR02MB4767;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4767;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4767;4:FGj7vlRkfZy1y68sCSYAM8IG/NipE42rJh7zcTkZ3PoyTPtLF/ASQItaK73/oBaT0lJb+foUwm3p31KFMhnRjpi0MFWkz4fLs6V/8ITuGxsHHFeE110RQZj7YVyP6uRuyNARv95qqRBKTn79qXmjxJYRMe+Fp5KnHrCx/BDn4XHwlviEeTY8u36m01RO31VliYHFqFwZVkeyq+JYs+hWPOGxfDvWbvMCiYgx+DV7Yn+3kKSp+w2j9dbX8E8sIi/p9SJnCLs2t2VP1F7FENULXgHMtVA6Bn273aPyz4RsunoNA8Z7b7K+YcdmPyWAI9FsIUZt77Jd6IF8wOsMcZhe2iHPcNFKlDxDMWj3KWUe8+Y=
X-Forefront-PRVS: 08062C429B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4767;23:3EDDVlBBvMWEwUiK/dtLDLFEviCLUf+etYsxOLaHJ?=
 =?us-ascii?Q?CO/ckZtz/MLraG6kFHqp3862Nt3bdpdlW13x4mQGZ4Xxl7VB0GF23rVfw3cr?=
 =?us-ascii?Q?JkEuAKyTxi8g1a0JP29B0PdUcBUb+JvdCAv4fBXIrC17vOkVEl+TaVaL4he2?=
 =?us-ascii?Q?wJSvxOBy70amvCq6wzG5NOjysVDoppjbByrlPw3aXZ8ewWrbEPyBYB3eteyW?=
 =?us-ascii?Q?kn89U74wtGSDaNUBTlzYNn12pKyb9Bk9IzTV21yDB7EwEadU7gJorugu0XmM?=
 =?us-ascii?Q?8StdkHZtfZ1eAmEEqf8SzGNAAXowKZhuiT9kFssyOPZawiaL0exeNMXtlBlA?=
 =?us-ascii?Q?zA7golE/ylyy2jiJAan9QNxr0reB/nhbBQkCVDSOE+1olFOLwZhVoqeEfoXw?=
 =?us-ascii?Q?L7EAWMM7wJE8z/DmFe7BNm8RAaBMamJW4oFR4pnGEfhROIcWhfR+wOO9s1FI?=
 =?us-ascii?Q?ZozXGXv2KUBdLgXj/GdtezsSxdZFAT7tN37vk2vzW8Rb2umahsG9Rj+UTB69?=
 =?us-ascii?Q?QhQ2mjEtYi3BfQx0K9VTaWnwCsWtrWbemy/vNDskhDkTY/n3U9eX5EFbHdVM?=
 =?us-ascii?Q?tugN8bhCggtvc4opWZmPyRvoB5F4lyC1ErMpz4L/+v/N1/QCqnGjBpR8moJe?=
 =?us-ascii?Q?9KDnMHPoWrBHo72t3F6o3px0qQMwNAZTcfu+BszYFRYzuQHuVeK6qesTvQis?=
 =?us-ascii?Q?zKrwe262L+mxZpsFpL/mzms3R+dJqStKhjPgVI4O8lZe4RXxVf7ishtKWZAI?=
 =?us-ascii?Q?GsT9bPmaKfhFqYe+Mue92d1infYA6Fcxn6utBRgQvypQfhQXGXexS3OMuH4C?=
 =?us-ascii?Q?S0+pJHKLsAHY6BZyFejeaANrhc2TwmwfZIBZSvi8JAEPB9qtY6pxCNOgKKYq?=
 =?us-ascii?Q?745dCa3UmztPwDqpJvvApdc8meOc/5pPHJfaGd4fv2yFu1uSigQJJ79hHXWb?=
 =?us-ascii?Q?AEqbZZ8vjmeb+ffcEX8u6fVsyePm7t2uvrgL7EY2SQ7q44ldDQDJa2C9RO7o?=
 =?us-ascii?Q?o/Qweg3tn+1fLqBFHkgIMUNSwG5ckE0eSAEm3A9TxaAk6ShHVxCK9hamoN0y?=
 =?us-ascii?Q?gbyvYE+1CDG3BdSckxFjtGIMMlmWT9Bs7Ns+3WMQ0yYLsl6Xuwynsa6s59Q7?=
 =?us-ascii?Q?APxRLFF2sM8PM94Ddzj7OfELGq8tCw/NQNlrCBa6gS73gnqFJUAn6B69KEdV?=
 =?us-ascii?Q?4KkQM22g+043QW3CyaUtEY4fIwSqIHkC58E?=
X-Microsoft-Antispam-Message-Info: QSDPzCuKEUvT/5gFlydz1lpebQ5ge7U/jBxsUs4D2Z7BFCMUORYjX6CIMAnk7iP82OotrsoPnpaDn2l/ioZT4rTAFfzBL3JBrO7nNgr39dfajD8ez4+Hp4wzLge8LpiyC7uJ9yL2wEsiS/zRYdtuaaeYcyfjolDPJz9cu+M2fkRMjpmO7RigFZYhn97xscovUSM1o4+BN3THOEVf1oT/X1HciDX6upWJOOB+Aydo6B6YPfSNwI51RaRksUzPjhcbuGc3K6PQi89CupYPijCMB1j+5rGEISR64QZW/Xg7U2O4YmqPj3dn7zEurHCQ6KZF667qrgk3xK/9v21+swDDTKm7y8cw/EcxEk8sAqZ2YTs=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4767;6:lz7PNqX+NjiVxS+Umec5UHhqEzll19N71fyTn7CkhFcb74TFBkWzePGrRmfIaAplTDBNEithwepjMAr53PMIJM7Kvmmd/CHjXah8N6T6yO/NMfynMMOBY1yx1GIRWtSg+LGNExbPyjUjj0xjkP5B+F0TxQ60JSESkFitHn5vbw6U+aXt9Dq+jW8hRkU8PtdcP8CfSQNP2cHvOA7n0DUQDRYlN86FfR0d7zXSMwgtSTB6ieIiHlYa82kR9S6eNZMmUwLvZNnn5xvEh9vISQAhNs9d7xe9oK1c1sTng+43VTWFy04RhmnFG58HzTwQ7hDlF64/eWGWBaaYyd4tlnYdtTwyTiLgiggS7FJnmfileaICgLOFGzdSjo4WYNQPVmgnHwkOjuKY7zYi9Ugy/s5+JCiNnzA1ffDjMwIy7esSGa7cWO6wweSp517gutAv+avxTxoV658PMM/6KKaosvtTnw==;5:sETl4LKB0pGLMAqaur8luM7cFH7JB39fTiyL238Lpx8vgdsnrnlz9QI5GuI8sX6MxIb9ENPn416j55nQwguco1pbbQqsOoSMIOEKFiZAQmIwMHhpz1yTgnzBiG1/ahqmxL7sVvD+7xgzy5BdMkPKUJMN5lSMcclb3QBYMPghKqI=;7:rd3VYbxbuLVMSUVO2tXww7TMO1IGEx60ymz1t7D9w+L37mA6572pwPaiDTy0a60U15ASLh0DwoLVjjJQPURQLEpSx1nWaWoCWqMfEx+kzfCwa+IBWMxjZMhMNqvi0XfFWh+rrcrW7Oh3ae+gVxT8xr65PqiiLD+QLLNgtOyldAYJIXvS0Lw/1DE5WASS72mbi3OurHDXG6T2QktMicqbNhJLv9sR5x8lhy9+BeH+QeHP9kwTnkFHT7qZONQLjMI3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 12:21:08.7522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe758b9-0781-47be-d6d3-08d622e16045
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some NAND controllers needs sdr timing mode value, instead of
timings parameters. i.e the NAND controller will change its operating
mode by just configuring the sdr timing mode number. so add mode parameter
in struct nand_sdr_timings.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v11:
 - None
---
 drivers/mtd/nand/raw/nand_timings.c | 6 ++++++
 include/linux/mtd/rawnand.h         | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_timings.c b/drivers/mtd/nand/raw/nand_timings.c
index ebc7b5f..1ec7a28 100644
--- a/drivers/mtd/nand/raw/nand_timings.c
+++ b/drivers/mtd/nand/raw/nand_timings.c
@@ -56,6 +56,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 120000,
 			.tWP_min = 50000,
 			.tWW_min = 100000,
+			.mode = 0,
 		},
 	},
 	/* Mode 1 */
@@ -98,6 +99,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 25000,
 			.tWW_min = 100000,
+			.mode = 1,
 		},
 	},
 	/* Mode 2 */
@@ -140,6 +142,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 17000,
 			.tWW_min = 100000,
+			.mode = 2,
 		},
 	},
 	/* Mode 3 */
@@ -182,6 +185,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 15000,
 			.tWW_min = 100000,
+			.mode = 3,
 		},
 	},
 	/* Mode 4 */
@@ -224,6 +228,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 12000,
 			.tWW_min = 100000,
+			.mode = 4,
 		},
 	},
 	/* Mode 5 */
@@ -266,6 +271,7 @@ static const struct nand_data_interface onfi_sdr_timings[] = {
 			.tWHR_min = 80000,
 			.tWP_min = 10000,
 			.tWW_min = 100000,
+			.mode = 5,
 		},
 	},
 };
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index efb2345..3bf2cea 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -723,6 +723,7 @@ struct nand_ecc_ctrl {
  * @tWHR_min: WE# high to RE# low
  * @tWP_min: WE# pulse width
  * @tWW_min: WP# transition to WE# low
+ * @mode: sdr timing mode value
  */
 struct nand_sdr_timings {
 	u64 tBERS_max;
@@ -763,6 +764,7 @@ struct nand_sdr_timings {
 	u32 tWHR_min;
 	u32 tWP_min;
 	u32 tWW_min;
+	u8 mode;
 };
 
 /**
-- 
2.7.4

