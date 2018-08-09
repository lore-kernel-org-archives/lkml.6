Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAD6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18E321C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="q5xSiahD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18E321C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeHIJ3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:29:09 -0400
Received: from mail-cys01nam02on0063.outbound.protection.outlook.com ([104.47.37.63]:26014
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbeHIJ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tdpNXwEkefytiycT1F9aNxIa8peeORV3i7I8y7Lujo=;
 b=q5xSiahD7b7Tws4LnIU/uzsdX2Q55TrkNP1Vj7fPiZf4volsmTSraoKZDUGYujK29IkuLQBAx03hTqLLn35SRRqtw35lzWSFel1Ce/WgVlex8bzp6PbfZtRfvKLSLrMCo50VeAPZ4s1FhCWxwNOmwBUvMoftw6V68Kx9zNZqqCs=
Received: from SN4PR0201CA0046.namprd02.prod.outlook.com
 (2603:10b6:803:2e::32) by BL0PR02MB4324.namprd02.prod.outlook.com
 (2603:10b6:208:40::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Thu, 9 Aug
 2018 07:05:25 +0000
Received: from CY1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by SN4PR0201CA0046.outlook.office365.com
 (2603:10b6:803:2e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.22 via Frontend
 Transport; Thu, 9 Aug 2018 07:05:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT003.mail.protection.outlook.com (10.152.74.151) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Thu, 9 Aug 2018 07:05:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:35937 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fnf0Z-0004d2-Fz; Thu, 09 Aug 2018 00:05:19 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fnf0U-0008Vy-CS; Thu, 09 Aug 2018 00:05:14 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fnf0T-0008U9-MC; Thu, 09 Aug 2018 00:05:14 -0700
Subject: Re: [PATCH 2/3] microblaze: Added system call table generation
 support
To:     Firoz Khan <firoz.khan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
CC:     <y2038@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <arnd@arndb.de>,
        <deepa.kernel@gmail.com>, <marcin.juszkiewicz@linaro.org>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-3-git-send-email-firoz.khan@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <80094eae-05b8-a96f-b631-cc3b81e0e425@xilinx.com>
Date:   Thu, 9 Aug 2018 09:05:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533792466-4227-3-git-send-email-firoz.khan@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(2980300002)(438002)(189003)(199004)(58126008)(106002)(110136005)(316002)(8936002)(31686004)(54906003)(36756003)(65956001)(65806001)(9786002)(47776003)(65826007)(7416002)(64126003)(6666003)(230700001)(5660300001)(305945005)(356003)(50466002)(4326008)(229853002)(39060400002)(6246003)(8676002)(81166006)(81156014)(2906002)(76176011)(11346002)(2486003)(446003)(126002)(44832011)(77096007)(476003)(26005)(486006)(106466001)(478600001)(53546011)(2616005)(31696002)(336012)(23676004)(186003)(426003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4324;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT003;1:Xn8/TeGP6vIN6aterVO7ux64dOsBK6UoAvuy1rZWdLl/w1y54WAE3YFvkSLCcp6PW9ExCGa1cqrAmgl2dy35lgwifb5Xn6un7nrXGw9YYehL09Ktrk8Pv0URfe6VpqLL
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbd8c0c-b450-4a04-ee57-08d5fdc67a89
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;3:orFo9mEv/m4kI6tllGRtN95xNisyJtHK1di6uPwDo6mCvRJhMpGdgkkLh2lUn/kDjdIKIAzKibkdg+tAy6ViMP1Pxx7UepUIdx7Ts6zkFDQqgL8JQ6XO4UY/CnZdkHBzbAF2uzA7gxUbkOIQvPPktZnTjxa89u4+YFDQHmv9IgcA6z3af1hULZRvPZlB9wtWodjvL0WsSxq+Y6HqgTdWquUILFlK9/kR1trAZRlftqyOx/vwQb5waJulp/llU6iTZSXQfWtWCTcLuq/tkK1SgeoQbfLXNY71Nj15OCJ9uN4ymTCIsftXAyRN30qs6YRnzo1IrZV3P3Wm2YEFrpNYKv1tVwGMBrk0uI8P48pnH3M=;25:2NKrQpHVSx9XukHWeYVqKhpDmXDRGcIiUcBPNOSYjLUBcoEIiPl1KsG2GKDQTaAg/jeawM/gRMu/PQRzgvXWjuUvzwCHOWOxeKUJIaQEzzFiI4n2Wq0qkmv6pfUS47AOZuw0lG8K84HgOvF1hwQ6C8vnR0yv5M/6FLWAsJFF5o3XcTbJPqcUx6Hx8bSA8k/9g7qN8EYP8YxrIlbK51iIJPP3b3nTih7c1PF2XCMBNl0bJdgfFimmos/fyiNn/W6mkMDaDPkg96ZdxiyjySQdWa9jwS+lDUgXPxwOmp9Jz6prmTugTKvpze079QgSmyB946rbsCL1vRjlKHzys2Jsdg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4324:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;31:vuX4IhnbwnqEBHY1yfuyxAIHmZC//sh6ROSVqHxBFRi8dsFyVYR/n7oO0VaNEf1mh/iNy/CnJlbWgxoJvUp0TlKmZsPcp5jXhK+aJjLsHOMpI0jICggqI3VjgQClg5ssO6eCfhDf+T45P3/RHfwj/2x3xyFnqx7dNFOoHuU9asT6kF8QZcYbCtKQJbi8bqCGJguR94togZ7YiVMH/AOZSqJFW6Exu6+0IuZrlpASBd0=;20:j2Eqyt/+zN2w5f4ec5CvqNrzoLoUS9xs0RI544ispjN5bfrRcmdt26pk7zfmlHRLi0r0P3iyf48rkK2A9ygn9zCLfZEqDTSaVU6//niO/WPSDnWdd7V8Wuwykdm5BT2F8IPnwBREHGrCCRUICogcRi9GsD5909TcNhQRLjUfpTcDN8tlzDUUxZt2qp3U1fcbRSS39UH+AlR/t2J2dl8b4rvmFmeem6Hchis975/aLdjGVso2jTACJhl9nixZ/6NPQjcxmxzUeIN9uABltIaK6mXsj2lEw7CCg+fYnY4ubsDW4vL9SxVklz5puewtucBvZH2ivPE+45fZ7w/FCcHu5L+dlf7dZeaYYv9tYwjbsU5Bt09FUojpZWPfDQS+diS4DAlaM/a+sNDobc9m2n2r6GIbNEPN7t+3EAePtTcnDsIr3+Jbe13oq1iSEdjEe96qe5w/Z1pmAoZvHDLFmtW9KRJ23CWJ/ga18S26zrkIhm0vM+n/mTcqzMnzlxz4L9iM
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB43248FA1AA1416D702F3A298C6250@BL0PR02MB4324.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB4324;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4324;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;4:mV6LHRKdEUQpxbQBH6k3Yu2M253m3bu1un7s5M9oa2QGNv0ZZzJtNIL36xItX2oBTvXFAPKZoFCFH9W6ZH+reFNv8E8goLpnd31ZU1D5cwJjdmudsoFk9G4EXSvO0dYHbiVlH5X6hidgwt2IaD7G62Gxob5RTgG9bKhW9G4scA1US7D0WoPa4e3gvwLTdMgKNhFzsWCUmhvjPYyHp8z7/GmOhq+CVcUpzvmxzoMtlchtLOtWkh7LKuTlzAakw/2AelkEcT10qjuZoxKmu16xGA==
X-Forefront-PRVS: 0759F7A50A
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0MzI0OzIzOjl6UDNqaXpPSU9jemVrWEZndS83a2duK3Ny?=
 =?utf-8?B?WDViR2F5S25jRThDTmZYVkRmbXBqMkpGU05XUndma1EzTVRSKzc4dWRDcTRt?=
 =?utf-8?B?K2VMNFpTSHlUK2RPait6QmNCd2l5QndjcjBMbFRXRWxEcGtsZ08wS2tFOFk5?=
 =?utf-8?B?SzZYVEhLbmpFSGl5NWVsUHBQU1IvZlQzYzdUU3JZeEcwQmk1QU96VCtPZjZz?=
 =?utf-8?B?a28rSGFITFBXUC91Y3cvVUJ3WFhoWStWaWtUZTRSTE52NGcybmM3dDFZdVJO?=
 =?utf-8?B?NTZ0ZEVRck80blYxa21wZ3I0bUYrL2ZiUW1sYWFIWDdmUHVLQ01VcnZxUm1R?=
 =?utf-8?B?cDFIVFVQVGhHQzU3bDJlQkQ5aWUxN3VwRGdWY3Z0cVdzUHU3dFVkNXdSbmUy?=
 =?utf-8?B?Rml6TUsybFhiVTRhaDNvTjRiY1gxRGEvcngrWEdvMGVkWWk4U1hUMHRXTDlv?=
 =?utf-8?B?REpSVWl1SDVJeDQ5b2VXWEtpNG1waXNlQytmUnViYlF0a2JKU2dPdEF2NGt1?=
 =?utf-8?B?WDRUb2hpRkd3dG0yVXJDbk1WOUtiMGo4L211MHFlTkoyQ0pKb2ZuNjRpbDhL?=
 =?utf-8?B?NHNjQkVFYlZuUFl0eFN4VU9IUWZLK1JEYVRnTi9kZ0RxWVcrdU5NSVVmR0ZV?=
 =?utf-8?B?NE5McGUxWXBBRDhJdFlqcHErQjE1cFdGY01RLzNrVkZYQnBTMDlMRDdaSVQ1?=
 =?utf-8?B?Ry9zKzRwVEJER3lxT0VmUE1JUWxxYlQySHRPdjBNSXFFalkrdTNiN0xLTk9a?=
 =?utf-8?B?Nlp0Rm5HdVZQZVdHUEhBbUs1QWdRUVh0RWZqelY1bTRuRjlCbHZ5aTBVbGIw?=
 =?utf-8?B?bmZvUE5mL1hDcW5BUTZoRDVDM2RhS3NPQ25rWk1YcVJmaUFwUTJSTG8vZHhM?=
 =?utf-8?B?cVRCY3l2eFpIRnFEdVMydEtsVXJrcGxVamNWbmE1dkplWnFSSFdxS09PK2NJ?=
 =?utf-8?B?cGRacHd1N2ZOaDBuc21idGphUFZkand4T2ZMek1QUS90S05VOVNBclljbXFD?=
 =?utf-8?B?dHZCSGtIMit6UEUrL014bFBoeVdOa2hvMi9vTkFaaGVYSjZhUjl1R29OOGdU?=
 =?utf-8?B?azdja1hNRUdCZ2t2c1Y0emVYb3FJQ203NVNCOVEzZEFjZE4yTG1xRHRodUF3?=
 =?utf-8?B?Zitkb3VWcU9NcUxrVFJhZnA1WlBMRjVtZFB3R2NVbGFtTkIycCtCcWNyN3FF?=
 =?utf-8?B?OGE2MVdya0dQcUg5blVZbVNqOEtXelNPa1hTRDBLSmpDRVJXUEIyZElRbThk?=
 =?utf-8?B?ZVhrNmFnTHZRY2k5Wm5yVHMxa08zYVo2VlNEaFJMcjdmd1poT2VRRFFZNkha?=
 =?utf-8?B?SGk1VzFYUzlOUnJ0TlZjcHJFcVE5bzhOTDl1cis2K3lGYjQ1NzZGakZZSjVO?=
 =?utf-8?B?dHNiUU9yNUVHNllCTG1kcmlJQUI0TWNCem16T2ZQQ0t4RGxPL09kUzhLN05n?=
 =?utf-8?B?QTZWYklPV3ZpOWdNLytEN2M4UHR2Y0VOdVcvVTVCUTFTZjhwYU10LzcwWGV4?=
 =?utf-8?B?VjN0UmRwL0swcHVlOVM4UzlyUTZPNkVMU0pyc0srbGdlN1FsS2xHY1U1elVp?=
 =?utf-8?B?V3l1MjVLVUlKL3o3VVExTjRuYmlmdDk3SCtGSFZ4YlZnVGozV2U0RllXSUVG?=
 =?utf-8?B?cVFWdExJdWl6WUtEQlhvV012c2t1Tm8vWDJ1cERkdm9KTjNmRktTSkxpVloy?=
 =?utf-8?B?TkhoRkp0RzJ1MWlxVDMrTHY4TlRUUWp4RHJwODJQR2wwa0g1K2lkdUJVOUVU?=
 =?utf-8?Q?RQi4arWPUq1mCIHyk88dQiGujw8iKghanZja4=3D?=
X-Microsoft-Antispam-Message-Info: VWpGDk+qqqtJyStooGIbrV+Fto3XvZcSV6ZZqRDIap4JZu+Hy58BGv1RCuXQ44I2FbgiiujxalFo7miSwYHIa2wrzjMF2Wb3dKeVLUOwWTrA93KXQjDS5Jxj7suzqPGCjme7MBOzoj4rum4StWo4yLfHLxgfGMBWmdE+rIdTvEH3RI600n/hjW1n4a0DTqW6pEUKmB7//y5dDLP3w2eA+IwkzDmHcHLOBIIV3CAvscX5aus09WGUuFXrUmaHnhpCSYRE+kr7LgDHwfZZCQeVHNvvhEUI+uXJ5lnMlLIY5h7cX46DzVTUW1PNW3IBcffIwU1X0i8Zqud4NQ6uz6IP8Eh00iVP1Y1j1g4G/E+jy8g=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4324;6:QmjUeAeRO3S9BaUiOhlYTBIcNhDxCVIsyVbO/gBQYgcQWvGluykE1dDcFD1qba8aHwmytomgosh+YZl2UFm5YiItR/6CTPNCsS1xZLQKf4YlHPV2W+Az0NKKFeShIpFOwh3WS/D7KasqR6sD7x9TfgkSZTIHG6nudaN69ZmZyGORaNujdJ13Q/id4rupqsf/ryHCPOv5v61AtY9p+vm3VIt8VTfAezZ2e4K40J5IbAx7A1K+8U8abjCdwjdoCrOqemXiyRTxJSfnP+BrNALzY9i2wRNOL/aM3kLQ55r3FCj3UooMq5CAAIIie6peOs+kH+h/V6+mIX3gf5QvkW6s5z9ohiqShZBpCWBttUOzAK0D/FIKjXryhB4T8VDX50K1z7A+tBGqwAAnCCiI/bqZ9RtkgBfNljfqkR5wdifYQHy5ZrpPmBiFKpckUfGdumk0F3oGgVxhyDhJyeVLHVr6gw==;5:zHN8MyyAJGL9JUGHjtZXWKJBX9aLdoNHyBvRfBHlj8IE5teCrWQkP2efpFehB/fSrFdiwMb1NzaJ4EnMh16IFUdEFX3FDqM9yoFy9CpJ6w54oh1sWEEEnxHnAbXgthEZjvZ8P/I1UHnxWmRNQa9OxgSHYEOhDWLKn/gb+agOqc8=;7:/joUL6l1gd+Z2sNfrNwtlFFevuKdZli6N6gVr0XioDhw8Zw7mP8JX450RCxESSGItJtyFrEfE5w+tKekgHSJV++Ua8XHQKHCiuCtTIVJf2dKsfyAaMU5A9y0Fyl81woqRvae/Im+VOVrXoGOr+MvqHmxOUWz/HBypRdMPWEDKcCt0Pz+pLCLxWf5+jyVgxR2WRnanoTo5H/6U77Mz3QyRzpRbOteHTKkrC7i1tPlQItMIRGc5YSIJyOmyFyGhTvS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 07:05:20.2597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbd8c0c-b450-4a04-ee57-08d5fdc67a89
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.8.2018 07:27, Firoz Khan wrote:
> The system call tables are in different format in all
> architecture and it will be difficult to manually add or
> modify the system calls in the respective files. To make
> it easy by keeping a script and which'll generate the
> header file and syscall table file so this change will
> unify them across all architectures.
> 
> The system call table generation script is added in
> syscalls directory which contain the script to generate
> both uapi header file system call table generation file
> and syscall.tbl file which'll be the input for the scripts.
> 
> syscall.tbl contains the list of available system calls
> along with system call number and corresponding entry point.
> Add a new system call in this architecture will be possible
> by adding new entry in the syscall.tbl file.
> 
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
> 
> syscallhdr.sh and syscalltbl.sh will generate uapi header-
> unistd.h and syscall_table.h files respectively. File
> syscall_table.h is included by syscall.S - the real system
> call table. Both .sh files will parse the content syscall.tbl
> to generate the header and table files.
> 
> ARM, s390 and x86 architecuture does have the similar support.
> I leverage their implementation to come up with a generic
> solution. And this is the ground work for y2038 issue. We need
> to change 52 system call implementation and this work will
> reduce the effort by simply modify 52 entries in syscall.tbl.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/microblaze/kernel/syscalls/Makefile      |  37 +++
>  arch/microblaze/kernel/syscalls/syscall.tbl   | 404 ++++++++++++++++++++++++++
>  arch/microblaze/kernel/syscalls/syscallhdr.sh |  33 +++
>  arch/microblaze/kernel/syscalls/syscalltbl.sh |  28 ++
>  4 files changed, 502 insertions(+)
>  create mode 100644 arch/microblaze/kernel/syscalls/Makefile
>  create mode 100644 arch/microblaze/kernel/syscalls/syscall.tbl
>  create mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh

it is interesting that arm and x86 scripts and they are "almost" the
same. Is there any plan to put these script to generic location instead
of keeping the same copy in architecture?

fileguard name contains hardcoded macro prefix where in arm there is
uapi detection. The same should be done architecture and sholdn't matter
if you define macro with or without value.




>  create mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
> 
> diff --git a/arch/microblaze/kernel/syscalls/Makefile b/arch/microblaze/kernel/syscalls/Makefile
> new file mode 100644
> index 0000000..7624044
> --- /dev/null
> +++ b/arch/microblaze/kernel/syscalls/Makefile
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0
> +out := arch/$(SRCARCH)/include/generated/asm
> +uapi := arch/$(SRCARCH)/include/generated/uapi/asm
> +
> +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
> +	  $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> +
> +syscall := $(srctree)/$(src)/syscall.tbl
> +
> +syshdr := $(srctree)/$(src)/syscallhdr.sh
> +systbl := $(srctree)/$(src)/syscalltbl.sh
> +
> +quiet_cmd_syshdr = SYSHDR  $@
> +      cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'  \
> +		   '$(syshdr_abi_$(basetarget))'          \
> +		   '$(syshdr_pfx_$(basetarget))'          \
> +		   '$(syshdr_offset_$(basetarget))'
> +
> +quiet_cmd_systbl = SYSTBL  $@
> +      cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'  \
> +		   '$(systbl_abi_$(basetarget))'
> +
> +$(uapi)/unistd_32.h: $(syscall) $(syshdr)
> +	$(call if_changed,syshdr)
> +
> +$(out)/syscall_table.h: $(syscall) $(systbl)
> +	$(call if_changed,systbl)
> +
> +uapisyshdr-y			+= unistd_32.h
> +syshdr-y			+= syscall_table.h
> +
> +targets	+= $(uapisyshdr-y) $(syshdr-y)
> +
> +PHONY += all
> +all: $(addprefix $(uapi)/,$(uapisyshdr-y))
> +all: $(addprefix $(out)/,$(syshdr-y))
> +	@:
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> new file mode 100644
> index 0000000..219d940
> --- /dev/null
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -0,0 +1,404 @@
> +#
> +# Linux system call numbers and entry vectors
> +#
> +# The format is:
> +# <number> <abi> <name> <entry point>
> +#
> +# The abi is always common for this file.
> +#
> +0       common  restart_syscall                 sys_restart_syscall
> +1       common  exit                            sys_exit
> +2       common  fork                            sys_fork
> +3       common  read                            sys_read

Arm(and partially s390) are using tabs for indentation. Any reason not
to use it here too?

Thanks,
Michal
