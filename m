Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BA7C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7739520862
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wHQGGfqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7739520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbeKEWxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 17:53:22 -0500
Received: from mail-eopbgr730071.outbound.protection.outlook.com ([40.107.73.71]:11872
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726723AbeKEWxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 17:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYsgfwrBUm0k+FAJIOJF0wwK+o5KJaD4xbdDzr0Nr70=;
 b=wHQGGfqmqIH3qnWxYumXhU9ujfCjxpmOGZL0++7ZCdTbFdDnLceX095t1oeN1B1l1wNrgnnQJJQI6geELfsxgoNS47ajI+DSLiDHUhSxzgFXztuDQMWijfAQFW76OUmFt+PPJK+R7oNljuDHn3cdoMR5ExAVkymFkTCqiRW1C7g=
Received: from BYAPR02CA0066.namprd02.prod.outlook.com (2603:10b6:a03:54::43)
 by BL0PR02MB4321.namprd02.prod.outlook.com (2603:10b6:208:40::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.25; Mon, 5 Nov
 2018 13:33:16 +0000
Received: from SN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BYAPR02CA0066.outlook.office365.com
 (2603:10b6:a03:54::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Mon, 5 Nov 2018 13:33:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT005.mail.protection.outlook.com (10.152.72.117) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 5 Nov 2018 13:33:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:45138 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJf0E-0007X4-6X; Mon, 05 Nov 2018 05:33:14 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJf09-00017V-2G; Mon, 05 Nov 2018 05:33:09 -0800
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA5DWx8K009488;
        Mon, 5 Nov 2018 05:32:59 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gJezz-00011E-0c; Mon, 05 Nov 2018 05:32:59 -0800
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
To:     Borislav Petkov <bp@alien8.de>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Manish Narani <manish.narani@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mchehab@kernel.org>,
        <amit.kucheria@linaro.org>, <sudeep.holla@arm.com>,
        <leoyang.li@nxp.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic>
 <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
Date:   Mon, 5 Nov 2018 14:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105132007.GB7937@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(438002)(189003)(199004)(110136005)(2906002)(446003)(65826007)(8936002)(31696002)(8676002)(356004)(6666004)(230700001)(229853002)(64126003)(50466002)(36386004)(81156014)(6246003)(81166006)(7416002)(486006)(305945005)(36756003)(106002)(426003)(65806001)(58126008)(65956001)(5660300001)(44832011)(4326008)(31686004)(93886005)(23676004)(336012)(47776003)(26005)(54906003)(6346003)(186003)(316002)(478600001)(106466001)(9786002)(2616005)(63266004)(76176011)(11346002)(77096007)(476003)(2486003)(126002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4321;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT005;1:YTxj0+maDlNif8KpK6IOCaYljSAyBVotOV7ZzPRvhaMxvm+4Swa7U67CvDSUInkQhVIoUb/mVosuisb0z+WIumT9Z7amS6IJFPOCBdNKpA/viM49DngZc9mIKjY/yT7F
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddfa6c9a-3ef0-471b-80a4-08d643233d70
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL0PR02MB4321;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4321;3:1qhcMmhzkkgD/q+beM0DKsKemKnJcQ+ufolV5Dfo53OIj1f/TWlj8iW2bjzATfQfNT7ei0BGndA2XhxBXA9VnNXx+/ryzrDQQ3LeqRwV3MQVGEvzU+gHptVI8AIIpUg4x0ev5+F2WtKFmRh8P901uvLG3yx9pPCru80e5w9OrifIF88yZuFpH3Tywuc6AXi/jAR2wDp4zrhoc21xeF55O9HJCos5Jyr3Nj8isff/wPycQ11pu9XPcINOav15And6j54lN1ayr74aKNUktCEcW8FqEzN7e5HAHXPx8dvXWWh7yBaynZiUWBFDQaBCZZygFhdv9uE7Ti7FQVqTKf0zPYDDY2lGgxqQh/3c94vMtgg=;25:GNPUyAz/lPLTV6vpiFp9sqyyogvS3+Jf2Ba8Bre3IzrcTIpqEsj3Doa4TE2uBcIy2XoSvvHAzEh5MsDepjj6nUHf9sM+mSgaYq1Czs/ZJiMxaPEf5iIo7BBdBs/Yl9SzEmnSuvVPqTCOiQn7cJ+vkihCV75B+NAxX3Gd3sTylqtuGGG3UcvNh4YvfTMvUqvaP5KalZ2XPLPMu7eqftTIBcs//xWpAbzxeXtz+28l3A3NsLr3FzWw+whr6Lec9DEIKWIcTrcthJUa1oQZAkmWe63D+W2Y/KmQbK9hlle3RDbP7V7sgMq1V0IP1gJHivezoQvoPmYlIFUwgL2e2MME+w==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4321:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4321;31:FU5Vab/z5N0m058jiSK6ohBvRKvB4obG22NeaeXorpkNd0RlO9klrPP+LMQLvFV7cqHoaPXRjh0xgD+H/+xaXyteew2pLkutTGR3cDnvSwXnaq2z89ZJwjAfIGDnqZSbExYD55WIwggGoc8BimcuWxq1ivd7U1UDYNS+YUm+9J+x9MuAIS2zsQfnbX1/oGe+eVqdqNn1T06dYbKmRlvuAePzpq6AemY980swpY1VROY=;20:P5oPnhqtlMoG03JU4tWV76UtARCEoZqlMYCkVoVJUdoc7Tqa7fRTuJ1B+UFyZo5K5nF/Xssx2gbfZl0zq29+RPHObeuQsNSOKFQkq+oSolls4QleoS2ikVoWKnoEeX1GysjXMVgSpO41wgIviaErQ/4mtk7P0NUDgjPXvxPSVE61e+ZoKn/CyZc6+axOXy2JWpsMGXnrF3lqM2jewf4HqTYQhkMD0wpN2i6DJtc1Ch5X/+xWI8yJnY8HaxrnXT7J6IvMZJypRsZwauWM15fp3gC1CgpD+00x+ChQxmg1ebr2x7+EmwGGVdE5AFAkArxjGIvpMWniBSzRhSGSmalg9aW8ON6J4m/k9NsZDz6mgjGjPv9BgdmdDu9v/LR1pUE7MvcIENP0y+dseurdtPlHoCzZoXJd8QQKlLAYwV3by1M3/D+MJkGXwEKUbDmkaE/AawC8ajbRrXlLWcv9JaBuUqlrbVjvxON8zUI9gwUIp3OskuC8IjNvgmxxkZtn2YaQ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4321B04BE171DA47A2FDFE2AC6CA0@BL0PR02MB4321.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231382)(944501410)(52105095)(3002001)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BL0PR02MB4321;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4321;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4321;4:7cMAEXSm5iI73ruxWfyAfMvQPc7cHchhryQSMRfsntOIElGRoReqfGy+72ZOOqCPA0Fci7mS2wv7B4pZU+ZX2GZ2P5ywNlyd1tiRj2wU+zu/Cv+8UFooPDJ7El/cPNfQqyVv1+tDH+g4lZrV51hV7FeATru1XflLsb9W9Zrug5ZSr2vK5EEcrjiF519QlbJzUT+HDMCEwcfnEXPa2nuR9yz0tH4na8d6KvqyuN7EGgGHlSYSPY3F4XPn6hhOUQoaBmaRkkdeP2rHhHZNKcbk0w==
X-Forefront-PRVS: 08476BC6EF
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDBQUjAyTUI0MzIxOzIzOk04UXozbk1XY2dQcFNrVnNWdUlNd2E2bkRL?=
 =?utf-8?B?bHhXRWZWN0t0R1p0bFBqUE14ODdQbThxMi9YdHI5dkpETmMwQWpUUzZoY1do?=
 =?utf-8?B?SXYxc3VzRjEvRTNiZmNNYnR6RVJMUWV1S1g0M29lU1M2Qmw2TjgxWmdjSFd3?=
 =?utf-8?B?U2Z1dHdVZlArZURSaEV4bnNjRUhtckYvajlSQ1duTGlNWnN4d2NzWXY4aW5L?=
 =?utf-8?B?ZWRVQmFDNmJRSE02Zkdjd3JpUEwyOSs5U3A3Y0UwZzdhblFUc2d6a2xPNldj?=
 =?utf-8?B?dzBZYVNRakgwTnZlWjVsZlNNaHpOYjRFc3RySGgwblFXVFhqVmVSZUdSTUJ3?=
 =?utf-8?B?eURVcVgvY29LRHR6TlZMU29MUG9XS1dNYTFnUElCdFZPRkFoNDhpOVhUb01r?=
 =?utf-8?B?aHJrQkNUSEVtS00rV1JDT2dtWEIybnlHRHd5N1BWWFR5UTdYQUprUmlVRzBE?=
 =?utf-8?B?SHNWUkF4UE15d2VMTWpSalFYdzBxQTlseVpTRFVveHcrTlF6Rk1YazF0SVZ2?=
 =?utf-8?B?UFZsQ0V6T3hoTjV5YUl6MmpKWXIwWEFFVGh1MWtINkIyRjhkUUZ3c2ZpenFM?=
 =?utf-8?B?VUdSQXM0VjFrUGhEUmh0N2I1MFpQTTc0eFNkbWNIZEkwN0xybDdreEhpTzBW?=
 =?utf-8?B?Y25nbit4bGxoenNvWjBoMEc5Q2t2Smh3VlAxZ3ZxeldPcXNkQktmRlNWQ0lB?=
 =?utf-8?B?YlhWNFFLNmcvYzBQdzllbU9Zci9rTEIxS0swdnpWRmtOWjB4WmhQakhpamMw?=
 =?utf-8?B?QjZKTkdZdXNZbVN4Mk9BWHVsOXJJSmxwQ0JYTU9GajZ6bkZGSitzRkpHWHRr?=
 =?utf-8?B?bFRWYmhHa0xMVnZhS1RQaUMycEtpalk4S1h0VHlwdFhaaXdhOHNYeUltd1ox?=
 =?utf-8?B?VFM2S1VaWnNPazB2bzZVVGdwZmRsdkRPSldRYUxxMElod0xFUXlhbkJ4MERP?=
 =?utf-8?B?ZnI0b1J5R0paRGovQnVhOE9TdUNqcVNYb0ZMRlplUjNDKzdhVUU4TEFXS3pK?=
 =?utf-8?B?dTM1VTR1bDY5a09UZHlmQk5Qc1JyWjE5eklUa2tQUEZMbVVCd3ZZRDZjS25M?=
 =?utf-8?B?UWIyczRHSFExc1ZkTGZBdGN6OWZNRE5nOUpITUNEZVcwSnRpK2tWcE45L1Ir?=
 =?utf-8?B?aHkzdFFYeGJ5ekMzUjg2L3p0L0g4ZklKaDNxTWFXdmI4dHNDdzBITUdkUEdl?=
 =?utf-8?B?TDJRQU0xcEVQcnFxZUdicUFFaGc1TklPQTVXOEhJckdHUVMycHFKOGFDQjRP?=
 =?utf-8?B?QS9mYmdmQUtlb2dWWjdlR0U0T0o2L05JL3psaHNkOStLcFg2SitBbzlzd1JQ?=
 =?utf-8?B?SGNVeEJXVk1SSDJzSmZYVkpsY3gwVGc2eGtjUm0ycjNLbWRtZWR1eW91VHIy?=
 =?utf-8?B?WkVucjFSeEx1aWVkWEhCaVVqZW9oV0pFM3YxaUxKK0QyUm5wcVFuMXYxS0ts?=
 =?utf-8?B?MTIyUnEydnhiT2p3MEpiRlpTSWpGczFKeDRUL2d5QiswYXUyTkd1Rkk3dCtv?=
 =?utf-8?B?NnVwS3dTSzRRNEplcGtZa09ZeGtBK3FDU29FMFpveWZPbmNic3RnUGswemlv?=
 =?utf-8?B?cjk1dFZ0bjZsZlQ3WVk0cmY4WlV4YVlqTHFqMlFwRGpsRStRTjdoZnhXdnk0?=
 =?utf-8?B?bzNWTEk5ZnMvdW1nTDU5Y1htYjVWVHB0bEdFcnZyaGY3RzZMMmw0MzVGN0x1?=
 =?utf-8?B?bHhSRTIvS3J6dU1EVktDUjhtNWc5RzkwemIrbUkxT0hZS2h1a1AvbFNVbko5?=
 =?utf-8?B?ZVVrQlZqVkl6T0FqUFpvTlcwZS9UclRONm9mUFpPaHFjS2lEcGZzWjJJNDZ2?=
 =?utf-8?B?N01CNU0rNlVBa1QyR0lubmRtWVlRZkoyenFkcTVjUFR2eHc9PQ==?=
X-Microsoft-Antispam-Message-Info: YyX9cLAcfGa/7N6lNvCdJnU9MKBwPAoOw0IURwQJWNS5vRKpOI02Q/if/nNkX9+npMekhx0WRCP0m1mWnXnlU7l+VHNA7iSNcwxrOhv7tUq8C/HAapwkdLXDop1/et1GRNhE4uBTPRugMDWFdTah0sCfS64liG3eP7k8DPar44o0gFT4toVftQYtqjIb2VnCeNXi5LRm/JItbTTvgDI++lped7PMKYb5Su6Nl7xR8OBdt10eKIiuU/h9OODMOrkXdG6zyo2cJmqamENECefKjtqplnnqDWQVrGqghpyArTZPm1rtuTWMk4ccjlP4bmjU/Bwc4vQ40DLhCK6gw+FtAXUj25ZQCfoy/S+4GFpK+mY=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4321;6:WbQgWljoepdHWizxD0dANx92zo/aWLNsJYvkyHk9PmkBHKFN89171WV7ES0m9XJRE5buvG58n8dIOTlCX18KmTrUnUWEnAZYcl8jAyaZ15bohoJzg874uNowMcsAOQdRFYSniMvO5ytnm/xZ68srDFc8bwkJqG2ixCaPzc8L9/xzp4uVhPIZ3mi8aPPt0WdgNRGSiRINrfFVIBMY3fJbylWOvN7p6tHWYmmppXyeECr9T4ramwuOOFUxMIo6kwDMbe4SLaDDGFvbgdFK+HYSo4vYyXa6A+txssyQYviJQ94PEp7gdJpj80qSt/0dFTIcszYHh0yBSJeKWekqskuOw0Mw90OMmonseDINtwdHrniRyEg8n6IyI57Yc/3cdGUmQhUcxm/hwxoZdrQqxJcb53070tkYuf3aDZPjpVzxakyTzfBqGoHz70QH4H6fBACnSfHopGKAKkMNxnhJREv09g==;5:WWavo3wTU/vKvqySJiBCVoa4fnQCAyDsr98ulbVCkyfpad4eSxmELhpFjridjTWeQmq8AdikjdHmUlDzaQL2Yg2a+pgo8PzB5wXxtbjMmGYMg4UHbm3Xx+sxE62cIxC5AOTvnToR/x7yf+4KWGpmio/QQvQ3zHACQ1brf2MZmpU=;7:9GaVne6Ql3NWg3m5IRnolp7+bnUqfUphInaRTBRRiOdboTCMwBpH2jwzpHg0V51Dzem6LaA2uEd2wlhcN8oW3Q4VXDioB7W3Oj1pbPDs/R/O3MIux3zx1MXuppP9MfLTC8nVNQg3xrIKiyBb5i3scw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2018 13:33:14.8203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfa6c9a-3ef0-471b-80a4-08d643233d70
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 18 14:20, Borislav Petkov wrote:
> On Mon, Nov 05, 2018 at 02:06:11PM +0100, Michal Simek wrote:
>> I don't think that driver will be broken. You can build them, use them
>> on out of tree HW. And when this patch is merged to mainline it will be
>> enabled for xilinx soc.
> 
> But if the DT entries are missing, the driver won't load, would it?

you don't have that HW anyway.

> 
>> TBH I can't see any reason to do merges but if you want to do that way
>> we can also do it.
> 
> The reason is because there's a separate DT tree and all those arm
> drivers need DT.
> 
> I have already acked EDAC patches to go through other trees too, FWIW.

I looked at v10 and I can't see your ack there. Can you please give me a
link?
I see Rob's reviewed by in v10 2/6

> Which is not optimal either if someone sends fixes ontop but I cannot
> apply them yet because the dependent patches are in a different tree.
> 
> So yes, there are at least two good reasons for merging a shared branch.

I have not a problem with that. I can simply take patch (process via
arm-soc) with pointing to reviewed binding doc and you will take the
rest when this is in arm-soc tree.

Thanks,
Michal


