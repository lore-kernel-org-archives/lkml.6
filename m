Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD54C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE09208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ehLeJwLx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE09208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbeGaT2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:28:10 -0400
Received: from mail-sn1nam01on0086.outbound.protection.outlook.com ([104.47.32.86]:2623
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729645AbeGaT2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JerY6usTt6MjIvlgRGf+iA8a0ibjXP6VzdOeA9ra34g=;
 b=ehLeJwLxi7qME3ZlxzR3t/BAgT6Wy+bA8HT9QBnUF7LOUDzum9tXq3ng+yXNi9apBxWO9rfqyRV1zq9ygjAGL3dRy065IKOJpTxnKGKJCdIPR0rwJV/6MBfCLoGaGVL+6VK+wMZWK5aYCCu06xV6BNvwvIWDzABppVd3AudjcXw=
Received: from MWHPR02CA0033.namprd02.prod.outlook.com (2603:10b6:301:60::22)
 by BL0PR02MB4449.namprd02.prod.outlook.com (2603:10b6:208:45::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Tue, 31 Jul
 2018 17:46:42 +0000
Received: from BL2NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by MWHPR02CA0033.outlook.office365.com
 (2603:10b6:301:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Tue, 31 Jul 2018 17:46:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT056.mail.protection.outlook.com (10.152.77.221) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Tue, 31 Jul 2018 17:46:37 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47762 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fkYjE-00021Y-Oh; Tue, 31 Jul 2018 10:46:36 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1fkYj9-000385-LM; Tue, 31 Jul 2018 10:46:31 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6VHkOfs026127;
        Tue, 31 Jul 2018 10:46:24 -0700
Received: from [172.23.37.80] (helo=xhd-paegbuild40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@xilinx.com>)
        id 1fkYj2-00037C-4t; Tue, 31 Jul 2018 10:46:24 -0700
Received: by xhd-paegbuild40.xilinx.com (Postfix, from userid 13245)
        id 4E3D8B20673; Tue, 31 Jul 2018 23:16:23 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <dan.j.williams@intel.com>,
        <radhey.shyam.pandey@xilinx.com>, <appanad@xilinx.com>,
        <lars@metafoo.de>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/2] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support
Date:   Tue, 31 Jul 2018 23:16:11 +0530
Message-ID: <1533059173-21405-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(346002)(136003)(2980300002)(438002)(199004)(189003)(52956003)(2201001)(8676002)(106466001)(81166006)(6306002)(476003)(126002)(305945005)(50226002)(103686004)(36756003)(5660300001)(966005)(63266004)(2616005)(486006)(356003)(2906002)(14444005)(81156014)(478600001)(426003)(51416003)(217873002)(106002)(110136005)(186003)(54906003)(6666003)(4326008)(336012)(48376002)(8936002)(36386004)(16586007)(47776003)(42186006)(316002)(90966002)(6266002)(50466002)(26005)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4449;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT056;1:plfn/HBvMKDAufLOTC3u4MjvWAOY2uIHYAxPPFMjyQ+Pw/GQU8rnuXtCVxVnYmak2Unt9CcKtDXpBKo5TM3WoHSw/TmvRF6gozZ6ptao24CqP3Zn67cG19/Gep93IdNQ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca37a027-b26c-4e02-1978-08d5f70d92bf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;3:wTpyB72Ds2AwhxpcZcFUSkMq5Yna63Lw3Zb9AkRcRHuj//X7H0mKA49C8LMSiQf8flto6KhD0/X1RWioxC/PSaRzHsbu0xXSUINYo/hHnUMtcCa/zcd3UBnwkuTIBeWT6kE9wQ+T4zZjC//educb+BL/9Y7+ocCMPEfxsvzVRK6oEup7ZcwTQ3M0x/EibyOdWOmxuqKDemCeeXU8y1YkV2n186PbkhGRdPL0WMHVzBd6TI4RPPW87q0LBEgQEF8naM4Y81CqPobXS+iuPzzVGmEqVoKOfMwsyoK23ceP7vAzMgYX4314krTqZDAzmMJDIfmp9MWgkmqc8YyN18PUg4fYvsrMK/wO87AXgAt1ay4=;25:b7siKXSVhjb/e+zgx3h5/wl0WKCgkQggdd9W0f7jr4xJZo8Ug+NuaxCvXyvMrhR9jSh3p/8uEeD4qUOasPtEiIi68Dx46TL0kK0ovjTuI89GgT0EYgcW5wEpDFUqJHkIteFQgkHmO4D5X5fpOqxSp4nDBPQ91TsrEtN7Ux2okfNSywF7fCHnOrLXc1wgxxwgtIW+GCQFDcgg/8fzBTZ5Di8MDioy0cJW9arxCTMyTYqvomk/+MpOAzgq+GZMe4vo6rVsEBT2f5rC0ImTG1G4pxPMx4FlAGO+9WzQoO5jMIiCjndU+AzzFSIeM8+0pPu9n53AQ+9xM4aBwarlhmfRNA==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4449:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;31:Ai6eKQwm4KZifeW0Im48Ry1Rwro2COixEYEi2zCFWtoxVNnfiFPDllcFHdgRtmK0vs+2vpACleRmvijkmaoqBi10IJFOy9toHeZRwCptGsPSMJDMdKEMNtrZYRBdBo1qE64NebCllZzUacihq1R21XzxOzWj4vKz7D+Jky/NQuAwVA77tNCyhVZVQIwsFkcWcrOIiDJoygiPfjvRJknCEgWBnYsfSJvpJZ4mRiQae/k=;20:E9+pViKQoFGa9sr+iDk8Im4meQV8TexjiMCtKO4FTEwdgxESNk/hLRAI6cgPjAwLpFTDmnKhzxSNRc7Yyioth9FkTD0ITOJVK9bWPTDIJcul7tte8UARh/rNqX3+flz44N+h76+BrnlrXWmypwJ2n537A5RSygLUvt/7WqDSBeSewuXsOe035Co0wyCWvHRvnuPDcUwOWaxWvfEnKyNq8U9aQjsUG0BLrE0qaZOGVLgtd2IpTPiz/licgmJibpvBTqAMZedc7uqhEsHfOx2k/IieIMnP9mULXUBGPCnofzx53sjWx7nYmh/tQnb19klFBQwW8JqpC5Dn5McChgYBVZKO3x1UNX8zui1UA/Q/7OLDCLS+Du6LZ7xWagIQYvVEt+i9rdz2tjKKjuta0p+L75pwk+vdFGowFQyMou2u/VKqivJpK/1zDXWYfRNnDUrqntIREl51nIqf1/rB5Xb9RoFrnjNEOuS+hQ1zFesagNnpbe5HY/ynQ/uHvjti4sJ4
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB44496BF89C5E47E281F17F05C72E0@BL0PR02MB4449.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(189271028609987);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4449;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4449;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;4:o7oMM+Q15VtHeZmaFd22jLbJmzIgmhGWU82iRNrgfielDbYNPwNdhzXhTyQwts0e5OA1Q/ziMFNGD/BGJpt7v32mstNLM8c/OZKBroG3HwNd6dUEmnOXuJzd6Gzxdy126haiXYFUXWBew0KS4agv5AiCKR37W5Ov70g4FA0O9xyBLF9kvB/WcOpOqmrAE0thxGruldtNORNggeFJuNSeJVxUcEf6VMBe4iAxTo+cvHkWLCVUiaF5820zw0PYgo8I/jvk8X94bzOoWbKhN2+5BUkBhid7CmVrA4DIURXKufKiiNS1dDw1rlcRObAv3ZRwNUsi6gU36eS816grgrvq8Bva09oJ4z0QSPqE2DzBFSA=
X-Forefront-PRVS: 0750463DC9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4449;23:4RyDW01VkzpElZvOl85uG3WRzYfE9E7DUvF/j72Dq?=
 =?us-ascii?Q?+EhT7SKQv4SyPgqUiJx6uplFzD78jx2dAdG+tGVZrDiCbePfbauk8PRHKdxm?=
 =?us-ascii?Q?gvUGuRkNwNcD/fpdFnfGXw/J1MW51G8p2UTXmNWkY3B7B6VyCX6bxiPiv78s?=
 =?us-ascii?Q?mJac33fDCtRbR+65vNYu1144QebcBi81WgDl7Wz18MfUaTOPVAV2PQFs0Rk7?=
 =?us-ascii?Q?KmQlwh9g4K2H66lRyjcBsAT50XGX7cm0oxaH3nh+VJ0AZMsyrr4kBxK9gkE9?=
 =?us-ascii?Q?wel58VeNf/nKKx97DCcWTI73lzOwm7zs/RiyJ7e4Mel8APeUb0fibL7F5iMT?=
 =?us-ascii?Q?UiQj8Uoi/DPDXtxwE0s7DdsXDxnqW9tntq72Y0oUkFd1WDmtVZC/5Ca9UvMI?=
 =?us-ascii?Q?aCjL8yhiFhAdamh7DC4jkrIItWaKTlciKKKo2OBDkqZhWNey74K7v7YE70Ob?=
 =?us-ascii?Q?CIA9XRrQmRYCAczDcH6gvPfL/BNY5+eIY6HikLTHDbNQQqXpKC89ZNGjNiMM?=
 =?us-ascii?Q?bVxbTGC1VmkoZTPsXUqs6kpMQ94lH6j3HB3p62Gh2L0+zcp6ucoumyvLVq8V?=
 =?us-ascii?Q?Y6YIvEQQxp4LBeiE3niHUHGIIxNqfU7EgkX6cKvHI1Sfyt2tHbi9fm0778/v?=
 =?us-ascii?Q?dhxbTrllSgVhG0N615snDwuNAZiB3DtJkpKB8Ys8Nl30m3uy5M5FhdaejfVY?=
 =?us-ascii?Q?T7ay2Jq60fCIO1bkDryoi/lxudvu3WN152jFOpoE7TR6HOyoU2xRHMVBqYVP?=
 =?us-ascii?Q?hO65Nc2yqOv/wSTk9lk7KnKbcSXmY8LoIV8y+dtfs+grGQSExmiYckMS6hyC?=
 =?us-ascii?Q?k8LHOv/Q/Gdu4iSTjRA+coYilWtiJUNlt2vLkmaqJX6VYZt3XiJxSNKhEchu?=
 =?us-ascii?Q?hnMJip6+FGI9ZrjqDO3oCcYwuGy/pTAMgpa8k4DtjI7m8AMb0KvGldRiDQlb?=
 =?us-ascii?Q?Wawut1gmcZa5Q0OG0N1BNSGFSDO0lzz0NvmY3iILBeACvtYyaKRMvGjKG5R+?=
 =?us-ascii?Q?bErdTSQShhxaZfrGMW8BzOmjybxSmn6wdRtJTu+ZJOIogZ0YeOyEvRBvErXh?=
 =?us-ascii?Q?4LzxvFwqs8JiMwsAzRVtDgLW8C+ZCkARjYTv/5SLmqKoKicimU48fPQznbHi?=
 =?us-ascii?Q?6OAdsMcaHGXy1lO6rS6ekh9NUTfnxBfs6Z1U2mZ+ZcJ6kh2yQtvHQaTRLUqa?=
 =?us-ascii?Q?sQQ1/sCyCw2FX4ESycm/Aywz+U6ikQZeL4msUJf48K2eIYe9O6AKWBTSw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +IAy/F+XAeblAsLt0pZQd7PaPJ+biiVOO0cTwPD2ioj2RRe/iY/42AG4X8pBI3tIGAHHbUFuryicK3anZGlwY++vlHJiso/9cEc+lYm2nDUTl+XGTe/EMkRyQTaFA9QF/G7bwupOt6sON0kwfhNTNP3k4Xh0qf00dqud5UJk3FgTVIqm9oYAE4xCgUM4rexsvZHdytYTMxJ8uT+RQZzhmSHdJi+6M3bSIE1EkFJ5rGGvx32D/QDxPHWr/NO9ITyw83Th+8VEreQcx/+XG6QrdJ1atNh6owFe9fSCKkp/XVe8UXoKfQAGPcedmSnqzuva74+hO5ug0kXcFnx6QLaOqfZB2Dr/kqjFQBfDEz6MpXM=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4449;6:U+K6fKKukX/yvlDoaFGa3KLLsGDq0EVBuylBxDFaakL1qwr7jwp+AA8MTDoSMCkcIHup77FRgeuQ1+Rx4HjnoR7FK6Q16ZNQV5O1tLTO4rBz7Fe3gu6CkXwiYRfjaB0RlI9PaHOpbsbm7nlELHBC0N8uigVzgfb2plEUDjrzV3NjahXZ9glxe4r6Nlc2D3Mk608jqudTVV/blut8xVCQzWb5Ft2hD7CwFtSdMupIGxCAMWcpuXZvsqdahQs2tMwgnG/uAVmB2mDVGDN5prtxqNhqosQbTDSnrv7CwZWoSnn6YoxUDFtQYsA9x41eMM6VDvKpMNLq+h/rqIP/17XxY2qScbSzlqLe5hNqoGUtcK18neUWOijGEqc7xIUgewnsBPo6vTRLh6fNZ5ZuoGDFockz+bCziv+Yi8StMn1Wp40xiA2cJg+VmJRaqujkw/Uoh7y7cfzY+4DrQ1KHNhdtpQ==;5:lUp7pV4llylulJ+ZBlL8U4MMO8sM7k+YBt2o5P5vntfPiOFHQaZqINSMdO121OFoCZzh0jhkTdgc8DmTihvLfID7ooEZBOq2yhQ9inCI5Nkv+O3k+0LN76vWhSKts/cqcIWaVM1Hmc2JoRkat0I8E5dNfsKJG0gvBB0ZaSWKsig=;7:1HDeFsl+kMojf9xthB+g3jpyy1+2ucYS/C5aostjn7VB/EjpJcGZnCqLE5BTBPrI6v1ye7IQs4uWrFKgQcPk1R6Km3uC2lOY8ScZ2ASc87dvG4piM7Jn9RXo0MvXan+hgLrHJVZBhfyFF0oZ+SHPROvAjrnHNYJdfqU3x9NX9UzjGyhUhmZEVoNtBHHfwDr5yUgiFitXAeRHrKGaEOgHmtTOfQxuQDO81bXDN6lqWlwYA6m1qTKXO1Rjsf+IjrjG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 17:46:37.7675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca37a027-b26c-4e02-1978-08d5f70d92bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Xilinx AXI MCDMA IP support. The AXI MCDMA provides
high-bandwidth direct memory access between memory and AXI4-Stream target
peripherals. It supports up to 16 independent read/write channels.

MCDMA IP supports per channel interrupt output but driver support one
interrupt per channel for simplification. IP specification/programming
sequence and register description is mentioned in PG [1].


The driver is tested with xilinx internal dmatest client. In end usecase
MCDMA will be used by xilinx axiethernet driver using dma API's.

[1] https://www.xilinx.com/support/documentation/ip_documentation/axi_mcdma/v1_0/pg288-axi-mcdma.pdf

Radhey Shyam Pandey (2):
  dt-bindings: dmaengine: xilinx_dma: Add binding for Xilinx MCDMA IP
  dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  10 +-
 drivers/dma/xilinx/xilinx_dma.c                    | 449 ++++++++++++++++++++-
 2 files changed, 448 insertions(+), 11 deletions(-)

-- 
2.7.4

