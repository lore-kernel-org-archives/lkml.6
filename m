Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3C7C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06696240FE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06696240FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753961AbeGESah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:30:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:15943 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753769AbeGESaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:30:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 11:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,313,1526367600"; 
   d="scan'208";a="238124104"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga005.jf.intel.com with ESMTP; 05 Jul 2018 11:30:34 -0700
Received: from orsmsx111.amr.corp.intel.com ([169.254.12.50]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.132]) with mapi id 14.03.0319.002;
 Thu, 5 Jul 2018 11:30:34 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Dave Young <dyoung@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Laszlo Ersek <lersek@redhat.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Nicolai Stange <nicstange@gmail.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCH 1/6] efi: Introduce efi_memmap_free() to free memory
 allocated by efi_memmap_alloc()
Thread-Topic: [PATCH 1/6] efi: Introduce efi_memmap_free() to free memory
 allocated by efi_memmap_alloc()
Thread-Index: AQHUEnBaZNAup0NsRUapVIXngFKxWqSA1eOAgAAg5CA=
Date:   Thu, 5 Jul 2018 18:30:33 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F4659B195@ORSMSX111.amr.corp.intel.com>
References: <1530582654-25662-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1530582654-25662-2-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu8FjCojLTckLVcOq1z4e=pp4U8GQWVHpvHTewRgef6HDg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8FjCojLTckLVcOq1z4e=pp4U8GQWVHpvHTewRgef6HDg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTRjNGMwNmUtOGVmOC00NzYyLWEyOWItZmQ0MDE4NzhiMDkxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRmF5Q3U5eWl6TTA2KzFMUXpPcmFUaFQyd0tKNkdDSFpvVVAwMWo0SnJNMjY2SW1hTXJWWGhPQXlOYUYxcXU1RSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFNpZ25lZC1vZmYtYnk6IFNhaSBQcmFuZWV0aCBQcmFraHlhIDxzYWkucHJhbmVldGgucHJh
a2h5YUBpbnRlbC5jb20+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkLmJp
ZXNoZXV2ZWxAbGluYXJvLm9yZz4NCj4gPiBDYzogTGVlIENodW4tWWkgPGpsZWVAc3VzZS5jb20+
DQo+ID4gQ2M6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPg0KPiA+IENjOiBCb3Jpc2xh
diBQZXRrb3YgPGJwQGFsaWVuOC5kZT4NCj4gPiBDYzogTGFzemxvIEVyc2VrIDxsZXJzZWtAcmVk
aGF0LmNvbT4NCj4gPiBDYzogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4g
PiBDYzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4NCj4gPiBDYzogQmh1cGVz
aCBTaGFybWEgPGJoc2hhcm1hQHJlZGhhdC5jb20+DQo+ID4gQ2M6IE5pY29sYWkgU3RhbmdlIDxu
aWNzdGFuZ2VAZ21haWwuY29tPg0KPiA+IENjOiBOYXJlc2ggQmhhdCA8bmFyZXNoLmJoYXRAbGlu
YXJvLm9yZz4NCj4gPiBDYzogUmljYXJkbyBOZXJpIDxyaWNhcmRvLm5lcmlAaW50ZWwuY29tPg0K
PiA+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQo+ID4gQ2M6IFRh
a3UgSXp1bWkgPGl6dW1pLnRha3VAanAuZnVqaXRzdS5jb20+DQo+ID4gQ2M6IFJhdmkgU2hhbmth
ciA8cmF2aS52LnNoYW5rYXJAaW50ZWwuY29tPg0KPiA+IENjOiBNYXR0IEZsZW1pbmcgPG1hdHRA
Y29kZWJsdWVwcmludC5jby51az4NCj4gPiBDYzogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFt
c0BpbnRlbC5jb20+DQo+ID4gQ2M6IEFyZCBCaWVzaGV1dmVsIDxhcmQuYmllc2hldXZlbEBsaW5h
cm8ub3JnPg0KPiANCj4gRG8geW91IHJlYWxseSB0aGluayB5b3Ugc2hvdWxkIGNjIGFsbCB0aGVz
ZSBwZW9wbGU/DQo+IA0KDQpTb3JyeSEgSSBnZXQgdGhhdC4uDQoNCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9maXJtd2FyZS9lZmkvbWVtbWFwLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIGluY2x1ZGUvbGludXgvZWZpLmggICAgICAgICAgIHwgIDggKysrKysrKysNCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspDQo+ID4NCg0KW3NuaXBdDQoNCj4g
SSBhbSBub3cgdGhpbmtpbmcgd2Ugc2hvdWxkIHBlcmhhcHMgaGlkZSB0aGUgYWxsb2NhdGlvbiB0
eXBlIGZyb20gdGhlIGNhbGxlcnMNCj4gcmF0aGVyIHRoYW4gcGFzc2luZyBhcm91bmQgaW1wbGVt
ZW50YXRpb24gZGV0YWlscyBvZiB0aGUgYWxsb2NhdG9yLCBhbmQgaGF2ZQ0KPiBleHBsaWNpdCBh
bGxvYy9mcmVlIG9wZXJhdGlvbnMuDQo+IA0KPiBDb3VsZCB3ZSBpbnN0ZWFkIGhhdmUgYSBzaW5n
bGUgJ2VmaV9yZWFsbG9jX21lbW1hcCgpJyBmdW5jdGlvbiB0aGF0IHRha2VzIGNhcmUNCj4gb2Yg
YWxsIG9mIHRoaXM/DQoNClN1cmUhIEkgd2lsbCBnaXZlIGl0IGEgdHJ5Lg0KDQpSZWdhcmRzLA0K
U2FpDQo=
