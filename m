Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F253C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 405FC21852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S6haeK9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387668AbeLTOjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:39:25 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:53220 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731737AbeLTOjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:39:24 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id A271024E1024;
        Thu, 20 Dec 2018 06:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545316764; bh=PSaIbdm1pTweGDxdz0+CtGyfSqlmkKGLtd9gBB8k3Fk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=S6haeK9BYiMbEw8naQIUZmNOhPPKmH5WS/eK1XxivEPZoP4rXOLY8nLRtNBCN0CVB
         qxloqvHh037jtMwAn6lD2efJCAa62AS98VuxthH2r55ErL6i8+oGmmzOUz/iVMAdBH
         LOCPxa9yqpPpr6OwJsWIDxvt4EElx1xA2L33y1V0+XAVZvFCIHaqX8CtY8TWr3fc0Y
         +31RGWBvCJ0fsuug/p+K44LD0g9y+W741CC6TC4tQMR9wLLEPLevCWJ6PB0pYMywxs
         rE6h+/VlE9KZG4Maee6Y20I93akMYiYlwfDWdVL8POJ3m9/2TrbCSTBGki9hpv3PL9
         LCQCnw9e5cSJw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 28F295031;
        Thu, 20 Dec 2018 06:39:23 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 20 Dec 2018 06:39:23 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 20 Dec 2018 15:39:20 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "hch@lst.de" <hch@lst.de>,
        "eugeniy.paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: ensure dma_alloc_coherent always returns zeroed memory
Thread-Topic: ensure dma_alloc_coherent always returns zeroed memory
Thread-Index: AQHUk4aSEUXLnU4haEedcBZA0NDmW6WGQKSAgAFpToCAAABngIAAAWqA
Date:   Thu, 20 Dec 2018 14:39:20 +0000
Message-ID: <1545316759.14089.22.camel@synopsys.com>
References: <20181214082515.14835-1-hch@lst.de>
         <20181219165939.GA26087@lst.de> <1545316369.14089.20.camel@synopsys.com>
         <20181220143415.GA17726@lst.de>
In-Reply-To: <20181220143415.GA17726@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <97A4157C2B777C4DAB00EFA080F46E4C@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTEyLTIwIGF0IDE1OjM0ICswMTAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBUaHUsIERlYyAyMCwgMjAxOCBhdCAwMjozMjo1MlBNICswMDAwLCBFdWdlbml5IFBhbHRzZXYg
d3JvdGU6DQo+ID4gSGkgQ2hyaXN0b3BoLA0KPiA+IA0KPiA+IEkgdGVzdCBrZXJuZWwgZnJvbSB5
b3VyICdkbWEtYWxsb2MtYWx3YXlzLXplcm8nIGJyYW5jaCwgYW5kIGFzDQo+ID4gSSBjYW4gc2Vl
IHdlIGhhdmUgRE1BIHBlcmlwaGVyYWxzIChsaWtlIFVTQikgYnJva2VuLg0KPiANCj4gSSB3b3Vs
ZCBiZSByZWFsbHkgc3VycHJpc2VkIGlmIHRoYXQgaXMgY2F1c2VkIGJ5IHRoZSBwYXRjaCB0byBh
ZGQNCj4gdGhlIHplcm9pbmcuIA0KTWUgdG9vIDopDQoNCj4gIENhbiB5b3UgY2hlY2sgd2hpY2gg
Y29tbWl0IGNhdXNlZCB0aGUgaXNzdWUgYnkgYmlzZWN0aW5nDQo+IGZyb20gYSBrbm93biBnb29k
IGJhc2VsaW5lPw0KDQpZZXAuIEF0IGxlYXN0IGtlcm5lbCBidWlsZCBmcm9tIHY0LjIwLXJjNCAo
d2hpY2ggaXMgYmFzZSBmb3IgeW91ciBicmFuY2gpDQpzZWVtcyB0byB3b3JrIGZpbmUuDQoNCi0t
IA0KIEV1Z2VuaXkgUGFsdHNldg==
