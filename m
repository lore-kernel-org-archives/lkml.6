Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3190C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E87D26165
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ANoZapLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E87D26165
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754980AbeFYVOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:14:37 -0400
Received: from mail-eopbgr690107.outbound.protection.outlook.com ([40.107.69.107]:43345
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751970AbeFYVOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbYO9mCTT6+g8IGbUK+YD0tb6V6xmXeCSKAQiMn/b7w=;
 b=ANoZapLeyoT/zsRXy5CASqGbfMZ7hqrZD+kObv0Kw3s0I6UB8FU53LKjayhXV9uEObSkQU3+l1fwgmTkW1N5fMfdJ5dYDIXxUHLvMC3aW0t2WFhEzNrpOJIxZatZpbGt/39F4EaqDuCdeoERZ/F7Rg4tZNcL0eOkFLoZQDlI5O8=
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com (52.132.100.10) by
 CY4PR2101MB0866.namprd21.prod.outlook.com (52.132.101.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.5; Mon, 25 Jun 2018 21:14:31 +0000
Received: from CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7]) by CY4PR2101MB0722.namprd21.prod.outlook.com
 ([fe80::a849:9c0c:337b:2ee7%5]) with mapi id 15.20.0930.005; Mon, 25 Jun 2018
 21:14:31 +0000
From:   Long Li <longli@microsoft.com>
To:     Tom Talpey <tom@talpey.com>, Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [Patch v2 06/15] CIFS: Introduce helper function to get page
 offset and length in smb_rqst
Thread-Topic: [Patch v2 06/15] CIFS: Introduce helper function to get page
 offset and length in smb_rqst
Thread-Index: AQHT+E9iEw5xkPQo+UyOlJNsNS6C6qRu0BMAgALQeXA=
Date:   Mon, 25 Jun 2018 21:14:31 +0000
Message-ID: <CY4PR2101MB0722840106EDFEFBBA42D45FCE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-7-longli@linuxonhyperv.com>
 <a6613388-0dc5-7646-b71f-75b8bec4e4d9@talpey.com>
In-Reply-To: <a6613388-0dc5-7646-b71f-75b8bec4e4d9@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:a:fdde:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR2101MB0866;7:WpT0aITKsxapnJ/1yRAdfqUovks6+pe4xQU0QQq20XcENb/RtDuuzY1/O4dzzJwZZMOAUQiohbM2ttpF+wUnG317melTPFY2quV4agk1Z2UwAt/OVD+VN0z/30woh3sRp2+eDBJC46SaRR2V5FTwW3+PHus6A++96/3WjyIjK3AHbTbT6Vdsk5DU2kulPBapBtco/k2WEhed/WIU+quKInXepDFtAflhWKx2fgOOPoAq8ADOgSNtJNlxBpktQLR4
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a5e0b0f1-272c-4ace-3b6c-08d5dae0a50e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:CY4PR2101MB0866;
x-ms-traffictypediagnostic: CY4PR2101MB0866:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR2101MB0866FCD43FDE5972178778F8CE4A0@CY4PR2101MB0866.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR2101MB0866;BCL:0;PCL:0;RULEID:;SRVR:CY4PR2101MB0866;
x-forefront-prvs: 0714841678
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(229853002)(10290500003)(55016002)(33656002)(106356001)(105586002)(6436002)(9686003)(2900100001)(2501003)(5250100002)(14454004)(110136005)(478600001)(22452003)(316002)(6116002)(476003)(486006)(102836004)(11346002)(46003)(99286004)(186003)(446003)(76176011)(8676002)(86612001)(305945005)(7736002)(81166006)(74316002)(6506007)(81156014)(7696005)(97736004)(68736007)(25786009)(86362001)(10090500001)(8936002)(53936002)(2201001)(5660300001)(6246003)(2906002)(8990500004)(53546011)(14444005)(256004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2101MB0866;H:CY4PR2101MB0722.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DPq3qCZAHZtyEBfDIbN68MgjoVMpbod4oDZtVFEQTpV30o8XCfu3KqQCmq9BcaD4ni0Uy46wzon8ncSsQOeEDaVeMcg2eokpEjbTWLjLp497ink/8cItjEeBe3HmHq7iHNffC6oMTtHReNfC+GIfVJXQPTv9FFf5hd1vsNLOxGtt4gfkjIIyP0L/U9oprzbQ8fyF1XFR39Dtb3KZp/kCKAPIH+8pBuoHp2KiENHkbo+x/oErVkz3MRK3z4IkFuhEXJFXpNLE8mFM8nJAbnDTtOWY0NqSTJOTOHde4o5Rcd7bMBdglaDJViYoaYUmMQ6OKtOZsFV+k9uXCcAcOGXANfjuvNCUkD6ZoO0YFqZqj7o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e0b0f1-272c-4ace-3b6c-08d5dae0a50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2018 21:14:31.8089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2101MB0866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDA2LzE1XSBDSUZTOiBJbnRyb2R1Y2UgaGVscGVyIGZ1
bmN0aW9uIHRvIGdldCBwYWdlDQo+IG9mZnNldCBhbmQgbGVuZ3RoIGluIHNtYl9ycXN0DQo+IA0K
PiBPbiA1LzMwLzIwMTggMzo0NyBQTSwgTG9uZyBMaSB3cm90ZToNCj4gPiBGcm9tOiBMb25nIExp
IDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPg0KPiA+IEludHJvZHVjZSBhIGZ1bmN0aW9uIHJx
c3RfcGFnZV9nZXRfbGVuZ3RoIHRvIHJldHVybiB0aGUgcGFnZSBvZmZzZXQNCj4gPiBhbmQgbGVu
Z3RoIGZvciBhIGdpdmVuIHBhZ2UgaW4gc21iX3Jxc3QuIFRoaXMgZnVuY3Rpb24gaXMgdG8gYmUg
dXNlZA0KPiA+IGJ5IGZvbGxvd2luZyBwYXRjaGVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TG9uZyBMaSA8bG9uZ2xpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4gICBmcy9jaWZzL2Np
ZnNwcm90by5oIHwgIDMgKysrDQo+ID4gICBmcy9jaWZzL21pc2MuYyAgICAgIHwgMTcgKysrKysr
KysrKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc3Byb3RvLmggYi9mcy9jaWZzL2NpZnNwcm90
by5oIGluZGV4DQo+ID4gNzkzM2M1Zi4uODlkZGExNCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9jaWZz
L2NpZnNwcm90by5oDQo+ID4gKysrIGIvZnMvY2lmcy9jaWZzcHJvdG8uaA0KPiA+IEBAIC01NTcs
NCArNTU3LDcgQEAgaW50IGNpZnNfYWxsb2NfaGFzaChjb25zdCBjaGFyICpuYW1lLCBzdHJ1Y3QN
Cj4gY3J5cHRvX3NoYXNoICoqc2hhc2gsDQo+ID4gICAJCSAgICBzdHJ1Y3Qgc2Rlc2MgKipzZGVz
Yyk7DQo+ID4gICB2b2lkIGNpZnNfZnJlZV9oYXNoKHN0cnVjdCBjcnlwdG9fc2hhc2ggKipzaGFz
aCwgc3RydWN0IHNkZXNjDQo+ID4gKipzZGVzYyk7DQo+ID4NCj4gPiArZXh0ZXJuIHZvaWQgcnFz
dF9wYWdlX2dldF9sZW5ndGgoc3RydWN0IHNtYl9ycXN0ICpycXN0LCB1bnNpZ25lZCBpbnQNCj4g
cGFnZSwNCj4gPiArCQkJCXVuc2lnbmVkIGludCAqbGVuLCB1bnNpZ25lZCBpbnQgKm9mZnNldCk7
DQo+ID4gKw0KPiA+ICAgI2VuZGlmCQkJLyogX0NJRlNQUk9UT19IICovDQo+ID4gZGlmZiAtLWdp
dCBhL2ZzL2NpZnMvbWlzYy5jIGIvZnMvY2lmcy9taXNjLmMgaW5kZXggOTY4NDliNS4uZTk1MTQx
Nw0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2ZzL2NpZnMvbWlzYy5jDQo+ID4gKysrIGIvZnMvY2lm
cy9taXNjLmMNCj4gPiBAQCAtOTA1LDMgKzkwNSwyMCBAQCBjaWZzX2ZyZWVfaGFzaChzdHJ1Y3Qg
Y3J5cHRvX3NoYXNoICoqc2hhc2gsDQo+IHN0cnVjdCBzZGVzYyAqKnNkZXNjKQ0KPiA+ICAgCQlj
cnlwdG9fZnJlZV9zaGFzaCgqc2hhc2gpOw0KPiA+ICAgCSpzaGFzaCA9IE5VTEw7DQo+ID4gICB9
DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogcnFzdF9wYWdlX2dldF9sZW5ndGggLSBvYnRhaW4g
dGhlIGxlbmd0aCBhbmQgb2Zmc2V0IGZvciBhIHBhZ2UgaW4NCj4gPiArc21iX3Jxc3QNCj4gPiAr
ICogSW5wdXQ6IHJxc3QgLSBhIHNtYl9ycXN0LCBwYWdlIC0gYSBwYWdlIGluZGV4IGZvciBycXN0
DQo+ID4gKyAqIE91dHB1dDogKmxlbiAtIHRoZSBsZW5ndGggZm9yIHRoaXMgcGFnZSwgKm9mZnNl
dCAtIHRoZSBvZmZzZXQgZm9yDQo+ID4gK3RoaXMgcGFnZSAgKi8gdm9pZCBycXN0X3BhZ2VfZ2V0
X2xlbmd0aChzdHJ1Y3Qgc21iX3Jxc3QgKnJxc3QsDQo+ID4gK3Vuc2lnbmVkIGludCBwYWdlLA0K
PiA+ICsJCQkJdW5zaWduZWQgaW50ICpsZW4sIHVuc2lnbmVkIGludCAqb2Zmc2V0KSB7DQo+ID4g
KwkqbGVuID0gcnFzdC0+cnFfcGFnZXN6Ow0KPiA+ICsJKm9mZnNldCA9IChwYWdlID09IDApID8g
cnFzdC0+cnFfb2Zmc2V0IDogMDsNCj4gDQo+IFJlYWxseT8gUGFnZSAwIGFsd2F5cyBoYXMgYSB6
ZXJvIG9mZnNldD8/DQoNCkkgdGhpbmsgeW91IGFyZSBtaXNyZWFkaW5nIHRoaXMgbGluZS4gVGhl
IG9mZnNldCBmb3IgcGFnZSAwIGlzIHJxX29mZnNldCwgdGhlIG9mZnNldCBmb3IgYWxsIHN1YnNl
cXVlbnQgcGFnZXMgYXJlIDAuDQoNCj4gDQo+ID4gKw0KPiA+ICsJaWYgKHJxc3QtPnJxX25wYWdl
cyA9PSAxIHx8IHBhZ2UgPT0gcnFzdC0+cnFfbnBhZ2VzLTEpDQo+ID4gKwkJKmxlbiA9IHJxc3Qt
PnJxX3RhaWxzejsNCj4gPiArCWVsc2UgaWYgKHBhZ2UgPT0gMCkNCj4gPiArCQkqbGVuID0gcnFz
dC0+cnFfcGFnZXN6IC0gcnFzdC0+cnFfb2Zmc2V0OyB9DQo+ID4NCj4gDQo+IFRoaXMgc3Vicm91
dGluZSBkb2VzIHdoYXQgcGF0Y2ggNSBkb2VzIGlubGluZS4gV2h5IG5vdCBwdXNoIHRoaXMgcGF0
Y2ggdXAgaW4NCj4gdGhlIHNlcXVlbmNlIGFuZCB1c2UgdGhlIGhlbHBlcj8NCg0KVGhpcyBpcyBh
Y3R1YWxseSBhIGxpdHRsZSBkaWZmZXJlbnQuIFRoaXMgZnVuY3Rpb24gcmV0dXJucyB0aGUgbGVu
Z3RoIGFuZCBvZmZzZXQgZm9yIGEgZ2l2ZW4gcGFnZSBpbiB0aGUgcmVxdWVzdC4gVGhlcmUgbWln
aHQgYmUgbXVsdGlwbGUgcGFnZXMgaW4gYSByZXF1ZXN0LiANCg0KVGhlIG90aGVyIGZ1bmN0aW9u
IGNhbGN1bGF0ZXMgdGhlIHRvdGFsIGxlbmd0aCBvZiBhbGwgdGhlIHBhZ2VzIGluIGEgcmVxdWVz
dC4NCg0KPiANCj4gVG9tLg0K
