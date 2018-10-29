Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D527C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD702064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 05:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="duhKgdbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD702064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeJ2OIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 10:08:34 -0400
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:19155
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729090AbeJ2OIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 10:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtPGG09DXbt4dK2es0K/3a9Cl6Qu886kkMyfLmuXgkE=;
 b=duhKgdbG+G0K2ksWgaczQJs9ba0ckhL7xgHMVFDOeEkunVHdC+/V1fRUdG++IgtKAC+Idg0bUdrjmaWAo9FqZKlIMOBQICuvP1zzkddf0sUQ6ludbhRfkwXeopyAQrTru83dV47Xz3F+E8PsrD6rwvR6FYuWOW56GXTMUimmejY=
Received: from BYAPR07MB4920.namprd07.prod.outlook.com (52.135.237.93) by
 BYAPR07MB4455.namprd07.prod.outlook.com (52.135.225.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Mon, 29 Oct 2018 05:21:24 +0000
Received: from BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5]) by BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5%4]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 05:21:24 +0000
From:   George Cherian <gcherian@caviumnetworks.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Cherian, George" <George.Cherian@cavium.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Subject: Re: [PATCH] xhci: Add quirk to workaround the errata seen on Cavium
 Thunder-X2 Soc
Thread-Topic: [PATCH] xhci: Add quirk to workaround the errata seen on Cavium
 Thunder-X2 Soc
Thread-Index: AQHUbhvbI9VLVrMJM0yFLaM3hV0WVaU06EmAgADJ54A=
Date:   Mon, 29 Oct 2018 05:21:24 +0000
Message-ID: <364d8916-5630-9662-1f39-fd18f84d1941@caviumnetworks.com>
References: <Pine.LNX.4.44L0.1810281305140.23762-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1810281305140.23762-100000@netrider.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::19)
 To BYAPR07MB4920.namprd07.prod.outlook.com (2603:10b6:a03:55::29)
x-originating-ip: [111.93.218.67]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4455;6:Oj0velDfp7QcEGNPRBc0WoqOZiZKTaBE7f8AaKFtA2De/s1QPjtrUYSYdICeu+GnFRF3HHGKReQ8gah7e2orX51YSkz4GVj145RQZSyv9lwGDFFU0LCdsx3TKs9/qOhBxrelm0sCwxRddWzEcN7PVYhaaha1lUavS2l1ojeb2fhLLxHPCy7nWyvNGtXQXvHjNiN8/+mptAtSVhf4SG1ZmWtnV5CF5F1sbeEfKsM5eu3KBYC50n4tv5b6MR4GOnDBz11T4UhK2/fK7wa1hpbgjvBVZS1L5qrl59E6N4fxsZ5KGuWZC81MMdk/XhtFKPNSx47VO84i0TAnDKfmuxJ1gKN2NbcFxqpDxNxtRtOvsTxccJSCsqG+c1euWf3Kwhj7hCCoqxiqRJN5iPineI5dt7S38a77pHM1OL4EQ6YgZfZ/Hr9pjEurs3nYopO24CsicvuoykQ0MMRELb/socCwAw==;5:Ved1acR5papeZt3TjlJQrkGwWHLhCudqrjmPQnbPtFkYXaYvfV0KUHjqqRqLKExOakTWRwM7r2g1meJxrKpDmsa2peXbldhTtjJ9gxN9c5asttk28cNdMtDMa/MT+CszP5tF+r2rdQ2xxtDyTom+OcyqiPZSl89+ADFkYKnSyQg=;7:n7R09ba731+NAYELOE06kti15Sh79Xh7QsuZWz5ZTXJRM2J1cP4zlmlSiYpEuZn35dqQoKsbGipzxspi1qMwsyClrxHJL7NLExfm9s5LVS622erzaPwetNfxnMVPYtPCjJF2OpwKOp4n5sO2PLulRQ==
x-ms-office365-filtering-correlation-id: d7d62e21-c568-4608-9534-08d63d5e5e37
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4455;
x-ms-traffictypediagnostic: BYAPR07MB4455:
x-microsoft-antispam-prvs: <BYAPR07MB4455B7E8424F1A54AE3F7898F9F30@BYAPR07MB4455.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4455;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4455;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(51914003)(66066001)(81166006)(305945005)(81156014)(7736002)(8936002)(8676002)(478600001)(486006)(2616005)(71190400001)(11346002)(476003)(446003)(71200400001)(106356001)(105586002)(99286004)(3846002)(76176011)(52116002)(6116002)(54906003)(186003)(42882007)(53546011)(6506007)(102836004)(110136005)(316002)(26005)(6246003)(2171002)(53936002)(25786009)(386003)(4326008)(2900100001)(6512007)(6486002)(5250100002)(6436002)(2906002)(97736004)(5660300001)(68736007)(229853002)(14454004)(72206003)(31686004)(78486011)(31696002)(36756003)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4455;H:BYAPR07MB4920.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: X6D9m/4A3gXS2NV/5GwxQNE1v2V7W6gZmdzQypBkrU29s0MUSlgODohROfE8gTu2X5+oFm0WIyGtbd9EN+ZrYD/ePfJNRRDOezSFTU+JSdPlwPARzvWn26IFU2NmCPungCiRZr4gWiOsKKpH/Zhn/AJ/pquUmxsq34+dGUptvkox3Ga6ieuhM6pKL3ezwE3bIm3ynqxyxl0OmLLbzF5qFL0Uzwh3wRJhCM8n0+ry0R5coyORe8zTQk5y+8+Q+4mtkEkDr5RDvpDtdWzYUKifUjKO5JTNwnsLmRoc5kHrcOXAPgLE3Th8R6L+emNhIQZQi4VluX/wuiU0yzvEwpYYZ95ekYwk98+yg2HUECSLTnQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C91C0AD23A62E4458ABFCFD0F0534D0C@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d62e21-c568-4608-9534-08d63d5e5e37
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 05:21:24.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBbGFuLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQpJIHdpbGwgdXBkYXRlIHRoZSBw
YXRjaCBhY2NvcmRpbmdseSBhbmQgc2VuZCBvdXQgdjIuDQoNCk9uIDEwLzI4LzIwMTggMTA6NDgg
UE0sIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IA0KPiBPbiBTYXQsIDI3IE9jdCAyMDE4LCBDaGVyaWFu
LCBHZW9yZ2Ugd3JvdGU6DQo+IA0KPj4gSW1wbGVtZW50IHdvcmthcm91bmQgZm9yIFRodW5kZXJY
MiBFcnJhdGEtMTI5IChkb2N1bWVudGVkIGluDQo+PiBDTjk5WFggS25vd24gSXNzdWVzIiBhdmFp
bGFibGUgYXQgQ2F2aXVtIHN1cHBvcnQgc2l0ZSkuDQo+PiBBcyBwZXIgVGh1bmRlclgyZXJyYXRh
LTEyOSwgVVNCLTIuMCBkZXZpY2UgbWF5IGNvbWUgdXAgYXMgVVNCLTEuMA0KPj4gSWYgYSBjb25u
ZWN0aW9uIHRvIGEgVVNCLTEuMCBkZXZpY2UgaXMgZm9sbG93ZWQgYnkgYW5vdGhlciBjb25uZWN0
aW9uDQo+PiB0byBhIFVTQi0yLjAgZGV2aWNlLCB0aGUgbGluayB3aWxsIGNvbWUgdXAgYXMgVVNC
LTEuMCBmb3IgdGhlIFVTQi0yLjANCj4+IGRldmljZS4NCj4+DQo+PiBSZXNvbHV0aW9uOiBSZXNl
dCB0aGUgUEhZIGFmdGVyIHRoZSBVU0IxLjAgZGV2aWNlIGlzIGRpc2Nvbm5lY3RlZC4NCj4+IFRo
ZSBQSFkgcmVzZXQgc2VxdWVuY2UgaXMgZG9uZSB1c2luZyBwcml2YXRlIHJlZ2lzdGVycyBpbiBY
SENJIHJlZ2lzdGVyDQo+PiBzcGFjZS4gQWZ0ZXIgdGhlIFBIWSBpcyByZXNldCB3ZSBjaGVjayBm
b3IgdGhlIFBMTCBsb2NrIHN0YXR1cyBhbmQgcmV0cnkNCj4+IHRoZSBvcGVyYXRpb24gaWYgaXQg
ZmFpbHMuIEZyb20gb3VyIHRlc3RzLCByZXRyeWluZyA0IHRpbWVzIGlzIHN1ZmZpY2llbnQuDQo+
Pg0KPj4gQWRkIGEgbmV3IHF1aXJrIGZsYWcgWEhDSV9SRVNFVF9QTExfT05fRElTQ09OTkVDVCB0
byBpbnZva2UgdGhlIHdvcmthcm91bmQNCj4+IGluIGhhbmRsZV94aGNpX3BvcnRfc3RhdHVzKCku
DQo+IA0KPiBNaW5vciBuaXRwaWNrIChmb3IgYm90aCB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gYW5k
IHRoZSBjb2RlIGNvbW1lbnRzKToNCj4gDQo+IFVTQiAxLjAgd2FzIG5ldmVyIHdpZGVseSBhZG9w
dGVkIGFuZCBpcyBub3QgdXNlZCBhbnkgbW9yZS4gIFRoZQ0KPiBlYXJsaWVzdCB2ZXNpb24gb2Yg
VVNCIGN1cnJlbnRseSB1c2VkIGluIHN1cHBvcnRlZCBkZXZpY2VzIGlzIFVTQiAxLjEuDQo+IExp
a2V3aXNlLCB0aGVyZSBhcmUgYSBmZXcgZGV2aWNlcyBhcm91bmQgdGhhdCBzdXBwb3J0IFVTQiAy
LjEsIG5vdA0KPiBVU0IgMi4wLCBidXQgdGhleSBhcmUgcHJlc3VtYWJseSBhbHNvIHN1YmplY3Qg
dG8gdGhlIHByb2JsZW0gZGVzY3JpYmVkDQo+IGFib3ZlLg0KPiANCj4gSSBzdWdnZXN0IHlvdSBj
aGFuZ2UgdGhlIGRlc2NyaXB0aW9uIGFuZCB0aGUgY29tbWVudHMgdG8gcmVmZXIgdG8gVVNCIDEN
Cj4gYW5kIFVTQiAyIGluc3RlYWQgb2YgVVNCIDEuMCBhbmQgVVNCIDIuMCwgYXMgdGhlIGxhdHRl
ciBhcmUgdG9vDQo+IHJlc3RyaWN0aXZlIGFuZCBtaXNsZWFkaW5nLg0KPiANCj4gQWxhbiBTdGVy
bg0KPiANClJlZ2FyZHMsDQotR2VvcmdlDQo=
