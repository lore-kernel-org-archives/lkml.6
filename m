Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 30412C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BD9208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 18:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="E7jF4H1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BD9208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964891AbeFNS3n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 14:29:43 -0400
Received: from mail-eopbgr720079.outbound.protection.outlook.com ([40.107.72.79]:6896
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755324AbeFNS2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 14:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tzXjjxb+XxO3qo0I5igjwilZ3KxLCYpht6qunDjCKVs=;
 b=E7jF4H1D5EU7EhQZCWKsYaB2jeLw3O3e0v1756unDlUYMZShUjXz0BXbQKerG59PVIYp9P2ls7suV/HkYnFdR9nv9gzE/82TeDwnulA6ovald3bl0hLu/h8IAMrh9XC77QJwollyd2bylHggsP9fvCUnQbk0poj7/4XB1aP4mck=
Received: from BY2PR02CA0100.namprd02.prod.outlook.com
 (2a01:111:e400:5261::26) by BYAPR02MB4952.namprd02.prod.outlook.com
 (2603:10b6:a03:47::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Thu, 14 Jun
 2018 18:28:12 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by BY2PR02CA0100.outlook.office365.com
 (2a01:111:e400:5261::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.19 via Frontend
 Transport; Thu, 14 Jun 2018 18:28:12 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.863.11
 via Frontend Transport; Thu, 14 Jun 2018 18:28:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:41081 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyg-0000Ak-Pn; Thu, 14 Jun 2018 11:28:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fTWyb-0006HA-Mf; Thu, 14 Jun 2018 11:28:05 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5EIRuYU017081;
        Thu, 14 Jun 2018 11:27:56 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fTWyR-0006F7-Ve; Thu, 14 Jun 2018 11:27:55 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v8 07/10] firmware: xilinx: Add debugfs for IOCTL API
Date:   Thu, 14 Jun 2018 11:27:39 -0700
Message-ID: <1529000862-11510-8-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(39380400002)(396003)(2980300002)(438002)(189003)(199004)(81166006)(50226002)(51416003)(186003)(5660300001)(77096007)(59450400001)(7416002)(50466002)(305945005)(48376002)(2616005)(44832011)(316002)(126002)(8676002)(476003)(446003)(110136005)(11346002)(2201001)(16586007)(47776003)(426003)(478600001)(486006)(7696005)(76176011)(26005)(81156014)(54906003)(8936002)(36756003)(36386004)(4326008)(106466001)(336012)(107886003)(39060400002)(63266004)(356003)(106002)(72206003)(2906002)(6666003)(9786002)(107986001)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4952;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT052;1:V0A273+LtASutwTVaW6gLAyG3F476uGG/jdN0/OBCTPkOm0uj6BcHqsXemrAC/t6eu6GmTHOgCNz0QezpD6d5ZtwyIiHzisKNn0/HcCvQ2wqnJsynUbVetczwvMM0ymZ
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b51515c0-0f8b-4f5b-5af0-08d5d22495e8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4952;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4952;3:wSWhQ3deCed8X9po09US24v1I7ZguYMtaHzYXDsBorBAMfOKaXxJFlgnmOeLvx6SJ8Ki1rSZ/CT1NwPQ+dkJrEV/OXZHXHBU9DTAd1qNMeRicyJao1yWNN/uJtMlp63VUhQ/PlEn62YcZdptxSR9ozNUBRKnWj3mOkt9eoywUI6yq2QuhP/he14CNm22NdPXGbELO5DeHkoPAVB+FkP3WEUnA3/XqlVkQKWeENW6Ril7X1I+F36Rg0ev7MX9I63617S8mpO1sMdgcR9DWfO+O6UQ7vnL9qBjwBLrQeGXh9psvHDkSxLiEmX6NLsHKMoPUmCUWIOvXeliEKxeRzPV5ZCaQqQ9QBe7D3LmiY0uJr0=;25:MSdYpBKgZNgdufjA769naHZVF9iwKU2B9c+2Z6KqNn9Up76mlQVIZPdtxqJTKxHm2pfkeVZ/l7Ppk8SBm+fr1KpvWjSrjDMqj5gP/a/ZSKJ/vPZyGjMpb+T/NuZiY1897SBUtxqpBFyvikMZJ+LW96VNWueZPIZW3keYV7kObrxK+g7KQJYi8YnO9aus+hkp5bS1g92rRvMar2wKHxQrAXJFL/FCxChWFz+/G1mXklmEioEg75K7q91qGYHqy5aYuAm7aGdlwphbK2F2MPqEZbLWzUzGe87ThbUhKF52UMy6pJzgrwcoSPHQPVwA7QHUW8t6bIcNNCE050fDBW9kMA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4952:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4952;31:23DAN/J+VHdUphOXI77YRKgYOJafLWMMbnJQ3FqsOsRV4CiS3oXtNLa3jksVMHsoqhTVBVgcDu4C6NVvTLSvm/qGF0oiQLFfLGGKrX2Zm2FEM2/04igcc5xN+w+TF/vUST/+8FlqsiUI8f2GcPFtNdNq0hCWXAD7n0HddNIFOLgh34QA2we7kou4vjHm7cwHqj8WCQ1P3ZmmZV8shFBd7z5BY1heMlKfS6MNx+P4Hhc=;20:Fb6ZPzkYWGEaNbmQTtUy2GV97YzV7PDH63HBSLpMaDR5admuT27Z+sAL5yt5jPQXHOI/qG+O9hWN5rmUoAqVMrQoX9dgDuR7hcLp30pJ8vVU2sYYwgRq6g9bqWeIHZTMS6J8C+vDmPZtOPY4skv+fdBmWaMHBPA1pZBLfaAMJDOMd1yFLQw+Mx1jI+8xlyqD7P3DuF7cm/7LABGbBq3GrO6sQVNZGgLzPYhhbIbQ7Rcl2QcbbXXVtcO34F0AnWKwcbHhg3g8S/PexKbwK1RA6P3nHOTnB5M07LN6WJioOEy89x89/NoFYEIHU8Suhztxym9UVA6Pl9mORa5Y52Q90INAf4pYcGtsJYfcL5YIO5sCUZs5VGKhi+uk1Lt/Tfx6m5jyEV4/zkvOtxVJZQUvlnvKFQmqiEjR4EF92aqt8AJFsCQ/ft4LpTKFjA7L+lEjbiZYrpsWmqdozLavDL1whDV+nUlx2elOfbLLMKD1nOKAbZj1GXoHZxxeXif536x0
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB495276C880E216EF6A402975B87D0@BYAPR02MB4952.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BYAPR02MB4952;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4952;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4952;4:xocZ0lye4Vnj9eD9vc2QX9TfEDChgGZCEUlMTM5hoDwIVUNldvmwS9f788LgcjzIO5SBmGn9q4opXiDoub5m3FuQsC7xLBblo9oF8n/hi9jnh8v/ovX7sGE258q2W2KJySKQoNk2TSqXWzJSr3pfEBB7QcWYcmvKSTsoDd63Er6PhCQtMXrvzm3DDU800SkuWS3cJfbE5K+uvhlbiOSLgo/b9vkofYTpKfiLbnHvZtfHxHl1kHcZl2qGm35x9G4J0OrqHS1S0qumwsX3EtIvI7NSwhnJ3Ud2/aOGkWQYQVQ2TJQbDEGBj08Z7B+danGa
X-Forefront-PRVS: 0703B549E4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4952;23:lLaaatvAO926iphPUIhio4J/RmzuNn9fKB+OVJMeZ?=
 =?us-ascii?Q?ETYIgJ786Hfs5VIhyc0nyPQL39crXcTSawATCLhCtYMzAZmaCThw2kiKCO4I?=
 =?us-ascii?Q?vZSERhvSa0dhtBviNN/S4KhOR4AzuSEuxcbHEPATEZi6CMh58Em14CjNuOQu?=
 =?us-ascii?Q?dPqx7ITIbZbz2nxoM554qKJydfs4+ToIB27q0JC71TQdm3oRLlcVmRw8GoQW?=
 =?us-ascii?Q?+St7ieMIvZGcwD91Nj/V8qfjEKUkfgo07q6jdPPgVTU1AKMLQlEomxFKzCj9?=
 =?us-ascii?Q?kFRobffntiGUxxSbROl31HntfXJHA/46aPWQb6ob3EBfSN46PNDE0FwmPvMp?=
 =?us-ascii?Q?uM2/noZCYWkitap5y/qVzhCivPN9CxyVVcK46gN6QNtmuOmUUBvNaISs6ej7?=
 =?us-ascii?Q?8n1eity0JH//cejMZLhPx1w6ZPIEIdH+trFjMaYKzlm+awyiql8cKmMAgZQs?=
 =?us-ascii?Q?MxeKU7ueUeKJkCZtGFy6dYhcQGEPe4IIKj3lcqnXh4Z4HmE9yeEAeEaNR5aH?=
 =?us-ascii?Q?Zarb1wgtPYsEIzUYKbEpnsZwzB1bMtW9BOCY7jdKw6I6kGHmg1anZMojGHhq?=
 =?us-ascii?Q?Tf6U/90ZfKL1JiZpQnPvprDPyV2YFmApZYpZgP5NvYvXyoZksTgsvyQN4RNz?=
 =?us-ascii?Q?aIWEMaf5KlfRQTk39EPWg1N8pk7i+43AXCy2i+PFWGBM2a4z1WCOBaVWukKS?=
 =?us-ascii?Q?x55Eg3cR5QwgZ/Tr4T1jLf1oSnV/iLAGEBfLfkaRpOMrkaL+RmCV1HRLfF+G?=
 =?us-ascii?Q?d+1KtcZvXgqPNQ8Y1TxOFmaZT5HhVyQMyEg4lKX1KgwrHKIv65iW4RGaxRvI?=
 =?us-ascii?Q?VoCYXLDqS3PtjjkfYhnX4zJ8AZdWtFgE5sLjXRnOtD+n9u2dp2oPqnMyC59e?=
 =?us-ascii?Q?gUNAKDhVGXuPaFyWye+T3/tfwme3L5AM4ybuB6804kP6D7eOo9mnK82N9bwi?=
 =?us-ascii?Q?Y1SA7hxdmiGVUIMTLxFfmAUZtxN5onoADprJfjEIYojjMRXvodszBOcJFVwp?=
 =?us-ascii?Q?B4IrrsZtHilJOfE8mPueitITrma8jabK1HGSVQegrLybp7qZEXHCUkSX67T2?=
 =?us-ascii?Q?oRJhoQ8VHiWodX2BMtg8YCIBSm8KdHYxdlvqpfF6NCbhwEQBTHUnu72JGtLH?=
 =?us-ascii?Q?hthInOfeBl7EX8WOIG6uDDlFyOEbMgjruvLDDeDUOZ/h34P3g6DYMiK0b7wD?=
 =?us-ascii?Q?Yl8Z1+bE30PufgULBNisgl48LeSgwUNrRSj/0djBg1M60BFzi6a51xW0NTDF?=
 =?us-ascii?Q?s8oi3XrZxTwjhvNV/0msiAv7F4XTaGrsylsV0ujzQ8LWHwM2fkbpjEScwQJk?=
 =?us-ascii?Q?PfY/fJYTbjHNXbuN84yVa4=3D?=
X-Microsoft-Antispam-Message-Info: zjlFYhcS5Fez3NNMtSRaf3ew7ppjcu7+crEW9M6pV0mxePgHuoX4m4c4eDrVbiEsYAT0lJH051GBWXjxIlzFeKrLtjnO0DMCxiBDnJSlX7wfN/LX+5e1K8fZlfiyednpzRhA9GjMf5pJx5ClTgMY64CAvVJB2IIc/9pzEo/owTBBb36PP+Iw86hRNkMOlH2w
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4952;6:uRH6RADNPuxgy2R1Bj8QZ4B7Pg91zaMUS7J+XkcPqQB43ZLmM1LS1iOUX2//kpkPc4R6Mm22f7RqR0TePD/fvi23hQd1wor8fltFJgktiqtWcXrUG2UumODRgkepTwKEC5vlZhHQ8hMedmujNT9ZNawW66hBOtOMNWo2LpeRstmXB848t+cZqz9nNL8mZqHYjVX0mr/8GWyO5P5gEM4a6C5fWYMp0c/pmqs758tTBuFp0OweNTZsBqwfkCeU74LOQJZXKoz439qRFW59CpB2BBiPKRurUXJRWP8Vq29MYXVpsQhREov2hqGryjF3stGM6XNj5GWU4qDuwMsiKh+PXUEbRaBS8hZu4AbaCLA4wA7VT6Mv0pf5Zt0l3qR5oKxCweY7JSez7ip2S4DXundvRzJ5D2zOgT8Nk5H/wrlqbToDWZ5RoEFmtRF5dHksQ3kMXs0zMok2ikQ6ZOgxfKtH8A==;5:DHy78I9loT8jVShy31apV+HwA6yPrfbXA4QKs9R4zO+bea/tm/K5OVspC8cANaYToGT3qpu13XCXg0F88G3VDahX3JHoCc43Fiumez1Kcy7D/57epHbO7a5c2gypgAED3clD0gq3Kt0Spf/9g3E+kTkWZVURKmyk5C6O+9XNq2I=;24:gUZf1SVVzUgYyCX8vrrmE6mzBLqxSG77jYixGBeGQHL5rwcuKcy8I0Bsdl0UT5gVd/atVuSsvO9Xd8H9EhjNJd2mTLIwZa7d6XIZisiR7jw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4952;7:D3UO5Ocd2cLmxkifp4DCefn8Hn5qa/n+t55CbkkPm3hLL1YZt2MXXArpkg5Rw2fI3a2GDf8COUnDNupRNPotIXEWhuq1SP41oKLJkU66jRdAB6zzyXMfjL6S+DK/3Uyq1wnQ6Amb3PiEBglF6gRNULD+FI1L1Gxis3h263LziEuQBLlRrN0XfWSo7rAW8edzJUA7njzMnHYTgSEPx4aAiVFvYI1/oehKz8gmBXsAuB84Zi1KwxBGX/k/c0hwAWq5
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2018 18:28:11.2856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51515c0-0f8b-4f5b-5af0-08d5d22495e8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4952
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add debugfs file to set/get IOCTL using debugfs interface.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp-debug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 4800366..148dbff 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -32,6 +32,7 @@ static char debugfs_buf[PAGE_SIZE];
 #define PM_API(id)		 {id, #id, strlen(#id)}
 static struct pm_api_info pm_api_list[] = {
 	PM_API(PM_GET_API_VERSION),
+	PM_API(PM_IOCTL),
 };
 
 /**
@@ -95,6 +96,15 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 		sprintf(debugfs_buf, "PM-API Version = %d.%d\n",
 			pm_api_version >> 16, pm_api_version & 0xffff);
 		break;
+	case PM_IOCTL:
+		ret = eemi_ops->ioctl(pm_api_arg[0], pm_api_arg[1],
+				      pm_api_arg[2], pm_api_arg[3],
+				      &pm_api_ret[0]);
+		if (!ret && (pm_api_arg[1] == IOCTL_GET_PLL_FRAC_MODE ||
+			     pm_api_arg[1] == IOCTL_GET_PLL_FRAC_DATA))
+			sprintf(debugfs_buf, "IOCTL return value: %u\n",
+				pm_api_ret[1]);
+		break;
 	default:
 		sprintf(debugfs_buf, "Unsupported PM-API request\n");
 		ret = -EINVAL;
-- 
2.7.4

