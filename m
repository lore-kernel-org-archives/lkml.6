Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC41C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B79221852
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SXTCiUzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbeLTOc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:32:59 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:53040 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387522AbeLTOc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:32:59 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3F84624E1065;
        Thu, 20 Dec 2018 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545316378; bh=GOeeGQYGm4G/inhh155glchXwRUk2B2MXoesoIy4i8A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SXTCiUztfb3IDqMdskTrelyyR4NkaQp7GpHRB7D1C7jhIepoOfr/E3+7/IgLEAPn7
         aQNxwbYvyv62kYZeBle75lwOYy45ubl5trfBPNFYaA2V2FsNL5F0jQ65cqzF/Rmqb2
         AkmyreJpLxt44nOvWCUvTJgWT3Oh1PP2f79xTcqDVC8IAZDVnSkIid8+Y0oYp+nniP
         QZ9jsL6nD/dMVWC6ciHYfAI5yohSaBCpsNS/x4jLfpeN0iPjWWvPqaXsTkS0JRuVdY
         9shkXjxEGqVwCmHDIvCFbfTHYJd0tb7KE+19b0EptBkNTb565QSXWBpjcSNhPI3/99
         hid/6p4cWYZdw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 69A3A5BD6;
        Thu, 20 Dec 2018 06:32:56 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 20 Dec 2018 06:32:56 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 20 Dec 2018 15:32:53 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "hch@lst.de" <hch@lst.de>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: ensure dma_alloc_coherent always returns zeroed memory
Thread-Topic: ensure dma_alloc_coherent always returns zeroed memory
Thread-Index: AQHUk4aSEUXLnU4haEedcBZA0NDmW6WGQKSAgAFpToA=
Date:   Thu, 20 Dec 2018 14:32:52 +0000
Message-ID: <1545316369.14089.20.camel@synopsys.com>
References: <20181214082515.14835-1-hch@lst.de>
         <20181219165939.GA26087@lst.de>
In-Reply-To: <20181219165939.GA26087@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE3F2B66B5D61E4486F0534F863C1240@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpJIHRlc3Qga2VybmVsIGZyb20geW91ciAnZG1hLWFsbG9jLWFsd2F5
cy16ZXJvJyBicmFuY2gsIGFuZCBhcw0KSSBjYW4gc2VlIHdlIGhhdmUgRE1BIHBlcmlwaGVyYWxz
IChsaWtlIFVTQikgYnJva2VuLg0KDQpUaGVyZSBhcmUgdGhlIGVycm9ycyBleGFtcGxlIEkgZ290
IGR1cmluZyBVU0IgaW5pdGlhbGl6aW5nOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
PjgtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KdXNiIDEtMTogZGV2aWNlIGRlc2Ny
aXB0b3IgcmVhZC82NCwgZXJyb3IgLTExMA0KdXNiIHVzYjEtcG9ydDE6IGF0dGVtcHQgcG93ZXIg
Y3ljbGUNCnVzYiAxLTE6IG5ldyBoaWdoLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDQgdXNpbmcg
ZWhjaS1wbGF0Zm9ybQ0KdXNiIDEtMTogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3Ig
LTExMA0KdXNiIDEtMTogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC82NCwgZXJyb3IgLTExMA0KdXNi
IDEtMTogbmV3IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgNSB1c2luZyBlaGNpLXBsYXRm
b3JtDQp1c2IgMS0xOiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtMTEwDQp1c2Ig
MS0xOiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzY0LCBlcnJvciAtMTEwDQp1c2IgdXNiMS1wb3J0
MTogdW5hYmxlIHRvIGVudW1lcmF0ZSBVU0IgZGV2aWNlDQp1c2IgMi0xOiBuZXcgZnVsbC1zcGVl
ZCBVU0IgZGV2aWNlIG51bWJlciAyIHVzaW5nIG9oY2ktcGxhdGZvcm0NCnVzYiAyLTE6IGRldmlj
ZSBkZXNjcmlwdG9yIHJlYWQvYWxsLCBlcnJvciAtODQNCnVzYiAyLTE6IG5ldyBmdWxsLXNwZWVk
IFVTQiBkZXZpY2UgbnVtYmVyIDMgdXNpbmcgb2hjaS1wbGF0Zm9ybQ0KdXNiIDItMTogZGV2aWNl
IGRlc2NyaXB0b3IgcmVhZC9hbGwsIGVycm9yIC04NA0KdXNiIHVzYjItcG9ydDE6IGF0dGVtcHQg
cG93ZXIgY3ljbGUNCnVzYiAyLTE6IG5ldyBmdWxsLXNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDQg
dXNpbmcgb2hjaS1wbGF0Zm9ybQ0KdXNiIDItMTogZGV2aWNlIGRlc2NyaXB0b3IgcmVhZC84LCBl
cnJvciAtNjINCnVzYiAyLTE6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvOCwgZXJyb3IgLTYyDQp1
c2IgMi0xOiBuZXcgZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciA1IHVzaW5nIG9oY2ktcGxh
dGZvcm0NCnVzYiAyLTE6IGRldmljZSBkZXNjcmlwdG9yIHJlYWQvOCwgZXJyb3IgLTg0DQp1c2Ig
Mi0xOiBkZXZpY2UgZGVzY3JpcHRvciByZWFkLzgsIGVycm9yIC04NA0KdXNiIHVzYjItcG9ydDE6
IHVuYWJsZSB0byBlbnVtZXJhdGUgVVNCIGRldmljZQ0KIFtzbmlwXQ0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tODwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQoNCk9u
IFdlZCwgMjAxOC0xMi0xOSBhdCAxNzo1OSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6
DQo+IEZZSSwgSSd2ZSBwaWNrZWQgdGhpcyB1cCBmb3IgZG1hLW1hcHBpbmcgZm9yLW5leHQgbm93
Lg0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cj4gbGludXgtc25wcy1hcmMgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXNucHMtYXJjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91
PWh0dHAtM0FfX2xpc3RzLmluZnJhZGVhZC5vcmdfbWFpbG1hbl9saXN0aW5mb19saW51eC0yRHNu
cHMtMkRhcmMmZD1Ed0lDQWcmYz1EUEw2X1hfNkprWEZ4N0FYV3FCMHRnJnI9WmxKTg0KPiAxTXJp
UFVUa0JLQ3JQU3g2N0dtYXBsRVVHY0FFazl5UHRDTGRVWEkmbT1uYUJDVDk2QTRSU1FKTHpCV3p1
Q2NtcHRGR2lRRGZGVE9XSnBwcnFESVZrJnM9Y0hGODR2YTg5b2ZQNlZsclY2ODNld0VOVVhkYUxX
N29wYW1MWlNrWkJnayZlPQ0KLS0gDQogRXVnZW5peSBQYWx0c2V2
