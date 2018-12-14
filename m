Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04147C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC9B20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aoxeAYz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC9B20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbeLNM0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:26:00 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:46200 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731882AbeLNMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:12:05 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EE77010C0944;
        Fri, 14 Dec 2018 04:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544789524; bh=vxyUbWIKMM1FKX/hrTcLwLlJoo9v5PS5ZjabsjB+cks=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aoxeAYz13vLbNQSXuCF4VK7mGArwR8C4WHj5rrT42fZCM/bajJHwU6KRTeFaGlqFy
         hQzzn7ScSc1XtZ4KE2I8EcfoGsps5IVgvAqS0L3CH++f4A/G/LNOB2lXTOJET9GeQq
         Tf+9siJa4D9GjO4IOYt0dZy2iUO6jplsN83E5cAROQzTfth3RUZWAv49U/ZCfUoTUb
         VN62bzshYhRf4ZpdborsRMMJ35xbVN+piDnDH6b4oET3jq55Y8gP7KS4SivMygD1JM
         BdOGORdkFIIvON+FqbDxNV6ixI3cBtG40mH2avScFpmSUYZBHObJWPlRoy5hpD4IZ+
         Amj5y/e3INwJw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id EC8DC3BB4;
        Fri, 14 Dec 2018 04:12:02 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Dec 2018 04:12:02 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 14 Dec 2018 13:12:00 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "hch@lst.de" <hch@lst.de>,
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
Subject: Re: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Thread-Topic: [PATCH 1/2] dma-mapping: zero memory returned from dma_alloc_*
Thread-Index: AQHUk4aRtLeIbhAYd0qf1lnBWQEMXaV+FJsA
Date:   Fri, 14 Dec 2018 12:12:00 +0000
Message-ID: <1544789518.3270.34.camel@synopsys.com>
References: <20181214082515.14835-1-hch@lst.de>
         <20181214082515.14835-2-hch@lst.de>
In-Reply-To: <20181214082515.14835-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1793738A7430CE4AA844DA21B88BC20D@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQpkbyB5b3UgaGF2ZSBhbnkgcHVibGljIGdpdCByZXBvc2l0b3J5IHdp
dGggYWxsIHlvdXIgZG1hIGNoYW5nZXM/DQoNCkkgd2FudCB0byB0ZXN0IHRoZW0gZm9yIEFSQy4N
Cg0KVGhhbmtzLg0KDQpPbiBGcmksIDIwMTgtMTItMTQgYXQgMDk6MjUgKzAxMDAsIENocmlzdG9w
aCBIZWxsd2lnIHdyb3RlOg0KPiBJZiB3ZSB3YW50IHRvIG1hcCBtZW1vcnkgZnJvbSB0aGUgRE1B
IGFsbG9jYXRvciB0byB1c2Vyc3BhY2UgaXQgbXVzdCBiZQ0KPiB6ZXJvZWQgYXQgYWxsb2NhdGlv
biB0aW1lIHRvIHByZXZlbnQgc3RhbGUgZGF0YSBsZWFrcy4gICBXZSBhbHJlYWR5IGRvDQo+IHRo
aXMgb24gbW9zdCBjb21tb24gYXJjaGl0ZWN0dXJlcywgYnV0IHNvbWUgYXJjaGl0ZWN0dXJlcyBk
b24ndCBkbyB0aGlzDQo+IHlldCwgZml4IHRoZW0gdXAsIGVpdGhlciBieSBwYXNzaW5nIEdGUF9a
RVJPIHdoZW4gd2UgdXNlIHRoZSBub3JtYWwgcGFnZQ0KPiBhbGxvY2F0b3Igb3IgZG9pbmcgYSBt
YW51YWwgbWVtc2V0IG90aGVyd2lzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCi0tIA0KIEV1Z2VuaXkgUGFsdHNldg==
