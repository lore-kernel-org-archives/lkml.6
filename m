Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F82C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0C42086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0C42086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeK1XPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:15:01 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:38334 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeK1XPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:15:01 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 5359A67A7D5;
        Wed, 28 Nov 2018 13:13:32 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 28 Nov
 2018 13:13:31 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 28 Nov 2018 13:13:31 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peron.clem@gmail.com" <peron.clem@gmail.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: [PATCH] mtd: spinand: Fix ECC status and OOB layout for Toshiba
 TC58CVG2S0H
Thread-Topic: [PATCH] mtd: spinand: Fix ECC status and OOB layout for Toshiba
 TC58CVG2S0H
Thread-Index: AQHUhxPHoTk0prcI30yUlMgbpRnUbA==
Date:   Wed, 28 Nov 2018 12:13:31 +0000
Message-ID: <1543407135-20862-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0F5D3CDE8FFD41A5A063EBB0A6A273@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 5359A67A7D5.AD4D7
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com,
        peron.clem@gmail.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiByZWFkaW5nIHRoZSBzdGF0dXMgb2YgdGhlIG9uLWNoaXAgRUNDLCB0aGUgVG9zaGliYSBj
aGlwIHJldHVybnMNCnR3byBkaWZmZXJlbnQgc3RhdGVzIGZvciByZXBvcnRpbmcgY29ycmVjdGVk
IGJpdGZsaXBzLiBXZSBzaG91bGQgY2hlY2sNCmZvciBib3RoIG9mIHRoZW0uDQoNCkFsc28gdGhl
IGRhdGFzaGVldCBjbGFpbXMgdGhhdCB0aGUgRUNDIGJ5dGVzIGluIE9PQiBzaG91bGQgbm90IGJl
DQphY2Nlc3NlZCBhdCBhbGwsIHNvIGxldCdzIGFsc28gYXZvaWQgYW55IHJlYWQgb3BlcmF0aW9u
cyBvbiB0aGVtLg0KDQpPbmUgbW9yZSBtaW5vciBvcHRpbWl6YXRpb24gaXMgdG8gcmV0dXJuIHRo
ZSBmcmVlIE9PQiBieXRlcyBhcyBvbmUNCmNvbnRpbnVvdXMgYXJlYSwgaW5zdGVhZCBvZiBtdWx0
aXBsZSBzZWN0aW9ucy4NCg0KU3VnZ2VzdGVkLWJ5OiBDbMOpbWVudCBQw6lyb24gPHBlcm9uLmNs
ZW1AZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5z
Y2hyZW1wZkBrb250cm9uLmRlPg0KLS0tDQogZHJpdmVycy9tdGQvbmFuZC9zcGkvdG9zaGliYS5j
IHwgMTggKysrKysrLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KSwgMTIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3NwaS90
b3NoaWJhLmMgYi9kcml2ZXJzL210ZC9uYW5kL3NwaS90b3NoaWJhLmMNCmluZGV4IDI5NGJjZjYu
LjkwNDBhYTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL210ZC9uYW5kL3NwaS90b3NoaWJhLmMNCisr
KyBiL2RyaXZlcnMvbXRkL25hbmQvc3BpL3Rvc2hpYmEuYw0KQEAgLTExLDYgKzExLDcgQEANCiAj
aW5jbHVkZSA8bGludXgvbXRkL3NwaW5hbmQuaD4NCiANCiAjZGVmaW5lIFNQSU5BTkRfTUZSX1RP
U0hJQkEJCTB4OTgNCisjZGVmaW5lIFRPU0hfU1RBVFVTX0VDQ19IQVNfQklURkxJUFNfVAkoMyA8
PCA0KQ0KIA0KIHN0YXRpYyBTUElOQU5EX09QX1ZBUklBTlRTKHJlYWRfY2FjaGVfdmFyaWFudHMs
DQogCQlTUElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1g0X09QKDAsIDEsIE5VTEwsIDApLA0K
QEAgLTI3LDI1ICsyOCwxNyBAQCBzdGF0aWMgU1BJTkFORF9PUF9WQVJJQU5UUyh1cGRhdGVfY2Fj
aGVfdmFyaWFudHMsDQogc3RhdGljIGludCB0YzU4Y3ZnMnMwaF9vb2JsYXlvdXRfZWNjKHN0cnVj
dCBtdGRfaW5mbyAqbXRkLCBpbnQgc2VjdGlvbiwNCiAJCQkJICAgICBzdHJ1Y3QgbXRkX29vYl9y
ZWdpb24gKnJlZ2lvbikNCiB7DQotCWlmIChzZWN0aW9uID4gNykNCi0JCXJldHVybiAtRVJBTkdF
Ow0KLQ0KLQlyZWdpb24tPm9mZnNldCA9IDEyOCArIDE2ICogc2VjdGlvbjsNCi0JcmVnaW9uLT5s
ZW5ndGggPSAxNjsNCi0NCi0NCi0JcmV0dXJuIDA7DQorCXJldHVybiAtRVJBTkdFOw0KIH0NCiAN
CiBzdGF0aWMgaW50IHRjNThjdmcyczBoX29vYmxheW91dF9mcmVlKHN0cnVjdCBtdGRfaW5mbyAq
bXRkLCBpbnQgc2VjdGlvbiwNCiAJCQkJICAgICAgc3RydWN0IG10ZF9vb2JfcmVnaW9uICpyZWdp
b24pDQogew0KLQlpZiAoc2VjdGlvbiA+IDcpDQorCWlmIChzZWN0aW9uID4gMCkNCiAJCXJldHVy
biAtRVJBTkdFOw0KIA0KLQlyZWdpb24tPm9mZnNldCA9IDIgKyAxNiAqIHNlY3Rpb247DQotCXJl
Z2lvbi0+bGVuZ3RoID0gMTQ7DQotDQorCXJlZ2lvbi0+b2Zmc2V0ID0gMjsNCisJcmVnaW9uLT5s
ZW5ndGggPSAxMjY7DQogDQogCXJldHVybiAwOw0KIH0NCkBAIC03MCw2ICs2Myw3IEBAIHN0YXRp
YyBpbnQgdGM1OGN2ZzJzMGhfZWNjX2dldF9zdGF0dXMoc3RydWN0IHNwaW5hbmRfZGV2aWNlICpz
cGluYW5kLA0KIAkJcmV0dXJuIC1FQkFETVNHOw0KIA0KIAljYXNlIFNUQVRVU19FQ0NfSEFTX0JJ
VEZMSVBTOg0KKwljYXNlIFRPU0hfU1RBVFVTX0VDQ19IQVNfQklURkxJUFNfVDoNCiAJCS8qDQog
CQkgKiBMZXQncyB0cnkgdG8gcmV0cmlldmUgdGhlIHJlYWwgbWF4aW11bSBudW1iZXIgb2YgYml0
ZmxpcHMNCiAJCSAqIGluIG9yZGVyIHRvIGF2b2lkIGZvcmNpbmcgdGhlIHdlYXItbGV2ZWxpbmcg
bGF5ZXIgdG8gbW92ZQ0KLS0gDQoyLjcuNA0K
