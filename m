Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F93C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC5020700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="BM5+V8B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC5020700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbeKFDKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:10:34 -0500
Received: from mail-eopbgr720070.outbound.protection.outlook.com ([40.107.72.70]:13920
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387590AbeKFDKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBVIco+TjYRq5AxAdWazJX6kPZlNYx1taX78t+cXn7I=;
 b=BM5+V8B+XMvC+tjqfdBxSlko4mkcSuy3BdPFdDdK1Hl80DjNeb1+r2xdiRtagmDDmqYZ1UCjNw63UDD1KzhegSTGYjGZOq3yhi4bsFGDqfUKoUxSVqJwmrxoQmq6Femi1X7zEE3CJtKlXBYebaxsOsky7q6hryxoZ9U0nttYmxc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4677.namprd05.prod.outlook.com (52.135.233.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.14; Mon, 5 Nov 2018 17:49:43 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 17:49:43 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Thread-Topic: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Thread-Index: AQHUcwQ37jX8+phTpkyCnxi097WrnaVBPEeAgAA19QCAAAeVAA==
Date:   Mon, 5 Nov 2018 17:49:42 +0000
Message-ID: <4D260352-A9FF-47F2-B3B2-0A87DF16CB70@vmware.com>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-3-namit@vmware.com>
 <20181105140925.GD22467@hirez.programming.kicks-ass.net>
 <BB6FC627-C152-4C4C-A6D4-FA7F42F2610D@amacapital.net>
In-Reply-To: <BB6FC627-C152-4C4C-A6D4-FA7F42F2610D@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4677;20:VHjxQgR+hmrkACZNc6twioiMg5NyRR36Xbb8YWpuD8jbWpHo1Oj/5O8ESDg0v6fVlAnr7h2zJ1KQpY4dfaiv1zqJKl1afVfxo4pYLsZnXINSZv1Fws/4CEMyV0GRL8kFih0blK2k53L1vFRWaihrmuyoNtCRPAFZvdjtttiWurc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 87650e75-c1b9-43c1-e9d4-08d64347114a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4677;
x-ms-traffictypediagnostic: BYAPR05MB4677:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB4677385105925C2F5A92BDF3D0CA0@BYAPR05MB4677.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(192374486261705)(61668805478150)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4677;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4677;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(189003)(199004)(7416002)(4326008)(446003)(97736004)(33656002)(99286004)(6246003)(53546011)(68736007)(3846002)(478600001)(82746002)(86362001)(575784001)(6116002)(102836004)(53936002)(2900100001)(2616005)(71200400001)(476003)(25786009)(11346002)(2906002)(71190400001)(26005)(486006)(6486002)(83716004)(5660300001)(66066001)(229853002)(110136005)(186003)(106356001)(8936002)(256004)(316002)(105586002)(6436002)(54906003)(36756003)(7736002)(14454004)(81166006)(81156014)(8676002)(305945005)(76176011)(14444005)(6512007)(6506007)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4677;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ghXoMf3ww/9xqltsJr55Av1YuzEWv4miL6qDmrvOB/GENrD/GIx9bZsPPGKdgCENaOjeUoGngUvG/WRPN+rHTHrtr5frW1/1pFKOL+u0DoScN+E34ypa4zSUvGQgeiTxmq7k8jGh7BpelP3UdEdzy17YyYTBvZqSrMdiWS9VkrA1sn5sM2rlYJiPKcvegC8MSuPWvbFZ4DdoYOQet7k/JECre6ilJRcwjsZritLiDEON0mW2C8JQGZ2ETJK8xZIAui/IACHwJ0YKztiuam2oXEbFOus6xs21VCj12Jjhfg/+Gg09UYIx5Mz/c2S79T3PeGn71ZvbU3+xPs2NSp5GQKvDxJf9Gp3+VJtRASJQR00=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2BF2E3805D2B24A96E4E14538A5697C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87650e75-c1b9-43c1-e9d4-08d64347114a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 17:49:42.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4677
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQpTZW50OiBOb3ZlbWJlciA1LCAyMDE4IGF0IDU6MjI6MzIg
UE0gR01UDQo+IFRvOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+IENj
OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiwgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhh
dC5jb20+LCBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCB4ODZAa2VybmVsLm9yZywgSC4g
UGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+LCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRy
b25peC5kZT4sIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiwgRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4sIEFuZHkgTHV0b21pcnNraSA8bHV0b0BrZXJuZWwu
b3JnPiwgS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+LCBEYXZlIEhhbnNlbiA8ZGF2
ZS5oYW5zZW5AaW50ZWwuY29tPiwgTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9y
Zz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzddIHg4Ni9qdW1wX2xhYmVsOiBVc2UgdGV4
dF9wb2tlX2Vhcmx5KCkgZHVyaW5nIGVhcmx5X2luaXQNCj4gDQo+IA0KPiANCj4+IE9uIE5vdiA1
LCAyMDE4LCBhdCA2OjA5IEFNLCBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
IHdyb3RlOg0KPj4gDQo+Pj4gT24gRnJpLCBOb3YgMDIsIDIwMTggYXQgMDQ6Mjk6NDFQTSAtMDcw
MCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2p1
bXBfbGFiZWwuYyBiL2FyY2gveDg2L2tlcm5lbC9qdW1wX2xhYmVsLmMNCj4+PiBpbmRleCBhYWMw
YzFmN2UzNTQuLjM2N2MxZDBjMjBhMyAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwv
anVtcF9sYWJlbC5jDQo+Pj4gKysrIGIvYXJjaC94ODYva2VybmVsL2p1bXBfbGFiZWwuYw0KPj4+
IEBAIC01Miw3ICs1MiwxMyBAQCBzdGF0aWMgdm9pZCBfX3JlZiBfX2p1bXBfbGFiZWxfdHJhbnNm
b3JtKHN0cnVjdCBqdW1wX2VudHJ5ICplbnRyeSwNCj4+PiAgIGptcC5vZmZzZXQgPSBqdW1wX2Vu
dHJ5X3RhcmdldChlbnRyeSkgLQ0KPj4+ICAgICAgICAgICAgKGp1bXBfZW50cnlfY29kZShlbnRy
eSkgKyBKVU1QX0xBQkVMX05PUF9TSVpFKTsNCj4+PiANCj4+PiAtICAgIGlmIChlYXJseV9ib290
X2lycXNfZGlzYWJsZWQpDQo+Pj4gKyAgICAvKg0KPj4+ICsgICAgICogQXMgbG9uZyBhcyB3ZSBh
cmUgaW4gZWFybHkgYm9vdCwgd2UgY2FuIHVzZSB0ZXh0X3Bva2VfZWFybHkoKSwgd2hpY2gNCj4+
PiArICAgICAqIGlzIG1vcmUgZWZmaWNpZW50OiB0aGUgbWVtb3J5IHdhcyBzdGlsbCBub3QgbWFy
a2VkIGFzIHJlYWQtb25seSAoaXQNCj4+PiArICAgICAqIGlzIG9ubHkgbWFya2VkIGFmdGVyIHBv
a2luZ19pbml0KCkpLiBUaGlzIGFsc28gcHJldmVudHMgdXMgZnJvbSB1c2luZw0KPj4+ICsgICAg
ICogdGV4dF9wb2tlKCkgYmVmb3JlIHBva2luZ19pbml0KCkgaXMgY2FsbGVkLg0KPj4+ICsgICAg
ICovDQo+Pj4gKyAgICBpZiAoIWVhcmx5X2Jvb3RfZG9uZSkNCj4+PiAgICAgICBwb2tlciA9IHRl
eHRfcG9rZV9lYXJseTsNCj4+PiANCj4+PiAgIGlmICh0eXBlID09IEpVTVBfTEFCRUxfSk1QKSB7
DQo+PiANCj4+IEl0IHRvb2sgbWUgYSB3aGlsZSB0byB1bnRhbmdsZSBpbml0L21hemVeSF5IaW4u
Yy4uLiBidXQgSSB0aGluayB0aGlzDQo+PiBpcyBhbGwgd2UgbmVlZDoNCj4+IA0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gveDg2L2tlcm5lbC9qdW1wX2xhYmVsLmMgYi9hcmNoL3g4Ni9rZXJuZWwvanVt
cF9sYWJlbC5jDQo+PiBpbmRleCBhYWMwYzFmN2UzNTQuLmVkNWZlMjc0YTdkOCAxMDA2NDQNCj4+
IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9qdW1wX2xhYmVsLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9qdW1wX2xhYmVsLmMNCj4+IEBAIC01Miw3ICs1MiwxMiBAQCBzdGF0aWMgdm9pZCBfX3Jl
ZiBfX2p1bXBfbGFiZWxfdHJhbnNmb3JtKHN0cnVjdCBqdW1wX2VudHJ5ICplbnRyeSwNCj4+ICAg
am1wLm9mZnNldCA9IGp1bXBfZW50cnlfdGFyZ2V0KGVudHJ5KSAtDQo+PiAgICAgICAgICAgIChq
dW1wX2VudHJ5X2NvZGUoZW50cnkpICsgSlVNUF9MQUJFTF9OT1BfU0laRSk7DQo+PiANCj4+IC0g
ICAgaWYgKGVhcmx5X2Jvb3RfaXJxc19kaXNhYmxlZCkNCj4+ICsgICAgLyoNCj4+ICsgICAgICog
QXMgbG9uZyBhcyB3ZSdyZSBVUCBhbmQgbm90IHlldCBtYXJrZWQgUk8sIHdlIGNhbiB1c2UNCj4+
ICsgICAgICogdGV4dF9wb2tlX2Vhcmx5OyBTWVNURU1fQk9PVElORyBndWFyYW50ZWVzIGJvdGgs
IGFzIHdlIHN3aXRjaCB0bw0KPj4gKyAgICAgKiBTWVNURU1fU0NIRURVTElORyBiZWZvcmUgZ29p
bmcgZWl0aGVyLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgaWYgKHN5c3RlbV9zdGF0ZSA9PSBTWVNU
RU1fQk9PVElORykNCj4+ICAgICAgIHBva2VyID0gdGV4dF9wb2tlX2Vhcmx5Ow0KPj4gDQo+PiAg
IGlmICh0eXBlID09IEpVTVBfTEFCRUxfSk1QKSB7DQo+IA0KPiBDYW4gd2UgbW92ZSB0aGlzIGxv
Z2ljIGludG8gdGV4dF9wb2tlKCkgYW5kIGdldCByaWQgb2YgdGV4dF9wb2tlX2Vhcmx5KCk/DQoN
ClRoaXMgd2lsbCBuZWdhdGl2ZWx5IGFmZmVjdCBwb2tpbmcgb2YgbW9kdWxlcyBkb2luZyBtb2R1
bGUgbG9hZGluZywgZS5nLiwNCmFwcGx5X3BhcmF2aXJ0KCkuIFRoaXMgY2FuIGJlIHJlc29sdmVk
IGJ5IGtlZXBpbmcgdHJhY2sgd2hlbiB0aGUgbW9kdWxlIGlzDQp3cml0ZS1wcm90ZWN0ZWQgYW5k
IGdpdmluZyBhIG1vZHVsZSBwYXJhbWV0ZXIgdG8gdGV4dF9wb2tlKCkuIERvZXMgaXQgd29ydGgN
CnRoZSBjb21wbGV4aXR5Pw0KDQo+IEZXSVcsIGFsdGVybmF0aXZlIHBhdGNoaW5nIHdhcywgYXQg
c29tZSBwb2ludCwgYSBzaWduaWZpY2FudCBmcmFjdGlvbiBvZg0KPiB0b3RhbCBib290IHRpbWUg
aW4gc29tZSBjYXNlcy4gVGhpcyB3YXMgcHJvYmFibHkgbW9zdGx5IGR1ZSB0byB1bm5lY2Vzc2Fy
eQ0KPiBzeW5jX2NvcmUoKSBjYWxscy4gQWx0aG91Z2ggSSB0aGluayB0aGlzIHdhcyByZXBvcnRl
ZCBvbiBhIFZNLCBhbmQNCj4gc3luY19jb3JlKCkgdXNlZCB0byBiZSAqZXh0cmVtZWx5KiBleHBl
bnNpdmUgb24gYSBWTSwgYnV0IHRoYXTigJlzIGZpeGVkDQo+IG5vdywgYW5kIGl0IGV2ZW4gZ290
IGJhY2twb3J0ZWQsIEkgdGhpbmsuDQo+IA0KPiAoSG1tLiBNYXliZSB3ZSBjYW4gYWxzbyBtYWtl
IGp1bXAgbGFiZWwgcGF0Y2hpbmcgd29yayBpbiBlYXJseSBib290LCB0b28hKQ0KDQpJdCBtYXkg
YmUgcG9zc2libGUgdG8gcmVzb2x2ZSB0aGUgZGVwZW5kZW5jaWVzIGJldHdlZW4gcG9raW5nX2lu
aXQoKSBhbmQgdGhlDQpvdGhlciAqX2luaXQoKS4gSSBmaXJzdCBjb25zaWRlcmVkIGRvaW5nIHRo
YXQsIHlldCwgaXQgbWFrZXMgdGhlIGNvZGUgdmVyeQ0KZnJhZ2lsZSwgYW5kIEkgZG9u4oCZdCBz
ZWUgdGhlIHZhbHVlIGluIGdldHRpbmcgcmlkIG9mIHRleHRfcG9rZV9lYXJseSgpIGZyb20NCnNl
Y3VyaXR5IG9yIHNpbXBsaWNpdHkgcG9pbnQgb2Ygdmlld3MuIExldCBtZSBrbm93IGlmIHlvdSB0
aGluayBvdGhlcndpc2UuDQoNClJlZ2FyZHMsDQpOYWRhdg==
