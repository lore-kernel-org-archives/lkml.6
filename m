Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28A1C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5FF20652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XZNDZ0JQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kdxVPDya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5FF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeJCETd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 00:19:33 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50872 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbeJCETc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 00:19:32 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w92LXiDl003917;
        Tue, 2 Oct 2018 14:34:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0s5EFO1xYHGBtwsIIAOHpAmU7yIO7s2NdLETX2KMRCc=;
 b=XZNDZ0JQUBgmnu2lLEsWcUZvAFW8v+qr45iZiKNMUA5de2zcYZ3Qt7TV9THBOAaBiaA+
 Lpptqik0sXAZNgWgcpNoz5P44EHK4OpeQymnjZplQpfAt5gQqV8G6MdASgAh89Dz8A22
 5rwiVGrmUt9a8jQlPFCB7Wt0ZoWKs0cgvD4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mvdt18k1b-7
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Oct 2018 14:34:06 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.15) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 2 Oct 2018 14:33:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s5EFO1xYHGBtwsIIAOHpAmU7yIO7s2NdLETX2KMRCc=;
 b=kdxVPDyaNZuLABm6kaHRsop5bP35/YBrCeOM6JSNLckEKHUDANMST7vun1o/x/pSP8TIWdCyFtH/Wf9PlZ1uc4LXu0ryIAwxTi0n62tjAYh1iRSy8GNM+Rj6GcSRtWKb5KZ0nNlvxwUR8EpQ/FrTN5PJ98kxQCGL0MuLDsycJoA=
Received: from SN1PR15MB0158.namprd15.prod.outlook.com (10.162.106.13) by
 SN1PR15MB0239.namprd15.prod.outlook.com (10.162.106.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.25; Tue, 2 Oct 2018 21:33:41 +0000
Received: from SN1PR15MB0158.namprd15.prod.outlook.com
 ([fe80::60e4:7ed2:81a6:9472]) by SN1PR15MB0158.namprd15.prod.outlook.com
 ([fe80::60e4:7ed2:81a6:9472%4]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 21:33:41 +0000
From:   Dan Schatzberg <dschatzberg@fb.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     Tejun Heo <tj@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fuse: enable caching of symlinks
Thread-Topic: [PATCH] fuse: enable caching of symlinks
Thread-Index: AQHUVmlm6B4VA33ox0WSe5595jPrUaUEJ6KAgAgXqYA=
Date:   Tue, 2 Oct 2018 21:33:41 +0000
Message-ID: <FEA49C2E-639E-4B1E-A4A1-0E0879F1214A@fb.com>
References: <20180927135211.31641-1-dschatzberg@fb.com>
 <CAJfpegsRNv3Uby2w-B0+d4fE8ecSRkT0ef2AfQ_QnnEVT-nkmA@mail.gmail.com>
In-Reply-To: <CAJfpegsRNv3Uby2w-B0+d4fE8ecSRkT0ef2AfQ_QnnEVT-nkmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c091:180::1:2c52]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR15MB0239;20:EFHz1WiPq1QJPEYgnAZWJpunr7b4s6FAOyhq/MuLi5JFy7pS/3OgNBNfqnYKd/OPGiGyMhZf7efu8KIVGbo3foBbItNWc+EzBbh2Dwl+8zqWNWi9HfGPKUUXx3GhR1eoRGQYEkv+4gNgt++28/zz6t2Y+9c+pm0r/5bbkYPTS8c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c310a670-d298-441f-135e-08d628aeb963
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0239;
x-ms-traffictypediagnostic: SN1PR15MB0239:
x-microsoft-antispam-prvs: <SN1PR15MB023946E31AC5A0E3EF9AD91CD0E80@SN1PR15MB0239.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302063)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051);SRVR:SN1PR15MB0239;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0239;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(376002)(396003)(39860400002)(189003)(199004)(186003)(2616005)(36756003)(7736002)(53936002)(4326008)(476003)(2900100001)(14444005)(256004)(305945005)(5024004)(6486002)(6512007)(6436002)(83716004)(71200400001)(6916009)(54906003)(99286004)(5250100002)(6116002)(2906002)(71190400001)(6246003)(8676002)(82746002)(229853002)(53546011)(6506007)(25786009)(5660300001)(81166006)(81156014)(106356001)(316002)(102836004)(8936002)(486006)(86362001)(478600001)(446003)(105586002)(11346002)(14454004)(575784001)(68736007)(46003)(97736004)(33656002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0239;H:SN1PR15MB0158.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hglGYfM2saI2k1vogMk4s4KvYjyCVqerYr1eFC9FwsEdTBEy0B+6dLlw94kUkxOnA6r868XKIKUVfKw/fTOwm5uq4XeuHvYSUjNraakydZcQzuDk2gQ+Wf1VJDTI5jc9wpbsolpI5HYq4c88shGzvzmdCm+FNdh16uxmV+RwKyxlyoYDYKiCBrp7Da3i+KBAvX5bXjRoYQcuyX8rG3Nnf7zBGn3zkjh9hciFUMDYZ0TmOvLOTsnqVbDfFVMNZShXrFORi0K3SfCo+gRRDTdqF2tHUVvQlMAZFBA54++FZeKmhsM58R30LG0f85KyEgbnvjyBlEgBWLsHNnTwxhpMPBhHIWlgz+mIU6iZxSqht+0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDE301FF89C7514791D7BF54BF36F778@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c310a670-d298-441f-135e-08d628aeb963
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 21:33:41.7871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0239
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8yNy8xOCwgOTo1OSBBTSwgIk1pa2xvcyBTemVyZWRpIiA8bWlrbG9zQHN6ZXJlZGkuaHU+
IHdyb3RlOg0KDQo+ICBPbiBUaHUsIFNlcCAyNywgMjAxOCBhdCAzOjUyIFBNLCBEYW4gU2NoYXR6
YmVyZyA8ZHNjaGF0emJlcmdAZmIuY29tPiB3cm90ZToNCj4+IEZVU0UgZmlsZSByZWFkcyBhcmUg
Y2FjaGVkIGluIHRoZSBwYWdlIGNhY2hlLCBidXQgc3ltbGluayByZWFkcyBhcmUNCj4+IG5vdC4g
VGhpcyBwYXRjaCBlbmFibGVzIEZVU0UgUkVBRExJTksgb3BlcmF0aW9ucyB0byBiZSBjYWNoZWQg
d2hpY2gNCj4+IGNhbiBpbXByb3ZlIHBlcmZvcm1hbmNlIG9mIHNvbWUgRlVTRSB3b3JrbG9hZHMu
DQo+Pg0KPj4gSW4gcGFydGljdWxhciwgSSdtIHdvcmtpbmcgb24gYSBGVVNFIGZpbGVzeXN0ZW0g
Zm9yIGFjY2VzcyB0byBzb3VyY2UNCj4+IGNvZGUgYW5kIGRpc2NvdmVyZWQgdGhhdCBhYm91dCBh
IDEwJSBpbXByb3ZlbWVudCB0byBidWlsZCB0aW1lcyBpcw0KPj4gYWNoaWV2ZWQgd2l0aCB0aGlz
IHBhdGNoICh0aGVyZSBhcmUgYSBsb3Qgb2Ygc3ltbGlua3MgaW4gdGhlIHNvdXJjZQ0KPj4gdHJl
ZSkuDQo+Pg0KPj4gUGxlYXNlIHByb3ZpZGUgZmVlZGJhY2ssIEknbSBsb29raW5nIHRvIGZsZXNo
IHRoaXMgb3V0IG1vcmUuDQo+IA0KPiBOZWVkIHRvIHRoaW5rIGFib3V0IGhvdy93aGVuIHRvIGlu
dmFsaWRhdGUgdGhlIGNhY2hlZCBzeW1saW5rDQo+IGNvbnRlbnRzLiAgSSB0aGluayB0cmVhdGlu
ZyBpdCBsaWtlIG1ldGFkYXRhIChpLmUuIGxvb2sgYXQNCj4gYXR0cl90aW1lb3V0IGZvciB2YWxp
ZGl0eSkgd291bGQgYmUgdGhlIHNpbXBsZXN0Lg0KPiANCj4gVGhhbmtzLA0KPiBNaWtsb3MNCj4g
DQoNCkFueSBmdXJ0aGVyIHRob3VnaHRzIG9uIHRoaXM/IEp1c3Qgc28gSSBjYW4gY29uZmlybSBt
eSB1bmRlcnN0YW5kaW5nLA0KdGhlIGF0dGFjaGVkIHBhdGNoIHdpbGwgdW5jb25kaXRpb25hbGx5
IGNhY2hlIFJFQURMSU5LIHJlc3BvbnNlcw0KSG93ZXZlciwgYmFzZWQgb24gdGhlIGVudHJ5IHRp
bWVvdXQgcHJvdmlkZWQgYnkgdGhlIExPT0tVUCByZXNwb25zZSwNClVzZXJzcGFjZSBjYW4gZGVj
aWRlIHRvIGludmFsaWRhdGUgdGhpcyBieSBwcm92aWRpbmcgYSBkaWZmZXJlbnQgaW5vZGUgb24N
CmEgc3Vic2VxdWVudCBMT09LVVAgKGUuZy4gZHVyaW5nIGZ1c2VfZGVudHJ5X3JldmFsaWRhdGUo
KSkNCg0KV291bGQgeW91IGxpa2UgdGhlcmUgdG8gYmUgYSB3YXkgdG8gaW52YWxpZGF0ZSB0aGUg
Y2FjaGVkIHN5bWxpbmsgd2l0aG91dA0KIGNoYW5naW5nIHRoZSBpbm9kZSB2aWEgTE9PS1VQPw0K
Pj4NCj4+IFNpZ25lZC1vZmYtYnk6IERhbiBTY2hhdHpiZXJnIDxkc2NoYXR6YmVyZ0BmYi5jb20+
DQo+PiAtLS0NCj4+ICBmcy9mdXNlL2Rpci5jIHwgNzAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQzIGluc2Vy
dGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9mdXNlL2Rp
ci5jIGIvZnMvZnVzZS9kaXIuYw0KPj4gaW5kZXggMDk3OTYwOWQ2ZWJhLi4zYzBhODFlZjViY2Eg
MTAwNjQ0DQo+PiAtLS0gYS9mcy9mdXNlL2Rpci5jDQo+PiArKysgYi9mcy9mdXNlL2Rpci5jDQo+
PiBAQCAtMTM5OCwzOCArMTM5OCw0NiBAQCBzdGF0aWMgaW50IGZ1c2VfcmVhZGRpcihzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpDQo+PiAgICAgICAgIHJldHVybiBl
cnI7DQo+PiAgfQ0KPj4NCj4+IC1zdGF0aWMgY29uc3QgY2hhciAqZnVzZV9nZXRfbGluayhzdHJ1
Y3QgZGVudHJ5ICpkZW50cnksDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgaW5vZGUgKmlub2RlLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGRlbGF5ZWRfY2FsbCAqZG9uZSkNCj4+ICtzdGF0aWMgaW50IGZ1c2Vfc3ltbGlua19y
ZWFkcGFnZShzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IHBhZ2UgKnBhZ2UpDQo+PiAgew0KPj4g
KyAgICAgICBzdHJ1Y3QgaW5vZGUgKmlub2RlID0gcGFnZS0+bWFwcGluZy0+aG9zdDsNCj4+ICAg
ICAgICAgc3RydWN0IGZ1c2VfY29ubiAqZmMgPSBnZXRfZnVzZV9jb25uKGlub2RlKTsNCj4+IC0g
ICAgICAgRlVTRV9BUkdTKGFyZ3MpOw0KPj4gLSAgICAgICBjaGFyICpsaW5rOw0KPj4gLSAgICAg
ICBzc2l6ZV90IHJldDsNCj4+IC0NCj4+IC0gICAgICAgaWYgKCFkZW50cnkpDQo+PiAtICAgICAg
ICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVDSElMRCk7DQo+PiArICAgICAgIHN0cnVjdCBmdXNl
X3JlcSAqcmVxOw0KPj4gKyAgICAgICBpbnQgZXJyOw0KPj4gKyAgICAgICBzaXplX3QgbnVtX3Jl
YWQ7DQo+Pg0KPj4gLSAgICAgICBsaW5rID0ga21hbGxvYyhQQUdFX1NJWkUsIEdGUF9LRVJORUwp
Ow0KPj4gLSAgICAgICBpZiAoIWxpbmspDQo+PiAtICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9Q
VFIoLUVOT01FTSk7DQo+PiArICAgICAgIGVyciA9IC1FSU87DQo+PiArICAgICAgIGlmIChpc19i
YWRfaW5vZGUoaW5vZGUpKQ0KPj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4NCj4+IC0g
ICAgICAgYXJncy5pbi5oLm9wY29kZSA9IEZVU0VfUkVBRExJTks7DQo+PiAtICAgICAgIGFyZ3Mu
aW4uaC5ub2RlaWQgPSBnZXRfbm9kZV9pZChpbm9kZSk7DQo+PiAtICAgICAgIGFyZ3Mub3V0LmFy
Z3ZhciA9IDE7DQo+PiAtICAgICAgIGFyZ3Mub3V0Lm51bWFyZ3MgPSAxOw0KPj4gLSAgICAgICBh
cmdzLm91dC5hcmdzWzBdLnNpemUgPSBQQUdFX1NJWkUgLSAxOw0KPj4gLSAgICAgICBhcmdzLm91
dC5hcmdzWzBdLnZhbHVlID0gbGluazsNCj4+IC0gICAgICAgcmV0ID0gZnVzZV9zaW1wbGVfcmVx
dWVzdChmYywgJmFyZ3MpOw0KPj4gLSAgICAgICBpZiAocmV0IDwgMCkgew0KPj4gLSAgICAgICAg
ICAgICAgIGtmcmVlKGxpbmspOw0KPj4gLSAgICAgICAgICAgICAgIGxpbmsgPSBFUlJfUFRSKHJl
dCk7DQo+PiAtICAgICAgIH0gZWxzZSB7DQo+PiAtICAgICAgICAgICAgICAgbGlua1tyZXRdID0g
J1wwJzsNCj4+IC0gICAgICAgICAgICAgICBzZXRfZGVsYXllZF9jYWxsKGRvbmUsIGtmcmVlX2xp
bmssIGxpbmspOw0KPj4gKyAgICAgICByZXEgPSBmdXNlX2dldF9yZXEoZmMsIDEpOw0KPj4gKyAg
ICAgICBpZiAoSVNfRVJSKHJlcSkpIHsNCj4+ICsgICAgICAgICAgICAgICBlcnIgPSBQVFJfRVJS
KHJlcSk7DQo+PiArICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+PiAgICAgICAgIH0NCj4+ICsN
Cj4+ICsgICAgICAgcmVxLT5vdXQucGFnZV96ZXJvaW5nID0gMTsNCj4+ICsgICAgICAgcmVxLT5v
dXQuYXJncGFnZXMgPSAxOw0KPj4gKyAgICAgICByZXEtPm51bV9wYWdlcyA9IDE7DQo+PiArICAg
ICAgIHJlcS0+cGFnZXNbMF0gPSBwYWdlOw0KPj4gKyAgICAgICByZXEtPnBhZ2VfZGVzY3NbMF0u
bGVuZ3RoID0gUEFHRV9TSVpFIC0gMTsNCj4+ICsgICAgICAgcmVxLT5pbi5oLm9wY29kZSA9IEZV
U0VfUkVBRExJTks7DQo+PiArICAgICAgIHJlcS0+aW4uaC5ub2RlaWQgPSBnZXRfbm9kZV9pZChp
bm9kZSk7DQo+PiArICAgICAgIHJlcS0+b3V0LmFyZ3ZhciA9IDE7DQo+PiArICAgICAgIHJlcS0+
b3V0Lm51bWFyZ3MgPSAxOw0KPj4gKyAgICAgICByZXEtPm91dC5hcmdzWzBdLnNpemUgPSBQQUdF
X1NJWkUgLSAxOw0KPj4gKyAgICAgICBmdXNlX3JlcXVlc3Rfc2VuZChmYywgcmVxKTsNCj4+ICsg
ICAgICAgbnVtX3JlYWQgPSByZXEtPm91dC5hcmdzWzBdLnNpemU7DQo+PiArICAgICAgIGVyciA9
IHJlcS0+b3V0LmguZXJyb3I7DQo+PiArDQo+PiArICAgICAgIGlmICghZXJyKQ0KPj4gKyAgICAg
ICAgICAgICAgIFNldFBhZ2VVcHRvZGF0ZShwYWdlKTsNCj4+ICsNCj4+ICsgICAgICAgZnVzZV9w
dXRfcmVxdWVzdChmYywgcmVxKTsNCj4+ICAgICAgICAgZnVzZV9pbnZhbGlkYXRlX2F0aW1lKGlu
b2RlKTsNCj4+IC0gICAgICAgcmV0dXJuIGxpbms7DQo+PiArb3V0Og0KPj4gKyAgICAgICB1bmxv
Y2tfcGFnZShwYWdlKTsNCj4+ICsgICAgICAgcmV0dXJuIGVycjsNCj4+ICB9DQo+Pg0KPj4gIHN0
YXRpYyBpbnQgZnVzZV9kaXJfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAq
ZmlsZSkNCj4+IEBAIC0xODU1LDcgKzE4NjMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlub2Rl
X29wZXJhdGlvbnMgZnVzZV9jb21tb25faW5vZGVfb3BlcmF0aW9ucyA9IHsNCj4+DQo+PiAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBpbm9kZV9vcGVyYXRpb25zIGZ1c2Vfc3ltbGlua19pbm9kZV9vcGVy
YXRpb25zID0gew0KPj4gICAgICAgICAuc2V0YXR0ciAgICAgICAgPSBmdXNlX3NldGF0dHIsDQo+
PiAtICAgICAgIC5nZXRfbGluayAgICAgICA9IGZ1c2VfZ2V0X2xpbmssDQo+PiArICAgICAgIC5n
ZXRfbGluayAgICAgICA9IHBhZ2VfZ2V0X2xpbmssDQo+PiAgICAgICAgIC5nZXRhdHRyICAgICAg
ICA9IGZ1c2VfZ2V0YXR0ciwNCj4+ICAgICAgICAgLmxpc3R4YXR0ciAgICAgID0gZnVzZV9saXN0
eGF0dHIsDQo+PiAgfTsNCj4+IEBAIC0xODcxLDcgKzE4NzksMTUgQEAgdm9pZCBmdXNlX2luaXRf
ZGlyKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+PiAgICAgICAgIGlub2RlLT5pX2ZvcCA9ICZmdXNl
X2Rpcl9vcGVyYXRpb25zOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBhZGRy
ZXNzX3NwYWNlX29wZXJhdGlvbnMgZnVzZV9zeW1saW5rX2FvcHMgPSB7DQo+PiArICAgICAgIC5y
ZWFkcGFnZSAgICAgICA9IGZ1c2Vfc3ltbGlua19yZWFkcGFnZSwNCj4+ICt9Ow0KPj4gKw0KPj4g
IHZvaWQgZnVzZV9pbml0X3N5bWxpbmsoc3RydWN0IGlub2RlICppbm9kZSkNCj4+ICB7DQo+PiAg
ICAgICAgIGlub2RlLT5pX29wID0gJmZ1c2Vfc3ltbGlua19pbm9kZV9vcGVyYXRpb25zOw0KPj4g
KyAgICAgICBpbm9kZS0+aV9kYXRhLmFfb3BzID0gJmZ1c2Vfc3ltbGlua19hb3BzOw0KPj4gKyAg
ICAgICBtYXBwaW5nX3NldF9nZnBfbWFzayhpbm9kZS0+aV9tYXBwaW5nLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgbWFwcGluZ19nZnBfY29uc3RyYWludChpbm9kZS0+aV9tYXBwaW5nLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH4oX19HRlBfRlMgfCBf
X0dGUF9ISUdITUVNKSkpOw0KPj4gIH0NCj4+IC0tDQo+PiAyLjE3LjENCg0K
