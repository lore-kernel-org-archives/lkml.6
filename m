Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F1CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570C320811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 07:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ClWqfXci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570C320811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeLNHsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 02:48:55 -0500
Received: from mail-eopbgr30127.outbound.protection.outlook.com ([40.107.3.127]:31280
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726998AbeLNHsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 02:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYvjY/qdG06kbVt0llvUxkweQj7h+gwToveeRQgBqqM=;
 b=ClWqfXciuX8LNjdXw70THvsvDysZIP5qHeoTxdTTxZWWFOBVrlw4h68cXDXGeEghc+7cYYO2ig5i5jDTfJgNtqaVmF/ZF0toD3Ho2YFVtmk0TxMmPABJq4PwLSt+UmvgdNDAScQFGKe0q1ITliv6OnH/GeE36JMzpnUYeXZdEc8=
Received: from AM6PR08MB4213.eurprd08.prod.outlook.com (20.178.91.206) by
 AM6SPR01MB0032.eurprd08.prod.outlook.com (20.177.117.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Fri, 14 Dec 2018 07:48:11 +0000
Received: from AM6PR08MB4213.eurprd08.prod.outlook.com
 ([fe80::503:716b:a67:5fe6]) by AM6PR08MB4213.eurprd08.prod.outlook.com
 ([fe80::503:716b:a67:5fe6%3]) with mapi id 15.20.1425.021; Fri, 14 Dec 2018
 07:48:10 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH] vhost: return EINVAL if iovecs size does not match the
 message size
Thread-Topic: [PATCH] vhost: return EINVAL if iovecs size does not match the
 message size
Thread-Index: AQHUkvOy1ciA70m9jUq2f7iIAKeCIqV9FaKAgADHKwA=
Date:   Fri, 14 Dec 2018 07:48:10 +0000
Message-ID: <677e47dd-6c34-b1ac-67b0-2740fc9f7e30@virtuozzo.com>
References: <20181213145350.5454-1-ptikhomirov@virtuozzo.com>
 <20181213143426-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181213143426-mutt-send-email-mst@kernel.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0068.eurprd04.prod.outlook.com
 (2603:10a6:3:19::36) To AM6PR08MB4213.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ptikhomirov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6SPR01MB0032;20:F3XME7bOlhH4kxeGzmRQ0lsaXa4L5hF1D28EyZf4BameA23I/y0VTzCXWTHQyswYFuM3X3JJTL3J5IhmbxI/cpB18PID1AYlvA+I2M9A1XTLnpJ14b9DmsdYQaX0hDC13ac2HOGCFvteMYA/oVisJ+ZZjlK4vH4DBzwuwCwt7Fg=
x-ms-office365-filtering-correlation-id: 533816c2-32ed-4124-380f-08d661987e82
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6SPR01MB0032;
x-ms-traffictypediagnostic: AM6SPR01MB0032:
x-microsoft-antispam-prvs: <AM6SPR01MB003210C5E09879EFADE9C11FB7A10@AM6SPR01MB0032.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM6SPR01MB0032;BCL:0;PCL:0;RULEID:;SRVR:AM6SPR01MB0032;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(376002)(366004)(346002)(136003)(51914003)(189003)(199004)(8676002)(6486002)(6436002)(2906002)(6506007)(53546011)(102836004)(186003)(26005)(386003)(14454004)(6916009)(99286004)(229853002)(81166006)(97736004)(81156014)(316002)(6512007)(7736002)(305945005)(53936002)(107886003)(86362001)(31696002)(6246003)(76176011)(52116002)(8936002)(71190400001)(71200400001)(4326008)(54906003)(256004)(5660300001)(25786009)(2616005)(11346002)(446003)(105586002)(478600001)(486006)(106356001)(36756003)(476003)(66066001)(6116002)(3846002)(31686004)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6SPR01MB0032;H:AM6PR08MB4213.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EY96GarUbu5QLsMFtOAyC3+1QhN3BY7i39vPhhAyQd74Ai4GrvY872C6CplLSMMeD1JVtqmIbke2bCk6oE1XxFVFFdlaDkziajia4RI95pq2gSs89SOtwIm++TDBVF8fSAMDihTwJvBhYmJHenA26NsDT8vjEf8TuGFdJJFAUmCMh/8jrcThbZZFPHvVwWhJniXkJTtFbd4K6D4myz4RBRCPPtqKbAbOsJFyRoX66mDOTD91v+IBYTxo0XvdmZFk6OjEUFijzJV1v7mQ+x2AOawS63ywZFOA8faV3xPNIsk+n0X05XpHgOpL/eYtyfHp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <69FB16C01A942B4583B044E072F76ACF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533816c2-32ed-4124-380f-08d661987e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 07:48:10.7859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTMvMjAxOCAxMDo1NSBQTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiBPbiBU
aHUsIERlYyAxMywgMjAxOCBhdCAwNTo1Mzo1MFBNICswMzAwLCBQYXZlbCBUaWtob21pcm92IHdy
b3RlOg0KPj4gV2UndmUgZmFpbGVkIHRvIGNvcHkgYW5kIHByb2Nlc3Mgdmhvc3RfaW90bGJfbXNn
IHNvIGxldCB1c2Vyc3BhY2UgYXQNCj4+IGxlYXN0IGtub3cgYWJvdXQgaXQuIEZvciBpbnN0YW5j
ZSBiZWZvcmUgdGhlc2UgcGF0Y2ggdGhlIGNvZGUgYmVsb3cgcnVucw0KPj4gd2l0aG91dCBhbnkg
ZXJyb3I6DQo+Pg0KPj4gaW50IG1haW4oKQ0KPj4gew0KPj4gICAgc3RydWN0IHZob3N0X21zZyBt
c2c7DQo+PiAgICBzdHJ1Y3QgaW92ZWMgaW92Ow0KPj4gICAgaW50IGZkOw0KPj4NCj4+ICAgIGZk
ID0gb3BlbigiL2Rldi92aG9zdC1uZXQiLCBPX1JEV1IpOw0KPj4gICAgaWYgKGZkID09IC0xKSB7
DQo+PiAgICAgIHBlcnJvcigib3BlbiIpOw0KPj4gICAgICByZXR1cm4gMTsNCj4+ICAgIH0NCj4+
DQo+PiAgICBpb3YuaW92X2Jhc2UgPSAmbXNnOw0KPj4gICAgaW92Lmlvdl9sZW4gPSBzaXplb2Yo
bXNnKS00Ow0KPj4NCj4+ICAgIGlmICh3cml0ZXYoZmQsICZpb3YsMSkgPT0gLTEpIHsNCj4+ICAg
ICAgcGVycm9yKCJ3cml0ZXYiKTsNCj4+ICAgICAgcmV0dXJuIDE7DQo+PiAgICB9DQo+Pg0KPj4g
ICAgcmV0dXJuIDA7DQo+PiB9DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGF2ZWwgVGlraG9taXJv
diA8cHRpa2hvbWlyb3ZAdmlydHVvenpvLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHBhdGNo
IQ0KPiANCj4+IC0tLQ0KPj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCA4ICsrKysrKy0tDQo+
PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYw0KPj4gaW5kZXggM2E1ZjgxYTY2ZDM0Li4wMzAxNDIyNGVmMTMgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMNCj4+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYw0K
Pj4gQEAgLTEwMjQsOCArMTAyNCwxMCBAQCBzc2l6ZV90IHZob3N0X2Nocl93cml0ZV9pdGVyKHN0
cnVjdCB2aG9zdF9kZXYgKmRldiwNCj4+ICAgCWludCB0eXBlLCByZXQ7DQo+PiAgIA0KPj4gICAJ
cmV0ID0gY29weV9mcm9tX2l0ZXIoJnR5cGUsIHNpemVvZih0eXBlKSwgZnJvbSk7DQo+PiAtCWlm
IChyZXQgIT0gc2l6ZW9mKHR5cGUpKQ0KPj4gKwlpZiAocmV0ICE9IHNpemVvZih0eXBlKSkgew0K
Pj4gKwkJcmV0ID0gLUVJTlZBTDsNCj4+ICAgCQlnb3RvIGRvbmU7DQo+PiArCX0NCj4+ICAgDQo+
PiAgIAlzd2l0Y2ggKHR5cGUpIHsNCj4+ICAgCWNhc2UgVkhPU1RfSU9UTEJfTVNHOg0KPiANCj4g
c2hvdWxkIHRoaXMgYmUgRUZBVUxUIHJhdGhlcj8NCg0KV2UgYWxyZWFkeSBoYXZlICJJbnZhbGlk
IGFyZ3VtZW50IiByZXR1cm5lZCB3aGVuIHdyb25nIHR5cGUgb2Ygdmhvc3RfbXNnIA0KcmVjZWl2
ZWQsIEkgdGhvdWdoIGl0IHdvdWxkIGJlIGZpbmUgdG8gcmV0dXJuIHNhbWUgdGhpbmcgaWYgd2Ug
aGF2ZSANCndyb25nIHNpemUgb2Ygdmhvc3RfbXNnLg0KDQpXaGVuIHdlIHJldHVybiAiQmFkIGFk
ZHJlc3MiIGJlY2F1c2Ugb2Ygdmhvc3RfcHJvY2Vzc19pb3RsYl9tc2cgZmFpbCwgaXQgDQppcyBi
ZWNhdXNlIG91ciB2aG9zdF9kZXYgaGFzIG5vIC0+aW90bGIgc28gb3VyIHByb2JsZW0gaXMgbm90
IGNvbm5lY3RlZCANCnRvIHRoZSBkYXRhIHBhc3NlZCBmcm9tIHVzZXJzcGFjZSBidXQgd2l0aCB0
aGUgc3RhdGUgb2Ygdmhvc3RfZGV2Lg0KDQpTbyBJIGxpa2UgRUlOVkFMIG1vcmUgaW4gdGhlc2Ug
dHdvIGNhc2VzLg0KDQo+IA0KPj4gQEAgLTEwNDQsOCArMTA0NiwxMCBAQCBzc2l6ZV90IHZob3N0
X2Nocl93cml0ZV9pdGVyKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwNCj4+ICAgDQo+PiAgIAlpb3Zf
aXRlcl9hZHZhbmNlKGZyb20sIG9mZnNldCk7DQo+PiAgIAlyZXQgPSBjb3B5X2Zyb21faXRlcigm
bXNnLCBzaXplb2YobXNnKSwgZnJvbSk7DQo+PiAtCWlmIChyZXQgIT0gc2l6ZW9mKG1zZykpDQo+
PiArCWlmIChyZXQgIT0gc2l6ZW9mKG1zZykpIHsNCj4+ICsJCXJldCA9IC1FSU5WQUw7DQo+PiAg
IAkJZ290byBkb25lOw0KPj4gKwl9DQo+PiAgIAlpZiAodmhvc3RfcHJvY2Vzc19pb3RsYl9tc2co
ZGV2LCAmbXNnKSkgew0KPj4gICAJCXJldCA9IC1FRkFVTFQ7DQo+PiAgIAkJZ290byBkb25lOw0K
PiANCj4gVGhpcyB0b28/DQo+IA0KPj4gLS0gDQo+PiAyLjE3LjENCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsIFRpa2hvbWlyb3YgUGF2ZWwNClNvZnR3YXJlIERldmVsb3BlciwgVmlydHVvenpvLg0K
