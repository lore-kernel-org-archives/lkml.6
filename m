Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2780C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8423F215F9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="Y4fDnf2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8423F215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbeGBQPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:15:17 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:48886 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752235AbeGBQPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1530547652; x=1562083652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2IDJh5xW4YZKAP0WWI0tp9+X/6S1/PJybvnG4MUkZyU=;
  b=Y4fDnf2lnOQzXwKy5sTdVCz51tOvCB+WoapN9EjY5KioYfS5n+4XCz5u
   oao/0eqhQ+0H9SK1TPljnLP6s1BDI/PuHyHP8pRHofk01k3CvlW5M7xkv
   Q3dg0hBappaxJRm9K3VvCeJk3Ri/ihszQsD6rsVRxjgdkeqRCKmNr8AYq
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FJAgBxTTpbmMuZ6ERcHAEBAQQBAQoBA?=
 =?us-ascii?q?YQdDn8oCoNvlEKCB5U4gSs7CyUJg3hGAheDHiE3FQECAQECAQECAQECEAEBAQE?=
 =?us-ascii?q?BCAsLBikjDII1Ig0ESzowAQEBAQEBAQEBAQEBAQEBGgINYwEBAQECASMRRRACA?=
 =?us-ascii?q?QgaAiYCAgJFEAIEDg2DGAGBdwgPp3uCHIhMgSkFgQuHYoIVgQ+CYS6DGAICgSI?=
 =?us-ascii?q?mY4I0glUCmUYHAoYGgmSGK4FIjBWHeoI5h1SBV4F1cIM6giMOCYNFilJvkEGBG?=
 =?us-ascii?q?gEB?=
X-IPAS-Result: =?us-ascii?q?A2FJAgBxTTpbmMuZ6ERcHAEBAQQBAQoBAYQdDn8oCoNvlEK?=
 =?us-ascii?q?CB5U4gSs7CyUJg3hGAheDHiE3FQECAQECAQECAQECEAEBAQEBCAsLBikjDII1I?=
 =?us-ascii?q?g0ESzowAQEBAQEBAQEBAQEBAQEBGgINYwEBAQECASMRRRACAQgaAiYCAgJFEAI?=
 =?us-ascii?q?EDg2DGAGBdwgPp3uCHIhMgSkFgQuHYoIVgQ+CYS6DGAICgSImY4I0glUCmUYHA?=
 =?us-ascii?q?oYGgmSGK4FIjBWHeoI5h1SBV4F1cIM6giMOCYNFilJvkEGBGgEB?=
Received: from esa5.dell-outbound2.iphmx.com ([68.232.153.203])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 11:07:31 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps301.us.dell.com ([143.166.148.223])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 22:11:30 +0600
X-LoopCount0: from 10.166.132.169
X-IronPort-AV: E=Sophos;i="5.51,299,1526360400"; 
   d="scan'208";a="182098894"
X-DLP:  DLP_GlobalPCIDSS
To:     <andy.shevchenko@gmail.com>
CC:     <stuart.w.hayes@gmail.com>, <dvhart@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v3] dcdbas: Add support for WSMT ACPI table
Thread-Topic: [PATCH v3] dcdbas: Add support for WSMT ACPI table
Thread-Index: AQHUA+s4lznLK12+Q0uzCL8QOq9XaKRgVv6fgBdXLySAAFzYgIAEBPIQgABsw4D//7DtYA==
Date:   Mon, 2 Jul 2018 16:15:12 +0000
Message-ID: <73c53c23c0824e4595292bfafc6054ee@ausx13mpc120.AMER.DELL.COM>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com>
 <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain>
 <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com>
 <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com>
 <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
 <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com>
 <CAHp75VfL3v8U6o36-e3+XPL53sb9wMUOXsL6gn3XE4=-kJjuKQ@mail.gmail.com>
 <367a12e9-7d10-98e4-4791-69cdc7d01129@gmail.com>
 <CAHp75VdSVLzNHnrOzzrBMf4X2Cg4QACRrnxKNkQzcYJ0h5W+tw@mail.gmail.com>
 <e17fbb51b98d45318001adb7eb6a51b2@ausx13mpc120.AMER.DELL.COM>
 <CAHp75VfNo9NVfgGn4Fqa5fA9zp47TkqHwn1MJ044qMQoMNMB-Q@mail.gmail.com>
In-Reply-To: <CAHp75VfNo9NVfgGn4Fqa5fA9zp47TkqHwn1MJ044qMQoMNMB-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gPiBJIGRvbid0IGJlbGlldmUgU01NIGNvbW11bmljYXRpb24gQUNQSSB0YWJsZSBoYXMg
ZXZlciBiZWVuIGltcGxlbWVudGVkIGJ5DQo+IERlbGwNCj4gPiBvbiBzZXJ2ZXIgb3IgY2xpZW50
IEJJT1MuICBJIGRvIGFncmVlIHRoaXMgdGFibGUgZGVzY3JpYmVzIHRoZSBiZWhhdmlvciB0aGF0
IERDREJBUw0KPiBkcml2ZXINCj4gPiBoYXMgdXNlZCBzaW5jZSBiZWZvcmUgZXZlbiBVRUZJIEJJ
T1MgcHJldHR5IGFjY3VyYXRlbHkuDQo+IA0KPiBTbywgRVBTIHRhYmxlIGhhcyBiZWVuIGZvciBh
Z2VzIGluIERlbGwgbWFjaGluZXM/DQo+IENhbiB3ZSBjb25zaWRlciBpdCBhcyBhIHByZWRlY2Vz
c29yIG9mIHRoYXQgU01NIGNvbW11bmljYXRpb24gQUNQSSB0YWJsZT8NCg0KTm8sIEVQUyBpcyBu
ZXcgdGhpcyB5ZWFyLCBzcGVjaWZpY2FsbHkgZm9yIHNlcnZlciBCSU9TIHRvIGJlIGFibGUgdG8g
c3VwcG9ydCBTTU0gY29tbXVuaWNhdGlvbg0Kd2hlbiBXU01UIGlzIGVuYWJsZWQuICBUaGUgY29k
ZSB0ZXN0cyBpbiBTdHVhcnQncyBwYXRjaCB3aWxsIGRldGVjdCBpZiBXU01UIGlzIGVuYWJsZWQN
CmFuZCBpZiBpdCdzIGVuYWJsZWQgdGVzdCBpZiBFUFMgd2FzIGRlZmluZWQuICBPbiBzZXJ2ZXIg
QklPUyB3aGVuIEVQUyBpcyBkZWZpbmVkIGRjZGJhcw0Kd2lsbCBiZSBhYmxlIHRvIGNvbW11bmlj
YXRlIHVzaW5nIGFkZHJlc3NlcyBkZWZpbmVkIGluIEVQUy4NCg0KU2VydmVyIEJJT1Mgd2lsbCBz
dXBwb3J0IEVQUyBmb3IgYXBwbGljYXRpb25zIHVzaW5nIGRjZGJhcyBpbnRlcmZhY2UgYW5kIG1h
eSBhdCBhIGxhdGVyIHRpbWUNCmludHJvZHVjZSBzYW1lIFdNSSBpbnRlcmZhY2UgYXMgY2xpZW50
IHRvbyAoYnV0IGFwcGxpY2F0aW9ucyB3aWxsIG5lZWQgdGltZSB0byB1cGRhdGUgc28NCnRoZXkg
bmVlZCB0byBzdXBwb3J0IGJvdGgpLg0KDQpBY3R1YWxseSBTdHVhcnQncyBwYXRjaCB3aWxsIGNh
dXNlIGNsaWVudCBCSU9TIHRoYXQgaGFzIFdTTVQgZW5hYmxlZCBtYWtlIGRjZGJhcyBmYWlsDQpp
bml0aWFsaXphdGlvbiAoYXMgaXQgc2hvdWxkIGJlY2F1c2UgZGNkYmFzIGRvZXNuJ3QgaGF2ZSBh
IHJlZ2lvbiB0aGF0IGl0IGNhbiBzdWNjZXNzZnVsbHkNCmNvbW11bmljYXRlKS4gIA0KDQpJbiBj
bGllbnQgbWFjaGluZXMgd2UgbW92ZWQgdGhpcyBjb21tdW5pY2F0aW9uIHRvIEFDUEkgYnVmZmVy
IGFsbG9jYXRlZCBieSBXTUksIHdoaWNoDQppcyB3aHkgd2UgaGF2ZSBkZWxsLXNtYmlvcy13bWkg
bm93IGluIGtlcm5lbC4NCg0KSSB0aGluayBvbmNlIHNvbWUgdmFyaWF0aW9uIG9mIFN0dWFydCdz
IHBhdGNoIGlzIG1lcmdlZCwgSSdsbCBzZW5kIGEgZm9sbG93DQp1cCBwYXRjaCB0byBkcm9wIHRo
aXMgdGVzdCBiZWNhdXNlIGl0J3Mgbm8gbG9uZ2VyIG5lY2Vzc2FyeToNCmh0dHBzOi8vZ2l0aHVi
LmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxs
LXNtYmlvcy1zbW0uYyNMMTA2DQoNCg0KPiANCj4gPiBTdHVhcnQgYW5kIEkgZGlkIGRpc2N1c3Mg
d2l0aCBzZXJ2ZXIgQklPUyAod2hvIHVzZXMgdGhpcyBFUFMgbWVjaGFuaXNtKSB0byBzZWUgaWYN
Cj4gaXRzIHBvc3NpYmxlDQo+ID4gdG8gbW92ZSBFUFMgdG8gU01NIGNvbW11bmljYXRpb24gQUNQ
SSB0YWJsZSBob3dldmVyIHNpbmNlIGl0J3MgYmVlbg0KPiBkZXByZWNhdGVkIGJ5DQo+ID4gVUVG
SSAyLjcgdGhleSB3ZXJlbid0IHdpbGxpbmcgdG8gYWRvcHQgaXQuDQo+IA0KPiBJdCdzIHBpdHks
IGJ1dCB0aGUgbW90aXZhdGlvbiB0byBkZXByZWNhdGUgaXMgImxhY2sgb2YgdXNlIiB3aGljaCBp
cw0KPiBub3QgdHJ1ZS4gVGhhdCdzIHdoeSBJIHdvdWxkIHN1Z2dlc3QgdG8gZXNjYWxhdGUgdGhp
cyB0byBVRUZJDQo+IGNvbW1pdHRlZS4NCj4gDQo+ID4gU3R1YXJ0LCBhbnl0aGluZyBlbHNlIHlv
dSB3YW50IHRvIGFkZCBoZXJlPw0KPiANCj4gRGFycmVuLCB3aGF0J3MgeW91ciBvcGluaW9uIGFi
b3V0IHRoaXM/DQo+IA0KPiBQLlMuIEknbSBub3QgYWdhaW5zdCB0aGlzIGFwcHJvYWNoIChqdXN0
IHNvbWUgdGVjaG5pY2FsIGNvbW1lbnRzIEkNCj4gYWxyZWFkeSBzaGFyZWQpLCBidXQgb24gdGhl
IG90aGVyIGhhbmQgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIHVuZG8NCj4gdGhhdCBkZXByZWNh
dGlvbiBhbmQgZm9sbG93IHRoZSBzdGFuZGFyZCBpbiBuZXcgZmlybXdhcmVzLg0KPiBXb3VsZCB5
b3UgYWdyZWU/DQoNClN1cmUuICBEdWUgdG8gdGhlIHRpbWluZyBvZiBob3cgbG9uZyB0aGlzIHdp
bGwgdGFrZSwgZXZlbiBpZiBTTU0gY29tbXVuaWNhdGlvbg0KQUNQSSB0YWJsZSBpcyB1bmRvbmUg
ZnJvbSBkZXByZWNhdGlvbiB3ZSBtYXkgaGF2ZSB0byBzdGlsbCBzdXBwb3J0IGJvdGggRVBTDQph
bmQgU01NIGNvbW11bmljYXRpb24gQUNQSSB0YWJsZSB0aG91Z2ggKG1heWJlIGl0IHdvdWxkIGJl
IG9yZGVyIG9mIHByZWZlcmVuY2UpLg0KDQoNCg==
