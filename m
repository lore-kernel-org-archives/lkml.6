Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B879C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BCC218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfBKRQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:16:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:64544 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfBKRQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:16:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 09:16:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="123625697"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga008.fm.intel.com with ESMTP; 11 Feb 2019 09:16:09 -0800
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 09:16:09 -0800
Received: from crsmsx151.amr.corp.intel.com (172.18.7.86) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 09:16:08 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.57]) by
 CRSMSX151.amr.corp.intel.com ([169.254.3.79]) with mapi id 14.03.0415.000;
 Mon, 11 Feb 2019 11:16:07 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Topel, Bjorn" <bjorn.topel@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Netdev <netdev@vger.kernel.org>, Davidlohr Bueso <dbueso@suse.de>
Subject: RE: [PATCH 1/2] xsk: do not use mmap_sem
Thread-Topic: [PATCH 1/2] xsk: do not use mmap_sem
Thread-Index: AQHUwh8y/Z/k25QyB0Oc2wm5pV76vqXbMI2A//+lm9A=
Date:   Mon, 11 Feb 2019 17:16:06 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79BCB3B9@CRSMSX101.amr.corp.intel.com>
References: <20190207053740.26915-1-dave@stgolabs.net>
 <20190207053740.26915-2-dave@stgolabs.net>
 <CAJ+HfNg=Wikc_uY9W1QiVCONq3c1GyS44-xbrq-J4gqfth2kwQ@mail.gmail.com>
 <d92b7b49-81e6-1ac5-4ae4-4909f87bbea8@iogearbox.net>
 <CAPcyv4gjUmRdV1jZegLecocj155m7dpQLxQSnF_HQQErD8Gtag@mail.gmail.com>
In-Reply-To: <CAPcyv4gjUmRdV1jZegLecocj155m7dpQLxQSnF_HQQErD8Gtag@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWY2Y2EwYjQtYTAxYi00Zjg0LWE5NmEtOTFkNDdlMjg4YjM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiak5rNERqakdyUE1oXC81Sm91RUFha0ZSRjBFXC85dE0ybEM1TFVaRUljUVRYdXp2dzRVTndJSW9UcUkzTXNBNkZOIn0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4+IC0tLQ0KPiA+ID4+ICBuZXQveGRwL3hkcF91bWVtLmMgfCA2ICsrLS0tLQ0KPiA+ID4+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+ID4+
DQo+ID4gPj4gZGlmZiAtLWdpdCBhL25ldC94ZHAveGRwX3VtZW0uYyBiL25ldC94ZHAveGRwX3Vt
ZW0uYyBpbmRleA0KPiA+ID4+IDVhYjIzNmM1YzlhNS4uMjVlMWU3NjY1NGE4IDEwMDY0NA0KPiA+
ID4+IC0tLSBhL25ldC94ZHAveGRwX3VtZW0uYw0KPiA+ID4+ICsrKyBiL25ldC94ZHAveGRwX3Vt
ZW0uYw0KPiA+ID4+IEBAIC0yNjUsMTAgKzI2NSw4IEBAIHN0YXRpYyBpbnQgeGRwX3VtZW1fcGlu
X3BhZ2VzKHN0cnVjdA0KPiB4ZHBfdW1lbSAqdW1lbSkNCj4gPiA+PiAgICAgICAgIGlmICghdW1l
bS0+cGdzKQ0KPiA+ID4+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiA+Pg0K
PiA+ID4+IC0gICAgICAgZG93bl93cml0ZSgmY3VycmVudC0+bW0tPm1tYXBfc2VtKTsNCj4gPiA+
PiAtICAgICAgIG5wZ3MgPSBnZXRfdXNlcl9wYWdlcyh1bWVtLT5hZGRyZXNzLCB1bWVtLT5ucGdz
LA0KPiA+ID4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGd1cF9mbGFncywgJnVtZW0t
PnBnc1swXSwgTlVMTCk7DQo+ID4gPj4gLSAgICAgICB1cF93cml0ZSgmY3VycmVudC0+bW0tPm1t
YXBfc2VtKTsNCj4gPiA+PiArICAgICAgIG5wZ3MgPSBnZXRfdXNlcl9wYWdlc19mYXN0KHVtZW0t
PmFkZHJlc3MsIHVtZW0tPm5wZ3MsDQo+ID4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBndXBfZmxhZ3MsICZ1bWVtLT5wZ3NbMF0pOw0KPiA+ID4+DQo+ID4gPg0KPiA+ID4g
VGhhbmtzIGZvciB0aGUgcGF0Y2ghDQo+ID4gPg0KPiA+ID4gVGhlIGxpZmV0aW1lIG9mIHRoZSBw
aW5uaW5nIGlzIHNpbWlsYXIgdG8gUkRNQSB1bWVtIG1hcHBpbmcsIHNvDQo+ID4gPiBpc24ndCBn
dXBfbG9uZ3Rlcm0gcHJlZmVycmVkPw0KPiA+DQo+ID4gU2VlbXMgcmVhc29uYWJsZSBmcm9tIHJl
YWRpbmcgd2hhdCBndXBfbG9uZ3Rlcm0gc2VlbXMgdG8gZG8uIERhdmlkbG9ocg0KPiA+IG9yIERh
biwgYW55IHRob3VnaHRzIG9uIHRoZSBhYm92ZT8NCj4gDQo+IFllcywgYW55IGd1cCB3aGVyZSB0
aGUgbGlmZXRpbWUgb2YgdGhlIGNvcnJlc3BvbmRpbmcgcHV0X3BhZ2UoKSBpcyB1bmRlcg0KPiBk
aXJlY3QgY29udHJvbCBvZiB1c2Vyc3BhY2Ugc2hvdWxkIGJlIHVzaW5nIHRoZSBfbG9uZ3Rlcm0g
Zmxhdm9yIHRvDQo+IGNvb3JkaW5hdGUgYmUgY2FyZWZ1bCBpbiB0aGUgcHJlc2VuY2Ugb2YgZGF4
LiBJbiB0aGUgZGF4IGNhc2UgdGhlcmUgaXMgbm8gcGFnZQ0KPiBjYWNoZSBpbmRpcmVjdGlvbiB0
byBjb29yZGluYXRlIHRydW5jYXRlIHZzIHBhZ2UgcGlucy4gSXJhIGlzIGxvb2tpbmcgdG8gYWRk
IGENCj4gImZhc3QgKyBsb25ndGVybSIgZmxhdm9yIGZvciBjYXNlcyBsaWtlIHRoaXMuDQoNClll
cyBJJ20ganVzdCBhYm91dCByZWFkeSB3aXRoIGEgc21hbGwgcGF0Y2ggc2V0IHRvIGFkZCBhIEdV
UCBmYXN0IGxvbmd0ZXJtLg0KDQpJIHRoaW5rIHRoaXMgc2hvdWxkIHdhaXQgZm9yIHRoYXQgc2Vy
aWVzLg0KDQpJcmENCiANCg==
