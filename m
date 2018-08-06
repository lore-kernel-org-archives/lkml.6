Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1715C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B156121A34
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 14:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B156121A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeHFQLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:11:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:55847 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeHFQLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:11:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 07:02:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="77896023"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2018 07:02:09 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 6 Aug 2018 07:02:09 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 6 Aug 2018 07:02:09 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.81]) with mapi id 14.03.0319.002;
 Mon, 6 Aug 2018 22:02:06 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v3 2/2] virtio_balloon: replace oom notifier with
 shrinker
Thread-Topic: [PATCH v3 2/2] virtio_balloon: replace oom notifier with
 shrinker
Thread-Index: AQHUKwiIDee4cjzfrU+xxAdAaZxPKaStafKAgAUXbID//4McgIAAqoJw//+Hs4CAAIyV0A==
Date:   Mon, 6 Aug 2018 14:02:05 +0000
Message-ID: <286AC319A985734F985F78AFA26841F739722502@SHSMSX101.ccr.corp.intel.com>
References: <1533285146-25212-1-git-send-email-wei.w.wang@intel.com>
 <1533285146-25212-3-git-send-email-wei.w.wang@intel.com>
 <16c56ee5-eef7-dd5f-f2b6-e3c11df2765c@i-love.sakura.ne.jp>
 <5B681B41.6070205@intel.com>
 <c8d25019-1990-f0dd-c83d-e4def5b5f7fe@i-love.sakura.ne.jp>
 <286AC319A985734F985F78AFA26841F7397222E8@SHSMSX101.ccr.corp.intel.com>
 <109ff5ec-692d-67fe-4c5a-2de8b48e8300@i-love.sakura.ne.jp>
In-Reply-To: <109ff5ec-692d-67fe-4c5a-2de8b48e8300@i-love.sakura.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2I1M2Y1ODEtOThiYi00MGI4LWFkNTgtMTdlNTlhODAwMTQzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYjRXWVQxQ1RXbWM3TXhEZnl2U0FROG52SDJcL2FlYWhcL05BbThWZUtvN25IeDI2VXROMnl6WERCaXR3UTdQYzV4In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uZGF5LCBBdWd1c3QgNiwgMjAxOCA5OjI5IFBNLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+
IE9uIDIwMTgvMDgvMDYgMjE6NDQsIFdhbmcsIFdlaSBXIHdyb3RlOg0KPiA+IE9uIE1vbmRheSwg
QXVndXN0IDYsIDIwMTggNjoyOSBQTSwgVGV0c3VvIEhhbmRhIHdyb3RlOg0KPiA+PiBPbiAyMDE4
LzA4LzA2IDE4OjU2LCBXZWkgV2FuZyB3cm90ZToNCj4gPj4+IE9uIDA4LzAzLzIwMTggMDg6MTEg
UE0sIFRldHN1byBIYW5kYSB3cm90ZToNCj4gPj4+PiBPbiAyMDE4LzA4LzAzIDE3OjMyLCBXZWkg
V2FuZyB3cm90ZToNCj4gPj4+Pj4gK3N0YXRpYyBpbnQgdmlydGlvX2JhbGxvb25fcmVnaXN0ZXJf
c2hyaW5rZXIoc3RydWN0IHZpcnRpb19iYWxsb29uDQo+ID4+Pj4+ICsqdmIpIHsNCj4gPj4+Pj4g
K8KgwqDCoCB2Yi0+c2hyaW5rZXIuc2Nhbl9vYmplY3RzID0gdmlydGlvX2JhbGxvb25fc2hyaW5r
ZXJfc2NhbjsNCj4gPj4+Pj4gK8KgwqDCoCB2Yi0+c2hyaW5rZXIuY291bnRfb2JqZWN0cyA9IHZp
cnRpb19iYWxsb29uX3Nocmlua2VyX2NvdW50Ow0KPiA+Pj4+PiArwqDCoMKgIHZiLT5zaHJpbmtl
ci5iYXRjaCA9IDA7DQo+ID4+Pj4+ICvCoMKgwqAgdmItPnNocmlua2VyLnNlZWtzID0gREVGQVVM
VF9TRUVLUzsNCj4gPj4+PiBXaHkgZmxhZ3MgZmllbGQgaXMgbm90IHNldD8gSWYgdmIgaXMgYWxs
b2NhdGVkIGJ5DQo+ID4+Pj4ga21hbGxvYyhHRlBfS0VSTkVMKSBhbmQgaXMgbm93aGVyZSB6ZXJv
LWNsZWFyZWQsIEtBU0FOIHdvdWxkDQo+IGNvbXBsYWluIGl0Lg0KPiA+Pj4NCj4gPj4+IENvdWxk
IHlvdSBwb2ludCB3aGVyZSBpbiB0aGUgY29kZSB0aGF0IHdvdWxkIGNvbXBsYWluIGl0Pw0KPiA+
Pj4gSSBvbmx5IHNlZSB0d28gc2hyaW5rZXIgZmxhZ3MgKE5VTUFfQVdBUkUgYW5kIE1FTUNHX0FX
QVJFKSwgYW5kDQo+ID4+IHRoZXkgc2VlbSBub3QgcmVsYXRlZCB0byB0aGF0Lg0KPiA+Pg0KPiA+
PiBXaGVyZSBpcyB2Yi0+c2hyaW5rZXIuZmxhZ3MgaW5pdGlhbGl6ZWQ/DQo+ID4NCj4gPiBJcyB0
aGF0IG1hbmRhdG9yeSB0byBiZSBpbml0aWFsaXplZD8NCj4gDQo+IE9mIGNvdXJzZS4gOy0pDQo+
IA0KPiA+IEkgZmluZCBpdCdzIG5vdCBpbml0aWFsaXplZCBpbiBtb3N0IHNocmlua2VycyAoZS5n
LiB6c19yZWdpc3Rlcl9zaHJpbmtlciwNCj4gaHVnZV96ZXJvX3BhZ2Vfc2hyaW5rZXIpLg0KPiAN
Cj4gQmVjYXVzZSBtb3N0IHNocmlua2VycyBhcmUgInN0YXRpY2FsbHkgaW5pdGlhbGl6ZWQgKHdo
aWNoIG1lYW5zIHRoYXQNCj4gdW5zcGVjaWZpZWQgZmllbGRzIGFyZSBpbXBsaWNpdGx5IHplcm8t
Y2xlYXJlZCkiIG9yICJkeW5hbWljYWxseSBhbGxvY2F0ZWQgd2l0aA0KPiBfX0dGUF9aRVJPIG9y
IHplcm8tY2xlYXJlZCB1c2luZw0KPiBtZW1zZXQoKSAod2hpY2ggbWVhbnMgdGhhdCBhbGwgZmll
bGRzIGFyZSBvbmNlIHplcm8tY2xlYXJlZCkiLg0KPiANCj4gQW5kIGlmIHlvdSBvbmNlIHplcm8t
Y2xlYXIgdmIgYXQgYWxsb2NhdGlvbiB0aW1lLCB5b3Ugd2lsbCBnZXQgYSBib251cyB0aGF0DQo+
IGNhbGxpbmcgdW5yZWdpc3Rlcl9zaHJpbmtlcigpIHdpdGhvdXQgY29ycmVzcG9uZGluZyByZWdp
c3Rlcl9zaHJpbmtlcigpIGlzIHNhZmUNCj4gKHdoaWNoIHdpbGwgc2ltcGxpZnkgaW5pdGlhbGl6
YXRpb24gZmFpbHVyZSBwYXRoKS4NCg0KT2gsIEkgc2VlLCB0aGFua3MuIFNvIGl0IHNvdW5kcyBi
ZXR0ZXIgdG8gZGlyZWN0bHkga3phbGxvYyB2Yi4NCg0KQmVzdCwNCldlaQ0K
