Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A98FC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C19320850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="rMYp8fkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C19320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbeGVXUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:20:44 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34116 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbeGVXUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:20:44 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 30D168365E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:22:28 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532298148;
        bh=h0GaWQH8IxPvY1AQsD/hKFpwO+rBzl43z+410R9f73Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=rMYp8fkFgqt+N9NDDvjjmBpYMA2AAyUSFaNEHlnpQAMugX/VKwcU6chog/3hv9QXk
         9rzhYTx/U3xcNLJ2ViNQARD0dC7OkpK7BRYHCrqSrjLzWRPgdvmhJXfLTf1XtYZi+d
         fP40L9jaW5QuOqTrHHp9CsrYMZ6kbFDJXfleF++0=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5503a50001>; Mon, 23 Jul 2018 10:22:29 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1156.6; Mon, 23 Jul 2018 10:22:28 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Mon, 23 Jul 2018 10:22:28 +1200
From:   Theuns Verwoerd <Theuns.Verwoerd@alliedtelesis.co.nz>
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/2] jffs2: Provide jffs2_sync files to track gc POLL
 progress
Thread-Topic: [PATCH 2/2] jffs2: Provide jffs2_sync files to track gc POLL
 progress
Thread-Index: AQHUH7qBn4Fk7uVIKEuVREFccvK0fqSWcdeAgAAOAQCAA/QcgIAAmF2A
Date:   Sun, 22 Jul 2018 22:22:27 +0000
Message-ID: <e85ebd5d-e4a0-0b48-4664-78f90211c64f@alliedtelesis.co.nz>
References: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
 <f1c6c3cc0c8850e143594afd57b50d30cd8bb5f8.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
 <20180720000431.GA30522@ZenIV.linux.org.uk>
 <b2b2e3e0-14b7-9f46-434d-2134d1d0cfad@alliedtelesis.co.nz>
 <CAFLxGvyTmz8JQVn-OJFSVdns74o49XgdWbhGpPsqYe5S2uahYg@mail.gmail.com>
In-Reply-To: <CAFLxGvyTmz8JQVn-OJFSVdns74o49XgdWbhGpPsqYe5S2uahYg@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.16.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <31F9504A4CD84245B4CF996530ACAEDF@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcvMjMvMjAxOCAwMToxNyBBTSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOg0KPiBCZXNp
ZGUgb2YgdGhhdCwgSU1ITyB0aGlzIGRlYnVnZnMgZmlsZSBpcyBhIGdyb3NzIGhhY2suDQo+IERp
ZCB5b3UgbG9vayBpbnRvIHRoZSBwb3NzaWJpbGl0eSB0byBhZGQgdGhlIEdDIHBoYXNlIGludG8g
dGhlIHVubGluayBjb2RlPw0KSSdtIG5vdCB0ZXJyaWJseSBrZWVuIG9uIGl0IGVpdGhlciwgYnV0
IGl0J3MgdGhlIGxlYXN0IGJhZCBvcHRpb24gSSANCmNvdWxkIHRoaW5rIG9mLsKgIFRoZSBtYWlu
IGlzc3VlIGlzIHRoYXQgdGhpcyBraW5kIG9mIGZvcmNlZCBHQyBjYW4gYmUgDQp2ZXJ5IHNsb3cg
KHR5cGljYWxseSAybWluIG9uIG15IHRlc3QgcGxhdGZvcm0pLCBhbmQgaXMgbm90IG5lY2Vzc2Fy
eSBmb3IgDQp0aGUgdmFzdCBtYWpvcml0eSBvZiB1bmxpbmsgY2FzZXMgLSB3ZSBvbmx5IG5lZWQg
dG8gc2VjdXJlbHkgZGVsZXRlIA0Ka2V5cywgb3RoZXIgZmlsZXMgY2FuIGJlIGNsZWFuZWQgdXAg
ZXZlbnR1YWxseS4gVW5saW5rIGNhbGxzIGhhdmUgbm8gd2F5IA0Kb2YgaWRlbnRpZnlpbmcgc3Vj
aCBzZW5zaXRpdmUgZmlsZXMsIGhvd2V2ZXIsIG5vciBpcyB0aGVyZSBhIHdheSBvZiANCmRlbWFy
Y2F0aW5nIGEgc2VyaWVzIG9mIGJhY2stdG8tYmFjayBzZWN1cmUgZGVsZXRpb25zIHRoYXQgY2Fu
IGJlIA0KY29sbGVjdGVkIGVuIG1hc3NlLsKgIFBhcmFsbGVsIHRvIHRoZSBwcm9ibGVtIG9mIHRy
aWdnZXJpbmcgdGhlIGZvcmNlZCANCkdDLCBpcyB0aGUgaXNzdWUgb2Yga25vd2luZyB3aGVuIGl0
IGhhcyBjb21wbGV0ZWQ6IGJsb2NraW5nIG9uIGZpbGUgcmVhZCANCnNlZW1lZCB0byBiZSB0aGUg
bW9zdCBkaWdlc3RpYmxlIHRvIHVzZXJzcGFjZSB3YXkgb2YgZG9pbmcgdGhhdC4NCg0KQWx0ZXJu
YXRpdmVzIEkndmUgY29uc2lkZXJlZCBpbmNsdWRlIG92ZXJ3cml0ZS1iZWZvcmUtdW5saW5rICh0
aGUgYmxvY2sgDQpoaXN0b3J5IGdldHMgY29tcGxpY2F0ZWQsIHBsdXMgdGhlIHByb2JsZW0gb2Yg
YWN0dWFsbHkgZG9pbmcgc3VjaCBhbiANCm92ZXJ3cml0ZSksIGF1dG9tYXRpYyBHQyBvbiB1bmxp
bmsgKHNlZSBhYm92ZSksIGFuIGFsdGVybmF0aXZlIHN5c3RlbSANCmNhbGwgZm9yIHNlY3VyZSB1
bmxpbmsgKHRoYXQgbWVzc2VzIHVwIHRoZSBlbnRpcmUgRlMgY2FsbCBjaGFpbiksIGFuZCANCmVu
Y3J5cHRpbmcgdGhlIHNlbnNpdGl2ZSBmaWxlcyAoa2V5IHRvIGFjY2VzcyBrZXlzIG11c3QgYWxz
byBiZSANCnBlcnNpc3RlbnQsIHdoaWNoIGdldHMgdXMgYmFjayB0byB0aGUgc2FtZSBwcm9ibGVt
KS7CoCBJbiBteSBvcmlnaW5hbCANCnZlcnNpb24gSSdkIHVzZWQgYSAvcHJvYyBmaWxlLCBidXQg
ZGVidWdmcyBoYXMgYSBtb3JlIGZvcmdpdmluZyBzb2NpYWwgDQpjb250cmFjdC4NCg0KUmVnYXJk
cywNCg0KVGhldW5zDQpLUk4=
