Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D657C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FD42089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZBdmz83F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FD42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJCVSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:18:49 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:51604 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:18:49 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 9B78B24E0C6C;
        Wed,  3 Oct 2018 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538577010; bh=jCwrxvquZwhcQq6ErYceNk7WwFVWns0zA3KwY27R6gc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZBdmz83FpQ1kFOKN4ER/wM3yRzPfmGT8EToPJIp/JMsNQwA9XdDkwv3nA++QoeGyb
         nNYohRTsGla//mg+xlu4EEw1XpTUhSaIdphq99eZPNKAebmzxJjR02/KFpaua7eVki
         bcQkMNob3JMAYShSTLOdjQLLBahNjhyGq03ix5WpCNbwB7hxCVuTWpGlsAskkQFytZ
         PxM4G4ZRgxS0P70peJm4y3S84R6pHoPe7OV5FOggMohyVUHDsVgVAX3kUYDUVsdBu+
         PUUHLQwESkkacEuQ1JptlJw4dSVD6Lq2EOVhRGOpPdDUbGIAkhlTDc5zQJgOrsRSGZ
         zmw8g1+xkAN7Q==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id E140434C0;
        Wed,  3 Oct 2018 07:30:08 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 3 Oct 2018 07:30:08 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 3 Oct 2018 16:30:06 +0200
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [PATCH] drm: fb-helper: Validate requested pixel format against
 bpp
Thread-Topic: [PATCH] drm: fb-helper: Validate requested pixel format
 against bpp
Thread-Index: AQHUWwj0P2RkEaxeWUikPZdEDLcF9KUNQuoAgAAPT4CAACFUAA==
Date:   Wed, 3 Oct 2018 14:30:05 +0000
Message-ID: <1538577004.11140.5.camel@synopsys.com>
References: <20181003110457.9318-1-Eugeniy.Paltsev@synopsys.com>
         <CAKMK7uFP3bMcNSY2L9ZmvFPz6KB51_gMnZ-b7FPCz3NEOafi=w@mail.gmail.com>
         <20181003123047.GK9144@intel.com>
In-Reply-To: <20181003123047.GK9144@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B80D7FA0D6CE947BF018A477450D5A5@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEwLTAzIGF0IDE1OjMwICswMzAwLCBWaWxsZSBTeXJqw6Rsw6Qgd3JvdGU6
DQo+IE9uIFdlZCwgT2N0IDAzLCAyMDE4IGF0IDAxOjM2OjAwUE0gKzAyMDAsIERhbmllbCBWZXR0
ZXIgd3JvdGU6DQo+ID4gT24gV2VkLCBPY3QgMywgMjAxOCBhdCAxOjA1IFBNIEV1Z2VuaXkgUGFs
dHNldg0KPiA+IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiA+IA0K
PiA+ID4gVmFsaWRhdGUgcmVxdWVzdGVkIHBpeGVsIGZvcm1hdCBhZ2FpbnN0IGJpdHNfcGVyX3Bp
eGVsIHRvIHJlamVjdA0KPiA+ID4gaW52YWxpZCBmb3JtYXRzIHdpdGggc3ViY29tcG9uZW50cyBs
ZW5ndGggc3VtIGlzIGdyZWF0ZXIgdGhhbiByZXF1ZXN0ZWQNCj4gPiA+IGJpdHNfcGVyX3BpeGVs
Lg0KPiA+ID4gDQo+ID4gPiB3ZXN0b24gNS4wLjAgd2l0aCBmYmRldiBiYWNrZW5kIHRyaWVzIHRv
IHNldCB1cCBhbiBBUkdCIHg4cjhnOGI4IHBpeGVsDQo+ID4gPiBmb3JtYXQgd2l0aG91dCBiaXRz
X3Blcl9waXhlbCB1cGRhdGluZy4gU28gaXQgY2FuIHJlcXVlc3QNCj4gPiA+IHg4cjhnOGI4IHdp
dGggMTYgYnBwIHdoaWNoIGlzIG9idmlvdXNseSBpbmNvcnJlY3QgYW5kIHNob3VsZCBiZQ0KPiA+
ID4gcmVqZWN0ZWQuDQo+ID4gPiANCj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBFdWdlbml5IFBhbHRzZXYgPEV1Z2VuaXkuUGFsdHNldkBzeW5v
cHN5cy5jb20+DQo+ID4gDQo+ID4gZHJtIGZiZGV2IGVtdWxhdGlvbiBkb2Vzbid0IHN1cHBvcnQg
Y2hhbmdpbmcgdGhlIHBpeGVsIGZvcm1hdCBhdCBhbGwuDQo+ID4gSSB0aGluayB3ZSBzaG91bGQg
cmVqZWN0IGFsbCBzdWNoIHJlcXVlc3QsIG5vdCBqdXN0IHRoZSBpbnZhbGlkIG9uZXMuDQo+ID4g
Q2FuIHlvdSBwbHMgcmVzcGluPw0KPiANCj4gRllJIEkgb25jZSBwb3N0ZWQgYSBwYXRjaCB0byB0
aWdodGVuIHVwIHRoZSBmYi1oZWxwZXIgcGl4ZWwgZm9ybWF0DQo+IHN0dWZmOg0KPiBodHRwczov
L3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMjAzMTg5Lw0KDQoNCkhpIERhbmllbCwN
Cg0Kd2lsbCB5b3UgdGFrZSBWaWxsZSdzIHBhdGNoIG9yIHNob3VsZCBJIGNyZWF0ZSB0aGUgbmV3
IG9uZSB3aGljaCBpcyBvbmx5IHJlbGF0ZWQNCnRvIG5ldyBwaXhlbCBmb3JtYXQgdmFsaWRhdGlv
biBpbiBkcm1fZmJfaGVscGVyX2NoZWNrX3ZhcigpID8NCg0KDQo+ID4gVGhhbmtzLCBEYW5pZWwN
Cj4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9kcm1fZmJfaGVscGVyLmMg
fCA3ICsrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4g
PiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2hlbHBlci5jIGIv
ZHJpdmVycy9ncHUvZHJtL2RybV9mYl9oZWxwZXIuYw0KPiA+ID4gaW5kZXggMTZlYzkzYjc1ZGJm
Li40ZjM5ZGEwN2YwNTMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2Zi
X2hlbHBlci5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2ZiX2hlbHBlci5jDQo+
ID4gPiBAQCAtMTYxMCw2ICsxNjEwLDEzIEBAIGludCBkcm1fZmJfaGVscGVyX2NoZWNrX3Zhcihz
dHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwNCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gPiA+ICAgICAgICAgfQ0KPiA+ID4gDQo+ID4gPiArICAgICAgIGlmICgo
dmFyLT5ncmVlbi5sZW5ndGggKyB2YXItPmJsdWUubGVuZ3RoICsgdmFyLT5yZWQubGVuZ3RoICsN
Cj4gPiA+ICsgICAgICAgICAgIHZhci0+dHJhbnNwLmxlbmd0aCkgPiB2YXItPmJpdHNfcGVyX3Bp
eGVsKSB7DQo+ID4gPiArICAgICAgICAgICAgICAgRFJNX0RFQlVHKCJmYiByZXF1ZXN0ZWQgcGl4
ZWwgZm9ybWF0IGNhbid0IGZpdCBpbiAlZCBicHBcbiIsDQo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgIHZhci0+Yml0c19wZXJfcGl4ZWwpOw0KPiA+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+ID4gKyAgICAgICB9DQo+ID4gPiArDQo+ID4gPiAgICAgICAgIHN3
aXRjaCAodmFyLT5iaXRzX3Blcl9waXhlbCkgew0KPiA+ID4gICAgICAgICBjYXNlIDE2Og0KPiA+
ID4gICAgICAgICAgICAgICAgIGRlcHRoID0gKHZhci0+Z3JlZW4ubGVuZ3RoID09IDYpID8gMTYg
OiAxNTsNCj4gPiA+IC0tDQo+ID4gPiAyLjE0LjQNCj4gPiA+IA0KPiA+ID4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiA+IGRyaS1kZXZlbCBtYWls
aW5nIGxpc3QNCj4gPiA+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+IGh0
dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnX21haWxtYW5fbGlzdGluZm9fZHJpLTJEZGV2ZWwmZD1Ed0lEQXcmYz1E
UEw2X1hfNkprWEZ4N0FYV3FCMHRnJnI9WmxKTg0KPiA+ID4gMU1yaVBVVGtCS0NyUFN4NjdHbWFw
bEVVR2NBRWs5eVB0Q0xkVVhJJm09ZjEyWnlFRVNJZWF2dHFDVUt1dGlaOUY2eHRSRkMyVVV2ZHFu
TTR5d0J4OCZzPUNQUzh0YU1pWWJJZ1hvLWZ4aHFFck9KWHZPNlBNVHptci1CTm5HSklveTAmZT0N
Cj4gPiANCj4gPiANCj4gPiANCj4gPiAtLSANCj4gPiBEYW5pZWwgVmV0dGVyDQo+ID4gU29mdHdh
cmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uDQo+ID4gKzQxICgwKSA3OSAzNjUgNTcgNDgg
LSBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cC0zQV9fYmxv
Zy5mZndsbC5jaCZkPUR3SURBdyZjPURQTDZfWF82SmtYRng3QVhXcUIwdGcmcj1abEpOMU1yaVBV
VGtCS0NyUFN4NjcNCj4gPiBHbWFwbEVVR2NBRWs5eVB0Q0xkVVhJJm09ZjEyWnlFRVNJZWF2dHFD
VUt1dGlaOUY2eHRSRkMyVVV2ZHFuTTR5d0J4OCZzPVZ0OE9YOXM5bGpTSzZHRGdibndzRi1ZZDM1
ZmJCVWZlOFNCVjJqUG5WYVEmZT0NCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KPiA+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj4gPiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9p
bnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19saXN0cy5mcmVlZGVza3RvcC5vcmdfbWFpbG1hbl9s
aXN0aW5mb19kcmktMkRkZXZlbCZkPUR3SURBdyZjPURQTDZfWF82SmtYRng3QVhXcUIwdGcmcj1a
bEpOMU0NCj4gPiByaVBVVGtCS0NyUFN4NjdHbWFwbEVVR2NBRWs5eVB0Q0xkVVhJJm09ZjEyWnlF
RVNJZWF2dHFDVUt1dGlaOUY2eHRSRkMyVVV2ZHFuTTR5d0J4OCZzPUNQUzh0YU1pWWJJZ1hvLWZ4
aHFFck9KWHZPNlBNVHptci1CTm5HSklveTAmZT0NCj4gDQo+IA0KLS0gDQogRXVnZW5peSBQYWx0
c2V2
