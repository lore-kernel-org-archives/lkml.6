Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30554C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42AA21582
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="FHAXi+hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42AA21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeKLRuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:50:08 -0500
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:21632
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727357AbeKLRuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzNY4WQ9X6DnF++rcHLqIbLYhqQq3KuVjkf8XiVQ3Ew=;
 b=FHAXi+huDOgFy8FwXirnNPQB01e3VJdEhSbom0L99/134D1W0gxohf7aF0bl/jqQqrJDpfMHMNI1sXozT3/UYG26fVZ0LQOTG2MQkqKC7xu6x7DasmZ4SAQc6M69QN2UUUmccArJw5y2erhT6RF1k/Tvk7DrbHsS6AIb/9klCB8=
Received: from BN3PR03CA0112.namprd03.prod.outlook.com (2603:10b6:400:4::30)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.26; Mon, 12 Nov
 2018 07:58:00 +0000
Received: from BN1BFFO11FD016.protection.gbl (2a01:111:f400:7c10::1:143) by
 BN3PR03CA0112.outlook.office365.com (2603:10b6:400:4::30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.21 via Frontend Transport; Mon, 12 Nov 2018 07:58:00 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BN1BFFO11FD016.mail.protection.outlook.com (10.58.144.79) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1339.12
 via Frontend Transport; Mon, 12 Nov 2018 07:58:00 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id wAC7vxR2008071
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 11 Nov 2018 23:57:59 -0800
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0301.000; Mon, 12 Nov 2018 02:57:59 -0500
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: check if ad778x before
 gain update
Thread-Topic: [PATCH v2 1/2] staging: iio: ad7780: check if ad778x before
 gain update
Thread-Index: AQHUd2NzGRRwV0ksHkKUb3k2/dEO6aVGN1OAgASqV4CAAT45gA==
Date:   Mon, 12 Nov 2018 07:57:58 +0000
Message-ID: <d606520397eaf3b57372fa2fffc6f17b567eee61.camel@analog.com>
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
         <762e851dd819f27e3955cb695cd8422d84a19438.1541681371.git.giuliano.belinassi@usp.br>
         <77c3b6ee484b077152138cb8e1b7e03295114e54.camel@analog.com>
         <20181111125859.7263bc15@archlinux>
In-Reply-To: <20181111125859.7263bc15@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.244]
x-adiroutedonprem: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <30751E4C442CD141831FEC75680C94EA@analog.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(2980300002)(438002)(199004)(189003)(7736002)(305945005)(7636002)(39060400002)(356004)(47776003)(4326008)(426003)(2900100001)(486006)(436003)(446003)(6246003)(6916009)(76176011)(106466001)(26005)(118296001)(36756003)(14454004)(8676002)(102836004)(2351001)(2486003)(23676004)(478600001)(7696005)(246002)(3846002)(86362001)(2501003)(8936002)(6116002)(4001150100001)(106002)(336012)(54906003)(316002)(93886005)(186003)(5660300001)(476003)(126002)(2906002)(2616005)(229853002)(5640700003)(11346002)(7416002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD016;1:WuGaJ09dUj+b9tYd20secbKzP29zNwfLCVH+Pg1G4DB7LxYjf1HxJjyQ9gq4qv6i/Yb2XDlo6ZnXgd4cB5OlBkNuaoqoOi5dpklgvxu7ZN1THn9v3CgGNiU4WdVfgCHV
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d76d7cda-68ea-4c71-1445-08d6487490d0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;3:Rs4Ry1bRMS+0d7+3XpRy8euQNdmNERVKRwAyoOtDVIO41kyhBKeiiBf3db1QWDFmVmNqS8YougyO367ZeLLl0+ozyGGq4FmS08x/XzxhB3gMU39NyGJ8l5G0aySY90qkJ4l5gDoeLdgNLx9gXJ4AwwF78ImnowuQk063o3l2E1uVLUh34k5VkPzr0LOEsiJIpbbVVITKuzmRTvnF1iqqT+6H1giXDMQyoiUL33ssgy2CARo418Jt5vRYb7Wzwy4S4ObVHF35g5QQCvukpy64RMDxEhSJMMafpvB1ezR70rE9qQAK1gh+xvRFbqvGPKuxgwMX33H40EkzVWCfH5D6BRet0RNohgFwXDQNpABLIn8=;25:pPsW6cm1P+uHD3N5or7CLRv2A7oeJ45YL5kyLRGbiUta85mDcRRu3ZepbjsEa3AxIMvIR9q3qijxgsPH8wnIM1jjnOFDVCotO5nPNVxqAOzfBHjZSVuORUNSTO7PWA4n2thr8mIRl8P78Q/g3G7KxQEmea717vt7FnFVMgFmwDeba/bXo+Yp2PNlLr3VPmTERTkcfVU9EzR5wJ292BbwPeLcgdooRi5AIeO+2vWQbgil1JLg/qLip0qHtIDiKk1XpBrDX+J1ZvUGnloyd9xeBpTaQLrMxaNTbvhWXTPrc2LXghtA1eifQmUS0BwOcAdaXs5BdydqvPH14SPWln8Vm+653aSPXsvi08ViyMH9SvA=
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;31:dqp0sc/2vaDZHMCkdRzvtx3CGN9ZejHa3UO8JzKknOtXysiq9M+CJwBpVtntwd1vqRtFKLZ23BmdVzUI9iiFvA6wke31RL4rdotKvPXZ/klBBkHBXQlKvsqpaFD9fD5lOwfkD2lEAo7pMm7tlhdhkyX6K6LFrA6zBLTzARt4jqL7/mRr8+K07cjgQzeXQCOKZ3qr22+mJUJMtZkuGkfzGTkjOoQPaY2tCXj+SX7VyAY=;20:n5LQoPIv7Z0LGRs3krFS0aUVxnl1b1ZkTI+OdJF6Tzeo8hcJbrPjcbbZ8nOCUY7BQMXFt4Te6NXI+pwpB5EekwqhPZe++U2/Ip06UgHNR6iftIzzGSUJ5ouloYnKrop3XheivFNsc+qklYzOm37ht0r8dZw31w6iw9H6N+fFuaKF20pNOsvbgPeyZkStHmeviXhmb4csCaBeXFEcr6YFXSeI6tAm+UzQPlu0yPZqPdnQSnSxH0tUybQld2kLpLSw4Pjt/D3N2DSIbY7k9qJy2rYRavtwjVlCZ+YhLZ6n+RRkqcsZ52S8yS8SYErEpTj8XetrvnlNYGXYPRtC8piQb7IjBQI40eWffU8XZwgijz+6QEmmnn/J+s5CK5oTgAdJvoO42N1M6wlzuLbYiI2YHnCPOOlkcYB5Nm6oO6n++//hwJRIXgxxNgYcjvDE8Nq9j34edtlXbIIuNAfPIWbyMm4bMASROYQVMD5zNGq77IWjkMe+4lcSW2gwXMROB2wN
X-Microsoft-Antispam-PRVS: <BL2PR03MB54510728FEE3552393690ECF9C10@BL2PR03MB545.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231402)(944501410)(52105112)(93006095)(93004095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL2PR03MB545;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;4:d9Zw9grJcAsC7WY4x2BJ/1IExOzWquPQFjA7+gBok/rYPDHL/IC8kFAUdgLL2g7X8l5JLjHs/hXhDCH0jF0KjnlzADtG/zS1GfioQa9t9IliF8Ysi6AIR2lx167I1YKZWlwUCQmkXxaufYC4TurIov7qNy1kVVNRmH/3/68UOWJCdqSCGhxqF/a1JQ/gZPCebReDxebBDweL0G+/AQ3hbF7eFx1A4xPHY7aYNIzpTeF1sRaVye0VB+Qm6QYdVkb8miqOOCIl/K/gzikWaILt9nFLMKOl82mcm8ylSU9EHltRV3JAcSXg/gj2t+hO1tgT
X-Forefront-PRVS: 0854128AF0
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDU7MjM6andhZG5Bd3h3Sld3S0Z4UHJVUVdaZExEY0J3?=
 =?utf-8?B?eXNiR0ZWSHVYTW9mN1NPTkV3YmFhY251NkNiQ2lIMUxyd3YrUU5sa0ZvQlFZ?=
 =?utf-8?B?cXYvOGxYMVQzRldJVGtRV2F2UXB0OC8zWVZsTlRmTWE1MzV2ZGY4ZFdjWkZ5?=
 =?utf-8?B?eTNNV3dhZElzbzRoUFZjUEYzcXZJdkJsdkNMTGF5ZzNDOGVJWno4TncwWVRi?=
 =?utf-8?B?eEEwNVRDeVZrVnRqd0hxVFBNZ3o5ZW9JK3JuaFFoK3RBN0hncy9MaVVNbXVO?=
 =?utf-8?B?OHVWcm5DTGp5eno3Z0JKNGxzQytsbWlGZGFKRmdXWE5iU0VZd2JFbGIwZ084?=
 =?utf-8?B?SW1CQW1kaHFyQm5aeTE1dTNIT3MyZE1zNUJDdVEwbWVBbHMwQzErYS9mNzJm?=
 =?utf-8?B?eXg3SmJUZkxEZmE5TjlEZi83cG5CQ0VZc3AxVFp6eCtqZEYwRnJ4UlZpd3Rh?=
 =?utf-8?B?eGdUVXBtRHBCUDc3VmVVYjVYOG1QYW9ITmhTRFpTdG5uRmhmVGdLc294LzVC?=
 =?utf-8?B?L1QwblpTdFdJRXl4LzRqYlVxcThMMGJlLzdYOGVha3Bua2hEdHRsRStRNVpO?=
 =?utf-8?B?TmtzWWx0Vmp5cmNxY05NN1VWVmpYZzYxNUh5U3BERVcveHhMMmQ5eWhaVVVz?=
 =?utf-8?B?VTYrSHFWdGNIUnpERFVoWHNmSDZUYXlJeUs2NEEyR0FuSGNwTWdJbHNjN3oz?=
 =?utf-8?B?K0RTK2NTdWpGMUd3YkllNEZIYmxFaS9saGU2UGYrd2VVc2U2eVk0QU03bzdv?=
 =?utf-8?B?RnlDNXYvR2gyTmQ0T3FWdElCWnMydSs1ZmlzWDVBSEpYUmJUZEZOeEVTZ3d1?=
 =?utf-8?B?ZEJhcEpxK09DblJ5bTd2YlFpNWJLU0xJNU9WSC9rSVgvSjVPeTZHaHp2Mnda?=
 =?utf-8?B?TmZaQk5DOVdDYW5WbFRmRjVJZk5UaHBQeTlwUnhTZXJTTGIzbzQwVTlhNmJ5?=
 =?utf-8?B?NzBpYTZ5ZHRZZHAwVG9VcHV1dXJ1WWhCajljaWplOWFrWHM5TVkzZTFmdE9K?=
 =?utf-8?B?WVpldEpiVVpMcHhpWk5ONzVjdkw2RnNYKzRPUDlkQU1ycUp4SjNjTTBXa0gx?=
 =?utf-8?B?cWlhd21ZMXROdXhKSUNKMnpXd0JOZkhtUkxnQzcrOUYvV2MyN2hMY0NRTUhy?=
 =?utf-8?B?SHowbUFGTlc4SU9YYnNwVnpTQU1pWXlKakRoSG9YT21ublFKMVRxZFVjVjdx?=
 =?utf-8?B?Q1NiamJEeEVGTnE3NitONXJ5RFlyTUdoUXRaZkdlMjlEcE1YaFNQOTRGcHlI?=
 =?utf-8?B?NXdxdWlydC81Y1VneWE3bEJDQ2dzcm9FeERFRjZLZVczM2dNNFZPbmh2WlBK?=
 =?utf-8?B?UGVoVzNhQ281MUtTUS9lQ0x2SExXWEhGMzZEcTdBbWwvNWF0U1ZGb2d0R0Ra?=
 =?utf-8?B?KzcxeFZxcHVrc1dWN3FYVmxwd0JCdFpuL0oyS2JtV0t5eU1ReC9CekVZc00r?=
 =?utf-8?B?VXNvQ2ZPUDVPbEZQdUdHWlhhZkoydTN5NE9QRkNyRk43cUhHUktBeG5Ta2hv?=
 =?utf-8?B?NnZTdHVzdk5qS01jMml1ZW8xT3g0TzJiQ3gzaTFmbXlQQms2SzZsWmIwQWN2?=
 =?utf-8?B?Vy90ZW9tTldNSm14eVQrY045Ukk3OXFxWVkrQ25Sb3V3SEZCSDlmeXY1ZkJP?=
 =?utf-8?B?ZUJnRDRyZTQ0U0Z3K3hmWGYyaHpjazZVTk4zeWNOT29qdGx1elYxNmFSSGow?=
 =?utf-8?B?Y25PdEh0eElnT1U2ME4rUEJGcHF6VVlSMUxURkFvQTVGZXdjelpHUG5LZWNv?=
 =?utf-8?B?ak1za3JDVWdvbVJvb3pRPT0=?=
X-Microsoft-Antispam-Message-Info: UHoY0I3SNVCJNSNJreKSi2s2m7deyYD7rwBcvvgzTO8vv8JEzR4kVsfz82Bmu2kR/vKqrIintW66vqwasOMlQ9qfZ+BvATRbFlwR5QEk/F3FcRGPOgrHu4UXwx9lddGhxSPMTEEQS59AQOIL6Mm7siyqrTupts5GjHuRMasAlQrU7U/cOFfe368HwGZwlBQylWpHlUHxZhp1cb5UZ4ybRsdhc+kx1UC+Lg+8XgQJ3gJ/Hu/PIHXEndHYTqKzagYI2sohnS+CBF8LA0DXKbi6AwrR+/IIx5FdHqUKSUxp2zAbftQfVT9zxD9iP5KcZe4eJKiXiCaCgJPiRGVswrdKGiJ6AegUi4DesWTqcnUoHuA=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;6:ugkxCbS5TzFHCarsAy1T9hsvzj9hwQ2JKWlazuCiQf86+WS7AuaDAm4kZk+aTMR9KyKl6lm/7ZtI8vNCKiaoZZMcuyAd6Egu60OLeZeYgGykSxWqNdlN1IVRZoirCQVIjNnaYCEGNf99jqCF943mslpNJrI1t8cLHZupltzia11yJjk9AdQg2pCQZ65y1aXR4+x4E4q1PdsOS7au040+hCcMSyBEQRB54tfmcU+bZ5k4nXQWiLjApzWCYeoxonEhy6iokseRVHyaLHwleh1hkHt0PesViULY4E2D42W1pQ3XRrxN9XqUHa+WocgEHD61+4c7/ccLjxbBTOO2jA2UexyD4scKg1fhaNxB0xYS+n5pfP0RAV3/xPAIMdpxXYF5eEQcl3dWw7rTJydHVLEQXxR2D0NzP5DvaU5ELC5+XtjgXceKFmuQRSbQwuOatb5IrPZ/BaBVv4sjJVM8/e5yBg==;5:j95ZKhpqpKg5q6YwTSfaK+63nRvhhiIFoK9yMTKoxjw0mipQI0uEYYNsqgVYwbeVmJIT40iUhMhnTeotVuBEhXR1+bcNycV6jVGXZarMPSEdRQWiD4zTVJAp2JcihJnHS+KTiecx6Ui1BUTSoWYNmD1hajtzI0ELL6ZqryJabrk=;7:sbkDNf5W4D5AxAb265KTzKe6s+ScqAQXrwhrt+PjZpFqag/Zv3x0eWiYSM9hg9Q2Y5AY2n3lN8NlfHfi66NgCEBYpHgEyymM3rVOw0mT5QCL24GiucW0uHTkC6+kwgHOkndpYUWg3WAwOPahCnmzAg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2018 07:58:00.1059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76d7cda-68ea-4c71-1445-08d6487490d0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE4LTExLTExIGF0IDEyOjU4ICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBUaHUsIDggTm92IDIwMTggMTM6NDQ6MTcgKzAwMDANCj4gIkFyZGVsZWFuLCBBbGV4
YW5kcnUiIDxhbGV4YW5kcnUuQXJkZWxlYW5AYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9u
IFRodSwgMjAxOC0xMS0wOCBhdCAxMTowMyAtMDIwMCwgR2l1bGlhbm8gQmVsaW5hc3NpIHdyb3Rl
Og0KPiA+ID4gT25seSB0aGUgYWQ3Nzh4IGhhdmUgdGhlICdnYWluJyBzdGF0dXMgYml0LiBDaGVj
ayBpdCBiZWZvcmUgdXBkYXRpbmcNCj4gPiA+IHRocm91Z2ggYSBuZXcgdmFyaWFibGUgaXNfYWQ3
Nzh4IGluIGNoaXBfaW5mby4NCj4gPiA+ICAgDQo+ID4gDQo+ID4gTG9va3MgZ29vZC4NCj4gDQo+
IEFsZXgsIGZvcm1hbCB0YWdzIGRlZmluaXRlbHkgcHJlZmVycmVkISAgSXQncyBub3QgYXMgdGhv
dWdoIGENCj4gbG9va3MgZ29vZCBpcyBhbnkgbGVzcyBvZiBhIHJldmlldyB0aGFuIGFuIEFjaywg
aXQncyBqdXN0IGJldHRlcg0KPiBoaWRkZW4gYXMgcGVvcGxlIG5lZWQgdG8gbG9vayBhdCBtYWls
aW5nIGxpc3QgYXJjaGl2ZXMuLi4NCj4gDQo+IEpvbmF0aGFuDQo+IA0KDQpBY2tlZC1ieTogQWxl
eGFuZHJ1IEFyZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCg0KLy8gV2ls
bCByZW1lbWJlciB0aGF0IG5leHQgdGltZSA6KQ0KDQpUaGFua3MNCkFsZXgNCg0KPiA+IA0KPiA+
IEFsZXgNCj4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEdpdWxpYW5vIEJlbGluYXNzaSA8Z2l1
bGlhbm8uYmVsaW5hc3NpQHVzcC5icj4NCj4gPiA+IC0tLQ0KPiA+ID4gQ2hhbmdlcyBpbiB2MjoN
Cj4gPiA+IAktIFNxdWFzaGVkIGlzX2FkNzc4eCBkZWNsYXJhdGlvbiBjb21taXQgd2l0aCB0aGUg
YWQ3Nzh4IGNoZWNrYWdlDQo+ID4gPiAJLSBDaGFuZ2VkIGlzX2FkNzc4eCB0eXBlIHRvIGJvb2wN
Cj4gPiA+ICANCj4gPiA+ICBkcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYyB8IDE1ICsr
KysrKysrKysrLS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5n
L2lpby9hZGMvYWQ3NzgwLmMNCj4gPiA+IGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3Nzgw
LmMNCj4gPiA+IGluZGV4IDkxZTAxNmQ1MzRlZC4uOWVjMmIwMDI1MzllIDEwMDY0NA0KPiA+ID4g
LS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+ID4gPiBAQCAtMzUsNiArMzUsNyBAQCBzdHJ1
Y3QgYWQ3NzgwX2NoaXBfaW5mbyB7DQo+ID4gPiAgCXN0cnVjdCBpaW9fY2hhbl9zcGVjCWNoYW5u
ZWw7DQo+ID4gPiAgCXVuc2lnbmVkIGludAkJcGF0dGVybl9tYXNrOw0KPiA+ID4gIAl1bnNpZ25l
ZCBpbnQJCXBhdHRlcm47DQo+ID4gPiArCWJvb2wJCQlpc19hZDc3OHg7DQo+ID4gPiAgfTsNCj4g
PiA+ICANCj4gPiA+ICBzdHJ1Y3QgYWQ3NzgwX3N0YXRlIHsNCj4gPiA+IEBAIC0xMTMsMTAgKzEx
NCwxMiBAQCBzdGF0aWMgaW50IGFkNzc4MF9wb3N0cHJvY2Vzc19zYW1wbGUoc3RydWN0DQo+ID4g
PiBhZF9zaWdtYV9kZWx0YSAqc2lnbWFfZGVsdGEsDQo+ID4gPiAgCSAgICAoKHJhd19zYW1wbGUg
JiBjaGlwX2luZm8tPnBhdHRlcm5fbWFzaykgIT0gY2hpcF9pbmZvLT5wYXR0ZXJuKSkNCj4gPiA+
ICAJCXJldHVybiAtRUlPOw0KPiA+ID4gIA0KPiA+ID4gLQlpZiAocmF3X3NhbXBsZSAmIEFENzc4
MF9HQUlOKQ0KPiA+ID4gLQkJc3QtPmdhaW4gPSAxOw0KPiA+ID4gLQllbHNlDQo+ID4gPiAtCQlz
dC0+Z2FpbiA9IDEyODsNCj4gPiA+ICsJaWYgKGNoaXBfaW5mby0+aXNfYWQ3Nzh4KSB7DQo+ID4g
PiArCQlpZiAocmF3X3NhbXBsZSAmIEFENzc4MF9HQUlOKQ0KPiA+ID4gKwkJCXN0LT5nYWluID0g
MTsNCj4gPiA+ICsJCWVsc2UNCj4gPiA+ICsJCQlzdC0+Z2FpbiA9IDEyODsNCj4gPiA+ICsJfQ0K
PiA+ID4gIA0KPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiA+ICB9DQo+ID4gPiBAQCAtMTM1LDIxICsx
MzgsMjUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvDQo+ID4gPiBhZDc3
ODBfY2hpcF9pbmZvX3RibFtdID0gew0KPiA+ID4gIAkJLmNoYW5uZWwgPSBBRDc3ODBfQ0hBTk5F
TCgxMiwgMjQpLA0KPiA+ID4gIAkJLnBhdHRlcm4gPSAweDUsDQo+ID4gPiAgCQkucGF0dGVybl9t
YXNrID0gMHg3LA0KPiA+ID4gKwkJLmlzX2FkNzc4eCA9IGZhbHNlLA0KPiA+ID4gIAl9LA0KPiA+
ID4gIAlbSURfQUQ3MTcxXSA9IHsNCj4gPiA+ICAJCS5jaGFubmVsID0gQUQ3NzgwX0NIQU5ORUwo
MTYsIDI0KSwNCj4gPiA+ICAJCS5wYXR0ZXJuID0gMHg1LA0KPiA+ID4gIAkJLnBhdHRlcm5fbWFz
ayA9IDB4NywNCj4gPiA+ICsJCS5pc19hZDc3OHggPSBmYWxzZSwNCj4gPiA+ICAJfSwNCj4gPiA+
ICAJW0lEX0FENzc4MF0gPSB7DQo+ID4gPiAgCQkuY2hhbm5lbCA9IEFENzc4MF9DSEFOTkVMKDI0
LCAzMiksDQo+ID4gPiAgCQkucGF0dGVybiA9IDB4MSwNCj4gPiA+ICAJCS5wYXR0ZXJuX21hc2sg
PSAweDMsDQo+ID4gPiArCQkuaXNfYWQ3Nzh4ID0gdHJ1ZSwNCj4gPiA+ICAJfSwNCj4gPiA+ICAJ
W0lEX0FENzc4MV0gPSB7DQo+ID4gPiAgCQkuY2hhbm5lbCA9IEFENzc4MF9DSEFOTkVMKDIwLCAz
MiksDQo+ID4gPiAgCQkucGF0dGVybiA9IDB4MSwNCj4gPiA+ICAJCS5wYXR0ZXJuX21hc2sgPSAw
eDMsDQo+ID4gPiArCQkuaXNfYWQ3Nzh4ID0gdHJ1ZSwNCj4gPiA+ICAJfSwNCj4gPiA+ICB9Ow0K
PiA+ID4gICAgDQo+IA0KPiANCg==
