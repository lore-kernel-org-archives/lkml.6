Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B583DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903F4214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfA2Jco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:32:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:26205 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfA2Jco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:32:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 01:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,536,1539673200"; 
   d="scan'208";a="113545131"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 29 Jan 2019 01:32:42 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 29 Jan 2019 01:32:39 -0800
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 29 Jan 2019 01:32:39 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.110]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.190]) with mapi id 14.03.0415.000;
 Tue, 29 Jan 2019 17:32:37 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     "Kang, Luwei" <luwei.kang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Thread-Topic: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Thread-Index: AQHUrvgng1TGbq88YUCMNKU8aNpvOaW/01aAgAR9dGCAAbiiYA==
Date:   Tue, 29 Jan 2019 09:32:36 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD4BDD@SHSMSX101.ccr.corp.intel.com>
References: <1547793240-9157-1-git-send-email-luwei.kang@intel.com>
 <a88ee1f8-ec49-f35f-5b97-65bb1ceb9ea4@redhat.com>
 <82D7661F83C1A047AF7DC287873BF1E172CD3820@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E172CD3820@SHSMSX101.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjQzYmZmZjktNTI0ZC00Y2Q4LWI3YTUtMzhkYmZlOWRlNTk4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVDQ3TkM0NHRnWDlOTFJySGtrVzFIOVFST0JpNTJwWnljQ3R3K2xcL3VPNkIzelpVSmFKbVwvbmNqUXk5NFdMSGJsIn0=
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

PiA+IEhvd2V2ZXIsIHlvdSBzaG91bGQgYXQgbGVhc3QgY2hhbmdlIHRoZSBjb21tZW50IGluIHZj
cHVfZW50ZXJfZ3Vlc3QgdG8NCj4gPiBtZW50aW9uICJiZWZvcmUgcmVhZGluZyBQSVIiIGluc3Rl
YWQgb2YgImJlZm9yZSByZWFkaW5nIFBJUi5PTiIuDQo+IA0KPiBXaWxsIGRvIHRoYXQuIEkgdGhp
bmsgdGhlICJjaGVja2luZyBQSVIuT04iIHNob3VsZCBiZSBQSUQuT04uIEkgd2lsbCBmaXggaXQu
DQo+IA0KSGkgUGFvbG8sDQogICAgSSByZWNvbnNpZGVyZWQgdGhlIGNvbW1lbnQgaW4gdmNwdV9l
bnRlcl9ndWVzdCgpIGFuZCB0aGluayBpdCBtYXkgZG9uJ3QgbmVlZCB0byBjaGFuZ2UuIFRoZSBv
cmlnaW5hbCBjb21tZW50IGFzIGJlbG93Og0KICAgICAgICAgKiAyKSBGb3IgQVBJQ3YsIHdlIHNo
b3VsZCBzZXQgLT5tb2RlIGJlZm9yZSBjaGVja2luZyAgUElSLk9OLiAgVGhpcw0KICAgICAgICAg
KiBwYWlycyB3aXRoIHRoZSBtZW1vcnkgYmFycmllciBpbXBsaWNpdCBpbiBwaV90ZXN0X2FuZF9z
ZXRfb24NCiAgICAgICAgICogKHNlZSB2bXhfZGVsaXZlcl9wb3N0ZWRfaW50ZXJydXB0KS4NCg0K
ICAgIEkgdGhpbmsgImJlZm9yZSBjaGVja2luZyBQSVIuT04iIGlzIG1lYW4gImJlZm9yZSBjaGVj
a2luZyBQSUQuUElSIGFuZCBQSUQuT04iLiBCZWNhdXNlIHRoZXJlIGluZGVlZCBoYXZlIHRoaXMg
dHdvIGZsYWcgY2hlY2sgaW4gIHZteF9kZWxpdmVyX3Bvc3RlZF9pbnRlcnJ1cHQoKSBmdW5jdGlv
bi4gSWYgUElELk9OIGlzIGFscmVhZHkgU2V0IGF0IHRoZSB0aW1lIG9mIGhhcmR3YXJlIHBvc3Rp
bmcgYW4gaW50ZXJydXB0IHRvIFBJUiBmaWVsZCwgbm90aWZpY2F0aW9uIGV2ZW50IGlzIG5vdCBn
ZW5lcmF0ZWQgKGZyb20gVlQtZCBzcGVjIDkuMTIpLg0KDQpUaGFua3MsDQpMdXdlaSBLYW5nDQo=
