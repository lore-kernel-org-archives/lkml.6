Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4077DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E5420989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E5420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbeLEJuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:50:40 -0500
Received: from mail-eopbgr40052.outbound.protection.outlook.com ([40.107.4.52]:24298
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729725AbeLEJuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1xACOOB6JX0LDyT6uLioC/0ZCRH0LwcbItzIvzleJU=;
 b=ZtAuGSR3FTVGjUxMueUy90fftnbFgfDerUsGDErVgrfMy93ZBya+RzXUeN8F9l3JLbfuvLQtDAiaeTyrCKL7Dwo/eb6BVu03+50s7tA8pd0G2Rt4G/h9KhvujHOn5iM9nK1QJL8YIwOdTLYe+9IwRg0w7Xv1i6dtoKX65XNwsPU=
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com (10.175.20.142) by
 VI1PR0802MB2493.eurprd08.prod.outlook.com (10.175.22.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 09:50:32 +0000
Received: from VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac]) by VI1PR0802MB2528.eurprd08.prod.outlook.com
 ([fe80::3d5c:5229:b634:b1ac%11]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 09:50:32 +0000
From:   Dave Rodgman <dave.rodgman@arm.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sonnyrao@google.com" <sonnyrao@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        nd <nd@arm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 0/7] lib/lzo: performance improvements
Thread-Topic: [PATCH v4 0/7] lib/lzo: performance improvements
Thread-Index: AQHUiLiqITo/LLyl1EWjCUTAJp49+6Vvx1mAgAAnHwA=
Date:   Wed, 5 Dec 2018 09:50:32 +0000
Message-ID: <c4a9e85f-498e-337a-5bb1-b9c5e58acacd@arm.com>
References: <20181130142600.13782-1-dave.rodgman@arm.com>
 <20181205073029.GA30820@jagdpanzerIV>
In-Reply-To: <20181205073029.GA30820@jagdpanzerIV>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.53]
x-clientproxiedby: LO2P265CA0406.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::34) To VI1PR0802MB2528.eurprd08.prod.outlook.com
 (2603:10a6:800:b0::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dave.rodgman@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0802MB2493;6:w+pMKkVWM7KWpHQHTvccKqoIjAW+sPcIbv28FsAy6VGxTtHYRqN5bjonHlAUa0SYPsv+9hMwYSwwN4kKCt/gU0liYMcHlS23BLd2YlBYTp7vkWICkKJb+ML2ca7CCyfN+9nMdGP3LoeNYb1PocgZguOi3XndijVWNmz9GKUJBi4OT2fD3I7VBlvxVS5enYh/Zi7fVDST+j0kebIkzvWnnNbGHtGOmRDOdsRngq5SmV/AMEAsf9id8GCze7XF8hJD6Dc3Z1pFnBUKNxSizVkjnHCTlbDWfa4p8PZ/KuPzoqPyEdRP0MAg4nTx1vYu5m0udqTaLHe5X7rmP8w7M1iLM9aVLGQrpSj4eTmpsLPO7skaoEtzbqWxIe10ymccQ6YuEEJOg3mqUONGlR/rvYZh4JAoFvv5q7hgBHeabTTobCC/mzzm/Fe/QwcPGfqyq6GHsBUlBqETB5qUuCsYgdL3+A==;5:lwY0AKe2trmQFyHqyEAtVOtQnznZ95EAwfZP+pumC8kqFRBxG7y6/OEVJs5JsmOw74t7npo/drH3XleBVmF8LA6/105fBxCDhw24/mjphkAITsGPh0B4yqbXseePK7BDyUNNwTzNgGdByM2u/hHj2P+oUk2QtXewZJhlbttJhyQ=;7:JmViNJiLJ6ddG9LqEF7/0IZvtqAM1wtkjUWmMkTW8GebLxvc7ZPDEJwcZz/+oUpxfe7i04Lkg8d3915aHrgojBMa7EFNzO15+ggUXGJMP50Xa8v4A4VM4lgCEHjQ7MVfPTE04HgwtHfl3NPItOP5lw==
x-ms-office365-filtering-correlation-id: 7d9c64d2-e03d-4bb7-61ac-08d65a971873
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0802MB2493;
x-ms-traffictypediagnostic: VI1PR0802MB2493:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR0802MB2493825DA8C57DD86D8D328D8FA80@VI1PR0802MB2493.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0802MB2493;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0802MB2493;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(106356001)(105586002)(99286004)(6116002)(3846002)(31686004)(476003)(5660300001)(486006)(66066001)(44832011)(316002)(86362001)(6486002)(68736007)(446003)(11346002)(54906003)(2616005)(14444005)(36756003)(256004)(31696002)(4326008)(6246003)(14454004)(305945005)(6512007)(7736002)(81166006)(229853002)(26005)(186003)(25786009)(53936002)(6916009)(52116002)(2906002)(8676002)(81156014)(8936002)(6436002)(71190400001)(71200400001)(478600001)(39060400002)(53546011)(76176011)(6506007)(386003)(7416002)(97736004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2493;H:VI1PR0802MB2528.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /OBdAYq8evn02JUHdYe/vieWhHRuew37/gPHG4PnSMchiC6CzZImWOVbuj212ZfuYsBRcIC3vcjNvAKTcr7lFcHnWTatOIXJHjekKRmigggNUyf6zho4R0ALwRcD/pf1yJNWPy2Iqhdiyv0XfzOHrCNuBCJ4XllaAm1j4r3GfR/X96FZRv2x50TGnwxr/zFQQFB9RV5DtNEBhGzitPre2b+YR/6ZGsiI+qLEuYMxuJif1+nEOlG5OwWlr1oJW2rFrc8tJP2Mtn+v9WnwxYiOmw2nFwdeHJ+28KMCE/HjqaydhlKbiJgjOJGlBiFRaownGltrDBMuqKJ9VpLPmC1nKb7fkC1QY+6oGbHU2O+CF8c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8BDDF43925CE04AA393204F4A9BD099@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9c64d2-e03d-4bb7-61ac-08d65a971873
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 09:50:32.1744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMTIvMjAxOCA3OjMwIGFtLCBTZXJnZXkgU2Vub3poYXRza3kgd3JvdGU6DQo+IEhpIERh
dmUsDQo+IA0KPiBOb3RpY2VzIHRoaXMgd2FybmluZyB0b2RheToNCj4gDQo+IGxpYi9sem8vbHpv
MXhfY29tcHJlc3MuYzogSW4gZnVuY3Rpb24g4oCYbHpvMXhfMV9kb19jb21wcmVzc+KAmToNCj4g
bGliL2x6by9sem8xeF9jb21wcmVzcy5jOjIzOToxNDogd2FybmluZzog4oCYbV9wb3PigJkgbWF5
IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlh
bGl6ZWRdDQo+IDIzOSB8ICAgbV9vZmYgPSBpcCAtIG1fcG9zOw0KPiANCj4gQ2FyZSB0byB0YWtl
IGEgbG9vaz8gKGNvdWxkIGJlIGZhbHNlIHBvc2l0aXZlKQ0KDQpIaSBTZXJnZXksDQoNClRoaXMg
d2FybmluZyAoaXQncyBhIGZhbHNlIHBvc2l0aXZlIG9ubHkgc2VlbiB3aXRoIGdjYykgd2FzIGZp
eGVkIGJ5IHY0IG9mIHRoaXMgcGF0Y2hzZXQuIEkndmUganVzdCB0ZXN0ZWQgdGhlIGxhdGVzdCAN
CmxpbnV4LW5leHQvbWFzdGVyIChuZXh0LTIwMTgxMjA1KSBhbmQgaXQgZG9lc24ndCBoYXZlIHRo
aXMgaXNzdWUuDQoNCmNoZWVycw0KDQpEYXZlDQo=
