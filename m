Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7A5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D213521533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="a8fYBTHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D213521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbeIZXRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:17:43 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:19683 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728926AbeIZXRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1537981413; x=1569517413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5madhtq3st5+ejyyYCOEXsIdMLQ9SUAE0O0VbUnLkbI=;
  b=a8fYBTHAXL3eL1fX/wP2BTJ6Syu3ceZQy4zD1YAwJ9ClgFG7CTy3HgK+
   TrKyo1cnbgaBILPi0+PYsBDK0IS+P5qdZJlae7YR+RscKfUosf4CYAlit
   VdatyDxkYYw1R7mRQzhgWOH+HPwry/77H/LZaOydgaCDCqFSPRtwgd/Vr
   4=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FwAAD+uqtbhyeV50NbHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUYJzfygKg2qIFV+LUoINgz2TEoE/OwsjC4Q+AheDZyE0GAEDAQECAQE?=
 =?us-ascii?q?CAQECEAEBAQoLCQgpIwyCNSINBEs7MAEBAQEBAQEBAQEBAQEBARoCDWMBAQE?=
 =?us-ascii?q?BAgESERFFEAIBCBgCAiYCAgJFEAIEDgUIGoJ/AYF5CA+ZAolXAQEBbYEuhCs?=
 =?us-ascii?q?BhWQFgQuJcIIXgRKCFH6DGwICGIEQgQSCNIJXAog2CIZ5jVAHAoZDiWIfjzS?=
 =?us-ascii?q?Le4hvAgQCBAUCFIFCgg5wgzyCM4NPhRSFPm8BinqBLoEeAQE?=
X-IPAS-Result: =?us-ascii?q?A2FwAAD+uqtbhyeV50NbHAEBAQQBAQcEAQGBUYJzfygKg?=
 =?us-ascii?q?2qIFV+LUoINgz2TEoE/OwsjC4Q+AheDZyE0GAEDAQECAQECAQECEAEBAQoLC?=
 =?us-ascii?q?QgpIwyCNSINBEs7MAEBAQEBAQEBAQEBAQEBARoCDWMBAQEBAgESERFFEAIBC?=
 =?us-ascii?q?BgCAiYCAgJFEAIEDgUIGoJ/AYF5CA+ZAolXAQEBbYEuhCsBhWQFgQuJcIIXg?=
 =?us-ascii?q?RKCFH6DGwICGIEQgQSCNIJXAog2CIZ5jVAHAoZDiWIfjzSLe4hvAgQCBAUCF?=
 =?us-ascii?q?IFCgg5wgzyCM4NPhRSFPm8BinqBLoEeAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2018 12:03:32 -0500
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QH3CqK001835;
        Wed, 26 Sep 2018 13:03:48 -0400
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
        by mx0b-00154901.pphosted.com with ESMTP id 2mrbqygyqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 13:03:48 -0400
From:   <Mario.Limonciello@dell.com>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2018 23:03:39 +0600
X-LoopCount0: from 10.166.132.169
X-IronPort-AV: E=Sophos;i="5.54,307,1534827600"; 
   d="scan'208";a="298046170"
To:     <andy.shevchenko@gmail.com>
CC:     <dvhart@infradead.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mika.westerberg@intel.com>
Subject: RE: [PATCH] platform/x86: intel-wmi-thunderbolt: Add dynamic
 debugging
Thread-Topic: [PATCH] platform/x86: intel-wmi-thunderbolt: Add dynamic
 debugging
Thread-Index: AQHUVbOGMxR5CBms5k66u9Z7xuD6/6UDHdeA//+sXTA=
Date:   Wed, 26 Sep 2018 17:03:45 +0000
Message-ID: <72af799dd45442e6bd35082e1579013a@ausx13mpc120.AMER.DELL.COM>
References: <1537978258-2907-1-git-send-email-mario.limonciello@dell.com>
 <CAHp75VeGQTEZOrMbNsbsxSb4RcN1y=gAZuZ5Z6FawuU-e0+qcg@mail.gmail.com>
In-Reply-To: <CAHp75VeGQTEZOrMbNsbsxSb4RcN1y=gAZuZ5Z6FawuU-e0+qcg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gV2VkLCBTZXAgMjYsIDIwMTggYXQgNzoxMSBQTSBNYXJpbyBMaW1vbmNpZWxsbw0K
PiA8bWFyaW8ubGltb25jaWVsbG9AZGVsbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gU29tZSB1c2Vy
cyBoYXZlIGJlZW4gcmVwb3J0aW5nIGlzc3VlcyB3aXRoIHRodW5kZXJib2x0IGJlaW5nIHR1cm5l
ZCBvZmYNCj4gPiBiZWZvcmUgZnVsbHkgaW5pdGlhbGl6ZWQuICBUaGlzIGlzIHN1c3BlY3RlZCB0
byBiZSBjYXVzZWQgYnkgdXNlcnNwYWNlDQo+ID4gdHVybmluZyBvZmYgdGhlIFRodW5kZXJib2x0
IGNvbnRyb2xsZXIgdXNpbmcgaW50ZWwtd21pLXRodW5kZXJib2x0DQo+ID4gcHJlbWF0dXJlbHku
DQo+ID4NCj4gDQo+ID4gRGV0YWlscyBhcmUgYXZhaWxhYmxlIGhlcmU6DQo+ID4gaHR0cHM6Ly9i
dWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDEyMjcNCj4gPiBodHRwczovL2J1
Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5OTYzMQ0KPiANCj4gQnVnTGluazog
Li4uID8NCj4gQnVnTGluazogLi4uID8NCj4gDQo+IEkgY2FuIGRvIGl0IG15c2VsZiBpZiB5b3Ug
YXJlIG9rYXkgd2l0aCB0aGlzIGZvcm1hdC4NCj4gDQo+IFRoZSBwYXRjaCBpdHNlbGYgTEdUTS4N
Cg0KU3VyZSwgdGhhbmsgeW91Lg0KDQo+IA0KPiA+DQo+ID4gVXNlcnNwYWNlIGhhcyBhbHJlYWR5
IG1hZGUgc29tZSBtaXRpZ2lhdGlvbnMgZm9yIHRoaXMgc2l0dWF0aW9uOg0KPiA+IGh0dHBzOi8v
Z2l0aHViLmNvbS9odWdoc2llL2Z3dXBkL2NvbW1pdC9lZjZmMWQ3Njk4M2M5YjY2DQo+ID4gaHR0
cHM6Ly9naXRodWIuY29tL2h1Z2hzaWUvZnd1cGQvY29tbWl0L2MwN2NlNWI0ODg5YTUzODQNCj4g
Pg0KPiA+IFRvIGFsbG93IGVhc2llciBkZWJ1Z2dpbmcgb2YgdGhpcyBzaXR1YXRpb24gYWRkIG91
dHB1dCB0aGF0IGNhbiBiZSB0dXJuZWQNCj4gPiBvbiB3aXRoIGR5bmFtaWMgZGVidWdnaW5nIHRv
IGJldHRlciByb290IGNhdXNlIHRoaXMgcHJvYmxlbS4NCj4gPg0KPiA+IFN1Z2dlc3RlZC1ieTog
TWlrYSBXZXN0ZXJiZXJnIDxtaWthLndlc3RlcmJlcmdAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BkZWxsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwtd21pLXRodW5kZXJib2x0LmMg
fCA2ICsrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwt
d21pLXRodW5kZXJib2x0LmMNCj4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC13bWktdGh1
bmRlcmJvbHQuYw0KPiA+IGluZGV4IGMyMjU3YmQuLmNlNWZiZjAgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwtd21pLXRodW5kZXJib2x0LmMNCj4gPiArKysgYi9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC13bWktdGh1bmRlcmJvbHQuYw0KPiA+IEBAIC0zOCwx
MiArMzgsMTYgQEAgc3RhdGljIHNzaXplX3QgZm9yY2VfcG93ZXJfc3RvcmUoc3RydWN0IGRldmlj
ZSAqZGV2LA0KPiA+ICAgICAgICAgaW5wdXQubGVuZ3RoID0gc2l6ZW9mKHU4KTsNCj4gPiAgICAg
ICAgIGlucHV0LnBvaW50ZXIgPSAmbW9kZTsNCj4gPiAgICAgICAgIG1vZGUgPSBoZXhfdG9fYmlu
KGJ1ZlswXSk7DQo+ID4gKyAgICAgICBkZXZfZGJnKGRldiwgImZvcmNlX3Bvd2VyOiBzdG9yaW5n
ICUjeFxuIiwgbW9kZSk7DQo+ID4gICAgICAgICBpZiAobW9kZSA9PSAwIHx8IG1vZGUgPT0gMSkg
ew0KPiA+ICAgICAgICAgICAgICAgICBzdGF0dXMgPSB3bWlfZXZhbHVhdGVfbWV0aG9kKElOVEVM
X1dNSV9USFVOREVSQk9MVF9HVUlELCAwLCAxLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZpbnB1dCwgTlVMTCk7DQo+ID4gLSAgICAgICAgICAgICAg
IGlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkNCj4gPiArICAgICAgICAgICAgICAgaWYgKEFDUElf
RkFJTFVSRShzdGF0dXMpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2RiZyhk
ZXYsICJmb3JjZV9wb3dlcjogZmFpbGVkIHRvIGV2YWx1YXRlIEFDUEkgbWV0aG9kXG4iKTsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gPiArICAgICAgICAg
ICAgICAgfQ0KPiA+ICAgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2X2Ri
ZyhkZXYsICJmb3JjZV9wb3dlcjogdW5zdXBwb3J0ZWQgbW9kZVxuIik7DQo+ID4gICAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+ICAgICAgICAgfQ0KPiA+ICAgICAgICAgcmV0dXJu
IGNvdW50Ow0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0KPiANCj4gDQo+IC0tDQo+IFdpdGggQmVz
dCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCg==
