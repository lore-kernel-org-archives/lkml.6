Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC86C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C52A20652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C52A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeIGXQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:16:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:60456 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbeIGXQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:16:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 11:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,343,1531810800"; 
   d="scan'208";a="261633680"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2018 11:32:22 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 7 Sep 2018 11:32:22 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.73]) with mapi id 14.03.0319.002;
 Fri, 7 Sep 2018 11:32:22 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH V4 0/3] Add efi page fault handler to recover from page
Thread-Topic: [PATCH V4 0/3] Add efi page fault handler to recover from page
Thread-Index: AQHURjlkSYU05F00bkKzUccpg9YwmqTlF/KAgAANTwA=
Date:   Fri, 7 Sep 2018 18:32:21 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485BA5E8@ORSMSX114.amr.corp.intel.com>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu8F76ngzr_zgAXZhDPNb2SobYc4A8L3Rq-h1kMrbFqK+A@mail.gmail.com>
In-Reply-To: <CAKv+Gu8F76ngzr_zgAXZhDPNb2SobYc4A8L3Rq-h1kMrbFqK+A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWIyMmQ4NmUtMTk0Yi00ODAyLTllODItN2RlNjZlNGU5Y2Q4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibTJjckwzSWJuYlN3Y2RSeVNCd1BpWm0zQ0F3MldzcDk5WmxuaDBZQnZJR3Ftck9TeHp6T0d0aFk2RCt3aEM3YiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFRoZSBlZmkgcGFnZSBmYXVsdCBoYW5kbGVyIHdpbGwgY2hlY2sgaWYgdGhlIGFjY2VzcyBp
cyBieQ0KPiA+IGVmaV9yZXNldF9zeXN0ZW0oKS4NCj4gPiAxLiBJZiBzbywgdGhlbiB0aGUgZWZp
IHBhZ2UgZmF1bHQgaGFuZGxlciB3aWxsIHJlYm9vdCB0aGUgbWFjaGluZQ0KPiA+ICAgIHRocm91
Z2ggQklPUyBhbmQgbm90IHRocm91Z2ggZWZpX3Jlc2V0X3N5c3RlbSgpLg0KPiA+IDIuIElmIG5v
dCwgdGhlbiB0aGUgZWZpIHBhZ2UgZmF1bHQgaGFuZGxlciB3aWxsIGZyZWV6ZSBlZmlfcnRzX3dx
IGFuZA0KPiA+ICAgIHNjaGVkdWxlcyBhIG5ldyBwcm9jZXNzLg0KPiA+DQo+IA0KPiBUaGFua3Mg
U2FpISBJIGFtIHByZXR0eSBoYXBweSBob3cgdGhpcyBwYXRjaCBzZXQgdHVybmVkIG91dC4gSXQg
c3RpbGwgcmVxdWlyZXMgdGhlDQo+IGJsZXNzaW5nIG9mIHRoZSB4ODYgbWFpbnRhaW5lcnMsIG9m
IGNvdXJzZSwgYnV0IGZyb20gbXkgcG92LCB0aGlzIGlzIGdvb2QgdG8gZ28NCj4gKGJ1dCBJIHdp
bGwgZm9sZCBwYXRjaCAjMyBpbnRvICMyKQ0KDQpIb3BlZnVsbHksIHBhdGNoICMzIGdvZXMgYXdh
eSB0b28uLiBpbiBWNS4NCg0KUmVnYXJkcywNClNhaQ0K
