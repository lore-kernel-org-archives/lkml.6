Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C5BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50DE206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Q6JeIOvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50DE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeLEGeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:34:07 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:35363 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:34:07 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2018 01:34:06 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2710; q=dns/txt; s=iport;
  t=1543991646; x=1545201246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9aGH8LE+95x6txChuToa2qXVT0ZxSJwarg/VXGNOARk=;
  b=Q6JeIOvZFMHD+ufww2PliqZ7CCJW3tzoUO5xE8FsleJB4xoHTPCCi6KI
   uWhykKsnoVWku0os1gcg+e09Wkgi9YBm83jDd69hGM+cK8WyKDsK8BWkA
   KbRdtF5cd+jKMgUp7K9Tz/5HP+aDfuHu2hBFpBQO+oPGWK++Y7MhCI+fX
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ADAAAucAdc/4sNJK1kGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBggOBaCcKg2+IGY12JYkSjjoUgWYLAQG?=
 =?us-ascii?q?EbAIXgnQiNAkNAQMBAQIBAQJtKIU9AQUjEUUQAgEIGAICJgICAh8RFRACBAE?=
 =?us-ascii?q?NBYMhgWoDFaR4gS+EAgGEAA2CHIELixMXgUA/gTgME4JMgleCEi+CbTGCJgK?=
 =?us-ascii?q?JKIdYjyEuCQKOEYMuGJEsLIhdhXSJVQIRFIEnHziBVXAVZQGCQYInF41mATZ?=
 =?us-ascii?q?BMYsPgR8BAQ?=
X-IronPort-AV: E=Sophos;i="5.56,317,1539648000"; 
   d="scan'208";a="273501594"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 06:30:57 +0000
Received: from XCH-ALN-014.cisco.com (xch-aln-014.cisco.com [173.36.7.24])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id wB56UvFG003798
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 5 Dec 2018 06:30:57 GMT
Received: from xch-aln-003.cisco.com (173.36.7.13) by XCH-ALN-014.cisco.com
 (173.36.7.24) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 00:30:57 -0600
Received: from xch-aln-003.cisco.com ([173.36.7.13]) by XCH-ALN-003.cisco.com
 ([173.36.7.13]) with mapi id 15.00.1395.000; Wed, 5 Dec 2018 00:30:56 -0600
From:   "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: Re: [PATCH v2] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
Thread-Topic: [PATCH v2] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
Thread-Index: AQHUfDq2aTJBVdtYakmW9VN5ceo/AKVd4fgAgBIyt4D//5l8AA==
Date:   Wed, 5 Dec 2018 06:30:56 +0000
Message-ID: <12CB1ACA-CE7D-4534-87D2-CBD96E301D9A@cisco.com>
References: <5bec5342.1c69fb81.b02fa.ace9@mx.google.com>
 <CAJr6mf1d=tviauDfd4Hq_750mGiypheUxHhQEv_tsdR_TrTkNA@mail.gmail.com>
 <CAJr6mf1wqNq02e89U85u=h1Ge0MSzAOk+wQc9q_gWurEZzWZUw@mail.gmail.com>
In-Reply-To: <CAJr6mf1wqNq02e89U85u=h1Ge0MSzAOk+wQc9q_gWurEZzWZUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/f.22.0.170515
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.34.134]
Content-Type: text/plain; charset="utf-8"
Content-ID: <18DD16CDF211CB4C91FFB7E71A082844@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-SMTP-Client: 173.36.7.24, xch-aln-014.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZC4gQXBvbG9naXplIGZvciB0aGUgZGVsYXkgaW4gYWNrbm93bGVkZ2luZyB0aGUg
cGF0Y2guDQoNCkFja2VkLWJ5OiAgIFNlc2lkaGFyIEJhZGRlbGEgICAgPHNlYmFkZGVsQGNpc2Nv
LmNvbT4NCg0KDQpPbiAxMi80LzE4LCA4OjM3IFBNLCAiU2FieWFzYWNoaSBHdXB0YSIgPHNhYnlh
c2FjaGkubGludXhAZ21haWwuY29tPiB3cm90ZToNCg0KICAgIE9uIEZyaSwgTm92IDIzLCAyMDE4
IGF0IDg6MTMgUE0gU2FieWFzYWNoaSBHdXB0YQ0KICAgIDxzYWJ5YXNhY2hpLmxpbnV4QGdtYWls
LmNvbT4gd3JvdGU6DQogICAgPg0KICAgID4gT24gV2VkLCBOb3YgMTQsIDIwMTggYXQgMTA6MjQg
UE0gU2FieWFzYWNoaSBHdXB0YQ0KICAgID4gPHNhYnlhc2FjaGkubGludXhAZ21haWwuY29tPiB3
cm90ZToNCiAgICA+ID4NCiAgICA+ID4gUmVwbGFjZWQgdm1hbGxvYyArIG1lbXNldCB3aXRoIHZ6
YWxsb2MNCiAgICA+ID4NCiAgICA+ID4gU2lnbmVkLW9mZi1ieTogU2FieWFzYWNoaSBHdXB0YSA8
c2FieWFzYWNoaS5saW51eEBnbWFpbC5jb20+DQogICAgPg0KICAgID4gQW55IGNvbW1lbnQgb24g
dGhpcyBwYXRjaD8NCiAgICANCiAgICBBbnkgY29tbWVudCBvbiB0aGlzIHBhdGNoPw0KICAgIA0K
ICAgID4NCiAgICA+ID4gLS0tDQogICAgPiA+IHYyOiBSZW1vdmVkIGFkZGl0aW9uYWwgYnJhY2Vz
DQogICAgPiA+DQogICAgPiA+ICBkcml2ZXJzL3Njc2kvZm5pYy9mbmljX3RyYWNlLmMgfCAzICst
LQ0KICAgID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygt
KQ0KICAgID4gPg0KICAgID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL2ZuaWMvZm5pY190
cmFjZS5jIGIvZHJpdmVycy9zY3NpL2ZuaWMvZm5pY190cmFjZS5jDQogICAgPiA+IGluZGV4IDgy
NzE3ODUuLmJmMGZkMmEgMTAwNjQ0DQogICAgPiA+IC0tLSBhL2RyaXZlcnMvc2NzaS9mbmljL2Zu
aWNfdHJhY2UuYw0KICAgID4gPiArKysgYi9kcml2ZXJzL3Njc2kvZm5pYy9mbmljX3RyYWNlLmMN
CiAgICA+ID4gQEAgLTQ2OCwxNCArNDY4LDEzIEBAIGludCBmbmljX3RyYWNlX2J1Zl9pbml0KHZv
aWQpDQogICAgPiA+ICAgICAgICAgZm5pY19tYXhfdHJhY2VfZW50cmllcyA9ICh0cmFjZV9tYXhf
cGFnZXMgKiBQQUdFX1NJWkUpLw0KICAgID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBGTklDX0VOVFJZX1NJWkVfQllURVM7DQogICAgPiA+DQogICAgPiA+IC0g
ICAgICAgZm5pY190cmFjZV9idWZfcCA9ICh1bnNpZ25lZCBsb25nKXZtYWxsb2MoKHRyYWNlX21h
eF9wYWdlcyAqIFBBR0VfU0laRSkpOw0KICAgID4gPiArICAgICAgIGZuaWNfdHJhY2VfYnVmX3Ag
PSAodW5zaWduZWQgbG9uZyl2emFsbG9jKHRyYWNlX21heF9wYWdlcyAqIFBBR0VfU0laRSk7DQog
ICAgPiA+ICAgICAgICAgaWYgKCFmbmljX3RyYWNlX2J1Zl9wKSB7DQogICAgPiA+ICAgICAgICAg
ICAgICAgICBwcmludGsoS0VSTl9FUlIgUEZYICJGYWlsZWQgdG8gYWxsb2NhdGUgbWVtb3J5ICIN
CiAgICA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJmb3IgZm5pY190cmFj
ZV9idWZfcFxuIik7DQogICAgPiA+ICAgICAgICAgICAgICAgICBlcnIgPSAtRU5PTUVNOw0KICAg
ID4gPiAgICAgICAgICAgICAgICAgZ290byBlcnJfZm5pY190cmFjZV9idWZfaW5pdDsNCiAgICA+
ID4gICAgICAgICB9DQogICAgPiA+IC0gICAgICAgbWVtc2V0KCh2b2lkICopZm5pY190cmFjZV9i
dWZfcCwgMCwgKHRyYWNlX21heF9wYWdlcyAqIFBBR0VfU0laRSkpOw0KICAgID4gPg0KICAgID4g
PiAgICAgICAgIGZuaWNfdHJhY2VfZW50cmllcy5wYWdlX29mZnNldCA9DQogICAgPiA+ICAgICAg
ICAgICAgICAgICB2bWFsbG9jKGFycmF5X3NpemUoZm5pY19tYXhfdHJhY2VfZW50cmllcywNCiAg
ICA+ID4gLS0NCiAgICA+ID4gMi43LjQNCiAgICA+ID4NCiAgICANCg0K
