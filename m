Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BC9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E606B2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XwJP4Hwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E606B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbeKTISs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:18:48 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:57940 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbeKTISs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:18:48 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 99C7524E0EA3;
        Mon, 19 Nov 2018 13:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542664388; bh=cjYnphE0CzwTZpbpooKDCDZ/TeVDdN5UD9EjEwlT+2E=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XwJP4Hwl9iVjx/PrlBiFho85QOyD7ZVdJcSbotSKiaRu9gVpseGGWd+G12vDBuSLP
         rfxDFYXUGlK2B8xTVLprUpucbhPWo0Kp/7wVaH0hZOgmqbpHDYwwoLNQBcJThjm6X9
         ge6FGIO8NuF+16f8Pa+AEtDbuAeATxj7HltCEzLA/sm7PZ05wVziKFSOrNiI5tK3SD
         Ty5T6cRqbGjYq/9br6soPJokdyvhlTOp5EjNgBDfMhSKGvUe4vGTx70t62mwTzf6Zw
         2k+W7UnjEjfNed7rYHjLMrXKGneleJEgR3JVrJSGxUTTsVyyi9NpwzQyP30MGoQcOE
         9yb/DM2kc9ZKA==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 89A655058;
        Mon, 19 Nov 2018 13:53:08 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 19 Nov 2018 13:53:08 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Mon,
 19 Nov 2018 22:53:06 +0100
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
Thread-Index: AQHUf/s/PX6mUz8Dqkul5tUTbfctiaVXkvAAgAAA1AA=
Date:   Mon, 19 Nov 2018 21:53:05 +0000
Message-ID: <349be75346aaf03eda8c49dfd90c06e3f916a1e3.camel@synopsys.com>
References: <20181119112917.4214-1-abrodkin@synopsys.com>
         <360a492f-58b0-daa4-a450-3cdbfffbeabe@linaro.org>
In-Reply-To: <360a492f-58b0-daa4-a450-3cdbfffbeabe@linaro.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <16BCC2FCA7823A4F91C92B898B649704@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuaWVsLA0KDQpPbiBNb24sIDIwMTgtMTEtMTkgYXQgMjI6NTAgKzAxMDAsIERhbmllbCBM
ZXpjYW5vIHdyb3RlOg0KPiBPbiAxOS8xMS8yMDE4IDEyOjI5LCBBbGV4ZXkgQnJvZGtpbiB3cm90
ZToNCj4gPiBJdCB0dXJuZWQgb3V0IHdlIHVzZWQgdG8gdXNlIGRlZmF1bHQgaW1wbGVtZW50YXRp
b24gb2Ygc2NoZWRfY2xvY2soKQ0KPiA+IGZyb20ga2VybmVsL3NjaGVkL2Nsb2NrLmMgd2hpY2gg
d2FzIGFzIHByZWNpc2UgYXMgMS9IWiwgaS5lLg0KPiA+IGJ5IGRlZmF1bHQgd2UgaGFkIDEwIG1z
ZWMgZ3JhbnVsYXJpdHkgb2YgdGltZSBtZWFzdXJlbWVudC4NCj4gPiANCj4gPiBOb3cgZ2l2ZW4g
QVJDIGJ1aWx0LWluIHRpbWVycyBhcmUgY2xvY2tlZCB3aXRoIHRoZSBzYW1lIGZyZXF1ZW5jeSBh
cw0KPiA+IENQVSBjb3JlcyB3ZSBtYXkgZ2V0IG11Y2ggaGlnaGVyIHByZWNpc2lvbiBvZiB0aW1l
IHRyYWNraW5nLg0KPiA+IA0KPiA+IFRodXMgd2Ugc3dpdGNoIHRvIGdlbmVyaWMgc2NoZWRfY2xv
Y2sgd2hpY2ggcmVhbGx5IHJlYWRzIEFSQyBoYXJkd2FyZQ0KPiA+IGNvdW50ZXJzLg0KPiA+IA0K
PiA+IFRoaXMgaXMgZXNwZWNpYWxseSBoZWxwZnVsIGZvciBtZWFzdXJpbmcgc2hvcnQgZXZlbnRz
Lg0KPiA+IFRoYXQncyB3aGF0IHdlIHVzZWQgdG8gaGF2ZToNCj4gPiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICQgcGVyZiBzdGF0
IC9iaW4vc2ggLWMgL3Jvb3QvbG1iZW5jaC1tYXN0ZXIvYmluL2FyYy9oZWxsbyA+IC9kZXYvbnVs
bA0KPiA+IA0KPiA+ICBQZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnL2Jpbi9zaCAtYyAv
cm9vdC9sbWJlbmNoLW1hc3Rlci9iaW4vYXJjL2hlbGxvJzoNCj4gPiANCj4gPiAgICAgICAgICAx
MC4wMDAwMDAgICAgICB0YXNrLWNsb2NrIChtc2VjKSAgICAgICAgICMgICAgMi44MzIgQ1BVcyB1
dGlsaXplZA0KPiA+ICAgICAgICAgICAgICAgICAgMSAgICAgIGNvbnRleHQtc3dpdGNoZXMgICAg
ICAgICAgIyAgICAwLjEwMCBLL3NlYw0KPiA+ICAgICAgICAgICAgICAgICAgMSAgICAgIGNwdS1t
aWdyYXRpb25zICAgICAgICAgICAgIyAgICAwLjEwMCBLL3NlYw0KPiA+ICAgICAgICAgICAgICAg
ICA2MyAgICAgIHBhZ2UtZmF1bHRzICAgICAgICAgICAgICAgIyAgICAwLjAwNiBNL3NlYw0KPiA+
ICAgICAgICAgICAgMzA0OTQ4MCAgICAgIGN5Y2xlcyAgICAgICAgICAgICAgICAgICAgIyAgICAw
LjMwNSBHSHoNCj4gPiAgICAgICAgICAgIDEwOTEyNTkgICAgICBpbnN0cnVjdGlvbnMgICAgICAg
ICAgICAgICMgICAgMC4zNiAgaW5zbiBwZXIgY3ljbGUNCj4gPiAgICAgICAgICAgICAyNTY4Mjgg
ICAgICBicmFuY2hlcyAgICAgICAgICAgICAgICAgICMgICAyNS42ODMgTS9zZWMNCj4gPiAgICAg
ICAgICAgICAgMjcwMjYgICAgICBicmFuY2gtbWlzc2VzICAgICAgICAgICAgICMgICAxMC41MiUg
b2YgYWxsIGJyYW5jaGVzDQo+ID4gDQo+ID4gICAgICAgIDAuMDAzNTMwNjg3IHNlY29uZHMgdGlt
ZSBlbGFwc2VkDQo+ID4gDQo+ID4gICAgICAgIDAuMDAwMDAwMDAwIHNlY29uZHMgdXNlcg0KPiA+
ICAgICAgICAwLjAxMDAwMDAwMCBzZWNvbmRzIHN5cw0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLT44LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gDQo+ID4gQW5kIG5vdyB3
ZSdsbCBzZWU6DQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gPiAkIHBlcmYgc3RhdCAvYmluL3NoIC1jIC9yb290L2xtYmVuY2gt
bWFzdGVyL2Jpbi9hcmMvaGVsbG8gPiAvZGV2L251bGwNCj4gPiANCj4gPiAgUGVyZm9ybWFuY2Ug
Y291bnRlciBzdGF0cyBmb3IgJy9iaW4vc2ggLWMgL3Jvb3QvbG1iZW5jaC1tYXN0ZXIvYmluL2Fy
Yy9oZWxsbyc6DQo+ID4gDQo+ID4gICAgICAgICAgIDMuMDA0MzIyICAgICAgdGFzay1jbG9jayAo
bXNlYykgICAgICAgICAjICAgIDAuODY1IENQVXMgdXRpbGl6ZWQNCj4gPiAgICAgICAgICAgICAg
ICAgIDEgICAgICBjb250ZXh0LXN3aXRjaGVzICAgICAgICAgICMgICAgMC4zMzMgSy9zZWMNCj4g
PiAgICAgICAgICAgICAgICAgIDEgICAgICBjcHUtbWlncmF0aW9ucyAgICAgICAgICAgICMgICAg
MC4zMzMgSy9zZWMNCj4gPiAgICAgICAgICAgICAgICAgNjMgICAgICBwYWdlLWZhdWx0cyAgICAg
ICAgICAgICAgICMgICAgMC4wMjEgTS9zZWMNCj4gPiAgICAgICAgICAgIDI5ODY3MzQgICAgICBj
eWNsZXMgICAgICAgICAgICAgICAgICAgICMgICAgMC45OTQgR0h6DQo+ID4gICAgICAgICAgICAx
MDg3NDY2ICAgICAgaW5zdHJ1Y3Rpb25zICAgICAgICAgICAgICAjICAgIDAuMzYgIGluc24gcGVy
IGN5Y2xlDQo+ID4gICAgICAgICAgICAgMjU1MjA5ICAgICAgYnJhbmNoZXMgICAgICAgICAgICAg
ICAgICAjICAgODQuOTQ3IE0vc2VjDQo+ID4gICAgICAgICAgICAgIDI2MDAyICAgICAgYnJhbmNo
LW1pc3NlcyAgICAgICAgICAgICAjICAgMTAuMTklIG9mIGFsbCBicmFuY2hlcw0KPiA+IA0KPiA+
ICAgICAgICAwLjAwMzQ3NDgyOSBzZWNvbmRzIHRpbWUgZWxhcHNlZA0KPiA+IA0KPiA+ICAgICAg
ICAwLjAwMzUxOTAwMCBzZWNvbmRzIHVzZXINCj4gPiAgICAgICAgMC4wMDAwMDAwMDAgc2Vjb25k
cyBzeXMNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiA+IA0KPiA+IE5vdGUgaG93IG11Y2ggbW9yZSBtZWFuaW5nZnVsIGlzIHRo
ZSBzZWNvbmQgb3V0cHV0IC0gdGltZSBzcGVudCBmb3INCj4gPiBleGVjdXRpb24gcHJldHR5IG11
Y2ggbWF0Y2hlcyBudW1iZXIgb2YgY3ljbGVzIHNwZW50ICh3ZSdyZSBydW5uaWduDQo+ID4gQCAx
R0h6IGhlcmUpLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhleSBCcm9ka2luIDxhYnJv
ZGtpbkBzeW5vcHN5cy5jb20+DQo+ID4gQ2M6IERhbmllbCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fu
b0BsaW5hcm8ub3JnPg0KPiA+IENjOiBWaW5lZXQgR3VwdGEgPHZndXB0YUBzeW5vcHN5cy5jb20+
DQo+ID4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiA+IC0tLQ0K
PiANCj4gQXBwbGllZCwgdGhhbmtzLg0KDQpNYXliZSBhIGJpdCB0b28gbGF0ZSBidXQgSSBjb21w
bGV0ZWx5IGZvcmdvdCB0byBhZGQgc3RhYmxlIHRhZyBpbnRvIENjIGxpc3QuDQpBbnkgY2hhbmNl
IHRvIGFkZCBpdCBzdGlsbD8NCg0KLUFsZXhleQ0K
