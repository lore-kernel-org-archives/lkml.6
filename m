Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225C4C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3651213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3651213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeIMAJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:09:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:8504 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeIMAJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:09:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 12:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,365,1531810800"; 
   d="scan'208";a="91106015"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga002.jf.intel.com with ESMTP; 12 Sep 2018 12:03:32 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 12 Sep 2018 12:02:59 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.73]) with mapi id 14.03.0319.002;
 Wed, 12 Sep 2018 12:02:59 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Al Stone" <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH V6 2/2] x86/efi: Add efi page fault handler to recover
 from page faults caused by the firmware
Thread-Topic: [PATCH V6 2/2] x86/efi: Add efi page fault handler to recover
 from page faults caused by the firmware
Thread-Index: AQHUSgPvXGo5d0syW0SVkzae+FIc5KTtdeYAgAAAogD//4t7kA==
Date:   Wed, 12 Sep 2018 19:02:58 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485BB609@ORSMSX114.amr.corp.intel.com>
References: <1536693322-8335-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536693322-8335-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <alpine.DEB.2.21.1809122055190.1473@nanos.tec.linutronix.de>
 <CAKv+Gu9yDEfUFkTK0orYLjRfs+=WXwPvr44a2q0ALiWMNEpmDg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9yDEfUFkTK0orYLjRfs+=WXwPvr44a2q0ALiWMNEpmDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWFkNzA1M2MtNjhkOC00MmI2LTgyZGEtYmNhMzU3Y2RmZTEzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoickIwZmZIVGFzdmwxcFlRMmRcL095Zjk1elpoV0I4ckp6WkpveWNUblRjSkwzMXVSQTJFc1F6Y2JUWGs4MmF0S3oifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMiBTZXB0ZW1iZXIgMjAxOCBhdCAyMDo1NiwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMTEgU2VwIDIwMTgsIFNhaSBQcmFuZWV0
aCBQcmFraHlhIHdyb3RlOg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9lZmkv
cnVudGltZS13cmFwcGVycy5jDQo+IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvcnVudGltZS13cmFw
cGVycy5jDQo+ID4+IGluZGV4IGIxOGIyZDg2NGMyYy4uNzQ1NTI3N2EzYjY1IDEwMDY0NA0KPiA+
PiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9ydW50aW1lLXdyYXBwZXJzLmMNCj4gPj4gKysr
IGIvZHJpdmVycy9maXJtd2FyZS9lZmkvcnVudGltZS13cmFwcGVycy5jDQo+ID4+IEBAIC02MSw2
ICs2MSwxMSBAQCBzdHJ1Y3QgZWZpX3J1bnRpbWVfd29yayBlZmlfcnRzX3dvcms7DQo+ID4+ICAo
eyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBcDQo+ID4+ICAgICAgIGVmaV9ydHNfd29yay5zdGF0dXMgPSBFRklfQUJPUlRF
RDsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+
ID4+ICsgICAgIGlmICghZWZpX2VuYWJsZWQoRUZJX1JVTlRJTUVfU0VSVklDRVMpKSB7ICAgICAg
ICAgICAgICAgICAgICAgICBcDQo+ID4+ICsgICAgICAgICAgICAgcHJfaW5mbygiQWJvcnRpbmch
IEVGSSBSdW50aW1lIFNlcnZpY2VzIGRpc2FibGVkXG4iKTsgICBcDQo+ID4NCj4gPiBUaGlzIHBy
b2JhYnkgd2FudHMgdG8gYmUgcHJfaW5mb19pbmNlKCkuDQo+ID4NCg0KWWVzLi4gdGhhdCBtYWtl
cyBzZW5zZS4NCg0KPiANCj4gSSBjYW4gZml4IHRoYXQgdXAgd2hlbiBhcHBseWluZy4NCj4NCg0K
VGhhbmtzIGEgbG90ISBBcmQuDQogDQo+ID4gT3RoZXIgdGhhbiB0aGF0Og0KPiA+DQo+ID4gICAg
ICAgUmV2aWV3ZWQtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiAN
Cj4gVGhhbmtzISBJIHdpbGwgcXVldWUgdGhpcyB1cCBpbiBlZmkvbmV4dA0K
