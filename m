Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FEFC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3421F20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3421F20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbeJWB4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:56:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:30599 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbeJWB4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:56:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2018 10:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,413,1534834800"; 
   d="scan'208";a="80026941"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2018 10:36:49 -0700
Received: from orsmsx158.amr.corp.intel.com (10.22.240.20) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 22 Oct 2018 10:36:49 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.194]) by
 ORSMSX158.amr.corp.intel.com ([169.254.10.68]) with mapi id 14.03.0319.002;
 Mon, 22 Oct 2018 10:36:48 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: RE: [PATCH 1/2] x86/efi: Unmap efi boot services code/data regions
 from efi_pgd
Thread-Topic: [PATCH 1/2] x86/efi: Unmap efi boot services code/data regions
 from efi_pgd
Thread-Index: AQHUaae1+/df8a0vpkCawzkqjxdfr6Uq90AAgADNTID//8OP8A==
Date:   Mon, 22 Oct 2018 17:36:48 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485D5D95@ORSMSX114.amr.corp.intel.com>
References: <1540172145-17134-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1540172145-17134-2-git-send-email-sai.praneeth.prakhya@intel.com>
 <20181022015738.GB24095@gmail.com>
 <f88841ec-e104-fa8b-0be6-7418c7bf5161@intel.com>
In-Reply-To: <f88841ec-e104-fa8b-0be6-7418c7bf5161@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2JkYzY2ZjgtNjJmYi00NjVmLThiMDUtYmMxY2ViMDFiNTgyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYjJxSXAzWnR4MVdZZSs0OUtVTit5c3ZGQWhlQmQ3MzlwcU1aaEVFSUljQ3poK0pubzhwMkhuZVdqSkVmSVNnUCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMC8yMS8yMDE4IDA2OjU3IFBNLCBJbmdvIE1vbG5hciB3cm90ZToNCj4gPiBEb2VzIHRo
ZSBDUFUgX2V2ZXJfIGxvb2sgbG9vayBhdCB0aGUgUEZOIGlmIHRoZSBwYWdlIGlzDQo+ID4gIV9Q
QUdFX1BSRVNFTlQsIGZvciBleGFtcGxlIHNwZWN1bGF0aXZlbHk/IElmIHllcyB0aGVuIHdoYXQg
aXMgdGhlDQo+ID4gcmVjb21tZW5kZWQgdmFsdWUgZm9yIHRoZSBwZm4gLSB6ZXJvIHBlcmhhcHM/
DQo+IA0KPiBJJ2xsIG5ldmVyIHNheSBuZXZlci4gOikNCj4gDQo+IEZvciBMMVRGWzFdLCB3ZSBr
bm93IHRoZSBDUFUgZGlkIGV4YWN0bHkgdGhpczsgaXQgaWdub3JlZCB0aGUgX1BBR0VfUFJFU0VO
VA0KPiBiaXQgd2hlbiBmZXRjaGluZyBkYXRhIGZyb20gdGhlIEwxLiAgVGhhdCdzIHdoYXQgaXMg
d29ya2VkIGFyb3VuZCB3aXRoIHRoZSBndW5rDQo+IGluIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Bn
dGFibGUtaW52ZXJ0LmguDQo+IA0KPiBJIHRoaW5rIEFuZGkgcGx1Z2dlZCB0aGUgY29kZSBpbiBo
ZXJlIGF0IGEgbG93IGVub3VnaCBsZXZlbCBpbiB0aGUgcGFnZSB0YWJsZQ0KPiBtYW5pcHVsYXRp
b24gdGhhdCBwYWdlYXR0ci5jIHNob3VsZCBpbmhlcml0IGl0IHdpdGhvdXQgZG9pbmcgYW55dGhp
bmcgZXhwbGljaXQuDQo+IEJ1dCwgU2FpLCB5b3UgbWlnaHQgd2FudCB0byBkb3VibGUtY2hlY2sg
dGhpcy4NCj4gDQo+IDEuDQo+IGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3dy91cy9l
bi9hcmNoaXRlY3R1cmUtYW5kLQ0KPiB0ZWNobm9sb2d5L2wxdGYuaHRtbA0KDQpTdXJlISBEYXZl
LiBUaGFua3MgZm9yIHRoZSBsaW5rLiBJIHdpbGwgdGFrZSBhIGxvb2sgYXQgaXQuDQoNClJlZ2Fy
ZHMsDQpTYWkNCg==
