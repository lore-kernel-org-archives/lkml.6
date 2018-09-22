Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139A8ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0F22154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dlp+5eFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0F22154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeIVNAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:00:36 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41574 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbeIVNAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:00:35 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8M74jOB031020;
        Sat, 22 Sep 2018 00:08:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=NzNNN4h5i/q39sgN+ouGSYnhX5Uk0Xa06agtAMIe93A=;
 b=dlp+5eFGNppHbUKUxrcDXc4VBFwj73g4ddMTi6OBlcqeffDdXuRtwN52kiedUuKPTwcO
 uiEFRdu8SVxxBRFpkctNu30hWTnJ1knAOip1vbeboxlFQt0jzVFbjcG1s2SMianq2BAQ
 GzIrP7DrN1w2mQ0m/f9EPvgwLiSnBGfOAgtwWCQho2shz18zpnpBwjiJAGt9p2LvBKiy
 H3qtZa+5o6C4jEfxSkX8v6Ti5DDLGTBFdT4F2+pPrHTE9CMQ+i0u/Sw5d4vQE8Qs8cKy
 3QsiZhPkf+1Lqe6ynGZkGHhtquCT1os+bpDEc347jJ5L8iI5CfKy+r5Vcl3Zao5O0dbj 1A== 
Received: from il-exch01.marvell.com ([199.203.130.101])
        by mx0b-0016f401.pphosted.com with ESMTP id 2mn2q6ja5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 22 Sep 2018 00:08:01 -0700
Received: from IL-EXCH01.marvell.com (10.4.102.220) by IL-EXCH01.marvell.com
 (10.4.102.220) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Sat, 22 Sep
 2018 10:07:58 +0300
Received: from IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36]) by
 IL-EXCH01.marvell.com ([fe80::5d63:81cd:31e2:fc36%20]) with mapi id
 15.00.1210.000; Sat, 22 Sep 2018 10:07:58 +0300
From:   Yelena Krivosheev <yelena@marvell.com>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        "Stefan Chulski" <stefanc@marvell.com>,
        Yan Markman <ymarkman@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [EXT] [PATCH net] net: mvneta: fix the Rx desc buffer DMA
 unmapping
Thread-Topic: [EXT] [PATCH net] net: mvneta: fix the Rx desc buffer DMA
 unmapping
Thread-Index: AQHUUPKZKMnLakvV5UmL1EQUhBy92qT74alg
Date:   Sat, 22 Sep 2018 07:07:57 +0000
Message-ID: <92138f5d3c8548f4ad9637cd0736139d@IL-EXCH01.marvell.com>
References: <20180919132906.26868-1-antoine.tenart@bootlin.com>
        <5ab58500e78549618b597fdc2e54356a@IL-EXCH01.marvell.com>
        <20180920112010.GB1158@kwain> <87k1ngjjtd.fsf@bootlin.com>
In-Reply-To: <87k1ngjjtd.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [199.203.130.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-22_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809220074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZ29yeS4NCg0KSSB3YW50IHRvIGNsYXJpZnkgc3RhdGljIG12bmV0YV9yeHFfZHJvcF9w
a3RzKCk6DQoNCnN0YXRpYyB2b2lkIG12bmV0YV9yeHFfZHJvcF9wa3RzKHN0cnVjdCBtdm5ldGFf
cG9ydCAqcHAsDQoJCQkJIHN0cnVjdCBtdm5ldGFfcnhfcXVldWUgKnJ4cSkNCnsNCglpbnQgcnhf
ZG9uZSwgaTsNCg0KCXJ4X2RvbmUgPSBtdm5ldGFfcnhxX2J1c3lfZGVzY19udW1fZ2V0KHBwLCBy
eHEpOw0KCWlmIChyeF9kb25lKQ0KCQltdm5ldGFfcnhxX2Rlc2NfbnVtX3VwZGF0ZShwcCwgcnhx
LCByeF9kb25lLCByeF9kb25lKTsNCg0KCWlmIChwcC0+Ym1fcHJpdikgeyA8LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSB0aGlzIGlzIGNhc2UgZm9yIEhXQk0NCgkJZm9yIChpID0gMDsgaSA8
IHJ4X2RvbmU7IGkrKykgew0KCQkJc3RydWN0IG12bmV0YV9yeF9kZXNjICpyeF9kZXNjID0NCgkJ
CQkJCSAgbXZuZXRhX3J4cV9uZXh0X2Rlc2NfZ2V0KHJ4cSk7DQoJCQl1OCBwb29sX2lkID0gTVZO
RVRBX1JYX0dFVF9CTV9QT09MX0lEKHJ4X2Rlc2MpOw0KCQkJc3RydWN0IG12bmV0YV9ibV9wb29s
ICpibV9wb29sOw0KDQoJCQlibV9wb29sID0gJnBwLT5ibV9wcml2LT5ibV9wb29sc1twb29sX2lk
XTsNCgkJCS8qIFJldHVybiBkcm9wcGVkIGJ1ZmZlciB0byB0aGUgcG9vbCAqLw0KCQkJbXZuZXRh
X2JtX3Bvb2xfcHV0X2JwKHBwLT5ibV9wcml2LCBibV9wb29sLA0KCQkJCQkgICAgICByeF9kZXNj
LT5idWZfcGh5c19hZGRyKTsNCgkJfQ0KCQlyZXR1cm47DQoJfQ0KDQo8LS0tLS0tLS0gdGhpcyBp
cyBjYXNlIGZvciBTV0JNIG9ubHkNCglmb3IgKGkgPSAwOyBpIDwgcnhxLT5zaXplOyBpKyspIHsN
CgkJc3RydWN0IG12bmV0YV9yeF9kZXNjICpyeF9kZXNjID0gcnhxLT5kZXNjcyArIGk7DQoJCXZv
aWQgKmRhdGEgPSByeHEtPmJ1Zl92aXJ0X2FkZHJbaV07DQoNCgkJaWYgKCFkYXRhIHx8ICEocnhf
ZGVzYy0+YnVmX3BoeXNfYWRkcikpDQoJCQljb250aW51ZTsNCgkJZG1hX3VubWFwX3NpbmdsZShw
cC0+ZGV2LT5kZXYucGFyZW50LCByeF9kZXNjLT5idWZfcGh5c19hZGRyLA0KCQkJCSBNVk5FVEFf
UlhfQlVGX1NJWkUocHAtPnBrdF9zaXplKSwgRE1BX0ZST01fREVWSUNFKTsNCgkJX19mcmVlX3Bh
Z2UoZGF0YSk7DQoJfQ0KfQ0KDQpTbyBJIHN1Z2dlc3QgdG8gZml4IGRtYV91bm1hcF9zaW5nbGUo
KSBjYWxsIHRvby4NCg0KVGhhbmtzLg0KWWVsZW5hDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEdyZWdvcnkgQ0xFTUVOVCBbbWFpbHRvOmdyZWdvcnkuY2xlbWVudEBib290
bGluLmNvbV0gDQpTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDIwLCAyMDE4IDY6MDAgUE0NClRv
OiBBbnRvaW5lIFRlbmFydCA8YW50b2luZS50ZW5hcnRAYm9vdGxpbi5jb20+DQpDYzogWWVsZW5h
IEtyaXZvc2hlZXYgPHllbGVuYUBtYXJ2ZWxsLmNvbT47IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHRob21h
cy5wZXRhenpvbmlAYm9vdGxpbi5jb207IG1heGltZS5jaGV2YWxsaWVyQGJvb3RsaW4uY29tOyBt
aXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOyBOYWRhdiBIYWtsYWkgPG5hZGF2aEBtYXJ2ZWxsLmNv
bT47IFN0ZWZhbiBDaHVsc2tpIDxzdGVmYW5jQG1hcnZlbGwuY29tPjsgWWFuIE1hcmttYW4gPHlt
YXJrbWFuQG1hcnZlbGwuY29tPjsgbXdAc2VtaWhhbGYuY29tDQpTdWJqZWN0OiBSZTogW0VYVF0g
W1BBVENIIG5ldF0gbmV0OiBtdm5ldGE6IGZpeCB0aGUgUnggZGVzYyBidWZmZXIgRE1BIHVubWFw
cGluZw0KDQpIaSBBbnRvaW5lLA0KIA0KIE9uIGpldS4sIHNlcHQuIDIwIDIwMTgsIEFudG9pbmUg
VGVuYXJ0IDxhbnRvaW5lLnRlbmFydEBib290bGluLmNvbT4gd3JvdGU6DQoNCj4gSGkgWWVsZW5h
LA0KPg0KPiBPbiBUaHUsIFNlcCAyMCwgMjAxOCBhdCAxMDoxNDo1NkFNICswMDAwLCBZZWxlbmEg
S3Jpdm9zaGVldiB3cm90ZToNCj4+IA0KPj4gUGxlYXNlLCBjaGVjayBhbmQgZml4IGFsbCBjYXNl
cyBvZiBkbWFfdW5tYXBfc2luZ2xlKCkgdXNhZ2UuDQo+PiBTZWUgbXZuZXRhX3J4cV9kcm9wX3Br
dHMoKQ0KPj4gLi4uDQo+PiAJCWlmICghZGF0YSB8fCAhKHJ4X2Rlc2MtPmJ1Zl9waHlzX2FkZHIp
KQ0KPj4gCQkJY29udGludWU7DQo+PiAJCWRtYV91bm1hcF9zaW5nbGUocHAtPmRldi0+ZGV2LnBh
cmVudCwgcnhfZGVzYy0+YnVmX3BoeXNfYWRkciwNCj4+IAkJCQkgTVZORVRBX1JYX0JVRl9TSVpF
KHBwLT5wa3Rfc2l6ZSksIERNQV9GUk9NX0RFVklDRSk7DQo+PiAJCV9fZnJlZV9wYWdlKGRhdGEp
Ow0KPj4gLi4uDQo+DQo+IEkgaGFkIGEgbG9vayBhdCB0aGUgb25lIHJlcG9ydGVkIGJ5IENPTkZJ
R19ETUFfQVBJX0RFQlVHLCBhbmQgYXQgRE1BIA0KPiB1bm1hcHBpbmcgY2FsbHMgdXNpbmcgUEFH
RV9TSVpFLiBBcyB5b3UgcG9pbnRlZCBvdXQgdGhlcmUgbWlnaHQgYmUgDQo+IG90aGVycyBwYXJ0
cywgdGhhbmtzIQ0KDQpBY3R1YWxseSBKaXNoZW5nIGhhZCBzdWJtaXR0ZWQgYSBzaW1pbGFyIHBh
dGNoIGZldyB3ZWVrcyBhZ28gYW5kIGFzIEkgcG9pbnRlZCBhdCB0aGlzIHRpbWUsIHRoZSBkbWFf
dW5tYXAgaW4gbXZuZXRhX3J4cV9kcm9wX3BrdHMgY2FuIGJlIGNhbGxlZCB3aGVuIHRoZSBhbGxv
Y2F0aW9uIGlzIGRvbmUgaW4gd2l0aCBIV0JNIGluIHRoaXMgY2FzZSB3aGljaCB1c2UgYSBkbWFf
bWFwX3NpbmdsZS4NCg0KSSB0aG91Z2ggdGhhdCBpbiB0aGlzIGNhc2UgdXNpbmcgZG1hX21hcF9z
aW5nbGUgaXMgdGhlIHRoaW5ncyB0byBkbyBldmVuIGlmIGluIHRoZSBTV0JNIGNhc2UgaXQgaXMg
bGVzcyBvcHRpbWFsLg0KDQpHcmVnb3J5DQoNCj4NCj4gQW50b2luZQ0KPg0KPiAtLQ0KPiBBbnRv
aW5lIFTDqW5hcnQsIEJvb3RsaW4NCj4gRW1iZWRkZWQgTGludXggYW5kIEtlcm5lbCBlbmdpbmVl
cmluZw0KPiBodHRwczovL2Jvb3RsaW4uY29tDQoNCi0tDQpHcmVnb3J5IENsZW1lbnQsIEJvb3Rs
aW4NCkVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCmh0dHA6Ly9ib290bGlu
LmNvbQ0K
