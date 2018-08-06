Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C1CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A6C21A01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="k3UgbYzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A6C21A01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbeHFNsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:48:22 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:39116 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeHFNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:48:22 -0400
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 41kbKK5Mt4z4f3klb;
        Mon,  6 Aug 2018 13:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1533555573;
        bh=5rxI6fYL9wd3HGUtcwlzBi6RuUarhfuGqGmpjdvD9c0=; l=10;
        h=From:From:Reply-To:Sender;
        b=k3UgbYzHDbyo6GJV9V4GLCNR0H+FoM9VWi5ZdUuhQLN61bE6dskw4JQmL5OWymgdv
         LS5BhwJ2s0oadxlKFMJpAPkK2MJ7mEPwNsbYI+mMpVqq5lkiVMdFoYG7PL9AYm0mt0
         N14qipF7IRy+BdShN5J0AD1qkrcxowNYKEXQsrIQ=
Received: from fe0vm1740.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTP id 41kbKK4sb9z6CjQfP;
        Mon,  6 Aug 2018 13:39:33 +0200 (CEST)
X-AuditID: 0a3aad14-887ff70000000cae-7e-5b683375c579
Received: from si0vm1949.rbesz01.com (Unknown_Domain [10.58.173.29])
        (using TLS with cipher AES128-SHA (128/128 bits))
        (Client did not present a certificate)
        by fe0vm1740.rbesz01.com (SMG Outbound) with SMTP id 61.95.03246.573386B5; Mon,  6 Aug 2018 13:39:34 +0200 (CEST)
Received: from FE-MBX2050.de.bosch.com (fe-mbx2050.de.bosch.com [10.3.231.60])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 41kbKK3GnJz6D6XD6;
        Mon,  6 Aug 2018 13:39:33 +0200 (CEST)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2050.de.bosch.com (10.3.231.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Mon, 6 Aug 2018 13:39:33 +0200
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Mon, 6 Aug 2018 13:39:33 +0200
From:   "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "WANG Xin (BT-FIR/ENG1-Zhu)" <Xin.Wang7@cn.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Subject: Re: [PATCH] eeprom: at24: Fix unexpected timeout under high load
Thread-Topic: [PATCH] eeprom: at24: Fix unexpected timeout under high load
Thread-Index: AdQtaVsfz7z65+4/RnKDjPD2HkYfBg==
Date:   Mon, 6 Aug 2018 11:39:32 +0000
Message-ID: <cf106f99b8794bb38c16c7a5a83e128b@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22TfUwbdRjH+fX6ctQeHNd2PHaybM00mXG8DIxl3chCjKlGs5ktZkiMHvag
        nbQldwVhRMPojBu4iGXUrmVsjrGwF+xEJax0q6mOiGxWgxvsRUTmmAXMpswMedMrB2v/8J/L
        977P7/N9nt9zORyjOnANbrbaGdZKl2qlcrF8Y0fa+opsU2HmwCZdpOFrpJt39sp0/pEuqc7R
        6pPq9s3fR7oBf7N0i9QwO+NEhtarNySGc56fZYbg4TMyw1Tnqm2SV+WbjEypuYJhM/LekJsu
        DrXIyvybK101N7AadE9fhxJxIHPAvb9OWofkOEU2iaB3eFASLVDkBQQB106hMIng49t3xcJL
        EMH5iQOi6CkpuRHeP9Evi2oV+Qr4ZqYWNUaeEoF3bFdUK8nnYd7TJBbOvABXWrqQoNPh5Bcf
        Lvpici18M356MZMg9RAYvbKoEZkGZ8+GMSEzFTrHHkiEsUk4HhB8INUQubXA+ziv10CzOz8q
        MXId+PwZArkGDtb/KhPSU6Dv0G/iBqT2xIV6YoQnjvDEEUeR+BRSFzOZFZasZ3Iy09kihtud
        mZX+ps3SiYRvpupGs6HiECJxpFUQ51eaCikJXcFVWULoaVykVRPTSt5KKrIZq0w0Z3qdLS9l
        OK2GQAkJCZTyoc2VF1nMHGe2WUMIcEyrItq9JYUUYaSrdjOsTcBCaCUu1qYS1peNhRRZQtuZ
        tximjGGXq3oc1wJh3sA3TGGZEqay2FxqXy5r04SeK+Ir8W1FeGIIZeMKvnduNILgymgLZy5Z
        wh8VcGrZjaHfoa34dccHTgyfu9vEP2/Wu5wYJbbarIwmlXg7mkVGKVO59eE0mseIgiH+guq4
        QixxHF1D/D6VxLEorOB/k9gcQHQrmwuolCUzBm1o4xmyTwXBawMI9t+fQ9A5dVsE/WP3ROBb
        +AOD1uNuCTRMfimBfz9xSGF65C8p/DR7Swbv9dTisG/hIA6/D4cT4fvBSCJ42/bIwVk/IofP
        2i48AsFfjingkuOOAoJeZxLMHGpKhunJz5Ph4t7RZHBH3CQEx9pJOBKeTYEfWi5T4DznUkLj
        R0dVcMZXq4bhcKsavF2NqeP8kkX8kqtzmOiS7bT9f5a85MZup6lBntU9Ha89GzhAOKw982rY
        nq0c65/I2Ms+yH0c/+rT6y+2RHbeqbTsecKVd/rm0GWKzpOePGK+pN/2VD5rTNBzk38zu6pz
        PM5RQ/Ucd6J3VUNyeGv3P2u3lPUVdOT/+FzSuy/5V9sPT1x9hybbA5tz240r/qwKfZtXvENf
        G2xcN7jeoRVzJjrrSYzl6P8AsvViZsAEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KPiA+PiA+IC0jZGVmaW5lIGF0MjRfbG9vcF91bnRpbF90aW1lb3V0KHRvdXQs
IG9wX3RpbWUpICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPj4gPiAtICAgICAgIGZvciAo
dG91dCA9IGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKGF0MjRfd3JpdGVfdGltZW91dCksICAg
ICBcDQo+ID4+ID4gLSAgICAgICAgICAgIG9wX3RpbWUgPSAwOyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+PiA+IC0gICAgICAgICAgICBvcF90aW1l
ID8gdGltZV9iZWZvcmUob3BfdGltZSwgdG91dCkgOiB0cnVlOyAgICAgICAgICAgICAgIFwNCj4g
Pj4gPiAtICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDEwMDAsIDE1MDApLCBvcF90aW1lID0gamlm
ZmllcykNCj4gPj4NCj4gPj4gVGhpcyBvbmUgdW5kZXJzdGFuZGJsZSBhbmQgcmVwcmVzZW50cyBv
bmUgb3BlcmF0aW9uLg0KPiA+DQo+ID4gSXQganVzdCBoYXMgdGhlIGRvd25zaWRlIHRoYXQgaXQg
d2lsbCBub3QgcmV0cnkgaWYgdGhlIHRpbWVvdXQgaXMNCj4gPiByZWFjaGVkIGFmdGVyIHRoZSB1
c2xlZXBfcmFuZ2UoKS4NCj4gPg0KPiA+IElmIHlvdSBoYXZlIGEgc3lzdGVtIHdoaWNoIGNvbWJp
bmVzIGhpZ2ggQ1BVIGxvYWQgd2l0aCByZXBlYXRlZA0KPiBFRVBST00NCj4gPiB3cml0ZXMgeW91
IHdpbGwgcnVuIGludG8gdGhlIGZvbGxvd2luZyBzY2VuYXJpbzoNCj4gPg0KPiA+IC0gU3lzdGVt
IG1ha2VzIGEgc3VjY2Vzc2Z1bCByZWdtYXBfYnVsa193cml0ZSgpIHRvIEVFUFJPTS4NCj4gPiAt
IFN5c3RlbSB3YW50cyB0byBwZXJmb3JtIGFub3RoZXIgd3JpdGUgdG8gRUVQUk9NIGJ1dCBFRVBS
T00gaXMgc3RpbGwNCj4gPiAgIGJ1c3kgd2l0aCB0aGUgbGFzdCB3cml0ZS4NCj4gPiAtIEJlY2F1
c2Ugb2YgaGlnaCBDUFUgbG9hZCB0aGUgdXNsZWVwX3JhbmdlKCkgd2lsbCBzbGVlcCBtb3JlIHRo
YW4NCj4gPiAgIDI1IG1zIChhdDI0X3dyaXRlX3RpbWVvdXQpLg0KPiA+IC0gV2l0aGluIHRoZSBv
dmVyLWxvbmcgc2xlZXBpbmcgdGhlIEVFUFJPTSBmaW5pc2hlZCB0aGUgcHJldmlvdXMgd3JpdGUN
Cj4gPiAgIG9wZXJhdGlvbiBhbmQgaXMgcmVhZHkgYWdhaW4uDQo+ID4gLSBhdDI0X2xvb3BfdW50
aWxfdGltZW91dCgpIHdpbGwgZGV0ZWN0IHRpbWVvdXQgYW5kIHdvbid0IHRyeSB0byB3cml0ZS4N
Cj4gDQo+ID4NCj4gPiBUaGUgc2NlbmFyaW8gYWJvdmUgaGFwcGVucyB2ZXJ5IG9mdGVuIG9uIG91
ciBzeXN0ZW0gYW5kIHdlIG5lZWQgYSBmaXguDQo+IA0KPiBUaGFua3MgZm9yIGV4cGxhbmF0aW9u
IHdoeS4gKGl0IHdvdWxkIGJlIGdvb2QgcGFydGlhbGx5IG1vdmUgdGhpcyB0bw0KPiB0aGUgY29t
bWl0IG1lc3NhZ2UpLg0KDQpXZSB3aWxsIGltcHJvdmUgdGhlIGNvbW1pdCBtZXNzYWdlIGluIHRo
ZSBuZXh0IHJldmlzaW9uIG9mIHRoZSBwYXRjaC4NCg0KPiA+PiA+ICsjZGVmaW5lIGF0MjRfbG9v
cF91bnRpbF90aW1lb3V0X2JlZ2luKHRvdXQsIG9wX3RpbWUpICAgICAgICAgICBcDQo+ID4+ID4g
KyAgICAgICB0b3V0ID0gamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMoYXQyNF93cml0ZV90aW1l
b3V0KTsgIFwNCj4gPj4gPiArICAgICAgIHdoaWxlICh0cnVlKSB7ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+PiA+ICsgICAgICAgICAgICAgICBvcF90aW1l
ID0gamlmZmllczsNCj4gPj4gPiArDQo+ID4+ID4gKyNkZWZpbmUgYXQyNF9sb29wX3VudGlsX3Rp
bWVvdXRfZW5kKHRvdXQsIG9wX3RpbWUpICAgICAgICAgICAgIFwNCj4gPj4gPiArICAgICAgICAg
ICAgICAgaWYgKHRpbWVfYmVmb3JlKHRvdXQsIG9wX3RpbWUpKSAgICAgICAgICAgICAgICAgXA0K
PiA+PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcDQo+ID4+ID4gKyAgICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAw
LCAxNTAwKTsgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPj4gPiArICAgICAgIH0NCj4gPj4N
Cj4gPj4gQmVzaWRlcyBgd2hpbGUgKHRydWUpYCwgd2hpY2ggaXMgYSByZWQgZmxhZyBmb3IgdGlt
ZW91dCBsb29wcywNCj4gPj4gdGhlc2UgYXJlIGRvbmUgaW4gYW4gaGFjayB3YXkuIEp1c3Qgb3Bl
biBjb2RlIHRoZW0gaW4gYm90aCBjYXNlcywgb3INCj4gPj4gcmV3cml0ZSBvcmlnaW5hbCBvbmUg
dG8ga2VlbCBpdCdzIHNlbWFudGljcy4NCj4gPg0KPiA+IEkgaGF2ZSB0byBhZG1pdCB0aGF0IEkg
YW0gbm90IHN1cmUgd2hhdCB5b3UgbWVhbi4NCj4gPg0KPiA+IFdlIGtlcHQgdGhlIG1hY3JvLXN0
eWxlIG9mIHRoZSBsb29wIGJlY2F1c2Ugd2UgYXNzdW1lZCBpdCB3YXMgZ29vZA0KPiA+IHN0eWxl
IGluIHRoaXMgY29udGV4dC4NCj4gDQo+IE5vIHdheS4gSXQncyBhIGJhZCBzdHlsZSB3aGVuIHlv
dSBoYXZlIGEgbWFjcm8gbGlrZSB5b3UgcHJvcG9zaW5nLiBJdA0KPiB3b3VsZCBnaXZlIHlvdSBh
IGJvdHRsZSBvZiBzcGFya2xpbmcgYnVncy4NCj4gDQo+ID4gV2hhdCBkb2VzICJrZWVsIGl0J3Mg
c2VtYW50aWNzIiBtZWFuPw0KPiANCj4gTWFjcm8gc2hvdWxkIGJlIHN0YW5kYWxvbmUgcGllY2Ug
b2YgY29kZSB3aGljaCBkb2VzIHNvbWV0aGluZyBmcm9tIEENCj4gdG8gWiwgbm90IGZyb20gQS1L
IHdoZW4geW91IG5lZWQgYSBjb21wbGVtZW50YXJ5IG1hY3JvIHRvIGRvIEwtWg0KPiBwYXJ0cy4N
Cg0KSSBhZ3JlZSwgd2Ugd2lsbCBkbyBpdCB3aXRob3V0IGEgbWFjcm8gdGhlbi4NCg0KPiA+IFdp
dGggIm9wZW4gY29kZSB0aGVtIGluIGJvdGggY2FzZXMiIGRvIHlvdSBtZWFuIHRvIHJpZCBvZiB0
aGUgbWFjcm8NCj4gPiBhbmQgdG8gZGlyZWN0bHkgd3JpdGUgdGhlIGxvb3AgaW50byB0aGUgY29k
ZT8gRG9lcyB0aGUgZm9sbG93aW5nDQo+ID4gbWF0Y2ggeW91ciBwcm9wb3NhbHM/DQo+ID4NCj4g
PiByZXQgPSAwOw0KPiA+IHRvdXQgPSBqaWZmaWVzICsgbXNlY3NfdG9famlmZmllcyhhdDI0X3dy
aXRlX3RpbWVvdXQpOw0KPiA+IGRvIHsNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gICAgICAg
ICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAwLCAxNTAwKTsNCj4gPg0KPiA+ICAgICAgICAgcmVh
ZF90aW1lID0gamlmZmllczsNCj4gPg0KPiA+ICAgICAgICAgcmV0ID0gcmVnbWFwX2J1bGtfcmVh
ZChyZWdtYXAsIG9mZnNldCwgYnVmLCBjb3VudCk7DQo+ID4gICAgICAgICBkZXZfZGJnKCZjbGll
bnQtPmRldiwgInJlYWQgJXp1QCVkIC0tPiAlZCAoJWxkKVxuIiwNCj4gPiAgICAgICAgICAgICAg
ICAgY291bnQsIG9mZnNldCwgcmV0LCBqaWZmaWVzKTsNCj4gPiAgICAgICAgIGlmICghcmV0KQ0K
PiA+ICAgICAgICAgICAgICAgICByZXR1cm4gY291bnQ7DQo+ID4gfSB3aGlsZSAoIXRpbWVfYmVm
b3JlKHRvdXQsIHJlYWRfdGltZSkpDQo+IA0KPiBZZXMsIHRob3VnaCwgcGxlYXNlLCBsb29rIGF0
IHRoZSBleGFtcGxlcyBpbiB0aGUgZXhpc3RpbmcgY29kZSBhbmQNCj4gbWFrZSBpdCBzbGlnaHRs
eSBiZXR0ZXINCj4gDQo+IHRpbWVvdXQgPSAuLi4NCj4gZG8gew0KPiByZXQgPSAuLi4NCj4gaWYg
KHJldCkgLy8gb3IgaWYgKCFyZXQpDQo+ICAuLi4NCj4gDQo+IHVzbGVlcF9yYW5nZSguLi4pOw0K
PiB9IHdoaWxlKHRpbWVfYmVmb3JlKC4uLikpOw0KDQpXaGVuIHdvcmtpbmcgb24gdGhlIHByb2Js
ZW0gd2UgaGFkIGFuIGludGVybWVkaWF0ZSByZXN1bHQgd2VyZSB3ZQ0KY2FtZSB0byB0aGUgc2Ft
ZSBzb2x1dGlvbiBhcyB5b3VyIHByb3Bvc2FsIHNob3dlZDoNCg0KdG91dCA9IGppZmZpZXMgKyBt
c2Vjc190b19qaWZmaWVzKGF0MjRfd3JpdGVfdGltZW91dCk7DQpkbyB7DQogICAgICAgICByZWFk
X3RpbWUgPSBqaWZmaWVzOw0KDQogICAgICAgICByZXQgPSByZWdtYXBfYnVsa19yZWFkKHJlZ21h
cCwgb2Zmc2V0LCBidWYsIGNvdW50KTsNCiAgICAgICAgIGRldl9kYmcoJmNsaWVudC0+ZGV2LCAi
cmVhZCAlenVAJWQgLS0+ICVkICglbGQpXG4iLA0KICAgICAgICAgICAgICAgICBjb3VudCwgb2Zm
c2V0LCByZXQsIGppZmZpZXMpOw0KICAgICAgICAgaWYgKCFyZXQpDQogICAgICAgICAgICAgICAg
IHJldHVybiBjb3VudDsNCg0KICAgICAgICAgdXNsZWVwX3JhbmdlKDEwMDAsIDE1MDApOw0KfSB3
aGlsZSAoIXRpbWVfYmVmb3JlKHRvdXQsIHJlYWRfdGltZSkpDQoNClRoZSBhZHZhbnRhZ2Ugb2Yg
dGhpcyBjb2RlIGlzIHRoYXQgdGhlIHVzbGVlcF9yYW5nZSgpIGlzIHVuY29uZGl0aW9uYWwuDQoN
CihJbiBteSBvbGRlciBwcm9wb3NhbCBhICJpZiAocmV0KSIgY29uZGl0aW9uIGlzIHJlcXVpcmVk
IHRvIG1ha2Ugc3VyZQ0KdGhhdCB0aGVyZSBpcyBub3Qgc2xlZXAgYXQgdGhlIHZlcnkgZmlyc3Qg
aXRlcmF0aW9uIGJ1dCBvbmx5IGF0DQpmb2xsb3ctdXAgaXRlcmF0aW9ucyB3aGVyZSByZWdtYXBf
YnVsa19yZWFkKCkgZmFpbGVkLikNCg0KVGhlIGRpc2FkdmFudGFnZSBvZiB0aGUgbmV3IHByb3Bv
c2FsIGlzIHRoYXQgaW4gY2FzZSBvZiBhIHRpbWVvdXQgb25lDQptb3JlIHVubmVjZXNzYXJ5IHNs
ZWVwIGlzIG1hZGUuIElzIHRoYXQgYWNjZXB0YWJsZT8NCg0KQW4gYWx0ZXJuYXRpdmUgd291bGQg
YmUgdG8gZHVwbGljYXRlIHRoZSByZWdtYXBfYnVsa19yZWFkKCkgYW5kIHRoZQ0KZGVidWdnaW5n
IGNvZGUgb3V0c2lkZSB0aGUgbG9vcC4NCg0KdG91dCA9IGppZmZpZXMgKyBtc2Vjc190b19qaWZm
aWVzKGF0MjRfd3JpdGVfdGltZW91dCk7DQpyZWFkX3RpbWUgPSBqaWZmaWVzOw0KDQpyZXQgPSBy
ZWdtYXBfYnVsa19yZWFkKHJlZ21hcCwgb2Zmc2V0LCBidWYsIGNvdW50KTsNCmRldl9kYmcoJmNs
aWVudC0+ZGV2LCAicmVhZCAlenVAJWQgLS0+ICVkICglbGQpXG4iLA0KCWNvdW50LCBvZmZzZXQs
IHJldCwgamlmZmllcyk7DQoNCndoaWxlIChyZXQgJiYgIXRpbWVfYmVmb3JlKHRvdXQsIHJlYWRf
dGltZSkpDQoJdXNsZWVwX3JhbmdlKDEwMDAsIDE1MDApOw0KDQoJLyoNCgkgKiBUaGUgdGltZXN0
YW1wIHNoYWxsIGJlIHRha2VuIGJlZm9yZSBzbGVlcCBhbmQgdGhlIGFjdHVhbA0KCSAqIG9wZXJh
dGlvbiB0byBhdm9pZCBhIHByZW1hdHVyZSB0aW1lb3V0IGluIGNhc2Ugb2YgaGlnaCBDUFUgbG9h
ZC4NCgkgKi8NCglyZWFkX3RpbWUgPSBqaWZmaWVzOw0KDQoJcmV0ID0gcmVnbWFwX2J1bGtfcmVh
ZChyZWdtYXAsIG9mZnNldCwgYnVmLCBjb3VudCk7DQoJZGV2X2RiZygmY2xpZW50LT5kZXYsICJy
ZWFkIHJldHJ5ICV6dUAlZCAtLT4gJWQgKCVsZClcbiIsDQoJCWNvdW50LCBvZmZzZXQsIHJldCwg
amlmZmllcyk7DQp9DQoNCmlmICghcmV0KQ0KCXJldHVybiBjb3VudDsNCg0KSXMgdGhpcyBwcmVm
ZXJhYmxlPw0KDQpHcmVldGluZ3MsDQpNYXJrDQoNCkJ1aWxkaW5nIFRlY2hub2xvZ2llcywgUGFu
ZWwgU29mdHdhcmUgRmlyZSAoQlQtRklSL0VORzEpIA0KQm9zY2ggU2ljaGVyaGVpdHNzeXN0ZW1l
IEdtYkggfCBQb3N0ZmFjaCAxMSAxMSB8IDg1NjI2IEdyYXNicnVubiB8IEdFUk1BTlkgfCB3d3cu
Ym9zY2hzZWN1cml0eS5jb20NCg0KU2l0ejogU3R1dHRnYXJ0LCBSZWdpc3RlcmdlcmljaHQ6IEFt
dHNnZXJpY2h0IFN0dXR0Z2FydCBIUkIgMjMxMTggDQpBdWZzaWNodHNyYXRzdm9yc2l0emVuZGVy
OiBTdGVmYW4gSGFydHVuZzsgR2VzY2jDpGZ0c2bDvGhydW5nOiBUYW5qYSBSw7xja2VydCwgQW5k
cmVhcyBCYXJ0eiwgVGhvbWFzIFF1YW50ZSwgQmVybmhhcmQgU2NodXN0ZXINCg==
