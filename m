Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84AFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75912087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="DF2mNsnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfAGQBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:01:54 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:22915 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727049AbfAGQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1546876913; x=1578412913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p4T4/LbLRT6wKVtWvqVtBF2IOumsf99A+yH54MBCk98=;
  b=DF2mNsnqOOlyBwcyrZ542dGW+OD9yS/bYZkB2QnL0a2hJpoAmasz/laH
   ycGtVhZU+52jBQqjCNpyXhR/Gy90qvyKvCgCdGuIOSUUPPLL+9DDDMXeP
   2veZWYUm+H0j21Q0vjnPvUvNDBwTI7mPkW3li8X34dOwuIR2nXdJXHT3U
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FyAABPdzNchyeV50NjGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBZYNsJwqDdYh5iweCDYF9lgaBZwsBAYRsAheBbiI4EgEDAQECAQE?=
 =?us-ascii?q?CAQECEAEBARUJCCkvgjoigm8BAQEBAxIREUUMBAIBCBEEAQEDAiYCAgJFCAg?=
 =?us-ascii?q?CBAENBQgagwCCApoaPQKBbokGAQEBboEviiKBC4s0ghaEI4ROARIBgyeCVwK?=
 =?us-ascii?q?LS5YRBwKRaSCObYMCiWKQNAIEAgQFAhSBXSBncXCDPII1jidAATGIQoEfgR8?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2FyAABPdzNchyeV50NjGwEBAQEDAQEBBwMBAQGBZYNsJ?=
 =?us-ascii?q?wqDdYh5iweCDYF9lgaBZwsBAYRsAheBbiI4EgEDAQECAQECAQECEAEBARUJC?=
 =?us-ascii?q?Ckvgjoigm8BAQEBAxIREUUMBAIBCBEEAQEDAiYCAgJFCAgCBAENBQgagwCCA?=
 =?us-ascii?q?poaPQKBbokGAQEBboEviiKBC4s0ghaEI4ROARIBgyeCVwKLS5YRBwKRaSCOb?=
 =?us-ascii?q?YMCiWKQNAIEAgQFAhSBXSBncXCDPII1jidAATGIQoEfgR8BAQ?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2019 10:01:52 -0600
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x07FrOEm064026;
        Mon, 7 Jan 2019 11:01:52 -0500
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0b-00154901.pphosted.com with ESMTP id 2pv6bfhfbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Jan 2019 11:01:51 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps301.us.dell.com ([143.166.148.223])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Jan 2019 22:01:00 +0600
X-LoopCount0: from 10.166.132.172
X-IronPort-AV: E=Sophos;i="5.56,451,1539666000"; 
   d="scan'208";a="283666527"
To:     <hayeswang@realtek.com>, <mlord@pobox.com>,
        <kai.heng.feng@canonical.com>
CC:     <aatteka@nicira.com>, <davem@davemloft.net>, <greg@kroah.com>,
        <romieu@fr.zoreil.com>, <netdev@vger.kernel.org>,
        <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <ryankao@realtek.com>
Subject: RE: r8152: data corruption in various scenarios
Thread-Topic: r8152: data corruption in various scenarios
Thread-Index: AQHUpfQHALXHc6TickGdZTS3BUtrnaWjIfGAgAAA/gCAAG77gIAAZjZA
Date:   Mon, 7 Jan 2019 16:01:26 +0000
Message-ID: <92e9ddd8a05a493bbb1f5ac4828c2f2a@ausx13mpc120.AMER.DELL.COM>
References: <ed0c9790-57be-8bca-cdd6-3a54ca24f0bd@pobox.com>
 <20161125095350.GA20653@kroah.com>
 <1816ec7e-2733-f4ba-5d30-29dbabd20aad@pobox.com>
 <20161125.115827.2014848246966159357.davem@davemloft.net>
 <0835B3720019904CB8F7AA43166CEEB201057793@RTITMBSV03.realtek.com.tw>
 <CAA=3Oqn5_5w+vrg9_7UtZ-5BEbZ9Pm=qdX3WoVZKaAkxcMXYXA@mail.gmail.com>
 <469a41ea-e97c-23d2-d129-68aad5585fec@pobox.com>
 <3D7273C4-D378-42D5-92FA-4ED72041D820@canonical.com>
 <1726a1ef-cfa7-0f97-4388-bf2ba72cb9a9@pobox.com>
 <31f145b8-4518-122c-eab8-50ed1075ba55@pobox.com>
 <0835B3720019904CB8F7AA43166CEEB2D38781F2@RTITMBSVM03.realtek.com.tw>
In-Reply-To: <0835B3720019904CB8F7AA43166CEEB2D38781F2@RTITMBSVM03.realtek.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=914 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYXllcyBXYW5nIDxoYXllc3dh
bmdAcmVhbHRlay5jb20+DQo+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSA2LCAyMDE5IDk6NTQgUE0N
Cj4gVG86IE1hcmsgTG9yZDsgS2FpIEhlbmcgRmVuZw0KPiBDYzogQW5zaXMgQXR0ZWthOyBEYXZp
ZCBNaWxsZXI7IGdyZWdAa3JvYWguY29tOyByb21pZXVAZnIuem9yZWlsLmNvbTsNCj4gbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgbmljX3N3c2Q7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiB1c2JAdmdlci5rZXJuZWwub3JnOyBMaW1vbmNpZWxsbywgTWFyaW87IFJ5YW5r
YW8NCj4gU3ViamVjdDogUkU6IHI4MTUyOiBkYXRhIGNvcnJ1cHRpb24gaW4gdmFyaW91cyBzY2Vu
YXJpb3MNCj4gDQo+IA0KPiBbRVhURVJOQUwgRU1BSUxdDQo+IA0KPiBNb25kYXksIEphbnVhcnkg
MDcsIDIwMTkgNToxNyBBTQ0KPiBbLi4uXQ0KPiA+PiBUaGlzIGlzIHByb2JhYmx5IGFuIHhIQyBi
dWcuIEEgc2ltaWxhciBpc3N1ZSBpcyBmaXhlZCBieSBjb21taXQgOWRhNWExMDkyYjEzDQo+ID4+
ICgieGhjaTogQmFkIEV0aGVybmV0IHBlcmZvcm1hbmNlIHBsdWdnZWQgaW4gQVNNMTA0MkEgaG9z
dOKAnSkuDQo+ID4+DQo+ID4+PiBJIGp1c3QgZ290IHRoYXQgZXhhY3QgbWVzc2FnZSBhYm92ZSwg
d2l0aCB0aGUgcjgxNTIgaW4gbXkgMS1kYXkgb2xkIFdEMTUgZG9jaywNCj4gPj4+IHdpdGggdGhl
IFRCMTYgIndvcmthcm91bmQiIGVuYWJsZWQgaW4gTGludXgga2VybmVsIDQuMjAuMC4NCj4gPj4N
Cj4gPj4gSXMgdGhlIHhIQyBXRDE1IGNvbm5lY3RlZCBhbiBBU01lZGlhIG9uZT8NCj4gPg0KPiA+
IEkgZG9uJ3Qga25vdy4gIEkgKnRoaW5rKiBpdCBpZGVudGlmaWVzIGFzIGEgRFNMNjM0MCAoc2Vl
IGJlbG93KS4NCj4gPg0KPiANCj4gQWNjb3JkaW5nIHRvIG91ciByZWNvcmQsIGl0IGlzIHJlbGF0
aXZlIHRvIHRoZSBhc21lZGlhLg0KPiANCg0KRFNMNjQzMCBzaG91bGQgYmUgcmVmZXJyaW5nIHRv
IHRoZSBBbHBpbmUgUmlkZ2UgY29udHJvbGxlciBpbiB0aGUgc3lzdGVtLg0KDQpUQjE2IGNvbnRh
aW5zIEFTTWVkaWEgaG9zdCBjb250cm9sbGVyLiAgSXQncyBhIFRodW5kZXJib2x0IGRvY2sgYW5k
IGFsbCBVU0IgZGV2aWNlcw0KYXJlIGNvbm5lY3RlZCB0byBBU01lZGlhIGhvc3QgY29udHJvbGxl
ciBpbiB0aGUgZG9jay4NCg0KV0QxNSBkb2VzIG5vdCBjb250YWluIGFuIEFTTWVkaWEgaG9zdCBj
b250cm9sbGVyLCBpdCBjb25uZWN0ZWQgdG8gc3lzdGVtJ3MNClVTQiBob3N0IGNvbnRyb2xsZXIu
DQo=
