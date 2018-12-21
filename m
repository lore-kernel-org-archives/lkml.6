Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D54C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2561321927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="fyzS6SiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404417AbeLUSkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:40:14 -0500
Received: from mail-eopbgr20111.outbound.protection.outlook.com ([40.107.2.111]:8217
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730310AbeLUSkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:40:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hgJ9eKcvp3mtD3qtsywV2vcd5imvkiW6tLFwOQ5DIU=;
 b=fyzS6SiScvab2I6QjUqk1fRYyMs+dYA+1SXqf2/fyxen2YzooQrrwLKBdMn6rgIny7RiUqjoGWZT3cfmlVzIQ29AJ2t5DjhHOu4h790kb8mW4nopqkSp2x43uHGAdsMK/gwir4ArNVdGGZjZo1cnBGkm04SkmJiPo4rP0wT0VUI=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB1440.eurprd02.prod.outlook.com (10.165.232.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Fri, 21 Dec 2018 18:40:08 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8%5]) with mapi id 15.20.1446.020; Fri, 21 Dec 2018
 18:40:08 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Thread-Topic: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Thread-Index: AQHUl7rfZ33se6fYoU6lrQpH7Zprj6WGT3kAgAAUsQCAAEIogIAAv+SAgAHjUwCAAEAuAA==
Date:   Fri, 21 Dec 2018 18:40:08 +0000
Message-ID: <c1518533-ccc0-1a82-31b4-959682fb9b9e@axentia.se>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
 <20181219223341.GA998@kunai>
 <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
 <20181221145022.umsugdwadw5a5ag6@ninjato>
In-Reply-To: <20181221145022.umsugdwadw5a5ag6@ninjato>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::11) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB1440;6:Xf8aLQNsbDW6rmSQrqZ160y9FjQt1dZ2VqpPsNMSn9CObmkFFqJODDi1Mb7jZ+eHD850Z+27JKTZHI4PWknPuFZJz66A9vunUWXJen6umThWMyrDQM/pV2LJjEQmgGTqDIw6XPq8qclDkT9OuELTab5nyWncWYN5zMT3hScRCH7cj9L6pS2KdKd9YFubgaaFagpbrtUpkNMtynzbpFkEv08dsbYQVeT/Tbowj6DDpMkl1lK9+YzyaA9EOU2eWG5TJvAfZtfJo8xfHLUupVXm1amHFpQWo8ZX/4z8P9343DbH5Wjwebpne0+lKtWjL4CVzONP3+cbg3FGIqvvJRtfWfpDORIrpsmguvzuSafkd3wJseIWuw3RxpM3eA22VWypEWeIL9GBUHQP42+MvOtcCBxY+1GQozq8+c2mcmruuegdvYZnegZYJoCbYTMZx/59x25zpdycuIhEXm39ASETEA==;5:sptudN96DoBQRAYeCpO1G1jk5SF8y9pHMfjmZ7tKJIMzShtsewzzduTdwfM/tM9IoEjrSuxljSVbo1XWjVk803o07KINpOHjIjmMiy/ZXYSYD6LnFF4QBX387V4ZwaTFngrJxSXdRyQ4KCEkNzZ4LCGWzOu4sZ3AmQ1kgbD5GwE=;7:9TCpJSvL1tuYTMtIJt2Ba6yeG9X0iw81kUGBm5jRD5SezxJxHCe/6myvhjQfCMa4J80zxw1LQl9MUHvMNI07xeKj37VKDC6SogFAB4SVHkouJQwGwekd9FyKydj60+H7X9TvKsxPfpnqMnXymKZHfA==
x-ms-office365-filtering-correlation-id: b0f3ed5f-9f52-4037-eb0b-08d66773bb24
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB1440;
x-ms-traffictypediagnostic: VI1PR02MB1440:
x-microsoft-antispam-prvs: <VI1PR02MB1440096A6B45079B66FCF32FBCB80@VI1PR02MB1440.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB1440;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB1440;
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39830400003)(376002)(346002)(199004)(189003)(6246003)(105586002)(65826007)(14454004)(65806001)(65956001)(2906002)(8676002)(81166006)(7736002)(66066001)(6512007)(36756003)(4001150100001)(97736004)(52116002)(71190400001)(256004)(14444005)(3846002)(31696002)(71200400001)(53936002)(6436002)(5660300001)(25786009)(81156014)(446003)(11346002)(508600001)(2616005)(476003)(64126003)(58126008)(186003)(6486002)(486006)(86362001)(8936002)(110136005)(54906003)(229853002)(305945005)(26005)(68736007)(93886005)(4326008)(74482002)(53546011)(6116002)(106356001)(316002)(99286004)(6506007)(76176011)(31686004)(386003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB1440;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5JVRT7NAqfDAss/22WKCdRT+KX5saY/r+kecVXsGYtABSxOmu+cQ2dQ35L2SF9cQmFPQZEoUQNhdMVm5pwopR6iMBP9HAt1u51LBxpbDIVcHh3+VvpDkzC46mnwZiAYhi5RvJ0AYKiC6zf3bNxFx8j3nGWt4MDxmDegG1qqvOezGRvHU/c568VfmrdaPRpJK4XA9D9BCQEqK++iHapKpASWLtfxT3cw7rjEMxTKhL/Zg+pUIGoDD4MMJkZtZS9OH2sLBoBkGG4Ozq0PI9QtgSVHtRhJc1cT8snOg9xmnk0/ar3ZKCXsy+qr4iMm+RCpW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <02D913DAABD69147955C10E49A5487A1@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f3ed5f-9f52-4037-eb0b-08d66773bb24
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 18:40:08.0984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB1440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-21 15:50, Wolfram Sang wrote:
>=20
>>>> I think this might be as simple as adding:
>>>>
>>>> 	if (WARN_ON(adap->dev.parent->power.is_suspended))
>>>> 		return -ESHUTDOWN;
>=20
> Peter, I think this should work for muxes, too, or? The i2c_transfer()
> call to the mux will not be rejected, but it will be later when we reach
> the root adapter. And then the error code will be pushed down the tree
> until we arrive at the mux again. So, the rejection will not happen at
> the earliest time, but it will happen. Is my understanding correct?

Yes, I agree with that analysis. All mux actions eventually end up with
an __i2c_transfer() call on the relevant root adapter. Hmm, but not *all*
calls. How about SMBus adapters? Should there not be a similar WARN_ON
in __i2c_smbus_xfer?

But maybe that's not applicable for some reason? Just asking...

Cheers,
Peter

