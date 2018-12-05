Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374612082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="YPzmf7ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374612082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeLEGhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:37:33 -0500
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:53162 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2284; q=dns/txt; s=iport;
  t=1543991853; x=1545201453;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0q3yJk6+Dg0kzx2TNIPNsM01isJwjE8OyjXAXbeV+yY=;
  b=YPzmf7tisSjgFUff7pDSICyLNpJ14aQiAEhMuo0ZxWI2NUxwjZ4a+ysf
   9pzxPzciAp0QGWUR0ifGxYUjqCjGJs5FgPq5c0gMWRj8EqhjO+YE1A+hh
   ViF6LqQoV2Pd9encoNkl5BSvTtG6XiTZKUC0vihMhCzJ/UIP+HE6TTmV8
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ADAADIbgdc/5tdJa1kGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAQGBUQQBAQEBAQsBggOBaCcKg2+IGY12JYkSjjqBegsBAYR?=
 =?us-ascii?q?sAheCdCI0CQ0BAwEBAgEBAm0ohT0BBSMEDUUQAgEIGAICJgICAh8RFRACBAE?=
 =?us-ascii?q?NBYMhgWoDFaUBfDOIAw2CHIELixMXgUA/gTgME4JMgleFLjGCJgKJKIdYhGe?=
 =?us-ascii?q?KOi4JAo4Rgy4YkSwsiF2FdIlVAhEUgScfOIFVcBVlAYJBgicXjh1BMYsPgR8?=
 =?us-ascii?q?BAQ?=
X-IronPort-AV: E=Sophos;i="5.56,317,1539648000"; 
   d="scan'208";a="489561175"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 06:28:03 +0000
Received: from XCH-ALN-011.cisco.com (xch-aln-011.cisco.com [173.36.7.21])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id wB56S3Rp006969
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 5 Dec 2018 06:28:03 GMT
Received: from xch-aln-003.cisco.com (173.36.7.13) by XCH-ALN-011.cisco.com
 (173.36.7.21) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 5 Dec
 2018 00:28:02 -0600
Received: from xch-aln-003.cisco.com ([173.36.7.13]) by XCH-ALN-003.cisco.com
 ([173.36.7.13]) with mapi id 15.00.1395.000; Wed, 5 Dec 2018 00:28:02 -0600
From:   "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Subject: Re: [PATCH] drivers/scsi/snic/snic_trc.c: Use vzalloc
Thread-Topic: [PATCH] drivers/scsi/snic/snic_trc.c: Use vzalloc
Thread-Index: AQHUfQEKypWm+S61x0KEZqQ1RPx37qVd3rwAgBIzIoD//5nxAA==
Date:   Wed, 5 Dec 2018 06:28:02 +0000
Message-ID: <B16AE34C-4395-434E-98AD-C5F7AB818C49@cisco.com>
References: <5beda000.1c69fb81.e6599.d3d8@mx.google.com>
 <CAJr6mf0rawk6rDRB7NzsTUXyqvt0U5J4SUnVYck2_-jh6D6MoQ@mail.gmail.com>
 <CAJr6mf2obk8MgPc3AO74EwsiXt66OZGni57Z8v3TgnePyACLmg@mail.gmail.com>
In-Reply-To: <CAJr6mf2obk8MgPc3AO74EwsiXt66OZGni57Z8v3TgnePyACLmg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/f.22.0.170515
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.34.134]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B51B4681C3481C4DB5F0D1E9B56628A5@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-SMTP-Client: 173.36.7.21, xch-aln-011.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TG9va3MgZ29vZCB0byBtZS4NCg0KQWNrZWQtYnk6ICAgU2VzaWRoYXIgQmFkZGVsYSAgICAgPHNl
YmFkZGVsQGNpc2NvLmNvbT4NCg0KT24gMTIvNC8xOCwgODozMyBQTSwgIlNhYnlhc2FjaGkgR3Vw
dGEiIDxzYWJ5YXNhY2hpLmxpbnV4QGdtYWlsLmNvbT4gd3JvdGU6DQoNCiAgICBPbiBGcmksIE5v
diAyMywgMjAxOCBhdCA4OjA3IFBNIFNhYnlhc2FjaGkgR3VwdGENCiAgICA8c2FieWFzYWNoaS5s
aW51eEBnbWFpbC5jb20+IHdyb3RlOg0KICAgID4NCiAgICA+IE9uIFRodSwgTm92IDE1LCAyMDE4
IGF0IDEwOjA0IFBNIFNhYnlhc2FjaGkgR3VwdGENCiAgICA+IDxzYWJ5YXNhY2hpLmxpbnV4QGdt
YWlsLmNvbT4gd3JvdGU6DQogICAgPiA+DQogICAgPiA+IFJlcGxhY2VkIHZtYWxsb2MgKyBtZW1z
ZXQgd2l0aCB2emFsbG9jDQogICAgPiA+DQogICAgPiA+IFNpZ25lZC1vZmYtYnk6IFNhYnlhc2Fj
aGkgR3VwdGEgPHNhYnlhc2FjaGkubGludXhAZ21haWwuY29tPg0KICAgID4NCiAgICA+IEFueSBj
b21tZW50IG9uIHRoaXMgcGF0Y2g/DQogICAgDQogICAgQW55IGNvbW1lbnQgb24gdGhpcyBwYXRj
aD8NCiAgICANCiAgICA+DQogICAgPiA+IC0tLQ0KICAgID4gPiAgZHJpdmVycy9zY3NpL3NuaWMv
c25pY190cmMuYyB8IDMgKy0tDQogICAgPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDIgZGVsZXRpb25zKC0pDQogICAgPiA+DQogICAgPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Njc2kvc25pYy9zbmljX3RyYy5jIGIvZHJpdmVycy9zY3NpL3NuaWMvc25pY190cmMuYw0KICAg
ID4gPiBpbmRleCBmYzYwYzkzLi40NThlYWJhIDEwMDY0NA0KICAgID4gPiAtLS0gYS9kcml2ZXJz
L3Njc2kvc25pYy9zbmljX3RyYy5jDQogICAgPiA+ICsrKyBiL2RyaXZlcnMvc2NzaS9zbmljL3Nu
aWNfdHJjLmMNCiAgICA+ID4gQEAgLTEyNiw3ICsxMjYsNyBAQCBzbmljX3RyY19pbml0KHZvaWQp
DQogICAgPiA+ICAgICAgICAgaW50IHRidWZfc3ogPSAwLCByZXQ7DQogICAgPiA+DQogICAgPiA+
ICAgICAgICAgdGJ1Zl9zeiA9IChzbmljX3RyYWNlX21heF9wYWdlcyAqIFBBR0VfU0laRSk7DQog
ICAgPiA+IC0gICAgICAgdGJ1ZiA9IHZtYWxsb2ModGJ1Zl9zeik7DQogICAgPiA+ICsgICAgICAg
dGJ1ZiA9IHZ6YWxsb2ModGJ1Zl9zeik7DQogICAgPiA+ICAgICAgICAgaWYgKCF0YnVmKSB7DQog
ICAgPiA+ICAgICAgICAgICAgICAgICBTTklDX0VSUigiRmFpbGVkIHRvIEFsbG9jYXRlIFRyYWNl
IEJ1ZmZlciBTaXplLiAlZFxuIiwgdGJ1Zl9zeik7DQogICAgPiA+ICAgICAgICAgICAgICAgICBT
TklDX0VSUigiVHJhY2UgRmFjaWxpdHkgbm90IGVuYWJsZWQuXG4iKTsNCiAgICA+ID4gQEAgLTEz
NSw3ICsxMzUsNiBAQCBzbmljX3RyY19pbml0KHZvaWQpDQogICAgPiA+ICAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KICAgID4gPiAgICAgICAgIH0NCiAgICA+ID4NCiAgICA+ID4gLSAgICAg
ICBtZW1zZXQodGJ1ZiwgMCwgdGJ1Zl9zeik7DQogICAgPiA+ICAgICAgICAgdHJjLT5idWYgPSAo
c3RydWN0IHNuaWNfdHJjX2RhdGEgKikgdGJ1ZjsNCiAgICA+ID4gICAgICAgICBzcGluX2xvY2tf
aW5pdCgmdHJjLT5sb2NrKTsNCiAgICA+ID4NCiAgICA+ID4gLS0NCiAgICA+ID4gMi43LjQNCiAg
ICA+ID4NCiAgICANCg0K
