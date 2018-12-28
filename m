Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5CDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CE420665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 21:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeL1V16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:27:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:44579 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeL1V15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 16:27:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 13:27:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,411,1539673200"; 
   d="scan'208";a="113960284"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga003.jf.intel.com with ESMTP; 28 Dec 2018 13:27:56 -0800
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 28 Dec 2018 13:27:56 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.59]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.172]) with mapi id 14.03.0415.000;
 Fri, 28 Dec 2018 13:27:55 -0800
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH] x86/efi: Don't unmap EFI boot services code/data
 regions for EFI_OLD_MEMMAP and EFI_MIXED_MODE
Thread-Topic: [PATCH] x86/efi: Don't unmap EFI boot services code/data
 regions for EFI_OLD_MEMMAP and EFI_MIXED_MODE
Thread-Index: AQHUmZ2DcDK9KhIqLEy5y3yuvYSshKWLHDcAgAAC+YCAAwydAIAGh5Yw
Date:   Fri, 28 Dec 2018 21:27:55 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F48608DD1@ORSMSX114.amr.corp.intel.com>
References: <20181222022234.7573-1-sai.praneeth.prakhya@intel.com>
 <20181222105410.GA130780@gmail.com>
 <CAKv+Gu93dgfXsq_sRzvXBw-h=8pn2BtrQLtpwtjK51potpOtdg@mail.gmail.com>
 <CAKv+Gu8_9zMKhNyL=R7ZJHU=cFCkASVEOrm_4kqmTQG+7wPFbw@mail.gmail.com>
In-Reply-To: <CAKv+Gu8_9zMKhNyL=R7ZJHU=cFCkASVEOrm_4kqmTQG+7wPFbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzEyNzkzYTItMTVmYS00MGY3LTg4MGEtZjQwMjkzNGI5MDVmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieFMxRXpkMXVSM1lXbWtGNklwMFloc2h0cWh2OGFGXC9XT1VOUjJPUEc3ZzZJajFsSmo1ZEFCVFwvZXY1QnJGVVVFIn0=
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

PiA+IEFja2VkLWJ5OiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJvLm9yZz4N
Cj4gPg0KPiA+IHdpdGggdGhlIHNpZGVub3RlIHRoYXQgSSB3b24ndCBiZSBhYmxlIHRvIHRlc3Qg
dGhpcyBteXNlbGYgdW50aWwNCj4gPiBtb25kYXkgYXQgdGhlIGVhcmxpZXN0Lg0KPiANCj4gT0ss
IHNvIEkgaGF2ZSB0ZXN0ZWQgYm90aCBlZmk9b2xkX21hcCBhbmQgbWl4ZWQgbW9kZSBiZWZvcmUg
YW5kIGFmdGVyDQo+IGFwcGx5aW5nIHRoaXMgcGF0Y2gsIHVzaW5nIFFFTVUvS1ZNIHdpdGggNjQt
Yml0IGFuZCAzMi1iaXQgYnVpbGRzIG9mIE9WTUYNCj4gW3Jlc3BlY3RpdmVseV0NCj4gDQo+IGVm
aT1vbGRfbWFwIGlzIGluZGVlZCBicm9rZW4gYmVmb3JlIGFuZCBuZWVkcyB0aGlzIHBhdGNoLg0K
PiANCj4gTWl4ZWQgbW9kZSB3b3JrcyBqdXN0IGZpbmUgYm90aCBiZWZvcmUgYW5kIGFmdGVyIGFw
cGx5aW5nIHRoZSBwYXRjaCwgYnV0IEkNCj4gc3VnZ2VzdCB3ZSBrZWVwIHRoaXMgcGF0Y2ggYXMt
aXMgYW5kIGFkZHJlc3MgbWl4ZWQgbW9kZSBsYXRlciBpZiBuZWVkZWQgKEkNCj4gc3BvdHRlZCBh
IGNvdXBsZSBvZiB0aGluZ3MgaW4gdGhlIGJvb3QgbG9nIHRoYXQgbWF5IG5lZWQgc29tZSBhdHRl
bnRpb24gYnV0IEknbQ0KPiBub3Qgc3VyZSBpZiB0aGUgaXNzdWUgaXMgaW4gTGludXggb3IgaW4g
T1ZNRikNCg0KVGhhbmtzIGZvciB0ZXN0aW5nIHRoaXMgQXJkLg0KDQpGb3IgdGVzdGluZyBNaXhl
ZCBtb2RlLCBJIGhhdmUgdXNlZCBRRU1VL0tWTSB3aXRoIDY0LWJpdCBhbmQgMzItYml0IE9WTUYg
DQphbmQgbWl4ZWQgbW9kZSBpcyBicm9rZW4gZm9yIG1lIHdpdGhvdXQgdGhpcyBwYXRjaC4NCg0K
SSBhbSB1c2luZyBhbiBvbGRlciBPVk1GIGJ1aWxkIGFuZCBwcm9iYWJseSB0aGF0IG1pZ2h0IGJl
IHRoZSByZWFzb24gZm9yIHVzIHNlZWluZyANCmRpZmZlcmVudCBiZWhhdmlvcnMuIEFsc28sIGtl
cm5lbCBjb25maWcgZmlsZSBtaWdodCBoYXZlIHNvbWUgcm9sZSB0byBwbGF5Li4gSSBndWVzcy4N
Cg0KUmVnYXJkcywNClNhaQ0K
