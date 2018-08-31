Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56D0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9202077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Oqg0CsYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9202077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbeHaRgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:36:05 -0400
Received: from mail-bl2nam02on0052.outbound.protection.outlook.com ([104.47.38.52]:16960
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727447AbeHaRgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne4NIZ9mVOzZn7yOAaAY9vmkMXX8QjVyqY3FLebjNfU=;
 b=Oqg0CsYBcVA+3XtskuP9euL7W4j1aJgSyry1k5aNG99qZirQ3YdtJL+U3oFiF3KG+35/JZ4msOzkFqmY2B6fzbNN2tkGAZEIPFntO1tb7dXVPZin8/dMekKkv7qXz5ViiJPJQ0NwrnzpD/GxPUiCmEKjscIBrmtZDRefMmM3Lkg=
Received: from BN7PR02CA0013.namprd02.prod.outlook.com (2603:10b6:408:20::26)
 by BL0PR02MB4929.namprd02.prod.outlook.com (2603:10b6:208:53::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.13; Fri, 31 Aug
 2018 13:28:24 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by BN7PR02CA0013.outlook.office365.com
 (2603:10b6:408:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Fri, 31 Aug 2018 13:28:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Fri, 31 Aug 2018 13:28:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTK-0001Hl-TT; Fri, 31 Aug 2018 06:28:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fvjTF-0000Ak-QX; Fri, 31 Aug 2018 06:28:17 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w7VDS9NE024496;
        Fri, 31 Aug 2018 06:28:09 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fvjT6-00008v-Uo; Fri, 31 Aug 2018 06:28:09 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1DF28121477; Fri, 31 Aug 2018 18:58:08 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <manish.narani@xilinx.com>, <leoyang.li@nxp.com>,
        <amit.kucheria@linaro.org>, <olof@lixom.net>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
Subject: [PATCH v5 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
Date:   Fri, 31 Aug 2018 18:57:49 +0530
Message-ID: <1535722070-10394-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(438002)(189003)(199004)(476003)(52956003)(126002)(5024004)(2201001)(44832011)(2616005)(106002)(14444005)(36386004)(217873002)(26005)(5660300001)(63266004)(36756003)(42186006)(16586007)(53946003)(6666003)(486006)(316002)(54906003)(110136005)(76176011)(51416003)(81156014)(2906002)(50466002)(6266002)(48376002)(8936002)(11346002)(446003)(4326008)(7416002)(81166006)(336012)(8676002)(47776003)(426003)(478600001)(186003)(356003)(106466001)(305945005)(50226002)(103686004)(72206003)(90966002)(107986001)(2101003)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4929;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT033;1:XO5u45b4Hf/hL6Ez4GCRlJ5nwea0el0fkL9liUPyM26+U0qWz9BHViL3Omzs2cSNpwpdNZemEYD/Q4z076PfMquZ7ol74PyYylmjWktLC7c/nQnuDWbAYodUOwij0OTd
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 048f61f4-d0e0-4a3d-c5e9-08d60f45a084
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;3:9GQ+u+TP0KKpecFBKK1pWkSGlIZYABVrfqyE91uN80Ij+sisiBz+3K80r+ux08+0xzZlusAo+/7LRTyKOGj8ZrMRTOq5VtMBS1BH7BWjRU6zIcsFOvSDFk/yzMOgqDADDbjwCZRFFqaAj4ASuyuWPWZ4yDlXaZFyr6z8Gvr9V3uaczVBBHbr/K0bSw4eC09o83XyFI/3ddU7ahJUA7XXeaj3dpzm/sNtg65j8ca69i4TEJicawJYFER64ymQ3GbMA6JCuYVaoADJYSPzbJFE99KIX0fX0SPnHmxGYNt7L9RYq8uCowLNQtEODm7yKOA5tNtfxJUuJ7ICKhOe49gzcQvArftRPG8QXI8Icm2cdeo=;25:vdicl0HfYhqFvmJj0m2Sa57jkRDvo3P1f4uhEyMrisFH7CykFIjDg1ku4WMJ3Uzax7iAr8TF2zBYtPbKD2Rm8kb7Tv0C1AjItxQfajfQJTUaIpb02Per1Y8nHYwfTft/9i4MCon4cExua6sA/H5RPySM12LzzcoLc/wEnAY5TdmusHjfCbGddGAZ8iYQia9xZ/l3ejIRz9FqCyF4tpwAZVGzIcw58ZtrmFeQ4/2m88OQR58wh2hMlLAmNf1rdFh4UaYH4VVjYvuYvRxfYGb8cw9GAacZUMJnneUl8bsp/fx0D3MSXYRMgBoAMdIWM1UO3+NZl6ZdT3y7y1AG7gQqag==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4929:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;31:RtodWg8NxbfTVlsCiUj4U//GfohaS/HmCyIvgaeG6Wy7QlQvF0NGLZ0hHSWhKCZ/89R+8XySHXeaousEx/SvZpVxaCQp2VL6WJ7LocKiOkOUsobH2rDJsF4mr695Xl7yLFCXy+s7BEUArAlfjxJcBDALQb0u21QF7nh347rsVumONH+p7MVjdWu4ZlxlS2d+nXPv2GOm2tCNXSrGZTAyA2GdJya1Gy1RfTFNxBgmbUk=;20:K0Y/zyD58TQQccBP+lELF8zORk+vPPNrQu8zjCwX8uFNS9DgRYJLjy8stRF3NjoHNWA7TDnRsGop2qK+Bto+bO52ZkwyMWjBmirdi6PN6DjxR3j2MOmiKEkNtA1wXuFPfHdqpyAYsPc0ka9pATlq+vv5d7Rtw2njqxD0uGP8FG4U8YT1iP3Do9moWan3Py9Lu+FymlbaZIl2yBV9naWEwVcEl/AnxOzwVjXybdEEgVayJB9SGRPm3/JPedUkmv2XCDXI3EEL2YHej0uUzlHbKGzE2BHY4+3X4adJ01DuSjcqBTT8AddKSo+xbTKy6eajL/s9AVbWgtYo+iEA3zruDOmYIGGpGM/k/lqf6b3BJn1J0fNkoHlQcOhwKDdPpPWZZmt7mNRHQFRPUvNWWouv/udpRNfvRMw8SypoWe0mKgh3a+f5RtO41WQcggGwsY73S/omJ2y+GDw6TKLWpz4yUYHoFPA7X5BnGY4DZZya5c2yLOCxbRNdbErF1+AEIXqZ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB49290702DFFB51C22C90550BC10F0@BL0PR02MB4929.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(105169848403564)(163750095850);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699016);SRVR:BL0PR02MB4929;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4929;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;4:kOZdCa33i4zH+CCbPa56fKEaMJ4FYAkem5HgKou5yu4QXY56H06fOgV6nBYVqtVW0iEpg8ylclgvJl0CfzZYhrL4XEgpDngPmjWk25/ekluAbb99NfY1m26K+tffIiAKH9Gkny1dAsLD6q02VeTyJC8NeO8iU17ofd2TIzeZQaQPaqAcIeu2i7YhxBgW+nh6tIPdgOF1upePnA0VtFxyqsiQmsgMxAB/pimjGa7VEtmVRZUtnEEVjha40d1daHcVL8Q2vD83cpDXX9aq/POfdINHvJXVftltDGM2KRU1i9jPzjAKrpGcjc5IOtph4u8ZrjPG0sv9NRyGOndx05ETzbkxz78rQeSlJxgPOE27v7PQ0o/ulGmzkoc+YSMuLvYH
X-Forefront-PRVS: 07817FCC2D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4929;23:L67OSThnCXXfqd0WEk+DpFRJfYeB+RXDjxhNoGoCk?=
 =?us-ascii?Q?FWRuWvWb+0r+GlwDRQQT9LQ38tvbgQX6yy7HIUdzSGbzd6vLa9VnMbJOn7Hc?=
 =?us-ascii?Q?gq9xxx+zbDaFfvRoQPT9epCpzgTVxMt/o/ajjloiNx8wqvTyNEw2K/j5wz9E?=
 =?us-ascii?Q?mUizc09+cfJv76wvuQjTcjf7DGmoEkzNfddeFEeTolpWywnskVE9UGC0oz6E?=
 =?us-ascii?Q?Qf5GSB4ZPCqwVynQc3luMME81CG59SKUYOWwRkgkXO5HBHYMFbd3M5v+hJvM?=
 =?us-ascii?Q?XVzZ/w+VBQo50DbEKJoRWjD0zupoNiD/uj1wyxsMmMth0TdC329XSjulENBL?=
 =?us-ascii?Q?4msrvC+Zk51ubOnpBj+kOny6vsIMcFVdu6S5yDveYvvNTwGC5/msipoQYltB?=
 =?us-ascii?Q?5rJQivfpwh9VC3YNtogNM9boOZRnovygUezdSKHDcejQEQPFbP77sBHWJif3?=
 =?us-ascii?Q?wRpw6R0QtnmE4mWd7AqhdyzsGJt1EXZDCiZiVGxf0ZcoEAlhTACV0ZkehS5w?=
 =?us-ascii?Q?Ih5fhSZnkbELWpq17VDle8VVm/e08bZu2LJWYumfC3j4P7obtb8/XDaCQDTE?=
 =?us-ascii?Q?TMr85BWNnHUY+4w2op7AyLEWuo8S9IUaSXJtpHZrLUwBti4KuZgU8OWoRvkg?=
 =?us-ascii?Q?veQEnYvI7QExjOCuD1qadZv3eHJBokpFtNpa4u/HFT2Tk1XUxQaa+/weOADD?=
 =?us-ascii?Q?Sz2QWMsUplHKVJoJO7wjPCVluoe+n8+iKGr8vwPgMzjYGzwrLAq4yuMW6uJ+?=
 =?us-ascii?Q?aDsKrOhNS8wTmQySW6c64z/LMjLtdX0g5G86zFbzSJ1rdbzh4MJdaFTzo1pf?=
 =?us-ascii?Q?02riU4m7jf62eFvLkO0ijPc1gUC5lRMqWiJPi5gbgNSxfKXs+5PQpjHqr++L?=
 =?us-ascii?Q?JAOXGE/UD92BIbnrNTLsudDJjw6bBxkQr4+8VBv/GTmv5HuTNzPL7QsrU/GG?=
 =?us-ascii?Q?DTF1xzsi3lQp9Q0OFrjbaYDmuRTG6AJKWp8dXT5bY2unUoJOTiBrKT2sRK1B?=
 =?us-ascii?Q?PT53qx39Yjz5iT/0sPUxHIUT4+vay/kWZ3joKhz5AJ/gull1dKlDoBni1LAN?=
 =?us-ascii?Q?rYCJxu8oUrqzDOwiv0SF/U32LX7vMlI/IsMnJY85QswM5c9pxFlSoINpWrCW?=
 =?us-ascii?Q?vlKiaUu9jIJTOLIFX8V0+yS8/bfxihs7aWJBolE8TXB1tuA0bCxBtinbJPWe?=
 =?us-ascii?Q?iX82NLP1eyJoibLQ8DkW+ZwcV4PCB6dnPsZvZ9xb663xgWiav/+fjhfvVchX?=
 =?us-ascii?Q?CmYo4/+3xY8j/Mt5iWFxO+VzwogM9PYiObAMwkz/1gdEvoeabRGorpaoNrrE?=
 =?us-ascii?Q?dYJj6Gb1FqifB7Gn7m6EwpBu8MY813H6vsveNA1zRSH?=
X-Microsoft-Antispam-Message-Info: 9EkzOrFPYT1mkfHI5J2UQBbxmHr96Iwu4qSuUon1VmqUL14hAhOnd3j5daaMoIeNIkSKDriph3SiOgMte5JVvG3ah0no9I7be3LWk0tp4QTNKfBhsfkpVHfy65NGxaS+7wZtba/wpJmoPftUByzQGpikfmXWskUB5JKp2AvTaFhfJWZt8V8MVIhqcznrSoefS3YmeGNnekrs556sgXcwsibHC77SZCSVH1eZB4Hi2vMXdHFxi2zN5BJJ2lmpYFcnC4ctjCJfmGSZthBQh/grWGnoT1CNw48vRQSNf3x5nyVCnBZ42Rys1MDMWYxw+tPvu2Fz/tEArrGB4m4xmr/uo5PznDmk++TvwAF4wf/5MTA=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4929;6:sWzE/WtAEgEAaEZvLblRkdJ7VMQf3XhpbFQefpYws+DjqFwZR9INsjPSkMoqCV+g8vJ3yK7pVtRfXTjXO2cCUiMOitiXX1K9Jz5h6krPb1p92IFz5zkBKO3t8HG6SZeHgQ1mWrfwdR+QHK+jvF4ZbI3fhxZeqp1w8MNHJOFa0jd8dmiD9F00sJsXCYSMyCMnLdtiL8Y/E/2yEcUAB281iLfphNW5TCKyHAfNLPkypVQz7UyU02ZzoD7EqjNHA787tLqpeob12KsQI+Vodfjo4L5u4Chsv8vWB/brA/aUQrc6ZRybPfCeunoHFxvi5pzKM6h8AOYZ2eQPjWHBLtsnY0RKxeMGBcH8eFn0QZby7huToiymF7rqnOb1QEXPwWzFO37to6BgZiq+TYj9z4NnbVT1NFU5TRYGUymBZrOxVnLh10phKhSq+UiGGb3KiBMOG81+LkYiTXySmxEZMUBXhw==;5:pr+aEp+0WBPZBnrRNoUopa5p/7cLzgjCOJ2vM8i4StRzUGCJ4p6MZLVnC2hjGgZeWLxeqLDRpQwzT7eNGZGp+SS7Tn9R4fhCziQmOD2JXL8eB1xlyV/QZ1k9znsc96eyr4+s7nLpkP4X5qOb8liiIFdy4BlQe5q5n7X86Bl/1bs=;7:g7MS432Foq5auY/gQUsgvjBSyJVTOtk69ihR0YH7GdXpdW3ofXp/Ib6ZbPWwHjBqU/gjDeQgisSj0bKw3zLvTpv+gzNcrlEejaKle8Yh9XImeWFnaxYP5levKaNRF/P6YV7LZ/8nOAjkVCfq2ynUnfcP6gytui1gHt/UWA+gD+R6ieLCxEs7LChT+pDWSj3Oru9axqt01VmtGUSz6QXUPoEsADS8mRRYWGWavLo5G1TpgonV9IeFeQ1C2Gx1eEjs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 13:28:23.5657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 048f61f4-d0e0-4a3d-c5e9-08d60f45a084
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EDAC ECC support for ZynqMP DDRC IP. Also add support for ECC Error
Injection in ZynqMP. The corrected and uncorrected error interrupts
support is added. The Row, Column, Bank, Bank Group and Rank bits
positions are determined via Address Map registers of Synopsys DDRC.
Minor indentation changes are also done for better readability.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/edac/Kconfig         |    2 +-
 drivers/edac/synopsys_edac.c | 1054 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 937 insertions(+), 119 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 57304b2..b1fc7a16 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ || ARM64
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 2470d35..5333877 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -22,80 +22,249 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
 #include "edac_module.h"
 
 /* Number of cs_rows needed per memory controller */
-#define SYNPS_EDAC_NR_CSROWS	1
+#define SYNPS_EDAC_NR_CSROWS		1
 
 /* Number of channels per memory controller */
-#define SYNPS_EDAC_NR_CHANS	1
+#define SYNPS_EDAC_NR_CHANS		1
 
 /* Granularity of reported error in bytes */
-#define SYNPS_EDAC_ERR_GRAIN	1
+#define SYNPS_EDAC_ERR_GRAIN		1
 
-#define SYNPS_EDAC_MSG_SIZE	256
+#define SYNPS_EDAC_MSG_SIZE		256
 
-#define SYNPS_EDAC_MOD_STRING	"synps_edac"
-#define SYNPS_EDAC_MOD_VER	"1"
+#define SYNPS_EDAC_MOD_STRING		"synps_edac"
+#define SYNPS_EDAC_MOD_VER		"1"
 
 /* Synopsys DDR memory controller registers that are relevant to ECC */
-#define CTRL_OFST		0x0
-#define T_ZQ_OFST		0xA4
+#define CTRL_OFST			0x0
+#define T_ZQ_OFST			0xA4
 
 /* ECC control register */
-#define ECC_CTRL_OFST		0xC4
+#define ECC_CTRL_OFST			0xC4
 /* ECC log register */
-#define CE_LOG_OFST		0xC8
+#define CE_LOG_OFST			0xC8
 /* ECC address register */
-#define CE_ADDR_OFST		0xCC
+#define CE_ADDR_OFST			0xCC
 /* ECC data[31:0] register */
-#define CE_DATA_31_0_OFST	0xD0
+#define CE_DATA_31_0_OFST		0xD0
 
 /* Uncorrectable error info registers */
-#define UE_LOG_OFST		0xDC
-#define UE_ADDR_OFST		0xE0
-#define UE_DATA_31_0_OFST	0xE4
+#define UE_LOG_OFST			0xDC
+#define UE_ADDR_OFST			0xE0
+#define UE_DATA_31_0_OFST		0xE4
 
-#define STAT_OFST		0xF0
-#define SCRUB_OFST		0xF4
+#define STAT_OFST			0xF0
+#define SCRUB_OFST			0xF4
 
 /* Control register bit field definitions */
-#define CTRL_BW_MASK		0xC
-#define CTRL_BW_SHIFT		2
+#define CTRL_BW_MASK			0xC
+#define CTRL_BW_SHIFT			2
 
-#define DDRCTL_WDTH_16		1
-#define DDRCTL_WDTH_32		0
+#define DDRCTL_WDTH_16			1
+#define DDRCTL_WDTH_32			0
 
 /* ZQ register bit field definitions */
-#define T_ZQ_DDRMODE_MASK	0x2
+#define T_ZQ_DDRMODE_MASK		0x2
 
 /* ECC control register bit field definitions */
-#define ECC_CTRL_CLR_CE_ERR	0x2
-#define ECC_CTRL_CLR_UE_ERR	0x1
+#define ECC_CTRL_CLR_CE_ERR		0x2
+#define ECC_CTRL_CLR_UE_ERR		0x1
 
 /* ECC correctable/uncorrectable error log register definitions */
-#define LOG_VALID		0x1
-#define CE_LOG_BITPOS_MASK	0xFE
-#define CE_LOG_BITPOS_SHIFT	1
+#define LOG_VALID			0x1
+#define CE_LOG_BITPOS_MASK		0xFE
+#define CE_LOG_BITPOS_SHIFT		1
 
 /* ECC correctable/uncorrectable error address register definitions */
-#define ADDR_COL_MASK		0xFFF
-#define ADDR_ROW_MASK		0xFFFF000
-#define ADDR_ROW_SHIFT		12
-#define ADDR_BANK_MASK		0x70000000
-#define ADDR_BANK_SHIFT		28
+#define ADDR_COL_MASK			0xFFF
+#define ADDR_ROW_MASK			0xFFFF000
+#define ADDR_ROW_SHIFT			12
+#define ADDR_BANK_MASK			0x70000000
+#define ADDR_BANK_SHIFT			28
 
 /* ECC statistic register definitions */
-#define STAT_UECNT_MASK		0xFF
-#define STAT_CECNT_MASK		0xFF00
-#define STAT_CECNT_SHIFT	8
+#define STAT_UECNT_MASK			0xFF
+#define STAT_CECNT_MASK			0xFF00
+#define STAT_CECNT_SHIFT		8
 
 /* ECC scrub register definitions */
-#define SCRUB_MODE_MASK		0x7
-#define SCRUB_MODE_SECDED	0x4
+#define SCRUB_MODE_MASK			0x7
+#define SCRUB_MODE_SECDED		0x4
+
+/* DDR ECC Quirks */
+#define DDR_ECC_INTR_SUPPORT		BIT(0)
+#define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
+
+/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* ECC Configuration Registers */
+#define ECC_CFG0_OFST			0x70
+#define ECC_CFG1_OFST			0x74
+
+/* ECC Status Register */
+#define ECC_STAT_OFST			0x78
+
+/* ECC Clear Register */
+#define ECC_CLR_OFST			0x7C
+
+/* ECC Error count Register */
+#define ECC_ERRCNT_OFST			0x80
+
+/* ECC Corrected Error Address Register */
+#define ECC_CEADDR0_OFST		0x84
+#define ECC_CEADDR1_OFST		0x88
+
+/* ECC Syndrome Registers */
+#define ECC_CSYND0_OFST			0x8C
+#define ECC_CSYND1_OFST			0x90
+#define ECC_CSYND2_OFST			0x94
+
+/* ECC Bit Mask0 Address Register */
+#define ECC_BITMASK0_OFST		0x98
+#define ECC_BITMASK1_OFST		0x9C
+#define ECC_BITMASK2_OFST		0xA0
+
+/* ECC UnCorrected Error Address Register */
+#define ECC_UEADDR0_OFST		0xA4
+#define ECC_UEADDR1_OFST		0xA8
+
+/* ECC Syndrome Registers */
+#define ECC_UESYND0_OFST		0xAC
+#define ECC_UESYND1_OFST		0xB0
+#define ECC_UESYND2_OFST		0xB4
+
+/* ECC Poison Address Reg */
+#define ECC_POISON0_OFST		0xB8
+#define ECC_POISON1_OFST		0xBC
+
+#define ECC_ADDRMAP0_OFFSET		0x200
+
+/* Control register bitfield definitions */
+#define ECC_CTRL_BUSWIDTH_MASK		0x3000
+#define ECC_CTRL_BUSWIDTH_SHIFT		12
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+
+/* DDR Control Register width definitions  */
+#define DDRCTL_EWDTH_16			2
+#define DDRCTL_EWDTH_32			1
+#define DDRCTL_EWDTH_64			0
+
+/* ECC status register definitions */
+#define ECC_STAT_UECNT_MASK		0xF0000
+#define ECC_STAT_UECNT_SHIFT		16
+#define ECC_STAT_CECNT_MASK		0xF00
+#define ECC_STAT_CECNT_SHIFT		8
+#define ECC_STAT_BITNUM_MASK		0x7F
+
+/* DDR QOS Interrupt register definitions */
+#define DDR_QOS_IRQ_STAT_OFST		0x20200
+#define DDR_QOSUE_MASK			0x4
+#define	DDR_QOSCE_MASK			0x2
+#define	ECC_CE_UE_INTR_MASK		0x6
+#define DDR_QOS_IRQ_EN_OFST		0x20208
+#define DDR_QOS_IRQ_DB_OFST		0x2020C
+
+/* ECC Corrected Error Register Mask and Shifts*/
+#define ECC_CEADDR0_RW_MASK		0x3FFFF
+#define ECC_CEADDR0_RNK_MASK		BIT(24)
+#define ECC_CEADDR1_BNKGRP_MASK		0x3000000
+#define ECC_CEADDR1_BNKNR_MASK		0x70000
+#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_BNKGRP_SHIFT	24
+#define ECC_CEADDR1_BNKNR_SHIFT		16
+
+/* ECC Poison register shifts */
+#define ECC_POISON0_RANK_SHIFT		24
+#define ECC_POISON0_RANK_MASK		BIT(24)
+#define ECC_POISON0_COLUMN_SHIFT	0
+#define ECC_POISON0_COLUMN_MASK		0xFFF
+#define ECC_POISON1_BG_SHIFT		28
+#define ECC_POISON1_BG_MASK		0x30000000
+#define ECC_POISON1_BANKNR_SHIFT	24
+#define ECC_POISON1_BANKNR_MASK		0x7000000
+#define ECC_POISON1_ROW_SHIFT		0
+#define ECC_POISON1_ROW_MASK		0x3FFFF
+
+/* DDR Memory type defines */
+#define MEM_TYPE_DDR3			0x1
+#define MEM_TYPE_LPDDR3			0x8
+#define MEM_TYPE_DDR2			0x4
+#define MEM_TYPE_DDR4			0x10
+#define MEM_TYPE_LPDDR4			0x20
+
+/* DDRC Software control register */
+#define DDRC_SWCTL			0x320
+
+/* DDRC ECC CE & UE poison mask */
+#define ECC_CEPOISON_MASK		0x3
+#define ECC_UEPOISON_MASK		0x1
+
+/* DDRC Device config masks */
+#define DDRC_MSTR_CFG_MASK		0xC0000000
+#define DDRC_MSTR_CFG_SHIFT		30
+#define DDRC_MSTR_CFG_X4_MASK		0x0
+#define DDRC_MSTR_CFG_X8_MASK		0x1
+#define DDRC_MSTR_CFG_X16_MASK		0x2
+#define DDRC_MSTR_CFG_X32_MASK		0x3
+
+#define DDR_MAX_ROW_SHIFT		18
+#define DDR_MAX_COL_SHIFT		14
+#define DDR_MAX_BANK_SHIFT		3
+#define DDR_MAX_BANKGRP_SHIFT		2
+
+#define ROW_MAX_VAL_MASK		0xF
+#define COL_MAX_VAL_MASK		0xF
+#define BANK_MAX_VAL_MASK		0x1F
+#define BANKGRP_MAX_VAL_MASK		0x1F
+#define RANK_MAX_VAL_MASK		0x1F
+
+#define ROW_B0_BASE			6
+#define ROW_B1_BASE			7
+#define ROW_B2_BASE			8
+#define ROW_B3_BASE			9
+#define ROW_B4_BASE			10
+#define ROW_B5_BASE			11
+#define ROW_B6_BASE			12
+#define ROW_B7_BASE			13
+#define ROW_B8_BASE			14
+#define ROW_B9_BASE			15
+#define ROW_B10_BASE			16
+#define ROW_B11_BASE			17
+#define ROW_B12_BASE			18
+#define ROW_B13_BASE			19
+#define ROW_B14_BASE			20
+#define ROW_B15_BASE			21
+#define ROW_B16_BASE			22
+#define ROW_B17_BASE			23
+
+#define COL_B2_BASE			2
+#define COL_B3_BASE			3
+#define COL_B4_BASE			4
+#define COL_B5_BASE			5
+#define COL_B6_BASE			6
+#define COL_B7_BASE			7
+#define COL_B8_BASE			8
+#define COL_B9_BASE			9
+#define COL_B10_BASE			10
+#define COL_B11_BASE			11
+#define COL_B12_BASE			12
+#define COL_B13_BASE			13
+
+#define BANK_B0_BASE			2
+#define BANK_B1_BASE			3
+#define BANK_B2_BASE			4
+
+#define BANKGRP_B0_BASE			2
+#define BANKGRP_B1_BASE			3
+
+#define RANK_B0_BASE			6
 
 /**
  * struct ecc_error_info - ECC error log information
@@ -104,6 +273,8 @@
  * @bank:	Bank number
  * @bitpos:	Bit position
  * @data:	Data causing the error
+ * @bankgrpnr:	Bank group number
+ * @blknr:	Block number
  */
 struct ecc_error_info {
 	u32 row;
@@ -111,6 +282,8 @@ struct ecc_error_info {
 	u32 bank;
 	u32 bitpos;
 	u32 data;
+	u32 bankgrpnr;
+	u32 blknr;
 };
 
 /**
@@ -129,12 +302,18 @@ struct synps_ecc_status {
 
 /**
  * struct synps_edac_priv - DDR memory controller private instance data
- * @baseaddr:	Base address of the DDR controller
- * @message:	Buffer for framing the event specific info
- * @stat:	ECC status information
- * @p_data:	Pointer to platform data
- * @ce_cnt:	Correctable Error count
- * @ue_cnt:	Uncorrectable Error count
+ * @baseaddr:		Base address of the DDR controller
+ * @message:		Buffer for framing the event specific info
+ * @stat:		ECC status information
+ * @p_data:		Pointer to platform data
+ * @ce_cnt:		Correctable Error count
+ * @ue_cnt:		Uncorrectable Error count
+ * @poison_addr:	Data poison address
+ * @row_shift:		Bit shifts for row bit
+ * @col_shift:		Bit shifts for column bit
+ * @bank_shift:		Bit shifts for bank bit
+ * @bankgrp_shift:	Bit shifts for bank group bit
+ * @rank_shift:		Bit shifts for rank bit
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
@@ -143,33 +322,40 @@ struct synps_edac_priv {
 	const struct synps_platform_data *p_data;
 	u32 ce_cnt;
 	u32 ue_cnt;
+	ulong poison_addr;
+	u32 row_shift[18];
+	u32 col_shift[14];
+	u32 bank_shift[3];
+	u32 bankgrp_shift[2];
+	u32 rank_shift[1];
 };
 
 /**
  * struct synps_platform_data -  synps platform data structure
- * @edac_geterror_info:	function pointer to synps edac error info
- * @edac_get_mtype:	function pointer to synps edac mtype
- * @edac_get_dtype:	function pointer to synps edac dtype
- * @edac_get_eccstate:	function pointer to synps edac eccstate
- * @quirks:		to differentiate IPs
+ * @geterror_info:	Synps EDAC error info
+ * @get_mtype:		Synps EDAC mtype
+ * @get_dtype:		Synps EDAC dtype
+ * @get_eccstate:	Synps EDAC eccstate
+ * @quirks:		To differentiate IPs
  */
 struct synps_platform_data {
-	int (*edac_geterror_info)(struct synps_edac_priv *priv);
-	enum mem_type (*edac_get_mtype)(const void __iomem *base);
-	enum dev_type (*edac_get_dtype)(const void __iomem *base);
-	bool (*edac_get_eccstate)(void __iomem *base);
+	int (*geterror_info)(struct synps_edac_priv *priv);
+	enum mem_type (*get_mtype)(const void __iomem *base);
+	enum dev_type (*get_dtype)(const void __iomem *base);
+	bool (*get_eccstate)(void __iomem *base);
 	int quirks;
 };
 
 /**
- * synps_edac_geterror_info - Get the current ecc error info
- * @priv:	Pointer to DDR memory controller private instance data
+ * zynq_geterror_info - Get the current ECC error info
+ * @priv:	DDR memory controller private instance data
  *
- * Determines there is any ecc error or not
+ * Get the ECC error information from the ECC registers and clear the error
+ * status bits in the ECC registers.
  *
- * Return: one if there is no error otherwise returns zero
+ * Return: 0 if there is no error, otherwise return 1
  */
-static int synps_edac_geterror_info(struct synps_edac_priv *priv)
+static int zynq_geterror_info(struct synps_edac_priv *priv)
 {
 	void __iomem *base;
 	struct synps_ecc_status *p;
@@ -222,11 +408,77 @@ static int synps_edac_geterror_info(struct synps_edac_priv *priv)
 }
 
 /**
+ * zynqmp_geterror_info - Get the current ECC error info
+ * @priv:	DDR memory controller private instance data
+ *
+ * Get the ECC error information from the ECC registers and clear the error
+ * status bits in the ECC registers.
+ *
+ * Return: 0 if there is no error, otherwise return 1
+ */
+static int zynqmp_geterror_info(struct synps_edac_priv *priv)
+{
+	void __iomem *base;
+	struct synps_ecc_status *p;
+	u32 regval, clearval = 0;
+
+	if (!priv)
+		return 1;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
+	regval = readl(base + ECC_STAT_OFST);
+	if (!regval)
+		return 1;
+
+	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
+	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
+	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
+
+	regval = readl(base + ECC_CEADDR0_OFST);
+	if (!(p->ce_cnt))
+		goto ue_err;
+
+	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_CEADDR1_OFST);
+	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
+		 p->ceinfo.data);
+
+ue_err:
+	regval = readl(base + ECC_UEADDR0_OFST);
+	if (!(p->ue_cnt))
+		goto out;
+
+	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
+	regval = readl(base + ECC_UEADDR1_OFST);
+	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+					ECC_CEADDR1_BNKGRP_SHIFT;
+	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
+					ECC_CEADDR1_BNKNR_SHIFT;
+	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+out:
+	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
+	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	writel(clearval, base + ECC_CLR_OFST);
+	writel(0x0, base + ECC_CLR_OFST);
+
+	return 0;
+}
+
+/**
  * synps_edac_handle_error - Handle controller error types CE and UE
- * @mci:	Pointer to the edac memory controller instance
- * @p:		Pointer to the synopsys ecc status structure
+ * @mci:	EDAC memory controller instance
+ * @p:		Synopsys ECC status structure
  *
- * Handles the controller ECC correctable and un correctable error.
+ * Handles the controller ECC correctable and un-correctable error.
  */
 static void synps_edac_handle_error(struct mem_ctl_info *mci,
 				    struct synps_ecc_status *p)
@@ -236,9 +488,25 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "CE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				 "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				 "CE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d ",
+				 pinf->bankgrpnr, pinf->blknr);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "Bit Position: %d Data: 0x%08x\n",
+				 pinf->bitpos, pinf->data);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
 				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -246,9 +514,19 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-			 "UE", pinf->row, pinf->bank, pinf->col);
+		if (!priv->p_data->quirks) {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				 "UE", pinf->row, pinf->bank, pinf->col);
+		} else {
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
+				 "UE", pinf->row, pinf->bank, pinf->col);
+			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+				 "BankGroup Number %d Block Number %d ",
+				 pinf->bankgrpnr, pinf->blknr);
+		}
+
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
 				     priv->message, "");
@@ -258,10 +536,46 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
 }
 
 /**
+ * synps_edac_intr_handler - Interrupt Handler for ECC interrupts
+ * @irq:        irq number
+ * @dev_id:     device id pointer
+ *
+ * This is the ISR called by EDAC core interrupt thread.
+ * This is used to check and post ECC errors.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct synps_edac_priv *priv = mci->pvt_info;
+	const struct synps_platform_data *p_data = priv->p_data;
+	int status, regval;
+
+	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+	if (!(regval & ECC_CE_UE_INTR_MASK))
+		return IRQ_NONE;
+
+	status = p_data->geterror_info(priv);
+	if (status)
+		return IRQ_NONE;
+
+	priv->ce_cnt += priv->stat.ce_cnt;
+	priv->ue_cnt += priv->stat.ue_cnt;
+	synps_edac_handle_error(mci, &priv->stat);
+
+	edac_dbg(3, "Total error count ce %d ue %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	return IRQ_HANDLED;
+}
+
+/**
  * synps_edac_check - Check controller for ECC errors
- * @mci:	Pointer to the edac memory controller instance
+ * @mci:	EDAC memory controller instance
  *
- * Used to check and post ECC errors. Called by the polling thread
+ * Used to check and post ECC errors. This is called by the polling thread.
  */
 static void synps_edac_check(struct mem_ctl_info *mci)
 {
@@ -269,7 +583,7 @@ static void synps_edac_check(struct mem_ctl_info *mci)
 	const struct synps_platform_data *p_data = priv->p_data;
 	int status;
 
-	status = p_data->edac_geterror_info(priv);
+	status = p_data->geterror_info(priv);
 	if (status)
 		return;
 
@@ -282,15 +596,15 @@ static void synps_edac_check(struct mem_ctl_info *mci)
 }
 
 /**
- * synps_edac_get_dtype - Return the controller memory width
- * @base:	Pointer to the ddr memory controller base address
+ * zynq_get_dtype - Return the controller memory width
+ * @base:	DDR memory controller base address
  *
  * Get the EDAC device type width appropriate for the current controller
  * configuration.
  *
  * Return: a device type width enumeration.
  */
-static enum dev_type synps_edac_get_dtype(const void __iomem *base)
+static enum dev_type zynq_get_dtype(const void __iomem *base)
 {
 	enum dev_type dt;
 	u32 width;
@@ -313,36 +627,93 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
 }
 
 /**
- * synps_edac_get_eccstate - Return the controller ecc enable/disable status
- * @base:	Pointer to the ddr memory controller base address
+ * zynqmp_get_dtype - Return the controller memory width
+ * @base:	DDR memory controller base address
  *
- * Get the ECC enable/disable status for the controller
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynqmp_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + CTRL_OFST);
+	width = (width & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+	switch (width) {
+	case DDRCTL_EWDTH_16:
+		dt = DEV_X2;
+		break;
+	case DDRCTL_EWDTH_32:
+		dt = DEV_X4;
+		break;
+	case DDRCTL_EWDTH_64:
+		dt = DEV_X8;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
+ * zynq_get_eccstate - Return the controller ECC enable/disable status
+ * @base:	DDR memory controller base address
+ *
+ * Get the ECC enable/disable status for the controller.
  *
- * Return: a ecc status boolean i.e true/false - enabled/disabled.
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool synps_edac_get_eccstate(void __iomem *base)
+static bool zynq_get_eccstate(void __iomem *base)
 {
 	enum dev_type dt;
 	u32 ecctype;
-	bool state = false;
 
-	dt = synps_edac_get_dtype(base);
+	dt = zynq_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
-		return state;
+		return false;
 
 	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
 	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		state = true;
+		return true;
 
-	return state;
+	return false;
 }
 
 /**
- * synps_edac_get_memsize - reads the size of the attached memory device
+ * zynqmp_get_eccstate - Return the controller ECC enable/disable status
+ * @base:	DDR memory controller base address
+ *
+ * Get the ECC enable/disable status for the controller.
+ *
+ * Return: a ECC status boolean i.e true/false - enabled/disabled.
+ */
+static bool zynqmp_get_eccstate(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+
+	dt = zynqmp_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return false;
+
+	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	if ((ecctype == SCRUB_MODE_SECDED) &&
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+		return true;
+
+	return false;
+}
+
+/**
+ * zynq_get_memsize - reads the size of the attached memory device
  *
  * Return: the memory size in bytes
  */
-static u32 synps_edac_get_memsize(void)
+static u32 zynq_get_memsize(void)
 {
 	struct sysinfo inf;
 
@@ -352,15 +723,15 @@ static u32 synps_edac_get_memsize(void)
 }
 
 /**
- * synps_edac_get_mtype - Returns controller memory type
- * @base:	pointer to the synopsys ecc status structure
+ * zynq_get_mtype - Returns controller memory type
+ * @base:	Synopsys ECC status structure
  *
  * Get the EDAC memory type appropriate for the current controller
  * configuration.
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type synps_edac_get_mtype(const void __iomem *base)
+static enum mem_type zynq_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -376,13 +747,41 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
 }
 
 /**
+ * zynqmp_get_mtype - Returns controller memory type
+ * @base:	Synopsys ECC status structure
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type zynqmp_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + CTRL_OFST);
+
+	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+		mt = MEM_DDR3;
+	else if (memtype & MEM_TYPE_DDR2)
+		mt = MEM_RDDR2;
+	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+		mt = MEM_DDR4;
+	else
+		mt = MEM_EMPTY;
+
+	return mt;
+}
+
+/**
  * synps_edac_init_csrows - Initialize the cs row data
- * @mci:	Pointer to the edac memory controller instance
+ * @mci:	EDAC memory controller instance
  *
  * Initializes the chip select rows associated with the EDAC memory
- * controller instance
+ * controller instance.
  *
- * Return: Unconditionally 0.
+ * Return: Always zero.
  */
 static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 {
@@ -395,15 +794,15 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = synps_edac_get_memsize();
+		size = zynq_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_FLAG_SECDED;
-			dimm->mtype	= p_data->edac_get_mtype(priv->baseaddr);
+			dimm->mtype	= p_data->get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
 			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= p_data->edac_get_dtype(priv->baseaddr);
+			dimm->dtype	= p_data->get_dtype(priv->baseaddr);
 		}
 	}
 
@@ -412,8 +811,8 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
 
 /**
  * synps_edac_mc_init - Initialize driver instance
- * @mci:	Pointer to the edac memory controller instance
- * @pdev:	Pointer to the platform_device struct
+ * @mci:	EDAC memory controller instance
+ * @pdev:	platform_device struct
  *
  * Performs initialization of the EDAC memory controller instance and
  * related driver-private data associated with the memory controller the
@@ -442,8 +841,13 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 	mci->dev_name = SYNPS_EDAC_MOD_STRING;
 	mci->mod_name = SYNPS_EDAC_MOD_VER;
 
-	edac_op_state = EDAC_OPSTATE_POLL;
-	mci->edac_check = synps_edac_check;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+		mci->edac_check = synps_edac_check;
+	}
+
 	mci->ctl_page_to_phys = NULL;
 
 	status = synps_edac_init_csrows(mci);
@@ -452,35 +856,413 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
 }
 
 static const struct synps_platform_data zynq_edac_def = {
-	.edac_geterror_info	= synps_edac_geterror_info,
-	.edac_get_mtype		= synps_edac_get_mtype,
-	.edac_get_dtype		= synps_edac_get_dtype,
-	.edac_get_eccstate	= synps_edac_get_eccstate,
-	.quirks			= 0,
+	.geterror_info	= zynq_geterror_info,
+	.get_mtype	= zynq_get_mtype,
+	.get_dtype	= zynq_get_dtype,
+	.get_eccstate	= zynq_get_eccstate,
+	.quirks		= 0,
+};
+
+static const struct synps_platform_data zynqmp_edac_def = {
+	.geterror_info	= zynqmp_geterror_info,
+	.get_mtype	= zynqmp_get_mtype,
+	.get_dtype	= zynqmp_get_dtype,
+	.get_eccstate	= zynqmp_get_eccstate,
+	.quirks		= (DDR_ECC_INTR_SUPPORT |
+			   DDR_ECC_DATA_POISON_SUPPORT),
 };
 
 static const struct of_device_id synps_edac_match[] = {
-	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
-	{ /* end of table */ }
+	{
+		.compatible = "xlnx,zynq-ddrc-a05",
+		.data = (void *)&zynq_edac_def
+	},
+	{
+		.compatible = "xlnx,zynqmp-ddrc-2.40a",
+		.data = (void *)&zynqmp_edac_def
+	},
+	{
+		/* end of table */
+	}
 };
 
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
 /**
- * synps_edac_mc_probe - Check controller and bind driver
- * @pdev:	Pointer to the platform_device struct
+ * ddr_poison_setup -	update poison registers
+ * @priv:		DDR memory controller private instance data
  *
- * Probes a specific controller instance for binding with the driver.
+ * Update poison registers as per DDR mapping.
+ * Return: none.
+ */
+static void ddr_poison_setup(struct synps_edac_priv *priv)
+{
+	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
+	int index;
+	ulong hif_addr = 0;
+
+	hif_addr = priv->poison_addr >> 3;
+
+	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
+		if (priv->row_shift[index])
+			row |= (((hif_addr >> priv->row_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
+		if (priv->col_shift[index] || index < 3)
+			col |= (((hif_addr >> priv->col_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
+		if (priv->bank_shift[index])
+			bank |= (((hif_addr >> priv->bank_shift[index]) &
+						BIT(0)) << index);
+		else
+			break;
+	}
+
+	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
+		if (priv->bankgrp_shift[index])
+			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
+						& BIT(0)) << index);
+		else
+			break;
+	}
+
+	if (priv->rank_shift[0])
+		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
+
+	regval = (rank << ECC_POISON0_RANK_SHIFT) & ECC_POISON0_RANK_MASK;
+	regval |= (col << ECC_POISON0_COLUMN_SHIFT) & ECC_POISON0_COLUMN_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+
+	regval = (bankgrp << ECC_POISON1_BG_SHIFT) & ECC_POISON1_BG_MASK;
+	regval |= (bank << ECC_POISON1_BANKNR_SHIFT) & ECC_POISON1_BANKNR_MASK;
+	regval |= (row << ECC_POISON1_ROW_SHIFT) & ECC_POISON1_ROW_MASK;
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
+}
+
+static ssize_t inject_data_error_show(struct device *dev,
+				      struct device_attribute *mattr,
+				      char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
+			"Error injection Address: 0x%lx\n\r",
+			readl(priv->baseaddr + ECC_POISON0_OFST),
+			readl(priv->baseaddr + ECC_POISON1_OFST),
+			priv->poison_addr);
+}
+
+static ssize_t inject_data_error_store(struct device *dev,
+				       struct device_attribute *mattr,
+				       const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	if (kstrtoul(data, 0, &priv->poison_addr))
+		return -EINVAL;
+
+	ddr_poison_setup(priv);
+
+	return count;
+}
+
+static ssize_t inject_data_poison_show(struct device *dev,
+				       struct device_attribute *mattr,
+				       char *data)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	return sprintf(data, "Data Poisoning: %s\n\r",
+			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
+			? ("Correctable Error") : ("UnCorrectable Error"));
+}
+
+static ssize_t inject_data_poison_store(struct device *dev,
+					struct device_attribute *mattr,
+					const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct synps_edac_priv *priv = mci->pvt_info;
+
+	writel(0, priv->baseaddr + DDRC_SWCTL);
+	if (strncmp(data, "CE", 2) == 0)
+		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	else
+		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
+	writel(1, priv->baseaddr + DDRC_SWCTL);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(inject_data_error);
+static DEVICE_ATTR_RW(inject_data_poison);
+
+static int synps_edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
+	if (rc < 0)
+		return rc;
+	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void synps_edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
+	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
+}
+
+static void setup_row_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 addrmap_row_b2_10;
+	int index;
+
+	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
+	priv->row_shift[1] = ((addrmap[5] >> 8) &
+			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
+
+	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
+	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
+		for (index = 2; index < 11; index++)
+			priv->row_shift[index] = addrmap_row_b2_10 +
+				index + ROW_B0_BASE;
+
+	} else {
+		priv->row_shift[2] = (addrmap[9] &
+				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
+		priv->row_shift[3] = ((addrmap[9] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
+		priv->row_shift[4] = ((addrmap[9] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
+		priv->row_shift[5] = ((addrmap[9] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
+		priv->row_shift[6] = (addrmap[10] &
+				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
+		priv->row_shift[7] = ((addrmap[10] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
+		priv->row_shift[8] = ((addrmap[10] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
+		priv->row_shift[9] = ((addrmap[10] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
+		priv->row_shift[10] = (addrmap[11] &
+				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
+	}
+
+	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
+	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
+				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
+	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
+	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
+				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
+	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
+				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
+	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+}
+
+static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	u32 width, memtype;
+	int index;
+
+	memtype = readl(priv->baseaddr + CTRL_OFST);
+	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+
+	priv->col_shift[0] = 0;
+	priv->col_shift[1] = 1;
+	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
+	priv->col_shift[3] = ((addrmap[2] >> 8) &
+			COL_MAX_VAL_MASK) + COL_B3_BASE;
+	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B4_BASE);
+	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B5_BASE);
+	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
+					COL_MAX_VAL_MASK) + COL_B6_BASE);
+	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
+					COL_MAX_VAL_MASK) + COL_B7_BASE);
+	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
+					COL_MAX_VAL_MASK) + COL_B8_BASE);
+	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
+			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
+					COL_MAX_VAL_MASK) + COL_B9_BASE);
+	if (width == DDRCTL_EWDTH_64) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[11] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		} else {
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+			priv->col_shift[13] = (((addrmap[4] >> 8) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
+				 COL_B11_BASE);
+		}
+	} else if (width == DDRCTL_EWDTH_32) {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[11] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		}
+	} else {
+		if (memtype & MEM_TYPE_LPDDR3) {
+			priv->col_shift[10] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[11] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+			priv->col_shift[13] = ((addrmap[4] &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				((addrmap[4] & COL_MAX_VAL_MASK) +
+				 COL_B10_BASE);
+		} else {
+			priv->col_shift[11] = (((addrmap[3] >> 16) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
+				 COL_B8_BASE);
+			priv->col_shift[13] = (((addrmap[3] >> 24) &
+				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
+				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
+				 COL_B9_BASE);
+		}
+	}
+
+	if (width) {
+		for (index = 9; index > width; index--) {
+			priv->col_shift[index] = priv->col_shift[index - width];
+			priv->col_shift[index - width] = 0;
+		}
+	}
+}
+
+static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
+	priv->bank_shift[1] = ((addrmap[1] >> 8) &
+				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
+	priv->bank_shift[2] = (((addrmap[1] >> 16) &
+				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
+				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
+				 BANK_B2_BASE);
+}
+
+static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->bankgrp_shift[0] = (addrmap[8] &
+				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
+	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
+				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
+				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
+}
+
+static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+{
+	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
+				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
+				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
+}
+
+/**
+ * setup_address_map -	Set Address Map by querying ADDRMAP registers
+ * @priv:		DDR memory controller private instance data
+ *
+ * Set Address Map by querying ADDRMAP registers.
  *
- * Return: 0 if the controller instance was successfully bound to the
- * driver; otherwise, < 0 on error.
+ * Return: none.
  */
+static void setup_address_map(struct synps_edac_priv *priv)
+{
+	u32 addrmap[12];
+	int index;
+
+	for (index = 0; index < 12; index++) {
+		u32 addrmap_offset;
+
+		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
+	}
+
+	/* Set Row Address Map */
+	setup_row_address_map(priv, addrmap);
+
+	/* Set Column Address Map */
+	setup_column_address_map(priv, addrmap);
+
+	/* Set Bank Address Map */
+	setup_bank_address_map(priv, addrmap);
+
+	/* Set Bank Group Address Map */
+	setup_bg_address_map(priv, addrmap);
+
+	/* Set Rank Address Map */
+	setup_rank_address_map(priv, addrmap);
+}
+
 static int synps_edac_mc_probe(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
 	struct synps_edac_priv *priv;
-	int rc;
+	int rc, irq, status;
 	struct resource *res;
 	void __iomem *baseaddr;
 	const struct synps_platform_data *p_data;
@@ -491,7 +1273,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		return PTR_ERR(baseaddr);
 
 	p_data = of_device_get_match_data(&pdev->dev);
-	if (!(p_data->edac_get_eccstate(baseaddr))) {
+	if (!(p_data->get_eccstate(baseaddr))) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
@@ -522,6 +1304,27 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"No irq %d in DT\n", irq);
+			goto free_edac_mc;
+		}
+
+		status = devm_request_irq(&pdev->dev, irq,
+			synps_edac_intr_handler,
+			0, dev_name(&pdev->dev), mci);
+		if (status < 0) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");
+			goto free_edac_mc;
+		}
+
+		/* Enable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+	}
+
 	rc = edac_mc_add_mc(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -529,11 +1332,24 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 		goto free_edac_mc;
 	}
 
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
+		if (synps_edac_create_sysfs_attributes(mci)) {
+			edac_printk(KERN_ERR, EDAC_MC,
+					"Failed to create sysfs entries\n");
+			goto free_edac_mc;
+		}
+	}
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "xlnx,zynqmp-ddrc-2.40a"))
+		setup_address_map(priv);
+
 	/*
 	 * Start capturing the correctable and uncorrectable errors. A write of
 	 * 0 starts the counters.
 	 */
-	writel(0x0, baseaddr + ECC_CTRL_OFST);
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
+		writel(0x0, baseaddr + ECC_CTRL_OFST);
 	return rc;
 
 free_edac_mc:
@@ -542,17 +1358,19 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 	return rc;
 }
 
-/**
- * synps_edac_mc_remove - Unbind driver from controller
- * @pdev:	Pointer to the platform_device struct
- *
- * Return: Unconditionally 0
- */
 static int synps_edac_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct synps_edac_priv *priv;
 
+	priv = mci->pvt_info;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
+		/* Disable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 	edac_mc_del_mc(&pdev->dev);
+	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
+		synps_edac_remove_sysfs_attributes(mci);
 	edac_mc_free(mci);
 
 	return 0;
-- 
2.1.1

