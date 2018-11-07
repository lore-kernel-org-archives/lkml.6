Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837D9C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482E120827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Hy27PtUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbeKGKhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:37:34 -0500
Received: from alln-iport-1.cisco.com ([173.37.142.88]:3861 "EHLO
        alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeKGKhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:37:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1552; q=dns/txt; s=iport;
  t=1541552971; x=1542762571;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TF5HhGIovnO/NrH/7tqPovQYcKYsiXuSaIWpI3/h1oE=;
  b=Hy27PtUXgXsFAcPKXN0AM4QPg05AANvWY/PMcVw5/sQ4sGIf9cD4fYam
   7pciGWVkkdA0eml706FltmU9Rc8/jwQ07gGWw24I1V+4u9lH6frLuBYSW
   EgcipwVFEtUHtQIAT5o0rvxcGC4jVmkOIPRyUd70TBzHPORlPryo6hCdh
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AFAAApOuJb/51dJa1kGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUgMBAQEBAQsBggNmgQInCoNslC+ZPYF6CwEBGA2ERwI?=
 =?us-ascii?q?Xg0EiNQwNAQMBAQIBAQJtHAyFOwIBAwEiEUUQAgEIGgImAgICJgoVEAIEAQ0?=
 =?us-ascii?q?FgyEBggEPqWWBLoQtAYV1FHeKbReBQT+BEScfgkyDGwMCgXWCbTGCJgKKd5R?=
 =?us-ascii?q?CCQKGbYYNhBYYgiKOQo0NihkCERSBJh8BNYFVcBVIEwoBgkEJixOFPkExAYw?=
 =?us-ascii?q?1gR8BAQ?=
X-IronPort-AV: E=Sophos;i="5.54,473,1534809600"; 
   d="scan'208";a="197334776"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 01:09:30 +0000
Received: from XCH-RTP-008.cisco.com (xch-rtp-008.cisco.com [64.101.220.148])
        by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id wA719UDj018524
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 7 Nov 2018 01:09:30 GMT
Received: from xch-rtp-001.cisco.com (64.101.220.141) by XCH-RTP-008.cisco.com
 (64.101.220.148) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 6 Nov
 2018 20:09:29 -0500
Received: from xch-rtp-001.cisco.com ([64.101.220.141]) by
 XCH-RTP-001.cisco.com ([64.101.220.141]) with mapi id 15.00.1395.000; Tue, 6
 Nov 2018 20:09:29 -0500
From:   "Nikunj Kela (nkela)" <nkela@cisco.com>
To:     Richard Weinberger <richard@nod.at>,
        "Daniel Walker (danielwa)" <danielwa@cisco.com>
CC:     Richard Weinberger <richard.weinberger@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Rod Whitby <rod@whitby.id.au>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Make JFFS2 endianness configurable
Thread-Topic: [PATCH] Make JFFS2 endianness configurable
Thread-Index: AQHUcjYrpHzq5iVzlUCHkRlsBI/3aKU73VoAgAAI7wCAAOI/AIAAZ5cAgAAQqQCAAAJHgIAGmWSA
Date:   Wed, 7 Nov 2018 01:09:29 +0000
Message-ID: <08C13A64-E842-4E4D-AD04-31C09DFD1108@cisco.com>
References: <20181101225603.17806-1-nkela@cisco.com>
 <CAFLxGvy-0-A1Ta1vf=o4q0tcJAdr+uv9eQc7UrnwqF9NkJiWUw@mail.gmail.com>
 <20181102211444.nqqqbd4w5diyqrfw@zorba> <2265901.Da3O5o3T4q@blindfold>
In-Reply-To: <2265901.Da3O5o3T4q@blindfold>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.118.127]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9145249FEF7EAF4D94F128212B92B15F@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-SMTP-Client: 64.101.220.148, xch-rtp-008.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBpbnB1dC4gSSBoYXZlIHBvc3RlZCBhbm90aGVyIHBhdGNoIHdpdGggbW91bnQg
b3B0aW9uOg0KDQpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbXRk
LzIwMTgtTm92ZW1iZXIvMDg1MjUyLmh0bWwNCg0KDQpPbiAxMS8yLzE4LCAyOjIzIFBNLCAiUmlj
aGFyZCBXZWluYmVyZ2VyIiA8cmljaGFyZEBub2QuYXQ+IHdyb3RlOg0KDQogICAgQW0gRnJlaXRh
ZywgMi4gTm92ZW1iZXIgMjAxOCwgMjI6MTQ6NDQgQ0VUIHNjaHJpZWIgRGFuaWVsIFdhbGtlcjoN
CiAgICA+ID4gTWFrZSBpdCBhIG1vdW50IG9wdGlvbiBhbmQgc3RvcmUgdGhlIGVuZGlhbm5lc3Mg
bW9kZSBpbiB0aGUgc3VwZXIgYmxvY2suDQogICAgPiANCiAgICA+IEl0J3MgYWN0dWFsbHkgYSBt
a2ZzIG9wdGlvbiBjdXJyZW50bHkuIEknbSBub3Qgc3VyZSBob3cgdGhhdCBmYWN0b3JzIGluLA0K
ICAgID4gDQogICAgPiBmcm9tIHRoZSBta2ZzLmpmZnMyIG1hbiBwYWdlLA0KICAgID4gDQogICAg
PiAgICAgICAgLWwsIC0tbGl0dGxlLWVuZGlhbg0KICAgID4gICAgICAgICAgICAgICBDcmVhdGUg
YSBsaXR0bGUtZW5kaWFuIEpGRlMyIGltYWdlLiAgRGVmYXVsdCBpcyB0byBtYWtlIGFuIGltYWdl
IHdpdGggdGhlIHNhbWUgZW5kaWFubmVzcyBhcyB0aGUgaG9zdC4NCiAgICA+IA0KICAgID4gICAg
ICAgIC1iLCAtLWJpZy1lbmRpYW4NCiAgICA+ICAgICAgICAgICAgICAgQ3JlYXRlIGEgYmlnLWVu
ZGlhbiBKRkZTMiBpbWFnZS4gIERlZmF1bHQgaXMgdG8gbWFrZSBhbiBpbWFnZSB3aXRoIHRoZSBz
YW1lIGVuZGlhbm5lc3MgYXMgdGhlIGhvc3QuDQogICAgDQogICAgQXMgbG9uZyB0aGlzIHNldHRp
bmcgaXMgbm90IHN0b3JlZCBpbiB0aGUgZmlsZXN5c3RlbSBpdHNlbGYsIGl0IGlzIHVzZWxlc3Mu
DQogICAgSUlSQyBpdCBqdXN0IGNvbnRyb2xzIHRoZSBlbmRpYW5uZXNzIHNldHRpbmcgZm9yIG1r
ZnMuamZmczIncw0KICAgIHQzMigpIGFuZCB0MTYoKSBtYWNyb3MuDQogICAgDQogICAgVGhhdCdz
IHdoeSBJIHRoaW5rIG9mIGEgbW91bnQgb3B0aW9uIGxpa2UgImZvcmNlX2VuZGlhbj0iLg0KICAg
IA0KICAgIFRoYW5rcywNCiAgICAvL3JpY2hhcmQNCiAgICANCiAgICANCiAgICANCg0K
