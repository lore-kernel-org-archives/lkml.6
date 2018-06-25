Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80169C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B2526185
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TrgGP3O7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B2526185
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755735AbeFYVXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:23:51 -0400
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:15393
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755621AbeFYVXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG9Sr0VOcjX5lkWw9HUi7UVNKmtMnwGZP5V23ReWyE0=;
 b=TrgGP3O7GwAHAyJFkDOJb/ZqkZdfgCORO0u/0zWCxWS/0FANXZ+A6oR9S+QAwghYvNX5AEMx7bkgNcF2IX4xzRlA/kWLEc5xncBBvUaUOmHc4KBWYVpptl9OCY8a4VWlG2WKb0xrzTJyb5uplxrsrBxI17fbs4gcCwuRmkOB3UE=
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com (52.132.100.10) by
 CY4PR2101MB0866.namprd21.prod.outlook.com (52.132.101.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.5; Mon, 25 Jun 2018 21:23:45 +0000
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7]) by CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7%5]) with mapi id 15.20.0930.005; Mon, 25 Jun 2018
 21:23:45 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 08/15] CIFS: SMBD: Support page offset in RDMA send
Thread-Topic: [Patch v2 08/15] CIFS: SMBD: Support page offset in RDMA send
Thread-Index: AQHT+E9fpX+VkUWirkGN3Idedqto+aRu0MCAgALSvZA=
Date:   Mon, 25 Jun 2018 21:23:44 +0000
Message-ID: <CY4PR2101MB07228C8B88784E03A8E9175BCE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-9-longli@linuxonhyperv.com>
 <ad9b2249-7e26-be0d-997c-c1cc128f70d6@talpey.com>
In-Reply-To: <ad9b2249-7e26-be0d-997c-c1cc128f70d6@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a:fdde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2101MB0866;7:46OT+R9xai6GJxEdBjBqg3V/STQ/Vuc/Atv+8/NFSpLGp0BB2soGXDNOTppnYBflgaNv1S0dFfr5cH45FUUrX6ZhO9PjHEIAkvP/QrkhimOTtrOoVB4kfPA5/zWDcOqwVmEQKmcfhY+tT/pcJzvLvv5OAtqTqSbC2cVF7wzzIRcXocwfS5i00AMtNgX9US7EX8lrKoX6uin8Q6sVZPr5ymGSPXPpfLvwFKJH1+ty8bWuVSaol1FfPyIoJO7l1Ep+
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ab7a1fee-efb5-4e99-b4a2-08d5dae1eeba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:CY4PR2101MB0866;
x-ms-traffictypediagnostic: CY4PR2101MB0866:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR2101MB0866481A5F14EA013CB1F1CDCE4A0@CY4PR2101MB0866.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR2101MB0866;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2101MB0866;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(229853002)(10290500003)(55016002)(33656002)(106356001)(105586002)(6436002)(9686003)(2900100001)(2501003)(5250100002)(14454004)(110136005)(478600001)(22452003)(316002)(6116002)(476003)(486006)(102836004)(11346002)(46003)(99286004)(186003)(446003)(76176011)(8676002)(86612001)(305945005)(7736002)(81166006)(74316002)(6506007)(81156014)(7696005)(97736004)(68736007)(25786009)(86362001)(10090500001)(8936002)(53936002)(2201001)(5660300001)(6246003)(2906002)(8990500004)(53546011)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2101MB0866;H:CY4PR2101MB0722.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1cKqMjsR5Cm/I7QLvL5l3ftLV5tq8UZRpk2A+C+qYrDXQu/JHxsKEJh6ryvI6ShcnHOfbEyxD6RAOkKhUCaAsyuN0cftrdPm1+w+Hm81GB/69WeW+4Mvp6cycwL83kds85Z4tQ1Z1yN8GgCweFfNt8NZekk1W/pCHHeya9MH3IBHjhdyMCA80eoWhs65QmC5WUiV5ylJrsRgYfioOG4LJFvFVUYMXlTllftpPK8QasHigf3Tpnd4o86/8xog4qbe1iKButmDXWECyMGjdjz5gJljeTc3FDkajuQhB+k2nC8A7R+N02f5a13bV+MEL3Lhj2ZhCfvRpWCPR8g4Ux2CWqImRxc8xHQdnQMblj1i1n8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7a1fee-efb5-4e99-b4a2-08d5dae1eeba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 21:23:44.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDA4LzE1XSBDSUZTOiBTTUJEOiBTdXBwb3J0IHBhZ2Ug
b2Zmc2V0IGluIFJETUEgc2VuZA0KPiANCj4gT24gNS8zMC8yMDE4IDM6NDggUE0sIExvbmcgTGkg
d3JvdGU6DQo+ID4gRnJvbTogTG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4NCj4g
PiBUaGUgUkRNQSBzZW5kIGZ1bmN0aW9uIG5lZWRzIHRvIGxvb2sgYXQgb2Zmc2V0IGluIHRoZSBy
ZXF1ZXN0IHBhZ2VzLA0KPiA+IGFuZCBzZW5kIGRhdGEgc3RhcnRpbmcgZnJvbSB0aGVyZS4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IExvbmcgTGkgPGxvbmdsaUBtaWNyb3NvZnQuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgZnMvY2lmcy9zbWJkaXJlY3QuYyB8IDI3ICsrKysrKysrKysrKysrKysrKyst
LS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDggZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZnMvY2lmcy9zbWJkaXJlY3QuYyBiL2ZzL2Np
ZnMvc21iZGlyZWN0LmMgaW5kZXgNCj4gPiBjNjJmN2M5Li42MTQxZTNjIDEwMDY0NA0KPiA+IC0t
LSBhL2ZzL2NpZnMvc21iZGlyZWN0LmMNCj4gPiArKysgYi9mcy9jaWZzL3NtYmRpcmVjdC5jDQo+
ID4gQEAgLTE3LDYgKzE3LDcgQEANCj4gPiAgICNpbmNsdWRlIDxsaW51eC9oaWdobWVtLmg+DQo+
ID4gICAjaW5jbHVkZSAic21iZGlyZWN0LmgiDQo+ID4gICAjaW5jbHVkZSAiY2lmc19kZWJ1Zy5o
Ig0KPiA+ICsjaW5jbHVkZSAiY2lmc3Byb3RvLmgiDQo+ID4NCj4gPiAgIHN0YXRpYyBzdHJ1Y3Qg
c21iZF9yZXNwb25zZSAqZ2V0X2VtcHR5X3F1ZXVlX2J1ZmZlcigNCj4gPiAgIAkJc3RydWN0IHNt
YmRfY29ubmVjdGlvbiAqaW5mbyk7DQo+ID4gQEAgLTIwODIsNyArMjA4Myw3IEBAIGludCBzbWJk
X3NlbmQoc3RydWN0IHNtYmRfY29ubmVjdGlvbiAqaW5mbywNCj4gc3RydWN0IHNtYl9ycXN0ICpy
cXN0KQ0KPiA+ICAgCXN0cnVjdCBrdmVjIHZlYzsNCj4gPiAgIAlpbnQgbnZlY3M7DQo+ID4gICAJ
aW50IHNpemU7DQo+ID4gLQlpbnQgYnVmbGVuID0gMCwgcmVtYWluaW5nX2RhdGFfbGVuZ3RoOw0K
PiA+ICsJdW5zaWduZWQgaW50IGJ1ZmxlbiA9IDAsIHJlbWFpbmluZ19kYXRhX2xlbmd0aDsNCj4g
PiAgIAlpbnQgc3RhcnQsIGksIGo7DQo+ID4gICAJaW50IG1heF9pb3Zfc2l6ZSA9DQo+ID4gICAJ
CWluZm8tPm1heF9zZW5kX3NpemUgLSBzaXplb2Yoc3RydWN0IHNtYmRfZGF0YV90cmFuc2Zlcik7
DQo+IEBADQo+ID4gLTIxMTMsMTAgKzIxMTQsMTcgQEAgaW50IHNtYmRfc2VuZChzdHJ1Y3Qgc21i
ZF9jb25uZWN0aW9uICppbmZvLA0KPiBzdHJ1Y3Qgc21iX3Jxc3QgKnJxc3QpDQo+ID4gICAJCWJ1
ZmxlbiArPSBpb3ZbaV0uaW92X2xlbjsNCj4gPiAgIAl9DQo+ID4NCj4gPiAtCS8qIGFkZCBpbiB0
aGUgcGFnZSBhcnJheSBpZiB0aGVyZSBpcyBvbmUgKi8NCj4gPiArCS8qDQo+ID4gKwkgKiBBZGQg
aW4gdGhlIHBhZ2UgYXJyYXkgaWYgdGhlcmUgaXMgb25lLiBUaGUgY2FsbGVyIG5lZWRzIHRvIHNl
dA0KPiA+ICsJICogcnFfdGFpbHN6IHRvIFBBR0VfU0laRSB3aGVuIHRoZSBidWZmZXIgaGFzIG11
bHRpcGxlIHBhZ2VzIGFuZA0KPiA+ICsJICogZW5kcyBhdCBwYWdlIGJvdW5kYXJ5DQo+ID4gKwkg
Ki8NCj4gPiAgIAlpZiAocnFzdC0+cnFfbnBhZ2VzKSB7DQo+ID4gLQkJYnVmbGVuICs9IHJxc3Qt
PnJxX3BhZ2VzeiAqIChycXN0LT5ycV9ucGFnZXMgLSAxKTsNCj4gPiAtCQlidWZsZW4gKz0gcnFz
dC0+cnFfdGFpbHN6Ow0KPiA+ICsJCWlmIChycXN0LT5ycV9ucGFnZXMgPT0gMSkNCj4gPiArCQkJ
YnVmbGVuICs9IHJxc3QtPnJxX3RhaWxzejsNCj4gPiArCQllbHNlDQo+ID4gKwkJCWJ1ZmxlbiAr
PSBycXN0LT5ycV9wYWdlc3ogKiAocnFzdC0+cnFfbnBhZ2VzIC0gMSkgLQ0KPiA+ICsJCQkJCXJx
c3QtPnJxX29mZnNldCArIHJxc3QtPnJxX3RhaWxzejsNCj4gPiAgIAl9DQo+IA0KPiBUaGlzIGNv
ZGUgaXMgcmVhbGx5IGNvbmZ1c2luZyBhbmQgcmVkdW5kYW50LiBJdCB0ZXN0cyBucGFnZXMgPiAw
LCB0aGVuIHRlc3RzDQo+IG5wYWdlcyA9PSAxLCB0aGVuIGRvZXMgYW4gZWxzZS4gV2h5IG5vdCBj
YWxsIHRoZSBoZWxwZXIgbGlrZSB0aGUgZm9sbG93aW5nDQo+IHNtYmRfc2VuZCgpPw0KDQpUaGlz
IGNvZGUgbmVlZHMgdG8gZ2V0IHRoZSBjb21iaW5lZCBsZW5ndGggb2YgYWxsIHRoZSBwYWdlcyBp
biB0aGUgcmVxdWVzdCAoYnV0IGV4Y2x1ZGluZyBpb3YsIHRoaXMgaXMgZGlmZmVyZW50IHRvIHRo
ZSBmdW5jdGlvbiBycXN0X2xlbiBpbiBwYXRjaCAwNSksIGJ1dCB0aGUgZm9sbG93aW5nIGlzIGZv
ciBnZXR0aW5nIGEgc2luZ2xlIHBhZ2UgZnJvbSB0aGUgcmVxdWVzdC4gDQoNCkkgY2FuIHNpbXBs
aWZ5IHRoZSBjb2RlIGEgbGl0dGxlIGJpdCBieSBmb2xsb3dpbmcgeW91ciBzdWdnZXN0aW9uIGlu
IHBhdGNoIDA1Lg0KDQo+IA0KPiBUb20uDQo+IA0KPiA+DQo+ID4gICAJaWYgKGJ1ZmxlbiArIHNp
emVvZihzdHJ1Y3Qgc21iZF9kYXRhX3RyYW5zZmVyKSA+IEBAIC0yMjEzLDggKzIyMjEsOQ0KPiA+
IEBAIGludCBzbWJkX3NlbmQoc3RydWN0IHNtYmRfY29ubmVjdGlvbiAqaW5mbywgc3RydWN0IHNt
Yl9ycXN0ICpycXN0KQ0KPiA+DQo+ID4gICAJLyogbm93IHNlbmRpbmcgcGFnZXMgaWYgdGhlcmUg
YXJlIGFueSAqLw0KPiA+ICAgCWZvciAoaSA9IDA7IGkgPCBycXN0LT5ycV9ucGFnZXM7IGkrKykg
ew0KPiA+IC0JCWJ1ZmxlbiA9IChpID09IHJxc3QtPnJxX25wYWdlcy0xKSA/DQo+ID4gLQkJCXJx
c3QtPnJxX3RhaWxzeiA6IHJxc3QtPnJxX3BhZ2VzejsNCj4gPiArCQl1bnNpZ25lZCBpbnQgb2Zm
c2V0Ow0KPiA+ICsNCj4gPiArCQlycXN0X3BhZ2VfZ2V0X2xlbmd0aChycXN0LCBpLCAmYnVmbGVu
LCAmb2Zmc2V0KTsNCj4gPiAgIAkJbnZlY3MgPSAoYnVmbGVuICsgbWF4X2lvdl9zaXplIC0gMSkg
LyBtYXhfaW92X3NpemU7DQo+ID4gICAJCWxvZ193cml0ZShJTkZPLCAic2VuZGluZyBwYWdlcyBi
dWZsZW49JWQgbnZlY3M9JWRcbiIsDQo+ID4gICAJCQlidWZsZW4sIG52ZWNzKTsNCj4gPiBAQCAt
MjIyNSw5ICsyMjM0LDExIEBAIGludCBzbWJkX3NlbmQoc3RydWN0IHNtYmRfY29ubmVjdGlvbiAq
aW5mbywNCj4gc3RydWN0IHNtYl9ycXN0ICpycXN0KQ0KPiA+ICAgCQkJcmVtYWluaW5nX2RhdGFf
bGVuZ3RoIC09IHNpemU7DQo+ID4gICAJCQlsb2dfd3JpdGUoSU5GTywgInNlbmRpbmcgcGFnZXMg
aT0lZCBvZmZzZXQ9JWQNCj4gc2l6ZT0lZCINCj4gPiAgIAkJCQkiIHJlbWFpbmluZ19kYXRhX2xl
bmd0aD0lZFxuIiwNCj4gPiAtCQkJCWksIGoqbWF4X2lvdl9zaXplLCBzaXplLA0KPiByZW1haW5p
bmdfZGF0YV9sZW5ndGgpOw0KPiA+ICsJCQkJaSwgaiptYXhfaW92X3NpemUrb2Zmc2V0LCBzaXpl
LA0KPiA+ICsJCQkJcmVtYWluaW5nX2RhdGFfbGVuZ3RoKTsNCj4gPiAgIAkJCXJjID0gc21iZF9w
b3N0X3NlbmRfcGFnZSgNCj4gPiAtCQkJCWluZm8sIHJxc3QtPnJxX3BhZ2VzW2ldLCBqKm1heF9p
b3Zfc2l6ZSwNCj4gPiArCQkJCWluZm8sIHJxc3QtPnJxX3BhZ2VzW2ldLA0KPiA+ICsJCQkJaipt
YXhfaW92X3NpemUgKyBvZmZzZXQsDQo+ID4gICAJCQkJc2l6ZSwgcmVtYWluaW5nX2RhdGFfbGVu
Z3RoKTsNCj4gPiAgIAkJCWlmIChyYykNCj4gPiAgIAkJCQlnb3RvIGRvbmU7DQo+ID4NCg==
