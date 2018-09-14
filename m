Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653AAFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D5920881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Sr56l4X8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D5920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hammerspace.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeINSMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:12:32 -0400
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:44871
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727773AbeINSMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT3168II2OTd0hiFWQGLtsztL/wvYvrmqrzThT0OEQI=;
 b=Sr56l4X81+0ZcVRVuhOFZjhSPQMpbPqoKMXKRSx3KiicgJsOOX7u7/HF6jJq+K1IQIkRfdmEVpxyk5RzGCo8WdQxiEkh2G9tx8Lh/R+kc1lH+oaMoYwIHEF/VYs1jzgWNU34B81hOsEmWpDS6UMvtLnBXvnPAZr5ivtnwop7oNY=
Received: from SN6PR13MB2494.namprd13.prod.outlook.com (52.135.95.148) by
 SN6PR13MB2413.namprd13.prod.outlook.com (52.135.94.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.9; Fri, 14 Sep 2018 12:57:26 +0000
Received: from SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::443b:db6b:be3e:ad21]) by SN6PR13MB2494.namprd13.prod.outlook.com
 ([fe80::443b:db6b:be3e:ad21%2]) with mapi id 15.20.1143.010; Fri, 14 Sep 2018
 12:57:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "viro@ZenIV.linux.org.uk" <viro@ZenIV.linux.org.uk>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 04/10] iov_iter: Add mapping and discard iterator types
Thread-Topic: [PATCH 04/10] iov_iter: Add mapping and discard iterator types
Thread-Index: AQHUS3nC7q3ZiVBfPkuS6Fk7tvHbzaTvLQoAgACQ+AA=
Date:   Fri, 14 Sep 2018 12:57:26 +0000
Message-ID: <a37220c23479c79239b046e2487cfc95544b8f13.camel@hammerspace.com>
References: <153685389564.14766.11306559824641824935.stgit@warthog.procyon.org.uk>
         <153685392942.14766.3347355712333618914.stgit@warthog.procyon.org.uk>
         <20180914041831.GY19965@ZenIV.linux.org.uk>
In-Reply-To: <20180914041831.GY19965@ZenIV.linux.org.uk>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.40.195.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2413;6:ircuwNyxWU2IXJjhAxuAPYHHTY/qlvfKQ+tw8hOBHA93X53G6WNqfy0Zitglzci3xNT97HQcVH96dQryPZlHBIc7Whw6gI86169CUiFsu30rhvYEFmDxBlHkbRWm2XeIkYWyIbTm2ChRGuXAcLjqYkk7l2ZVX74RrmpM3fqVsgU5IIw3P0D8SVuWYec7xyRq0b4CvrksBuzNrZlDYUWDc76ElUYxZHkNHcTDEHih0aoF4aB3Ze4lo/YCr59l125GHsGxGCCU8wxwglnSudFbGux9yWWUfYns+aonS3SU7plYJYgLq5meveFC8niEbX3ylzHj/MDTyUo7xYQARVOsqHlsl/vRBWUHvOR3dl5uUkY8CX8+uwof31tUMSjyUNyQbvD0/7G348EMzWE95KVAYDO68wxWPDuYBbXlJKfz7AdPfMZTQlbcoAQ7FDAQeSkfjcj5CtU9J1eoeP7qBvBYJQ==;5:gK8V2447Gi2RBViYfXbs0w48qM+BSlxazLzTyhP3XNHUpR+B9bXTOIrhVC960/KNDL60J4Yrh9j17k+XI57qyQZVM8V1kfh+E10sBLA7OL6SkY4nIdxMjjBbXTFQDgrqP+UQMVzwbnAGcdg8yY7/WTBo83E1kMgIovmGmRu1y9E=;7:ytKbwnQfCOVFUrC0H7jOE6LQQ7hoYtmql/HR1LSuVw2cDkoweGIHq9YXgEFCrp5ySAvo4H2IoRWF1gBlB+27OW6wsKYHL9LKt3Ye3GRPzuZV2Q6yhZHlAc3ZvqxfJT6o+CTzGehkKoXNd6PiVTby+VAFEnRgnemeU7FZ1s2P7HmJezSR3qYAv34y3cLdr+h34XohsM1A2n6ta8Wspg520xnimKPtERaxDF2N4wETPTmn3W+tbwH6IH0OyftG5Lpd
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 0be3d567-9eea-4565-d37e-08d61a419f51
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR13MB2413;
x-ms-traffictypediagnostic: SN6PR13MB2413:
x-microsoft-antispam-prvs: <SN6PR13MB2413A2826C6D7EDC24C33751B8190@SN6PR13MB2413.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(131327999870524);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231344)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:SN6PR13MB2413;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2413;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(256004)(76176011)(4326008)(110136005)(25786009)(54906003)(305945005)(66066001)(7736002)(5660300001)(68736007)(316002)(6116002)(105586002)(3846002)(106356001)(81156014)(2906002)(186003)(99286004)(36756003)(8936002)(478600001)(118296001)(8676002)(81166006)(14444005)(6486002)(6246003)(6346003)(5024004)(229853002)(26005)(102836004)(6506007)(53936002)(476003)(2900100001)(5250100002)(486006)(86362001)(2501003)(11346002)(2616005)(97736004)(446003)(6512007)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR13MB2413;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-microsoft-antispam-message-info: QndycvcZ+WNtl7/jpxPqIxNsVr/tdA5H7aEc1CJjl/pytEEEnb5yh/nVZWLpriPlN0fj9xrQjvWKHanvZbxV1Abrdhg3oXT5sOr9dRddPGWo0AG2+K4175tFRcChstkBWvcgKkCrk9s0VFd9kYNDA2SnEizLvqdO3NJ7DtV80L8f0zfS7zulk1tehTTillHIQ4bTo8sUL4eiIgydtBMGqNMPvXxz/qaed8AH656jO1PBdXgZMN/z+tftlXGRLoZZ/Fwnh023OIR0HyIC/3+lZ7mwdP47GSi0upnO2DfS0+NcwUXys5L/cCS3uFPg9nX/cfeZwAS74jWM2tRMjsVjP/LZloOExLJOyuOUXOwVtNs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8411263DE5D71344893DBC2D165D7217@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be3d567-9eea-4565-d37e-08d61a419f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 12:57:26.5718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA5LTE0IGF0IDA1OjE4ICswMTAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
aHUsIFNlcCAxMywgMjAxOCBhdCAwNDo1MjowOVBNICswMTAwLCBEYXZpZCBIb3dlbGxzIHdyb3Rl
Og0KPiA+IEFkZCB0d28gbmV3IGl0ZXJhdG9yIHR5cGVzIHRvIGlvdl9pdGVyOg0KPiA+IA0KPiA+
ICAoMSkgSVRFUl9NQVBQSU5HDQo+ID4gDQo+ID4gICAgICBUaGlzIHdhbGtzIHRocm91Z2ggYSBz
ZXQgb2YgcGFnZXMgYXR0YWNoZWQgdG8gYW4gYWRkcmVzc19zcGFjZQ0KPiA+IHRoYXQNCj4gPiAg
ICAgIGFyZSBwaW5uZWQgb3IgbG9ja2VkLCBzdGFydGluZyBhdCBhIGdpdmVuIHBhZ2UgYW5kIG9m
ZnNldCBhbmQNCj4gPiB3YWxraW5nDQo+ID4gICAgICBmb3IgdGhlIHNwZWNpZmllZCBhbW91bnQg
b2Ygc3BhY2UuICBBIGZhY2lsaXR5IHRvIGdldCBhDQo+ID4gY2FsbGJhY2sgZWFjaA0KPiA+ICAg
ICAgdGltZSBhIHBhZ2UgaXMgZW50aXJlbHkgcHJvY2Vzc2VkIGlzIHByb3ZpZGVkLg0KPiA+IA0K
PiA+ICAgICAgVGhpcyBpcyB1c2VmdWwgZm9yIGNvcHlpbmcgZGF0YSBmcm9tIHNvY2tldCBidWZm
ZXJzIHRvIGlub2Rlcw0KPiA+IGluDQo+ID4gICAgICBuZXR3b3JrIGZpbGVzeXN0ZW1zLg0KPiAN
Cj4gSW50ZXJlc3RpbmcuLi4gIFF1ZXN0aW9uczoNCj4gCSogd2hhdCB3aWxsIGhvbGQgdGhvc2Ug
cGFnZXM/ICBJT1csIHdoZXJlIHdpbGwgeW91DQo+IHVubG9jay9kcm9wL3doYXRub3QNCj4gdGhv
c2Ugc3Vja2VyPw0KPiAJKiAiY2FsbGJhY2siIHNvdW5kcyBkYW5nZXJvdXMgLSBpdCBhcHBlYXJz
IHRvIGltcGx5IHRoYXQgeW91DQo+IHdvbid0DQo+IGNvcHkgdG8vZnJvbSB0aGUgc2FtZSBwYWdl
IHR3aWNlLiAgTm90IHRydWUgZm9yIGEgbG90IG9mIGlvdl9pdGVyDQo+IHVzZXJzOyB3aGF0DQo+
IGhhcHBlbnMgaWYgeW91IHBhc3Mgc3VjaCBhIGJlYXN0IHRvIHRoZW0/DQo+IAkqIHdoeSBub3Qg
c2ltcGx5ICJidWlsZCBhbmQgcG9wdWxhdGUgSVRFUl9CVkVDIGFsaWFzaW5nIGEgcGllY2UNCj4g
b2YgbWFwcGluZyIsDQo+IHBvc3NpYmx5IGluICJncmFiIiBhbmQgImdyYWIrbG9jayIgdmFyaWFu
dHM/ICBUaG9zZSBJVEVSX01BUFBJTkcgZG8NCj4gc2VlbSB0byBiZQ0KPiByZWxhdGVkIHRvIElU
RVJfQlZFQywgYXQgdGhlIHZlcnkgbGVhc3QuICBOb3RlLCBCVFcsIHRoYXQNCj4gaW92X2l0ZXJf
Z2V0X3BhZ2VzLi4uKCkNCj4gbWlnaHQgbXV0YXRlIGludG8gc29tZXRoaW5nIHNpbWlsYXIgLSAi
YnVpbGQgYW5kIHBvcHVsYXRlIElURVJfQlZFQw0KPiBhbGlhc2luZyBhIHBpZWNlDQo+IG9mIGdp
dmVuIGlvdl9pdGVyIi4gIE9yLCBwZXJoYXBzLCBhIG5pY2VyLW9uLW1lbW9yeSBhbmFsb2d1ZSBv
Zg0KPiBJVEVSX0JWRUMgLQ0KPiB3aXRoIDxvZmZzZXQsIGJ5dGVzLCBwb2ludGVyIHRvIHBhZ2Vz
IGFycmF5PiBpbnN0ZWFkIG9mIDxvZmZzZXQsDQo+IGJ5dGVzLCBwYWdlPiBhcw0KPiBlbGVtZW50
cywgd2l0aCB0aGUgc2FtZSAicG9wdWxhdGUgZnJvbSBtYXBwaW5nIiB0byBnZXQgc29tZXRoaW5n
DQo+IHNpbWlsYXIgdG8geW91cg0KPiBmdW5jdGlvbmFsaXR5IGFuZCAicG9wdWxhdGUgZnJvbSBp
b3ZfaXRlciIgZm9yIGlvdl9pdGVyX2dldF9wYWdlcy4uLg0KPiByZXBsYWNlbWVudC4NCg0KQW5v
dGhlciBxdWVzdGlvbiB0aGF0IGlzIHJlbGV2YW50IGZvciBtb3N0IG5ldHdvcmtlZCBmaWxlc3lz
dGVtcw0KKGluY2x1ZGluZyBBRlMsIEkgYmVsaWV2ZSksIGlzIGhvdyB3aWxsIHlvdSBkZWFsIHdp
dGggZW5jcnlwdGlvbiBvZiB0aGUNCmRhdGEgeW91IGFyZSB0cmFuc21pdHRpbmc/IEVuY3J5cHRp
bmcgYW5kIGRlY3J5cHRpbmcgaW4tcGxhY2UgZGlyZWN0bHkNCmluIHRoZSBwYWdlIGNhY2hlIG9y
IGluIGEgdXNlcnNwYWNlIE9fRElSRUNUIG1hcHBlZCBidWZmZXIgbWlnaHQgbm90IGJlDQp0aGUg
YmVzdCBhbmQgbW9zdCBzZWN1cmUgb3B0aW9uLCBzbyB3b24ndCB5b3UgZmluZCB5b3Vyc2VsZiB3
YW50aW5nIHRvDQpjb3B5IHRoZSBkYXRhIGFueXdheT8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
