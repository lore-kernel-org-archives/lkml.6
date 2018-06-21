Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E774C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="PTQdH5eA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB2C20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbeFUBYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:24:49 -0400
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:57857 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754474AbeFUBYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1529544147; x=1561080147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A2thaCKaIkvqr9j7NvAgRA6GGsnXJy+VlTO/L4NgHL0=;
  b=PTQdH5eAgBpTo03S/JTHjvqjbEBxHvNIhWeYiQ4H4thEFNmOyF5O0cun
   2weeG+b2C0xt3qzfiyA1i04T6Ebb1e2eh20xuwMVIWns9CY7FP0rhodQE
   1T+pYxCkYjEHl3MVHFslW5AkyB1ap3aL7cNIsQ9nRlcw3mWGgux7QZrnI
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HyAAA4/SpbmMuZ6ERcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQdDn8oCoNvlEKCApZ5CyMLhD4CF4JhITgUAQIBAQEBAQECAQE?=
 =?us-ascii?q?CEAEBAQEBCAsLBikjDII1IhFLXAEBAQEBASMCDWMBAQEEIxFFDAQCAQgRBAEBA?=
 =?us-ascii?q?QICIwMCAgJEAQgIAgQBDQUIgx0BgX8Pqy2CHIhGaAWBC4dJghOBD4JeLoUBM4J?=
 =?us-ascii?q?HglUCmSQHAoV9iQuNSYodh0KBWIF0cIM3gi+IYoU+b45LgRoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HyAAA4/SpbmMuZ6ERcGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?dDn8oCoNvlEKCApZ5CyMLhD4CF4JhITgUAQIBAQEBAQECAQECEAEBAQEBCAsLB?=
 =?us-ascii?q?ikjDII1IhFLXAEBAQEBASMCDWMBAQEEIxFFDAQCAQgRBAEBAQICIwMCAgJEAQg?=
 =?us-ascii?q?IAgQBDQUIgx0BgX8Pqy2CHIhGaAWBC4dJghOBD4JeLoUBM4JHglUCmSQHAoV9i?=
 =?us-ascii?q?QuNSYodh0KBWIF0cIM3gi+IYoU+b45LgRoBAQ?=
Received: from esa5.dell-outbound2.iphmx.com ([68.232.153.203])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 20:22:27 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 07:15:22 +0600
X-LoopCount0: from 10.166.132.152
X-IronPort-AV: E=Sophos;i="5.51,249,1526360400"; 
   d="scan'208";a="215023759"
X-DLP:  DLP_GlobalPCIDSS
To:     <dvhart@infradead.org>, <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>, <mihai.dontu@gmail.com>
Subject: RE: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
Thread-Topic: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
Thread-Index: AQHUCN4YY2liD6RijkeGi9YUJab2eaRqIWsAgAABkwCAAAmIgP//vrog
Date:   Thu, 21 Jun 2018 01:24:34 +0000
Message-ID: <3974cbadd027497982b5a52c765fb698@ausx13mpc120.AMER.DELL.COM>
References: <20180620213141.GA8957@beast> <20180620233736.GA3250@fury>
 <CAGXu5jL4V9sL7Ai1SVTNkg8OE70c6kLJBdqNtj9Z06MOb4zG0g@mail.gmail.com>
 <20180621001721.GB3250@fury>
In-Reply-To: <20180621001721.GB3250@fury>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXJyZW4gSGFydCBbbWFpbHRv
OmR2aGFydEBpbmZyYWRlYWQub3JnXQ0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjAsIDIwMTgg
NzoxNyBQTQ0KPiBUbzogS2VlcyBDb29rDQo+IENjOiBMS01MOyBBbmR5IFNoZXZjaGVua287IFBs
YXRmb3JtIERyaXZlcjsgTWloYWkgRG9uyJt1OyBMaW1vbmNpZWxsbywgTWFyaW8NCj4gU3ViamVj
dDogUmU6IFtQQVRDSF0gcGxhdGZvcm0veDg2OiB3bWk6IERvIG5vdCBtaXggcGFnZXMgYW5kIGtt
YWxsb2MNCj4gDQo+IE9uIFdlZCwgSnVuIDIwLCAyMDE4IGF0IDA0OjQzOjE0UE0gLTA3MDAsIEtl
ZXMgQ29vayB3cm90ZToNCj4gPiBPbiBXZWQsIEp1biAyMCwgMjAxOCBhdCA0OjM3IFBNLCBEYXJy
ZW4gSGFydCA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+ID4gT24gV2VkLCBKdW4g
MjAsIDIwMTggYXQgMDI6MzE6NDFQTSAtMDcwMCwgS2VlcyBDb29rIHdyb3RlOg0KPiA+ID4+IFRo
ZSBwcm9iZSBoYW5kbGVyX2RhdGEgd2FzIGJlaW5nIGFsbG9jYXRlZCB3aXRoIF9fZ2V0X2ZyZWVf
cGFnZXMoKQ0KPiA+ID4+IGZvciBubyByZWFzb24gSSBjb3VsZCBmaW5kLiBUaGUgZXJyb3IgcGF0
aCB3YXMgdXNpbmcga2ZyZWUoKS4gU2luY2UNCj4gPiA+DQo+ID4gPiB2NCBvZiBNYXJpbydzIHNl
cmllcyB1c2VkIGttYWxsb2M6DQo+ID4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzk5ODU4MjcvDQo+ID4gPg0KPiA+ID4gVGhpcyB3YXMgY2hhbmdlZCBpbiB2MTAgdG8gdXNl
IF9fZ2V0X2ZyZWVfcGFnZXM6DQo+ID4gPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzEwMDE4MDIzLw0KPiA+ID4NCj4gPiA+IEJ1dC4uLiBJJ20gbm90IGZpbmRpbmcgdGhlIGRp
c2N1c3Npb24gdGhhdCBsZWQgdG8gdGhpcyBjaGFuZ2UuLi4uIE1hcmlvLA0KPiA+ID4gZG8geW91
IHJlY2FsbD8gU29tZXRoaW5nIGFib3V0IGNvbnRpZ3VvdXMgbWVtb3J5PyBXZSBoYWQgYSBzaW1p
bGFyDQo+ID4gPiBkaXNjdXNzaW9uIG9uIGFuIGVhcmxpZXIgc2VyaWVzOg0KPiA+ID4NCj4gPiA+
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvOTk3NTI3Ny8NCj4gPg0KPiA+IEZX
SVcsIGttYWxsb2MgZ2V0cyB5b3UgY29udGlndW91cyBtZW1vcnkuLi4NCj4gDQo+IFllYWgsIEkn
bSBub3QgZmluZGluZyBhIHZhbGlkIHJlYXNvbiB0byB1c2UgX19nZXRfZnJlZV9wYWdlcyBvdmVy
IGttYWxsb2MgaW4NCj4gdGhpcyBjYXNlLiBJJ2xsIGdpdmUgTWFyaW8gYSBjaGFuY2UgdG8gcmVz
cG9uZCBpbiBjYXNlIEknbSBqdXN0IG1pc3NpbmcNCj4gc29tZXRoaW5nLCBidXQgb3RoZXJ3aXNl
IHdpbGwgcGxhbiB0byBhcHBseSB0aGlzIHBhdGNoLg0KDQpJIHRoaW5rIGl0IHdhcyBmb3IgY29u
dGlndW91cyBtZW1vcnksIHNvIGlmIGttYWxsb2MgaXMgZ2l2aW5nIHRoYXQgSSBhZ3JlZQ0Kbm8g
bmVlZCB0byBrZWVwIF9fZ2V0X2ZyZWVfcGFnZXMgaW5zdGVhZC4NCg0KQWNrZWQtYnk6IE1hcmlv
IExpbW9uY2llbGxvIDxNYXJpby5saW1vbmNpZWxsb0BkZWxsLmNvbT4NCg0KVGhhbmtzLA0KDQo+
IA0KPiA+DQo+ID4gQnV0IGlmIHRoZSByZWFzb24gaXMgZm91bmQgYW5kIG5lZWRzIHRvIHN0YXks
IHRoZSBwcm9iZSBlcnJvciBwYXRoJ3MNCj4gPiBrZnJlZSgpIG5lZWRzIHRvIGJlIGZpeGVkLCBh
bmQgX19HRlBfQ09NUCBuZWVkcyB0byBiZSBhZGRlZCB0byB0aGUNCj4gPiBmcmVlIHBhZ2UgZmxh
Z3MuDQo+IA0KPiBHb3QgaXQsIHRoYW5rcyBLZWVzLg0KPiANCj4gLS0NCj4gRGFycmVuIEhhcnQN
Cj4gVk13YXJlIE9wZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyDQo=
