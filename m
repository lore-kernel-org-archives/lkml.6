Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C04C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7722081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 00:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7722081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeJaJcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 05:32:10 -0400
Received: from mga07.intel.com ([134.134.136.100]:31580 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeJaJcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 05:32:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 17:36:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="82222378"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga007.fm.intel.com with ESMTP; 30 Oct 2018 17:36:26 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 17:36:26 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx117.amr.corp.intel.com (10.18.116.17) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Oct 2018 17:36:25 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.102]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.117]) with mapi id 14.03.0415.000;
 Wed, 31 Oct 2018 08:36:24 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Marc Orr <marcorr@google.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Chao Peng" <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work
 mode
Thread-Topic: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work
 mode
Thread-Index: AQHUa3CrSmGUmyBSyUy4MzZKiwm0DqUuDVQAgAEJRcCAB/KrAIAABWGAgACGsuD//4LkAIABdA8A
Date:   Wed, 31 Oct 2018 00:36:24 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172BDC044@SHSMSX101.ccr.corp.intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
 <1540368316-12998-7-git-send-email-luwei.kang@intel.com>
 <CALMp9eSNr_AedOLv+gcqayFQSpwxQnVdsJQSWG1qixwNUmQXzw@mail.gmail.com>
 <82D7661F83C1A047AF7DC287873BF1E172BD64F1@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.21.1810301027480.5984@nanos.tec.linutronix.de>
 <ad7452a3-61d7-1276-e0a5-84e6696832a7@redhat.com>
 <82D7661F83C1A047AF7DC287873BF1E172BDB25D@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.21.1810301122580.5984@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810301122580.5984@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDZhYTE5NDQtOTE4NC00ODY0LWExZDEtYzk2MTMwYTQxODY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUXR5d0Nzc2tNQUkxMjJTeWVNWVpHek9qc2hXbFdtcDMzTU1FaCt0UFJGUWJpQk1uNUpSN3pKa2krNEdFZ3M5eCJ9
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

PiA+ID4gPj4gVGhpcyBwYXJ0IGlzIGluIHRoZSAiIEludGVswq4gQXJjaGl0ZWN0dXJlIEluc3Ry
dWN0aW9uIFNldCBFeHRlbnNpb25zIGFuZCBGdXR1cmUgRmVhdHVyZXMgUHJvZ3JhbW1pbmcgUmVm
ZXJlbmNlIg0KPiA+ID4gPj4gaHR0cHM6Ly9zb2Z0d2FyZS5pbnRlbC5jb20vc2l0ZXMvZGVmYXVs
dC9maWxlcy9tYW5hZ2VkL2M1LzE1L2FyY2gNCj4gPiA+ID4+IGl0ZWMgdHVyZS1pbnN0cnVjdGlv
bi1zZXQtZXh0ZW5zaW9ucy1wcm9ncmFtbWluZy1yZWZlcmVuY2UucGRmDQo+ID4gPiA+Pg0KPiA+
ID4gPiBZZXQgYW5vdGhlciBQREYgd2hpY2ggd2lsbCBjaGFuZ2UgaXQncyBsb2NhdGlvbiBzb29u
ZXIgdGhhbiBsYXRlci4NCj4gPiA+ID4gQ2FuIHlvdSBwbGVhc2Ugc3RpY2sgdGhhdCBpbnRvIHRo
ZSBrZXJuZWwub3JnIGJ1Z3ppbGxhIGFuZA0KPiA+ID4gPiByZWZlcmVuY2UgdGhlIEJaIGluIHRo
ZSBjaGFuZ2UgbG9nLCBzbyB3ZSBoYXZlIHNvbWV0aGluZyBmb3IgcG9zdGVyaXR5Pw0KPiA+ID4N
Cj4gPiA+IEhvcGVmdWxseSBwb3N0ZXJpdHkgd2lsbCBiZSBhYmxlIHRvIHJlYWQgaXQgaW4gdGhl
IFNETS4gIEJ1dCBJIGFncmVlDQo+ID4gPiBpdCdzIGEgZ29vZCBpZGVhIHRvIGFkZCBpdCBpbiB0
aGUgY29tbWl0IGxvZy4gIExldCdzIGFsc28gd2FpdCBmb3IgQWxleGFuZGVyIHRvIGNsYXJpZnkg
d2hhdCBoZSB0aGlua3MgbmVlZHMgdG8gYmUgZG9uZS4NCj4gPg0KPiA+IEkgd2lsbCBjcmVhdGUg
YSBuZXcgYnVnIGZvciB0aGlzIGZlYXR1cmUgaW4gQnVnemlsbGEsIHBsZWFzZSBoZWxwDQo+ID4g
Y29uZmlybSBpZiBjYW4gbGlrZSB0aGlzIGZpcnN0IChpdCBteSBmaXJzdCB0aW1lIHRvIGNyZWF0
ZSBidWcgaW4NCj4gPiBrZXJuZWwub3JnIDopICkNCj4gPg0KPiANCj4gTG9va3MgZ29vZC4NCj4g
DQoNCkhhdmUgZG9uZS4NCmh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9MjAxNTY1DQoNClRoYW5rcywNCkx1d2VpIEthbmcNCg==
