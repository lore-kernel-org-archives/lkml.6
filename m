Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BBDC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9BC21736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Ou4xRxSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9BC21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732723AbeHNRWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:22:32 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:49538 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbeHNRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:22:32 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D7D4524E121E;
        Tue, 14 Aug 2018 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1534257306; bh=0MJQb5iNXt4hQz3uLgiHhuZzqUufFGDPoPlBD2zegbE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Ou4xRxSdWhWWR1jB0JW0UJH5bD+64WURSrv9ebIL4EoeokFgYGhpuQ8kMTlzwo2VH
         ppBmu17IDY/afJJtcnNJ9BxoBwSwRwWuJxvw/AUuCuxtrVwOCYoYywz1E6uiYT4jGI
         nN9Dmw2Ye3f4ZTt7KPWe+O8Gh98hHxb1IeaOcAuljCXaC+1AOEPQOGQy/7UgnBvYJp
         rV9YXJsatbDm0+mMK4PASbaVB1Dv1lpalr9H7cDhr26OdpF5XRzTl0+u3r7u+YO5Ho
         PESVVvlUAoImfymWqHsctzsXEeDnzEdXhoKKBP1ArF4/GJIDvJxh4pd3qG6ZEO+9UD
         kqIXePLUt3KCQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id C47673748;
        Tue, 14 Aug 2018 07:35:05 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 14 Aug 2018 07:35:05 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Tue,
 14 Aug 2018 16:35:03 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Vineet Gupta" <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Subject: Re: [PATCH] ARC: atomic64: fix atomic64_add_unless function
Thread-Topic: [PATCH] ARC: atomic64: fix atomic64_add_unless function
Thread-Index: AQHUMY2lhSLajPX2o0m683Cq9/FBEKS/M1SA
Date:   Tue, 14 Aug 2018 14:35:02 +0000
Message-ID: <1534257301.3962.79.camel@synopsys.com>
References: <20180811160856.24936-1-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075012B08CB78@us01wembx1.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B08CB78@us01wembx1.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.86]
Content-Type: text/plain; charset="utf-8"
Content-ID: <883CB8865F89B841B8764B2D88E4B1F3@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA4LTE0IGF0IDEzOjQyICswMDAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IE9uIDA4LzExLzIwMTggMDk6MDkgQU0sIEV1Z2VuaXkgUGFsdHNldiB3cm90ZToNCj4gPiBDdXJy
ZW50IGltcGxlbWVudGF0aW9uIG9mICdhdG9taWM2NF9hZGRfdW5sZXNzJyBmdW5jdGlvbg0KPiA+
IChhbmQgaGVuY2UgJ2F0b21pYzY0X2luY19ub3RfemVybycpIHJldHVybiBpbmNvcnJlY3QgdmFs
dWUNCj4gPiBpZiBsb3ZlciAzMiBiaXRzIG9mIGNvbXBhcmVkIDY0LWJpdCBudW1iZXIgYXJlIGVx
dWFsIGFuZA0KPiA+IGhpZ2hlciAzMiBiaXRzIGFyZW4ndC4NCj4gPiANCj4gPiBGb3IgaW4gZm9s
bG93aW5nIGV4YW1wbGUgYXRvbWljNjRfYWRkX3VubGVzcyBtdXN0IHJldHVybiAnMScNCj4gPiBi
dXQgaXQgYWN0dWFsbHkgcmV0dXJucyAnMCc6DQo+ID4gLS0tLS0tLS0tPjgtLS0tLS0tLS0NCj4g
PiBhdG9taWM2NF90IHZhbCA9IEFUT01JQzY0X0lOSVQoMHg0NDQ0MDAwMDAwMDAwMDAwTEwpOw0K
PiA+IGludCByZXQgPSBhdG9taWM2NF9hZGRfdW5sZXNzKCZ2YWwsIDFMTCwgMExMKQ0KPiA+IC0t
LS0tLS0tLT44LS0tLS0tLS0tDQo+ID4gDQo+ID4gVGhpcyBoYXBwZW5zIGJlY2F1c2Ugd2Ugd3Jp
dGUgJzAnIHRvIHJldHVybmVkIHZhcmlhYmxlIHJlZ2FyZGxlc3MNCj4gPiBvZiBoaWdoZXIgMzIg
Yml0cyBjb21wYXJpc29uIHJlc3VsdC4NCj4gPiANCj4gPiBTbyBmaXggaXQuDQo+ID4gDQo+ID4g
Tk9URToNCj4gPiAgdGhpcyBjaGFuZ2Ugd2FzIHRlc3RlZCB3aXRoIGF0b21pYzY0X3Rlc3QuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5LlBhbHRzZXZA
c3lub3BzeXMuY29tPg0KPiANCj4gTEdUTS4gQ3VyaW91cywgd2FzIHRoaXMgZnJvbSBjb2RlIHJl
dmlldyBvciBkaWQgdSBhY3R1YWxseSBydW4gaW50byB0aGlzID8NCg0KSSd2ZSBhY2NpZGVudGFs
bHkgcnVuIGludG8gdGhpcyB3aGVuIEkgcGxheWVkIHdpdGggYXRvbWljNjRfKiBmdW5jdGlvbnMN
CnRyeWluZyB0byBpbXBsZW1lbnQgaGFjayB0byBhdXRvbWF0aWNhbGx5IGFsaWduIExMNjQvU0M2
NCBkYXRhIGZvciBhdG9taWMgNjQtYml0DQpvcGVyYXRpb25zIG9uIEFSQyB0byBhdm9pZCBwcm9i
bGVtcyBsaWtlOg0KaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9saW51eC1zbnBzLWFyY0Bs
aXN0cy5pbmZyYWRlYWQub3JnL21zZzAzNzkxLmh0bWwNCg0KPiBUaHgsDQo+IC1WaW5lZXQNCj4g
DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2F0b21pYy5oIHwgMiArLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMvaW5jbHVkZS9hc20vYXRvbWljLmggYi9hcmNoL2FyYy9p
bmNsdWRlL2FzbS9hdG9taWMuaA0KPiA+IGluZGV4IDExODU5Mjg3YzUyYS4uZTg0MGNiMTc2M2Iy
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJjL2luY2x1ZGUvYXNtL2F0b21pYy5oDQo+ID4gKysr
IGIvYXJjaC9hcmMvaW5jbHVkZS9hc20vYXRvbWljLmgNCj4gPiBAQCAtNTc4LDExICs1NzgsMTEg
QEAgc3RhdGljIGlubGluZSBpbnQgYXRvbWljNjRfYWRkX3VubGVzcyhhdG9taWM2NF90ICp2LCBs
b25nIGxvbmcgYSwgbG9uZyBsb25nIHUpDQo+ID4gIA0KPiA+ICAJX19hc21fXyBfX3ZvbGF0aWxl
X18oDQo+ID4gIAkiMToJbGxvY2tkICAlMCwgWyUyXQlcbiINCj4gPiAtCSIJbW92CSUxLCAxCQlc
biINCj4gPiAgCSIJYnJuZQklTDAsICVMNCwgMmYJIyBjb250aW51ZSB0byBhZGQgc2luY2UgdiAh
PSB1IFxuIg0KPiA+ICAJIglicmVxLmQJJUgwLCAlSDQsIDNmCSMgcmV0dXJuIHNpbmNlIHYgPT0g
dSBcbiINCj4gPiAgCSIJbW92CSUxLCAwCQlcbiINCj4gPiAgCSIyOgkJCQlcbiINCj4gPiArCSIJ
bW92CSUxLCAxCQlcbiINCj4gPiAgCSIJYWRkLmYgICAlTDAsICVMMCwgJUwzCVxuIg0KPiA+ICAJ
IglhZGMgICAgICVIMCwgJUgwLCAlSDMJXG4iDQo+ID4gIAkiCXNjb25kZCAgJTAsIFslMl0JXG4i
DQo+IA0KPiANCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg==
