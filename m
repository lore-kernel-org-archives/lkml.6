Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9644C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2770820892
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hj1cc4iW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2770820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeIJTu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:50:58 -0400
Received: from mail-eopbgr700083.outbound.protection.outlook.com ([40.107.70.83]:29664
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728527AbeIJTu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+AOPIsYnLOZBMXEbddbTgOZv3dmNObSA+A4lmEFyec=;
 b=hj1cc4iWEmFOuvH9j3gVumzu51k2wLN6djGSKmHVKk7f0ZAtYvigp366CNLBmgoSrCNYU4yAn3mvR2rxN4UCaTFDvJhzQiwpT4FfGkWqRMYPnQOYN+pbqdsF9fcjViYrBmfzxMkplRAal8tEIMv2eWNI1nPdv7y2wr29iXBpS5Q=
Received: from SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) by MWHPR02MB2688.namprd02.prod.outlook.com
 (2603:10b6:300:106::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.16; Mon, 10 Sep
 2018 14:56:25 +0000
Received: from BL2NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by SN4PR0201CA0056.outlook.office365.com
 (2603:10b6:803:20::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.15 via Frontend
 Transport; Mon, 10 Sep 2018 14:56:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT011.mail.protection.outlook.com (10.152.77.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Mon, 10 Sep 2018 14:56:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fzNc0-0004kh-Gb; Mon, 10 Sep 2018 07:56:24 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fzNbv-0002fJ-D1; Mon, 10 Sep 2018 07:56:19 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8AEuIDK004620;
        Mon, 10 Sep 2018 07:56:19 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fzNbu-0002eW-J8; Mon, 10 Sep 2018 07:56:18 -0700
Subject: Re: [PATCH 08/21] microblaze: get cpu node with of_get_cpu_node
To:     Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-9-robh@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <8b227f8c-f351-18da-b55d-e8979281f510@xilinx.com>
Date:   Mon, 10 Sep 2018 16:56:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905193738.19325-9-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(2980300002)(438002)(189003)(199004)(65956001)(65806001)(2906002)(8676002)(31686004)(14444005)(50466002)(81166006)(81156014)(229853002)(8936002)(6246003)(9786002)(110136005)(186003)(2486003)(106002)(336012)(63266004)(316002)(77096007)(26005)(53546011)(486006)(58126008)(478600001)(23676004)(36756003)(11346002)(446003)(476003)(65826007)(2616005)(106466001)(76176011)(356003)(5660300001)(426003)(305945005)(126002)(64126003)(230700001)(31696002)(44832011)(575784001)(2201001)(47776003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2688;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT011;1:5aOBWM4inJfMStSX5q6UM8X5jkjAyee44OoDiVOZA1se9tysWqUa/SHA4m+DW3j2z4RgrwK2gNMmggvScTgW34vt0T8mnlktrcsKdRoeKAF7t2LY/hpT4gQEkJ3BXUM/
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53fc7d98-f49c-4430-a944-08d6172d9494
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR02MB2688;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;3:ockI1u3WqkRwP103TYY8unxYK0V1sz43Fk0GQBMUTTg1O79U0zlJIS2NkjMfwycA/Y5N217h5zytMR5cVgvZi+d2m0zPUUNTDUPn87Xr8KTI2UrCkvwh0D8kel4PZSMqaYpFLX/3o7bBy8GKlf6NxykNFdmz4P57LsS0aL/M748tfM4AdqKFam1TjERhrD7v/utYXI1aAYuNU4TCudzSROiUDj0OONrkC1RTIpllxNOfltxtZrxnQiqnrJQZdCUVrUZ/rBQPL8elzV0r3zV5YRDAi9ETVJNf1R8BVKlm6JMqAD9Xcbmk1fI8i/mQ136TbxUP2V9kJNDPfCyjX2ZmeD40hMeU1bEoKvZpHDNPvsg=;25:xQHSWfsj8qUp2RW22Zht4dDQbBq9vrfeUTTXjFbdxz5l/EvB5d9XYg6Z6zgacC+UMTTzcH83kNQpBWfr5YIqyhVaoV5V45OFgrAQwYCNSFU2tSH4QitUP9iu/6fVzNodkyhcJxBA80ZvfF07tgtNz7FY9WN8lBlT+4FgXRlA4+neA0ng0+gQEJkIqn60hF7+7nCi2SPtp+KZKBKDqdKzSrFEa+Qcsduex8M/QaExQZLfMdxIGj678C5lpwpyKPI05dLOhbEAOVcpDhMgi2KBQ1yVVDA4GafX+xvtLA+QOLoM7twfxn56CuGNRGmszhorq/AyUfUDZkDXDkkY8QVGdg==
X-MS-TrafficTypeDiagnostic: MWHPR02MB2688:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;31:HZ300o7kWnUBYg/4mwNNIa7Sj6cLnZWxNW5N06jrFynvbfl537Lm7jwqUrlxFh0BI7rCu8cDNv+Sn0RQTFl2Y/5zChVuwdbdbH09duew9WyxhW2zRh+F6vn0/EGfPsHay/B3fg2/fjE3ou2vh/0t8UVBPHap6Pc0TrTTT7t/9kEn9DKvOOahDr8w1Romf8AGYonY0It04R/3Sosg/bfm5apGH2bXRLv5z7xJFO2pKr0=;20:XEpYOdhMNhzjTWaoi8KKF2s9pEqLexs0zL4lm4UHZN5FMWHVOw0+6AXNN0Pf+aVizRJmGXWTxd805b+ldibV6/wAMxNZAz5uQTMGOEYI1fviagoFtquqh80vgIh50bjOoM7MSmXPe5d/W9iuQgPw4guXGvFnHcu7cumdL2Wl6WstL1sSbGvpF5pjA4/qy7oxlLsBlp9AHvNMzZ0jfHwAGqLwhF2VxQbcpNTfbdJO5WW5E+rhQGxvpOQcIvrauhcHKZVtvosANSQ9HeWom2ZHD0OQfuZgwswyDvIAJLEwS8Ps6srz4DzyCQe0NT9yDBv6wD/S7WsULu2tguNCPF3v+xwr1dQrM1pIV/S8iKTATnOZZ5In5k3IgpkroPKjJSHC61LEpa41YxXEzsXPeda57XvJrN1Tiwkz6W31wkvLOrVRPGdquJKhDViOTP7tep+hXliB6ZcmctmNzQ8h5Q3yLqZFVFvMZWtxVKelIdNNwB7Chfm5BvMflKBPNq8XoV3H
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2688EA954CBA8FE15425721AC6050@MWHPR02MB2688.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699050);SRVR:MWHPR02MB2688;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB2688;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;4:t1sE0T9WW4OL0mUXz5OEmPcMDlWy3UyFh+82RyLp2lHlTh/UhuBYwrSVzZ9uDsP6sL/g0t1ma2DSLbU1TghcBs9zMCad6zWTcTl6h3TndEPp3ADJlYMoKdMC+TOsYgvsbbslS7jgS8Om+IsiVKEAl9AOtOLAM51xU/MUYOe2rW/pxKoxBzK/QtfVdoLNFF4EUnDFvzDV88y7B14zAZvPFV8Oy1v61sYxpfcs/oL70tpIfWfIlMO7XuzXzeqfpNReqH8/a/Lm9rrtH/0sXN0Ty0gSgdgN4Mt550fzzja4rpcXoylCo/IDTqkhRljNJHH3
X-Forefront-PRVS: 07915F544A
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyTUIyNjg4OzIzOkl3d3J3RGYxVzIyQ3BadTgrQityVHkvSU9x?=
 =?utf-8?B?dFI0SS9QQzc0WUNhWWFrLytJRC9jOUZUdjgvQXhPRXlDSFZyY2tFd0UyNE5U?=
 =?utf-8?B?VTdtemw3VTF2SGZpL0xmWXNSSlV3dm5DVmk0ZWtodW9sbVUza1VZT3poT3c3?=
 =?utf-8?B?RiswN1hqcHkzRVM3b01tcG5vSHJMa1g3N2ptbk9zSkNNbFQ2eGNIc2JBT01L?=
 =?utf-8?B?TmQ5dnRtc014QWlOeFNHc0dWL2hBb2xzMGVrSnN0Rjc1SDVWZW9ORXNYSFd4?=
 =?utf-8?B?TDN3WnppVmdmOUp2ZDZWUmozaVFENS8vOUpWR2h4U1lpcjJCZFluY0VnL2xF?=
 =?utf-8?B?L3VNSzNJemlDV1RMRXJXTkIrbzdkcmtzSGVlL0d1aWo1emREL21ZZis1NVM4?=
 =?utf-8?B?cy9zNW1BUG10VWhrYlZJWTJWSnJMMEV5aDc3Zmp5a2MrSWNuSE0ra3J5eTZC?=
 =?utf-8?B?UjRTYlpUY01XRzlPYWx0cVpjMlI0b0ZRWVNnSUM2a2txckptajFMdHdFWTVW?=
 =?utf-8?B?bmpPM3c3ME45UUVGUlFWTGlVZ1hieVpRaTJZb01VcTZHOEhXdlZTTUlOOTQr?=
 =?utf-8?B?Unp2R29DcS9JS0ZXSU1yWTZBMER1MzF2WGpKbGdQdEZ3Vi9Kd0JsTFlqOVlV?=
 =?utf-8?B?Ymk2N1dUWHYzSER1QWo3YUdIeG1EQ3dFNHJiMEpGOS9Ocmg2ZnVSTEgybWo4?=
 =?utf-8?B?S1RYdzQxbDlheEROSFlvendNL0psSUZWanNvYTJsZ2ZVcVppUGJZT3F3ZzBt?=
 =?utf-8?B?bVdxUUZLVTlUUE9MbmNISXEvT0JzcEtmcm5kTUpFZkR4U1A0SVdXUFpYK1Mw?=
 =?utf-8?B?NzdkYVp0NTd1OHZFY3RXQitGTFR4SStEaW81RHVKd0xXdnUyYjhDUFk3VWw0?=
 =?utf-8?B?alJQUDk0VC8vUHpVYnUzYWJJMHdwRlRFY0t4L01COGtvckRWM1lYdTl1eExO?=
 =?utf-8?B?bVhPVjRLdDFVWGJsbWNtWXBXQjlvRTV0NG0zZWNERCs3KzhMdVFWQ0ZtRkpY?=
 =?utf-8?B?Z2ZjTUp4STNVWFB1QzllcmxhMWcwYmZITmdndm42bHdlVU5HMFBiMXZObXJS?=
 =?utf-8?B?QzZsRWV3TW0zaGZ6aHh4cmZ0SVE2cjZnVTMyc1VhV2xhMys2cS9XVkEwcHZs?=
 =?utf-8?B?R3MyOGRJNlpzcC9GNFp5cDhHQnpGYkFRejJSSUtrbXFrMlBZS1BSKy9hRGxM?=
 =?utf-8?B?L0hONEVUay9tMzFKcEg3Sy9NTVlaRndBLzJDYkh3N3J1bFhSYU9ubFR3Zi9U?=
 =?utf-8?B?SVI3M0U0S2tXT3RLLy9kdWx2cnBrY0xOTnFTc2tIME1DN0JhZXFWdUFsWU9q?=
 =?utf-8?B?cnJMMHArajJiSFI1dC9NTEQ2djlEaUZHMDU5WkxLMUw0SFIzVkhVRlhuWE1V?=
 =?utf-8?B?RkdINEVLcksvanlKcm5NRlhybkVLSGEzN3E2QUg3Y3I2bG5VWjRBWXlRYWN3?=
 =?utf-8?B?dytURnowdFZoL3NxbmZUTWU5Tk1GeGFmR0U4UWVUdEVQVDUxa2pqVGszTjFS?=
 =?utf-8?B?U2tQSlR5aEt5QUtNLytCUGRiQU9ocUtnUlFFRzZyamRDc28rZEVJWGxCNmYx?=
 =?utf-8?B?SUtlS0psWDFTc1ppMHErZ2V5OGtEWlc5WnZMQ1czV255bWJZejdCV1hzM1FG?=
 =?utf-8?B?WWNrbWR5OVFRZjR2TzM2dmVSN3NJVkxxaW84SVR3cU9NcDhhYnRpVm9ickJx?=
 =?utf-8?Q?J2VFjGTh5dO+BavPTY=3D?=
X-Microsoft-Antispam-Message-Info: kuiUo8LzTs+qrbU2yA+iCGmMh93KLc3ecN5RsSrPPJbUyx8qAGvmHPIPBbFS46gaXT1vu+YuX/RSOfjZaYR9VvVZr9CbubQMullbPjGazlvw8kxK1q6nNA9VOGTOG4t7PiMZ4hpG38JIxpduYt4+r3UT+hIc+RszzvIua7/g0w5VuyJeOq4LQngJe129irmEJdYE0SkJ76YoJ9bgChhw3ck+AHCJPjQSEemWy0rN5fx2daPiauP2DyEL5elzR2av8mEqXJwPmRCxuGwC6u6QGSDZ+kHgnHDyclkyzfMoWGdOrSujc0juAmDTx8XTvWBmQ9Z7H+icAe0c+5+u67ep95bbXH1v8MYYj2wGWv5ElUY=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB2688;6:ChhU+63YUd3zGsGemglC801Ygp3Yl/tZIyVluzoeXUkqSS0X9z/spNx7V4V5n7lTSkEh2FmgInAforhuEY+RgogFdGXIAYtC3rX84zA6gHQgMbkZhzV3x9XGn3YrXpD4HIRXXsQRTg/15zNM0aQbbS0y0dvPoA5d26RFD59tbnq1DWU5+N8dhnUq74okhCUD+4SxcrDgN/BB2VQhnGvFqBtRHOX4Br+wWi8PGvtUQnmROAV8yAgg5MdFKe6Ug+j7s7311V0wB6tQ6zi/mdmtPPGfqZyIx+MZQzm5VZsTVPf6xoH+rVlVSisGESePpSvQizZn30fsjDk0iWvl7QuNw4LBFUoISO2+acIuZnu7nYCPZcWwdtrCUPllePSyOngcEAQa2eXmxLVZJHRMgWKIY5X6rcEuLUwUqjEJXmRtvnX5sBHtghnGZa7F4reRSvs2xlpLcFGit7aT6ILztxgzDw==;5:C88WDJ7axvrRRsNqo0YXucqRmIsWGkvgljRJyrzok0YtH0sKKnLFJK8M+2LXyorlhbSGaTgW7O2sXXerf9tAREQ+wZrOHs+/wioMec0/s0uWpJJQ/ZQeJB4b2oGPemj+Opi/FAdmowkuQ2om2u4hI1i+4LB8JQdUrFHc6t7UaBQ=;7:4ShqnxQpiH+D4H+NFcqkNUAfDKQqWLp0jK8XISVTaar2LW3lXIJ1YHX5+DFvOshAJqp75SgoacCJY/funcWycleL9W0Yb6I0OAl3J0jJ8ET8GU1Bp4ltdz5LqbkduNpE27+1VWe8ky1HZVkUw+M+ZLDP4F83BLHsELeuK5FDw+E7bbFckqjamG5N1bFqHOp/oQ0CixBh8+O6UREif+sfMoZTdj4RslFUG748A7Z0Q85w60M1cOke464AeCGyau92
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 14:56:25.0741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fc7d98-f49c-4430-a944-08d6172d9494
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.9.2018 21:37, Rob Herring wrote:
> "device_type" use is deprecated for FDT though it has continued to be used
> for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
> node names by default. This will allow the eventually removal of cpu
> device_type properties.
> 
> Also, fix a leaked reference by adding a missing of_node_put.
> 
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take via the DT tree. This is dependent on the
> first 2 patches.

I have tested it and it is align with the spec and all dtses generated
before 2015 will work without any issue.
In 2015 new device tree generator was introduced and it is not adding
reg property to cpu node which is required by this change.
This will be fixed but that means that all generated dtses from 2015 are
affected.

That's why will be great if you can also change that pr_err message to
mentioned to also check reg property to give users a chance to fix it
properly. Error log below.

Anyway here is my
Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal


[    0.000000] Ramdisk addr 0x00000000,
[    0.000000] Compiled-in FDT at (ptrval)
[    0.000000] Linux version 4.19.0-rc2-00010-gf9a96b0ac503
(monstr@monstr-desktop2) (gcc version 4.9.2 (crosstool-NG 1.20.0)) #4
Mon Sep 10 16:31:14 CEST 2018
[    0.000000] setup_memory: max_mapnr: 0x40000
[    0.000000] setup_memory: min_low_pfn: 0x80000
[    0.000000] setup_memory: max_low_pfn: 0xb0000
[    0.000000] setup_memory: max_pfn: 0xc0000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000afffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  [mem 0x00000000b0000000-0x00000000bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000bfffffff]
[    0.000000] Initmem setup node 0 [mem
0x0000000080000000-0x00000000bfffffff]
[    0.000000] earlycon: ns16550a0 at MMIO 0x44a01000 (options '')
[    0.000000] bootconsole [ns16550a0] enabled
[    0.000000] You don't have cpu!!!
[    0.000000] setup_cpuinfo: initialising
[    0.000000] setup_cpuinfo: Using full CPU PVR support
[    0.000000] ERROR: Microblaze BARREL, MSR, PCMP or DIV-different for
PVR and DTS
[    0.000000] ERROR: Microblaze HW_MUL-different for PVR and DTS
[    0.000000] wt_msr_noirq
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 260608
[    0.000000] Kernel command line: console=ttyS0,115200 earlycon
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288
bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144
bytes)
[    0.000000] Memory: 1027496K/1048576K available (4270K kernel code,
153K rwdata, 1256K rodata, 4989K init, 561K bss, 21080K reserved, 0K
cma-reserved, 262144K highmem)
[    0.000000] Kernel virtual memory layout:
[    0.000000]   * 0xfffea000..0xfffff000  : fixmap
[    0.000000]   * 0xff800000..0xffc00000  : highmem PTEs
[    0.000000]   * 0xff7ff000..0xff800000  : early ioremap
[    0.000000]   * 0xf0000000..0xff7ff000  : vmalloc & ioremap
[    0.000000] NR_IRQS: 33
[    0.000000] irq-xilinx: /amba_pl/interrupt-controller@41200000:
num_irq=6, edge=0x0
[    0.000000] Oops: kernel access of bad area, sig: 11
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
4.19.0-rc2-00010-gf9a96b0ac503 #4
[    0.000000]  Registers dump: mode=80571E90
[    0.000000]  r1=C028BD54, r2=C056FAB6, r3=00000000, r4=00000010
[    0.000000]  r5=00000000, r6=C0495348, r7=C0495350, r8=00000000
[    0.000000]  r9=C0571F44, r10=EF002400, r11=00000030, r12=00000000
[    0.000000]  r13=410C2FC0, r14=C0496688, r15=C02831F0, r16=00000000
[    0.000000]  r17=C02831EC, r18=FFFFFFFF, r19=C05BABE0, r20=BFFEC168
[    0.000000]  r21=BFFEC168, r22=EF7F9A80, r23=00000000, r24=00000000
[    0.000000]  r25=BFE6B84C, r26=80000000, r27=00000001, r28=90000040
[    0.000000]  r29=01000000, r30=00000380, r31=C05782E8, rPC=C02831EC
[    0.000000]  msr=000046A0, ear=0000000C, esr=00001A72, fsr=000065A0
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---
