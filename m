Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F283C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84D120827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84D120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeJ3TGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:06:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:23453 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeJ3TGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:06:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 03:13:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="85614121"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2018 03:13:23 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 03:13:23 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.102]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.214]) with mapi id 14.03.0415.000;
 Tue, 30 Oct 2018 18:13:21 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Jim Mattson <jmattson@google.com>, kvm list <kvm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Marc Orr <marcorr@google.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work
 mode
Thread-Topic: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work
 mode
Thread-Index: AQHUa3CrSmGUmyBSyUy4MzZKiwm0DqUuDVQAgAEJRcCAB/KrAIAABWGAgACGsuA=
Date:   Tue, 30 Oct 2018 10:13:21 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172BDB25D@SHSMSX101.ccr.corp.intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
 <1540368316-12998-7-git-send-email-luwei.kang@intel.com>
 <CALMp9eSNr_AedOLv+gcqayFQSpwxQnVdsJQSWG1qixwNUmQXzw@mail.gmail.com>
 <82D7661F83C1A047AF7DC287873BF1E172BD64F1@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.21.1810301027480.5984@nanos.tec.linutronix.de>
 <ad7452a3-61d7-1276-e0a5-84e6696832a7@redhat.com>
In-Reply-To: <ad7452a3-61d7-1276-e0a5-84e6696832a7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTg5OTkzMDgtMjdkYy00ZjdiLWFkNjctMzY1NDJlNWQwYWU5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSFdHdUhuY25NbExBSndYZmpXYWZ5MjRKSzVZWThhamZjY0lzWmgrQ1pTUElJWmdPYnl1OTN0TzVaNnRqYmdTaSJ9
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

PiA+PiBUaGlzIHBhcnQgaXMgaW4gdGhlICIgSW50ZWzCriBBcmNoaXRlY3R1cmUgSW5zdHJ1Y3Rp
b24gU2V0IEV4dGVuc2lvbnMgYW5kIEZ1dHVyZSBGZWF0dXJlcyBQcm9ncmFtbWluZyBSZWZlcmVu
Y2UiDQo+ID4+IGh0dHBzOi8vc29mdHdhcmUuaW50ZWwuY29tL3NpdGVzL2RlZmF1bHQvZmlsZXMv
bWFuYWdlZC9jNS8xNS9hcmNoaXRlYw0KPiA+PiB0dXJlLWluc3RydWN0aW9uLXNldC1leHRlbnNp
b25zLXByb2dyYW1taW5nLXJlZmVyZW5jZS5wZGYNCj4gPj4NCj4gPiBZZXQgYW5vdGhlciBQREYg
d2hpY2ggd2lsbCBjaGFuZ2UgaXQncyBsb2NhdGlvbiBzb29uZXIgdGhhbiBsYXRlci4gQ2FuDQo+
ID4geW91IHBsZWFzZSBzdGljayB0aGF0IGludG8gdGhlIGtlcm5lbC5vcmcgYnVnemlsbGEgYW5k
IHJlZmVyZW5jZSB0aGUNCj4gPiBCWiBpbiB0aGUgY2hhbmdlIGxvZywgc28gd2UgaGF2ZSBzb21l
dGhpbmcgZm9yIHBvc3Rlcml0eT8NCj4gDQo+IEhvcGVmdWxseSBwb3N0ZXJpdHkgd2lsbCBiZSBh
YmxlIHRvIHJlYWQgaXQgaW4gdGhlIFNETS4gIEJ1dCBJIGFncmVlIGl0J3MgYSBnb29kIGlkZWEg
dG8gYWRkIGl0IGluIHRoZSBjb21taXQgbG9nLiAgTGV0J3MgYWxzbyB3YWl0IGZvciBBbGV4YW5k
ZXINCj4gdG8gY2xhcmlmeSB3aGF0IGhlIHRoaW5rcyBuZWVkcyB0byBiZSBkb25lLg0KDQpJIHdp
bGwgY3JlYXRlIGEgbmV3IGJ1ZyBmb3IgdGhpcyBmZWF0dXJlIGluIEJ1Z3ppbGxhLCBwbGVhc2Ug
aGVscCBjb25maXJtIGlmIGNhbiBsaWtlIHRoaXMgZmlyc3QgKGl0IG15IGZpcnN0IHRpbWUgdG8g
Y3JlYXRlIGJ1ZyBpbiBrZXJuZWwub3JnIDopICkNCg0KUHJvZHVjdDogVmlydHVhbGl6YXRpb24N
CkNvbXBvbmVudDogS1ZNDQpTZXZlcml0eTogbm9ybWFsICAgKG9wdGlvbjogaGlnaCwgbm9ybWFs
LCBsb3csIGVuaGFuY2VtZW50KQ0KSGFyZHdhcmU6IGkzODYNCktlcm5lbCBWZXJzaW9uOiAgNC4x
OQ0KU3VtbWFyeTogSW50ZWwgUHJvY2Vzc29yIFRyYWNlIGVuYWJsaW5nIGluIEtWTQ0KRGVzY3Jp
cHRpb246IA0KSW50ZWwgUHJvY2Vzc29yIFRyYWNlIChJbnRlbCBQVCkgaXMgYW4gZXh0ZW5zaW9u
IG9mIEludGVsIEFyY2hpdGVjdHVyZSB0aGF0IGNhcHR1cmVzIGluZm9ybWF0aW9uIGFib3V0IHNv
ZnR3YXJlIGV4ZWN1dGlvbiB1c2luZyBkZWRpY2F0ZWQgaGFyZHdhcmUgZmFjaWxpdGllcyB0aGF0
IGNhdXNlIG9ubHkgbWluaW1hbCBwZXJmb3JtYW5jZSBwZXJ0dXJiYXRpb24gdG8gdGhlIHNvZnR3
YXJlIGJlaW5nIHRyYWNlZC4gRGV0YWlscyBvbiB0aGUgSW50ZWwgUFQgaW5mcmFzdHJ1Y3R1cmUg
YW5kIHRyYWNlIGNhcGFiaWxpdGllcyBjYW4gYmUgZm91bmQgaW4gdGhlIEludGVsIDY0IGFuZCBJ
QS0zMiBBcmNoaXRlY3R1cmVzIFNvZnR3YXJlIERldmVsb3BlciAgICDigJlzIE1hbnVhbCwgVm9s
dW1lIDNDLg0KDQpUaGUgc3VpdGUgb2YgYXJjaGl0ZWN0dXJlIGNoYW5nZXMgc2VydmUgdG8gc2lt
cGxpZnkgdGhlIHByb2Nlc3Mgb2YgdmlydHVhbGl6aW5nIEludGVsIFBUIGZvciB1c2UgYnkgYSBn
dWVzdCBzb2Z0d2FyZS4gVGhlcmUgYXJlIHR3byBwcmltYXJ5IGVsZW1lbnRzIHRvIHRoaXMgbmV3
IGFyY2hpdGVjdHVyZSBzdXBwb3J0IGZvciBWTVggc3VwcG9ydCBpbXByb3ZlbWVudHMgbWFkZSBm
b3IgSW50ZWwgUFQuDQoxLiBBZGRpdGlvbiBvZiBhIG5ldyBndWVzdCBJQTMyX1JUSVRfQ1RMIHZh
bHVlIGZpZWxkIHRvIHRoZSBWTUNTLg0KICDigJQgVGhpcyBzZXJ2ZXMgdG8gc3BlZWQgYW5kIHNp
bXBsaWZ5IHRoZSBwcm9jZXNzIG9mIGRpc2FibGluZyB0cmFjZSBvbiBWTSBleGl0LCBhbmQgcmVz
dG9yaW5nIGl0IG9uIFZNIGVudHJ5Lg0KMi4gRW5hYmxpbmcgdXNlIG9mIEVQVCB0byByZWRpcmVj
dCBQVCBvdXRwdXQuDQogIOKAlCBUaGlzIGVuYWJsZXMgdGhlIFZNTSB0byBlbGVjdCB0byB2aXJ0
dWFsaXplIHRoZSBQVCBvdXRwdXQgYnVmZmVyIHVzaW5nIEVQVC4gSW4gdGhpcyBtb2RlLCB0aGUg
Q1BVIHdpbGwgdHJlYXQgUFQgb3V0cHV0IGFkZHJlc3NlcyBhcyBHdWVzdCBQaHlzaWNhbCBBZGRy
ZXNzZXMgKEdQQXMpIGFuZCB0cmFuc2xhdGUgdGhlbSB1c2luZyBFUFQuIFRoaXMgbWVhbnMgdGhh
dCBJbnRlbCBQVCBvdXRwdXQgcmVhZHMgKG9mIHRoZSBUb1BBIHRhYmxlKSBhbmQgd3JpdGVzIChv
ZiB0cmFjZSBvdXRwdXQpIGNhbiBjYXVzZSBFUFQgdmlvbGF0aW9ucywgYW5kIG90aGVyIG91dHB1
dCBldmVudHMuDQoNCkludGVsIFByb2Nlc3NvciBUcmFjZSB2aXJ0dWFsaXphdGlvbiBjYW4gYmUg
d29yayBpbiBvbmUgb2YgMiBwb3NzaWJsZSBtb2RlcyBieSBzZXQgbmV3IG9wdGlvbiAicHRfbW9k
ZSIuIERlZmF1bHQgaXMgU3lzdGVtLVdpZGUgbW9kZS4NCmEuIFN5c3RlbS1XaWRlIG1vZGUgKGRl
ZmF1bHQpOg0KICAgV2hlbiB0aGUgaG9zdCBjb25maWd1cmVzIEludGVsIFBUIHRvIGNvbGxlY3Qg
dHJhY2UgcGFja2V0cyBvZiB0aGUgZW50aXJlIHN5c3RlbSwgaXQgY2FuIGxlYXZlIHRoZSByZWxl
dmFudCBWTVggY29udHJvbHMNCiAgIGNsZWFyIHRvIGFsbG93IFZNWC1zcGVjaWZpYyBwYWNrZXRz
IHRvIHByb3ZpZGUgaW5mb3JtYXRpb24gYWNyb3NzIFZNWCB0cmFuc2l0aW9ucy4NCiAgIEtWTSBn
dWVzdCB3aWxsIG5vdCBhd2FyZSB0aGlzIGZlYXR1cmUgaW4gdGhpcyBtb2RlIGFuZCBib3RoIGhv
c3QgYW5kIEtWTSBndWVzdCB0cmFjZSB3aWxsIG91dHB1dCB0byBob3N0IGJ1ZmZlci4NCg0KYi4g
SG9zdC1HdWVzdCBtb2RlOg0KICAgSG9zdCBjYW4gY29uZmlndXJlIHRyYWNlLXBhY2tldCBnZW5l
cmF0aW9uIHdoaWxlIGluIFZNWCBub24tcm9vdCBvcGVyYXRpb24gZm9yIGd1ZXN0cyBhbmQgcm9v
dCBvcGVyYXRpb24NCiAgIGZvciBuYXRpdmUgZXhlY3V0aW5nIG5vcm1hbGx5Lg0KICAgSW50ZWwg
UFQgd2lsbCBiZSBleHBvc2VkIHRvIEtWTSBndWVzdCBpbiB0aGlzIG1vZGUsIGFuZCB0aGUgdHJh
Y2Ugb3V0cHV0IHRvIHJlc3BlY3RpdmUgYnVmZmVyIG9mIGhvc3QgYW5kIGd1ZXN0Lg0KICAgSW4g
dGhpcyBtb2RlLCB0aGUgc3RhdHVzIG9mIFBUIHdpbGwgYmUgc2F2ZWQgYW5kIGRpc2FibGVkIGJl
Zm9yZSBWTS1lbnRyeSBhbmQgcmVzdG9yZWQgYWZ0ZXIgVk0tZXhpdCBpZiB0cmFjZSBhIHZpcnR1
YWwgbWFjaGluZS4NCg0KQXR0YWNobWVudDogPCB0aGUgUERGIGZpbGUgPg0KDQpUaGFua3MsDQpM
dXdlaSBLYW5nDQo=
