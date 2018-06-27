Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE18C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0954D267F2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 03:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="citNUvdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0954D267F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeF0DYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 23:24:13 -0400
Received: from mail-bn3nam01on0097.outbound.protection.outlook.com ([104.47.33.97]:2385
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752436AbeF0DYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 23:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijXidKZzNddw4G58eA5Eut9Y3xcq3aE33MlyVqSyYrA=;
 b=citNUvdXqXgrlIBwxk0EEZ18vCqvxdr9BoH1lT1INwZMcbDYE7s9kmk7R8TZLUjInLt5k/DOnDePoIEEhThXU/XZyB+GYwJdKpIStb9TumdiTBB1V71VCccYOTHV0Lo268Fp5lYnoyl/NdqXr3/rIyCuCcVmSW4xVbfEctYC1mY=
Received: from SN4PR2101MB0733.namprd21.prod.outlook.com (10.167.150.161) by
 SN4PR2101MB0880.namprd21.prod.outlook.com (10.167.151.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.4; Wed, 27 Jun 2018 03:24:09 +0000
Received: from SN4PR2101MB0733.namprd21.prod.outlook.com
 ([fe80::2543:cba3:2e1:a322]) by SN4PR2101MB0733.namprd21.prod.outlook.com
 ([fe80::2543:cba3:2e1:a322%5]) with mapi id 15.20.0930.005; Wed, 27 Jun 2018
 03:24:09 +0000
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
Thread-Index: AQHT+E9iEw5xkPQo+UyOlJNsNS6C6qRu0BMAgALQeXCAAQ68AIAA7ENw
Date:   Wed, 27 Jun 2018 03:24:09 +0000
Message-ID: <SN4PR2101MB0733196B6565A7BF6F0008BCCE480@SN4PR2101MB0733.namprd21.prod.outlook.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
 <20180530194807.31657-7-longli@linuxonhyperv.com>
 <a6613388-0dc5-7646-b71f-75b8bec4e4d9@talpey.com>
 <CY4PR2101MB0722840106EDFEFBBA42D45FCE4A0@CY4PR2101MB0722.namprd21.prod.outlook.com>
 <33a2f951-10fd-fa94-4fb1-cade7f72cd77@talpey.com>
In-Reply-To: <33a2f951-10fd-fa94-4fb1-cade7f72cd77@talpey.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:1:fde7:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR2101MB0880;7:MR2wdebkmCmGlnQqco2ZLl+bORL0mr9S7hZPUdwsEfwQXAzyLufOtiO6JxH0vwULAnWsYtzpUpwmSbMuQslyUslvJC+0TSeRblnZslP5oHGntIV5xs8ZiqR66InzlVPocsL/RwcCWyARC7ArcgJkOq65RSVmk5bt7pEZmGNt9e4AMs0pwVs8m+vt3S5H2YLYjjmYUIolrj9uQXXPSbIbX8w6tmZXZLFH5dGhNooX19olYSbW8qYkKjFgAW92coN9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cfcbd567-2d22-4fd1-0a82-08d5dbdd725c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN4PR2101MB0880;
x-ms-traffictypediagnostic: SN4PR2101MB0880:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-microsoft-antispam-prvs: <SN4PR2101MB08807748E91AF944FA78ACE4CE480@SN4PR2101MB0880.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN4PR2101MB0880;BCL:0;PCL:0;RULEID:;SRVR:SN4PR2101MB0880;
x-forefront-prvs: 0716E70AB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(366004)(136003)(376002)(189003)(199004)(99286004)(5660300001)(110136005)(7736002)(74316002)(33656002)(305945005)(22452003)(316002)(93886005)(105586002)(68736007)(106356001)(8936002)(2501003)(5250100002)(8676002)(81156014)(25786009)(8990500004)(6246003)(10090500001)(53936002)(6436002)(229853002)(2900100001)(9686003)(81166006)(97736004)(486006)(476003)(446003)(11346002)(55016002)(2906002)(46003)(86612001)(14444005)(14454004)(76176011)(86362001)(7696005)(53546011)(6506007)(2201001)(186003)(478600001)(10290500003)(102836004)(6116002)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0880;H:SN4PR2101MB0733.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ft372jlL6fzea4P54WDArwYv7dygt+YzZ1yOaXkjYNNv/uuzJ0J+9JCGE4urWzr0xc/9M0Z7xVkMO3JmT6UgUVC4ojT8GRaACJYtoBGx9zLsPZ/uRmoa72k+9nte1wlVIZDGtgZxXtoJxNmUjQvRvitrNfcpfKdIZmygVsamto5FlArbch+yTEAr1xYxiVeeGXih8lNYZ//OVBStE6MfwIvHvnWgmxzeFP7IcgSD8V9cXiuuQOa+ignGF3juJJ8NnwTV4ct5AlY1okWbO+UM/GTgco8H40LbruY7J1A209WvOsQS58k/03KrZ/1SYnh2kPanLTqTAYoDylDX/v9TINHXkbSh2e3noO8afOQbKxM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcbd567-2d22-4fd1-0a82-08d5dbdd725c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2018 03:24:09.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BhdGNoIHYyIDA2LzE1XSBDSUZTOiBJbnRyb2R1Y2UgaGVscGVyIGZ1
bmN0aW9uIHRvIGdldCBwYWdlDQo+IG9mZnNldCBhbmQgbGVuZ3RoIGluIHNtYl9ycXN0DQo+IA0K
PiBPbiA2LzI1LzIwMTggNToxNCBQTSwgTG9uZyBMaSB3cm90ZToNCj4gPj4gU3ViamVjdDogUmU6
IFtQYXRjaCB2MiAwNi8xNV0gQ0lGUzogSW50cm9kdWNlIGhlbHBlciBmdW5jdGlvbiB0byBnZXQN
Cj4gPj4gcGFnZSBvZmZzZXQgYW5kIGxlbmd0aCBpbiBzbWJfcnFzdA0KPiA+Pg0KPiA+PiBPbiA1
LzMwLzIwMTggMzo0NyBQTSwgTG9uZyBMaSB3cm90ZToNCj4gPj4+IEZyb206IExvbmcgTGkgPGxv
bmdsaUBtaWNyb3NvZnQuY29tPg0KPiA+Pj4NCj4gPj4+IEludHJvZHVjZSBhIGZ1bmN0aW9uIHJx
c3RfcGFnZV9nZXRfbGVuZ3RoIHRvIHJldHVybiB0aGUgcGFnZSBvZmZzZXQNCj4gPj4+IGFuZCBs
ZW5ndGggZm9yIGEgZ2l2ZW4gcGFnZSBpbiBzbWJfcnFzdC4gVGhpcyBmdW5jdGlvbiBpcyB0byBi
ZSB1c2VkDQo+ID4+PiBieSBmb2xsb3dpbmcgcGF0Y2hlcy4NCj4gPj4+DQo+ID4+PiBTaWduZWQt
b2ZmLWJ5OiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4g
ICAgZnMvY2lmcy9jaWZzcHJvdG8uaCB8ICAzICsrKw0KPiA+Pj4gICAgZnMvY2lmcy9taXNjLmMg
ICAgICB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ID4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzcHJv
dG8uaCBiL2ZzL2NpZnMvY2lmc3Byb3RvLmggaW5kZXgNCj4gPj4+IDc5MzNjNWYuLjg5ZGRhMTQg
MTAwNjQ0DQo+ID4+PiAtLS0gYS9mcy9jaWZzL2NpZnNwcm90by5oDQo+ID4+PiArKysgYi9mcy9j
aWZzL2NpZnNwcm90by5oDQo+ID4+PiBAQCAtNTU3LDQgKzU1Nyw3IEBAIGludCBjaWZzX2FsbG9j
X2hhc2goY29uc3QgY2hhciAqbmFtZSwgc3RydWN0DQo+ID4+IGNyeXB0b19zaGFzaCAqKnNoYXNo
LA0KPiA+Pj4gICAgCQkgICAgc3RydWN0IHNkZXNjICoqc2Rlc2MpOw0KPiA+Pj4gICAgdm9pZCBj
aWZzX2ZyZWVfaGFzaChzdHJ1Y3QgY3J5cHRvX3NoYXNoICoqc2hhc2gsIHN0cnVjdCBzZGVzYw0K
PiA+Pj4gKipzZGVzYyk7DQo+ID4+Pg0KPiA+Pj4gK2V4dGVybiB2b2lkIHJxc3RfcGFnZV9nZXRf
bGVuZ3RoKHN0cnVjdCBzbWJfcnFzdCAqcnFzdCwgdW5zaWduZWQNCj4gPj4+ICtpbnQNCj4gPj4g
cGFnZSwNCj4gPj4+ICsJCQkJdW5zaWduZWQgaW50ICpsZW4sIHVuc2lnbmVkIGludCAqb2Zmc2V0
KTsNCj4gPj4+ICsNCj4gPj4+ICAgICNlbmRpZgkJCS8qIF9DSUZTUFJPVE9fSCAqLw0KPiA+Pj4g
ZGlmZiAtLWdpdCBhL2ZzL2NpZnMvbWlzYy5jIGIvZnMvY2lmcy9taXNjLmMgaW5kZXggOTY4NDli
NS4uZTk1MTQxNw0KPiA+Pj4gMTAwNjQ0DQo+ID4+PiAtLS0gYS9mcy9jaWZzL21pc2MuYw0KPiA+
Pj4gKysrIGIvZnMvY2lmcy9taXNjLmMNCj4gPj4+IEBAIC05MDUsMyArOTA1LDIwIEBAIGNpZnNf
ZnJlZV9oYXNoKHN0cnVjdCBjcnlwdG9fc2hhc2ggKipzaGFzaCwNCj4gPj4gc3RydWN0IHNkZXNj
ICoqc2Rlc2MpDQo+ID4+PiAgICAJCWNyeXB0b19mcmVlX3NoYXNoKCpzaGFzaCk7DQo+ID4+PiAg
ICAJKnNoYXNoID0gTlVMTDsNCj4gPj4+ICAgIH0NCj4gPj4+ICsNCj4gPj4+ICsvKioNCj4gPj4+
ICsgKiBycXN0X3BhZ2VfZ2V0X2xlbmd0aCAtIG9idGFpbiB0aGUgbGVuZ3RoIGFuZCBvZmZzZXQg
Zm9yIGEgcGFnZQ0KPiA+Pj4gK2luIHNtYl9ycXN0DQo+ID4+PiArICogSW5wdXQ6IHJxc3QgLSBh
IHNtYl9ycXN0LCBwYWdlIC0gYSBwYWdlIGluZGV4IGZvciBycXN0DQo+ID4+PiArICogT3V0cHV0
OiAqbGVuIC0gdGhlIGxlbmd0aCBmb3IgdGhpcyBwYWdlLCAqb2Zmc2V0IC0gdGhlIG9mZnNldA0K
PiA+Pj4gK2ZvciB0aGlzIHBhZ2UgICovIHZvaWQgcnFzdF9wYWdlX2dldF9sZW5ndGgoc3RydWN0
IHNtYl9ycXN0ICpycXN0LA0KPiA+Pj4gK3Vuc2lnbmVkIGludCBwYWdlLA0KPiA+Pj4gKwkJCQl1
bnNpZ25lZCBpbnQgKmxlbiwgdW5zaWduZWQgaW50ICpvZmZzZXQpIHsNCj4gPj4+ICsJKmxlbiA9
IHJxc3QtPnJxX3BhZ2VzejsNCj4gPj4+ICsJKm9mZnNldCA9IChwYWdlID09IDApID8gcnFzdC0+
cnFfb2Zmc2V0IDogMDsNCj4gPj4NCj4gPj4gUmVhbGx5PyBQYWdlIDAgYWx3YXlzIGhhcyBhIHpl
cm8gb2Zmc2V0Pz8NCj4gPg0KPiA+IEkgdGhpbmsgeW91IGFyZSBtaXNyZWFkaW5nIHRoaXMgbGlu
ZS4gVGhlIG9mZnNldCBmb3IgcGFnZSAwIGlzIHJxX29mZnNldCwgdGhlDQo+IG9mZnNldCBmb3Ig
YWxsIHN1YnNlcXVlbnQgcGFnZXMgYXJlIDAuDQo+IA0KPiBBaCwgeWVzLCBzb3JyeSBJIGRpZCBy
ZWFkIGl0IGluY29ycmVjdGx5Lg0KPiA+Pj4gKw0KPiA+Pj4gKwlpZiAocnFzdC0+cnFfbnBhZ2Vz
ID09IDEgfHwgcGFnZSA9PSBycXN0LT5ycV9ucGFnZXMtMSkNCj4gPj4+ICsJCSpsZW4gPSBycXN0
LT5ycV90YWlsc3o7DQo+ID4+PiArCWVsc2UgaWYgKHBhZ2UgPT0gMCkNCj4gPj4+ICsJCSpsZW4g
PSBycXN0LT5ycV9wYWdlc3ogLSBycXN0LT5ycV9vZmZzZXQ7IH0NCj4gPj4+DQo+ID4+DQo+ID4+
IFRoaXMgc3Vicm91dGluZSBkb2VzIHdoYXQgcGF0Y2ggNSBkb2VzIGlubGluZS4gV2h5IG5vdCBw
dXNoIHRoaXMNCj4gPj4gcGF0Y2ggdXAgaW4gdGhlIHNlcXVlbmNlIGFuZCB1c2UgdGhlIGhlbHBl
cj8NCj4gPg0KPiA+IFRoaXMgaXMgYWN0dWFsbHkgYSBsaXR0bGUgZGlmZmVyZW50LiBUaGlzIGZ1
bmN0aW9uIHJldHVybnMgdGhlIGxlbmd0aCBhbmQgb2Zmc2V0DQo+IGZvciBhIGdpdmVuIHBhZ2Ug
aW4gdGhlIHJlcXVlc3QuIFRoZXJlIG1pZ2h0IGJlIG11bHRpcGxlIHBhZ2VzIGluIGEgcmVxdWVz
dC4NCj4gDQo+IE9rLCBidXQgSSBzdGlsbCB0aGluayB0aGVyZSBpcyBxdWl0ZSBhIGJpdCBvZiBp
bmxpbmUgY29tcHV0YXRpb24gb2YgdGhpcyBzdHVmZiB0aGF0DQo+IHdvdWxkIG1vcmUgY2xlYXJs
eSBhbmQgbW9yZSByb2J1c3RseSBiZSBkb25lIGluIGEgc2V0IG9mIGNvbW1vbiBmdW5jdGlvbnMu
DQo+IElmIHNvbWVvbmUgZXZlciB0b3VjaGVzIHRoZSBjb2RlIHRvIHN1cHBvcnQgYSBuZXcgdXBw
ZXIgbGF5ZXIsIG9yIGV2ZW4NCj4gaW50ZWdyYXRlIHdpdGggbW9yZSBjb21wbGV4IGNvbXBvdW5k
aW5nLCB0aGluZ3Mgd2lsbCBnZXQgdWdseSBmYXN0Lg0KPiANCj4gPiBUaGUgb3RoZXIgZnVuY3Rp
b24gY2FsY3VsYXRlcyB0aGUgdG90YWwgbGVuZ3RoIG9mIGFsbCB0aGUgcGFnZXMgaW4gYSByZXF1
ZXN0Lg0KPiANCj4gQWdhaW4sIGEgZ3JlYXQgY2FuZGlkYXRlIGZvciBhIGNvbW1vbiBzZXQgb2Yg
c3Vicm91dGluZXMsIElNTy4NCg0KSSB3aWxsIGxvb2sgaW50byB0aGlzLiBUaGUgcmVhc29uIEkg
ZGlkbid0IG1ha2UgYSBjb21tb24gZnVuY3Rpb24gaXMgdGhhdCB0aGlzIGlzIHRoZSBvbmx5IHBh
dGNoIHRoYXQgd2lsbCB1c2UgaXQgaW4gdGhpcyB3YXkuDQo=
