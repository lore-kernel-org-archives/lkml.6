Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E196C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB7920891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 01:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB7920891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756535AbeFPBTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 21:19:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:21307 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753749AbeFPBTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 21:19:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 18:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,228,1526367600"; 
   d="scan'208";a="208516365"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 15 Jun 2018 18:19:39 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 15 Jun 2018 18:19:38 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 15 Jun 2018 18:19:38 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.223]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.87]) with mapi id 14.03.0319.002;
 Sat, 16 Jun 2018 09:19:37 +0800
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>,
        "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>,
        "quan.xu0@gmail.com" <quan.xu0@gmail.com>,
        "nilal@redhat.com" <nilal@redhat.com>,
        Rik van Riel <riel@redhat.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: RE: [PATCH v33 1/4] mm: add a function to get free page blocks
Thread-Topic: [PATCH v33 1/4] mm: add a function to get free page blocks
Thread-Index: AQHUBGbzlrVfblBI3Uy7QJ/rUPSUs6RhbL2AgACn7bA=
Date:   Sat, 16 Jun 2018 01:19:36 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396A5CDB@shsmsx102.ccr.corp.intel.com>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <1529037793-35521-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
In-Reply-To: <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2ZmYTZlNzQtZTVlNC00YTU3LWJiYTYtYjBlYmQ2NWQ2MWRjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTTVoSDdUb0lOWGYxa1A1U1lWM0dXM1NMaUtyVXcwSlFXNU85dHh0UTl1ZTNLbnQzVjdHWUpQSXNjRDUxK2xadiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0dXJkYXksIEp1bmUgMTYsIDIwMTggNzowOSBBTSwgTGludXMgVG9ydmFsZHMgd3JvdGU6
DQo+IE9uIEZyaSwgSnVuIDE1LCAyMDE4IGF0IDI6MDggUE0gV2VpIFdhbmcgPHdlaS53LndhbmdA
aW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBhIGZ1bmN0aW9uIHRv
IGdldCBmcmVlIHBhZ2VzIGJsb2NrcyBmcm9tIGEgZnJlZSBwYWdlDQo+ID4gbGlzdC4gVGhlIG9i
dGFpbmVkIGZyZWUgcGFnZSBibG9ja3MgYXJlIGhpbnRzIGFib3V0IGZyZWUgcGFnZXMsDQo+ID4g
YmVjYXVzZSB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdCB0aGV5IGFyZSBzdGlsbCBvbiB0aGUg
ZnJlZSBwYWdlDQo+ID4gbGlzdCBhZnRlciB0aGUgZnVuY3Rpb24gcmV0dXJucy4NCj4gDQo+IEFj
ay4gVGhpcyBpcyB0aGUga2luZCBvZiBzaW1wbGUgaW50ZXJmYWNlIHdoZXJlIEkgZG9uJ3QgbmVl
ZCB0byB3b3JyeSBhYm91dA0KPiB0aGUgTU0gY29kZSBjYWxsaW5nIG91dCB0byByYW5kb20gZHJp
dmVycyBvciBzdWJzeXN0ZW1zLg0KPiANCj4gSSB0aGluayB0aGF0ICJvcmRlciIgc2hvdWxkIGJl
IGNoZWNrZWQgZm9yIHZhbGlkaXR5LCBidXQgZnJvbSBhIE1NIHN0YW5kcG9pbnQNCj4gSSB0aGlu
ayB0aGlzIGlzIGZpbmUuDQo+IA0KDQpUaGFua3MsIHdpbGwgYWRkIGEgdmFsaWRpdHkgY2hlY2sg
Zm9yICJvcmRlciIuDQoNCkJlc3QsDQpXZWkNCg==
