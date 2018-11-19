Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6701CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F42B20817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Q+/N8yZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F42B20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeKSUSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:18:39 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:34524 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSUSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:18:39 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DF67910C150A;
        Mon, 19 Nov 2018 01:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542621331; bh=fJMEuBveQ1OxRCixWZYlecFhkPsXIXTMH03OLXi8Wrw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Q+/N8yZW+n8OIOjn0d/zVkKIoVR1DEoiXd80xdGzTsIvki8Ug6Dlohcu0xCfPkSc2
         96EF6QhSd6zsGQYgnwCgwH0qCZI2NmXaQSmML7HpGMn9QNuE9tS4ZIDfXAtxpy5mvL
         qzBSYvABmIqqPX+sbS408C8j3sQFbhktHxM0rDzdOdD+cPCURPkZdXA5VK4tDOg4D9
         h8MLgjMbP8lBVPDZvc3nKCB8Qegg672T7+wuX5pdl0fXaLUyHC1r4Efyap4zJt7Q/e
         z+zDb65q4PNHcJuAJaBIqu0kivLKX2lVbBocOcBBqLs8zBP0vrxxDQND8flKmGrmaz
         I3Ndw3ACgqlbQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id C6540326D;
        Mon, 19 Nov 2018 01:55:31 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 01:55:31 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 19 Nov 2018 10:55:29 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Topic: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Index: AQHUZgzUjKESBok63Em0jiA3zZIBcaVBTesAgBOe34CAAguUgIAAA0kAgAADeoA=
Date:   Mon, 19 Nov 2018 09:55:28 +0000
Message-ID: <e31a11c42c21353963bd75c88493e8158316d469.camel@synopsys.com>
References: <20181017113020.7551-1-abrodkin@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B0B1A07@US01WEMBX2.internal.synopsys.com>
         <78ccbb4c-56d0-594b-4032-3eb19202847b@linaro.org>
         <2c46ab6e-f0a9-4857-9772-f3c714284e98@linaro.org>
         <dab866a50e66e73f6010de1487b06019887930c8.camel@synopsys.com>
         <40ada5b3-5824-51fd-501f-ef363f162047@linaro.org>
In-Reply-To: <40ada5b3-5824-51fd-501f-ef363f162047@linaro.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.121.8.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C983FB360B6B3345A6197B7058D4B82C@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQpPbiBNb24sIDIwMTgtMTEtMTkgYXQgMTA6NDMgKzAxMDAsIERhbmllbCBM
ZXpjYW5vIHdyb3RlOg0KPiBPbiAxOS8xMS8yMDE4IDEwOjMxLCBBbGV4ZXkgQnJvZGtpbiB3cm90
ZToNCj4gPiBIaSBEYW5pZWwsDQo+ID4gDQo+ID4gT24gU3VuLCAyMDE4LTExLTE4IGF0IDAzOjE3
ICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToNCj4gPiA+IE9uIDA1LzExLzIwMTggMTU6Mzks
IERhbmllbCBMZXpjYW5vIHdyb3RlOg0KPiA+ID4gPiBPbiAyNC8xMC8yMDE4IDAwOjMzLCBWaW5l
ZXQgR3VwdGEgd3JvdGU6DQo+ID4gPiA+ID4gT24gMTAvMTcvMjAxOCAwNDozMCBBTSwgQWxleGV5
IEJyb2RraW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBJdCB0dXJuZWQgb3V0IHdlIHVzZWQgdG8gdXNl
IGRlZmF1bHQgaW1wbGVtZW50YXRpb24gb2Ygc2NoZWRfY2xvY2soKQ0KPiA+ID4gPiA+ID4gZnJv
bSBrZXJuZWwvc2NoZWQvY2xvY2suYyB3aGljaCB3YXMgYXMgcHJlY2lzZSBhcyAxL0haLCBpLmUu
DQo+ID4gPiA+ID4gPiBieSBkZWZhdWx0IHdlIGhhZCAxMCBtc2VjIGdyYW51bGFyaXR5IG9mIHRp
bWUgbWVhc3VyZW1lbnQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE5vdyBnaXZlbiBBUkMg
YnVpbHQtaW4gdGltZXJzIGFyZSBjbG9ja2VkIHdpdGggdGhlIHNhbWUgZnJlcXVlbmN5IGFzDQo+
ID4gPiA+ID4gPiBDUFUgY29yZXMgd2UgbWF5IGdldCBtdWNoIGhpZ2hlciBwcmVjaXNpb24gb2Yg
dGltZSB0cmFja2luZy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGh1cyB3ZSBzd2l0Y2gg
dG8gZ2VuZXJpYyBzY2hlZF9jbG9jayB3aGljaCByZWFsbHkgcmVhZHMgQVJDIGhhcmR3YXJlDQo+
ID4gPiA+ID4gPiBjb3VudGVycy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhpcyBpcyBl
c3BlY2lhbGx5IGhlbHBmdWwgZm9yIG1lYXN1cmluZyBzaG9ydCBldmVudHMuDQo+ID4gPiA+ID4g
PiBUaGF0J3Mgd2hhdCB3ZSB1c2VkIHRvIGhhdmU6DQo+ID4gPiA+ID4gPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiA+ID4g
JCBwZXJmIHN0YXQgL2Jpbi9zaCAtYyAvcm9vdC9sbWJlbmNoLW1hc3Rlci9iaW4vYXJjL2hlbGxv
ID4gL2Rldi9udWxsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICBQZXJmb3JtYW5jZSBjb3Vu
dGVyIHN0YXRzIGZvciAnL2Jpbi9zaCAtYyAvcm9vdC9sbWJlbmNoLW1hc3Rlci9iaW4vYXJjL2hl
bGxvJzoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gICAgICAgICAgMTAuMDAwMDAwICAgICAg
dGFzay1jbG9jayAobXNlYykgICAgICAgICAjICAgIDIuODMyIENQVXMgdXRpbGl6ZWQNCj4gPiA+
ID4gPiA+ICAgICAgICAgICAgICAgICAgMSAgICAgIGNvbnRleHQtc3dpdGNoZXMgICAgICAgICAg
IyAgICAwLjEwMCBLL3NlYw0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAxICAgICAgY3B1
LW1pZ3JhdGlvbnMgICAgICAgICAgICAjICAgIDAuMTAwIEsvc2VjDQo+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgNjMgICAgICBwYWdlLWZhdWx0cyAgICAgICAgICAgICAgICMgICAgMC4wMDYg
TS9zZWMNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgMzA0OTQ4MCAgICAgIGN5Y2xlcyAgICAgICAg
ICAgICAgICAgICAgIyAgICAwLjMwNSBHSHoNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgMTA5MTI1
OSAgICAgIGluc3RydWN0aW9ucyAgICAgICAgICAgICAgIyAgICAwLjM2ICBpbnNuIHBlciBjeWNs
ZQ0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgMjU2ODI4ICAgICAgYnJhbmNoZXMgICAgICAgICAg
ICAgICAgICAjICAgMjUuNjgzIE0vc2VjDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgMjcwMjYg
ICAgICBicmFuY2gtbWlzc2VzICAgICAgICAgICAgICMgICAxMC41MiUgb2YgYWxsIGJyYW5jaGVz
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICAgICAgICAwLjAwMzUzMDY4NyBzZWNvbmRzIHRp
bWUgZWxhcHNlZA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAgICAgICAgMC4wMDAwMDAwMDAg
c2Vjb25kcyB1c2VyDQo+ID4gPiA+ID4gPiAgICAgICAgMC4wMTAwMDAwMDAgc2Vjb25kcyBzeXMN
Cj4gPiA+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEFuZCBub3cgd2UnbGwgc2Vl
Og0KPiA+ID4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gPiA+ICQgcGVyZiBzdGF0IC9iaW4vc2ggLWMgL3Jvb3Qv
bG1iZW5jaC1tYXN0ZXIvYmluL2FyYy9oZWxsbyA+IC9kZXYvbnVsbA0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJy9iaW4vc2ggLWMgL3Jv
b3QvbG1iZW5jaC1tYXN0ZXIvYmluL2FyYy9oZWxsbyc6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ICAgICAgICAgICAzLjAwNDMyMiAgICAgIHRhc2stY2xvY2sgKG1zZWMpICAgICAgICAgIyAg
ICAwLjg2NSBDUFVzIHV0aWxpemVkDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgICAgIDEgICAg
ICBjb250ZXh0LXN3aXRjaGVzICAgICAgICAgICMgICAgMC4zMzMgSy9zZWMNCj4gPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgMSAgICAgIGNwdS1taWdyYXRpb25zICAgICAgICAgICAgIyAgICAw
LjMzMyBLL3NlYw0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgIDYzICAgICAgcGFnZS1mYXVs
dHMgICAgICAgICAgICAgICAjICAgIDAuMDIxIE0vc2VjDQo+ID4gPiA+ID4gPiAgICAgICAgICAg
IDI5ODY3MzQgICAgICBjeWNsZXMgICAgICAgICAgICAgICAgICAgICMgICAgMC45OTQgR0h6DQo+
ID4gPiA+ID4gPiAgICAgICAgICAgIDEwODc0NjYgICAgICBpbnN0cnVjdGlvbnMgICAgICAgICAg
ICAgICMgICAgMC4zNiAgaW5zbiBwZXIgY3ljbGUNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgIDI1
NTIwOSAgICAgIGJyYW5jaGVzICAgICAgICAgICAgICAgICAgIyAgIDg0Ljk0NyBNL3NlYw0KPiA+
ID4gPiA+ID4gICAgICAgICAgICAgIDI2MDAyICAgICAgYnJhbmNoLW1pc3NlcyAgICAgICAgICAg
ICAjICAgMTAuMTklIG9mIGFsbCBicmFuY2hlcw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAg
ICAgICAgMC4wMDM0NzQ4Mjkgc2Vjb25kcyB0aW1lIGVsYXBzZWQNCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gICAgICAgIDAuMDAzNTE5MDAwIHNlY29uZHMgdXNlcg0KPiA+ID4gPiA+ID4gICAg
ICAgIDAuMDAwMDAwMDAwIHNlY29uZHMgc3lzDQo+ID4gPiA+ID4gPiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBOb3RlIGhvdyBtdWNoIG1vcmUgbWVhbmluZ2Z1bCBpcyB0aGUgc2Vjb25kIG91
dHB1dCAtIHRpbWUgc3BlbnQgZm9yDQo+ID4gPiA+ID4gPiBleGVjdXRpb24gcHJldHR5IG11Y2gg
bWF0Y2hlcyBudW1iZXIgb2YgY3ljbGVzIHNwZW50ICh3ZSdyZSBydW5uaW5nDQo+ID4gPiA+ID4g
PiBAIDFHSHogaGVyZSkuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEFsZXhleSBCcm9ka2luIDxhYnJvZGtpbkBzeW5vcHN5cy5jb20+DQo+ID4gPiA+ID4gPiBDYzog
RGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+ID4gPiA+ID4gPiBD
YzogVmluZWV0IEd1cHRhIDx2Z3VwdGFAc3lub3BzeXMuY29tPg0KPiA+ID4gPiA+ID4gQ2M6IFRo
b21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gQWNrZWQtYnk6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9wc3lz
LmNvbT4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBARGFuaWVsIGlzIHRoaXMgZ29pbmcgdmlhIHRp
bWVyIHRyZWUgb3IgeW91IHdhbnQgbWUgdG8gcGljayBpdCB1cC4NCj4gPiA+ID4gDQo+ID4gPiA+
IEkgd2lsbCB0YWtlIGNhcmUgb2YgaXQuDQo+ID4gPiANCj4gPiA+IFBsZWFzZSByZXNlbmQgd2l0
aG91dCB0aGUgYXJjaCBLY29uZmlnIGNoYW5nZQ0KPiA+IA0KPiA+IEknbSB3b25kZXJpbmcgaWYg
dGhlcmUncyBhIHByb2JsZW0gd2l0aCBhcmMvYXJjL0tjb25maWcgY2hhbmdlIGdvaW5nDQo+ID4g
dGhyb3VnaCB5b3VyIHRyZWU/IFRoaXMgd2F5IGl0IHdpbGwgYmUgcmVhbGx5IGF0b21pYyBjaGFu
Z2UgYW5kIGl0IHdpbGwgYmUNCj4gPiBtdWNoIGVhc2llciB0byBiYWNrLXBvcnQgKGFuZCB0aGF0
J3Mgd2hhdCB3ZSdkIHJlYWxseSBsaWtlIHRvIGhhcHBlbikuDQo+ID4gDQo+ID4gSWYgVmluZWV0
IGlzIE9LIHdpdGggdGhhdCBJTUhPIGl0J3Mgc2FmZSB0byBrZWVwIGl0IGluIHRoZSBvbmUgYW5k
IG9ubHkgY29tbWl0Lg0KPiA+IA0KPiA+IE90aGVyd2lzZSBzaG91bGQgSSBqdXN0IHNwbGl0IHRo
aXMgcGF0Y2ggaW4gMiBhbmQgc3RpbGwgc3VibWl0IHRoZW0gYXMgc2VyaWVzIG9yDQo+ID4gaGF2
ZSAyIGNvbXBsZXRlbHkgbm90LXJlbGF0ZWQgcGF0Y2hlcyBvbmUgZm9yIHlvdSBhbmQgb25lIGZv
ciBWaW5lZXQ/DQo+ID4gDQo+ID4gSW4gdGhhdCBjYXNlIGRvIEkgdW5kZXJzdGFuZCBjb3JyZWN0
bHkgdGhhdCB3ZSBtYXkgZW5hYmxlIEdFTkVSSUNfU0NIRURfQ0xPQ0sNCj4gPiBmb3IgQVJDIGV2
ZW4gYmVmb3JlIHByb3Bvc2VkIGNoYW5nZSBmb3IgYXJjX3RpbWVyLmMgZ2V0cyBtZXJnZWQgLSBp
LmUuIHdpdGggbm8NCj4gPiBzcGVjaWFsIEdFTkVSSUNfU0NIRURfQ0xPQ0sgZHJpdmVyIHdlJ2xs
IHNhZmVseSBmYWxsLWJhY2sgdG8gamlmZmllLWJhc2VkDQo+ID4gc2NoZWQgY2xvY2sgd2hpY2gg
d2UgYW55d2F5cyB1c2Ugbm93IHdoZW4gR0VORVJJQ19TQ0hFRF9DTE9DSyBpcyBkaXNhYmxlZCwg
cmlnaHQ/DQo+IA0KPiBUaGUgQVJDJ3MgS2NvbmZpZyBwYXJ0IGRvZXMgbm90IGFwcGx5IG9uIHRp
cC90aW1lcnMvY29yZS4NCg0KTWF5IEkgaGF2ZSBhIHJlZmVyZW5jZSB0byB0aGF0IHRyZWUgc28g
SSBtYXkgY2hlY2sgd2hhdCBnZXRzIGluIHRoZSB3YXkgdGhlcmUNCmFuZCB0aGVuIEknbGwganVz
dCBtb3ZlICJzZWxlY3QgR0VORVJJQ19TQ0hFRF9DTE9DSyIgYSBiaXQgYmVsb3cgc28gdGhlcmUn
cmUgbm8NCmNsYXNoZXMgYW55IGxvbmdlci4NCg0KLUFsZXhleQ0K
