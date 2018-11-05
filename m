Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BDEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5512085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5fWumbrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5512085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbeKEXFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:05:21 -0500
Received: from mail-eopbgr710049.outbound.protection.outlook.com ([40.107.71.49]:33628
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727390AbeKEXFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nFSuuAB8Qwv4bgVyX1e8rmylkLNzK7Xd3GI67Vytn0=;
 b=5fWumbrZEY43sSBkZO2kOElTVPNFxn0eCagMbb1BIXAElBUMS4Ft5zHZeliJBfZKUrAmxzRWSXGGwbfjvvyNwNRMqNRo1iWy7Q/CV957OdWlYwHJff1BzEBkfK9aubSneB0zKaZIuceYBzGa5MutRlcUDpEMNKcuXe6QoXmAi2M=
Received: from MWHPR0201CA0073.namprd02.prod.outlook.com
 (2603:10b6:301:75::14) by DM5PR0201MB3510.namprd02.prod.outlook.com
 (2603:10b6:4:77::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.21; Mon, 5 Nov
 2018 13:45:29 +0000
Received: from CY1NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR0201CA0073.outlook.office365.com
 (2603:10b6:301:75::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.20 via Frontend
 Transport; Mon, 5 Nov 2018 13:45:28 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT034.mail.protection.outlook.com (10.152.75.190) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Mon, 5 Nov 2018 13:45:26 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:55522 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJfC2-0007br-D6; Mon, 05 Nov 2018 05:45:26 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gJfBx-0003P4-7p; Mon, 05 Nov 2018 05:45:21 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA5DjIis012631;
        Mon, 5 Nov 2018 05:45:18 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gJfBu-0003Mo-Dk; Mon, 05 Nov 2018 05:45:18 -0800
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
 <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <cab338b6-e4d6-0436-6eb8-cbd6c33115f2@xilinx.com>
Date:   Mon, 5 Nov 2018 14:45:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105134218.GD7937@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(8936002)(77096007)(26005)(36386004)(4326008)(2906002)(126002)(186003)(76176011)(50466002)(23676004)(2486003)(6346003)(478600001)(63266004)(93886005)(316002)(58126008)(54906003)(31686004)(106466001)(6246003)(110136005)(106002)(486006)(81166006)(81156014)(8676002)(230700001)(229853002)(9786002)(7416002)(44832011)(476003)(11346002)(446003)(336012)(64126003)(426003)(31696002)(36756003)(6666004)(65806001)(356004)(305945005)(47776003)(2616005)(65956001)(5660300001)(65826007)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3510;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT034;1:T4KzBwrDneggJ0G0tgv8SwCQPAtabg5e8LIKgVLFrATeGVUJ/b9tt3IZW0Rt+E8P1gKk+mOhjNBADn3CnVw9iS2LK5qGy6ju+gPDEQzyIj8VzX/QuabBChuQuPUgAB2D
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01dc627d-ba71-4944-6683-08d64324f1f5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;3:bkS64+U+HSRXCFXcFeynSDG0bXDvHutGaVYUyMfu4rzkhe38oDKMaJo8JldthcUH1gVAKLgS/aG3YcjEMJfxU86+RWERhNofVliRLOTqIRu3JNtYn4KrP04aroyAQNhxOXpb/XHIQ1EIEfmu7XtrYHS25RqCalYKY40OBfK6nXc4YKxIRn+aTY9cQguV3/19y59/2knuw8l7KklGCq2/928JWNKxtLx716V7+/qmlFHUn/cVSQxx2l4aOwKJGB6xj7SmYNgQ9vniUu4jXvyin+eDJgaVQtb5rMwbFINIqkBA8e+/sWIZcPu+WQh/PdOMF9U4Chq7wEue9ztzH+cQYhN2UjWBK8peUmg/Ros+8ms=;25:tMqvP+aGLuaQkYbC1ME2FSxZMDjwpI2CIB2nezwjjeTwiKnkyek+Oxb3MzWRtCwSWbUlqs/OspuJbKvI7dNSGlapjF9PlkCQLgunWWSj9NCdMkEciSR5zq+zjQXscw/vNiCyeMdm1SgZBo1oHDBKMgsUjX43FZ53oRxHPDhB8HQrgG4gGnhmmRsJwr5e4GyKJZrtcmIUbdRwyC80kT54ETiFu13fMmHzsRS1rRbuEUpmgJGhe/l3Hmvmhm6THK4Q8dBV1w2FEbFSmMSMIPnUnw5IyQ00Whfogd0ITTfMx7c3pMxlcwVEdOVbRlgLK2BQpwEFof/dZvlf2hA7iSu/Iw==
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3510:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;31:pFvZqvucyjC2bJZCEwnha5oTDeEDr0Amlt4njM8cN4abxjgDu4sXH5IdYWfLWtZv4Jvrgv6I6LiCxdhanS/uuWwwU3xsIXKS8JY1mvXdwacuyTfQhxBUB+B90MamQAKAVkfjEr+FJbkB/CJYPpy8LhxYlDxAGrJsE58RoAoeJQQP6c5rpLbsJogCfRvLIh+l5J9plzqUPZ/tuyp9SCDu4VeSpzuXrm8h2VJUkvV1veg=;20:5BtdSWWXObslzNkk66NEBqa9Ia24+gTLsNAfaqjEEAcdYjQZzM/u50LfQcAK/iubDP4hbLNJ7IVLQ8JHUNcrMpvh68PZR5Vy/gMvRwMkJ8Ruz+xZoq88huryFt4Su1j8dTAuPPYVlYKWCBq7CDGnRz48xDyjJwm3SIeQgBRrFPMkWwiA6NXZ15C6jsBy68RThbxi50jC5xc/mJUnGL4r0EeQF/P3iguiz8zYOHPGY/le7+5ieYWDFVdgs4dYNFFqAkZffPCqXtQ/CP4VGpi2GAJ1PZEoN9Ao8aOM4/JU4j2X3SSFpu90y7snh6MUmxzG+PhM/MsNQzpgsh96TDZOBSonzA49bs0BU3jEP4ex7zxIn7dYAKMa8Q4vWsnTkD6sXV1ajlVtHG+4rDXqO+p4bRm5Bg3gKeAP9kKRhYYww92btq//3yhMt81S+RVT0CyTguHZh39jDYkmvlPpcUA3j1bllpdpTJZNFIQHJ3c9p8cnRhaf1Rq8rmOzzBuNo52Y
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR0201MB35103B354702056D57881B17C6CA0@DM5PR0201MB3510.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR0201MB3510;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0201MB3510;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;4:C+zd0d9FmrFc56uJqcvPHfr9fjE/oTArJNHLH8sAj35rkKRYFiMD6qgWqGSFhGid3vGSdhb3VHlr9kAafHk1nsFk9MsUjFq0i9wuBCRMXEwP991laVM1zy06cuS+aXEMu4mI0Yb+gxBFofeiOlvKrbjdoYhs6FFgmw75cv/y3MJ/OLCaD44cF4DaZKv9PvndA/dZmNOq2GdukaLsH7vJqZNV1tE0v8XG+MCsYzZt3DZKP7NjtHFdxnMmK6Fje7N7NxI8qxBRbe7SZGu9kEMMQQ==
X-Forefront-PRVS: 08476BC6EF
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjAyMDFNQjM1MTA7MjM6YmQ4MFVFeXNNMDR6cnBiZituUWJ4ZXg3?=
 =?utf-8?B?bFY2ZkhFamROYjhPdXprenkxOEtwc2hZV3JETnVCeEVjcW5FTk4rUkxtOCtK?=
 =?utf-8?B?czBxczZnYXVOVk9jRFZ6Z0FmQXh5VWZCWkN5MHR3MW5ZZE9kenBWNlJCdWkr?=
 =?utf-8?B?K01ZTlhjcktYVEp0T3gxTkRvT0FJaS83V2hkSGtsam1ReDZBTFBEY05vOW5P?=
 =?utf-8?B?WGN2SWdqUGpKaFEwWFlDVXdmS3ZUaStsd1VYT3dOWXJBQlhoK2NjL1VrRXJr?=
 =?utf-8?B?RjByR05FNkZaQXl5TS9CTEpQcDNrQ0tUNFA4UGcwdWd4bGlFbnNlVXlCcFFC?=
 =?utf-8?B?T25acmF3VElUeFM1Z05rQnBZZEVpNndFQVBEdDE3V0psUFNQUFdSYVlsR2hj?=
 =?utf-8?B?enlTOHdUejdDRFZYblhLWldvODlZYmZ1OTBBbzMwY0FubnMrV0FNcGtHV2tN?=
 =?utf-8?B?OGZhektqWHh1c2YvRDBRMUhuSGNXZ3d0MFFFWTdPSE9INHBGbTZPdkdFc0VG?=
 =?utf-8?B?dVo3NEJrZEY5T08zSVlFWEJYNEIxWWJnMjRLVTNrd0FxUHhUZFMwVGd4Zzdy?=
 =?utf-8?B?azdzVUh6aHgxbDg5NG9wMXR6TmwyR3g0dnNoMVU2UWVQMmgrejJxTm4zd0tO?=
 =?utf-8?B?YTFoeWtOejB6aVM5UEE5QUtiSUxCUzc5UWFnV2YwbzNSaWxGdWUzMHp5QUQr?=
 =?utf-8?B?ZHFPL1lvdEdMS21WNGxGY3ZPZmNkd3ZUQmhuUjVsays4MDhyb1QrRSs2aE1L?=
 =?utf-8?B?Y25lVmlpSkhKcVllYXAraFdYZXZaaU1zcytTcTNkUkwrNDdnbGtQaFJKVEdz?=
 =?utf-8?B?T0RqcTRzWjUwSVI2QTZrUENaaCs5MVNkVnYyZVZ6bjlkNmt2V01pRzJFcjJP?=
 =?utf-8?B?akZxYkFlR1BDVXNMY29IWGFwSU93WFYxTGNBU0I4aTF2UG9qL3ZuSm9lckRR?=
 =?utf-8?B?MktqRjY1alVNMGZiT2pNVGZvdWFkRldGWTlRTmNGQ1hzV1Q4a1RoZThlVVoz?=
 =?utf-8?B?eDl1TWNXZjBqbzJFTFhIRmUzR29zQjVpQzN3S3JYaE4yd21pa0xzR1VGcnFh?=
 =?utf-8?B?aXUzWnlCSkRVWjZjY3Y2NzJWUDNlaFdCR3dBMUNJbnZSYzFQdU5WbkE2aFJo?=
 =?utf-8?B?NVlETk8ydU5qT2JDS2h4R1B1dy9kSVBja1BsNXhZZ09hWjFKOXhRVjdKM0NN?=
 =?utf-8?B?YTN2QlpmRTFWSkttS3dMT0VLZjJzV2VLajZJYnZtYVhGVHdCN3liRmlpcVhO?=
 =?utf-8?B?VWJndEJJNytQeng2UXBtcXNOeWdNaGltd1BxR0wrMXloMGp0K0dLeEdDZFFF?=
 =?utf-8?B?d3hrSFFwdGczWWxEcll4NVpkN2JaZjVUVzZDd3lQSFRSYkdqZnZtbXBjSUtq?=
 =?utf-8?B?MEZEcG5nR3Bha1dZYlJTNVdNME8yRzc1aUpnV21sZE10WTE1V3BpaFZoY1Mv?=
 =?utf-8?B?N2lCL1BDSGRISWx1ekVNSjRnVjJTWEtIZVE1WWpLNTQ5THRCSU02WmFINS9U?=
 =?utf-8?B?b2t5elBITHpJRTFvbGRrckI2TXRINy8xaS9jcEE5eS80dUxpVGMwd2ZCQnBk?=
 =?utf-8?B?NlJSMzF1QnZzdW41TzhNcEZiZUJZbC93K2U0TENvemFoeHFBRmcxejZuREFm?=
 =?utf-8?B?V2ppb0RxNnVjcUNMa0E4NGVvMzk3K0tuT2VvS0xTSTljZGhxeUhjaVNTaGU4?=
 =?utf-8?B?bjlLbFdjQUwzREtFNEMzdDJZRGRoaU9HSnlsT1JBTW5IamY4ajE1Ukh3N1oz?=
 =?utf-8?B?K00wclNmTVN0UDk5bXR2ZXVaeVE3YkVNb2F5bllwQUxoRVFvN3cyTDhaOWlo?=
 =?utf-8?B?NlRGNHV0Qm9BMk5IWUhSa1JGTXQ1a3c4dU1QZk5pZTNlNXpTdz09?=
X-Microsoft-Antispam-Message-Info: UKc3CkIBShNjq+CzhWXvmy1GBiYQ3dDmYsbUuJwgZU2nblXdH0Jn89ou3krezmY7V+9FUZSLyJexUbG5bFeoe9K4QmvCjyx3mKOJSuxB7xDRSP+3ddToAmI9V8+SL5M2he/YzQlsAA3g1TUhdrAzLon2Ld0KzpyXDElzy7Jcm9uMkN5AXGRVleGqHnRo/IaksrV+JIeMJ4y/SA3ACeoq2aLvkvJGi6THm43TmGQtjGUm3MpGBAOZYcau2kbYjSZwFho58DbMJtN6yzbd24b8HlB2qf+EvPtCxlZU/jSX23mBZ5srkzkMINDRj9aRXBPwK43CCBIg6n5UGVhy8a6dmzf7n4xAb4XCHpsGqZ1VrXA=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0201MB3510;6:TKnj8HwEzDhSSAXU/geYXJ5nojYxiuLCk+8vXe86E13RVbWWpzp1cwB9nBKWkaNk5zGXlaBriNOfAuwX86jdcuTTCgsCD5cXJOqD+qJH0an4Z7kM8+4OlWe10uU3OoUq+uqrtiNL/7Hk4GaqO6Bdw6Tk6FgkY6wjP+GOZ+WlE/3JOkO0F5jqqdeZyrpVpWpIJcF/V8HPTO0WTXo9nAYc2z+uklkVfAQE9uBFPVm1/FseuJiYidn+USHxKEs4c9wB9uwuIo7U8WI/3aKe8sjr+5wyvMmnb1ZfhGCc8WFpODAQ1lNIXiljeP8ZAgXVMHR1m7AK8gLj0OmhRTDlBFmFpZ6VPiBm+gZrHq5kJ0S6WX4n1yCZn2q0phsWxsRjRtvt4eBuGcK1gLm9er5uLV1zBrnqQe+UPRI1xKqps6MKIxxNjcRwvPNaX4YHHatS0QlhLbFgj0BIQv7cQzAxl/yQ2g==;5:PpkmNxY9xF4Wup7osozzAUZCBHn1/4c01HffZc4tue/ytilCJPo0mpjLrlp/hS0pM+kJo7VlJTeWF0/GV7EvkIQyGgPYxktNiQj5eYEmiG75sgkP+brhmxnHledTgINIurokIbSWnasZzZ+NhpMDGARah0zQ7RchbjPWN9JtyIw=;7:CSHGgP9hpH79P7lEcbZ8nES5bKQ/g+9xX2M+5BG/eqKsMN6s8uds0lxupi1Zo8K4Ipl3uI5NNyrwZozlahBB1OMThBRIWpD8tHTS6dqb2I8Od3L8vilqvLTWRv4M/DgpZWThzmDMUZfrF7R9ORnQFg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2018 13:45:26.9279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01dc627d-ba71-4944-6683-08d64324f1f5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 18 14:42, Borislav Petkov wrote:
> On Mon, Nov 05, 2018 at 02:32:55PM +0100, Michal Simek wrote:
>> you don't have that HW anyway.
> 
> Grrr, I'm not talking about me - I'm talking about people testing
> linux-next. And perhaps in this particular case it won't matter because
> this hw is not shipping yet or whatever but the question is about the
> principle of the whole thing.
>
>> I looked at v10 and I can't see your ack there. Can you please give me
>> a link?
> 
> I'm talking about *other* patches for another driver.
> 
> Please note that I'm replying to this thread as an example - the
> procedural question I have is not only related to the synopsys changes
> but the synopsys changes are a good example for the problem of EDAC
> changes being sent to me along with DT additions.
> 
> As such, the question was aimed more at arm-soc people - that's why they
> were in To: - not at you.

ok. Got it.

M
