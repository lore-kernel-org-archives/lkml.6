Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9974AC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A33214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="VkFgSdhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A33214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJJATr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:19:47 -0400
Received: from mail-ve1eur01on0093.outbound.protection.outlook.com ([104.47.1.93]:7520
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbeJJATr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPfJvKGdUPvrnfVPynLX7+X+bxvebVwlWiuBlDdYtX0=;
 b=VkFgSdhqpMJsnZJ8YIm44iw1zksrQCZKwA2kkRyh7Xmn7hE9RLDWTGEU52J52S0tuHqkDvdOZCu1UFxC7hSOU34ALzH8nWUE0C5cx7BsFIsw9PGI9RkKym6sSfPyuq62k40PRgYK3Dqi9YW3NkRA2RSDVdIFxT6sMo1NoVc4EHA=
Received: from HE1PR0801MB2026.eurprd08.prod.outlook.com (10.168.95.15) by
 HE1PR0801MB1402.eurprd08.prod.outlook.com (10.167.248.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Tue, 9 Oct 2018 17:01:47 +0000
Received: from HE1PR0801MB2026.eurprd08.prod.outlook.com
 ([fe80::81:90cd:bab6:ed7a]) by HE1PR0801MB2026.eurprd08.prod.outlook.com
 ([fe80::81:90cd:bab6:ed7a%2]) with mapi id 15.20.1228.020; Tue, 9 Oct 2018
 17:01:47 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Laurent Vivier <laurent@vivier.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Eric Biederman <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andrei Vagin (C)" <avagin@gmail.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
Thread-Topic: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
Thread-Index: AQHUX+s9kF6FVIvT2ECnmBCh+DCRGaUXHxGAgAAEmwA=
Date:   Tue, 9 Oct 2018 17:01:47 +0000
Message-ID: <7d9d7846-d153-f328-f5b4-8dc9d9705339@virtuozzo.com>
References: <20181009103752.21482-1-laurent@vivier.eu>
 <20181009103752.21482-2-laurent@vivier.eu>
 <f14ce318-5a1a-06f3-2e90-91220f39e74b@virtuozzo.com>
 <bc11ca64-8616-f06a-c1fa-c76511e60257@vivier.eu>
In-Reply-To: <bc11ca64-8616-f06a-c1fa-c76511e60257@vivier.eu>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0102CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::39) To HE1PR0801MB2026.eurprd08.prod.outlook.com
 (2603:10a6:3:50::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0801MB1402;20:iIeEIgvCfVDlY6TqxMEPbPUSOHLLYusfw+qgLicdYs1w5WuCL8vGhv9b+km70P9dCWZ7zeprLU2WH8l75waYT/qCHJkPJKlW8XPIF9n8/RbSbpgDXNtmkF2YZOYVCv4Ay4qcrh5bnGJEnA3jBVC5CYQpYy8+VrycP9wXA/bWUzw=
x-ms-office365-filtering-correlation-id: 6d909f90-c3a1-4080-ecc3-08d62e08e5ad
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1402;
x-ms-traffictypediagnostic: HE1PR0801MB1402:
x-ld-processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
x-microsoft-antispam-prvs: <HE1PR0801MB14028CE066C14A4DAEAB17D0CDE70@HE1PR0801MB1402.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:HE1PR0801MB1402;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1402;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(396003)(366004)(376002)(346002)(136003)(189003)(199004)(2906002)(5660300001)(6116002)(86362001)(446003)(11346002)(7416002)(6436002)(256004)(110136005)(66066001)(71190400001)(229853002)(93886005)(71200400001)(4326008)(8676002)(39060400002)(99286004)(186003)(53546011)(6506007)(6512007)(26005)(386003)(66574009)(3846002)(305945005)(7736002)(31696002)(76176011)(52116002)(25786009)(97736004)(106356001)(5250100002)(105586002)(53936002)(2616005)(2501003)(476003)(2900100001)(8936002)(6486002)(14444005)(81166006)(81156014)(6246003)(68736007)(54906003)(31686004)(36756003)(316002)(102836004)(14454004)(486006)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1402;H:HE1PR0801MB2026.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2NPfyGaupzETN2NGSHsnvRcUogTVkgfMjdZX9hhuoUvaCQcOUIgQdq/89mtBGlhvu6Z2R4C2kMuZw2Vpt6LTZF1Rj7bjNdhN3Nru4phc952buD0jQo0Geo77DQpizMm/nkIUkFKaxPLg++LD9Xntjynleng3SbV/xD56LmyeWv/1j7oCnBfdnIewzqRaXhjf6NlZO/6aEzg6TVT4Y1AdCTTgIoL2QDsqgBLvyH5qU+z7BmgFvR+3NaPo/7VIc0A/VmZVUMiuPs5e/WHYReK9uwOhgeR0kanipcB+zMcNWZN8i5nqNKL5FTjBkrU2VpnoLesFzMiLCE1xnl48rtzBTIK0FGMP8FxzCgHhksZGweM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0247F71A93C55847856679BE251300BD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d909f90-c3a1-4080-ecc3-08d62e08e5ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 17:01:47.1634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMTAuMjAxOCAxOTo0NSwgTGF1cmVudCBWaXZpZXIgd3JvdGU6DQo+IExlIDA5LzEwLzIw
MTggw6AgMTg6MTUsIEtpcmlsbCBUa2hhaSBhIMOpY3JpdMKgOg0KPj4gT24gMDkuMTAuMjAxOCAx
MzozNywgTGF1cmVudCBWaXZpZXIgd3JvdGU6DQo+Pj4gVGhpcyBwYXRjaCBhbGxvd3MgdG8gaGF2
ZSBhIGRpZmZlcmVudCBiaW5mbXRfbWlzYyBjb25maWd1cmF0aW9uDQo+Pj4gZm9yIGVhY2ggbmV3
IHVzZXIgbmFtZXNwYWNlLiBCeSBkZWZhdWx0LCB0aGUgYmluZm10X21pc2MgY29uZmlndXJhdGlv
bg0KPj4+IGlzIHRoZSBvbmUgb2YgdGhlIHByZXZpb3VzIGxldmVsLCBidXQgaWYgdGhlIGJpbmZt
dF9taXNjIGZpbGVzeXN0ZW0gaXMNCj4+PiBtb3VudGVkIGluIHRoZSBuZXcgbmFtZXNwYWNlIGEg
bmV3IGVtcHR5IGJpbmZtdCBpbnN0YW5jZSBpcyBjcmVhdGVkIGFuZA0KPj4+IHVzZWQgaW4gdGhp
cyBuYW1lc3BhY2UuDQo+Pj4NCj4+PiBGb3IgaW5zdGFuY2UsIHVzaW5nICJ1bnNoYXJlIiB3ZSBj
YW4gc3RhcnQgYSBjaHJvb3Qgb2YgYW4gYW5vdGhlcg0KPj4+IGFyY2hpdGVjdHVyZSBhbmQgY29u
ZmlndXJlIHRoZSBiaW5mbXRfbWlzYyBpbnRlcnByZXRlciB3aXRob3V0IGJlaW5nIHJvb3QNCj4+
PiB0byBydW4gdGhlIGJpbmFyaWVzIGluIHRoaXMgY2hyb290Lg0KPj4+DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogTGF1cmVudCBWaXZpZXIgPGxhdXJlbnRAdml2aWVyLmV1Pg0KPj4+IC0tLQ0KPj4+ICBm
cy9iaW5mbXRfbWlzYy5jICAgICAgICAgICAgICAgfCAxMDYgKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tDQo+Pj4gIGluY2x1ZGUvbGludXgvdXNlcl9uYW1lc3BhY2UuaCB8ICAxMyAr
KysrDQo+Pj4gIGtlcm5lbC91c2VyLmMgICAgICAgICAgICAgICAgICB8ICAxMyArKysrDQo+Pj4g
IGtlcm5lbC91c2VyX25hbWVzcGFjZS5jICAgICAgICB8ICAgMyArDQo+Pj4gIDQgZmlsZXMgY2hh
bmdlZCwgMTA3IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAt
LWdpdCBhL2ZzL2JpbmZtdF9taXNjLmMgYi9mcy9iaW5mbXRfbWlzYy5jDQo+Pj4gaW5kZXggYWE0
YTdhMjNmZjk5Li4xZTAwMjlkMDk3ZDkgMTAwNjQ0DQo+Pj4gLS0tIGEvZnMvYmluZm10X21pc2Mu
Yw0KPj4+ICsrKyBiL2ZzL2JpbmZtdF9taXNjLmMNCj4gLi4uDQo+Pj4gQEAgLTgwLDE4ICs3NCwz
MiBAQCBzdGF0aWMgaW50IGVudHJ5X2NvdW50Ow0KPj4+ICAgKi8NCj4+PiAgI2RlZmluZSBNQVhf
UkVHSVNURVJfTEVOR1RIIDE5MjANCj4+PiAgDQo+Pj4gK3N0YXRpYyBzdHJ1Y3QgYmluZm10X25h
bWVzcGFjZSAqYmluZm10X25zKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbnMpDQo+Pj4gK3sNCj4+
PiArCXN0cnVjdCBiaW5mbXRfbmFtZXNwYWNlICpiX25zOw0KPj4+ICsNCj4+PiArCXdoaWxlIChu
cykgew0KPj4+ICsJCWJfbnMgPSBSRUFEX09OQ0UobnMtPmJpbmZtdF9ucyk7DQo+Pj4gKwkJaWYg
KGJfbnMpDQo+Pj4gKwkJCXJldHVybiBiX25zOw0KPj4+ICsJCW5zID0gbnMtPnBhcmVudDsNCj4+
PiArCX0NCj4+PiArCVdBUk5fT05fT05DRSgxKTsNCj4+PiArCXJldHVybiBOVUxMOw0KPj4+ICt9
DQo+Pj4gKw0KPiAuLi4NCj4+PiBAQCAtODIzLDEyICs4NDcsMzQgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBzdXBlcl9vcGVyYXRpb25zIHNfb3BzID0gew0KPj4+ICBzdGF0aWMgaW50IGJtX2ZpbGxf
c3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdm9pZCAqZGF0YSwgaW50IHNpbGVudCkNCj4+
PiAgew0KPj4+ICAJaW50IGVycjsNCj4+PiArCXN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbnMgPSBz
Yi0+c191c2VyX25zOw0KPj4+ICAJc3RhdGljIGNvbnN0IHN0cnVjdCB0cmVlX2Rlc2NyIGJtX2Zp
bGVzW10gPSB7DQo+Pj4gIAkJWzJdID0geyJzdGF0dXMiLCAmYm1fc3RhdHVzX29wZXJhdGlvbnMs
IFNfSVdVU1J8U19JUlVHT30sDQo+Pj4gIAkJWzNdID0geyJyZWdpc3RlciIsICZibV9yZWdpc3Rl
cl9vcGVyYXRpb25zLCBTX0lXVVNSfSwNCj4+PiAgCQkvKiBsYXN0IG9uZSAqLyB7IiJ9DQo+Pj4g
IAl9Ow0KPj4+ICANCj4+PiArCS8qIGNyZWF0ZSBhIG5ldyBiaW5mbXQgbmFtZXNwYWNlDQo+Pj4g
KwkgKiBpZiB3ZSBhcmUgbm90IGluIHRoZSBmaXJzdCB1c2VyIG5hbWVzcGFjZQ0KPj4+ICsJICog
YnV0IHRoZSBiaW5mbXQgbmFtZXNwYWNlIGlzIHRoZSBmaXJzdCBvbmUNCj4+PiArCSAqLw0KPj4+
ICsJaWYgKFJFQURfT05DRShucy0+YmluZm10X25zKSA9PSBOVUxMKSB7DQo+Pj4gKwkJc3RydWN0
IGJpbmZtdF9uYW1lc3BhY2UgKm5ld19uczsNCj4+PiArDQo+Pj4gKwkJbmV3X25zID0ga21hbGxv
YyhzaXplb2Yoc3RydWN0IGJpbmZtdF9uYW1lc3BhY2UpLA0KPj4+ICsJCQkJIEdGUF9LRVJORUwp
Ow0KPj4+ICsJCWlmIChuZXdfbnMgPT0gTlVMTCkNCj4+PiArCQkJcmV0dXJuIC1FTk9NRU07DQo+
Pj4gKwkJSU5JVF9MSVNUX0hFQUQoJm5ld19ucy0+ZW50cmllcyk7DQo+Pj4gKwkJbmV3X25zLT5l
bmFibGVkID0gMTsNCj4+PiArCQlyd2xvY2tfaW5pdCgmbmV3X25zLT5lbnRyaWVzX2xvY2spOw0K
Pj4+ICsJCW5ld19ucy0+Ym1fbW50ID0gTlVMTDsNCj4+PiArCQluZXdfbnMtPmVudHJ5X2NvdW50
ID0gMDsNCj4+PiArCQkvKiBlbnN1cmUgbmV3X25zIGlzIGNvbXBsZXRlbHkgaW5pdGlhbGl6ZWQg
YmVmb3JlIHNoYXJpbmcgaXQgKi8NCj4+PiArCQlzbXBfd21iKCk7DQo+Pg0KPj4gKEkgaGF2ZW4n
dCBkaXZlZCBpbnRvIHBhdGNoIGxvZ2ljLCBoZXJlIGp1c3Qgc21hbGwgYmFycmllciByZW1hcmsg
ZnJvbSBxdWljayBzaWdodCkuDQo+PiBzbXBfd21iKCkgaGFzIG5vIHNlbnNlIHdpdGhvdXQgcGFp
cmVkIHNtcF9ybWIoKSBvbiB0aGUgcmVhZCBzaWRlLiBQb3NzaWJsZSwNCj4+IHlvdSB3YW50IHNv
bWV0aGluZyBsaWtlIGJlbG93IGluIHJlYWQgaHVuazoNCj4+DQo+PiArCQliX25zID0gUkVBRF9P
TkNFKG5zLT5iaW5mbXRfbnMpOw0KPj4gKwkJaWYgKGJfbnMpIHsNCj4+ICsJCQlzbXBfcm1iKCk7
DQo+PiArCQkJcmV0dXJuIGJfbnM7DQo+PiArCQl9DQo+Pg0KPj4NCj4gDQo+IFRoZSB3cml0ZSBi
YXJyaWVyIGlzIGhlcmUgdG8gZW5zdXJlIHRoZSBzdHJ1Y3R1cmUgaXMgZnVsbHkgd3JpdHRlbg0K
PiBiZWZvcmUgd2Ugc2V0IHRoZSBwb2ludGVyLg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIGhv
dyByZWFkIGJhcnJpZXIgY2FuIGNoYW5nZSBzb21ldGhpbmcgYXQgdGhpcyBsZXZlbCwNCj4gSU1I
TyB0aGUgY291cGxlIFdSSVRFX09OQ0UoKS9SRUFEX09OQ0UoKSBzaG91bGQgYmUgZW5vdWdoIHRv
IGVuc3VyZSB3ZQ0KPiBoYXZlIGNvcnJlY3RseSBpbml0aWFsaXplZCB0aGUgcG9pbnRlciBhbmQg
dGhlIHN0cnVjdHVyZSB3aGVuIHdlIHJlYWQNCj4gdGhlIHBvaW50ZXIgYmFjay4NCj4gDQo+IEkg
dGhpbmsgdGhlIHBvaW50ZXIgaXRzZWxmIGlzIHRoZSAiYmFycmllciIgdG8gYWNjZXNzIHRoZSBt
ZW1vcnkNCj4gbW9kaWZpZWQgYmVmb3JlLg0KDQpzbXBfcm1iKCkgZ3VhcmFudGVlcyB5b3Ugc2Vl
IHN0b3JlcyBpbiB0aGUgb3JkZXIgeW91IHdhbnQuIElmIHlvdSBoYXZlOg0KDQpbY3B1MF0JCQkJ
CVtjcHUxXQ0KbmV3X25zLT5lbnRyeV9jb3VudCA9IDA7IA0Kc21wX3dtYigpOw0KV1JJVEVfT05D
RShucy0+YmluZm10X25zLCBuZXdfbnMpOyAJYl9ucyA9IFJFQURfT05DRShucy0+YmluZm10X25z
KTsNCgkJCQkJc21wX3JtYigpOw0KCQkJCQk8YWNjZXNzIGJfbnMtPmVudHJ5X2NvdW50Pg0KDQpz
bXBfcm1iKCkgZ3VhcmFudGVlcyB5b3Ugc2VlIHRydWUgZW50cnlfY291bnQgb24gdGhlIGNwdTEu
IFdpdGhvdXQNCnNtcF9ybWIoKSB5b3UgbWF5IHNlZSBvbGQgdmFsdWUgb2YgbmV3X25zLT5lbnRy
eV9jb3VudC4NCgkJCQkJDQpTZWUgRG9jdW1lbnRhdGlvbi9tZW1vcnktYmFycmllcnMudHh0DQo=
