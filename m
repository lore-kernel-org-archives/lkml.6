Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C9A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RJS+7Mu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C9A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbeH3Sti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:49:38 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:54584 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbeH3Ssv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:48:51 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D929724E0452;
        Thu, 30 Aug 2018 07:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535640381; bh=ikW+P3kPxgPiqszQVp+oF89NNj72jufU9XeolUuRBLo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RJS+7Mu8KJmmwCwJrBwi1mqwFw0e/vrVaK/EUpUvra7oYt+IJp1Xwh08thF1fApOg
         DCj+l4hHka5mFUKnAnbmeRhYfsKM8SxU2fXWHU1Viuox7Tl5a9/+mfZdXMhWbWYbqg
         9fCyiMzN8AfBr50Z7bfVw1Qv9dgHtCLq2CwyPmEDUvMFEHkRnur02MQxGoo8CtMWKz
         IKgf/bUEAOyIrmW9mwp8e5Plo8YKqkBLKY7YjNN1aIjYFx7yl1Bdp3YdiFZWjdNVN1
         jg0h7R/zXc9DntdHvoIXzleHOHtm4ZbcdQN3OWWwgRUWfWfs0IsaT/aqoGU3q5O99m
         /bc8YzI1nawhg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id E02115B3B;
        Thu, 30 Aug 2018 07:46:20 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 30 Aug 2018 07:46:20 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 30 Aug 2018 16:46:18 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Topic: Patch "asm-generic/bitops/lock.h: Rewrite using atomic_fetch_"
 causes kernel crash
Thread-Index: AQHUP8bWpY6ZRO7qfEeDcvF8FJVDUqTX6u2AgAACIoCAACHvAIAAKDiAgAAIHIA=
Date:   Thu, 30 Aug 2018 14:46:16 +0000
Message-ID: <1535640375.4465.68.camel@synopsys.com>
References: <1535567633.4465.23.camel@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B090BEA@us01wembx1.internal.synopsys.com>
         <20180830094411.GX24124@hirez.programming.kicks-ass.net>
         <20180830095148.GB5942@arm.com> <1535629996.4465.44.camel@synopsys.com>
         <20180830141713.GN24082@hirez.programming.kicks-ass.net>
In-Reply-To: <20180830141713.GN24082@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.36]
Content-Type: text/plain; charset="utf-8"
Content-ID: <244CAC2AC2A4F0498C22EA8E008B89D6@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA4LTMwIGF0IDE2OjE3ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gT24gVGh1LCBBdWcgMzAsIDIwMTggYXQgMTE6NTM6MTdBTSArMDAwMCwgRXVnZW5peSBQYWx0
c2V2IHdyb3RlOg0KPiA+IEkgY2FuIHNlZSBjcmFzaGVzIHdpdGggTExTQyBlbmFibGVkIGluIGJv
dGggU01QIHJ1bm5pbmcgb24gNCBjb3Jlcw0KPiA+IGFuZCBTTVAgcnVubmluZyBvbiAxIGNvcmUu
DQo+IA0KPiBTbyB5b3UncmUgcnVubmluZyBvbiBMTC9TQyBlbmFibGVkIGhhcmR3YXJlOyB0aGF0
IHdvdWxkIG1ha2UgV2lsbCdzDQo+IHBhdGNoIGlycmVsZXZhbnQgKGFsdGhvdWdoIHN0aWxsIGEg
Z29vZCBpZGVhIGZvciB0aGUgaGFyZHdhcmUgdGhhdCBkb2VzDQo+IGNhcmUgYWJvdXQgdGhhdCBz
cGlubG9ja2VkIGF0b21pYyBjcnVkKS4NCj4gDQo+IERvZXMgc29tZXRoaW5nIGxpa2UgdGhlIGJl
bG93IGN1cmUgdGhpbmdzPyBUaGF0IHdvdWxkIGNvbmZpcm0gdGhlDQo+IHN1Z2dlc3Rpb24gdGhh
dCB0aGUgY2hhbmdlIHRvIF9fY2xlYXJfYml0X3VubG9jaygpIGlzIHRoZSBjdXJwcml0Lg0KDQpJ
IHRlc3RlZCBpdCAtIHRoaXMgZG9lc24ndCBjaGFuZ2UgYW55dGhpbmcsIHRoZSBwcm9ibGVtIHN0
aWxsIHJlcHJvZHVjZXMuDQoNCkknbGwgdGVzdCBpdCB3aXRoIGxhc3QgV2lsbCBmaXguDQoNCg0K
PiBJZiB0aGF0IGRvZXNuJ3QgY3VyZSB0aGluZ3MsIHRoZW4gd2UndmUgYmVlbiBsb29raW5nIGlu
IGVudGlyZWx5IHRoZQ0KPiB3cm9uZyBwbGFjZS4NCj4gDQo+IC0tLQ0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9hc20tZ2VuZXJpYy9iaXRvcHMvbG9jay5oIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9i
aXRvcHMvbG9jay5oDQo+IGluZGV4IDNhZTAyMTM2OGY0OC4uNzljNjk3ODE1MmY4IDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9sb2NrLmgNCj4gKysrIGIvaW5jbHVk
ZS9hc20tZ2VuZXJpYy9iaXRvcHMvbG9jay5oDQo+IEBAIC01NywxMiArNTcsNyBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgY2xlYXJfYml0X3VubG9jayh1bnNpZ25lZCBpbnQgbnIsIHZvbGF0aWxlIHVu
c2lnbmVkIGxvbmcgKnApDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgX19jbGVhcl9iaXRfdW5sb2Nr
KHVuc2lnbmVkIGludCBuciwNCj4gIAkJCQkgICAgICB2b2xhdGlsZSB1bnNpZ25lZCBsb25nICpw
KQ0KPiAgew0KPiAtCXVuc2lnbmVkIGxvbmcgb2xkOw0KPiAtDQo+IC0JcCArPSBCSVRfV09SRChu
cik7DQo+IC0Jb2xkID0gUkVBRF9PTkNFKCpwKTsNCj4gLQlvbGQgJj0gfkJJVF9NQVNLKG5yKTsN
Cj4gLQlhdG9taWNfbG9uZ19zZXRfcmVsZWFzZSgoYXRvbWljX2xvbmdfdCAqKXAsIG9sZCk7DQo+
ICsJY2xlYXJfYml0X3VubG9jayhuciwgcCk7DQo+ICB9DQo+ICANCj4gIC8qKg0KLS0gDQogRXVn
ZW5peSBQYWx0c2V2
