Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEB9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EBB20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b75uGW5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389533AbfAPIsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:48:36 -0500
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:43774
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388743AbfAPIsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KH1hrngfGhtmSD9y6vpXgNNTfxPho2lwqmSJd0NLZc=;
 b=b75uGW5LlIYq+LvYWDzv4xZkTTf07Ya/sxsWEsletKgozpYSbW1xTi4eqZM8BrM/PxVOVkWkQoF2HK9e43FE+cm5xBwfoXfkUZ4Ulj1uBCO3e7fXOzhvT/wWoBmCKzwb/bjQUcdQ++cZrrkcTyz9VlEvtrS0vtTPf8YNhSTpQmU=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB2157.eurprd04.prod.outlook.com (10.166.43.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 08:48:28 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::9c6e:406c:e2bd:c293]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::9c6e:406c:e2bd:c293%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 08:48:28 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH] i2c: imx: defer probing on dma channel request
Thread-Topic: [PATCH] i2c: imx: defer probing on dma channel request
Thread-Index: AQHUrNscebgymanw5EqY6/es3fB8+KWw4HEAgAC2V4A=
Date:   Wed, 16 Jan 2019 08:48:28 +0000
Message-ID: <633db479-e1be-3b8b-45c4-06d1b651fe12@nxp.com>
References: <20190115140332.30417-1-laurentiu.tudor@nxp.com>
 <20190115215549.sepj7rmpqmtlxwbw@ninjato>
In-Reply-To: <20190115215549.sepj7rmpqmtlxwbw@ninjato>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB2157;6:9DnXq/9LwAuLeT24a7UC9gkHWstdaCeiu8cntKPHWccC+P66+7zE2STASZpCXLWiso63RkJciBuNhiSrmomT707ghTWJ8mzpx9oDf70H6uuWGBMXhaGD0+8vAjPtLpbhlcnalp8/peFggZAX6QstnPejWHQjnmIXX2TCgtjhgfE+bNTR7hao+FzUhuUYy7MNsNcfR78KW6ipvBh17gkMPhg8+o4aABIhzLI0fcUt+gCxW+KIZJiM4BUia78o6CL0VJ2Ag26s2xxCKLzggOzh7xPkru7KlPc1a0ZGHLMKtr5amtJQsYV85fd36GhT5eOyHzEb4jjxShooHPiTFRjHJqHdbRy7jaYfXOmpGIZhyLVnb4I/k2cs9YtvFTtKSC8E4SEjC7Z50jPQ2+Uxg1+145rfvo0sXjTify7ngvK91HoWUXfdYhVnf0aW2KvI+Bv8Y7HuGjo+dpvjJjJz6Cbb3g==;5:/iySYbRQ/uUWdZPt9JjidUfVSb4znjY5vRV0X+uJmPVLREYu5G92GmbckQWbY6ATMpzI2lYVKZvLL9I+Iy7ODDrT4Xe7gxK7KCRZG0hu8iZGzHIShQne2T5S0+07W+2IYeKQEeg188vbvGg+ff1ctinlKiOXfLbSfPcgd5uyFnvcYUKJ5/QfSQb5n+oHZuB4gW87ZvQliRMcKPg8qRTBHQ==;7:uS7NKiKJvmng4nSToS92uZCn2Nn4npBmJ5+AxUtBinpENIgMXMXunts2U5abnpBaggI6DFNdZGQhlq6w0C9GuSA47/eE79ilEgDttyVSDH2vmA65w8Q2+nvASp/SlBw2yGUhWleVX6S2S1FW+JQ2Uw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 697b2dd5-0701-44f6-2a8d-08d67b8f62b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2157;
x-ms-traffictypediagnostic: VI1PR04MB2157:
x-microsoft-antispam-prvs: <VI1PR04MB2157D86CC52664ECF0D1CF45EC820@VI1PR04MB2157.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(136003)(366004)(189003)(199004)(71200400001)(71190400001)(6436002)(6486002)(6512007)(6306002)(6916009)(229853002)(7736002)(26005)(102836004)(8936002)(53546011)(81166006)(81156014)(68736007)(14444005)(256004)(305945005)(6506007)(11346002)(446003)(31696002)(476003)(5660300001)(2616005)(76176011)(86362001)(2906002)(186003)(8676002)(44832011)(54906003)(99286004)(486006)(6246003)(31686004)(316002)(66066001)(53936002)(966005)(97736004)(478600001)(6116002)(3846002)(106356001)(105586002)(4326008)(25786009)(14454004)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB2157;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Sz/RTeXUHrrO2EeTGIbCAJvNsGvfk4fM0ls/qEnoKRjsUxBCUolT+xuAfCQB7g3kmAsP3XYpWRWd1H4+wjv6zS67irkj2qjfDEW15hXv9c3D4zMJUfEF21Kt05Er3Hn4mBZaqf542VU6Xvx9WU5k+B7/d1t7lR7kwl5Ebn+x04HGqOicqgYnyisYlb1dspQ+RGPVMU5/4tSQ8D+ZauZcDqmED6Xsn4EXyblo+v8ZAzQacYR6Boj5CUkbtMPva5u9dIAg4m2wceaZ23B/CH4TTvQkl+K8qNVQ4DePBGd1dABDv4j0MfIl6k2JUF8QPP8TZZwvzH+Pzaf6Y7OVyfVkBjatubdxqYtib4A0nYsvZNA9tjwg/NPBJjeMnwkg2t5XaH0qeXvTVrs5gzyfVkKgZEAo6Rh/GoJtilK5DITYOko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1515DFC079315A43BEFC0B7DB76310FF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697b2dd5-0701-44f6-2a8d-08d67b8f62b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 08:48:28.4104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 15.01.2019 23:55, Wolfram Sang wrote:
> Hi,
>=20
> On Tue, Jan 15, 2019 at 04:03:32PM +0200, Laurentiu Tudor wrote:
>> If the dma controller is not yet probed, defer i2c probe.
>> The error path in probe was slightly modified (no functional change)
>> to avoid triggering this WARN_ON():
>> "cg-pll0-div1 already disabled
>> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0x=
b0"
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> I just applied this series to i2c/for-next:
>=20
> http://patchwork.ozlabs.org/project/linux-i2c/list/?series=3D85099&state=
=3D*
>=20
> I haven't checked carefully but maybe it fixes/changes your issue?=20

Not really as it doesn't seem to defer probing until the dma controller=20
gets probed.

> If not, your patch most likely will need a rebase on top of the above.

Will rebase on latest i2c tree and re-send.

---
Best Regards, Laurentiu=
