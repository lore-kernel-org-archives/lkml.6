Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1997FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6802B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eEr3g/bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6802B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeKSTyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:54:24 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33590 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbeKSTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:54:24 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 069CF10C11C6;
        Mon, 19 Nov 2018 01:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542619880; bh=MsCG8KgTZHAhBEjgaaiH+ZcV+ze1mcZzy5H21rQCe8U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eEr3g/bujqUkhJxjhMXUWEuxBDUiX+JaMkECTuiIvCQboFyUxfC6MIMLLv6U4Ak7h
         +OILZBBbcQC0IjV1NjNU/fFPitNvhZfFqJtLFfEqjfYl2LzDJJ/uHkgr4jLAKK+jAJ
         QQjj+LcB/hZ5EFHkGveQeUwhV5gf+gKpYE+y/5Df/ynDC1KN/6v0+iu+IUSSPe1eO8
         E42YIVIAoE1BzY9M2yNa+KDViKo7YJIlP9tFGiu5wcgCF/BKyl4nP9GzX5kEDJ4M7y
         x/ERQEpO3eMIfqPIbQmqUSU5p/Pmvgy1YZkpNFaIwUyJz+nJZ8pw5TnF/1CEYj8kUg
         KFqyNqCU7qgFg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 98E0B5A3B;
        Mon, 19 Nov 2018 01:31:19 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 01:31:19 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 19 Nov 2018 10:31:16 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Topic: [PATCH v2] clocksource/drivers/arc_timer: Utilize generic
 sched_clock
Thread-Index: AQHUZgzUjKESBok63Em0jiA3zZIBcaVBTesAgBOe34CAAguUgA==
Date:   Mon, 19 Nov 2018 09:31:16 +0000
Message-ID: <dab866a50e66e73f6010de1487b06019887930c8.camel@synopsys.com>
References: <20181017113020.7551-1-abrodkin@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B0B1A07@US01WEMBX2.internal.synopsys.com>
         <78ccbb4c-56d0-594b-4032-3eb19202847b@linaro.org>
         <2c46ab6e-f0a9-4857-9772-f3c714284e98@linaro.org>
In-Reply-To: <2c46ab6e-f0a9-4857-9772-f3c714284e98@linaro.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.121.8.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF0E4D65CBE848409FA7A2BED5C020A2@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQpPbiBTdW4sIDIwMTgtMTEtMTggYXQgMDM6MTcgKzAxMDAsIERhbmllbCBM
ZXpjYW5vIHdyb3RlOg0KPiBPbiAwNS8xMS8yMDE4IDE1OjM5LCBEYW5pZWwgTGV6Y2FubyB3cm90
ZToNCj4gPiBPbiAyNC8xMC8yMDE4IDAwOjMzLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+ID4gPiBP
biAxMC8xNy8yMDE4IDA0OjMwIEFNLCBBbGV4ZXkgQnJvZGtpbiB3cm90ZToNCj4gPiA+ID4gSXQg
dHVybmVkIG91dCB3ZSB1c2VkIHRvIHVzZSBkZWZhdWx0IGltcGxlbWVudGF0aW9uIG9mIHNjaGVk
X2Nsb2NrKCkNCj4gPiA+ID4gZnJvbSBrZXJuZWwvc2NoZWQvY2xvY2suYyB3aGljaCB3YXMgYXMg
cHJlY2lzZSBhcyAxL0haLCBpLmUuDQo+ID4gPiA+IGJ5IGRlZmF1bHQgd2UgaGFkIDEwIG1zZWMg
Z3JhbnVsYXJpdHkgb2YgdGltZSBtZWFzdXJlbWVudC4NCj4gPiA+ID4gDQo+ID4gPiA+IE5vdyBn
aXZlbiBBUkMgYnVpbHQtaW4gdGltZXJzIGFyZSBjbG9ja2VkIHdpdGggdGhlIHNhbWUgZnJlcXVl
bmN5IGFzDQo+ID4gPiA+IENQVSBjb3JlcyB3ZSBtYXkgZ2V0IG11Y2ggaGlnaGVyIHByZWNpc2lv
biBvZiB0aW1lIHRyYWNraW5nLg0KPiA+ID4gPiANCj4gPiA+ID4gVGh1cyB3ZSBzd2l0Y2ggdG8g
Z2VuZXJpYyBzY2hlZF9jbG9jayB3aGljaCByZWFsbHkgcmVhZHMgQVJDIGhhcmR3YXJlDQo+ID4g
PiA+IGNvdW50ZXJzLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhpcyBpcyBlc3BlY2lhbGx5IGhlbHBm
dWwgZm9yIG1lYXN1cmluZyBzaG9ydCBldmVudHMuDQo+ID4gPiA+IFRoYXQncyB3aGF0IHdlIHVz
ZWQgdG8gaGF2ZToNCj4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gJCBwZXJmIHN0YXQgL2Jpbi9zaCAtYyAvcm9v
dC9sbWJlbmNoLW1hc3Rlci9iaW4vYXJjL2hlbGxvID4gL2Rldi9udWxsDQo+ID4gPiA+IA0KPiA+
ID4gPiAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJy9iaW4vc2ggLWMgL3Jvb3QvbG1i
ZW5jaC1tYXN0ZXIvYmluL2FyYy9oZWxsbyc6DQo+ID4gPiA+IA0KPiA+ID4gPiAgICAgICAgICAx
MC4wMDAwMDAgICAgICB0YXNrLWNsb2NrIChtc2VjKSAgICAgICAgICMgICAgMi44MzIgQ1BVcyB1
dGlsaXplZA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgIDEgICAgICBjb250ZXh0LXN3aXRjaGVz
ICAgICAgICAgICMgICAgMC4xMDAgSy9zZWMNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAxICAg
ICAgY3B1LW1pZ3JhdGlvbnMgICAgICAgICAgICAjICAgIDAuMTAwIEsvc2VjDQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICA2MyAgICAgIHBhZ2UtZmF1bHRzICAgICAgICAgICAgICAgIyAgICAwLjAw
NiBNL3NlYw0KPiA+ID4gPiAgICAgICAgICAgIDMwNDk0ODAgICAgICBjeWNsZXMgICAgICAgICAg
ICAgICAgICAgICMgICAgMC4zMDUgR0h6DQo+ID4gPiA+ICAgICAgICAgICAgMTA5MTI1OSAgICAg
IGluc3RydWN0aW9ucyAgICAgICAgICAgICAgIyAgICAwLjM2ICBpbnNuIHBlciBjeWNsZQ0KPiA+
ID4gPiAgICAgICAgICAgICAyNTY4MjggICAgICBicmFuY2hlcyAgICAgICAgICAgICAgICAgICMg
ICAyNS42ODMgTS9zZWMNCj4gPiA+ID4gICAgICAgICAgICAgIDI3MDI2ICAgICAgYnJhbmNoLW1p
c3NlcyAgICAgICAgICAgICAjICAgMTAuNTIlIG9mIGFsbCBicmFuY2hlcw0KPiA+ID4gPiANCj4g
PiA+ID4gICAgICAgIDAuMDAzNTMwNjg3IHNlY29uZHMgdGltZSBlbGFwc2VkDQo+ID4gPiA+IA0K
PiA+ID4gPiAgICAgICAgMC4wMDAwMDAwMDAgc2Vjb25kcyB1c2VyDQo+ID4gPiA+ICAgICAgICAw
LjAxMDAwMDAwMCBzZWNvbmRzIHN5cw0KPiA+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gPiANCj4gPiA+ID4gQW5kIG5v
dyB3ZSdsbCBzZWU6DQo+ID4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT44LS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICQgcGVyZiBzdGF0IC9iaW4vc2ggLWMgL3Jv
b3QvbG1iZW5jaC1tYXN0ZXIvYmluL2FyYy9oZWxsbyA+IC9kZXYvbnVsbA0KPiA+ID4gPiANCj4g
PiA+ID4gIFBlcmZvcm1hbmNlIGNvdW50ZXIgc3RhdHMgZm9yICcvYmluL3NoIC1jIC9yb290L2xt
YmVuY2gtbWFzdGVyL2Jpbi9hcmMvaGVsbG8nOg0KPiA+ID4gPiANCj4gPiA+ID4gICAgICAgICAg
IDMuMDA0MzIyICAgICAgdGFzay1jbG9jayAobXNlYykgICAgICAgICAjICAgIDAuODY1IENQVXMg
dXRpbGl6ZWQNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAxICAgICAgY29udGV4dC1zd2l0Y2hl
cyAgICAgICAgICAjICAgIDAuMzMzIEsvc2VjDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgMSAg
ICAgIGNwdS1taWdyYXRpb25zICAgICAgICAgICAgIyAgICAwLjMzMyBLL3NlYw0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgNjMgICAgICBwYWdlLWZhdWx0cyAgICAgICAgICAgICAgICMgICAgMC4w
MjEgTS9zZWMNCj4gPiA+ID4gICAgICAgICAgICAyOTg2NzM0ICAgICAgY3ljbGVzICAgICAgICAg
ICAgICAgICAgICAjICAgIDAuOTk0IEdIeg0KPiA+ID4gPiAgICAgICAgICAgIDEwODc0NjYgICAg
ICBpbnN0cnVjdGlvbnMgICAgICAgICAgICAgICMgICAgMC4zNiAgaW5zbiBwZXIgY3ljbGUNCj4g
PiA+ID4gICAgICAgICAgICAgMjU1MjA5ICAgICAgYnJhbmNoZXMgICAgICAgICAgICAgICAgICAj
ICAgODQuOTQ3IE0vc2VjDQo+ID4gPiA+ICAgICAgICAgICAgICAyNjAwMiAgICAgIGJyYW5jaC1t
aXNzZXMgICAgICAgICAgICAgIyAgIDEwLjE5JSBvZiBhbGwgYnJhbmNoZXMNCj4gPiA+ID4gDQo+
ID4gPiA+ICAgICAgICAwLjAwMzQ3NDgyOSBzZWNvbmRzIHRpbWUgZWxhcHNlZA0KPiA+ID4gPiAN
Cj4gPiA+ID4gICAgICAgIDAuMDAzNTE5MDAwIHNlY29uZHMgdXNlcg0KPiA+ID4gPiAgICAgICAg
MC4wMDAwMDAwMDAgc2Vjb25kcyBzeXMNCj4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gDQo+ID4gPiA+IE5vdGUg
aG93IG11Y2ggbW9yZSBtZWFuaW5nZnVsIGlzIHRoZSBzZWNvbmQgb3V0cHV0IC0gdGltZSBzcGVu
dCBmb3INCj4gPiA+ID4gZXhlY3V0aW9uIHByZXR0eSBtdWNoIG1hdGNoZXMgbnVtYmVyIG9mIGN5
Y2xlcyBzcGVudCAod2UncmUgcnVubmluZw0KPiA+ID4gPiBAIDFHSHogaGVyZSkuDQo+ID4gPiA+
IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGV4ZXkgQnJvZGtpbiA8YWJyb2RraW5Ac3lub3Bz
eXMuY29tPg0KPiA+ID4gPiBDYzogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFy
by5vcmc+DQo+ID4gPiA+IENjOiBWaW5lZXQgR3VwdGEgPHZndXB0YUBzeW5vcHN5cy5jb20+DQo+
ID4gPiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gPiA+ID4g
LS0tDQo+ID4gPiANCj4gPiA+IEFja2VkLWJ5OiBWaW5lZXQgR3VwdGEgPHZndXB0YUBzeW5vcHN5
cy5jb20+DQo+ID4gPiANCj4gPiA+IEBEYW5pZWwgaXMgdGhpcyBnb2luZyB2aWEgdGltZXIgdHJl
ZSBvciB5b3Ugd2FudCBtZSB0byBwaWNrIGl0IHVwLg0KPiA+IA0KPiA+IEkgd2lsbCB0YWtlIGNh
cmUgb2YgaXQuDQo+IA0KPiBQbGVhc2UgcmVzZW5kIHdpdGhvdXQgdGhlIGFyY2ggS2NvbmZpZyBj
aGFuZ2UNCg0KSSdtIHdvbmRlcmluZyBpZiB0aGVyZSdzIGEgcHJvYmxlbSB3aXRoIGFyYy9hcmMv
S2NvbmZpZyBjaGFuZ2UgZ29pbmcNCnRocm91Z2ggeW91ciB0cmVlPyBUaGlzIHdheSBpdCB3aWxs
IGJlIHJlYWxseSBhdG9taWMgY2hhbmdlIGFuZCBpdCB3aWxsIGJlDQptdWNoIGVhc2llciB0byBi
YWNrLXBvcnQgKGFuZCB0aGF0J3Mgd2hhdCB3ZSdkIHJlYWxseSBsaWtlIHRvIGhhcHBlbikuDQoN
CklmIFZpbmVldCBpcyBPSyB3aXRoIHRoYXQgSU1ITyBpdCdzIHNhZmUgdG8ga2VlcCBpdCBpbiB0
aGUgb25lIGFuZCBvbmx5IGNvbW1pdC4NCg0KT3RoZXJ3aXNlIHNob3VsZCBJIGp1c3Qgc3BsaXQg
dGhpcyBwYXRjaCBpbiAyIGFuZCBzdGlsbCBzdWJtaXQgdGhlbSBhcyBzZXJpZXMgb3INCmhhdmUg
MiBjb21wbGV0ZWx5IG5vdC1yZWxhdGVkIHBhdGNoZXMgb25lIGZvciB5b3UgYW5kIG9uZSBmb3Ig
VmluZWV0Pw0KDQpJbiB0aGF0IGNhc2UgZG8gSSB1bmRlcnN0YW5kIGNvcnJlY3RseSB0aGF0IHdl
IG1heSBlbmFibGUgR0VORVJJQ19TQ0hFRF9DTE9DSw0KZm9yIEFSQyBldmVuIGJlZm9yZSBwcm9w
b3NlZCBjaGFuZ2UgZm9yIGFyY190aW1lci5jIGdldHMgbWVyZ2VkIC0gaS5lLiB3aXRoIG5vDQpz
cGVjaWFsIEdFTkVSSUNfU0NIRURfQ0xPQ0sgZHJpdmVyIHdlJ2xsIHNhZmVseSBmYWxsLWJhY2sg
dG8gamlmZmllLWJhc2VkDQpzY2hlZCBjbG9jayB3aGljaCB3ZSBhbnl3YXlzIHVzZSBub3cgd2hl
biBHRU5FUklDX1NDSEVEX0NMT0NLIGlzIGRpc2FibGVkLCByaWdodD8NCg0KLUFsZXhleQ0K
