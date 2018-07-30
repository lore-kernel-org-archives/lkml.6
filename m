Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD9213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C999020870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QfZjB5h4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C999020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeG3MIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:08:45 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:34072 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeG3MIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:08:45 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 52F6610C1171;
        Mon, 30 Jul 2018 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532946864; bh=1O1ZAhd4mAlA7iMb5e6w7bYkYm8gtZbmG9M+7S3rpbg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=QfZjB5h4HF5gIZbzVYT2TpROSiqX8Wxx+Q/ULYx9Ro8h8yH139XBixPRwxuxqJcZ0
         Mpq8OFXTkmRoyELqQNqNdTiIVtrpSQRVNGftTDiMWNGgf5pkFzxaG5qAe8j8H+PxyN
         oyg4QqiiBEKwDYN0cJMiSXdWHPFeIzzqDg1yZ0Ilj6wyKkDhztad83qEX3seON1gmC
         WNkEDhzqicJtNgCAVecUSI/uzakcS/B7e4zUhsbJnQNmvvnc1OfqE6qnCs+3siku7y
         hZkc+4bFozlPyMkepbZC4N2uSU48X9Lw24ZxJEkyetFH8+cqITBLmo1WBfJ1TJTJMR
         OHJE2GueHHR9g==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1801E36A0;
        Mon, 30 Jul 2018 03:34:24 -0700 (PDT)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Mon, 30 Jul 2018 03:34:23 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Mon,
 30 Jul 2018 12:34:22 +0200
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "Alexey.Brodkin@synopsys.com" <Alexey.Brodkin@synopsys.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 3/4] ARC: refactor arch/arc/mm/dma.c
Thread-Topic: [PATCH 3/4] ARC: refactor arch/arc/mm/dma.c
Thread-Index: AQHUIzaVrV4KuWklskG7eut3+OJxHKShGwIAgAZeyIA=
Date:   Mon, 30 Jul 2018 10:34:20 +0000
Message-ID: <1532946859.3059.8.camel@synopsys.com>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
         <20180724101001.31965-4-Eugeniy.Paltsev@synopsys.com>
         <20180726091731.GC24209@lst.de>
In-Reply-To: <20180726091731.GC24209@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.86]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAD9DEFCFE16EA4C980E8F3C30C8875F@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA3LTI2IGF0IDExOjE3ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBKdWwgMjQsIDIwMTggYXQgMDE6MTA6MDBQTSArMDMwMCwgRXVnZW5peSBQ
YWx0c2V2IHdyb3RlOg0KPiA+IFJlZmFjdG9yaW5nLCBubyBmdW5jdGlvbmFsIGNoYW5nZSBpbnRl
bmRlZC4NCj4gPiAgDQpbc25pcF0NCj4gPiAgDQo+ID4gIAkqZG1hX2hhbmRsZSA9IHBhZGRyOw0K
PiA+ICANCj4gPiArCS8qDQo+ID4gKwkgKiAtIEEgY29oZXJlbnQgYnVmZmVyIG5lZWRzIE1NVSBt
YXBwaW5nIHRvIGVuZm9yY2Ugbm9uLWNhY2hhYmlsaXR5DQo+ID4gKwkgKiAtIEEgaGlnaG1lbSBw
YWdlIG5lZWRzIGEgdmlydHVhbCBoYW5kbGUgKGhlbmNlIE1NVSBtYXBwaW5nKQ0KPiA+ICsJICog
ICBpbmRlcGVuZGVudCBvZiBjYWNoYWJpbGl0eS4NCj4gPiArCSAqIGt2YWRkciBpcyBrZXJuZWwg
VmlydHVhbCBhZGRyZXNzICgweDcwMDBfMDAwMCBiYXNlZCkNCj4gPiArCSAqLw0KPiA+ICsJaWYg
KFBhZ2VIaWdoTWVtKHBhZ2UpIHx8IG5lZWRfY29oKSB7DQo+IA0KPiBkbWFfYWxsb2NfYXR0cnMg
Y2xlYXJzIF9fR0ZQX0hJR0hNRU0gZnJvbSB0aGUgcGFzc2VkIGluIGdmcCBtYXNrLCBzbw0KPiB5
b3UnbGwgbmV2ZXIgZ2V0IGEgaGlnaG1lbSBwYWdlIGhlcmUuDQo+IA0KDQpOaWNlIGNhdGNoLCB0
aGFua3MuDQpXaWxsIHJlbW92ZSBjaGVjayBmb3IgaGlnaG1lbSBwYWdlIGluIG5leHQgcGF0Y2gg
dmVyc2lvbi4gDQoNCj4gVGhhdCBhbHNvIG1lYW5zIHlvdSBjYW4gbWVyZ2UgdGhpcyBjb25kaXRp
b25hbCB3aXRoIHRoZSBvbmUgZm9yIHRoZSBjYWNoZQ0KPiB3cml0ZWJhY2sgYW5kIGludmFsaWRh
dGlvbiBhbmQga2lsbCB0aGUgbmVlZF9jb2ggZmxhZyBlbnRpcmVseS4NCj4gDQo+ID4gIAkJa3Zh
ZGRyID0gaW9yZW1hcF9ub2NhY2hlKHBhZGRyLCBzaXplKTsNCj4gPiAgCQlpZiAoa3ZhZGRyID09
IE5VTEwpIHsNCj4gPiAgCQkJX19mcmVlX3BhZ2VzKHBhZ2UsIG9yZGVyKTsNCj4gPiBAQCAtODEs
MTEgKzc1LDkgQEAgdm9pZCBhcmNoX2RtYV9mcmVlKHN0cnVjdCBkZXZpY2UgKmRldiwgc2l6ZV90
IHNpemUsIHZvaWQgKnZhZGRyLA0KPiA+ICB7DQo+ID4gIAlwaHlzX2FkZHJfdCBwYWRkciA9IGRt
YV9oYW5kbGU7DQo+ID4gIAlzdHJ1Y3QgcGFnZSAqcGFnZSA9IHZpcnRfdG9fcGFnZShwYWRkcik7
DQo+ID4gLQlpbnQgaXNfbm9uX2NvaCA9IDE7DQo+ID4gLQ0KPiA+IC0JaXNfbm9uX2NvaCA9IChh
dHRycyAmIERNQV9BVFRSX05PTl9DT05TSVNURU5UKTsNCj4gPiArCWJvb2wgaXNfY29oID0gIShh
dHRycyAmIERNQV9BVFRSX05PTl9DT05TSVNURU5UKTsNCj4gPiAgDQo+ID4gLQlpZiAoUGFnZUhp
Z2hNZW0ocGFnZSkgfHwgIWlzX25vbl9jb2gpDQo+ID4gKwlpZiAoUGFnZUhpZ2hNZW0ocGFnZSkg
fHwgaXNfY29oKQ0KPiA+ICAJCWlvdW5tYXAoKHZvaWQgX19mb3JjZSBfX2lvbWVtICopdmFkZHIp
Ow0KPiA+ICANCj4gDQo+IFNhbWUgaGVyZS4NCj4gDQo+IEFsc28gaWYgeW91IGNsZWFuIHRoaXMg
dXAgaXQgd291bGQgYmUgZ3JlYXQgdG8gdGFrZSB0aGUgcGVyLWRldmljZSBwZm4gb2Zmc2V0DQo+
IGludG8gYWNjb3VudCwgZXZlbiBpZiB0aGF0IGlzbid0IHVzZWQgYW55d2hlcmUgb24gYXJjIHll
dCwgdGhhdCBpcyBjYWxsDQo+IHBoeXNfdG9fZG1hIGFuZCBkbWFfdG9fcGh5cyB0byBjb252ZXJ0
IHRvIGFuIGZyb20gdGhlIGRtYSBhZGRyZXNzLg0KDQpPaywgSSdsbCBsb29rIGF0IGl0Lg0KUHJv
YmFibHkgSSdsbCBpbXBsZW1lbnQgaXQgYXMgYSBzZXBhcmF0ZSBwYXRjaCBhcyBpdCBpcyBpcnJl
bGV2YW50IHRvIHRoaXMNCnBhdGNoIHNlcmllcyB0b3BpYy4NCg0KLS0gDQogRXVnZW5peSBQYWx0
c2V2
