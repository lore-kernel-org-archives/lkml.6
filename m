Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6C5C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F552080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="J2rP3Rz3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F552080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbeKTIgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:36:32 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33718 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbeKTIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:36:32 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 4A76B10C083D;
        Mon, 19 Nov 2018 14:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542665448; bh=qvuNwn2+HKhcUF+O7W2RYsNKvCjpq9BQmfaa4lAaxD0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J2rP3Rz3qDjnYz+f2sf2ilDhVXUo8u8b+vNn73pWeIfdVePCGSvKlpaXsQPlJMuri
         RGuhgIjJKHQINbxUteBYmUHWcwg6JfUCjZ3DMxETU4vV7HzRQQClu8DOEnAFGQ6Sdo
         gtYLUbvG7RYpgN2ORQFAcLnRN91WrLABUaDxcLIgxyO4Yb1j8QOQJ2B5hjKyMXEy5W
         UwauNsfxBMrCnRuicrbAIHOeC0ELumbeJ2gSR9vas8uCQbhESqL8oF63YUkqjQF+T3
         SajupJ+jMNtSnbWBG+qhl2QHs+Hq495Zt19m/oLI8aLuI/Qr5Hv0Iv4Aty8wZOT5mz
         Np0yvRRZeZt2w==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2DD023844;
        Mon, 19 Nov 2018 14:10:48 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 14:10:47 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 19 Nov 2018 23:10:46 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v3] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Topic: [PATCH v3] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Index: AQHUf/s/PX6mUz8Dqkul5tUTbfctiaVXkvAAgAAA1ACAAASngIAAAEkA
Date:   Mon, 19 Nov 2018 22:10:45 +0000
Message-ID: <8f613c5cb91c4d94643e317f08d6019abe27638d.camel@synopsys.com>
References: <20181119112917.4214-1-abrodkin@synopsys.com>
         <360a492f-58b0-daa4-a450-3cdbfffbeabe@linaro.org>
         <349be75346aaf03eda8c49dfd90c06e3f916a1e3.camel@synopsys.com>
         <a400dabc-df12-1854-21c4-8e914ef538d8@linaro.org>
In-Reply-To: <a400dabc-df12-1854-21c4-8e914ef538d8@linaro.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <841DFA87AE6526499547E703EBACAA0C@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTE5IGF0IDIzOjA5ICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMTkvMTEvMjAxOCAyMjo1MywgQWxleGV5IEJyb2RraW4gd3JvdGU6DQo+ID4gSGkgRGFu
aWVsLA0KPiA+IA0KPiA+IE9uIE1vbiwgMjAxOC0xMS0xOSBhdCAyMjo1MCArMDEwMCwgRGFuaWVs
IExlemNhbm8gd3JvdGU6DQo+ID4gPiBPbiAxOS8xMS8yMDE4IDEyOjI5LCBBbGV4ZXkgQnJvZGtp
biB3cm90ZToNCj4gPiA+ID4gSXQgdHVybmVkIG91dCB3ZSB1c2VkIHRvIHVzZSBkZWZhdWx0IGlt
cGxlbWVudGF0aW9uIG9mIHNjaGVkX2Nsb2NrKCkNCj4gPiA+ID4gZnJvbSBrZXJuZWwvc2NoZWQv
Y2xvY2suYyB3aGljaCB3YXMgYXMgcHJlY2lzZSBhcyAxL0haLCBpLmUuDQo+ID4gPiA+IGJ5IGRl
ZmF1bHQgd2UgaGFkIDEwIG1zZWMgZ3JhbnVsYXJpdHkgb2YgdGltZSBtZWFzdXJlbWVudC4NCj4g
PiA+ID4gDQo+ID4gPiA+IE5vdyBnaXZlbiBBUkMgYnVpbHQtaW4gdGltZXJzIGFyZSBjbG9ja2Vk
IHdpdGggdGhlIHNhbWUgZnJlcXVlbmN5IGFzDQo+ID4gPiA+IENQVSBjb3JlcyB3ZSBtYXkgZ2V0
IG11Y2ggaGlnaGVyIHByZWNpc2lvbiBvZiB0aW1lIHRyYWNraW5nLg0KPiA+ID4gPiANCj4gPiA+
ID4gVGh1cyB3ZSBzd2l0Y2ggdG8gZ2VuZXJpYyBzY2hlZF9jbG9jayB3aGljaCByZWFsbHkgcmVh
ZHMgQVJDIGhhcmR3YXJlDQo+ID4gPiA+IGNvdW50ZXJzLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhp
cyBpcyBlc3BlY2lhbGx5IGhlbHBmdWwgZm9yIG1lYXN1cmluZyBzaG9ydCBldmVudHMuDQo+ID4g
PiA+IFRoYXQncyB3aGF0IHdlIHVzZWQgdG8gaGF2ZToNCj4gPiA+ID4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gJCBwZXJm
IHN0YXQgL2Jpbi9zaCAtYyAvcm9vdC9sbWJlbmNoLW1hc3Rlci9iaW4vYXJjL2hlbGxvID4gL2Rl
di9udWxsDQo+ID4gPiA+IA0KPiA+ID4gPiAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3Ig
Jy9iaW4vc2ggLWMgL3Jvb3QvbG1iZW5jaC1tYXN0ZXIvYmluL2FyYy9oZWxsbyc6DQo+ID4gPiA+
IA0KPiA+ID4gPiAgICAgICAgICAxMC4wMDAwMDAgICAgICB0YXNrLWNsb2NrIChtc2VjKSAgICAg
ICAgICMgICAgMi44MzIgQ1BVcyB1dGlsaXplZA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgIDEg
ICAgICBjb250ZXh0LXN3aXRjaGVzICAgICAgICAgICMgICAgMC4xMDAgSy9zZWMNCj4gPiA+ID4g
ICAgICAgICAgICAgICAgICAxICAgICAgY3B1LW1pZ3JhdGlvbnMgICAgICAgICAgICAjICAgIDAu
MTAwIEsvc2VjDQo+ID4gPiA+ICAgICAgICAgICAgICAgICA2MyAgICAgIHBhZ2UtZmF1bHRzICAg
ICAgICAgICAgICAgIyAgICAwLjAwNiBNL3NlYw0KPiA+ID4gPiAgICAgICAgICAgIDMwNDk0ODAg
ICAgICBjeWNsZXMgICAgICAgICAgICAgICAgICAgICMgICAgMC4zMDUgR0h6DQo+ID4gPiA+ICAg
ICAgICAgICAgMTA5MTI1OSAgICAgIGluc3RydWN0aW9ucyAgICAgICAgICAgICAgIyAgICAwLjM2
ICBpbnNuIHBlciBjeWNsZQ0KPiA+ID4gPiAgICAgICAgICAgICAyNTY4MjggICAgICBicmFuY2hl
cyAgICAgICAgICAgICAgICAgICMgICAyNS42ODMgTS9zZWMNCj4gPiA+ID4gICAgICAgICAgICAg
IDI3MDI2ICAgICAgYnJhbmNoLW1pc3NlcyAgICAgICAgICAgICAjICAgMTAuNTIlIG9mIGFsbCBi
cmFuY2hlcw0KPiA+ID4gPiANCj4gPiA+ID4gICAgICAgIDAuMDAzNTMwNjg3IHNlY29uZHMgdGlt
ZSBlbGFwc2VkDQo+ID4gPiA+IA0KPiA+ID4gPiAgICAgICAgMC4wMDAwMDAwMDAgc2Vjb25kcyB1
c2VyDQo+ID4gPiA+ICAgICAgICAwLjAxMDAwMDAwMCBzZWNvbmRzIHN5cw0KPiA+ID4gPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+
ID4gPiANCj4gPiA+ID4gQW5kIG5vdyB3ZSdsbCBzZWU6DQo+ID4gPiA+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICQgcGVy
ZiBzdGF0IC9iaW4vc2ggLWMgL3Jvb3QvbG1iZW5jaC1tYXN0ZXIvYmluL2FyYy9oZWxsbyA+IC9k
ZXYvbnVsbA0KPiA+ID4gPiANCj4gPiA+ID4gIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9y
ICcvYmluL3NoIC1jIC9yb290L2xtYmVuY2gtbWFzdGVyL2Jpbi9hcmMvaGVsbG8nOg0KPiA+ID4g
PiANCj4gPiA+ID4gICAgICAgICAgIDMuMDA0MzIyICAgICAgdGFzay1jbG9jayAobXNlYykgICAg
ICAgICAjICAgIDAuODY1IENQVXMgdXRpbGl6ZWQNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAx
ICAgICAgY29udGV4dC1zd2l0Y2hlcyAgICAgICAgICAjICAgIDAuMzMzIEsvc2VjDQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgMSAgICAgIGNwdS1taWdyYXRpb25zICAgICAgICAgICAgIyAgICAw
LjMzMyBLL3NlYw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgNjMgICAgICBwYWdlLWZhdWx0cyAg
ICAgICAgICAgICAgICMgICAgMC4wMjEgTS9zZWMNCj4gPiA+ID4gICAgICAgICAgICAyOTg2NzM0
ICAgICAgY3ljbGVzICAgICAgICAgICAgICAgICAgICAjICAgIDAuOTk0IEdIeg0KPiA+ID4gPiAg
ICAgICAgICAgIDEwODc0NjYgICAgICBpbnN0cnVjdGlvbnMgICAgICAgICAgICAgICMgICAgMC4z
NiAgaW5zbiBwZXIgY3ljbGUNCj4gPiA+ID4gICAgICAgICAgICAgMjU1MjA5ICAgICAgYnJhbmNo
ZXMgICAgICAgICAgICAgICAgICAjICAgODQuOTQ3IE0vc2VjDQo+ID4gPiA+ICAgICAgICAgICAg
ICAyNjAwMiAgICAgIGJyYW5jaC1taXNzZXMgICAgICAgICAgICAgIyAgIDEwLjE5JSBvZiBhbGwg
YnJhbmNoZXMNCj4gPiA+ID4gDQo+ID4gPiA+ICAgICAgICAwLjAwMzQ3NDgyOSBzZWNvbmRzIHRp
bWUgZWxhcHNlZA0KPiA+ID4gPiANCj4gPiA+ID4gICAgICAgIDAuMDAzNTE5MDAwIHNlY29uZHMg
dXNlcg0KPiA+ID4gPiAgICAgICAgMC4wMDAwMDAwMDAgc2Vjb25kcyBzeXMNCj4gPiA+ID4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiA+ID4gDQo+ID4gPiA+IE5vdGUgaG93IG11Y2ggbW9yZSBtZWFuaW5nZnVsIGlzIHRoZSBzZWNv
bmQgb3V0cHV0IC0gdGltZSBzcGVudCBmb3INCj4gPiA+ID4gZXhlY3V0aW9uIHByZXR0eSBtdWNo
IG1hdGNoZXMgbnVtYmVyIG9mIGN5Y2xlcyBzcGVudCAod2UncmUgcnVubmlnbg0KPiA+ID4gPiBA
IDFHSHogaGVyZSkuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4ZXkgQnJv
ZGtpbiA8YWJyb2RraW5Ac3lub3BzeXMuY29tPg0KPiA+ID4gPiBDYzogRGFuaWVsIExlemNhbm8g
PGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+ID4gPiA+IENjOiBWaW5lZXQgR3VwdGEgPHZn
dXB0YUBzeW5vcHN5cy5jb20+DQo+ID4gPiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGlu
dXRyb25peC5kZT4NCj4gPiA+ID4gLS0tDQo+ID4gPiANCj4gPiA+IEFwcGxpZWQsIHRoYW5rcy4N
Cj4gPiANCj4gPiBNYXliZSBhIGJpdCB0b28gbGF0ZSBidXQgSSBjb21wbGV0ZWx5IGZvcmdvdCB0
byBhZGQgc3RhYmxlIHRhZyBpbnRvIENjIGxpc3QuDQo+ID4gQW55IGNoYW5jZSB0byBhZGQgaXQg
c3RpbGw/DQo+IA0KPiBZZXMsIG5vIHByb2JsZW0sIEkndmUgYWRkZWQgaXQuDQoNCkNvb2wsIHRo
YW5rcyENCg0KLUFsZXhleQ0K
