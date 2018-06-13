Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E6187C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8459F208D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 22:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cray.com header.i=@cray.com header.b="W/zwhkU9";
	dkim=pass (1024-bit key) header.d=crayinc.onmicrosoft.com header.i=@crayinc.onmicrosoft.com header.b="icnaRfwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8459F208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cray.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935820AbeFMW1o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 18:27:44 -0400
Received: from esa2.cray.iphmx.com ([68.232.143.164]:37904 "EHLO
        esa2.cray.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935256AbeFMW1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 18:27:42 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 18:27:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=cray.com; i=@cray.com; q=dns/txt; s=cray1024;
  t=1528928862; x=1560464862;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UHATReheIWZSWk2u5y3KwZ42aAtIbiLFLD9XWletj4Q=;
  b=W/zwhkU9RSF9tI3uSnMQVmycpJxZormEUodJ3EnHDCj+RQCItaSSDnwh
   uSkdEwjFrPRa4g86M0kWmqZrwKH2Mr+2nX3vXPp0f8RocMzskFwjgLOG7
   C4wa6cdFMZP33eV5YXs0D2JPuX5k+qlC7Db8M4tt6BN0Bbeos20VTcALU
   s=;
X-IronPort-AV: E=Sophos;i="5.51,220,1526338800"; 
   d="scan'208";a="20065374"
X-Cray-OBMMKR: 1433258124 20065374
Received: from cray-smtp-2.cray.com (HELO CFWEX01.americas.cray.com) ([136.162.34.11])
  by esa2.cray.iphmx.com with ESMTP/TLS/AES256-SHA; 13 Jun 2018 23:18:14 +0100
Received: from CFWEXHYBRID.americas.cray.com (172.30.88.178) by
 CFWEX01.americas.cray.com (172.30.88.25) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Wed, 13 Jun 2018 17:18:14 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (216.32.180.24)
 by mail.cray.com (172.30.88.178) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Wed, 13 Jun 2018 17:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=crayinc.onmicrosoft.com; s=selector1-cray-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHATReheIWZSWk2u5y3KwZ42aAtIbiLFLD9XWletj4Q=;
 b=icnaRfwXtHZf9074VxIh1b4wQS6WDJ6P0v5jS4029Rs3I9X+uAEfnvHk826dubPs2vt13QuxE3ZK2kLKeoTog8qCuvIMk/Nb2bAY0QIKSFqLeKiFg4VeFYzvj83mtYPEDw/Ygf7iAvUBKJRSNX+ya90+rQuy0INtjH508nGwmfU=
Received: from SN2PR11MB0014.namprd11.prod.outlook.com (10.160.60.16) by
 SN2PR11MB0095.namprd11.prod.outlook.com (10.160.61.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.19; Wed, 13 Jun 2018 22:18:10 +0000
Received: from SN2PR11MB0014.namprd11.prod.outlook.com
 ([fe80::c10f:d224:e534:cb1c]) by SN2PR11MB0014.namprd11.prod.outlook.com
 ([fe80::c10f:d224:e534:cb1c%11]) with mapi id 15.20.0841.019; Wed, 13 Jun
 2018 22:18:03 +0000
From:   Doug Oucharek <doucharek@cray.com>
To:     James Simmons <jsimmons@infradead.org>
CC:     NeilBrown <neilb@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Drokin <oleg.drokin@intel.com>,
        "Amir Shehata" <amir.shehata@intel.com>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH v2 01/25] staging: lustre: libcfs: restore
 UMP handling
Thread-Topic: [lustre-devel] [PATCH v2 01/25] staging: lustre: libcfs: restore
 UMP handling
Thread-Index: AQHT91iN9x8YtlH2LUqa/xhf6WUwy6RHX3UAgBd2OwCAAARoAA==
Date:   Wed, 13 Jun 2018 22:18:03 +0000
Message-ID: <17F46A71-4A75-499D-9220-A8503C6C26F3@cray.com>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
 <1527603725-30560-2-git-send-email-jsimmons@infradead.org>
 <87muwiuiuz.fsf@notabene.neil.brown.name>
 <alpine.LFD.2.21.1806132248500.12664@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.21.1806132248500.12664@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [136.162.66.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR11MB0095;7:I4T9MstcUHdw7xqrwnhcdWknPBO+cBYQPOonssBC6VIcN3FmthI5mHXkJltUE+IKdM+GF8IayGLgm/REwgibcR1j8GpqFbYZWLFTg1djq0HiIYHeFlLVaNlJPamD0BeQY9fF8HI2nqzID0++VHEnrFtWVQXlq9BLlgPFwy2Wt9hUwl0QZbDD31QPw6cfc6flJwthI1/97tp+524DIPVRBbbSD7W+RGYvWTomvCZH/cUiF0N4LiyK3inil3OTdBed
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 6424dcc1-2707-4dbf-b8a2-08d5d17b882e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR11MB0095;
x-ms-traffictypediagnostic: SN2PR11MB0095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=doucharek@cray.com; 
x-microsoft-antispam-prvs: <SN2PR11MB0095654928756B2F00FDFE9DD47E0@SN2PR11MB0095.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(201166117486090);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN2PR11MB0095;BCL:0;PCL:0;RULEID:;SRVR:SN2PR11MB0095;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39380400002)(39850400004)(396003)(199004)(189003)(68736007)(229853002)(102836004)(2900100001)(97736004)(36756003)(14454004)(26005)(59450400001)(186003)(5250100002)(6506007)(53546011)(66066001)(6436002)(6486002)(76176011)(1720100001)(106356001)(105586002)(2906002)(6916009)(6512007)(6306002)(33656002)(478600001)(81166006)(8676002)(7736002)(81156014)(93886005)(305945005)(316002)(54906003)(8936002)(53936002)(6246003)(25786009)(3660700001)(4326008)(83716003)(486006)(82746002)(11346002)(446003)(476003)(3846002)(2616005)(966005)(3280700002)(6116002)(99286004)(86362001)(5660300001)(13693001)(16193025007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR11MB0095;H:SN2PR11MB0014.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: d9mBoiCIh8c+2iZkMXlwbSl8+Rkvg3Tm7C9toFbtO4CjDJ+AMve/Fn4Ru2f8nvygHu7Z5suhEi4fbXHypNLIVnD7+0qYO3w7YxCGH3O2G8Pn5fo6EHXJip3VU/REUXHXzGrvGE0TkQPfX9IcwMj5f8iR87L9VUJSFhk34rRMeKvP022LCHkevO6vlzlrPbIa
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC0D52A95A7992408A7A58AA4CA9F369@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6424dcc1-2707-4dbf-b8a2-08d5d17b882e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 22:18:03.6997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e7b8488a-c0cd-4614-aae1-996bfabec247
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR11MB0095
X-OriginatorOrg: cray.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEp1biAxMywgMjAxOCwgYXQgMzowMiBQTSwgSmFtZXMgU2ltbW9ucyA8anNpbW1vbnNA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiANCj4+PiBXaXRoIHRoZSBjbGVhbnVwIG9mIHRo
ZSBsaWJjZnMgU01QIGhhbmRsaW5nIGFsbCBVTVAgaGFuZGxpbmcNCj4+PiB3YXMgcmVtb3ZlZC4g
SW4gdGhlIHByb2Nlc3Mgbm93IHZhcmlvdXMgTlVMTCBwb2ludGVycyBhbmQNCj4+PiBlbXB0eSBm
aWVsZHMgYXJlIHJldHVybiBpbiB0aGUgVU1QIGNhc2Ugd2hpY2ggY2F1c2VzIGx1c3RyZQ0KPj4+
IHRvIGNyYXNoIGhhcmQuIFJlc3RvcmUgdGhlIHByb3BlciBVTVAgaGFuZGxpbmcgc28gTHVzdHJl
IGNhbg0KPj4+IHByb3Blcmx5IGZ1bmN0aW9uLg0KPj4gDQo+PiBDYW4ndCB3ZSBqdXN0IGdldCBs
dXN0cmUgdG8gaGFuZGxlIHRoZSBOVUxMIHBvaW50ZXI/DQo+PiBJcyBtb3N0IGNhc2VzLCB0aGUg
cG9pbnRlciBpcyBhY2Nlc3NlZCB0aHJvdWdoIGFuIGFjY2Vzc29yIGZ1bmN0aW9uLCBhbmQNCj4+
IG9uICFDT05GSUdfU01QLCB0aGF0IGNhbiBiZSBhIHN0YXRpYyBpbmxpbmUgdGhhdCBkb2Vzbid0
IGV2ZW4gbG9vayBhdA0KPj4gdGhlIHBvaW50ZXIuDQo+IA0KPiBMb3RzIG9mIE5VTEwgcG9pbnRl
ciBjaGVja3MgZm9yIGEgc3RydWN0dXJlIGFsbG9jYXRlZCBhdCBsaWJjZnMgbW9kdWxlIA0KPiBz
dGFydCBhbmQgb25seSBjbGVhbmVkIHVwIGF0IGxpYmNmcyByZW1vdmFsIGlzIG5vdCBhIGNsZWFu
IGFwcHJvYWNoLg0KPiBTbyBJIGhhdmUgdGhvdWdodCBhYm91dCBpdCBhbmQgSSBoYXZlIHRvIGFz
ayB3aHkgYWxsb2NhdGUgYSBnbG9iYWwNCj4gc3RydWN0IGNmc19jcHVfdGFibGUuIEl0IGNvdWxk
IGJlIG1hZGUgc3RhdGljIGFuZCBmaWxsIGl0IGluIHdoaWNoIHdvdWxkDQo+IGF2b2lkIHRoZSB3
aG9sZSBOVUxMIHBvaW50ZXIgaXNzdWUuIFBsdXMgZm9yIHRoZSBVTVAgY2FzZSB3aHkgYWxsb2Nh
dGUNCj4gYSBuZXcgY2ZzX2NwdV90YWJsZSB3aXRoIGNmc19jcHRfdGFibGVfYWxsb2MoKSB3aGlj
aCBpcyBleGFjdGx5IGxpa2UNCj4gdGhlIGRlZmF1bHQgVU1QIGNmc19jcHVfdGFibGUuIEluc3Rl
YWQgd2UgY291bGQganVzdCByZXR1cm4gdGhlIHBvaW50ZXINCj4gdG8gdGhlIHN0YXRpYyBkZWZh
dWx0IGNmc19jcHRfdGFiIGV2ZXJ5IHRpbWUuIFdlIHN0aWxsIGhhdmUgdGhlIE5VTEwNCj4gY3Ri
X2NwdW1hc2sgZmllbGQgdG8gZGVhbCB3aXRoLiBEb2VzIHRoYXQgc291bmQgbGlrZSBhIGJldHRl
ciBzb2x1dGlvbg0KPiB0byB5b3U/IERvdWcgd2hhdCBkbyB5b3UgdGhpbms/DQoNCkkgbGlrZSB5
b3VyIHN1Z2dlc3Rpb24sIEphbWVzLiAgQWx3YXlzIGhhdmluZyBhIGNmc19jcHVfdGFibGUgc28g
d2UgZG9u4oCZdCBoYXZlIHRvIHdvcnJ5IGFib3V0IGEgTlVMTCBwb2ludGVyIHdvdWxkIGJlIGdv
b2QuICBJIHRoaW5rIHdlIGNhbiB0cmFjayBkb3duIHRoZSBjb2RlIHdoaWNoIHJlbGllcyBvbiB0
aGUgY3B1bWFzayBmaWVsZCB0byBtYWtlIGl0IHNhZmUgZm9yIHRoZSBOVUxMIGNhc2UuICBJcyB0
aGVyZSBwb3NzaWJpbGl0eSBvZiBoYXZpbmcgYW4gZW1wdHkgY3B1bWFzayByYXRoZXIgdGhhbiBp
dCBiZWluZyBOVUxMPw0KDQo+IA0KPj4gSSByZWFsbHkgdGhpbmsgdGhpcyBpcyBhIHN0ZXAgYmFj
a3dhcmRzLiAgSWYgeW91IGNhbiBpZGVudGlmeSBzcGVjaWZpYw0KPj4gcHJvYmxlbXMgY2F1c2Vk
IGJ5IHRoZSBjdXJyZW50IGNvZGUsIEknbSBzdXJlIHdlIGNhbiBmaXggdGhlbS4NCj4+IA0KPj4+
IA0KPj4+IFNpZ25lZC1vZmYtYnk6IEphbWVzIFNpbW1vbnMgPHVqYS5vcm5sQHlhaG9vLmNvbT4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBBbWlyIFNoZWhhdGEgPGFtaXIuc2hlaGF0YUBpbnRlbC5jb20+
DQo+Pj4gSW50ZWwtYnVnLWlkOiBodHRwczovL2ppcmEuaHBkZC5pbnRlbC5jb20vYnJvd3NlL0xV
LTc3MzQNCj4+IA0KPj4gVGhpcyBidWcgZG9lc24ndCBzZWVtIHRvIG1lbnRpb24gdGhpcyBwYXRj
aCBhdCBhbGwNCj4+IA0KPj4+IFJldmlld2VkLW9uOiBodHRwOi8vcmV2aWV3LndoYW1jbG91ZC5j
b20vMTg5MTYNCj4+IA0KPj4gTm9yIGRvZXMgdGhpcyByZXZpZXcuDQo+IA0KPiBZZWFoIGl0cyBt
dXRhdGVkIHNvIG11Y2ggZnJvbSB3aGF0IGlzIGluIHRoZSBJbnRlbCB0cmVlLg0KPiBJIGRvIGJl
bGlldmUgaXQgd2FzIHRoZSBsYXN0IHBhdGNoIHRvIHRvdWNoIHRoaXMuDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGx1c3RyZS1kZXZlbCBtYWls
aW5nIGxpc3QNCj4gbHVzdHJlLWRldmVsQGxpc3RzLmx1c3RyZS5vcmcNCj4gaHR0cDovL2xpc3Rz
Lmx1c3RyZS5vcmcvbGlzdGluZm8uY2dpL2x1c3RyZS1kZXZlbC1sdXN0cmUub3JnDQoNCg==
