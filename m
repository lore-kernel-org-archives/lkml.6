Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14985ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9904B20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oTe43tI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9904B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbeGWQEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:04:25 -0400
Received: from mail-bn3nam01on0078.outbound.protection.outlook.com ([104.47.33.78]:32416
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388535AbeGWQET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX3TFA9KVqhZ+6V84wbnZOrpq/Jt0dI3vyIIgVW5cpI=;
 b=oTe43tI9/keGMUrcde/4WMTTKd96eYoTgP8Z3agejthtvE71ygygFIScxGREfAdcDqkOJL+2rEiAFsT5UpHsnt0hFYFtZwAbUtJSuJLc0tKqj6U3YpqpS5wWm27OFE1l3c8tKD8talAYuOxWLgcjRE3eO1mO3kAx1AU1x7MzYFM=
Received: from BYAPR02CA0035.namprd02.prod.outlook.com (2603:10b6:a02:ee::48)
 by SN1PR02MB1629.namprd02.prod.outlook.com (2a01:111:e400:519f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 15:02:38 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BYAPR02CA0035.outlook.office365.com
 (2603:10b6:a02:ee::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Mon, 23 Jul 2018 15:02:37 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.995.12
 via Frontend Transport; Mon, 23 Jul 2018 15:02:37 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcM8-0001BW-DB; Mon, 23 Jul 2018 08:02:36 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fhcM3-00006E-91; Mon, 23 Jul 2018 08:02:31 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6NF2L6m002957;
        Mon, 23 Jul 2018 08:02:21 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fhcLt-0008VJ-2P; Mon, 23 Jul 2018 08:02:21 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 38F1C121479; Mon, 23 Jul 2018 20:32:20 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <manish.narani@xilinx.com>, <michal.simek@xilinx.com>,
        <pmeerw@pmeerw.net>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <jic23@kernel.org>
CC:     <anirudh@xilinx.com>, <sgoud@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 4/4] iio: adc: xilinx: Move request_irq before enabling interrupts
Date:   Mon, 23 Jul 2018 20:32:03 +0530
Message-ID: <1532358123-23485-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(199004)(189003)(2906002)(81166006)(81156014)(5660300001)(63266004)(2201001)(126002)(8676002)(478600001)(6666003)(44832011)(72206003)(476003)(2616005)(8936002)(106466001)(486006)(336012)(426003)(52956003)(11346002)(446003)(50226002)(26005)(186003)(4326008)(6266002)(6346003)(90966002)(36756003)(36386004)(356003)(16586007)(305945005)(103686004)(42186006)(47776003)(106002)(50466002)(76176011)(54906003)(51416003)(110136005)(14444005)(48376002)(316002)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB1629;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT003;1:7U7KJtSzwAuj1UG75ijutNIDbEWA++D3UgYonzk4Mt30N2pVgbsJ1qDyM5P9j5DoJ/7ozQWdxiU9jZLS3oxcUwRWhvT/4Zvk8QxAknuZ0gYzr1eUFp70lYhMBI/x0fRF
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9556930c-26d7-44c8-7d63-08d5f0ad5415
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR02MB1629;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1629;3:lP4jhCko0esI/9XnsKxwGUkFl+OykHeg1OMl/lAucnmy0duZZ95d3LapTteq3MtH6BBAJzyE2nyfjMukdBQZGkvs84kjPK+8Or0TZrISA215xy2CTrp0WqwMFrRiqLc7Qt2mrNw0VMnHoPAxO8hNo8Wb0rUhrc0dbXTg5ZKzrlPdpqqGgwU3tVOXjs+E1KvHXp/vmcq6/uiiY7SeQOvFoXvG0Oz0TZokLHRK0fLmN6UMomFmkfoekcG2YcGm2BBCHwEuxBOnhoYHpTFmAw7DF11v7O1xDmT4gw216KWWYqv6Ohper2F6xjXSQe8IgXkP7hi17kt/JEfd+cjH+NuriEuFs51t2lXXbFosRNcVLg8=;25:XigkKBMO5morrljDyoGPGilYi91jCkK4GMDPBx3t6wRcR/onOVlLayXZsXlZvTA/hlUP8CGOeunoEiXPwiksFEvpo3jBFy/v4KfZYQ8OEyOsZojjbUEBo5VKKRDBfa5ZCwTZe534m/pk7PsNQO1F6DF9AOwAMQBgtclEQDGrGHn2xLzQWm/TbgXrCO3DfFYrD/vtChoYll5LOOJoNWx0I2rKJKbft9NXcxUPi1DkNsz9QBLeHu74WKvImbWrfEOvkecZ1jeD+wED0vzpiH+8VZtCl4apYmC3fzfnyv7ekpLtrp7LJ/XtEtsM7nMxcMq3Q5ih99Ko80ZFarRbWIvGTA==
X-MS-TrafficTypeDiagnostic: SN1PR02MB1629:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1629;31:TqrioGYSRVBECtgiOkuA+5Pz0ziVKQ8cn2y95h1PaNjaVP40f33nc4aiwRGYCLozYivh2BRoatdwBLNq1McoVztCZDu41GnodjPUQ6U1ClMXwJ/gjs/SJwvvgnLrpjGpM2zjSKD2MFUivoBBV/br5q6g9HDlZEPiW0LahKNMc0nZ575FwKXc4R19Yak/9Anw0IBNKXqLPgt3KwYbltfNbfaOyxJATGjnVvTqON9RSRc=;20:uga+Vv25dDwGP7mmp5/Js1KWFJ8JT0Z0AHquO/58jc4tZT0JJRRgh5/rKr1tGG7gjpYevqKQ5CPAmCY02tugaEvIvM1SbBm1ph2ze9Q5gHrJSnaxjEB3zx4pzsis7vDMg37AindKqrFYRCWrSmOll3tbhRDAcZ0HStEyoseSisHnIhQW5QOc2RSBHjm5U5f2ohI8kydzIXzcsTjBrwGqhIM1lyddr1wn1dosYbpLhwOVW9ktylI288T64NfoEDax0fdTnX9xo7YiMfeqF+jSPQjTZn6AbbDITm1Z3Mf4SP49gUCAZqm+LUoJIKyx+kdhCY5a+JXri0TbBOS07FSCQ4ptBYh1hAbA5K5DcoVfOECdSVyg6CWFS+Jz8PwL+nLQPh0ehJE4PlkKv31s904yJVefRHhN7yU5SK39Qjnx7eO1nsniik1+16n3W9FkFDeUvt9pJ/a5Ta7L0/VBiLQLbodXvhBvvJYE2qIp8U1gIe4IYoEWW0zWQbYDKevVJjW5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB16294403365922BB4CAB6475C1560@SN1PR02MB1629.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR02MB1629;BCL:0;PCL:0;RULEID:;SRVR:SN1PR02MB1629;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1629;4:qzpR+S3zsPt4iKk63E6JD2P2ruVCw1pP+ng6vjACbA8l0x2Kz3Nb+FyPaVP520g05jzVs2zDKcHwWtFQo7jhz+TLr73hhYJVUCC/G8dy4c13oA1Ga+PloQ7HQLTWO9VY7WgOCrcZ/qbU3tmCEYRoqYKBy2MPF+M5RkETKcgFLQIwCYI1AoZ+1XSd+gERHla7/9NukDfN3O41maVzQTG8a8NS9dt3QP4E6ib1mz48DEwE4sse8MDPX9+ivt6oz2Aveh8M9tdWV89F5/ZkAkf3DxaqFXs/8sOMFzX+Pi8XmJMw+/qylVWQplgq/JLxtI/g
X-Forefront-PRVS: 0742443479
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR02MB1629;23:eNCqntKzY5KEPQAvs9xXW+TLj6OI2LCBSp3EJIQoV?=
 =?us-ascii?Q?Jn90mosddNJhokV+T5FPCgC+jA/v+ZFZNKTzbESYocWmLP2ijSDb3h0X2Xd0?=
 =?us-ascii?Q?ewgzqkErPxRm5jQhtAsUtsqdKB+tYZuDktrnKwPZk6oDf3ipzC+lPoANp6+V?=
 =?us-ascii?Q?mdreZ9FWTmDyz0YCLTeTuSi7jRpf59mSFsPby6XvnSL/jdhq+nCNXtB2ny4l?=
 =?us-ascii?Q?ak48P78Uz9LP6nkfHBYCEFchWWpb77w9WigzEWsHWPFp+rUmhHUfm4x5cfPs?=
 =?us-ascii?Q?SbjPIJkx4IAD0ehogzLN0+9AYiN+hXHZjm5OHxK8dLAuBKQKgHhKAmAePVCf?=
 =?us-ascii?Q?0qrJWhnPkcPDWNH+1v2BUjusLNgpOKQCLgWG6qN+s7fSzeAdL/IaL4HLwgC0?=
 =?us-ascii?Q?JwzSKAMgS46Um5NHAyvx/JPxeQQIouw8j9ssAVptCLqY2zwZ5d8C3bUr3XnL?=
 =?us-ascii?Q?ywVLU8vV5iXUqfkIAwwOFls0ASkr4aCSKCT0O8FrMI1mEA+5QSul0QyHnbmU?=
 =?us-ascii?Q?pCOVvojeQY9TFzoV44dmKtx7wKAbouGX1KGTmQtBErF5cB6cmfcMCW3mUDCb?=
 =?us-ascii?Q?rQ577d4dWrTpI7ZSQPG0foX89+iBh2DjPYUer9pAT71xCDD/C/imS6vBiogQ?=
 =?us-ascii?Q?Q1djspoAgWAqo/SFJWwnsiR7lpNwRRSg9VRGrMyhxPRGTkcmaJpuknbNABKN?=
 =?us-ascii?Q?NeK++azk/bWR48EGUIa/a+ZTekFQS/kR6ICnNyd1ihmZ0CSzdrjMfAv4BFuh?=
 =?us-ascii?Q?kIwJWh6hFKXvB7bxV8dQwwSQ3yG45ix2zWRvZwd57kYrnw8kz5Q+uSB9c26y?=
 =?us-ascii?Q?IM+xMmPowyY8HepxQJOPGziHy+ivKMyG08IxSmx3gt+RB4LI67lDq0DRlxtV?=
 =?us-ascii?Q?mUU8FmR7Do9ZkNTGz5JYFfYWBkcP/Q+lTSWhqWukaWSQ9qJYKH/6t7iOMCtb?=
 =?us-ascii?Q?lisdXxqBvParVntoZpLIDQ9SxHRLuFwoZH/mjjxwp/YTZwqcYw/fJYDuhD2j?=
 =?us-ascii?Q?xd69DWFppUYNeyNJ7G/qvSSTe9Yn6h0joh7kIUBFKj5MPv/3nwUvyeLnZx+4?=
 =?us-ascii?Q?nnZ38aV6Jl9A1qC6HMBd7yQQkj8LCpb0+/2gvLVmxw3Qqj3G/ixXdVj7L5f6?=
 =?us-ascii?Q?5x+fwg0FezW7A+8wEgE+f2PhuyJGrSaibWLUWCAYkBlK1gAajO+2Mz+sM6eq?=
 =?us-ascii?Q?iIhzAC5C0Glxn3CunMOkT4vOSqred4ZUSakICqAA+EogwuB2Uua9hf5uQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: UJ7yyDNHfkjMLneDx0kNlDkLH05u0OPxDdMviVubetWz7+cl42OaDYWwd/fMH3K7rMlqkpVDjA4EgqcV4EIgIFBtLigoL2BuENfaCvjw44DfpcWrpSLaUXQWA+n16uz+EyJ1yRXjtmzzjwBRd0xfSksArEyAEm8YPnpUSvQNOYytSwz1MMYxJqqCNEJ4URPNMTI/rdkRD9f75pyDc7u9AQv3YP2FeKoa+8bPOmzJr3aXPEdHtSwH/wG91r2ofGNvoyabtIdpsZwj0pKAZSU+pKOkKoQoKMJrQ33WW1PxDMex3g8wqvQnK8gYitkOZvxR7nZInnik7ZvjV/PLadfG6depSM6MNv/Hzq8VS3CKT7Q=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR02MB1629;6:SWk8UvZcfeADy+Ug60inyqISedhP33mXGao91X1n0jfAy/eGFVMbfZ1vsTyzg34BNg+dlkXEFjAkO096dyv2CiRl7FnLhQygcKSIS6j+uoBdGyMDkxP01XvMdl9AB9Uy9h5SugL8ixqqM8jAvdDuXvIY0fAY6TokItcDqeuLNBozQDrFxLqYib0OkMcK4jG2t+HKWYmoiThSh1etZmD/ivtufotXKDv7G65VAvpi4wWIbro4fb6AQqKSwqhXxCmELAHsoPG3okzZUzFR8FLqCMgmEZn4RlE5RjqcjBNixUnHzrIP+7hHcatIynvEQg81i8SoY0E3/nqYSxu1Z6bPqLw7MWe+qxsgPFRsAvykVWenvt8Z/BCOxsOuAyga9UcO2nTcEH0IgwoX5Bo5Dy/30QS1wQpc9P3PUwUeA8vfKxepCKoUIPJ53PNSNG8SzvZlKXvzsLNCRoluG409kIcumA==;5:nbRdtCGVMafqepfLYJPVM8gNR2Wvtw5dx7JplbeOUrq6PU9lpb5aL5bR6bRYpBH0mbVfcmxKE2KDzpzu6fyU+npWDt1jQQ34uVeJVywnIboPEKzn1xLKbJzwuZCI/eUU2VrY7/uNGmc5Jk6r38trb4EHHPqkPR5gA3gtQoYbZ7A=;7:vVI0bL+LpMO7ylXEQ28m+r+GHQdIhhoOS+e46GfB0TtmJ+v+3HN0tyTWftg81s4Q+zN6E33lVOD+WfRmlNLzQln2cd/LtmyjIj1omNBNgb+Clq1/gNpG5Ji1nsIA5GnkvRJRR2qyp/JGG2j74o2jioNDbfl0ozKnJ4Ei70Xn85lcRCb8XunQ/UeqTraAfu95RP1AizRDhRAdReefC8Ku+2ey/Jnr5bcfG4hEnBbKCwqDZV0feEqd+cdXqdrdMbqZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 15:02:37.0683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9556930c-26d7-44c8-7d63-08d5f0ad5415
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB1629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the Interrupts before registering the irq handler is a bad
idea. This patch corrects the same for XADC driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 44a2519..3f6be5a 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1226,15 +1226,15 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_samplerate_trigger;
 
-	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
-	if (ret)
-		goto err_clk_disable_unprepare;
-
 	ret = request_irq(xadc->irq, xadc->ops->interrupt_handler, 0,
 			dev_name(&pdev->dev), indio_dev);
 	if (ret)
 		goto err_clk_disable_unprepare;
 
+	ret = xadc->ops->setup(pdev, indio_dev, xadc->irq);
+	if (ret)
+		goto err_free_irq;
+
 	for (i = 0; i < 16; i++)
 		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
 			&xadc->threshold[i]);
-- 
2.1.1

