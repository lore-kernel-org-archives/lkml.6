Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382B3C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC966208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qdS4D1eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC966208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbeGaT2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:28:11 -0400
Received: from mail-bn3nam01on0081.outbound.protection.outlook.com ([104.47.33.81]:47744
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729644AbeGaT2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+bWBBc7hBmtF9bEQfhDNeayrOWKcYEU2yet7IixTrk=;
 b=qdS4D1eh8s7J/8GTbrATWw7NAo0Yo04xyuj5e0VpmoHvk7iZ5bKuLsrGT4SEQOOzd1SDNfj9zkSts1YPyWb10nGNFxgAm6+pe/WvaT+Co64RfCwJCBjx+05TTkc1eTUwKnrTDBo9DmQgtdLiNi1nNauS75ilyN7soiqOHnD8foU=
Received: from CY4PR02CA0025.namprd02.prod.outlook.com (2603:10b6:903:117::11)
 by BYAPR02MB4455.namprd02.prod.outlook.com (2603:10b6:a03:57::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Tue, 31 Jul
 2018 17:46:41 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by CY4PR02CA0025.outlook.office365.com
 (2603:10b6:903:117::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Tue, 31 Jul 2018 17:46:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Tue, 31 Jul 2018 17:46:37 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47757 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fkYjE-00021X-NN; Tue, 31 Jul 2018 10:46:36 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fkYj9-000385-Jt; Tue, 31 Jul 2018 10:46:31 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6VHkOGd026129;
        Tue, 31 Jul 2018 10:46:24 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fkYj2-00037D-5F; Tue, 31 Jul 2018 10:46:24 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 52A55B20671; Tue, 31 Jul 2018 23:16:23 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <dan.j.williams@intel.com>,
        <radhey.shyam.pandey@xilinx.com>, <appanad@xilinx.com>,
        <lars@metafoo.de>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/2] dt-bindings: dmaengine: xilinx_dma: Add binding for Xilinx MCDMA IP
Date:   Tue, 31 Jul 2018 23:16:12 +0530
Message-ID: <1533059173-21405-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(47776003)(4326008)(14444005)(6666003)(6266002)(50226002)(36756003)(5660300001)(446003)(36386004)(217873002)(81166006)(2616005)(16586007)(11346002)(90966002)(356003)(8676002)(42186006)(81156014)(478600001)(316002)(336012)(52956003)(110136005)(106466001)(63266004)(2201001)(8936002)(426003)(186003)(26005)(103686004)(51416003)(126002)(76176011)(305945005)(54906003)(50466002)(2906002)(476003)(106002)(48376002)(486006)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4455;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT061;1:IhedinQPn9jkp5HXZJGFaYR8SM0Ae106IAgJrMckQJTjOHfIT3yETvLnqqTyQs5DVyKntqjPrHmeSsAlirBIMQpnBZ/SnZ3ci98rxZGLCUf+Qtevc7QwJZovkQb2T6w8
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11361bd3-fe22-4b73-c4be-08d5f70d92b4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;3:kUy11VueFGJ4jR+6L3Lry2GyGToo1fTO0fZBXYFPIEfvD/tyd99s7JUlkslOyxPukyQNPbFtWyJbvac2fsUE6PpF6End7xOeMuGbiZxqEQua5shIbSDx3irmcknRv5KHwnPm4DWD/fRk3nTxH8oTYXmMMReR2RAyD1kWA+T6X0yE6eAlO3O1LnpPfMVoDHOmHrLGJ3AnfgoqH3A0VFmUai+3+A3B2eKZDwdLABePvSiGkoSdM1k+5Q8eC+Xgufh5XOjWcXOsaH8IZDBA3fxfTPvyur/Yp4/hmXR0R9dq2UjlRWcZiHwdg+JTV2+9qDElv/ZcDbJkGIQn3OMkTU//j9w7ySk3Aek/uyfG1DSA6OI=;25:io2LASlpQIqamb/yoDQrxB1Etopu6lTsM4jFhaIAUSJHYm2NsimVrr/LEzjEcgIsY7osNhmMIt5TRIbQqrmic9muQ1qrizXivZ7QWpXM9YAmpQ7Or5cF7W+0jPFZefjCT2FVPXW0xMxUQeEq15ZIPz1sfbD7Blhfci5A38/+yzoksRTdyzgKV1+JDwJPTVtNUcchsFd7Eb5hNk2LB8T+sjqg/5zUlkesgcPOACZLaOXPKmaDoFJkJlVKxGIKzuuC/TkTiAR8d2wrMIouK6ekMdfs6Ce9kBwjk+IHA1SYT6dhF8cNp9WEjg51aty5YXojyhhPnTDeE0tI0OkTwou8HQ==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4455:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;31:TK2KTsvDsdkQj89SbiiHoKB3BzETb/cgzyYlvQJqsI+LihNjMIZ8VJwQh/vqfnbRLN1HBbjgx9JKQGiLm4OCtL5k+9Fa7MwEzNrLpKbDwxcfI+RrX6hi/rLC3vAKl5MfrMdkfTaVQcxO6uEt3D6IqvTd8TCqvy+L954a9aFnL/LGyAlTkPDmoXDQ+06tHQzFBXEmFHU2F+OmZJGe1weXAXoVmVBuNSHxfe32sp5G7yE=;20:Z1OkZLdhlKkM8AQjNFfJoP0cUzgIybIn1f+2WXgyiS3M3E3Mh6dOi92KcUXCa+BOiMkwCnd7f0YO63ee7C9e40MZQCE7AyjTDLA2vrLkgotFTFcoLMXeWD/r2TcXEPdi+qhHv8UHNNZ45p7Nwz6Owiu1fjrb1hi0unRP3OJSvaxasm6MAs4R69xMCtSYFZ60r71+guWuOZ2sH80KkYzSANTM8sjThZ7SePUwFtCnT4HbTia8UlJOsx5sxCZOufKP844fm9xgyHYUoX1PFcJg+XbrE33PirOKrkVA30UYuCK9zPwwEumryjc+t+xZF11zyLu+vDcQkqp3eiylhj9KaSmcldkGhF/o1fCe01dfAt8Crq+Vgc6Cqtkg28+dJcEO1FcB3pKuhrmUW9JkYcpG+G1/zl4KG68ygS67HzpCwBa8DWCCOXqT132uSJhNpda8G3iJr+dt2xgQzKa3eN17MBPdsjR2T+5gMtt8zx0phGeXoZtfrAIPgy25PKPca7Ru
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4455DDFA043C0AEC65BA1C29C72E0@BYAPR02MB4455.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4455;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;4:w6QSF13/0RKRc3HKEi4Gbd8eFkLRDr5caOMNcCQTR71ZT8NlXe/QTNX+SxNsnGpgZvRxx4dsa2XNEri7GBMkZtstJeMBwEvXz74eBZ+YV8MfpXu3AwcqTkQ+R5WzN+mTPkwBwSPtglHnbEui//lKZy69L06DLHqmK9kpJ+J/x3ofaBjD1trh0dPhJ/h5il7LvB2JZa2wX/7VmMJMdlAL5wcQ1tkrypppMPM49duvVYqjzXEaX5rkyJ//BBRW7udcP0HWvegb2jyMsDakjMci0ULj8amYXAxXfQ+gETfbztgE9AJ8O0Go1QMQtzCKdIOD
X-Forefront-PRVS: 0750463DC9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4455;23:vK0Bx1bWRcEGfCoHCKnUQip5oOm9+dg+yZTWuNXrM?=
 =?us-ascii?Q?GJnL5hNAjtnxsDqVKb+bWd7jRLQ7zjnQ72F6DuVfG8aN1CO2XW+AEibSSHSn?=
 =?us-ascii?Q?XhQAj45urHYvGdNM6j2QApxLnrNcaKpPPwsvmW/FXLhsZ8lumLwBuJoVqBrA?=
 =?us-ascii?Q?NmLimwZRkQWb7EIEqYMbqYvCc4LqM6F83iC7L983mHdxEtGJIw2fAc8vwhr/?=
 =?us-ascii?Q?RBJADsFpLVN6lMQGTIZyeu7CNnKGrTs9mQe3Wm8XtBx1G0GmMMw62Zy/Ouaw?=
 =?us-ascii?Q?sFghjMdpueZbzyqDiV9lBV+6p1BYpBjBkHr+QRh2pL5sZIK0vZIrHne89OSM?=
 =?us-ascii?Q?ncDy2080KhKSk6JRvtbhS45Y8b1poJk+bRX6YY9LkOTn+o6QhUPwcrY9gV9B?=
 =?us-ascii?Q?E8seE6uGFAYnbFpl6fwuxC4aXztZPrpSEBljE7M17RGy6fKGwqF1KzD9gDLm?=
 =?us-ascii?Q?MYLGKRBd3rXZKs0DLKk6WheEaoiXz9L+uXuboMb6q9g/U36zTlbx8P/bXeZL?=
 =?us-ascii?Q?FJ8iRmir0hnzj1r9dGW45876Lie67/fOphxCoZ6RUaWDZFR8A795qIGH7vTg?=
 =?us-ascii?Q?qv0QzQV3KHQH+dh/s9g3u2sp+1F+HWC9FwBwMwcbUiZLh1Nb5K3gobWq8LPo?=
 =?us-ascii?Q?g2Ci5ankP6vml18qc8WCa9NNt8nhfJPFQTfUkSqvgi0j+13Gws1NOhBoXI23?=
 =?us-ascii?Q?EtB3I/RVg6GjObnlPXuFdPvrOnG8xFCtKVxhd8hmo/9bOFTHHPfdqusvduFF?=
 =?us-ascii?Q?FYDhief0aKzfDsoB0EfQyUf9v7wwXzmnMbMX3cYsp2CUhL23p2iVi+XhSWcz?=
 =?us-ascii?Q?JvBkBnnyC4/SiWxmcEe3sNyAiTAVg3iaaI4D+XJ1e/xx+Csl1r6iviQaVG/g?=
 =?us-ascii?Q?uj+ch74SNXJAqjxh1KElm0IIomJlBa2TYLQ9OfXOZMy1TNowzSMT3HpxcpZJ?=
 =?us-ascii?Q?0pexORl0YC2v7hXAQ2B/rS8II8iGhy2nZHpr6mwTCznMglkHRcLr6VsvgJnc?=
 =?us-ascii?Q?MnTX4GRlKg1DXcY+vaeFzMWLVOcCOH8uHm7w9YCLvVyJsyFynNXfyPiqVvSc?=
 =?us-ascii?Q?fEnBss+x5p8HzqKRwVqb7xk58QXEOoqS4aBl+8HCpG9b2xZ89Hxd921V89xf?=
 =?us-ascii?Q?tbx6BXg9eRqqGMAmnaXTlf7E5n7QIY/txypCKSg5UbGWXGhzI7q9kC4zzFks?=
 =?us-ascii?Q?37O5iV0yzTWSOA7Ft0x1rCqF2FTeE+WU70XxHbsT/wV5w7MkphNClcIxBCJQ?=
 =?us-ascii?Q?z1zupgPEQ+Rg03BL7w=3D?=
X-Microsoft-Antispam-Message-Info: W+QXtz2WIHzXoI2OjlKeQdoJJoIcN9M6Q0XG0C7CXXrsg13kYSjMaPPx0KxQ2jE61RFMNIodxxX0dUlsRuczP8l8AZvO8aZTIu9/jWe21atPkUu9OWcH7KaUvtJ2CfWUzpSNKXGPMTNloW55aCZ8qfJ/mXASQ3B1VnSIPD4ckfDQ2qwZS9st9QVKeSICblCXAsvBCVS/KjaxOcviSQWolaR1OBXeRbxkzRb+0jFfMf5+ZcI1ALwfXqN4i1PbpFQohahyNERDWm1pqMZVHFi+JzYSMuRKhOVOIqYuJjEc8ickKliIN6UXU14hE8HaVFL5wDkLludB9mJA1AxWA1RA2CXZf+OD6MWbYkJ56QDWBPM=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4455;6:klvrsTbN2/oPltngy4qCy/rJ4QAJApd49m2sW0MUaSYVY0FddAsnk4PHzgX05Do4A5EXN/7LxVmE+Uu2weRwRuCDu5jFcJTqiNoMJVwbQaSwCZMRmFVQuqKSQ0nO7K8t1MIOU1G6JnMAdT4i4W7WEoikMz1NcSu6Pczkkay83ojFRCd8ar46N3s6+8xWJSrBdHe+JvH8NAm5mbgWHit3cgVBWTpkVGsJMUI7icgEA7ceZOJShBqvTCF5idoB4DftSf/oZQy8+n+4bEWOeLnBCSHPZO+FEolU3TUz/kpGIvgHyBOKM9GR3Wa/ETDb1DhyOLodkRv2Z/coZwJW6J1nA2+qIBKCUmxhvH/UuS05mEctM+QZG9YSYgz3K6DD+YlNGxSUHq1kthc4rF+ibBR9PjHl5KtpOAMbZRopLir2fw/Nn9Y46N/2o69KG7mPwZHsdP85lehZW1CvzSSyrKg/2w==;5:VSbJhPAhU0i62aYDzAFC728NAwX6d41x8UB090P83wdcpMhZtD1y2aPmZQKxber6++cIOWMO/1FwuL5f0Pc3qdE5YUxdFev5eB9TSIPoyQ0lwDCEQmgh8bU+kURe9cOIgwCyoaV32G8dwUOLiXyawwilNu0DnhVcJbhwR0IPIXE=;7:yBJKa6cAzVKXOVdW/IkleRS7lRxCS6cFzPGNSJvVGz6/Rulzq9cc/kGD70WfTX07//G2xXQhE39ZBELC86eE7cxhUI3aVicPAY59vo6pGhP+y5R3XJBpDq6F1EpXJTUQV3YX3KPoAU6DRZI+B7hBYLHUoOviL6DBL25RtHB9G8kfXanrwP1TnjywdUd21+DRRMiGLsCen7gJF7RPCJjgZiGh8IblZDC+UEIcNInHEzq1P4Pptrnb0Dauo2DjIRlo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 17:46:37.6998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11361bd3-fe22-4b73-c4be-08d5f70d92b4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Xilinx AXI Multichannel Direct Memory Access
(AXI MCDMA) IP. The AXI MCDMA provides high-bandwidth direct memory
access between memory and AXI4-Stream target peripherals. The AXI MCDMA
core provides scatter-gather interface with multiple channel support.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
index 174af2c..57bb02e 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
+++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt
@@ -11,9 +11,13 @@ is to receive from the device.
 Xilinx AXI CDMA engine, it does transfers between memory-mapped source
 address and a memory-mapped destination address.
 
+Xilinx AXI MCDMA engine, it does transfer between memory and AXI4 stream
+target devices. It can be configured to have up to 16 independent transmit
+and receive channels.
+
 Required properties:
 - compatible: Should be "xlnx,axi-vdma-1.00.a" or "xlnx,axi-dma-1.00.a" or
-	      "xlnx,axi-cdma-1.00.a""
+	      "xlnx,axi-cdma-1.00.a" or "xlnx,axi-mcdma-1.00.a".
 - #dma-cells: Should be <1>, see "dmas" property below
 - reg: Should contain VDMA registers location and length.
 - xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
@@ -56,6 +60,8 @@ Required child node properties:
 	For CDMA: It should be "xlnx,axi-cdma-channel".
 	For AXIDMA: It should be either "xlnx,axi-dma-mm2s-channel" or
 	"xlnx,axi-dma-s2mm-channel".
+	For MCDMA: It should be either "xlnx,axi-mcdma-mm2s-channel" or
+	"xlnx,axi-mcdma-s2mm-channel".
 - interrupts: Should contain per channel VDMA interrupts.
 - xlnx,datawidth: Should contain the stream data width, take values
 	{32,64...1024}.
@@ -68,7 +74,7 @@ Optional child node properties for VDMA:
 	enabled/disabled in hardware.
 - xlnx,enable-vert-flip: Tells vertical flip is
 	enabled/disabled in hardware(S2MM path).
-Optional child node properties for AXI DMA:
+Optional child node properties for AXI DMA and MCDMA:
 -dma-channels: Number of dma channels in child node.
 
 Example:
-- 
2.7.4

