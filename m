Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4A4C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFDC20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="lI08kaqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFDC20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeIKRPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:15:02 -0400
Received: from mail-eopbgr690047.outbound.protection.outlook.com ([40.107.69.47]:18656
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbeIKRPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSCLk6VJXKY7MnhA5P1EMAh+UCGqIC6R6TKKBDclyng=;
 b=lI08kaqP+3wts/xfn/ncUc2Koh7LxiRkMKkEZ5vw8V9JVitjO/sWXthodrDKboWPAJKfvVTOew2QDj0HQgP9TvMctvGkZXQ9Ztoo8sPTvarT4rd8rFHSKr1W/Wj7rN60v6RWTKbkbluUZb3DAHfQ+csGuQ1j4zfoqy9dJwiAHOY=
Received: from CY4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:903:18::34)
 by BYAPR02MB4760.namprd02.prod.outlook.com (2603:10b6:a03:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Tue, 11 Sep
 2018 12:15:53 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR02CA0024.outlook.office365.com
 (2603:10b6:903:18::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Tue, 11 Sep 2018 12:15:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Tue, 11 Sep 2018 12:15:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fzhaC-0004Nd-Nt; Tue, 11 Sep 2018 05:15:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fzha7-0006GR-K4; Tue, 11 Sep 2018 05:15:47 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8BCFh40015719;
        Tue, 11 Sep 2018 05:15:44 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fzha3-0006Fs-N8; Tue, 11 Sep 2018 05:15:43 -0700
Subject: Re: [PATCH 08/21] microblaze: get cpu node with of_get_cpu_node
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-9-robh@kernel.org>
 <8b227f8c-f351-18da-b55d-e8979281f510@xilinx.com>
 <CAL_JsqKWy8dmfF2zCAsEVkDdFM14niKtapqnR_K45Kr3-mZhqQ@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <57c78c6e-995d-29cb-fde5-8621610ea9a8@xilinx.com>
Date:   Tue, 11 Sep 2018 14:15:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKWy8dmfF2zCAsEVkDdFM14niKtapqnR_K45Kr3-mZhqQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(376002)(2980300002)(438002)(189003)(199004)(426003)(93886005)(11346002)(486006)(316002)(2616005)(446003)(54906003)(110136005)(106002)(336012)(65826007)(44832011)(5660300001)(58126008)(229853002)(106466001)(36756003)(63266004)(8936002)(81156014)(81166006)(31686004)(9786002)(50466002)(126002)(476003)(76176011)(2486003)(23676004)(305945005)(4326008)(6246003)(478600001)(2906002)(8676002)(230700001)(356003)(77096007)(26005)(186003)(53546011)(36386004)(64126003)(65806001)(31696002)(65956001)(47776003)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4760;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT017;1:Tdbs0FoqXOqB0LlDeRdDpmIaVIrWGHyMUUk3OLmPz9yBryG3coFExGoz1FI2JAMrYNNaAxFK7PK9XrKjXyrTPKjyhcjtt8rxi0EyFwDc2L9v7l2/YZ6RJ81BzAoRY3A7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fee87c8-6f31-46e8-f204-08d617e051fe
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;3:bGdCTTCaof70Scuhx7StC6wy+PrYrHLr80fP4YNb0mEjzMVg05f/Aj3sN+xJ1lZKUnlimHLif0xQDWh4sbPgfuWs0e1X2UrhHIPfQc3rbq1+niaR3qLegaOKqHZjjB4jQw6Nu7D6PxN4tfjygMSacE9U8Stp/AwU7UcBN4qQETf174FmmzERufySUkTiLDLgDaplO/dlauhmBFkiTjsN3RE8/Z8Kd5RLNUS46L/lqLIA+ypb/KQnmH2I1MMJifjnh6oY7Zm0G9T+Zn9SoZZu1CHg1QJil7zgCUEMfdy27kM5Uh3qyPjelESNYpnxFBw4A1YbUvkyCff9vXCFidrWGMGhlO9vvIN4fEPI7Jcx4A8=;25:H5jMPU4EakRvLdtHtPoqizD6U3l45hKTaDGj3SRL0DR0mYd3IQoYy+teanbSt4cZIVKX6srb3HsqNGicjbeKr8QQuqPp3BfmlAO271oFo0hk3i5/4j0rsJTHz5KoW2NMRlWl7BRnkiB1SFqErk19UDYIXhPD/SYvVdpZ+UROjcDHpXylduLs//tHX8+0ozZU7N0rHydBgUPFzQ8T2ESni9O9ojSD9v8KPXSpcLC6eR2yR76ZYCxjcLHiWTi5ZDyodRckOOAhGESyI/VeVmWuPNyL/cljEBi/OAMO7eqm2hcJcliufc0YS1RhpQMaqMuA0TPdpRLTlxwrNHbu94+/8g==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4760:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;31:El0896n1/wndneFYPvsDutV3CVTQ1Q2E+yQMW5QTqGoVse6j8ftVhY+pCYzZe6dLfwgCn0NN9iG3r8yzW2WadRpmvE8mH2797TBKME5NkrIC1xWYCVhGlZtpu6w2yx6mfQjo0pirh273TTijyEW7omwqMI/xFTkKGfcJ0SlJARrFnO4LMTcn94xFOmYk3HWNBqECZ1EWWlqyVIzJA2aMxBaLJviW0jPYWx52MCtHkoQ=;20:EpCFkHU2uh6dpwe7HVFn3fL7qIVWKjlbej3Nn7Zw63IibylmGw9AKKxQ/J+pnmfoj6syGCUsgTHwFu591YPgUXQRv5kfgmyE9IFEGf0Nsbc1DLNuFlS725iyoDGfhy5m4xhiVzV/hi0jHrMVTZAsjspaOUBwBaRhWz7cCFbm+b93gr20NQU9aVV7FT4+Xp7dBUP9tQZKhc/uBwQ4c5EeexbE81B0PaR54/gM0tw9uqW4LC0ioJMcn7bKfi04OsQ2APpbmrPXtH24r/r4YBip3E230W8TIfwV0QJr5decD0SnWTBpTT6UT3hYWAI3yuYOSA0dWB1DherAKpgtBSODw4yTXbwdpOQFxZlb/0Q6Fi8zc3GgYUWs9mX2wtEwOvnUwqnnWxqk7Ndx/3TSt9f0cUwC+Z0bNx/2F2ShDJ/nGmKy54xiEP0V6Ns5/DPHjsUdIXP2i7dxhAYq9PkgMY1o30draZTeZbasr67IOD/v/mWkimQMAejG+lvtjsjdijgE
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB47603699F5887650A59B3595C6040@BYAPR02MB4760.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR02MB4760;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4760;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;4:IHPFKa1Ep3Df4m7rjbQgyCg+l5RuUsqhc3397soRqyDv2G+LLYbExy5AQ3C6HRU8rJx4Kk3JyWP2mkz36uFQ3IiRrxxUpDcQoJbTN/9IEhaw193lit+Wtdp/1kXhAZeZXocL0QQwk/Ph1kNlbNHioWvjvIAMJmuoBFPhBPnmaSa/363V8ZCy614HrNv1TLQUR9q5TExXlm/IITE66N3RTjVVbRea20Ti9cZVpvHclv1kn75BdQWxooC53aiSwJDxBexcZV1/HBwWYwSOkUsAhCFJJEf0VSVBousHJvPiqKzEaP1rwJhX2nkmTwAXRAxo
X-Forefront-PRVS: 0792DBEAD0
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjAyTUI0NzYwOzIzOjE0azBxRTBQZXkyajhDZ3dBN1ZyV25mTUFq?=
 =?utf-8?B?enhqY1p6OERVak4yT1Npekc0Mnd5QzR4UTZHcDhHSGVRWFNoZVdwTTVKVEpo?=
 =?utf-8?B?UzZGUWZ1aXFjNjBnSGlBNWZXbEF6UTFLR0ZmQXd4T1hwdENYcTJpTXVIL0RZ?=
 =?utf-8?B?Mk1DL0crRGZqcTFxNlJ1a3hjZGNmRkhNTEFYMWYrRjgzU24vQmYzM1YzVnI4?=
 =?utf-8?B?QW8yZlcxNXNRTmUxcDV6NmNzYnNEZWw0Wk9kVG4xY3JYdm9ycUFXKzlqQndN?=
 =?utf-8?B?Y1JvUkpVaDluYXc5R1kyN3VtVXlqd3VhWnFzY2tUZEZSMEtQS3BONnFhekJU?=
 =?utf-8?B?M2hjVTMyOTJvUUxqdW5yQlIxbVQ1a1JqaFQ5MTlXaENQZi9MVVpsb2JNTXFQ?=
 =?utf-8?B?RTlMT2oxbys3a3FGMUkyY0E3R0NLRzNEMkU2cS8yT1BNNXI3MEcwRVcwbUtF?=
 =?utf-8?B?cG42WDZ3aWNvNnRFbW5tYklxMTJzVTRqQURBMHlXVE5UL3RjZSs1WTdtOG92?=
 =?utf-8?B?SFBJY1d5YVpBQkgxd0hlS2hZcThsS2hIcWhFcFZRekNYQ0xlT1FLUVh1MTRw?=
 =?utf-8?B?UUhFWHM1SllFU3VKYVg2ZzFYeDRBZ284VGYyOGN4MWdhS25aRkNwLzNuS2pq?=
 =?utf-8?B?Wlhaa0ZEVU94U3liQ0JXMWRVOVdQdHBtQnBETWNRaVVwQWY5QTR4K0twQzJB?=
 =?utf-8?B?TVF5NkxCUVBTeFIzSVZSYXFrOW1ZMWFDempkOTFyMDR2aFZxdnJDWkk0bzF2?=
 =?utf-8?B?Sk9VRTFZNHViRS9ZMnlOYWlkdC9NZUFkeVRIT2RnSjFUWXkrK1NkK05HeURG?=
 =?utf-8?B?VWhpdVAxdURjUHorRVJObDQxcnNoTmw3c3phMTYxdGQ1NEhrTXZQN2VOY1JR?=
 =?utf-8?B?SHd6MzhuN25Qc09pNXNrMTh4NWE3ZHFLd1JkVVpjNU5VbWl1TWZObC9hT3ZB?=
 =?utf-8?B?UEJMSWUvSUl3VjBHb01nZzlpY0tMRTkvdEMzNnMxVHpTS255VExuU0ZDd0Fp?=
 =?utf-8?B?dFpwZW5Xbyt4N05hTDgySWpaN0ZNT2l3emZxOExIUDR4N1pJN0RTcm90WGVR?=
 =?utf-8?B?ZXJqUnZEVGNSUFlRdGFld1p0WklYandwellPV0ZJZDgzQ1dIQ0g1NlNXZjNE?=
 =?utf-8?B?Y3lKcXpNbVdkNWExRWczM2tVWVlINWZlVnE5RFAyRTJ1clhXeU1Za2ROZGVW?=
 =?utf-8?B?TTAyc1R0Kys4MVY2ekRUU2lwSGNyWTgxRzlXTWtBUVp3QVBxWmRDekNENDZJ?=
 =?utf-8?B?S2FIYlZVUXAxcXQ4c0RydXNDVnlPcXpQaGwzS0gxSXlHMmNHWW1xeC84eGc1?=
 =?utf-8?B?QzJCOG56blM0eVhBaUlDT3lZRm5nbzlHbWVtbUlTS082YkljUnM0RjFoRitH?=
 =?utf-8?B?RlV1ckovTUw4Qk01bk5Odk03RXBmNXE0OUdsaDIvclpBZ3ZiUlErRWtTSmM1?=
 =?utf-8?B?bDVFcER1SUF3aVcxSG51TDRIeXJHTUFRanRGaVhZdTRMcGRUY2NLL1RFc1BD?=
 =?utf-8?B?MjFGdnQrUC94cC82Wk5RVFlNMm1YbmJlRlIwdEw1T25EUFkyWEFPRWlFVllV?=
 =?utf-8?B?bW5JMnl5VVV1VGlvNTJRWlgzYk5QcnVOMlczelY5dWFmSy83ZjdrOWsyWHRa?=
 =?utf-8?B?d0dqUlZQUWxLR2szUmQ1VjIxU0JJd2lDRkFkQTBidFFsQmxxdGVUUTZwMDlK?=
 =?utf-8?Q?66k2OW+MnVhKlNI2rSVgKWX+TJ7rTCBAJHpt+FR?=
X-Microsoft-Antispam-Message-Info: 0rzBwT3vw00w9T2ZFUr/9obB/ZUD69TZyIEXiI684rb9iQR6FIMq4n4GGZhshG5e4jxDYN5s1/FwVUSjfUAX5wit14Z27bwPTP+5c8qLrNHpbZZv4omoTe9RyVW72jJHKZSzBa7KFhsdYbsPMCG3fWaYxJ52jK3t28ctbgWoqp6Iwf4bzHlwFCkgXZPkTkWPowhIruP9yq1ikm3Y6EhcOx69wDD4ddSqI6jYw3mRyPBWhpUkUfMAgIxw1Pic86oQ5MpqBZ0ymR5hZ41tt5ZQRlAd1zJ7j4KW1arAELb/0yQ1KO6nwCpttQDOoamViOVOPmZ4wxUQSZiJ129dU8fN9/FKSzktDLYB9IZRk64atQQ=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4760;6:rKjD6P6Ja0pAkJZwRc5QbPCeHG58yc5c5GfPRdbNI+yFyejv7kEaDhhBWVGj4JAQisNO9vH0um6IJLfrVzWNA0+Ftx3GdWSPaRJSGash/DbH6EQnQP2kXAuFXtTOCvDlrJKXBoIC6ee4RDAMIfXUDoyON6BoZWGkAsm6jOlEx9OMaO+aHYcRt00UCoTaSTC2gvYcfKTVO+DfuaFdwsaZQo3KvAcp1tkGQf9XToUIZeSZWczMO9OIah/0tP+qabpPgx4/No5uaR4VylCKcpBlaZ6AuVarEG7jZXt7yhLtkq2JPs8m9qwbYx4qKm42Alr7JyKspT/Rh0/uCgTB/EYdzufzd6hNZA4o/pdSRGH6ktKvk3P8csgOJQRWpm4PIGBuM1fIS2LsvS9DMA2U8ptfjVm7S0fh36tfLKmNCjcx835GplrEBcc2FbBZeG90ccEQTlJ01SXrhCX6s5NaaRpjYQ==;5:z883iQj31TKsls/ojNqiMlOgQNiclN+WHZQqG2/IfByGj5J9vK0tejfFb7hCjsK8fec8iEuClyRHTJlcYICOgCf6Sj4iscw2lcxFrmaSGvyVofaReUDvOLS6aCT7L0BZxO103PIZwmuaFETVgDfL7FK4IejcRnKb5SXD+og488U=;7:8hmplL5PTmyWgFhneQJHeEOlVPFR9EZNmFMVHFAAAYIz8JHDniZQridMfLkhONQeAbWogUAc0SgESIaADqyjyxgYUYxBQaJe9uxzRFm17m5AEXQl7u8toqmyN5qhBu+cx7kawHZB76L8tH9M9R4Ac3g4JDYSlqs/W2ny8StVg7VkHoWtOXnelqd06GPRBDXuDZzYFQopy/vp5dqdvBunK+vu2ZJybrxvcIqwWbuTVr09Ik3lnDkIP7lvjk6g1GnT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2018 12:15:53.3092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fee87c8-6f31-46e8-f204-08d617e051fe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.9.2018 22:49, Rob Herring wrote:
> On Mon, Sep 10, 2018 at 9:56 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> On 5.9.2018 21:37, Rob Herring wrote:
>>> "device_type" use is deprecated for FDT though it has continued to be used
>>> for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
>>> node names by default. This will allow the eventually removal of cpu
>>> device_type properties.
>>>
>>> Also, fix a leaked reference by adding a missing of_node_put.
>>>
>>> Cc: Michal Simek <monstr@monstr.eu>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>> Please ack and I will take via the DT tree. This is dependent on the
>>> first 2 patches.
>>
>> I have tested it and it is align with the spec and all dtses generated
>> before 2015 will work without any issue.
>> In 2015 new device tree generator was introduced and it is not adding
>> reg property to cpu node which is required by this change.
>> This will be fixed but that means that all generated dtses from 2015 are
>> affected.
> 
> Patch 2 was supposed to handle that case. However, it does expect that
> there should be an #address-cells equal to 0 in that case. Is that not
> a valid assumption?

as you can expect we have

#address-cells = <0x1>;
#cpus = <0x1>;
#size-cells = <0x0>;
cpu@0 {
	/* no reg property */
};

That missing reg property was even reported by dtc but none has fixed
that. This will be fixed for xilinx releases.


>> That's why will be great if you can also change that pr_err message to
>> mentioned to also check reg property to give users a chance to fix it
>> properly. Error log below.
> 
> I don't think breaking users is good.
> 
> I could make this a find by path (/cpus/cpu) instead or just drop it
> for microblaze. It doesn't really affect my plans for removing
> device_node.type ptr.

If this is fine for you that will be the best solution.

Thanks,
Michal
