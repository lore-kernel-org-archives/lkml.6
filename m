Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ACDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A86A20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bgDmU7Vm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A86A20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbeGLIlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:41:11 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:54293 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeGLIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:41:11 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 49BFD24E082E;
        Thu, 12 Jul 2018 01:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1531384358; bh=k2Uw5jv7/tjbJa5CEGC4zn2qRfTRjz5i5YjlsCAN2ro=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bgDmU7VmK61NpTFPRoOvjGGpfPBhwzAp8qU2ezP7l2QVgP+QK3f4itUf/hqbzvR6S
         SE/qUFBxJ2CQbejoytygDhrgP9TZITDLb6qr/2yc8dNb4t4PbSCJ37suVKFl0Hr6iD
         bR7hO4+SlMDrDQv1/AbP/wZuPo/ExBQaK4vA3NWVx4TgEYmQiYAPGHRMZfPG9ViYKs
         oT0NNx2a6TZKa0A+2adO0KU/Y/j8uA12BeI9i0tXlFjCe2ACYTt+1K5CwZdBm8e3m4
         gJWcgqHyG311uMGjGDYZn/xDRodunCWD35T648vsne52JTmAGSEApyJFYZSAgjkNV7
         BgD4LAsiDMpew==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1.internal.synopsys.com [10.12.239.235])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2AC055E67;
        Thu, 12 Jul 2018 01:32:38 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 12 Jul 2018 01:32:38 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 12 Jul 2018 10:32:35 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Improve handling of fatal signals in
 do_page_fault()
Thread-Topic: [PATCH] ARC: Improve handling of fatal signals in
 do_page_fault()
Thread-Index: AQHUD9XQgYH1u9RF+UG15MGoFlKsxaSLNI+A
Date:   Thu, 12 Jul 2018 08:32:34 +0000
Message-ID: <cad7f596e41dbfef8d1ee465b13704d738e116bb.camel@synopsys.com>
References: <20180629182005.10243-1-abrodkin@synopsys.com>
In-Reply-To: <20180629182005.10243-1-abrodkin@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.42]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5D0E13F22FAD444B330CD7C2311D1A0@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBGcmksIDIwMTgtMDYtMjkgYXQgMTE6MjAgLTA3MDAsIEFsZXhleSBC
cm9ka2luIHdyb3RlOg0KPiBUaGlzIHdhcyB0cmlnZ2VyZWQgYnkgaW52ZXN0aWdhdGlvbiBvZiBh
IGRlYWRsb2NrIGFmdGVyIE9PTSBraWxsZXIgaW52b2NhdGlvbiwNCj4gc2VlIFsxXSBmb3IgbW9y
ZSBkZXRhaWxzLg0KPiANCj4gTG9va3MgbGlrZSBvdXIgaGFuZGxpbmcgb2YgZmF0YWwgc2lnbmFs
IGluIGRvX3BhZ2VfZmF1bHQoKSBoYXMgc29tZSBpc3N1ZXM6DQo+IA0KPiAxLiBXZSBvbmx5IHdh
bnQgdG8gZG8gc3BlY2lhbCAocmVhZCAiZWFybHkiKSBoYW5kbGluZyBvZiBmYXRhbCBzaWduYWwN
Cj4gICAgaWYgaGFuZGxlX21tX2ZhdWx0KCkgcmV0dXJuZWQgVk1fRkFVTFRfUkVUUlkgc28gdGhh
dCB3ZSBkb24ndCBsb29wDQo+ICAgIGluIHJldHJ5IGxvb3AgZW5kbGVzc2x5LCBvdGhlcndpc2Ug
d2UnbGwgaGFuZGxlIHRoYXQgc2lnbmFsIG5vcm1hbGx5DQo+ICAgIG9uIGV4aXQgZnJvbSBleGNl
cHRpb24gaGFuZGxlci4NCj4gDQo+IDIuIHVwX3JlYWQoKSBpcyBub3QgbmVlZGVkIGFzIGluZGVl
ZCBpdCB3aWxsIGJlIGRvbmUgaW4gX19sb2NrX3BhZ2Vfb3JfcmV0cnkoKQ0KPiAgICBpbiBtbS9m
aWxlbWFwLmMuDQo+IA0KPiBXaXRoIGFib3ZlIGNvbW1lbnRzIGluIG1pbmQgc2ltcGxpZmllZCB2
ZXJzaW9uIHNob3VsZCBiZSBsaWtlIHRoYXQ6DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAJaWYgKGZhdGFsX3NpZ25hbF9w
ZW5kaW5nKGN1cnJlbnQpDQo+IAkJaWYgKGZhdWx0ICYgVk1fRkFVTFRfUkVUUlkpDQo+IAkJCWlm
ICh1c2VyX21vZGUocmVncykpDQo+IAkJCQlyZXR1cm47DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gQnV0IGxvb2tz
IGxpa2UgdGhlcmUncyBhIHJvb20gZm9yIGltcHJvdmVtZW50LCBzZWUgWzJdLg0KPiBJbnN0ZWFk
IG9mIHByb2NlZWRpbmcgZm9yd2FyZCBhbmQgdGhlbiBpbmV2aXRhYmx5IGhpdHRpbmcgcmV0cnkg
cGF0aCB3ZQ0KPiBzaG9ydC1jdXQgcmlnaHQgdG8ga2VybmVsIGZpeC11cCBjb2RlIGluIG5vX2Nv
bnRleHQuDQo+IA0KPiBbMV0gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xp
bnV4LXNucHMtYXJjLzIwMTgtRmVicnVhcnkvMDAzNDAzLmh0bWwNCj4gWzJdIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9j
b21taXQvP2lkPTc0NmEyNzJlNDQxNDFhZjI0YTAyZjZjOWIwZjY1ZjRjNDU5OGVkNDINCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFsZXhleSBCcm9ka2luIDxhYnJvZGtpbkBzeW5vcHN5cy5jb20+DQoN
Ckkgc2hvdWxkIGhhdmUgcHV0IHRoYXQgaW4gY29tbWl0IG1lc3NhZ2UgcmlnaHQgYXdheTopDQoN
ClRoaXMgcGF0Y2ggZml4ZXMgT09NIGxvY2stdXAgd2Ugd2VyZSBzZWVpbmcgcHJldmlvdXNseSwN
CnNlZSBTVEFSIDkwMDEzMDQ2NzQgIk9PTSBraWxsZXIgaGFuZ3Mgc3lzdGVtIi4NCg0KLUFsZXhl
eQ==
