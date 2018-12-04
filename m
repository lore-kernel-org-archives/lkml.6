Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831E4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316822087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rzzQVRDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316822087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeLDJ4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:56:02 -0500
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:45056
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725613AbeLDJ4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:56:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvN/KDNRRS98311dJ46mtWdl8jkrMlrtUquskicRCqQ=;
 b=rzzQVRDuqItQa0hgLl7v3lLqPpERLLcmJg4EvniSLZcDW03VcUgaLLE1bb080yg4Elh2M/Y5BhKrprXhiwrv6h+xR6jdhW9A3KgX6LmxKpy7S7NTUD/BdE8xBK0J4BxBTRygNte731/CM2xZUMKHMnkjfcDpTtyYnNy9Fq+67TE=
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com (10.175.41.15) by
 AM5PR0402MB2705.eurprd04.prod.outlook.com (10.175.40.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:55:58 +0000
Received: from AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa]) by AM5PR0402MB2785.eurprd04.prod.outlook.com
 ([fe80::9d72:48b9:59c6:6dfa%4]) with mapi id 15.20.1382.020; Tue, 4 Dec 2018
 09:55:58 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>
CC:     Roy Pledge <roy.pledge@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>
Subject: RE: [PATCH 2/2] soc: fsl: dpio: use a cpumask to identify which cpus
 are unused
Thread-Topic: [PATCH 2/2] soc: fsl: dpio: use a cpumask to identify which cpus
 are unused
Thread-Index: AQHUdOozdrDXEgXDnkqgugAphJD21qVthS6AgAD/22A=
Date:   Tue, 4 Dec 2018 09:55:58 +0000
Message-ID: <AM5PR0402MB2785A41133A6434F4D4F053DE0AF0@AM5PR0402MB2785.eurprd04.prod.outlook.com>
References: <1541410219-9943-1-git-send-email-ioana.ciornei@nxp.com>
 <1541410219-9943-3-git-send-email-ioana.ciornei@nxp.com>
 <CADRPPNRiem+c2fK2RWyvopvre9ZBqT=6n8KxGJ1THtBpbA0d-Q@mail.gmail.com>
In-Reply-To: <CADRPPNRiem+c2fK2RWyvopvre9ZBqT=6n8KxGJ1THtBpbA0d-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2705;6:4NFEqCYRYzJJTnsFZvvYcAYCW1odqkrlm6gVvFSM7KVfxYEu90G4AlypWLyssZoBcFLlm62Mix79Qu1Tsz2CuqYZMUmmSoYP6BV9+NnbBsrfddG4ZbsP6OF896SuQdgiAOTY4PiiuH3VHM9WJAO7Abb64kBlLcB20ZvrIoEctry8YxxgA6zX7vd6RIa60ns4LSDpRGxcj/lpwNXAnz5Upj8XtcxYug3WMSA9bgoYRa7+lbj6qeXRI/7cppw5JWPRwGIjVXglC283KenDlE9/imrC5vvMGRJ0sYlXhGhZqgo64n3hB8xrhO8xRzubArxdnB9mnah/BBMiC2vDPj9sm4RPKXmtvMihBkiIXRSBzFjboV7I0GFI9P9O0KuQ15/ezCkuXj+HbmcOt2RJ/BAKpop9y9fLi2m50tOUOrhV62qNtA1dNafbH4bfNjtdtK2xx5Sh1ZKk2UiaE6KFGZSRNg==;5:Vq0D0kh9NRf+JL9dk303gs8Obe8hjscvvOIiepa+9FJQrJMKh7K3CKP2tN85MyP4HGqPBIOmQve9earswv95WjIzjUYqbbi/AkKVpw6CXfk6vnXn3ARSa3dpmtnF6EPwrHb2YrhXzY90WJXK5sq643x9xlvbbJ+YhpGeZqJ8GyI=;7:JRhDF4PtF4GXzDA2W+J5lOUvl/Emz2MHgfywoq01DpU+a6Aybnt8OCwxdahjvgDBgGphUxqb6n9AGgY2MHXmwz33x1X0WdqL+zcBi/MXCFh3IyIhn9ZmxzPVFV6f2iMi8Bukoc75bwMUR6qkhKcT+w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: af7fe039-d3ef-48be-e6b2-08d659ceb0e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2705;
x-ms-traffictypediagnostic: AM5PR0402MB2705:
x-microsoft-antispam-prvs: <AM5PR0402MB27052178F64ADB6435482475E0AF0@AM5PR0402MB2705.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2705;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2705;
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(199004)(189003)(97736004)(6116002)(3846002)(4326008)(229853002)(14454004)(106356001)(5660300001)(105586002)(6862004)(33656002)(6636002)(68736007)(11346002)(71190400001)(9686003)(44832011)(446003)(71200400001)(486006)(476003)(55016002)(2906002)(53936002)(478600001)(14444005)(256004)(25786009)(7736002)(99286004)(305945005)(86362001)(6246003)(8936002)(7696005)(76176011)(316002)(6436002)(74316002)(81156014)(81166006)(8676002)(6506007)(102836004)(66066001)(26005)(186003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2705;H:AM5PR0402MB2785.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +6P8KM6p3qLKVbPHa8icbBDvbHiu+J5auIUAZ2DvcIgR2UltJuQb0Taek42kkx0DyrQR7PQ+CLpc1WcUJFtWHzCGHfDdMK44qK8wnhbWPcVJV6MDeQ1NHC1VcpO5zIDyEb45uue7EfnPDOK/b2/G+D602BrLNCGPCtHbD8M9dpuf1HIdHD6kfXm7nF/RlMYyflwtHY1iGTyXYDq0HGul1V6XC4DK9blwJ/iMMf/tHfS5c4tPfD6tLUmndQIvb1yjLsdc5IFKx5lgwpIKEfdSL60hzTnVG6NnAFGxNqR8SeMT5XIEsYcCQxdEqSwhvWRC83sr2PNK6BsLo/Xc4sJ1sLUEcUToybxg+Hk10tVMcvE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7fe039-d3ef-48be-e6b2-08d659ceb0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:55:58.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgdGhlIGRwaW8gZHJpdmVyIHVz
ZXMgYSBzdGF0aWMgbmV4dF9jcHUNCj4gPiB2YXJpYWJsZSB0byBrZWVwIHRyYWNrIG9mIHRoZSBp
bmRleCBvZiB0aGUgbmV4dCBjcHUgYXZhaWxhYmxlLiBUaGlzDQo+ID4gYXBwcm9hY2ggZG9lcyBu
b3QgaGFuZGxlIHdlbGwgdW5iaW5kaW5nIGFuZCBiaW5kaW5nIGRwaW8gZGV2aWNlcyBpbiBhDQo+
ID4gcmFuZG9tIG9yZGVyLiBGb3IgZXhhbXBsZSwgdW5iaW5kaW5nIGEgZHBpbyBhbmQgdGhlbiBi
aW5kaW5nIGl0IGFnYWluDQo+ID4gd2l0aCB0aGUgZHJpdmVyLCB3aWxsIGdlbmVyYXRlIHRoZSBi
ZWxvdyBlcnJvcjoNCj4gPg0KPiA+ICQgZWNobyBkcGlvLjUgPiAvc3lzL2J1cy9mc2wtbWMvZHJp
dmVycy9mc2xfbWNfZHBpby91bmJpbmQNCj4gPiAkIGVjaG8gZHBpby41ID4gL3N5cy9idXMvZnNs
LW1jL2RyaXZlcnMvZnNsX21jX2RwaW8vYmluZA0KPiA+IFsgIDEwMy45NDYzODBdIGZzbF9tY19k
cGlvIGRwaW8uNTogcHJvYmUgZmFpbGVkLiBOdW1iZXIgb2YgRFBJT3MNCj4gPiBleGNlZWRzIE5S
X0NQVVMuDQo+ID4gWyAgMTAzLjk1NTE1N10gZnNsX21jX2RwaW8gZHBpby41OiBmc2xfbWNfZHJp
dmVyX3Byb2JlIGZhaWxlZDogLTM0DQo+ID4gLWJhc2g6IGVjaG86IHdyaXRlIGVycm9yOiBObyBz
dWNoIGRldmljZQ0KPiA+DQo+ID4gRml4IHRoaXMgZXJyb3IgYnkga2VlcGluZyBhIGdsb2JhbCBj
cHVtYXNrIG9mIHVudXNlZCBjcHVzIHRoYXQgd2lsbCBiZQ0KPiA+IHVwZGF0ZWQgYXQgZXZlcnkg
ZHBhYTJfZHBpb19bcHJvYmUscmVtb3ZlXS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IElvYW5h
IENpb3JuZWkgPGlvYW5hLmNpb3JuZWlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9z
b2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYyAgfCAyNSArKysrKysrKysrKysrKysrLS0tLS0tLS0t
DQo+ID4gZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1zZXJ2aWNlLmMgfCAgNiArKysrKysNCj4g
PiAgaW5jbHVkZS9zb2MvZnNsL2RwYWEyLWlvLmggICAgICAgICAgfCAgMiArKw0KPiA+ICAzIGZp
bGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYw0KPiA+IGIvZHJp
dmVycy9zb2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYw0KPiA+IGluZGV4IGU1OGZjYzkuLjgzMjE3
NWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvc29jL2ZzbC9kcGlvL2RwaW8tZHJpdmVyLmMNCj4gPiBAQCAtMzAs
NiArMzAsOCBAQCBzdHJ1Y3QgZHBpb19wcml2IHsNCj4gPiAgICAgICAgIHN0cnVjdCBkcGFhMl9p
byAqaW87DQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGNwdW1hc2tfdmFyX3QgY3B1c191bnVz
ZWRfbWFzazsNCj4gPiArDQo+ID4gIHN0YXRpYyBpcnFyZXR1cm5fdCBkcGlvX2lycV9oYW5kbGVy
KGludCBpcnFfbnVtLCB2b2lkICphcmcpICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSAoc3RydWN0IGRldmljZSAqKWFyZzsgQEAgLTg2LDcgKzg4LDcgQEANCj4gPiBzdGF0aWMg
aW50IGRwYWEyX2RwaW9fcHJvYmUoc3RydWN0IGZzbF9tY19kZXZpY2UgKmRwaW9fZGV2KQ0KPiA+
ICAgICAgICAgc3RydWN0IGRwaW9fcHJpdiAqcHJpdjsNCj4gPiAgICAgICAgIGludCBlcnIgPSAt
RU5PTUVNOw0KPiA+ICAgICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJmRwaW9fZGV2LT5kZXY7
DQo+ID4gLSAgICAgICBzdGF0aWMgaW50IG5leHRfY3B1ID0gLTE7DQo+ID4gKyAgICAgICBpbnQg
cG9zc2libGVfbmV4dF9jcHU7DQo+ID4NCj4gPiAgICAgICAgIHByaXYgPSBkZXZtX2t6YWxsb2Mo
ZGV2LCBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gPiAgICAgICAgIGlmICghcHJpdikN
Cj4gPiBAQCAtMTI4LDE3ICsxMzAsMTQgQEAgc3RhdGljIGludCBkcGFhMl9kcGlvX3Byb2JlKHN0
cnVjdCBmc2xfbWNfZGV2aWNlDQo+ICpkcGlvX2RldikNCj4gPiAgICAgICAgIGRlc2MuZHBpb19p
ZCA9IGRwaW9fZGV2LT5vYmpfZGVzYy5pZDsNCj4gPg0KPiA+ICAgICAgICAgLyogZ2V0IHRoZSBj
cHUgdG8gdXNlIGZvciB0aGUgYWZmaW5pdHkgaGludCAqLw0KPiA+IC0gICAgICAgaWYgKG5leHRf
Y3B1ID09IC0xKQ0KPiA+IC0gICAgICAgICAgICAgICBuZXh0X2NwdSA9IGNwdW1hc2tfZmlyc3Qo
Y3B1X29ubGluZV9tYXNrKTsNCj4gPiAtICAgICAgIGVsc2UNCj4gPiAtICAgICAgICAgICAgICAg
bmV4dF9jcHUgPSBjcHVtYXNrX25leHQobmV4dF9jcHUsIGNwdV9vbmxpbmVfbWFzayk7DQo+ID4g
LQ0KPiA+IC0gICAgICAgaWYgKCFjcHVfcG9zc2libGUobmV4dF9jcHUpKSB7DQo+ID4gKyAgICAg
ICBwb3NzaWJsZV9uZXh0X2NwdSA9IGNwdW1hc2tfZmlyc3QoY3B1c191bnVzZWRfbWFzayk7DQo+
ID4gKyAgICAgICBpZiAocG9zc2libGVfbmV4dF9jcHUgPj0gbnJfY3B1X2lkcykgew0KPiA+ICAg
ICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgInByb2JlIGZhaWxlZC4gTnVtYmVyIG9mIERQSU9z
IGV4Y2VlZHMgTlJfQ1BVUy5cbiIpOw0KPiA+ICAgICAgICAgICAgICAgICBlcnIgPSAtRVJBTkdF
Ow0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9hbGxvY2F0ZV9pcnFzOw0KPiA+ICAgICAg
ICAgfQ0KPiA+IC0gICAgICAgZGVzYy5jcHUgPSBuZXh0X2NwdTsNCj4gPiArICAgICAgIGRlc2Mu
Y3B1ID0gcG9zc2libGVfbmV4dF9jcHU7DQo+ID4gKyAgICAgICBjcHVtYXNrX2NsZWFyX2NwdShw
b3NzaWJsZV9uZXh0X2NwdSwgY3B1c191bnVzZWRfbWFzayk7DQo+ID4NCj4gPiAgICAgICAgIC8q
DQo+ID4gICAgICAgICAgKiBTZXQgdGhlIENFTkEgcmVncyB0byBiZSB0aGUgY2FjaGUgaW5oaWJp
dGVkIGFyZWEgb2YgdGhlDQo+ID4gcG9ydGFsIHRvIEBAIC0yMTEsNyArMjEwLDcgQEAgc3RhdGlj
IGludCBkcGFhMl9kcGlvX3JlbW92ZShzdHJ1Y3QNCj4gPiBmc2xfbWNfZGV2aWNlICpkcGlvX2Rl
dikgIHsNCj4gPiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiAgICAgICAgIHN0cnVj
dCBkcGlvX3ByaXYgKnByaXY7DQo+ID4gLSAgICAgICBpbnQgZXJyOw0KPiA+ICsgICAgICAgaW50
IGVyciA9IDAsIGNwdTsNCj4gPg0KPiA+ICAgICAgICAgZGV2ID0gJmRwaW9fZGV2LT5kZXY7DQo+
ID4gICAgICAgICBwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gQEAgLTIyMCw2ICsy
MTksOSBAQCBzdGF0aWMgaW50IGRwYWEyX2RwaW9fcmVtb3ZlKHN0cnVjdCBmc2xfbWNfZGV2aWNl
DQo+ID4gKmRwaW9fZGV2KQ0KPiA+DQo+ID4gICAgICAgICBkcGlvX3RlYXJkb3duX2lycXMoZHBp
b19kZXYpOw0KPiA+DQo+ID4gKyAgICAgICBjcHUgPSBkcGFhMl9pb19nZXRfY3B1KHByaXYtPmlv
KTsNCj4gPiArICAgICAgIGNwdW1hc2tfc2V0X2NwdShjcHUsIGNwdXNfdW51c2VkX21hc2spOw0K
PiA+ICsNCj4gPiAgICAgICAgIGVyciA9IGZzbF9tY19wb3J0YWxfYWxsb2NhdGUoZHBpb19kZXYs
IDAsICZkcGlvX2Rldi0+bWNfaW8pOw0KPiA+ICAgICAgICAgaWYgKGVycikgew0KPiA+ICAgICAg
ICAgICAgICAgICBkZXZfZXJyKGRldiwgIk1DIHBvcnRhbCBhbGxvY2F0aW9uIGZhaWxlZFxuIik7
IEBADQo+ID4gLTI2NywxMSArMjY5LDE2IEBAIHN0YXRpYyBpbnQgZHBhYTJfZHBpb19yZW1vdmUo
c3RydWN0IGZzbF9tY19kZXZpY2UNCj4gPiAqZHBpb19kZXYpDQo+ID4NCj4gPiAgc3RhdGljIGlu
dCBkcGlvX2RyaXZlcl9pbml0KHZvaWQpDQo+ID4gIHsNCj4gPiArICAgICAgIGlmICghemFsbG9j
X2NwdW1hc2tfdmFyKCZjcHVzX3VudXNlZF9tYXNrLCBHRlBfS0VSTkVMKSkNCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gKyAgICAgICBjcHVtYXNrX2NvcHkoY3B1c191
bnVzZWRfbWFzaywgY3B1X29ubGluZV9tYXNrKTsNCj4gPiArDQo+ID4gICAgICAgICByZXR1cm4g
ZnNsX21jX2RyaXZlcl9yZWdpc3RlcigmZHBhYTJfZHBpb19kcml2ZXIpOw0KPiA+ICB9DQo+ID4N
Cj4gPiAgc3RhdGljIHZvaWQgZHBpb19kcml2ZXJfZXhpdCh2b2lkKQ0KPiA+ICB7DQo+ID4gKyAg
ICAgICBmcmVlX2NwdW1hc2tfdmFyKGNwdXNfdW51c2VkX21hc2spOw0KPiA+ICAgICAgICAgZnNs
X21jX2RyaXZlcl91bnJlZ2lzdGVyKCZkcGFhMl9kcGlvX2RyaXZlcik7DQo+ID4gIH0NCj4gPiAg
bW9kdWxlX2luaXQoZHBpb19kcml2ZXJfaW5pdCk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
c29jL2ZzbC9kcGlvL2RwaW8tc2VydmljZS5jDQo+ID4gYi9kcml2ZXJzL3NvYy9mc2wvZHBpby9k
cGlvLXNlcnZpY2UuYw0KPiA+IGluZGV4IDIxYzNlMzIuLjMxOTgyNjUgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1zZXJ2aWNlLmMNCj4gPiArKysgYi9kcml2ZXJz
L3NvYy9mc2wvZHBpby9kcGlvLXNlcnZpY2UuYw0KPiA+IEBAIC0yMTQsNiArMjE0LDEyIEBAIGly
cXJldHVybl90IGRwYWEyX2lvX2lycShzdHJ1Y3QgZHBhYTJfaW8gKm9iaikNCj4gPiAgICAgICAg
IHJldHVybiBJUlFfSEFORExFRDsNCj4gPiAgfQ0KPiA+DQo+ID4gK2ludCBkcGFhMl9pb19nZXRf
Y3B1KHN0cnVjdCBkcGFhMl9pbyAqZCkgew0KPiA+ICsgICAgICAgcmV0dXJuIGQtPmRwaW9fZGVz
Yy5jcHU7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChkcGFhMl9pb19nZXRfY3B1KTsNCj4g
DQo+IEFsdGhvdWdoIHRoaXMgZnVuY3Rpb24gaXMgdmVyeSBzaW1wbGUgZnVuY3Rpb24gYW5kIHBy
b2JhYmx5IHNlbGYtZXhwbGFuYXRvcnksIGl0IGlzDQo+IHJlcXVpcmVkIHRoYXQgZXhwb3J0ZWQg
QVBJcyBoYXZlIGEga2VybmVsLWRvYyBjb21tZW50IGp1c3QgbGlrZSBvdGhlciBmdW5jdGlvbnMN
Cj4gaW4gdGhlIGZpbGUuDQoNClNvcnJ5IGZvciB0aGF0LiBXaWxsIHNlbmQgYW4gdXBkYXRlZCB2
ZXJzaW9uIHRvIGZpeCB0aGlzLg0KDQpJb2FuYQ0KDQo+IA0KPiA+ICsNCj4gPiAgLyoqDQo+ID4g
ICAqIGRwYWEyX2lvX3NlcnZpY2VfcmVnaXN0ZXIoKSAtIFByZXBhcmUgZm9yIHNlcnZpY2luZyBv
ZiBGUURBTiBvciBDREFODQo+ID4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5v
dGlmaWNhdGlvbnMgb24gdGhlIGdpdmVuIERQSU8gc2VydmljZS4NCj4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9zb2MvZnNsL2RwYWEyLWlvLmggYi9pbmNsdWRlL3NvYy9mc2wvZHBhYTItaW8uaA0K
PiA+IGluZGV4IGFiNTFlNDAuLjFjMTc2NGYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9zb2Mv
ZnNsL2RwYWEyLWlvLmgNCj4gPiArKysgYi9pbmNsdWRlL3NvYy9mc2wvZHBhYTItaW8uaA0KPiA+
IEBAIC05MCw2ICs5MCw4IEBAIHN0cnVjdCBkcGFhMl9pb19ub3RpZmljYXRpb25fY3R4IHsNCj4g
PiAgICAgICAgIHZvaWQgKmRwaW9fcHJpdmF0ZTsNCj4gPiAgfTsNCj4gPg0KPiA+ICtpbnQgZHBh
YTJfaW9fZ2V0X2NwdShzdHJ1Y3QgZHBhYTJfaW8gKmQpOw0KPiA+ICsNCj4gPiAgaW50IGRwYWEy
X2lvX3NlcnZpY2VfcmVnaXN0ZXIoc3RydWN0IGRwYWEyX2lvICpzZXJ2aWNlLA0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcGFhMl9pb19ub3RpZmljYXRpb25fY3R4
ICpjdHgpOw0KPiA+IHZvaWQgZHBhYTJfaW9fc2VydmljZV9kZXJlZ2lzdGVyKHN0cnVjdCBkcGFh
Ml9pbyAqc2VydmljZSwNCj4gPiAtLQ0KPiA+IDEuOS4xDQo+ID4NCg==
