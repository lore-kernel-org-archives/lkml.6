Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAD1C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEC420877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WDa9cjow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEC420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeJDWaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:30:00 -0400
Received: from mail-eopbgr680081.outbound.protection.outlook.com ([40.107.68.81]:2992
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727588AbeJDWaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3vel/bJQ3soqncvRhj7fkRbbdMqjTEXPsEsovB/6qc=;
 b=WDa9cjowk/DfalZtbJfbdE2jVmV+AOoRl21G/OFzVUuvG6m+rtNl2FvpM9zKn+h6jE7mfKihJXsfid0zz6VuJSEHTsA8DWr9hONYtFrhSw99Mfjl8zfAcOP6ZwS/y17W0/NwvNc7ZXgORZ8R1AlTYg0wxxBlOWiFbJinIludGbw=
Received: from BL0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:207:3c::49)
 by BYAPR02MB4758.namprd02.prod.outlook.com (2603:10b6:a03:4e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.23; Thu, 4 Oct
 2018 15:36:03 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by BL0PR02CA0036.outlook.office365.com
 (2603:10b6:207:3c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.18 via Frontend
 Transport; Thu, 4 Oct 2018 15:36:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Thu, 4 Oct 2018 15:36:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fU-0001OT-Ry; Thu, 04 Oct 2018 08:36:00 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g85fP-00005B-O7; Thu, 04 Oct 2018 08:35:55 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w94FZpB4030922;
        Thu, 4 Oct 2018 08:35:52 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g85fL-0008W8-Do; Thu, 04 Oct 2018 08:35:51 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 91BD6121465; Thu,  4 Oct 2018 21:05:50 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v8 02/10] edac: synopsys: Rename the static functions to a shorter name
Date:   Thu, 4 Oct 2018 21:05:20 +0530
Message-ID: <1538667328-9465-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
References: <1538667328-9465-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39850400004)(136003)(346002)(376002)(2980300002)(438002)(189003)(199004)(81166006)(81156014)(5660300001)(50226002)(8676002)(7416002)(36386004)(6266002)(48376002)(47776003)(6666003)(5024004)(14444005)(50466002)(8936002)(72206003)(478600001)(36756003)(106002)(52956003)(126002)(76176011)(316002)(51416003)(16586007)(476003)(2906002)(90966002)(11346002)(106466001)(42186006)(2201001)(44832011)(186003)(54906003)(4326008)(356003)(336012)(110136005)(426003)(26005)(305945005)(2616005)(103686004)(446003)(486006)(63266004)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4758;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT024;1:Ttzz5Kohao9Kp2h7SoPpzIWjM6nmIX/5fVH1/xUaX0mD5Kao5JTSTTS6Hb6pdP8BKMsE2ChBPGyxjeqs01/iWWWasCfbpuVaCApGBLjbVQbH9I5I0wSaSU89vg7g8ECT
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d517054b-2b20-4962-b784-08d62a0f1705
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4758;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4758;3:vXAEgZPjZPl0MOUEttPi6A5449Z09nBuMBg+vI3gJZ/stxEiiViosIFpYkL70+LoA0yIUIobTUt8wPgJlW//9w6APKiHji8+JNWuzqThYdeVe67KSI+yHCf13VCONC55uHOWrId+vyZG81hTr7/ZlgY01QjSWK621UTu0vmumOA7j1GpB0ZEqjA8GgI+i/blEm+VSpRVg9d9r2+tFLLUeOG9Tak003Vc+CuaM5VZk4HC3hOufDSyE8pooawuxutvIdtIj6BB3YTiQJVwkfzGeWXjSDySTyfpW3coJiZXHOmTbtYuTrRX/UynYmdobkHK1o0GB3KnaOHJ7Ob123KOKrh0+aQhKvarKbJgfJH/tjg=;25:u4F5mQ67O7IPbMP8zdMEduJRNZT8xuYcxqj/+4itshh0ieI53xtorQBlkWmVMb+aEmuidE9tvLjrjKRMsTOd77lDxDEOgnedgVJsLENKB6Sk3gj/IdS5lSInBt1ujHEJpLpqWM7MW+aFqk19RRALvTzhf6nAAc532z1tDAlsyURR+m+QoeqwX+pBo5NKjiNIIbWEOwv1jB/Dw4C1fKXgfOqfZktK03cS0tILxPfsyRBe7/M7PnMIhcno+BzfkXZrO82rCeEaAnbV1A26n/SBmK0hwNOXc1EZgx14P5bcO9EmqdC7IUCQZHdTEGc2RI/e/4sKSo3ZbVbzn9An32K3iA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4758:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4758;31:yHSeIMas9MDBQn9WyogvtV9P0dvOG7daQugMGKucAAwOf00FVYToC7uz61bSKq5SudDdLfcUMeSLIEhu79P1GyIXEVI6N7oXdOvCAN42BesmqkI+4Xy30PN/z92Mjnmku6Hwn9DOsx3VImyRPqUQuAfdAmVV4YbZWlC423DbRZRJIzVzmr9mLCPsO/dFNJgBi7pmrV5vcPH1o7iWZbVCO4KM5BYzGkRbmJNq8mW6kD8=;20:EuetuFHj+hoPBMttUJpxLjsFJxSFmkSyDfEJLhlz3E/lDXUD3+Uibij+8YmuSlHKX4RbploL2ttzXVAIuyErdx6ucPMhylgdAvmUOTSkFHYqEa+l/dPMpbm0/i62YiWAHkt+MHjofV2TNvZ3U7/fDbHcAQaY3rRDRKCjb9E0GUhouUP2qrdvEz+UoW/Ouj8ylPNwjyqzFeMPjKYzf7MzGIq8VO2XB60cwOhjS2i3O+jGnyUFO2rTlIgGxM6hN0Ssq/QY/+NyTDX7C+vaD7rLAS1Bm7ez4hAyVwWl5seF7VEZMatM9ntQm+w950TpuGAt7T/5eAlP4yQtr6VO96pAKV0KFqk+rpwvrpQ3qPcBp/TfDf1QdhAHAkANnvLm/KllLnGzDOGV653K4cpSaqh/q18mbQPu0fvhT9SLjKeZrn5h3RfQRqRbSgmkU7PXztjWnzeoHRhj+J0KRa5uqkGnXutbxFTyfOUxXbHgVf8t9CHVEWB2fd6d5CdrJ/wCbEZj
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB475835D812E323AD158D0D7EC1EA0@BYAPR02MB4758.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:BYAPR02MB4758;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4758;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4758;4:D94xgGtOrBN3Q0QCrCKdOCE4DBlpxJLmqzXf+X/ZluROewSegXm245bVxAC+5YjLHl/uzE+WCBUmCBuStbf5Hpdiw4rWVi8g+3I0lc9gwW5znHk8I7P6TY2YSMsYuc/9J7+QYBodyV00fczclhRFT9BZKcpnNa8+hR7pxy1tAVZrjNL/LwJTMayC/66hviPRBNgiHy/yy5sTmJEngZhXUj1nVmi1AbfHDYc9vEYiTJlZm253038SGjCF/Obv0M0R2s/7sC9AgKjIYtuoLL7vJgWK74f0GJMYsotG7dsVKgf8PBzoF5qCGwiPO19ud/HWmmNu6MQmWpAYIT6ptMXk7TT8cjE+gUjZH/R1J2uI2h4=
X-Forefront-PRVS: 0815F8251E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4758;23:K0McguQ5TPCdQMjdnGTs6fy72/vQRT2KtE+L922vd?=
 =?us-ascii?Q?pAG3MTVk6F41bj7O3ODS0PVVwVbld9oeDIKMvA3YwypH9VF0RJ9yFDMO55kZ?=
 =?us-ascii?Q?P5WCfZB2rZGj909knRmKZvGb1ZYbrNCJ1jrNzWIuA+CXqMbz+cGZoUn2Qgig?=
 =?us-ascii?Q?mpVa/inFu+1RxXL+9F40ixHCGk8hVK6jDxNxEJBp9CIAw0YquScrns5Jt8Mm?=
 =?us-ascii?Q?l+DEkmzVaYDaalsEi+x8zIRiwrZHYm3/wosDcpTs2aL+5LnRIUOUjY0u3eX+?=
 =?us-ascii?Q?ANoMeUcIS6O6U+0YW8XEI1dBZbByxdsYmInNE98yluYA2HX91QSgly8IzLdW?=
 =?us-ascii?Q?LO/8eH03xZvQ4UBQapw88bY0tz/NRpKBMdD0WU4ARxQ3ED4tKqU20wnuZFaS?=
 =?us-ascii?Q?b+M/2vblCSu160xw1uHi+z4PSpZHFo1cD+o3kuh14srl7+rheXNxa2HI+Pgh?=
 =?us-ascii?Q?YMABwEMmgdEZJpjVBrnNsVQeCMev8q4vylIdjqz3wvVOyEIiDBuYEOhmk9iN?=
 =?us-ascii?Q?6eSJ/Dxjn+o/GkQrZq8KWQSEGME2HqSnI/uZ0DOADbcFLqh20BujL5wTLGMD?=
 =?us-ascii?Q?wiA9+dfg7R6gsVgrvjayp7ZfSnHPF361V5jlGYP0vW8BqzB0dcxI83rfjKjD?=
 =?us-ascii?Q?ssobBWIKiEyqhyw6NbrRodJAIOxZ433HpUMFhGQhzOEuRw+Ocp139Aq5L5rY?=
 =?us-ascii?Q?djZEDtdO45iqUkB69pE+AuKUCJtE9nf3QO875HOzgMhHywrVanHqGYRU33nj?=
 =?us-ascii?Q?T0BeinAyDMAdH51LrmlBlAm3O8IFe4zJ5pIiDDKa2SV+GjFEwGDZzKG8jXiq?=
 =?us-ascii?Q?dAbxQ7vXkXGJWAxyXDbhclH2x/HDNyzHwAAkZSBO48p0UcB1O26QBeMk71Gh?=
 =?us-ascii?Q?tX9mZIX+4Pjog88+auK8TuJInzjBf6so1Hs8ZNXnZbSbrL8Z1i74x50clzXB?=
 =?us-ascii?Q?B1PJ/5poFK/1K9KaNAn3ys2Skw8RxrotqyGbec84fxIW4NlAB+bdvjrfPFIg?=
 =?us-ascii?Q?WNBqqnqe7ZH0MBmeWcOs/DFcFHAUUgwLnGLOoNGMZP/LJBj9EwjdeqaBgSIZ?=
 =?us-ascii?Q?mxV8TNrErOuty1FYpfSs6kcKZE5U5VaJ629AlUJ6WrKFnah0XzJLJkQHLIp4?=
 =?us-ascii?Q?8uirarhJqAjOlme7g8+ZwfEyfYeWfxhn1qBvB6LLaL/bSCGx2toLOTeET85B?=
 =?us-ascii?Q?Xu6fzhgJTFEr1c+5cLbl5bcnQXlzVAba6Abf/LxpOC3SQhp6a2aAmMQqQsYz?=
 =?us-ascii?Q?JeMKapS7BewAU0pVAl+sZDI8d9IsPZPusGxOlyq?=
X-Microsoft-Antispam-Message-Info: 2zoRnvrYwosSzLPu7mvBevwaYP4ryfe8prymb7KKoNrxiLTNTM46Jj8pUd5OaTDoXDySBdXB9Yf/MMpaiJK5pfkTA3TbddLi7ZnsqfIFBXgU88/2AYQU1fSjQ3CARYuhFC9idOMO4GYLW+xQ4734eaQo2TYqSN1SZWoj0bBU0g3Jo1CN0muGh73VWHkTzkKWneSDNHKshdeJr+Eko6rt7jBM2K1QaeW+hXafj4lvAZ20DYHZOkQrJDhvwSjyip+6ymCbiT0cKQS3bFlGfYkiiyvhgTFIgbmvPFBzvtEs/HkV04XwEUyjEeRjDjpjpSqMey62ZwQbt4YpeiMd1OFx9645v75jn/CDvfB1lqrJKGY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4758;6:ctR7YITlhY/qSQk8W1Bw+msuBu4GVBuUqElrxMAAXYKFifvJgBwdEBhbQORvw0gjIIUfU14/cgRTTGic8QGunpD9KyhTydUPrBQtJx9UlaayGsKoWOn7OP5WqZskGcFxBlQbkWnR+gsuF7VEPLDMNwEl2tP1adwHfW3BvpRoNSsfU/Sy/qVuqgawZ5qpJUM72vRM1YuQy3z4IyWcePfMGofVkhNmWYGZ7GQKRTQUN7Hgb/mnyXXtuQTudmpcO0LtQTW8dpdJXCWgE1O0Ag4yYEpxKIjecfhrJdiATpdesCmaOVPBq6TlCozjOz9vlGqk3mNzMIBgViiTAACC141/9zseCHBRn0E4jpSZD+xXpDbcwdsiV7HA44nE0tjAOQdrfzwWHKYRWotGsS9RQQrpZKzSC6RUcd7aekcfqpOdwAbUg/ENmQBOYKXenR7AaU5+slSonbPR5c3z2xw+ObAd9Q==;5:EZ45xCuYT0X1XDrrPiLI37b7xwKpgHk1CxmAHxpgXWslmQBrUXEIYJuyp3hXq1f4hHWnXm/k6s9UFBnHbiBgwYNuI1N3Yp5q6lEUKFbS/Md/DZWrLsO9rywYKokNqnDo+2zXULorrKqKxEGExWi5pxAkjqYV6rOTiCdzk7SGRJQ=;7:+DAEUIL4fcmFNC8suOVhbZXh1HZSeTvheNF8tZsL/G5zeHUN4wkER1FE8Rs3eL84dC3V34Nd8/zci3iqRDzt4a1gRcZwcZvPbOJ6de2PsOkY6Odz4ghVRAwuNRyE7vAfGr2rfviPXTReckZb9sTzuMwknMVphWmtXv+Ecd5osaezkZZkQ51FL3arLioBrNbNIjet4WUc9y2a2XlpUcDdzqTR4AyITDlv2bxVerCziaF2qMRz3bH3bXV2LSYQpzDS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2018 15:36:01.3474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d517054b-2b20-4962-b784-08d62a0f1705
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the static functions to a shorter name. Since this is Synopsys
EDAC driver, better to remove unnecessary 'synps_' prefix in function
names.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/synopsys_edac.c | 56 ++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1936c73..abb5de8 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -142,7 +142,7 @@ struct synps_edac_priv {
 };
 
 /**
- * synps_edac_geterror_info - Get the current ecc error info
+ * edac_geterror_info - Get the current ecc error info
  * @base:	Pointer to the base address of the ddr memory controller
  * @p:		Pointer to the synopsys ecc status structure
  *
@@ -150,7 +150,7 @@ struct synps_edac_priv {
  *
  * Return: one if there is no error otherwise returns zero
  */
-static int synps_edac_geterror_info(void __iomem *base,
+static int edac_geterror_info(void __iomem *base,
 				    struct synps_ecc_status *p)
 {
 	u32 regval, clearval = 0;
@@ -196,13 +196,13 @@ static int synps_edac_geterror_info(void __iomem *base,
 }
 
 /**
- * synps_edac_handle_error - Handle controller error types CE and UE
+ * edac_handle_error - Handle controller error types CE and UE
  * @mci:	Pointer to the edac memory controller instance
  * @p:		Pointer to the synopsys ecc status structure
  *
  * Handles the controller ECC correctable and un correctable error.
  */
-static void synps_edac_handle_error(struct mem_ctl_info *mci,
+static void edac_handle_error(struct mem_ctl_info *mci,
 				    struct synps_ecc_status *p)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
@@ -232,30 +232,30 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
- * synps_edac_check - Check controller for ECC errors
+ * edac_check - Check controller for ECC errors
  * @mci:	Pointer to the edac memory controller instance
  *
  * Used to check and post ECC errors. Called by the polling thread
  */
-static void synps_edac_check(struct mem_ctl_info *mci)
+static void edac_check(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	int status;
 
-	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
+	status = edac_geterror_info(priv->baseaddr, &priv->stat);
 	if (status)
 		return;
 
 	priv->ce_cnt += priv->stat.ce_cnt;
 	priv->ue_cnt += priv->stat.ue_cnt;
-	synps_edac_handle_error(mci, &priv->stat);
+	edac_handle_error(mci, &priv->stat);
 
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
 /**
- * synps_edac_get_dtype - Return the controller memory width
+ * edac_get_dtype - Return the controller memory width
  * @base:	Pointer to the ddr memory controller base address
  *
  * Get the EDAC device type width appropriate for the current controller
@@ -263,7 +263,7 @@ static void synps_edac_check(struct mem_ctl_info *mci)
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type synps_edac_get_dtype(const void __iomem *base)
+static enum dev_type edac_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -286,20 +286,20 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_get_eccstate - Return the controller ecc enable/disable status
+ * edac_get_eccstate - Return the controller ecc enable/disable status
  * @base:	Pointer to the ddr memory controller base address
  *
  * Get the ECC enable/disable status for the controller
  *
  * Return: a ecc status boolean i.e true/false - enabled/disabled.
  */
-static bool synps_edac_get_eccstate(void __iomem *base)
+static bool edac_get_eccstate(void __iomem *base)
 {
 	bool state = false;
 	enum dev_type dt;
 	u32 ecctype;
 
-	dt = synps_edac_get_dtype(base);
+	dt = edac_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
 		return state;
 
@@ -311,11 +311,11 @@ static bool synps_edac_get_eccstate(void __iomem *base)
 }
 
 /**
- * synps_edac_get_memsize - reads the size of the attached memory device
+ * edac_get_memsize - reads the size of the attached memory device
  *
  * Return: the memory size in bytes
  */
-static u32 synps_edac_get_memsize(void)
+static u32 edac_get_memsize(void)
 {
 	struct sysinfo inf;
 
@@ -325,7 +325,7 @@ static u32 synps_edac_get_memsize(void)
 }
 
 /**
- * synps_edac_get_mtype - Returns controller memory type
+ * edac_get_mtype - Returns controller memory type
  * @base:	pointer to the synopsys ecc status structure
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -333,7 +333,7 @@ static u32 synps_edac_get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type synps_edac_get_mtype(const void __iomem *base)
+static enum mem_type edac_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -349,7 +349,7 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_init_csrows - Initialize the cs row data
+ * edac_init_csrows - Initialize the cs row data
  * @mci:	Pointer to the edac memory controller instance
  *
  * Initializes the chip select rows associated with the EDAC memory
@@ -357,7 +357,7 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
  *
  * Return: Unconditionally 0.
  */
-static int synps_edac_init_csrows(struct mem_ctl_info *mci)
+static int edac_init_csrows(struct mem_ctl_info *mci)
 {
 	struct synps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
@@ -367,15 +367,15 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = synps_edac_get_memsize();
+		size = edac_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_FLAG_SECDED;
-			dimm->mtype	= synps_edac_get_mtype(priv->baseaddr);
+			dimm->mtype	= edac_get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= synps_edac_get_dtype(priv->baseaddr);
+			dimm->dtype	= edac_get_dtype(priv->baseaddr);
 		}
 	}
 
@@ -383,7 +383,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 }
 
 /**
- * synps_edac_mc_init - Initialize driver instance
+ * edac_mc_init - Initialize driver instance
  * @mci:	Pointer to the edac memory controller instance
  * @pdev:	Pointer to the platform_device struct
  *
@@ -393,7 +393,7 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
  *
  * Return: Always zero.
  */
-static int synps_edac_mc_init(struct mem_ctl_info *mci,
+static int edac_mc_init(struct mem_ctl_info *mci,
 				 struct platform_device *pdev)
 {
 	int status;
@@ -415,10 +415,10 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	mci->edac_check = edac_check;
 	mci->ctl_page_to_phys = NULL;
 
-	status = synps_edac_init_csrows(mci);
+	status = edac_init_csrows(mci);
 
 	return status;
 }
@@ -446,7 +446,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-	if (!synps_edac_get_eccstate(baseaddr)) {
+	if (!edac_get_eccstate(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -468,7 +468,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
-	rc = synps_edac_mc_init(mci, pdev);
+	rc = edac_mc_init(mci, pdev);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Failed to initialize instance\n");
-- 
2.1.1

