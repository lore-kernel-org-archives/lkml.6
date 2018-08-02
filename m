Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72290C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1801220BED
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KgtffQM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1801220BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeHBI6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:58:40 -0400
Received: from smtprelay4.synopsys.com ([198.182.47.9]:59851 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbeHBI6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:58:39 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 56A6724E0F81;
        Thu,  2 Aug 2018 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533193733; bh=zDf+A6FtvbekuTBWJp7cBsoG3pniim01oxvlPbNswnU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=KgtffQM5XFWvUDxOH7bRlGb8h11MzrgXGahi5P4Mssn+hzo3XHefWPsM2RFamzXQb
         QO1wD19pbxSUijrPXfw9XZRIEiQ3M0xbqQ+mnVNbfoJEo+uqP4QUVUqdjiw8yDMSGq
         xHTK6E1Y/HHTWQYF86aTJqn4mSH7uqGGIQgGSMmTqqy1aoIn11cF2LCgqvrvt8XIUN
         8/kXGjY0CwgGLgFWSeycP5voWlt2wAFJK/Sy9NYgQeBFVVXkzvFdND+rxsNfAmr+zs
         lhZZsBBV4qwSTKn1V+16V8i+KBvAH8ovO/7Yb2JJ7EZWOkOWCxi4wL1BOhItJBXbTh
         1Ouc8+ug8ZJkw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3F36432C0;
        Thu,  2 Aug 2018 00:08:52 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Thu, 2 Aug 2018 00:08:51 -0700
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Thu,
 2 Aug 2018 09:08:49 +0200
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: Improve handling of fatal signals in
 do_page_fault()
Thread-Topic: [PATCH] ARC: Improve handling of fatal signals in
 do_page_fault()
Thread-Index: AQHUD9XQgYH1u9RF+UG15MGoFlKsxaSrYFwAgAC9wYA=
Date:   Thu, 2 Aug 2018 07:08:49 +0000
Message-ID: <3760e66a23a8ec1c1eb4ad0aaaed06c9d31a3f4f.camel@synopsys.com>
References: <20180629182005.10243-1-abrodkin@synopsys.com>
         <432f2efe-e7cd-7bf1-40f5-f35f8954f224@synopsys.com>
In-Reply-To: <432f2efe-e7cd-7bf1-40f5-f35f8954f224@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8446AF2636A35C4FA402C10FA50EC595@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmluZWV0LA0KDQpPbiBXZWQsIDIwMTgtMDgtMDEgYXQgMTI6NDkgLTA3MDAsIFZpbmVldCBH
dXB0YSB3cm90ZToNCj4gSGkgQWxleGV5LA0KPiANCj4gSSB3YXMgZmluYWxseSBmb3JjZWQgdG8g
cmV2aXNpdCB0aGlzIGZvciBteSBnbGliYyB0c3QtdGxzMy1tYWxsb2MgZGVhZGxvY2suIEFuZA0K
PiBpbmRlZWQgd2l0aCB0aGlzIGNoYW5nZSB3ZSBkb24ndHNlZSB0aGUgZGVhZGxvY2suIEJ1dCBz
ZWUgYmVsb3cuLg0KPiANCj4gDQo+ID4gQEAgLTEzOSwxMiArMTM5LDE2IEBAIHZvaWQgZG9fcGFn
ZV9mYXVsdCh1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiA+
ICAJICovDQo+ID4gIAlmYXVsdCA9IGhhbmRsZV9tbV9mYXVsdCh2bWEsIGFkZHJlc3MsIGZsYWdz
KTsNCj4gPiAgDQo+ID4gLQkvKiBJZiBQYWdlZmF1bHQgd2FzIGludGVycnVwdGVkIGJ5IFNJR0tJ
TEwsIGV4aXQgcGFnZSBmYXVsdCAiZWFybHkiICovDQo+ID4gKwkvKiBJZiB3ZSBuZWVkIHRvIHJl
dHJ5IGJ1dCBhIGZhdGFsIHNpZ25hbCBpcyBwZW5kaW5nLCBoYW5kbGUgdGhlDQo+ID4gKwkgKiBz
aWduYWwgZmlyc3QuIFdlIGRvIG5vdCBuZWVkIHRvIHJlbGVhc2UgdGhlIG1tYXBfc2VtIGJlY2F1
c2UNCj4gPiArCSAqIGl0IHdvdWxkIGFscmVhZHkgYmUgcmVsZWFzZWQgaW4gX19sb2NrX3BhZ2Vf
b3JfcmV0cnkgaW4NCj4gPiArCSAqIG1tL2ZpbGVtYXAuYy4gKi8NCj4gDQo+IFJpZ2h0IGFuZCB3
ZSB3ZXJlIGFscmVhZHkgZG9pbmcgdGhhdDogdXBfcmVhZCgpIHdhcyBjYWxsZWQgZm9yICFWTV9G
QVVMVF9SRVRSWQ0KPiBtZWFuaW5nIHdlIHJlbGllZCBvbiB0aGUgY29yZSBtbSB0byBkbyB0aGF0
IGFscmVhZHkgZm9yIFZNX0ZBVUxUX1JFVFJZIGNhc2UuDQo+IA0KPiBUaGUgaXNzdWUgaGVyZSB3
YXMgYWRkaXRpb25hbCBjaGVjayBmb3IgVk1fRkFVTFRfRVJST1IuIFR5cGljYWxseSB0aGlzIGlz
IG5vdCBzZXQNCj4gYnkgaGFuZGxlX21tX2ZhdWx0KCkgbWVhbmluZyBmb3IgY29tbW9uIHVzZXIg
ZmF1bHRzIHdpdGggc2lnbmFsIHBlbmRpbmcsIHdlIHdlcmUNCj4gbm90IGNhbGxpbmcgdXBfcmVh
ZCwgaGVuY2UgdGhlIGVuc3VpbmcgZGVhZGxvY2suDQoNClJpZ2h0Lg0KDQo+ID4gIAlpZiAodW5s
aWtlbHkoZmF0YWxfc2lnbmFsX3BlbmRpbmcoY3VycmVudCkpKSB7DQo+ID4gLQkJaWYgKChmYXVs
dCAmIFZNX0ZBVUxUX0VSUk9SKSAmJiAhKGZhdWx0ICYgVk1fRkFVTFRfUkVUUlkpKQ0KPiA+IC0J
CQl1cF9yZWFkKCZtbS0+bW1hcF9zZW0pOw0KPiA+IC0JCWlmICh1c2VyX21vZGUocmVncykpDQo+
ID4gKwkJaWYgKGZhdWx0ICYgVk1fRkFVTFRfUkVUUlkpIHsNCj4gPiArCQkJaWYgKCF1c2VyX21v
ZGUocmVncykpDQo+ID4gKwkJCQlnb3RvIG5vX2NvbnRleHQ7DQo+IA0KPiBHaXZlbiB0aGlzIGNv
ZGUgaXMgcmVhbGx5IHRyaWNreSwgbGV0cyBvbmx5IHNvbHZlIG9uZSBwcm9ibGVtIHdpdGggMSBv
bmUgcGF0Y2guDQoNCkFncmVlLg0KDQo+ID4gIAkJCXJldHVybjsNCj4gPiArCQl9DQo+ID4gIAl9
DQo+IA0KPiBUaGUgZmF1bHQgaGFuZGxpbmcgaXMgc3BhZ2hldHRpIG1lc3Mgb2YgY2hlY2tzIGFu
ZCBtb3JlIGNoZWNrcyBhbmQgaGFzIG5vdCByZWFsbHkNCj4gYmVlbiB0b3VjaGVkIHNpbmNlIHVw
c3RyZWFtaW5nLiBJIG5lZWQgdG8gY2xlYW4gaXQgdXAgYW5kIGVzc2VudGlhbGx5IHJld3JpdGUg
aXQNCj4gZm9yIHY0LjE5DQoNClNvIHdvdWxkIHlvdSBsaWtlIG1lIHRvIHNlbmQgYSByZS1zcGlu
IHdpdGggbGVzcyBjaGFuZ2VzIGFzIGRpc2N1c3NlZCBhYm92ZSBzbw0Kd2UgaGF2ZSBzb21ldGhp
bmcgYmV0dGVyIGZvciBub3cgYW5kIGZvciBiYWNrLXBvcnRpbmcgdG8gc3RhYmxlIGJyYW5jaGVz
Lg0KDQpPciB5b3UncmUgZ29pbmcgdG8gcmV3cml0ZSBhbGwgdGhhdCBzb21ldGltZSBzb29uIHlv
dXJzZWxmPw0KDQotQWxleGV5DQo=
