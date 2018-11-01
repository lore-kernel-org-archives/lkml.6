Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02B1C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494A82064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="AZfSEUaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494A82064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeKBBiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:38:08 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:50544
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728175AbeKBBiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLs84lNRKQGmFXAphgdSH7ka5T/X2ws3DeA+9FV6Buw=;
 b=AZfSEUaFP4VekvzZcvn++WtiQ06u4mI3YhriU1JVnG/AuG43SRU+OcjlvAknw3FJwTLFWCBPIrFHQd2sO1O5JwPxuk13SRcBFCAYUZEACEbx9C6J/RMn8Zz0wn1W7OOIOURybijTYqpFIW2Mn6HmyFvKwTqlXLlmgEvzpw4KlaA=
Received: from AM6PR08MB3094.eurprd08.prod.outlook.com (52.135.163.155) by
 AM6PR08MB3448.eurprd08.prod.outlook.com (20.177.113.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Thu, 1 Nov 2018 16:34:21 +0000
Received: from AM6PR08MB3094.eurprd08.prod.outlook.com
 ([fe80::a0d2:aa1a:736d:9ef8]) by AM6PR08MB3094.eurprd08.prod.outlook.com
 ([fe80::a0d2:aa1a:736d:9ef8%7]) with mapi id 15.20.1294.024; Thu, 1 Nov 2018
 16:34:21 +0000
From:   Robin Murphy <Robin.Murphy@arm.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     "youlin.pei@mediatek.com" <youlin.pei@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "yingjoe.chen@mediatek.com" <yingjoe.chen@mediatek.com>,
        Daniel Kurtz <djkurtz@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>
Subject: Re: [PATCH v2 04/14] iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and
 iopte_to_paddr helpers
Thread-Topic: [PATCH v2 04/14] iommu/io-pgtable-arm-v7s: Add paddr_to_iopte
 and iopte_to_paddr helpers
Thread-Index: AQHUcgC9Tl+CFYdGwkeiyRp2PH2wmQ==
Date:   Thu, 1 Nov 2018 16:34:21 +0000
Message-ID: <d24bd2a4-1030-e255-b339-d02eadc93f28@arm.com>
References: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
 <1537779534-23575-5-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1537779534-23575-5-git-send-email-yong.wu@mediatek.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::33) To AM6PR08MB3094.eurprd08.prod.outlook.com
 (2603:10a6:209:45::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Robin.Murphy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB3448;6:UeLe4euJMTEsKFsqkZCqQ9ZAxZqRysVNc7v0aeamQ+3r6Zw+8RC6rTVYQ+61fydwnc+z4mvSEXKCVGZke1eBHZ2wpqg1czF9mJs192q5MIYYX2IB1LYAat73i7fC6ijkkKV1jCtNfajSwjWKbi2GFZwV39V0tOBxpZ2jpPhKpq88zmPU6FIK1xY7AVPViv8xFsHK5vY2PVFGcUfaJRFNJ04G5ncOBdKmbymrSlTWGgX8RX4/Djp1XflNd9XK5aQdojtX4NTIaPogFAFj9LtZapG6tI34UUlSXKWmXibLLWlB6VtpeSTHSOi3E+q71uO9lPq/tOkdQSEtmbnesFmki+xj1hiiPvbpFkmIq3GFBEB6EUs3h+riF8s6RWLYnY9nJleEM0tKCZ/N9RVDMkg/VTzMtZL5/EzD2fv+KPf8CdwK2tkDMPx6/MsESil5hLWIhNVd5vUDte3xPRLP+LLxmA==;5:jwXpCkp3MIFwITal/b6uNbLwgzjGvDhjzVUTnv0xoSiPnmzqs5cdRq+XNl/3Wy1nhFzSBsOLjNT4n0xJaWVMJwZqk4jXBTCSrm9iG7vYzdZpgKEbuh6HphrfnRHv+5VQN+JMDvpkRorjyruP6A1LccDA3SI7zi1DPXZdSYzdP8U=;7:zrlWL+PLX9IIIseDs1+k6y4LAkpXH3CQMU565F19ApVPWaq5UV2rc6wDbYF8GptMe/maY2aFdGr18X8W4Bh28h0M5C4XbfRM1nXBlGthGqI663t2vyvcfiF9LdnYhckomVCXFG7kzf5drUY/wC8iIA==
x-ms-office365-filtering-correlation-id: 8851f23c-d254-4a98-cfc0-08d64017e044
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3448;
x-ms-traffictypediagnostic: AM6PR08MB3448:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB3448C57FDF29C5FCE9BB4F1496CE0@AM6PR08MB3448.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR08MB3448;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3448;
x-forefront-prvs: 0843C17679
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(51444003)(189003)(199004)(6512007)(53936002)(11346002)(26005)(186003)(305945005)(446003)(97736004)(486006)(7416002)(4326008)(25786009)(256004)(65826007)(14444005)(7736002)(64126003)(86362001)(31686004)(6486002)(3846002)(39060400002)(65806001)(6116002)(65956001)(6436002)(66066001)(5250100002)(31696002)(36756003)(2906002)(44832011)(229853002)(76176011)(5660300001)(8936002)(6506007)(14454004)(106356001)(478600001)(81166006)(53546011)(105586002)(52116002)(386003)(2900100001)(54906003)(316002)(71190400001)(2616005)(68736007)(58126008)(8676002)(99286004)(476003)(6246003)(110136005)(81156014)(71200400001)(72206003)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3448;H:AM6PR08MB3094.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: FjF8gV6CIBBd8E6/iK/Z4b5u2dVBlWub2ExGDiMkl5MMJKPjdVcLyOcQaf9cgw/weHk9srxMsbSIrHYt3SOMoMVG0RRumajhN/XtXzd4klDP9CeNs50BdU81dGZgoWgdnIG506B7DtejTj9yOpRnTXqL9UgkQhhsVk5qKPcUwQiKUGSGYjTiPZYWYz3lN4z04YvqnDWwetu6fmzvwiXHqQY/SJSctc7CR6JjMr36D0M7tTjAxjeALJvqNpZBnV86RfcjqZMJ1M9PJ3EqOLlUt8E/KmEPyPeaPuADw7xwX6pjKeMXq28FecBxX981+8zwrdp4AIIkJs33/SNUt16XNYMZGaDBFLqkKQNC34l7xeg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DDAA7D9DB79C44FB3F9453451D57CBC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8851f23c-d254-4a98-cfc0-08d64017e044
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2018 16:34:21.3177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WyBhcG9sb2dpZXMgaWYgYW55b25lIGdldHMgdGhpcyB0d2ljZSwgbG9va3MgbGlrZSBvdXIgZW1h
aWwncyBlYXRlbiANCml0c2VsZiBhZ2Fpbi4uLiBdDQoNCk9uIDI0LzA5LzIwMTggMDk6NTgsIFlv
bmcgV3Ugd3JvdGU6DQo+IEFkZCB0d28gaGVscGVyIGZ1bmN0aW9uczogcGFkZHJfdG9faW9wdGUg
YW5kIGlvcHRlX3RvX3BhZGRyLg0KDQpOaWNlIGFuZCB0aWR5ISAoYWx0aG91Z2ggaXQgd2lsbCBu
ZWVkIHJlYmFzaW5nIG5vdywgYnV0IEkgdGhpbmsgdGhhdCdzIA0KanVzdCBjb250ZXh0IGNvbmZs
aWN0cykNCg0KPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4N
Cj4gLS0tDQo+ICAgZHJpdmVycy9pb21tdS9pby1wZ3RhYmxlLWFybS12N3MuYyB8IDQ1ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMz
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUt
YXJtLXY3cy5jDQo+IGluZGV4IGI1OTQ4YmEuLmZhM2I5ZWMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9pby1w
Z3RhYmxlLWFybS12N3MuYw0KPiBAQCAtMTczLDE4ICsxNzMsMzggQEAgc3RydWN0IGFybV92N3Nf
aW9fcGd0YWJsZSB7DQo+ICAgCXNwaW5sb2NrX3QJCXNwbGl0X2xvY2s7DQo+ICAgfTsNCj4gICAN
Cj4gK3N0YXRpYyBib29sIGFybV92N3NfcHRlX2lzX2NvbnQoYXJtX3Y3c19pb3B0ZSBwdGUsIGlu
dCBsdmwpOw0KPiArDQo+ICAgc3RhdGljIGRtYV9hZGRyX3QgX19hcm1fdjdzX2RtYV9hZGRyKHZv
aWQgKnBhZ2VzKQ0KPiAgIHsNCj4gICAJcmV0dXJuIChkbWFfYWRkcl90KXZpcnRfdG9fcGh5cyhw
YWdlcyk7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGFybV92N3NfaW9wdGUgKmlvcHRlX2RlcmVm
KGFybV92N3NfaW9wdGUgcHRlLCBpbnQgbHZsKQ0KPiArc3RhdGljIGFybV92N3NfaW9wdGUgcGFk
ZHJfdG9faW9wdGUocGh5c19hZGRyX3QgcGFkZHIsIGludCBsdmwsDQo+ICsJCQkJICAgIHN0cnVj
dCBhcm1fdjdzX2lvX3BndGFibGUgKmRhdGEpDQoNCk5pdDogaXQgc2VlbXMgdG8gd29yayBvdXQg
YSBsaXR0bGUgY2xlYW5lciBpZiB3ZSBwYXNzIHRoZSBpb19wZ3RhYmxlX2NmZyANCnRvIHRoZXNl
IGhlbHBlcnMgZGlyZWN0bHksIHJhdGhlciB0aGFuIHJlLWRlcml2aW5nIGl0IGZyb20gZGF0YSBl
YWNoIHRpbWUuDQoNCk90aGVyd2lzZSwgdGhvdWdoLA0KDQpSZXZpZXdlZC1ieTogUm9iaW4gTXVy
cGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCg0KPiAgIHsNCj4gKwlyZXR1cm4gcGFkZHIgJiBB
Uk1fVjdTX0xWTF9NQVNLKGx2bCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBwaHlzX2FkZHJfdCBp
b3B0ZV90b19wYWRkcihhcm1fdjdzX2lvcHRlIHB0ZSwgaW50IGx2bCwNCj4gKwkJCQkgIHN0cnVj
dCBhcm1fdjdzX2lvX3BndGFibGUgKmRhdGEpDQo+ICt7DQo+ICsJYXJtX3Y3c19pb3B0ZSBtYXNr
Ow0KPiArDQo+ICAgCWlmIChBUk1fVjdTX1BURV9JU19UQUJMRShwdGUsIGx2bCkpDQo+IC0JCXB0
ZSAmPSBBUk1fVjdTX1RBQkxFX01BU0s7DQo+ICsJCW1hc2sgPSBBUk1fVjdTX1RBQkxFX01BU0s7
DQo+ICsJZWxzZSBpZiAoYXJtX3Y3c19wdGVfaXNfY29udChwdGUsIGx2bCkpDQo+ICsJCW1hc2sg
PSBBUk1fVjdTX0xWTF9NQVNLKGx2bCkgKiBBUk1fVjdTX0NPTlRfUEFHRVM7DQo+ICAgCWVsc2UN
Cj4gLQkJcHRlICY9IEFSTV9WN1NfTFZMX01BU0sobHZsKTsNCj4gLQlyZXR1cm4gcGh5c190b192
aXJ0KHB0ZSk7DQo+ICsJCW1hc2sgPSBBUk1fVjdTX0xWTF9NQVNLKGx2bCk7DQo+ICsNCj4gKwly
ZXR1cm4gcHRlICYgbWFzazsNCj4gK30NCj4gKw0KPiArc3RhdGljIGFybV92N3NfaW9wdGUgKmlv
cHRlX2RlcmVmKGFybV92N3NfaW9wdGUgcHRlLCBpbnQgbHZsLA0KPiArCQkJCSAgc3RydWN0IGFy
bV92N3NfaW9fcGd0YWJsZSAqZGF0YSkNCj4gK3sNCj4gKwlyZXR1cm4gcGh5c190b192aXJ0KGlv
cHRlX3RvX3BhZGRyKHB0ZSwgbHZsLCBkYXRhKSk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyB2
b2lkICpfX2FybV92N3NfYWxsb2NfdGFibGUoaW50IGx2bCwgZ2ZwX3QgZ2ZwLA0KPiBAQCAtMzk2
LDcgKzQxNiw3IEBAIHN0YXRpYyBpbnQgYXJtX3Y3c19pbml0X3B0ZShzdHJ1Y3QgYXJtX3Y3c19p
b19wZ3RhYmxlICpkYXRhLA0KPiAgIAlpZiAobnVtX2VudHJpZXMgPiAxKQ0KPiAgIAkJcHRlID0g
YXJtX3Y3c19wdGVfdG9fY29udChwdGUsIGx2bCk7DQo+ICAgDQo+IC0JcHRlIHw9IHBhZGRyICYg
QVJNX1Y3U19MVkxfTUFTSyhsdmwpOw0KPiArCXB0ZSB8PSBwYWRkcl90b19pb3B0ZShwYWRkciwg
bHZsLCBkYXRhKTsNCj4gICANCj4gICAJX19hcm1fdjdzX3NldF9wdGUocHRlcCwgcHRlLCBudW1f
ZW50cmllcywgY2ZnKTsNCj4gICAJcmV0dXJuIDA7DQo+IEBAIC00NjIsNyArNDgyLDcgQEAgc3Rh
dGljIGludCBfX2FybV92N3NfbWFwKHN0cnVjdCBhcm1fdjdzX2lvX3BndGFibGUgKmRhdGEsIHVu
c2lnbmVkIGxvbmcgaW92YSwNCj4gICAJfQ0KPiAgIA0KPiAgIAlpZiAoQVJNX1Y3U19QVEVfSVNf
VEFCTEUocHRlLCBsdmwpKSB7DQo+IC0JCWNwdGVwID0gaW9wdGVfZGVyZWYocHRlLCBsdmwpOw0K
PiArCQljcHRlcCA9IGlvcHRlX2RlcmVmKHB0ZSwgbHZsLCBkYXRhKTsNCj4gICAJfSBlbHNlIGlm
IChwdGUpIHsNCj4gICAJCS8qIFdlIHJlcXVpcmUgYW4gdW5tYXAgZmlyc3QgKi8NCj4gICAJCVdB
Uk5fT04oIXNlbGZ0ZXN0X3J1bm5pbmcpOw0KPiBAQCAtNTEyLDcgKzUzMiw4IEBAIHN0YXRpYyB2
b2lkIGFybV92N3NfZnJlZV9wZ3RhYmxlKHN0cnVjdCBpb19wZ3RhYmxlICppb3ApDQo+ICAgCQlh
cm1fdjdzX2lvcHRlIHB0ZSA9IGRhdGEtPnBnZFtpXTsNCj4gICANCj4gICAJCWlmIChBUk1fVjdT
X1BURV9JU19UQUJMRShwdGUsIDEpKQ0KPiAtCQkJX19hcm1fdjdzX2ZyZWVfdGFibGUoaW9wdGVf
ZGVyZWYocHRlLCAxKSwgMiwgZGF0YSk7DQo+ICsJCQlfX2FybV92N3NfZnJlZV90YWJsZShpb3B0
ZV9kZXJlZihwdGUsIDEsIGRhdGEpLA0KPiArCQkJCQkgICAgIDIsIGRhdGEpOw0KPiAgIAl9DQo+
ICAgCV9fYXJtX3Y3c19mcmVlX3RhYmxlKGRhdGEtPnBnZCwgMSwgZGF0YSk7DQo+ICAgCWttZW1f
Y2FjaGVfZGVzdHJveShkYXRhLT5sMl90YWJsZXMpOw0KPiBAQCAtNTgyLDcgKzYwMyw3IEBAIHN0
YXRpYyBzaXplX3QgYXJtX3Y3c19zcGxpdF9ibGtfdW5tYXAoc3RydWN0IGFybV92N3NfaW9fcGd0
YWJsZSAqZGF0YSwNCj4gICAJCWlmICghQVJNX1Y3U19QVEVfSVNfVEFCTEUocHRlLCAxKSkNCj4g
ICAJCQlyZXR1cm4gMDsNCj4gICANCj4gLQkJdGFibGVwID0gaW9wdGVfZGVyZWYocHRlLCAxKTsN
Cj4gKwkJdGFibGVwID0gaW9wdGVfZGVyZWYocHRlLCAxLCBkYXRhKTsNCj4gICAJCXJldHVybiBf
X2FybV92N3NfdW5tYXAoZGF0YSwgaW92YSwgc2l6ZSwgMiwgdGFibGVwKTsNCj4gICAJfQ0KPiAg
IA0KPiBAQCAtNjQwLDcgKzY2MSw3IEBAIHN0YXRpYyBzaXplX3QgX19hcm1fdjdzX3VubWFwKHN0
cnVjdCBhcm1fdjdzX2lvX3BndGFibGUgKmRhdGEsDQo+ICAgCQkJCWlvX3BndGFibGVfdGxiX2Fk
ZF9mbHVzaChpb3AsIGlvdmEsIGJsa19zaXplLA0KPiAgIAkJCQkJQVJNX1Y3U19CTE9DS19TSVpF
KGx2bCArIDEpLCBmYWxzZSk7DQo+ICAgCQkJCWlvX3BndGFibGVfdGxiX3N5bmMoaW9wKTsNCj4g
LQkJCQlwdGVwID0gaW9wdGVfZGVyZWYocHRlW2ldLCBsdmwpOw0KPiArCQkJCXB0ZXAgPSBpb3B0
ZV9kZXJlZihwdGVbaV0sIGx2bCwgZGF0YSk7DQo+ICAgCQkJCV9fYXJtX3Y3c19mcmVlX3RhYmxl
KHB0ZXAsIGx2bCArIDEsIGRhdGEpOw0KPiAgIAkJCX0gZWxzZSB7DQo+ICAgCQkJCWlvX3BndGFi
bGVfdGxiX2FkZF9mbHVzaChpb3AsIGlvdmEsIGJsa19zaXplLA0KPiBAQCAtNjU4LDcgKzY3OSw3
IEBAIHN0YXRpYyBzaXplX3QgX19hcm1fdjdzX3VubWFwKHN0cnVjdCBhcm1fdjdzX2lvX3BndGFi
bGUgKmRhdGEsDQo+ICAgCX0NCj4gICANCj4gICAJLyogS2VlcCBvbiB3YWxraW4nICovDQo+IC0J
cHRlcCA9IGlvcHRlX2RlcmVmKHB0ZVswXSwgbHZsKTsNCj4gKwlwdGVwID0gaW9wdGVfZGVyZWYo
cHRlWzBdLCBsdmwsIGRhdGEpOw0KPiAgIAlyZXR1cm4gX19hcm1fdjdzX3VubWFwKGRhdGEsIGlv
dmEsIHNpemUsIGx2bCArIDEsIHB0ZXApOw0KPiAgIH0NCj4gICANCj4gQEAgLTY4NCw3ICs3MDUs
NyBAQCBzdGF0aWMgcGh5c19hZGRyX3QgYXJtX3Y3c19pb3ZhX3RvX3BoeXMoc3RydWN0IGlvX3Bn
dGFibGVfb3BzICpvcHMsDQo+ICAgCWRvIHsNCj4gICAJCXB0ZXAgKz0gQVJNX1Y3U19MVkxfSURY
KGlvdmEsICsrbHZsKTsNCj4gICAJCXB0ZSA9IFJFQURfT05DRSgqcHRlcCk7DQo+IC0JCXB0ZXAg
PSBpb3B0ZV9kZXJlZihwdGUsIGx2bCk7DQo+ICsJCXB0ZXAgPSBpb3B0ZV9kZXJlZihwdGUsIGx2
bCwgZGF0YSk7DQo+ICAgCX0gd2hpbGUgKEFSTV9WN1NfUFRFX0lTX1RBQkxFKHB0ZSwgbHZsKSk7
DQo+ICAgDQo+ICAgCWlmICghQVJNX1Y3U19QVEVfSVNfVkFMSUQocHRlKSkNCj4gQEAgLTY5Myw3
ICs3MTQsNyBAQCBzdGF0aWMgcGh5c19hZGRyX3QgYXJtX3Y3c19pb3ZhX3RvX3BoeXMoc3RydWN0
IGlvX3BndGFibGVfb3BzICpvcHMsDQo+ICAgCW1hc2sgPSBBUk1fVjdTX0xWTF9NQVNLKGx2bCk7
DQo+ICAgCWlmIChhcm1fdjdzX3B0ZV9pc19jb250KHB0ZSwgbHZsKSkNCj4gICAJCW1hc2sgKj0g
QVJNX1Y3U19DT05UX1BBR0VTOw0KPiAtCXJldHVybiAocHRlICYgbWFzaykgfCAoaW92YSAmIH5t
YXNrKTsNCj4gKwlyZXR1cm4gaW9wdGVfdG9fcGFkZHIocHRlLCBsdmwsIGRhdGEpIHwgKGlvdmEg
JiB+bWFzayk7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBzdHJ1Y3QgaW9fcGd0YWJsZSAqYXJt
X3Y3c19hbGxvY19wZ3RhYmxlKHN0cnVjdCBpb19wZ3RhYmxlX2NmZyAqY2ZnLA0KPiANCg==
