Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AB9C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3A820870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 08:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="VdKfaip/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfBBIiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 03:38:46 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:60666 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfBBIip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 03:38:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; 
   d="scan'208";a="24149870"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 02 Feb 2019 01:38:44 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sat, 2 Feb 2019 01:38:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ2T7XKEtfASLBg202ZllOssDx09WpS+ngu+ab+5YTA=;
 b=VdKfaip/7si+oXtva+2PL9pjZYoTctMbHCg4VF1iEs6to8sK0CuluP0jgYvZythdeUIZmCEL4WlwrNhUUfPEiztopxlnkRzb+P+NaPRO9z92WogGUEXlJr0tW7Rn9te/koSnJSp8EMiA7Y0sRNwRbEtiZQwYLVH12OfHZl0ai5Y=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB2035.namprd11.prod.outlook.com (10.173.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Sat, 2 Feb 2019 08:38:40 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.017; Sat, 2 Feb 2019
 08:38:40 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <bbrezillon@kernel.org>
CC:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <robh+dt@kernel.org>,
        <linux-spi@vger.kernel.org>, <Ludovic.Desroches@microchip.com>,
        <broonie@kernel.org>, <linux-mtd@lists.infradead.org>,
        <bugalski.piotr@gmail.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Topic: [PATCH v3 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Thread-Index: AQHUuqzGfGfknscimE6zODgQQX/E96XMFmIAgAAZnoA=
Date:   Sat, 2 Feb 2019 08:38:40 +0000
Message-ID: <adf1d099-b8fd-6f91-75d7-6eee256b470b@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
 <20190202040653.1217-2-tudor.ambarus@microchip.com>
 <20190202080650.44becc2d@bbrezillon>
In-Reply-To: <20190202080650.44becc2d@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0901CA0093.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [188.25.201.137]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB2035;6:tE3TQLDaNKhwwQxRXYeuyn5ScRAbXCYoRmfIgHgk120TUrWhpiUkXXfT3Vex+veMJggUWX0Tyhl7jq2eESrK2a+WtGkmHT4VVhTe0xKpk0vHq7LzzyGFPTB//j8mrCHkzxKtrZSPzI8WWQVIZ/UnR68jiiF2dEpyLBaD0zQjL1cq7idB8CA4ZiKfWqpH5a8/4zTXqzGBdQbTQkXHeE2orq4P2K1e0MjYtGmYfktVYuPCJWTzdTxPJwZXbsMiHsPRd8IIfkbPRn6RZmVHC22BZxN69fobl0NaO4yMnPS9BPU5gB7qd79ZwGfsTn0xTDRSyNcBQcGKTafLB6UGgMTwPayQvBxSzTxXJwu4UzGjZPEd2llAxocVAU/PpuPUZgUw8unTktkb9Df5XGSF8SSu4+iamZSLZX1VC2FvQOVXeJPft5HVTVrz011li5XbwiQZDSPwBfGTkMHqMKnaABjXPA==;5:YrUVJhv4rPLVepkgv6adLsSLDgeExQ5HiTzV0IN/6c5jxvnJ19/cwTkQyaHjCpNjoUk8G4iaYFlOfKrLyREAGhtHMIoGuuUpnRp35V30tmGzJDKV07dvgkvCx/ceIjB0/MFxADNfTQ5Y8PVrWoxdVBKxLINjIstr7dPC7iAIX8H1WpLHqTVbN/xcADkT1o2h7ZAw2Ky5C8v48SqP8xntTQ==;7:Wj/3qpt+pk3h9W9/Ewbt3tL4//cyscqdXikW4JmLgFPFtMkAs/WISVvvB5isoaBtMUf0GciJ5asl0ce5dqdOomhgD9+T081CExBONT1ENpi+GKdua4pvZSlyLsGiZ4L4bTpQxgcMQPIbAo/6vFYh+A==
x-ms-office365-filtering-correlation-id: 8086988f-8c79-4035-131f-08d688e9d4dc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB2035;
x-ms-traffictypediagnostic: BN6PR11MB2035:
x-microsoft-antispam-prvs: <BN6PR11MB20356B50F2AE9650521BEE71F0930@BN6PR11MB2035.namprd11.prod.outlook.com>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(2616005)(8936002)(7416002)(11346002)(31686004)(105586002)(71190400001)(14454004)(71200400001)(81156014)(36756003)(8676002)(81166006)(486006)(97736004)(966005)(446003)(2906002)(3846002)(476003)(68736007)(6116002)(102836004)(39060400002)(106356001)(6246003)(229853002)(25786009)(6306002)(6512007)(4326008)(99286004)(52116002)(72206003)(6506007)(53936002)(6436002)(54906003)(186003)(256004)(31696002)(66066001)(26005)(14444005)(86362001)(53546011)(478600001)(6486002)(386003)(305945005)(7736002)(316002)(76176011)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB2035;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9QP5TYLaK6B20r/n7h0rR85xLQAh/ToQUhFhbjzY6dwvC15PB0WiA0JRthbUJ13xL5YBg4vRmxXnXZSA9DVW+zQtdbXjojJ+UVVWxkjI74dvlJpPLpoK7ngvqLc4z3uQQu53FxcSR0MjnJgAPEMtd0Rktl7Z4LJkFXr3wBn7Z/fF7fPw35trRkDWu3fY68Oq5fYEaXAlU8xDntLJXiOmWXHlfENW/9WDWWxig1u+wZURYLtCJohISSwhXl9qnQ9OPhbIJGJfHxn/ePUWG4hjkuMpBqtgl5U1grsEmMSYcI7ZjMVBshfTSP+ezdC2nffvHF/nAv+48bgO/wk4ZR/5pswY6a0TroFitZjJ1mZs0TLlzNvg3uvNehP74PhVgZ9rn1zCzLGxmlDJ2ENNWY3p4+vapgZsZKw+2RvsxJuIpyA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5481712A5D9E7D4CB4C58E8754D3914A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8086988f-8c79-4035-131f-08d688e9d4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 08:38:38.0938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB2035
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzAyLzIwMTkgMDk6MDYgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
U2F0LCAyIEZlYiAyMDE5IDA0OjA3OjEzICswMDAwDQo+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPiANCj4+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNA
bWljcm9jaGlwLmNvbT4NCj4+DQo+PiBDYWNoZSBTZXJpYWwgTWVtb3J5IE1vZGUgKFNNTSkgdmFs
dWUgdG8gYXZvaWQgd3JpdGUgYWNjZXNzIHdoZW4NCj4+IHNldHRpbmcgdGhlIGNvbnRyb2xsZXIg
aW4gc2VyaWFsIG1lbW9yeSBtb2RlLiBTTU0gaXMgc2V0IGluDQo+PiBleGVjX29wKCkgYW5kIG5v
dCBhdCBwcm9iZSB0aW1lLCB0byBsZXQgcm9vbSBmb3IgZnV0dXJlIHJlZ3VsYXINCj4+IFNQSSBz
dXBwb3J0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFy
dXNAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gdjM6IHVwZGF0ZSBzbW0gdmFsdWUgd2hlbiBk
aWZmZXJlbnQuIHJlbmFtZSBtci9zbW0NCj4+IHYyOiBjYWNoZSBNUiB2YWx1ZSBpbnN0ZWFkIG9m
IG1vdmluZyB0aGUgd3JpdGUgYWNjZXNzIGF0IHByb2JlDQo+Pg0KPj4gIGRyaXZlcnMvc3BpL2F0
bWVsLXF1YWRzcGkuYyB8IDcgKysrKysrLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvYXRt
ZWwtcXVhZHNwaS5jIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+PiBpbmRleCBkZGM3
MTI0MTA4MTIuLjY0NTI4NGM2ZWM5YSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvc3BpL2F0bWVs
LXF1YWRzcGkuYw0KPj4gKysrIGIvZHJpdmVycy9zcGkvYXRtZWwtcXVhZHNwaS5jDQo+PiBAQCAt
MTU1LDYgKzE1NSw3IEBAIHN0cnVjdCBhdG1lbF9xc3BpIHsNCj4+ICAJc3RydWN0IGNsawkJKmNs
azsNCj4+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZQkqcGRldjsNCj4+ICAJdTMyCQkJcGVuZGlu
ZzsNCj4+ICsJdTMyCQkJc21tOw0KPj4gIAlzdHJ1Y3QgY29tcGxldGlvbgljbWRfY29tcGxldGlv
bjsNCj4+ICB9Ow0KPj4gIA0KPj4gQEAgLTIzOCw3ICsyMzksMTEgQEAgc3RhdGljIGludCBhdG1l
bF9xc3BpX2V4ZWNfb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwgY29uc3Qgc3RydWN0IHNwaV9tZW1f
b3AgKm9wKQ0KPj4gIAlpY3IgPSBRU1BJX0lDUl9JTlNUKG9wLT5jbWQub3Bjb2RlKTsNCj4+ICAJ
aWZyID0gUVNQSV9JRlJfSU5TVEVOOw0KPj4gIA0KPj4gLQlxc3BpX3dyaXRlbChhcSwgUVNQSV9N
UiwgUVNQSV9NUl9TTU0pOw0KPj4gKwkvKiBTZXQgdGhlIFFTUEkgY29udHJvbGxlciBpbiBTZXJp
YWwgTWVtb3J5IE1vZGUgKi8NCj4+ICsJaWYgKGFxLT5zbW0gIT0gUVNQSV9NUl9TTU0pIHsNCj4g
DQo+IFNvcnJ5LCBJIHRoaW5rIEkgbWlzdW5kZXJzdG9vZCB5b3VyIHByZXZpb3VzIHN1Z2dlc3Rp
b24sIEkgdGhvdWdodCB0aGUNCj4gcmVnIHdhcyBjYWxsZWQgU01NLiBJZiB0aGUgcmVnIGlzIGNh
bGxlZCBNUiBhbmQgdGhlIHZhbHVlIHlvdSBleHBlY3QgaW4NCj4gdGhlcmUgaXMgU01NLCB0aGVu
IHRoZSBmaWVsZCBzaG91bGQgYmUgbmFtZWQgLT5tciBhcyBpdCBjYWNoZXMgdGhlDQo+IHdob2xl
IHJlZywgbm90IG9ubHkgdGhlIFNNTSBiaXQuIFNvIGl0J3MgYWN0dWFsbHk6DQo+IA0KPiAJaWYg
KGFxLT5tciAhPSBRU1BJX01SX1NNTSkgew0KDQpObyB3b3JyaWVzLiBXaGVuIGtlZXBpbmcgdGhl
IHJlZyBuYW1lLCBhbmQgbm90IHRoZSBiaXQgaXRzZWxmLCBJIHdvdWxkIGV4cGVjdCB0bw0KZG8g
dGhlIGNoZWNrIGFzIGluIHYyLCB0byBsZXQgcm9vbSBmb3IgY2hlY2tpbmcgb3RoZXIgYml0cyB0
b286DQoNCisJaWYgKCEoYXEtPm1yICYgUVNQSV9NUl9TTU0pKQ0KDQpJIGRvbid0IGhhdmUgYW55
IHByb2JsZW1zIHRvIGtlZXAgIm1yIiBuYW1lLCBidXQgSSB3b3VsZCBsaWtlIHRvIHVuZGVyc3Rh
bmQgeW91cg0KcmVhc29ucy4NCg0KVGhhbmtzLA0KdGENCg0KPiANCj4+ICsJCXFzcGlfd3JpdGVs
KGFxLCBRU1BJX01SLCBRU1BJX01SX1NNTSk7DQo+PiArCQlhcS0+c21tID0gUVNQSV9NUl9TTU07
DQo+PiArCX0NCj4+ICANCj4+ICAJbW9kZSA9IGZpbmRfbW9kZShvcCk7DQo+PiAgCWlmIChtb2Rl
IDwgMCkNCj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXw0KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsDQo+IA0K
