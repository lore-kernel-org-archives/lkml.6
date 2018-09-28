Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E56C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BD2204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WvvO/4Mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BD2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeI1U4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:56:09 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:41116 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeI1U4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:56:09 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 96ACC10C0F6E;
        Fri, 28 Sep 2018 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538145125; bh=q1h9ENHygeE89lD6FfafBAdW7I3ApbO1f4FnbqGLh/Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WvvO/4Mrh/MJFxE09QEOn1rdgG9XOhhaeADpN+Ne+81yi3h8nOGUWxQ5cliNjhMWC
         BD6np+h6xycBypbI92w4w07oj8Q9/Hd5Vu0wNorTdCHb9nFbYLWdMHSJwG2mcZpIw1
         6xAZXo8UxfzPMsocDUBTXZAxfnVHh3XftRda7azAdavwentXjeR4XGGnoZA2Qi0NbB
         NwxXa4BxqHauQAfTA2HcaOZX8860nxTbimxM8mC9oDhLDnHY9gHAKShN0maE4rOZpC
         2Oy3nTJArD7uGV9VMc2zUfu1wDuruNjbJri8K9Eug24d4OHKplYWK+tS2hs9G5pc5L
         ItL4DcR3Y1XWQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 51FBF3F4E;
        Fri, 28 Sep 2018 07:32:05 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Fri, 28 Sep 2018 07:32:04 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Fri,
 28 Sep 2018 16:32:02 +0200
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] DRM: VBLANK: provide valid timestamp for EVENT_FLIP
Thread-Topic: [PATCH] DRM: VBLANK: provide valid timestamp for EVENT_FLIP
Thread-Index: AQHUVaTd72K6txZPUEmQwUCRbzZgK6UCoZWAgAMBogA=
Date:   Fri, 28 Sep 2018 14:32:01 +0000
Message-ID: <1538145120.5186.6.camel@synopsys.com>
References: <20180926142535.17997-1-Eugeniy.Paltsev@synopsys.com>
         <20180926163723.GW9144@intel.com>
In-Reply-To: <20180926163723.GW9144@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <43575F86C0A4944BAA17EC090EFB7CF6@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA5LTI2IGF0IDE5OjM3ICswMzAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6
DQo+IE9uIFdlZCwgU2VwIDI2LCAyMDE4IGF0IDA1OjI1OjM1UE0gKzAzMDAsIEV1Z2VuaXkgUGFs
dHNldiB3cm90ZToNCj4gPiBJZiBkcml2ZXIvSFcgZG9lc24ndCBzdXBwb3J0IHZibGFuayBmdW5j
dGlvbmFsaXR5IChmb3IgZXhhbXBsZQ0KPiA+IFVETCBkcml2ZXIsIEFSQ1BHVSBkcml2ZXIsIC4u
Likgd2UgYWx3YXlzIGhhdmUgdmJsYW5rLT50aW1lID09IDAuDQo+ID4gSW4gcmVzdWx0IHdlIGFs
d2F5cyBwcm92aWRlIHplcm8gdGltZXN0YW1wIGZvcg0KPiA+IERSTV9FVkVOVF9GTElQX0NPTVBM
RVRFLiBUaGlzIGJyZWFrcyB1c2Vyc3BhY2UgYXBwcyAoZm9yIGV4YW1wbGUNCj4gPiB3ZXN0b24p
IHdoaWNoIHJlbGllcyBvbiB0aW1lc3RhbXAgdmFsdWUuDQo+ID4gDQo+ID4gU2V0dXAgdGltZSB0
byBwcm92aWRlIHZhbGlkIHRpbWVzdGFtcCBmb3IgRFJNX0VWRU5UX0ZMSVBfQ09NUExFVEUNCj4g
PiBldmVudC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1Z2Vu
aXkuUGFsdHNldkBzeW5vcHN5cy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9k
cm1fdmJsYW5rLmMgfCA5ICsrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5r
LmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX3ZibGFuay5jDQo+ID4gaW5kZXggMjhjZGNmNzZiNmY5
Li4wZDE5YWNhNDg3ODIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV92Ymxh
bmsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fdmJsYW5rLmMNCj4gPiBAQCAtOTEx
LDYgKzkxMSwxNSBAQCB2b2lkIGRybV9jcnRjX3NlbmRfdmJsYW5rX2V2ZW50KHN0cnVjdCBkcm1f
Y3J0YyAqY3J0YywNCj4gPiAgDQo+ID4gIAlpZiAoZGV2LT5udW1fY3J0Y3MgPiAwKSB7DQo+IA0K
PiBJZiB0aG9zZSBkcml2ZXJzIGRvbid0IHN1cHBvcnQgdmJsYW5rIHN0dWZmIHdoeSBhcmUgdGhl
eSBjYWxsaW5nDQo+IGJsZHJtX3ZhbmtfaW5pdCgpIHcvIG51bV9jcnRjcyA+IDA/IElmIHRoZXkg
ZGlkbid0IHRoZXknZCB0YWtlIHRoZQ0KPiBlbHNlIGJyYW5jaCB3aGljaCBhbHJlYWR5IGRvZXMg
d2hhdCB5b3Ugd2FudC4NCg0KSG1tLi4uDQpBcyBJIGNhbiBzZWUgVURMIGNhbGwgZHJtX3ZibGFu
a19pbml0KCkgd2l0aCBudW1fY3J0Y3MgPSAxIGJ1dCBVREwgSFcNCmRvZXNuJ3Qgc3VwcG9ydCB2
YmxhbmsgYXQgYWxsLg0KSSBndWVzcyBJIG5lZWQgdG8gZml4IGl0Lg0KDQo+ID4gIAkJc2VxID0g
ZHJtX3ZibGFua19jb3VudF9hbmRfdGltZShkZXYsIHBpcGUsICZub3cpOw0KPiA+ICsNCj4gPiAr
CQkvKg0KPiA+ICsJCSAqIElmIGRyaXZlci9IVyBkb2Vzbid0IHN1cHBvcnQgdmJsYW5rIGZ1bmN0
aW9uYWxpdHkgd2UNCj4gPiArCQkgKiBhbHdheXMgaGF2ZSB2YmxhbmstPnRpbWUgPT0gMC4gU2V0
dXAgdGltZSB0byBwcm92aWRlIHZhbGlkDQo+ID4gKwkJICogdGltZXN0YW1wIGZvciBEUk1fRVZF
TlRfRkxJUF9DT01QTEVURSBldmVudC4NCj4gPiArCQkgKi8NCj4gPiArCQlpZiAoIW5vdyAmJiBl
LT5ldmVudC5iYXNlLnR5cGUgPT0gRFJNX0VWRU5UX0ZMSVBfQ09NUExFVEUpDQo+ID4gKwkJCW5v
dyA9IGt0aW1lX2dldCgpOw0KPiA+ICsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJc2VxID0gMDsN
Cj4gPiAgDQo+ID4gLS0gDQo+ID4gMi4xNC40DQo+ID4gDQo+ID4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0
DQo+ID4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiA+IGh0dHBzOi8vdXJsZGVm
ZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbGlzdHMuZnJlZWRlc2t0b3Au
b3JnX21haWxtYW5fbGlzdGluZm9fZHJpLTJEZGV2ZWwmZD1Ed0lEQXcmYz1EUEw2X1hfNkprWEZ4
N0FYV3FCMHRnJnI9WmxKTjFNDQo+ID4gcmlQVVRrQktDclBTeDY3R21hcGxFVUdjQUVrOXlQdENM
ZFVYSSZtPTViYmI5U2VWWFRNUERhMWJYUXhxbEJJT25TZEthS1k1VzBCa01DZ3dpakUmcz01MEVo
QXBDWkFlTU1EVUVkNkZWcFhmNW93ZDFCaTN2bjVHYUJ0MEtFMkN3JmU9DQo+IA0KPiANCi0tIA0K
IEV1Z2VuaXkgUGFsdHNldg==
