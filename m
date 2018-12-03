Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04BDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3572081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3572081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeLCIBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:01:46 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:53704 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeLCIBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:01:45 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 2748167A075;
        Mon,  3 Dec 2018 09:01:39 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 3 Dec 2018
 09:01:38 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Mon, 3 Dec 2018 09:01:38 +0100
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
Subject: [PATCH v3] mtd: spinand: Fix ECC status and OOB layout for Toshiba
 TC58CVG2S0H
Thread-Topic: [PATCH v3] mtd: spinand: Fix ECC status and OOB layout for
 Toshiba TC58CVG2S0H
Thread-Index: AQHUit5r+i/3AIRP0kKtRCmx1SJH2g==
Date:   Mon, 3 Dec 2018 08:01:38 +0000
Message-ID: <1543823821-18352-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2B1428231F9AA429728BE8353C832C6@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 2748167A075.AC741
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

RnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KDQpX
aGVuIHJlYWRpbmcgdGhlIHN0YXR1cyBvZiB0aGUgb24tY2hpcCBFQ0MsIHRoZSBUb3NoaWJhIGNo
aXAgcmV0dXJucw0KdHdvIGRpZmZlcmVudCBzdGF0ZXMgZm9yIHJlcG9ydGluZyBjb3JyZWN0ZWQg
Yml0ZmxpcHMuIFdlIHNob3VsZCBjaGVjaw0KZm9yIGJvdGggb2YgdGhlbS4NCg0KQWxzbyByZXR1
cm4gdGhlIGZyZWUgT09CIGJ5dGVzIGFzIG9uZSBjb250aWd1b3VzIGFyZWEsIGluc3RlYWQgb2YN
Cm11bHRpcGxlIHNlY3Rpb25zLg0KDQpTdWdnZXN0ZWQtYnk6IENsw6ltZW50IFDDqXJvbiA8cGVy
b24uY2xlbUBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmll
ZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQpBY2tlZC1ieTogQ2zDqW1lbnQgUMOpcm9uIDxwZXJv
bi5jbGVtQGdtYWlsLmNvbT4NCi0tLQ0KQ2hhbmdlcyBmb3IgdjM6DQo9PT09PT09PT09PT09PT0N
CiogQWRkIEFja2VkLWJ5DQoqIEFkZCBjb21tZW50IGZvciBCQk0gaW4gT09CIGxheW91dA0KDQpD
aGFuZ2VzIGZvciB2MjoNCj09PT09PT09PT09PT09PQ0KKiBSZW1vdmUgdGhlIGNoYW5nZXMgdG8g
dGhlIEVDQyBieXRlcyBpbiB0aGUgT09CIGxheW91dA0KLS0tDQogZHJpdmVycy9tdGQvbmFuZC9z
cGkvdG9zaGliYS5jIHwgMTEgKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9z
cGkvdG9zaGliYS5jIGIvZHJpdmVycy9tdGQvbmFuZC9zcGkvdG9zaGliYS5jDQppbmRleCAyOTRi
Y2Y2Li4wODEyNjU1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9zcGkvdG9zaGliYS5j
DQorKysgYi9kcml2ZXJzL210ZC9uYW5kL3NwaS90b3NoaWJhLmMNCkBAIC0xMSw2ICsxMSw3IEBA
DQogI2luY2x1ZGUgPGxpbnV4L210ZC9zcGluYW5kLmg+DQogDQogI2RlZmluZSBTUElOQU5EX01G
Ul9UT1NISUJBCQkweDk4DQorI2RlZmluZSBUT1NIX1NUQVRVU19FQ0NfSEFTX0JJVEZMSVBTX1QJ
KDMgPDwgNCkNCiANCiBzdGF0aWMgU1BJTkFORF9PUF9WQVJJQU5UUyhyZWFkX2NhY2hlX3Zhcmlh
bnRzLA0KIAkJU1BJTkFORF9QQUdFX1JFQURfRlJPTV9DQUNIRV9YNF9PUCgwLCAxLCBOVUxMLCAw
KSwNCkBAIC0zMywxOSArMzQsMTggQEAgc3RhdGljIGludCB0YzU4Y3ZnMnMwaF9vb2JsYXlvdXRf
ZWNjKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgc2VjdGlvbiwNCiAJcmVnaW9uLT5vZmZzZXQg
PSAxMjggKyAxNiAqIHNlY3Rpb247DQogCXJlZ2lvbi0+bGVuZ3RoID0gMTY7DQogDQotDQogCXJl
dHVybiAwOw0KIH0NCiANCiBzdGF0aWMgaW50IHRjNThjdmcyczBoX29vYmxheW91dF9mcmVlKHN0
cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgc2VjdGlvbiwNCiAJCQkJICAgICAgc3RydWN0IG10ZF9v
b2JfcmVnaW9uICpyZWdpb24pDQogew0KLQlpZiAoc2VjdGlvbiA+IDcpDQorCWlmIChzZWN0aW9u
ID4gMCkNCiAJCXJldHVybiAtRVJBTkdFOw0KIA0KLQlyZWdpb24tPm9mZnNldCA9IDIgKyAxNiAq
IHNlY3Rpb247DQotCXJlZ2lvbi0+bGVuZ3RoID0gMTQ7DQotDQorCS8qIDIgYnl0ZXMgcmVzZXJ2
ZWQgZm9yIEJCTSAqLw0KKwlyZWdpb24tPm9mZnNldCA9IDI7DQorCXJlZ2lvbi0+bGVuZ3RoID0g
MTI2Ow0KIA0KIAlyZXR1cm4gMDsNCiB9DQpAQCAtNzAsNiArNzAsNyBAQCBzdGF0aWMgaW50IHRj
NThjdmcyczBoX2VjY19nZXRfc3RhdHVzKHN0cnVjdCBzcGluYW5kX2RldmljZSAqc3BpbmFuZCwN
CiAJCXJldHVybiAtRUJBRE1TRzsNCiANCiAJY2FzZSBTVEFUVVNfRUNDX0hBU19CSVRGTElQUzoN
CisJY2FzZSBUT1NIX1NUQVRVU19FQ0NfSEFTX0JJVEZMSVBTX1Q6DQogCQkvKg0KIAkJICogTGV0
J3MgdHJ5IHRvIHJldHJpZXZlIHRoZSByZWFsIG1heGltdW0gbnVtYmVyIG9mIGJpdGZsaXBzDQog
CQkgKiBpbiBvcmRlciB0byBhdm9pZCBmb3JjaW5nIHRoZSB3ZWFyLWxldmVsaW5nIGxheWVyIHRv
IG1vdmUNCi0tIA0KMi43LjQNCg==
