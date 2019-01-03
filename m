Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850DEC43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF3220883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="h6wo2Qp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfACLDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:03:20 -0500
Received: from mail-eopbgr780044.outbound.protection.outlook.com ([40.107.78.44]:28625
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbfACLDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0mvc2I2OSm2E0oYl0OsJnC9ggXMERIsTeVlDTJDRXQ=;
 b=h6wo2Qp2MGXw5y3C0ttLprsYZ5bPM29T/PQdxNGBm8KRPoqzKWx/jwX/KhNDWUKS+kOq1WEQt/ZLcf9tD2c+ifhoiaBtH2mo2l1eRNG2E4+GT2enXPMNWpCUfMbxregk7P0IzE/kB751/kTKh/68bK2I9tOo5w+SFGAjUDpcFS0=
Received: from DM6PR02CA0023.namprd02.prod.outlook.com (2603:10b6:5:1c::36) by
 BY2PR0201MB1895.namprd02.prod.outlook.com (2a01:111:e400:58b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1495.7; Thu, 3 Jan
 2019 11:00:24 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by DM6PR02CA0023.outlook.office365.com
 (2603:10b6:5:1c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Thu, 3 Jan 2019 11:00:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1471.13
 via Frontend Transport; Thu, 3 Jan 2019 11:00:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gf0jf-0006c0-3n; Thu, 03 Jan 2019 03:00:23 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gf0jZ-00073p-Ua; Thu, 03 Jan 2019 03:00:17 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gf0jT-0006p5-Rm; Thu, 03 Jan 2019 03:00:12 -0800
Subject: Re: [PATCH] clk: zynqmp: Fix memory allocation in zynqmp_clk_setup
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20181224055058.GA23947@embeddedor.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <8d281c7b-4d07-02a3-fd89-61eeeaa78612@xilinx.com>
Date:   Thu, 3 Jan 2019 12:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181224055058.GA23947@embeddedor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(376002)(346002)(2980300002)(189003)(199004)(44832011)(31696002)(110136005)(575784001)(6666004)(31686004)(63266004)(50466002)(305945005)(2906002)(486006)(36756003)(54906003)(230700001)(229853002)(316002)(58126008)(356004)(106466001)(106002)(64126003)(11346002)(65806001)(65956001)(478600001)(2616005)(336012)(4326008)(426003)(81166006)(8936002)(6246003)(81156014)(8676002)(26005)(77096007)(186003)(5660300001)(2486003)(9786002)(23676004)(446003)(76176011)(65826007)(476003)(126002)(36386004)(47776003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0201MB1895;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT004;1:SYM1iK/p8EgWM+DbV+Wrf+rVwsCdSAwiwW9iHL7vVGBM35VR3YM83ymriRwHBH2uaeysBzpzvhfYusRmbzMC5DDzHD1Sy9MA4zw8kUIGeGDH3B3Mv7L9tqGZcVbUVS7+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f591903e-5755-4edc-1309-08d6716aa93e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BY2PR0201MB1895;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1895;3:gu+BE7SK9TPAf8rR1AM46A73sgLaWeO0qguwAAJYDnJ/glOr+itiGH4FEBVVR/opfMb1QHIoQceSuaHmHo9valK9i6NUHLYk6cv80QIUNxnD3wr6jKG4JSV4zNca6EDhPQVqAOiz0VQTDq147zMaocyN3fM9MrCM+LcWO3td+AoXdamyF0RhwcJI29g2XaUSYNqFoqcRcfnzvPI2eRflx1RFS5tctW+/z8UInV3MPSMUmo48VJGolnXS45ehNmqZtCVsvFZRl6J/j5db1dqZr+fgBzsjuERO66JwqjfqRmFgHMpave42obOu2GUJ1f6OpOq2nPSgh7YRd8LZN2X9arBZN3oEIet34up7YP1qJ4rAJS7fCC/GIB1DQ9LhXrfX;25:P9r9wlBQWTkY1TG+X79QiSHePfhLlwpIb/83AuhZT2676oiQ6bvL1IfeGEr6PbOTkK7XnV6s0D87JGj1sAuGf67UujGHA3Xzt+Bt8L1HOaF2mxfINaPNdCLyjqep3nWsje59SPjx2B95QYVomkQ3NqprhYQgPtcBYQB/j5i6D4uKj9d4TeztjdV9eyzgDiClhbTPWx+qTYTI8JiHlRtPbyXNOzCJIlmpgcF95Ep9wdA94ARnISdSCaN3h+WRr0VzLszkmFVkf7FwuqL0YOKpPvHCC5MOHfxMnC5XczugyIJam9DLtbHZDqvOdT6DbPfINqnzkhC579h5Ai91zpgb9g==
X-MS-TrafficTypeDiagnostic: BY2PR0201MB1895:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1895;31:MopCWO2csQwr2uxDLB3Q2+/zWSEZKA8d/LfJk5Wrg1OhO/NZQIHEPOmFVL6b7c33kjsCGAFshyyLPbV0Bwgx9VEDPFDyABOUairpPvqbpHeUppJoDCpGirq2GgiDIOpMq45a7sQbvm+3FSPJYSwAweaE+dmhlWRD2Ai4jYYknJ0nmuY0Ql8V2S1IgA9j7r0WJ0AdskAPaxWJEIEggTz8OUt25cGtoW/ae5VFvsyoEdE=;20:pGA4KOQwOu2Pwb8IpW4Q2qWNsgjUrnVaZEG80ON7uct0gcQCfcsFCp/oUfBe+Dsi9hq86O9TYaIncJq6L6XfcBQYmXJJ7ZoeiKPRJK+AWVDJVs/u+z7UozVK8MOAXURR/MeOw+A9cdvOAGk7YfornfJOQj7V9KYqWp8Mnkssi+YmvWvvXoYfvHTCwlEL1LecekMGioWOH0bbwjW/NpadkawVgNWr1EmV5xWtxf34nZT9YZb7Y+hHF32qNoIdjLN+/W3gKrNSNLXfipV7DT1qs8ktz1CZrXaPGaklN87tgTnQEp2aRgm7JlMTwjpHqvCNQvi3zxbjcH8B3K5F+5kkUGVYFldhDQMPgJsV2/75QHXX+kJytTu4+8wuOnB3IT9sL6fEPghnv7+MjZzAdcPB7BfPhiD5vE+drOJFtptf3mB4VE+gnuITpqRB3au2wWJkoD24JXdhqlC7LkdELOn/l49V8K3b2VrZd3jO7aMSl1vOyMwBi+gHjKYCplsQ3oR3
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR0201MB1895EB5BA0CAB6C3C4C61E27C68D0@BY2PR0201MB1895.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93004095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR0201MB1895;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0201MB1895;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1895;4:NK+TK+Nl3XAGV3zJb/kLbILk9jaDpLmCbqUzn2Te0H/u+II+P+fNTtrjPC9oSbJ+AC1Ehwf142S/IaKWpt1Yj5mPMAUZbSqLr2mqBSYmQ6v0+35GC6qQ9JhavDgbp1YtwTFxSCObHPqVt4mrIEY3okk4h/eDcMS5fdrmCkyLMzqz5+UnokkMQRXAQlm7vzxT20sR3t8r3C1AwfUkN020vQZAG9DViaWM4aBQ2cnNrb689fOsOxgZ9Vb7m/S+EAi1k7k6nXou1pMgOg2k9VZEvVtmf7OsQuN1YSDZv/CSKKJqeNTQ5aIVl6ubsBnomn46
X-Forefront-PRVS: 0906E83A25
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyMDFNQjE4OTU7MjM6aW9RZGxGckV3ZFBnSFhDVjkvcjlma0E5?=
 =?utf-8?B?OG9wMVdVQVRPcXFaQzNnbWlDeVF5SzdUZkc0dWR2ZUdON0l3V3ExNFoxYi9K?=
 =?utf-8?B?YkY3aEVEcWNPOHpqQXNXd1ZpVzlJMU9HM2ZPVU02S25CVGVPWHdvLzlFTUV2?=
 =?utf-8?B?MEp1M0N1UUV0WmszSlpLY0hWWHl5aVpZTDNodUxUMUw4bkRkYnpZV044TlZi?=
 =?utf-8?B?cFozcm5QQXpka0gvY3VKTVcwVXNrYnVSeGthYlZNS2hzMzdiWjBpM1krVTVh?=
 =?utf-8?B?clFJT3BqMHlnOWdHTGhsRUwyOG9IbzY1bi85TjZGWjFvNHpSSzdnRVpleUZ4?=
 =?utf-8?B?bjVpV1JDQkRaQ3FNVlV1YlVIY0NpdkNuOHZPVjJuVFdSUit5azByUVpDdWF4?=
 =?utf-8?B?RXpJWXBCQis4QnJ4L2xRakVUT21COXJHeUFobjQ5bHhSQ09QTG50Q2NZY3VO?=
 =?utf-8?B?eGF0VktOakl6UVBzL0RaRndJQzMzaDFoWW5FK290NlNRQTlzZmlrUjhOM3hM?=
 =?utf-8?B?cWgzMGJrdjUrc25vZGVUbFBRNDFhbFVKUFBYaUdGa0xoV2xkdnJnL2FZeFFH?=
 =?utf-8?B?Q3JsdEVtNzVwSWNJMjQ2TS9abE90akl5WTJuZGxIcE1PeTc1ZFg4ckRGNmIx?=
 =?utf-8?B?VTgyMW55ZmlaVmJqbGxoOENnb2tXb2F2R2wrVVJDd1d0TVZZYWNKMVJraXBS?=
 =?utf-8?B?Z0kwckF6bmlZeFhjOVowUkF2WllJd3lvTGpqbnVFN1V4ZTlvRmN6YllKUEg2?=
 =?utf-8?B?QXVXWmxaNld1R0o0NzRMS2x6RE9qMkEzVG0wUGRnRWRLekZFV1p0T1pmbjNO?=
 =?utf-8?B?T3M5dGo1WDduTnNwUGpwa2RSNW16VzlVTzJiem1hYU1ZNXBOb05DN1FYMEk0?=
 =?utf-8?B?UXNOYnEzRkt5aEFBVE5zWWhtZTFHZDhXY1d1WVhMOXZHZVlVa1JZV0twbCtU?=
 =?utf-8?B?U0poUjd1dVJBcVcza2xxWlpNRlowenVYdG8vMG9mL3djVThlSWljSXFEbjJK?=
 =?utf-8?B?RUR1aHFSRTNzaXRLUWovSktjdjFNV3YyY0hJL3hGelEzMUxpR201OVFCanBQ?=
 =?utf-8?B?VEIwNzFFM0hFeGMrOXpDeFV5M1RGZnZnTjBiY2dNckNPV1hxT2RxRG5ZQURU?=
 =?utf-8?B?cTh3TmZ2UVpEUEIrZFc5SWFNYmJ0U3JWYUZvYjdDVlBCSVVHODRTSDZRUUdG?=
 =?utf-8?B?dHVmbWZ3WTIvblowdlNrbW9WV0JDT3R3T3F1RWpVMkR6UVJ5eWY2U0hUNXVo?=
 =?utf-8?B?OGZ3YitKbjdvbDliZzlqMXhuZEg1QW53dkFGTUNCNE1Yay8zMFJXRFpPbUtj?=
 =?utf-8?B?bldsMHhwQiszYlVNcTRscmxqamQ2c3pBR0ZIczdLeUdCZEVoWE1QSWNxUlAr?=
 =?utf-8?B?cVdKWHRzZVFreTZ0OVkvNDdNa29sVitzTWRwZVpRNTRmc1FHSWtPR1p6U0s2?=
 =?utf-8?B?VURrcnVxeThYS3hReE1PbkVXSzBMQVR0REhQUjJscmN5V05TdWI2bEVxRmZu?=
 =?utf-8?B?MlgxMXhSdGVlSXY3dFBDU1FzaDJDRXpwN3R2QVJGZFRCaW1ub1BIbGVpNmNH?=
 =?utf-8?B?aTBORlBlS3BSVG1lWmZRVGFJMnhXK1pha2R4VEw0VGNHeStDbk9aWVU4bm5X?=
 =?utf-8?B?S2tZZzFPNDRxZUtEQ09raDVTYzZIVTVYVWd1QjY1WkcyMjkrVnU4Y3FmbEtZ?=
 =?utf-8?Q?wp9lveXbANW1ovf0wRztKpiQLbz8JOetfqrbn6P0i?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: MpwDVo3IvKCFZell0y5RCMG+A7DLuCgTvFSIYVdnh8lya+nFPYg9Nq44v7z6dDU5Xe8Q6ZiJ0USK3fGTzLz6VNIOYaAx5AkhKlJtedp6V1yBOiqOMks3Q97pDY8q8ZfptrIb5jwFSzhfVVLqoeWrV+Bv/l5bCn2RQ/jLgdhP6ZD/KaYnrXgeQrBBmYdRle4hUiOcpJdCUtJ7ujSruNncm8MV7PNvOk4Qsgh8Lchw2S7x0yOZSbaFiAMvw1P7IUbNTPdR3+ItbXh9fol9WmgJPHYdJ+v8B46DUeeRkal20aPg950y+Dyi8nTz8A9AW5Sk
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0201MB1895;6:GyFjw+uKDhNmOEtQFhuS/f8ysvRuiN1orSlgHnE1Qp2llywGXRecPS6ToJ4kAEfMpIHRn4Rn6EamnSkqtgMd92ab9N4P4YO7sPaz22cIE/HNrQqpT+Pc+At+l0xzydlQaSwT7nOJMkwwBq0MnxxcQiSRqaQ8S0H4CUEGScDk52fGHVxN5py9aAIdMT96l+c76pUoeD49+8e+hIlEbUPe79W3oCFMzKmOsF2BB7XljubJJJe5nSg2JulcW2t5e68Do4iM6WcKnEUjk+uAk8H4JDEkKGTXJjzOpITe2i7rON+oWlwSWwfpBikTdm93RmeWGz3TT0cA/gsXD2VXeaHq6GwjUC4XIirWCI1wn08BjgQeZoDcUEocOGZrmusQcx6KU81AE/1oCc/zuyIySKwv+Akg1+GvvKtQgqk2lu1DWS4H7vy2sPHq1aoH5EAFi0OBj9a5KGxwOlaCBdbnu21yJQ==;5:QmE8GL0dEDnW/26dTePpBVYjNpml9x5Sy0m5P9XptePIviD24HmE2ftNhWaRN/zDrR5+qwX3n5vrsqualYCDoML+O3qk1Rd1aj6ODkb9FLTQUItDtoOI8MQZuQTlgPdq7ijzsaZuiauH/deHleXZA9LRXxuDmuZ3lSRxmZ8L3wZarq0WzJMDiLFP0lUQYKWqi9hPNkgbFIXmTo63zfmoyQ==;7:ByUb9caqATc6dK6ftDiCA3ZWjiqu1+UoMLwfHpcx35+OQnpeWF7GCkTvJgajlbczSr7FhZN7qYscYiw7hbDjpuCGBo48iRxZkcPvkNDkhqtYvm7OZrPV9SVdcn08PrmDM7Pxmy3pDlGxfjabtDR22Q==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2019 11:00:23.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f591903e-5755-4edc-1309-08d6716aa93e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0201MB1895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 12. 18 6:50, Gustavo A. R. Silva wrote:
> Fix memory allocation and use struct_size() in kzalloc().
> 
> Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/clk/zynqmp/clkc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> index f65cc0ff76ab..b0908ec62f73 100644
> --- a/drivers/clk/zynqmp/clkc.c
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -669,8 +669,8 @@ static int zynqmp_clk_setup(struct device_node *np)
>  	if (ret)
>  		return ret;
>  
> -	zynqmp_data = kzalloc(sizeof(*zynqmp_data) + sizeof(*zynqmp_data) *
> -						clock_max_idx, GFP_KERNEL);
> +	zynqmp_data = kzalloc(struct_size(zynqmp_data, hws, clock_max_idx),
> +			      GFP_KERNEL);
>  	if (!zynqmp_data)
>  		return -ENOMEM;
>  
> 

Looks good. Description could be maybe more verbose that you are fixing
issue that it should be sizeof(struct clk_hw) instead of sizeof(struct
clk_hw_onecell_data)
Otherwise
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
