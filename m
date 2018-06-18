Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18001C5CFC1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95FF208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 02:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="DCWEv8mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95FF208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754532AbeFRCEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 22:04:08 -0400
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:19707 "EHLO
        rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754506AbeFRCEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 22:04:05 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2018 22:04:05 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1500; q=dns/txt; s=iport;
  t=1529287445; x=1530497045;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3zmNxbB7lxuaecBSZ4NsU5/1omR72ctveKmliXvWRf8=;
  b=DCWEv8mcxhStKRkdSOikdDCMD09GEIyeavjgjJdA8U0wQ5uwnC4+WTR+
   W6/zYbj1kgZN5QMFg9EyYQI/eY8hAWHUOlMog7e7Th9b3JpypgAHPHhM4
   0pMZRZ+yJTsQHoThi8tDUyJ2vY9ruLmD+Jw4VVXfpVlSe8bXq2qGlp/X1
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DPAACsDydb/5JdJa1bGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNIgWEoCoNviASMUoF/lHGBeAuEbAIXgjshNBgBAgEBAQE?=
 =?us-ascii?q?BAQJtHQuFKAEBAQQjBA1FEAIBCBUDAgImAgICMBUQAgQOBYUmqgyBaTOIQYF?=
 =?us-ascii?q?ogQuHSYFUP4QbhHUXgmqCVQKHU5FDCQKPB4E/hACHfJEmAhETAYEkHTiBUnA?=
 =?us-ascii?q?Vgn6QT2+PM4EaAQE?=
X-IronPort-AV: E=Sophos;i="5.51,237,1526342400"; 
   d="scan'208";a="411507975"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 01:54:34 +0000
Received: from XCH-ALN-015.cisco.com (xch-aln-015.cisco.com [173.36.7.25])
        by rcdn-core-10.cisco.com (8.14.5/8.14.5) with ESMTP id w5I1sYRp027290
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 18 Jun 2018 01:54:34 GMT
Received: from xch-rcd-012.cisco.com (173.37.102.22) by XCH-ALN-015.cisco.com
 (173.36.7.25) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Sun, 17 Jun
 2018 20:54:33 -0500
Received: from xch-rcd-012.cisco.com ([173.37.102.22]) by
 XCH-RCD-012.cisco.com ([173.37.102.22]) with mapi id 15.00.1320.000; Sun, 17
 Jun 2018 20:54:33 -0500
From:   "Govindarajulu Varadarajan (gvaradar)" <gvaradar@cisco.com>
To:     "ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>
CC:     "alexander.levin@microsoft.com" <alexander.levin@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christian Benvenuti (benve)" <benve@cisco.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Ravi Anand (ravianan)" <ravianan@cisco.com>
Subject: Re: [PATCH 4.4 234/268] enic: enable rq before updating rq
 descriptors
Thread-Topic: [PATCH 4.4 234/268] enic: enable rq before updating rq
 descriptors
Thread-Index: AQHT9m4V4rOpDiyqfkyrQfJLZStrFKRlho+AgAAu/4A=
Date:   Mon, 18 Jun 2018 01:54:33 +0000
Message-ID: <a309f7fb5b2c5a4941c330b975b8b4c698ea3258.camel@cisco.com>
References: <20180528100202.045206534@linuxfoundation.org>
         <20180528100229.860636552@linuxfoundation.org>
         <1529276779.2289.243.camel@codethink.co.uk>
In-Reply-To: <1529276779.2289.243.camel@codethink.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.42.84]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE681ADDA9DA3F47A900171DE7755F53@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA2LTE4IGF0IDAwOjA2ICswMTAwLCBCZW4gSHV0Y2hpbmdzIHdyb3RlOg0K
PiBPbiBNb24sIDIwMTgtMDUtMjggYXQgMTI6MDMgKzAyMDAsIEdyZWcgS3JvYWgtSGFydG1hbiB3
cm90ZToNCj4gPiA0LjQtc3RhYmxlIHJldmlldyBwYXRjaC4gIElmIGFueW9uZSBoYXMgYW55IG9i
amVjdGlvbnMsIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gPiANCj4gPiAtLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiANCj4gPiBGcm9tOiBHb3ZpbmRhcmFqdWx1IFZhcmFkYXJhamFuIDxndmFyYWRhckBj
aXNjby5jb20+DQo+ID4gDQo+ID4gWyBVcHN0cmVhbSBjb21taXQgZTg1ODhlMjY4NTA5MjkyNTUw
NjM0ZDlhMzVmMjcyM2EyMDc2ODNiMiBdDQo+IA0KPiBbLi4uXQ0KPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L2V0aGVybmV0L2Npc2NvL2VuaWMvZW5pY19tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9jaXNjby9lbmljL2VuaWNfbWFpbi5jDQo+IA0KPiBbLi4uXQ0KPiA+IEBAIC0x
NzY1LDggKzE3NjUsMTIgQEAgc3RhdGljIGludCBlbmljX29wZW4oc3RydWN0IG5ldF9kZXZpY2Ug
Kg0KPiA+ID4gIAlyZXR1cm4gMDsNCj4gPiANCj4gPiAgDQo+ID4gIGVycl9vdXRfZnJlZV9ycToN
Cj4gPiAtCWZvciAoaSA9IDA7IGkgPCBlbmljLT5ycV9jb3VudDsgaSsrKQ0KPiA+ICsJZm9yIChp
ID0gMDsgaSA8IGVuaWMtPnJxX2NvdW50OyBpKyspIHsNCj4gPiArCQllcnIgPSB2bmljX3JxX2Rp
c2FibGUoJmVuaWMtPnJxW2ldKTsNCj4gPiArCQlpZiAoZXJyKQ0KPiA+ICsJCQlyZXR1cm4gZXJy
Ow0KPiANCj4gVGhpcyBhZGRlZCBjb2RlIGlzIHdyb25nOiBpdCBvdmVyd3JpdGVzIHRoZSBlcnJv
ciBjb2RlIHRoYXQgd2FzDQo+IHByZXZpb3VzbHkgaW4gZXJyLiAgSWYgdm5pY19ycV9kaXNhYmxl
KCkgc3VjY2VlZHMsIGVuaWNfb3BlbigpIHdpbGwNCj4gd3JvbmdseSByZXR1cm4gMC4gIElmIHZu
aWNfcnFfZGlzYWJsZSgpIGZhaWxzLCBJIHN0aWxsIGRvbid0IHRoaW5rIGl0DQo+IG1ha2VzIHNl
bnNlIHRvIHNraXAgdGhlIHJlbWFpbmluZyBjbGVhbnVwIGFjdGlucy4NCg0KR29vZCBjYXRjaC4g
Rml4aW5nIGl0Lg==
