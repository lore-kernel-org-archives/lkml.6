Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F273C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEF621479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q4xAUrO3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YmtqbYG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEF621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJIVsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:48:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52568 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbeJIVsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:48:36 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w99EI5M2028514;
        Tue, 9 Oct 2018 07:31:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vTchVn+Kz+ZQRDrFvEYgGpp+BBGOS374nbqGms2d2bI=;
 b=Q4xAUrO3+sIYzEd5v/gHhyKvhdjak/KW0T/HqUsEHnkT6iBl3CxaEPWPRoqEpNOt0IJ8
 pfXITM2oGIrRbZ7g3GmieN6JdQCjYjL3uau9pMtZHZJ1M3Yej+Rczoo6EmAhmzh41+RL
 P/uB9lQL26x9+fhbUGuq1mvttRE2DOlGWKo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2n0m91hd5r-10
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Oct 2018 07:31:19 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.33) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 9 Oct 2018 10:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTchVn+Kz+ZQRDrFvEYgGpp+BBGOS374nbqGms2d2bI=;
 b=YmtqbYG8qcgnAHGiZ6j1lpY9esCP+LsnDpC/qe8MkST1oSyQIf9+fPyx+S6Ayqd749cuxpL9+YblQWxNIEN10Zc0C8zxfXg4NlTKv6jo6tXiZsIdv58IgYbPAfLE+XeVuln6sEK5c9zlP6Ue/raVJ2aDTQv2ciiM0FGJWq6VBtU=
Received: from SN1PR15MB0158.namprd15.prod.outlook.com (10.162.106.13) by
 SN1PR15MB0559.namprd15.prod.outlook.com (10.164.45.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Tue, 9 Oct 2018 14:29:43 +0000
Received: from SN1PR15MB0158.namprd15.prod.outlook.com
 ([fe80::5967:393c:29d7:b5ad]) by SN1PR15MB0158.namprd15.prod.outlook.com
 ([fe80::5967:393c:29d7:b5ad%8]) with mapi id 15.20.1228.020; Tue, 9 Oct 2018
 14:29:43 +0000
From:   Dan Schatzberg <dschatzberg@fb.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     Tejun Heo <tj@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fuse: enable caching of symlinks
Thread-Topic: [PATCH] fuse: enable caching of symlinks
Thread-Index: AQHUVmlm6B4VA33ox0WSe5595jPrUaUEJ6KAgBKhhQA=
Date:   Tue, 9 Oct 2018 14:29:43 +0000
Message-ID: <DC7A8BBA-6B24-4051-8EF6-10629EC3CA2E@fb.com>
References: <20180927135211.31641-1-dschatzberg@fb.com>
 <CAJfpegsRNv3Uby2w-B0+d4fE8ecSRkT0ef2AfQ_QnnEVT-nkmA@mail.gmail.com>
In-Reply-To: <CAJfpegsRNv3Uby2w-B0+d4fE8ecSRkT0ef2AfQ_QnnEVT-nkmA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c091:200::6:3927]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR15MB0559;20:iK9d6Z4VklfUOS/SmuVh/Y4617T5bFVDKHbAIa6JPGuz23rmUOIUEH7961R73vCP/WJ8HbHf9c5C1aJuc3Xmfl5+3wX+ehfhg+YNDimY9+sZ7tzCEql6j5HlZQPu0wWb9rEJZkGgN/4bs4We0uvAg/MYOlOK7GvsyjtgnwZEqSY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d47c25b1-e92d-417e-d8c1-08d62df3a7c4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0559;
x-ms-traffictypediagnostic: SN1PR15MB0559:
x-microsoft-antispam-prvs: <SN1PR15MB0559C957DA25EAF7096EC40AD0E70@SN1PR15MB0559.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(3002001)(3231355)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051);SRVR:SN1PR15MB0559;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0559;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(136003)(199004)(189003)(8936002)(14454004)(46003)(575784001)(86362001)(76176011)(316002)(6246003)(54906003)(99286004)(81156014)(446003)(106356001)(2906002)(11346002)(105586002)(305945005)(7736002)(81166006)(4326008)(486006)(33656002)(8676002)(6506007)(476003)(2616005)(53546011)(82746002)(2900100001)(53936002)(6486002)(6512007)(229853002)(6436002)(478600001)(71190400001)(71200400001)(6916009)(36756003)(5660300001)(6116002)(83716004)(256004)(25786009)(14444005)(5250100002)(186003)(68736007)(102836004)(5024004)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0559;H:SN1PR15MB0158.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rgiUCbJhi5vE2ahdwsAU8ceyfKpQg3OyY8F10mslGJBmIMMKeB/z/kklqeyqS2TOYcBmyF+GObGeKDc2LHCQ8ckVoYCrJ3KmDwrMnUagOyAZzyeh6RXK5iT4ZidzCKaMlQ7WoFfUG57x/iK0EKt/4sSW1xmMokPNCCo5V4CmvmU6rSIZCZET82Y6rl61PppO5r5HbFoX7vbDq8pK1TmXRVO9riGVP+DeKMjOV/uk9Mw477pSJuPHej4fWmTSmNeJzM5yXbpSyAL63SRwSVUDIULs3KofZSDJU2xUmGQcmuxPDKNBPF7ICbWE7Gg35LZW+W6p+FgWqBa1TynYSTlEgA46OQ+vxS2woU8HRe8jXwU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <183E19A37E39DF4FB916CC341E8017DF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d47c25b1-e92d-417e-d8c1-08d62df3a7c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 14:29:43.3481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0559
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_09:,,
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
DQo+PiBTaWduZWQtb2ZmLWJ5OiBEYW4gU2NoYXR6YmVyZyA8ZHNjaGF0emJlcmdAZmIuY29tPg0K
Pj4gLS0tDQo+PiAgZnMvZnVzZS9kaXIuYyB8IDcwICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRp
b25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvZnVzZS9kaXIu
YyBiL2ZzL2Z1c2UvZGlyLmMNCj4+IGluZGV4IDA5Nzk2MDlkNmViYS4uM2MwYTgxZWY1YmNhIDEw
MDY0NA0KPj4gLS0tIGEvZnMvZnVzZS9kaXIuYw0KPj4gKysrIGIvZnMvZnVzZS9kaXIuYw0KPj4g
QEAgLTEzOTgsMzggKzEzOTgsNDYgQEAgc3RhdGljIGludCBmdXNlX3JlYWRkaXIoc3RydWN0IGZp
bGUgKmZpbGUsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQ0KPj4gICAgICAgICByZXR1cm4gZXJy
Ow0KPj4gIH0NCj4+DQo+PiAtc3RhdGljIGNvbnN0IGNoYXIgKmZ1c2VfZ2V0X2xpbmsoc3RydWN0
IGRlbnRyeSAqZGVudHJ5LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IGlub2RlICppbm9kZSwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBkZWxheWVkX2NhbGwgKmRvbmUpDQo+PiArc3RhdGljIGludCBmdXNlX3N5bWxpbmtfcmVh
ZHBhZ2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBwYWdlICpwYWdlKQ0KPj4gIHsNCj4+ICsg
ICAgICAgc3RydWN0IGlub2RlICppbm9kZSA9IHBhZ2UtPm1hcHBpbmctPmhvc3Q7DQo+PiAgICAg
ICAgIHN0cnVjdCBmdXNlX2Nvbm4gKmZjID0gZ2V0X2Z1c2VfY29ubihpbm9kZSk7DQo+PiAtICAg
ICAgIEZVU0VfQVJHUyhhcmdzKTsNCj4+IC0gICAgICAgY2hhciAqbGluazsNCj4+IC0gICAgICAg
c3NpemVfdCByZXQ7DQo+PiAtDQo+PiAtICAgICAgIGlmICghZGVudHJ5KQ0KPj4gLSAgICAgICAg
ICAgICAgIHJldHVybiBFUlJfUFRSKC1FQ0hJTEQpOw0KPj4gKyAgICAgICBzdHJ1Y3QgZnVzZV9y
ZXEgKnJlcTsNCj4+ICsgICAgICAgaW50IGVycjsNCj4+ICsgICAgICAgc2l6ZV90IG51bV9yZWFk
Ow0KPj4NCj4+IC0gICAgICAgbGluayA9IGttYWxsb2MoUEFHRV9TSVpFLCBHRlBfS0VSTkVMKTsN
Cj4+IC0gICAgICAgaWYgKCFsaW5rKQ0KPj4gLSAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRS
KC1FTk9NRU0pOw0KPj4gKyAgICAgICBlcnIgPSAtRUlPOw0KPj4gKyAgICAgICBpZiAoaXNfYmFk
X2lub2RlKGlub2RlKSkNCj4+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsNCj4+DQo+PiAtICAg
ICAgIGFyZ3MuaW4uaC5vcGNvZGUgPSBGVVNFX1JFQURMSU5LOw0KPj4gLSAgICAgICBhcmdzLmlu
Lmgubm9kZWlkID0gZ2V0X25vZGVfaWQoaW5vZGUpOw0KPj4gLSAgICAgICBhcmdzLm91dC5hcmd2
YXIgPSAxOw0KPj4gLSAgICAgICBhcmdzLm91dC5udW1hcmdzID0gMTsNCj4+IC0gICAgICAgYXJn
cy5vdXQuYXJnc1swXS5zaXplID0gUEFHRV9TSVpFIC0gMTsNCj4+IC0gICAgICAgYXJncy5vdXQu
YXJnc1swXS52YWx1ZSA9IGxpbms7DQo+PiAtICAgICAgIHJldCA9IGZ1c2Vfc2ltcGxlX3JlcXVl
c3QoZmMsICZhcmdzKTsNCj4+IC0gICAgICAgaWYgKHJldCA8IDApIHsNCj4+IC0gICAgICAgICAg
ICAgICBrZnJlZShsaW5rKTsNCj4+IC0gICAgICAgICAgICAgICBsaW5rID0gRVJSX1BUUihyZXQp
Ow0KPj4gLSAgICAgICB9IGVsc2Ugew0KPj4gLSAgICAgICAgICAgICAgIGxpbmtbcmV0XSA9ICdc
MCc7DQo+PiAtICAgICAgICAgICAgICAgc2V0X2RlbGF5ZWRfY2FsbChkb25lLCBrZnJlZV9saW5r
LCBsaW5rKTsNCj4+ICsgICAgICAgcmVxID0gZnVzZV9nZXRfcmVxKGZjLCAxKTsNCj4+ICsgICAg
ICAgaWYgKElTX0VSUihyZXEpKSB7DQo+PiArICAgICAgICAgICAgICAgZXJyID0gUFRSX0VSUihy
ZXEpOw0KPj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4gICAgICAgICB9DQo+PiArDQo+
PiArICAgICAgIHJlcS0+b3V0LnBhZ2VfemVyb2luZyA9IDE7DQo+PiArICAgICAgIHJlcS0+b3V0
LmFyZ3BhZ2VzID0gMTsNCj4+ICsgICAgICAgcmVxLT5udW1fcGFnZXMgPSAxOw0KPj4gKyAgICAg
ICByZXEtPnBhZ2VzWzBdID0gcGFnZTsNCj4+ICsgICAgICAgcmVxLT5wYWdlX2Rlc2NzWzBdLmxl
bmd0aCA9IFBBR0VfU0laRSAtIDE7DQo+PiArICAgICAgIHJlcS0+aW4uaC5vcGNvZGUgPSBGVVNF
X1JFQURMSU5LOw0KPj4gKyAgICAgICByZXEtPmluLmgubm9kZWlkID0gZ2V0X25vZGVfaWQoaW5v
ZGUpOw0KPj4gKyAgICAgICByZXEtPm91dC5hcmd2YXIgPSAxOw0KPj4gKyAgICAgICByZXEtPm91
dC5udW1hcmdzID0gMTsNCj4+ICsgICAgICAgcmVxLT5vdXQuYXJnc1swXS5zaXplID0gUEFHRV9T
SVpFIC0gMTsNCj4+ICsgICAgICAgZnVzZV9yZXF1ZXN0X3NlbmQoZmMsIHJlcSk7DQo+PiArICAg
ICAgIG51bV9yZWFkID0gcmVxLT5vdXQuYXJnc1swXS5zaXplOw0KPj4gKyAgICAgICBlcnIgPSBy
ZXEtPm91dC5oLmVycm9yOw0KPj4gKw0KPj4gKyAgICAgICBpZiAoIWVycikNCj4+ICsgICAgICAg
ICAgICAgICBTZXRQYWdlVXB0b2RhdGUocGFnZSk7DQo+PiArDQo+PiArICAgICAgIGZ1c2VfcHV0
X3JlcXVlc3QoZmMsIHJlcSk7DQo+PiAgICAgICAgIGZ1c2VfaW52YWxpZGF0ZV9hdGltZShpbm9k
ZSk7DQo+PiAtICAgICAgIHJldHVybiBsaW5rOw0KPj4gK291dDoNCj4+ICsgICAgICAgdW5sb2Nr
X3BhZ2UocGFnZSk7DQo+PiArICAgICAgIHJldHVybiBlcnI7DQo+PiAgfQ0KPj4NCj4+ICBzdGF0
aWMgaW50IGZ1c2VfZGlyX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZp
bGUpDQo+PiBAQCAtMTg1NSw3ICsxODYzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbm9kZV9v
cGVyYXRpb25zIGZ1c2VfY29tbW9uX2lub2RlX29wZXJhdGlvbnMgPSB7DQo+Pg0KPj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgaW5vZGVfb3BlcmF0aW9ucyBmdXNlX3N5bWxpbmtfaW5vZGVfb3BlcmF0
aW9ucyA9IHsNCj4+ICAgICAgICAgLnNldGF0dHIgICAgICAgID0gZnVzZV9zZXRhdHRyLA0KPj4g
LSAgICAgICAuZ2V0X2xpbmsgICAgICAgPSBmdXNlX2dldF9saW5rLA0KPj4gKyAgICAgICAuZ2V0
X2xpbmsgICAgICAgPSBwYWdlX2dldF9saW5rLA0KPj4gICAgICAgICAuZ2V0YXR0ciAgICAgICAg
PSBmdXNlX2dldGF0dHIsDQo+PiAgICAgICAgIC5saXN0eGF0dHIgICAgICA9IGZ1c2VfbGlzdHhh
dHRyLA0KPj4gIH07DQo+PiBAQCAtMTg3MSw3ICsxODc5LDE1IEBAIHZvaWQgZnVzZV9pbml0X2Rp
cihzdHJ1Y3QgaW5vZGUgKmlub2RlKQ0KPj4gICAgICAgICBpbm9kZS0+aV9mb3AgPSAmZnVzZV9k
aXJfb3BlcmF0aW9uczsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYWRkcmVz
c19zcGFjZV9vcGVyYXRpb25zIGZ1c2Vfc3ltbGlua19hb3BzID0gew0KPj4gKyAgICAgICAucmVh
ZHBhZ2UgICAgICAgPSBmdXNlX3N5bWxpbmtfcmVhZHBhZ2UsDQo+PiArfTsNCj4+ICsNCj4+ICB2
b2lkIGZ1c2VfaW5pdF9zeW1saW5rKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQo+PiAgew0KPj4gICAg
ICAgICBpbm9kZS0+aV9vcCA9ICZmdXNlX3N5bWxpbmtfaW5vZGVfb3BlcmF0aW9uczsNCj4+ICsg
ICAgICAgaW5vZGUtPmlfZGF0YS5hX29wcyA9ICZmdXNlX3N5bWxpbmtfYW9wczsNCj4+ICsgICAg
ICAgbWFwcGluZ19zZXRfZ2ZwX21hc2soaW5vZGUtPmlfbWFwcGluZywNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIG1hcHBpbmdfZ2ZwX2NvbnN0cmFpbnQoaW5vZGUtPmlfbWFwcGluZywNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+KF9fR0ZQX0ZTIHwgX19H
RlBfSElHSE1FTSkpKTsNCj4+ICB9DQo+PiAtLQ0KPj4gMi4xNy4xDQoNCg0K
