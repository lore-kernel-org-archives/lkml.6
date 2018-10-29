Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709C8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B012082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="H9vaSJdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B012082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeJ2U7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 16:59:43 -0400
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:18550
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729227AbeJ2U7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 16:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCwBNkq5YV3SFL7VDJ//JK0pcATJV/0az4MD1lYHHRU=;
 b=H9vaSJdBe1S3BjtwBOSvsoj6s+fiLg44nu1NvwXwdIGdnGNCNfe3D706iy0TvelmIEsG2J5MK2YXE5ZtBllJrxLRjb4WJXSyBvmzK9QlIEyH57vbrUedgENc9uK+URoadBmFdDhoLajuQ2jwKjfY+qKgA1A126n05XycI/BYFDY=
Received: from SN4PR0201CA0042.namprd02.prod.outlook.com
 (2603:10b6:803:2e::28) by BYAPR02MB4454.namprd02.prod.outlook.com
 (2603:10b6:a03:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19; Mon, 29 Oct
 2018 12:11:11 +0000
Received: from BL2NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0042.outlook.office365.com
 (2603:10b6:803:2e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.19 via Frontend
 Transport; Mon, 29 Oct 2018 12:11:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT025.mail.protection.outlook.com (10.152.77.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 29 Oct 2018 12:10:59 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gH6Nm-0001M6-T9; Mon, 29 Oct 2018 05:10:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1gH6Nh-0007lx-JU; Mon, 29 Oct 2018 05:10:53 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w9TCAl0R008116;
        Mon, 29 Oct 2018 05:10:47 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1gH6Na-0007k5-H0; Mon, 29 Oct 2018 05:10:46 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 9DB8912147A; Mon, 29 Oct 2018 17:40:45 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <manish.narani@xilinx.com>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <olof@lixom.net>, <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <linus.walleij@linaro.org>,
        <vilhelm.gray@gmail.com>, <geert@linux-m68k.org>,
        <freeman.liu@spreadtrum.com>, <rdunlap@infradead.org>,
        <tglx@linutronix.de>, <baolin.wang@linaro.org>,
        <gregkh@linuxfoundation.org>, <jdelvare@suse.com>,
        <linux@roeck-us.net>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Mon, 29 Oct 2018 17:40:24 +0530
Message-ID: <1540815026-1012-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
References: <1540815026-1012-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(136003)(346002)(376002)(396003)(39860400002)(2970300002)(438002)(199004)(189003)(50466002)(81156014)(5660300001)(8936002)(2616005)(50226002)(44832011)(2906002)(476003)(126002)(52956003)(486006)(446003)(81166006)(11346002)(90966002)(426003)(8676002)(186003)(26005)(305945005)(336012)(2201001)(48376002)(51416003)(36386004)(42186006)(76176011)(7416002)(63266004)(47776003)(103686004)(54906003)(478600001)(356004)(36756003)(6666004)(72206003)(110136005)(16586007)(39060400002)(4326008)(316002)(106466001)(106002)(6266002)(921003)(107986001)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4454;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:3;MX:3;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT025;1:KrEgZJx3BPPsaa3lk34AP2O9EVPUAgjwkTg4zRRmG3oUbQpbWfjnOfbWdD9P+3oP9oGGdJx6SZUKd4yS7St7MvB6OVVFae65Q0+49ZAWajcCG3NNzHrfDkKQYl6YraWj
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e71b2c9-1b8c-4d58-ccaa-08d63d979cb9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;3:DMddSi9ltKlhjmaZMYwY5x3jQSSmBSsxFfopX2PVsxArLqOJwXRO/yZhDhqTgGTIHwZeaDqK1bBeGPN89HOtxJbONlK0UCcellFsvaqyfx3SDfU5Bu4uK7i6bCE/jYDN2b/spRkWV2OcVNbw0PHd/FyoEXEdZHXwQyfaKKIpyHFVkb1Fi6YUorYmc20YjI0pS/Dlx/ROoKSwkRJcjhHlRWOMWdnJNu5qbnioWDi6vUWgckqAb+wWskZ/YAfdZNyxfEfU8eznCgYJk8a7EZ7jg1HrQHIF21Z9QDKEvvJs8ahz2VbW6JBf0vhygrr8jiuimzvhs6S/1rJTc+TCBhG6WUU+BSVJtWNzszdZdHFyt7s=;25:+AtBAuY+a4IvP0zO2b0SrhLtZf/vVGpJD3m6H6u5JfMMCzLM4yHayOz5TGLfqJDjZRlX3AsXGE/w72N9ieVA4cxdSZZQRd3pxgbnob1FJH7FUX8tTsNO9X2DKV+tVnvI2vp87CtWpu4dnvBs0ryYdsnXJk9RBdmp5wOodw/ZEPKKC7byDhKhNmQRrQONJ+G7EUHisrRJBdOncJh7ba8s5ivpYIwtLj0DP8O3BqK8TqaRSn1ZiqpdOtWgQGrqyuY8r/K6I4+gFnRDSDrxjbmMDTgjv4/60COefzUeFWqY3Hm5C6ktgqjNisRH/DAsMuiIodz2HHe4cIowQHobLFoCRA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4454:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;31:k2KEn2qdkd18USkQ4GleoSeRod/h1HFUSNcuD5v5S5ruaxeOXrZwioMr1DTvIxvGhIomknFHzGNteYFcfOu6OgvrPz3uF3spKwrOGVaVjCCctTljUEl3j5gbU84h4YCiBVds3tBZcXV/xG6UATsmBWB3J/uRoOFKBp/86/WaeKPTpQZrXTftwytCWT8+L1B1eOdEyrc7WEtR4yoS2pXuGrxLpohUYoB5g4Q31HMjUDc=;20:WIFZcjz7XeImN/wzae9o7WJbIvYDBZD9raEo95TC6Uw1vNPvdrd/tPAjFw528sDHaunXygAQfbpHzbp3toGnD6N2HmEqZDs280szahTx4CYIlcCQCUZ/ZaLmbHPnCtKkpUuBOg46KLTCWkuaSNG2Ayp9mZh953svyjf3FlFnOSCJ19ByXc/iHYfapQu0RO81bSDihtOfSoZSuhvO37b57dqq+oV+S4HM+tNskGGc0WEeVqtaQkAaIvjFmNNlBNVozgPtsHR95IGZ0nvzzdg5Gvzg45afUeyuRJbDyspixZGhOEi470IUHMLqOLpfU7rzkdmF5XJz9/zvBwcP3ZqSBpEeiaRjewS7Ec7ZyNGxy2H6kvaH72v78aRDsY4ROFsaspAzZBbygYPvwj1ypqToEReTzkSa7XTtoDGAh8wTMmC8SZInYs5Q9fyEBv7ZvsWkAT/Amd7Wm0moD4KbBo4pworDTFby7hdd1P4Sp25Ks/zV9WJ/yhsuil6/LYUM6rmd
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4454C256C979C99B3E0CC118C1F30@BYAPR02MB4454.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(72170088055959)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR02MB4454;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4454;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;4:G5tLS2Ceh3S0KNRH89/CxtIeLOfLhhM1LCeIWUK/mJ+YozDJ/n44hYBuBpj2+fEjaQItnCo4ppqR2f/buJIENNWORAxk6PP7Fxl2EFkwSs1I3JII+UYJUENVKwTxcA8fQk4RcPWfsSFCL4KW7BuTIKZMS38cQEAocQtiitlPvMWJEe6tEsjvBq0PRW3RujKuLslf+ImrdZGfeaGyebjCsLzgYQsAwJwW7Dh8fiY/qp0GfcUS+DXIaj2lVAdjXaILKLtejGHXow/bVm8eng0xzlmSjggUeLBVME9vsnzucex/G+8IiBXmG4xws5Rsx+masK1kS4R7/Y93+m3BbBKoHpyjPWiZ2nfyY+bEPWDdnOj9x5oZ50JGabUDoQmXkpuS
X-Forefront-PRVS: 084080FC15
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4454;23:gGLJsJuI0TZ8waccFFtsgCVT130J3qZMspvxF/rdy?=
 =?us-ascii?Q?FdgUSwO22BIVn2HjzzdAdEqdNNkQIBU9H2ojPRVxBd7aQGFQeDzZKROjp0G3?=
 =?us-ascii?Q?iJllyZ1apa2XlLJKcy0LYDHQAyQyStXOXU5CJlLGrkFQLVzeBqk3jcd63B+1?=
 =?us-ascii?Q?ejlbEHK0gvDH6ZVAgpsL0f7ZNhbyOaVvlV4iyKS7fPLGQEh+n94spzk+PNfP?=
 =?us-ascii?Q?0Pl3oZjBJpeKWjkwPemIx8bBq71jxWmQet1zMT51hlZ0bNIcZM6z0+LWXoex?=
 =?us-ascii?Q?zlMd1CNWgz69qB6C+gfUYv7vFRA5Y/mqFsSu42sb1kgbLvR9bMUL52DclyRd?=
 =?us-ascii?Q?wJ4sVNcjJeFTj5nQFapsa/ogXuC+bqcaE8XkGrN8+FYZTZHVxyl4+NU193aL?=
 =?us-ascii?Q?eCssRnt32YHyijqOz7XZnInddzIsam5q++MtdijXHjNZCEO/71JVtwacSoo8?=
 =?us-ascii?Q?H7ynDU+BUGsNLTYVVEEPIyFk2WiIAt9ucxDfj4Cx3UZyaeXCTV0bCBNRWXHG?=
 =?us-ascii?Q?iKZpZm0X0TAzdREcK7FVPT+9q0yQLvcmVEBXdWILJqcrTOp7cWO2wSIxBiY9?=
 =?us-ascii?Q?Qy9llziIfUHfAaN8C0fw5cViYlKHhg/9icGr09psfhoYAD8Lx8SMg2KcS5Ev?=
 =?us-ascii?Q?n8C/dsXm1yo2yF3bepyj1rQXZ5z0KlI19/UWUNnO+t12WXAdr54hQYnyMLPP?=
 =?us-ascii?Q?B3r0a9wv87aZd3mwOKpi7lL958BZa7lBG0bmq4BSFFNiiRDtjEjzSTd1mdyU?=
 =?us-ascii?Q?D7a31vxtetrPmqrr2AjPcBTfXjUUfkqXJCpZ8OkvRZGdohim+ZIkoYuQqKch?=
 =?us-ascii?Q?mDlOF5k5EAN6xUN5OBkadt29RNdoY+UMmYL8oTYeG6n0ONak3cZhTeaIwY+9?=
 =?us-ascii?Q?BnYGJYhwH4c6kpYBvmwTo95z8atbxyeuOO7HXWjnV3Rxc5xykJM+nH8BjMfU?=
 =?us-ascii?Q?13WPswYE48CbnNbVJBo0E6K0z9ig2J2CxO2FtjWBW3W2aPgk8cA3oPO0Eosj?=
 =?us-ascii?Q?5FoKqlPVH2G3VLi9NhzGGXQEhPdEXKnBGnvsfIfvlqqq4VA5nJ2BEdSAg0y2?=
 =?us-ascii?Q?an2I4zNnXLA2NsoBMoqcPKUY9KuiBwv80zxB2+xbOijBFfD6UtGkhwjt3d/N?=
 =?us-ascii?Q?myHZYPwGIoCGgRXO4MKo5aHAZ6DPcMqfQT0gkSaIs27Z7DZJK12idm7hi7yy?=
 =?us-ascii?Q?e640cWwiEu0YgRvgyX7Ao0DHKp99Uj0mYQnVV5x1z/b0SvUuN32tyA3rrETh?=
 =?us-ascii?Q?4mlTkiNfzMhBXlbogb9eakJpSseie+J8brjWBi5cGEEe0VmOiUjMRhL9ou8o?=
 =?us-ascii?Q?ShZ6HdZ4QcjqXfGq438kowms/uQtVMmHXT0/r+hi6T3?=
X-Microsoft-Antispam-Message-Info: 6J/NvtK9no0Ji8gHBV8DTMZYNh6s8X5CqzX49JtnvWdmykeW0w1MxL71gkcgbwV8cjnseHlz+yeGShr3FWs5rGEKpl34ObjC17g+Zo1UlxtTsAsRFHSxooPMfj7W6HjCb0G9vSpbqwRgzgxNeFClWmYol01ikRjw1Ewk/4G6EGnrgp/5KumQqXWDc3HvY06aiZTTW/rCTvZ8AkhmYqt+EsyhnMs/M/gQHK3jrJURS4j3Q30hRsuG8x6PvqvopsMtIe7DY6IaJvmj9Qe4jmkKeZhgX/QgkMzihCrmNVnqMlFKT3FSrKhyad8ynBlGm3diE+aT0hF74L8HMjAT20gMbJPRZnv7vLGOly51QFoUvFw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4454;6:yecqr+BDp14ZzsTvO2U7ApXJonXrT6iRSkClFkh1cQwJo4ulqu9Z5FGFFqmqs7Y2Uc/WY6D0h+haxsypAK2e+h1AJhedfNJYt53BooUQgC82dLmoMtvWQq81k4QyfilnLYuaF7SxKj3jS6PE9U4rid4HgLbLgbBhCTSwzLUsaKPCIJ6VMMA6RSH8BqpiLxMDtX5zzXhoqioU9hXdVmsQoYa/TEAUOQDJKNz9pfABF3ojH2pEIQtsoqzALT2VI2mAZ0E2L2WDo7AuzeQsNlgBoomXCH5MI9P433SjmOzWwwIz0OQQvzUHL9O2mMozRcYMs3SqDxsFW8jOKzGDV0s0jY+NenyISPjjFZZmgTpyRCZr/m+U3uVPl/RAqjZS5ITF8kR+abbaXh/NxvekAkHx3eq+GiQ9r26T6+zAvoE1/OKJkrbh9qpmAC+4OXieijiRm4Ywznfs5YH/j7h+GpjP+Q==;5:bN7L4l8gq94hdntdMwYcBSHkokRH0NcOv2o3HaCpe9NdtPpaQR1hT1ezc4vFeGRHlBT8uQfXebj6RZAf2crmRyaO5WRF70RYYp/E/CsOkmrGDJ90xbEW/KGNUvuyOBgp05poJzLYv3g2N+B4e1QO7oJ/0OG26ZL6FcvEKJpz9LE=;7:QixF0aFpNfxwXOl97BixNk6eFCVcv5O+zyfcvzxBuxNRABiy2jKOf3vfXYYYXLHibtvYIrFT5sKrzFYws2pMs+ro33nH5ez/vV+guR1Ty55J7VMqGkApcTQuqDOSs0G2ZmJDxps8mAYPLxMfaOfKfg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2018 12:10:59.8748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e71b2c9-1b8c-4d58-ccaa-08d63d979cb9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx AMS have several ADC channels that can be used for measurement of
different voltages and temperatures. Document the same in the bindings.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/iio/adc/xilinx-ams.txt     | 183 +++++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
new file mode 100644
index 0000000..1635576
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
@@ -0,0 +1,183 @@
+Xilinx AMS controller
+`````````````````````
+The AMS includes an ADC as well as on-chip sensors that can be used to
+sample external voltages and monitor on-die operating conditions, such as
+temperature and supply voltage levels.
+The AMS has two SYSMON blocks which are PL (Programmable Logic) SYSMON and
+PS (Processing System) SYSMON.
+All designs should have AMS registers, but PS and PL are optional. The
+AMS controller can work with only PS, only PL and both PS and PL
+configurations. Please specify registers according to your design. Devicetree
+should always have AMS module property. Providing PS & PL module is optional.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams"
+	- reg: Should specify AMS register space
+	- interrupts: Interrupt number for the AMS control interface
+	- interrupt-names: Interrupt name, must be "ams-irq"
+	- clocks: Should contain a clock specifier for the device
+	- ranges: keep the property empty to map child address space
+	          (for PS and/or PL) nodes 1:1 onto the parent address
+	          space
+
+	AMS sub-nodes:
+		- ams_ps : Used as PS-SYSMON node
+		- ams_pl : Used as PL-SYSMON node
+
+
+
+AMS PS-SYSMON
+`````````````
+PS (Processing System) SYSMON is memory mapped to PS. This block has built-in
+alarm generation logic that is used to interrupt the processor based on
+condition set.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams-ps"
+	- reg: Register space for PS-SYSMON
+
+
+
+AMS PL-SYSMON
+`````````````
+PL-SYSMON is capable of monitoring off chip voltage and temperature. PL-SYSMON
+block has DRP, JTAG and I2C interface to enable monitoring from external master.
+Out of this interface currently only DRP is supported. This block has alarm
+generation logic that is used to interrupt the processor based on condition set.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams-pl"
+	- reg: Register space for PL-SYSMON
+
+PL-SYSMON optional sub-nodes:
+	- xlnx,ext-channels: List of external channels that are connected to the
+	                     AMS PL module.
+
+	  The child nodes of PL-SYSMON represent the external channels which are
+	  connected to this Module. If the property is not present
+	  no external channels will be assumed to be connected.
+
+	  Each child node represents one channel and has the following
+	  properties:
+
+	Required properties:
+		* reg: Pair of pins the channel is connected to.
+
+		    'reg' value		Channel Name		Channel Number
+		    -----------		------------		--------------
+			 0		VP/VN			      30
+			 1		VUSER0			      31
+			 2		VUSER1			      32
+			 3		VUSER3			      33
+			 4		VUSER4			      34
+			 5		VAUXP[0]/VAUXN[0]	      35
+			 6		VAUXP[1]/VAUXN[1]	      36
+			...
+			20		VAUXP[15]/VAUXN[15]	      50
+
+		Each channel number should only be used at most once. For
+		more details on channels, refer to the table given at the end.
+
+	Optional properties:
+		* xlnx,bipolar: If set the channel is used in bipolar
+		  mode.
+
+
+Example:
+	xilinx_ams: ams@ffa50000 {
+		compatible = "xlnx,zynqmp-ams";
+		interrupt-parent = <&gic>;
+		interrupts = <0 56 4>;
+		interrupt-names = "ams-irq";
+		reg = <0x0 0xffa50000 0x0 0x800>;
+		reg-names = "ams-base";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#io-channel-cells = <1>;
+		ranges = <0 0 0xffa50800 0x400
+			  1 0 0xffa50c00 0x400>;
+
+		ams_ps: ams_ps@0,0 {
+			compatible = "xlnx,zynqmp-ams-ps";
+			reg = <0 0x400>;
+		};
+
+		ams_pl: ams_pl@1,0 {
+			compatible = "xlnx,zynqmp-ams-pl";
+			reg = <0 0x400>;
+			xlnx,ext-channels {
+				channel@0 {
+					reg = <0>;
+					xlnx,bipolar;
+				};
+				channel@1 {
+					reg = <1>;
+				};
+				channel@8 {
+					reg = <8>;
+					xlnx,bipolar;
+				};
+			};
+		};
+	};
+
+
+AMS Channel Details
+```````````````````
+Sysmon Block	|Channel|			Details					|Measurement
+		|Number	|							 	|Type
+---------------------------------------------------------------------------------------------------------
+AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.			|Voltage
+		|1	|Battery voltage measurement, VCC_PSBATT.			|Voltage
+		|2	|PL Internal voltage measurement, VCCINT.			|Voltage
+		|3	|Block RAM voltage measurement, VCCBRAM.			|Voltage
+		|4	|PL Aux voltage measurement, VCCAUX.				|Voltage
+		|5	|Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.	|Voltage
+		|6	|VCC_PSINTFP_DDR voltage measurement.				|Voltage
+---------------------------------------------------------------------------------------------------------
+PS Sysmon	|7	|LPD temperature measurement.					|Temperature
+		|8	|FPD temperature measurement (REMOTE).				|Temperature
+		|9	|VCC PS LPD voltage measurement (supply1).			|Voltage
+		|10	|VCC PS FPD voltage measurement (supply2).			|Voltage
+		|11	|PS Aux voltage reference (supply3).				|Voltage
+		|12	|DDR I/O VCC voltage measurement.				|Voltage
+		|13	|PS IO Bank 503 voltage measurement (supply5).			|Voltage
+		|14	|PS IO Bank 500 voltage measurement (supply6).			|Voltage
+		|15	|VCCO_PSIO1 voltage measurement.				|Voltage
+		|16	|VCCO_PSIO2 voltage measurement.				|Voltage
+		|17	|VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).			|Voltage
+		|18	|VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).			|Voltage
+		|19	|VCC_PSADC voltage measurement.					|Voltage
+---------------------------------------------------------------------------------------------------------
+PL Sysmon	|20	|PL temperature measurement.					|Temperature
+		|21	|PL Internal voltage measurement, VCCINT.			|Voltage
+		|22	|PL Auxiliary voltage measurement, VCCAUX.			|Voltage
+		|23	|ADC Reference P+ voltage measurement.				|Voltage
+		|24	|ADC Reference N- voltage measurement.				|Voltage
+		|25	|PL Block RAM voltage measurement, VCCBRAM.			|Voltage
+		|26	|LPD Internal voltage measurement, VCC_PSINTLP (supply4).	|Voltage
+		|27	|FPD Internal voltage measurement, VCC_PSINTFP (supply5).	|Voltage
+		|28	|PS Auxiliary voltage measurement (supply6).			|Voltage
+		|29	|PL VCCADC voltage measurement (vccams).			|Voltage
+		|30	|Differential analog input signal voltage measurment.		|Voltage
+		|31	|VUser0 voltage measurement (supply7).				|Voltage
+		|32	|VUser1 voltage measurement (supply8).				|Voltage
+		|33	|VUser2 voltage measurement (supply9).				|Voltage
+		|34	|VUser3 voltage measurement (supply10).				|Voltage
+		|35	|Auxiliary ch 0 voltage measurement (VAux0).			|Voltage
+		|36	|Auxiliary ch 1 voltage measurement (VAux1).			|Voltage
+		|37	|Auxiliary ch 2 voltage measurement (VAux2).			|Voltage
+		|38	|Auxiliary ch 3 voltage measurement (VAux3).			|Voltage
+		|39	|Auxiliary ch 4 voltage measurement (VAux4).			|Voltage
+		|40	|Auxiliary ch 5 voltage measurement (VAux5).			|Voltage
+		|41	|Auxiliary ch 6 voltage measurement (VAux6).			|Voltage
+		|42	|Auxiliary ch 7 voltage measurement (VAux7).			|Voltage
+		|43	|Auxiliary ch 8 voltage measurement (VAux8).			|Voltage
+		|44	|Auxiliary ch 9 voltage measurement (VAux9).			|Voltage
+		|45	|Auxiliary ch 10 voltage measurement (VAux10).			|Voltage
+		|46	|Auxiliary ch 11 voltage measurement (VAux11).			|Voltage
+		|47	|Auxiliary ch 12 voltage measurement (VAux12).			|Voltage
+		|48	|Auxiliary ch 13 voltage measurement (VAux13).			|Voltage
+		|49	|Auxiliary ch 14 voltage measurement (VAux14).			|Voltage
+		|50	|Auxiliary ch 15 voltage measurement (VAux15).			|Voltage
+---------------------------------------------------------------------------------------------------------
-- 
2.1.1

