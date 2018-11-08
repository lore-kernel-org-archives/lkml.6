Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C019ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F226920684
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="DZamx/oD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F226920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeKIDiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:38:03 -0500
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:12241 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeKIDiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2336; q=dns/txt; s=iport;
  t=1541700085; x=1542909685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3IMbY4oi/HwUZsztMu3eSOUbBEj/tbdueVU2bY1+D5U=;
  b=DZamx/oD4Am/g8gW3ZdRgMcVNyHXJHotwBgKSkUk61ZOaW98rcg7vdSn
   JDF+u1SoxNe0gmeLYYerbCajV2nAm5vlFpQsvuhRnohHqscCZOWlqmZAH
   DsJm4LAApAQbik56mq/yJThv2Ht7Cwayjn5TDKRcRlAk60nsy9JrxDQkb
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ADAACdeORb/5FdJa1kGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBggNmgQInCoNuiBiLe4FoJZcygXoLAQE?=
 =?us-ascii?q?YDYRHAheDASI0DQ0BAwEBAgEBAm0cDIU7AQEEASIROA0QAgEIDgoCAiYCAgI?=
 =?us-ascii?q?mChUQAgQBDQWDIQGCAQ+oWIEuhC0BhXwUd4puF4FBP4E4DBOCTIMbAwKBXoM?=
 =?us-ascii?q?EMYImAp9ICQKGcIYNhBcYgiOOSY0giikCERSBJh04gVVwFUgTCgGCQQmLE4U?=
 =?us-ascii?q?+QTEBjDGBHwEB?=
X-IronPort-AV: E=Sophos;i="5.54,480,1534809600"; 
   d="scan'208";a="481963065"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 18:01:24 +0000
Received: from XCH-RTP-004.cisco.com (xch-rtp-004.cisco.com [64.101.220.144])
        by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id wA8I1OSo024711
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 8 Nov 2018 18:01:24 GMT
Received: from xch-rtp-001.cisco.com (64.101.220.141) by XCH-RTP-004.cisco.com
 (64.101.220.144) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 8 Nov
 2018 13:01:23 -0500
Received: from xch-rtp-001.cisco.com ([64.101.220.141]) by
 XCH-RTP-001.cisco.com ([64.101.220.141]) with mapi id 15.00.1395.000; Thu, 8
 Nov 2018 13:01:23 -0500
From:   "Nikunj Kela (nkela)" <nkela@cisco.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard.weinberger@gmail.com>
CC:     "linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
Thread-Topic: [PATCH] jffs2: implement mount option to configure endianness
Thread-Index: AQHUdhqbTj/3Cc5mIU2fPUfH4B/ycqVEWbYAgACWlICAAAK6AIAA6gMAgACks4A=
Date:   Thu, 8 Nov 2018 18:01:23 +0000
Message-ID: <B1D7CC34-C9D3-4745-94A1-3F713C1CB216@cisco.com>
References: <20181106214928.40020-1-nkela@cisco.com>
 <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
 <591D4732-BC3E-4F85-9277-25E049FFF4BA@cisco.com>
 <CAFLxGvz8QgK1P6d-_biSRk4fyYEobio315_tUP+cRXTvt+m1hA@mail.gmail.com>
 <01b82f6eb37b674effc6c8b0fa4a014deb401a85.camel@infradead.org>
In-Reply-To: <01b82f6eb37b674effc6c8b0fa4a014deb401a85.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.41.48.184]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D312EDA69CD6469B06F9880DD80453@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-SMTP-Client: 64.101.220.144, xch-rtp-004.cisco.com
X-Outbound-Node: rcdn-core-9.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMS84LzE4LCAxMjoxMiBBTSwgIkRhdmlkIFdvb2Rob3VzZSIgPGR3bXcyQGluZnJhZGVh
ZC5vcmc+IHdyb3RlOg0KDQogICAgT24gV2VkLCAyMDE4LTExLTA3IGF0IDE5OjE0ICswMTAwLCBS
aWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6DQogICAgPiBPbiBXZWQsIE5vdiA3LCAyMDE4IGF0IDc6
MDUgUE0gTmlrdW5qIEtlbGEgKG5rZWxhKSA8bmtlbGFAY2lzY28uY29tPiB3cm90ZToNCiAgICA+
ID4gSSBoYWQgdHJpZWQgdG8gdXNlIGNvbmZpZ3MgdG8gc3RhcnQgd2l0aCB2aWEgdGhlIGZvbGxv
d2luZyBwYXRjaCBob3dldmVyIEkgd2FzIGFkdmlzZWQgdG8gaGF2ZSBhIG1vdW50IG9wdGlvbjoN
CiAgICA+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW10ZC8y
MDE4LU5vdmVtYmVyLzA4NTEyNi5odG1sDQogICAgPiANCiAgICA+IEp1c3Qgc2hvdyBwZXJmb3Jt
YW5jZSBudW1iZXJzIG9uIGhvdyB5b3VyIGltcGxlbWVudGF0aW9uIGhhcyBhbiBpbXBhY3Qgb3Ig
bm90Lg0KICAgID4gU28gZmFyIHlvdXIgaW1wbGVtZW50YXRpb24gaXMgYWxzbyBub3QgbXVjaCBv
cHRpbWl6ZWQsIG1heWJlIGxpa2VseSgpDQogICAgPiBvciBzdGF0aWMga2V5cyBjYW4gaGVscC4u
Lg0KICAgIA0KICAgIFVzaW5nIGxpa2VseSgpIGZvciB0aGUgbmF0aXZlIGNhc2UgbWlnaHQgaGVs
cC4gU3RhdGljIGtleXMgbWlnaHQgaGVscCBhDQogICAgbGl0dGxlIG1vcmUsIGJ1dCBjb3VsZCBv
bmx5IHdvcmsgaWYgZXZlcnkgZmlsZSBzeXN0ZW0gaGFzIHRoZSAqc2FtZSoNCiAgICBlbmRpYW5u
ZXNzLiBVbmxlc3Mgd2UgZW5kIHVwIHdpdGggdGhyZWUgdmFyaWFudHMsIGZvciBuYXRpdmUgdnMu
IHN3YXANCiAgICB2cy4gcnVudGltZSBjaGVja2luZy4NCiAgICANCiAgICBXZSBhbHNvIGxvc2Ug
YSBidW5jaCBvZiB0aGUgb3B0aW1pc2F0aW9ucyB0aGF0IHdlIGdhaW5lZCBmcm9tIHVzaW5nDQog
ICAgX19idWlsdGluX3N3YWIgZnVuY3Rpb25zLCB3aGljaCBsZXQgdGhlIGNvbXBpbGVyIHNlZSB3
aGF0IHdhcyBnb2luZyBvbi4NCiAgICANCiAgICBCdXQgd2UgY2FuIGh5cG90aGVzaXNlIGFuZCBo
YW5kd2F2ZSBhYm91dCBpdCB1bnRpbCB0aGUgY293cyBjb21lIGhvbWU7DQogICAgSSdkIGxpa2Ug
dG8gc2VlIGEgcmVhbCB0ZXN0IG9mIHdoZXRoZXIgaXQgYWN0dWFsbHkgbWFrZXMgYSBkaWZmZXJl
bmNlDQogICAgdGhhdCB3ZSBjYXJlIGFib3V0Lg0KICAgIA0KICAgIElmIGl0IGRvZXMsIG9uZSBv
cHRpb24gbWlnaHQgYmUgdG8ganVzdCBidWlsZCBzZXBhcmF0ZSB2ZXJzaW9ucyBvZg0KICAgIHNj
YW4uYyBmb3IgZWFjaCBlbmRpYW5uZXNzLCBzaW5jZSB0aGF0J3MgdGhlIGNyaXRpY2FsIHBhdGgg
d2UgY2FyZQ0KICAgIGFib3V0Lg0KDQpJIHdvbmRlciBpZiB0aGlzIGZlYXR1cmUgaXMgcmVhbGx5
IHRoYXQgaW1wb3J0YW50IHRoYXQgd2UgbmVlZCB0byBkdXBsaWNhdGUgdGhlIGRyaXZlcnMuDQpB
bHNvLCBpdCBtaWdodCB0YWtlIHNvbWUgdGltZSBmb3IgbWUgdG8gZmluZCBzb21lIGRldmljZSB0
aGF0IEkgY2FuIHJ1biB0aGUgdGVzdHMgd2l0aCBhbmQgd2l0aG91dCB0aGlzIHBhdGNoLg0KSSBh
bSB3b25kZXJpbmcgaWYgd2UgY2FuIHN0aWxsIGNvbnNpZGVyIG15IGZpcnN0IHBhdGNoIHdpdGgg
Y29uZmlnIG9wdGlvbnMgYXMgYSBnb29kIGNvbXByb21pc2Ugb24gaXQ/DQogICAgDQoNCg==
