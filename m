Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E74C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CB12082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="Nq3VIddC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CB12082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJ3SnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:43:08 -0400
Received: from mail-eopbgr700074.outbound.protection.outlook.com ([40.107.70.74]:60873
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbeJ3SnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C+XxGJsjMa8byWIUmskUdfTxcv5JvnZdVNVJlIpsAE=;
 b=Nq3VIddC0VKDn+bYwnenKcO9YSVbZsU2JiQ6Jg6ED0qwFsYHDoNo1mtHywpPIIWgZdRXxYaYPOZIN77hzXBqwPaOfFEk5bSOf9ThclQrXkuUCSXCMLrVRV9vld24bMZ12TTkK3bshR3t57KQf3CPzENhxxVCq9JgheLmnYG78QA=
Received: from BYAPR07MB4920.namprd07.prod.outlook.com (52.135.237.93) by
 BYAPR07MB5173.namprd07.prod.outlook.com (20.176.254.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Tue, 30 Oct 2018 09:50:19 +0000
Received: from BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5]) by BYAPR07MB4920.namprd07.prod.outlook.com
 ([fe80::69f7:b92b:5107:d9e5%4]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 09:50:19 +0000
From:   George Cherian <gcherian@caviumnetworks.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "Cherian, George" <George.Cherian@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] xhci: Add quirk to workaround the errata seen on
 Cavium Thunder-X2 Soc
Thread-Topic: [PATCH v2] xhci: Add quirk to workaround the errata seen on
 Cavium Thunder-X2 Soc
Thread-Index: AQHUb6gROG15BNorrku1gifnx4EBw6U3jJEA/////4A=
Date:   Tue, 30 Oct 2018 09:50:19 +0000
Message-ID: <3b009211-6c86-ffdb-424f-5ed09b01e772@caviumnetworks.com>
References: <1540832062-22224-1-git-send-email-george.cherian@cavium.com>
 <f0d31ea6-5e2c-35c2-c4ab-746181d6f326@linux.intel.com>
In-Reply-To: <f0d31ea6-5e2c-35c2-c4ab-746181d6f326@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::32) To BYAPR07MB4920.namprd07.prod.outlook.com
 (2603:10b6:a03:55::29)
x-originating-ip: [111.93.218.67]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5173;6:Lf7BVzDQlS15nOsFMosn2/JM/kBlCWcKQjE0MorUphhjWyfZCOnfZTOcpo1VOFZjZxsz0eN01ecThesyx+L83W/J8AoMJB3czBCeWZeVuQUCQrPsYUXK9RvRacjBdif7zNMisT/HSDCBPlY7R5Zo2muJpDso2WX8Il3MOu19hRs1iW0RsQ8VGFZsm6yGWtRc0xbYAjIcpwhg2kY88qJwPaK0ki9dH/jjljScefyzzUHg2B9pHSbGyUFzsGLcb+c38L7uQPfmHJHC7D9o+b2PgKU85NY6rGCBkrG5Gdt1WhQn52A5YJ4kdBI0x/Vqqu1c1QEPDhwbNfUp8+qEa9zva0PbLTGeiPgyB3eIfMyo6X/Yq3KgY8ZHme1wD1h/gPxjmNsr7WX+gDjsnGz4bD6DdfxPyTctwx0BA+rl0nBXsE3QHN1jreSeApG2Y+0mZLBvHsyiDtkWmBz8OTBbw97lsg==;5:R3Fn9U5FU2aSehsty+3dwzDU5L7y/AWkQIQAPNQyKmd1BfMuczxqGHiwSamFQaGjXF6WD7WLfARxPuNG1O1EYQPflnydeEYqR4nKIS0jY9SYAkchl6SYr0Y/P0B+8zfZ7A2Mvn01ZCeoRr6zw7Vvrx1LWvcysDWEH8U6dpfs4dw=;7:nTWbwmWG/7coibwMAfXr8u11hA/8QC6wOB74piVY68tsl8BgQPsZtQGz/TL7qhXOJyI9OV/0MQDH4S7WOmnyMj6EhLmBPVve2E246uIDc8CeInQ+RaCVBWOHwDGXqeuM5h0khjHpItJlNLxCU8mjow==
x-ms-office365-filtering-correlation-id: 17edfdd2-5ed8-4a5a-2f73-08d63e4d19c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5173;
x-ms-traffictypediagnostic: BYAPR07MB5173:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
x-microsoft-antispam-prvs: <BYAPR07MB517398078909038CB35C3CD1F9CC0@BYAPR07MB5173.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(93006095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB5173;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5173;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(199004)(189003)(51914003)(53936002)(6506007)(36756003)(8936002)(68736007)(102836004)(6246003)(99286004)(105586002)(6512007)(575784001)(6116002)(31686004)(3846002)(76176011)(106356001)(386003)(81166006)(5660300001)(81156014)(6486002)(53546011)(305945005)(78486012)(8676002)(2201001)(52116002)(6436002)(2906002)(31696002)(7736002)(2501003)(229853002)(26005)(5250100002)(256004)(14444005)(2900100001)(97736004)(4326008)(25786009)(72206003)(71190400001)(11346002)(446003)(71200400001)(476003)(2616005)(478600001)(42882007)(66066001)(14454004)(54906003)(110136005)(186003)(316002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5173;H:BYAPR07MB4920.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ExMk+ZrYNevvw4fUOZb5EJ9QAS++uUDb1TA3UFjv9SHk9u6Id23CT4em6yDeUVF4HvKHsC2Lait7HiB+fAbqmJtgmVZrafHKnE9Ue1+sUcPVIxib2TXPCcauQdP1RGb+maejslfwB6BTZsv+EuyTui2mcP1ZMql7BR/NIn0/iK0WIY0AN+BqaxEfWlv095P3YFIRKbQYIFBTTE5934vFDAnS9cFZGr0HY4hoAnRuqJDjoIVc7EZO3Vy0Qtnffnhdcaa+PP/jwlesmIkSRQe+Kb1WcGIUofsYJmXvtPzTSIaT5m8J7YQHfLGAxQmTAJIAONwO9mnOmHceTnCKt2de9j/C4cH3AEPmZ0QI3mFWGc0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DB93B084ABC6C4E8FB6E897AAC67037@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17edfdd2-5ed8-4a5a-2f73-08d63e4d19c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 09:50:19.2514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0aGlhcywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiAxMC8zMC8yMDE4IDAz
OjIwIFBNLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0KPiANCj4gT24gMjkuMTAuMjAxOCAxODo1NCwg
Q2hlcmlhbiwgR2VvcmdlIHdyb3RlOg0KPj4gSW1wbGVtZW50IHdvcmthcm91bmQgZm9yIFRodW5k
ZXJYMiBFcnJhdGEtMTI5IChkb2N1bWVudGVkIGluDQo+PiBDTjk5WFggS25vd24gSXNzdWVzIiBh
dmFpbGFibGUgYXQgQ2F2aXVtIHN1cHBvcnQgc2l0ZSkuDQo+PiBBcyBwZXIgVGh1bmRlclgyZXJy
YXRhLTEyOSwgVVNCIDIgZGV2aWNlIG1heSBjb21lIHVwIGFzIFVTQiAxDQo+PiBpZiBhIGNvbm5l
Y3Rpb24gdG8gYSBVU0IgMSBkZXZpY2UgaXMgZm9sbG93ZWQgYnkgYW5vdGhlciBjb25uZWN0aW9u
IHRvDQo+PiBhIFVTQiAyIGRldmljZSwgdGhlIGxpbmsgd2lsbCBjb21lIHVwIGFzIFVTQiAxIGZv
ciB0aGUgVVNCIDIgZGV2aWNlLg0KPj4NCj4+IFJlc29sdXRpb246IFJlc2V0IHRoZSBQSFkgYWZ0
ZXIgdGhlIFVTQiAxIGRldmljZSBpcyBkaXNjb25uZWN0ZWQuDQo+PiBUaGUgUEhZIHJlc2V0IHNl
cXVlbmNlIGlzIGRvbmUgdXNpbmcgcHJpdmF0ZSByZWdpc3RlcnMgaW4gWEhDSSByZWdpc3Rlcg0K
Pj4gc3BhY2UuIEFmdGVyIHRoZSBQSFkgaXMgcmVzZXQgd2UgY2hlY2sgZm9yIHRoZSBQTEwgbG9j
ayBzdGF0dXMgYW5kIHJldHJ5DQo+PiB0aGUgb3BlcmF0aW9uIGlmIGl0IGZhaWxzLiBGcm9tIG91
ciB0ZXN0cywgcmV0cnlpbmcgNCB0aW1lcyBpcyANCj4+IHN1ZmZpY2llbnQuDQo+Pg0KPj4gQWRk
IGEgbmV3IHF1aXJrIGZsYWcgWEhDSV9SRVNFVF9QTExfT05fRElTQ09OTkVDVCB0byBpbnZva2Ug
dGhlIA0KPj4gd29ya2Fyb3VuZA0KPj4gaW4gaGFuZGxlX3hoY2lfcG9ydF9zdGF0dXMoKS4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBHZW9yZ2UgQ2hlcmlhbiA8Z2VvcmdlLmNoZXJpYW5AY2F2aXVt
LmNvbT4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy91c2IvaG9zdC94aGNpLXBjaS5jwqAgfMKgIDUg
KysrKysNCj4+IMKgIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1yaW5nLmMgfCAzNSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gwqAgZHJpdmVycy91c2IvaG9zdC94aGNpLmjC
oMKgwqDCoMKgIHzCoCAxICsNCj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3ho
Y2ktcGNpLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMNCj4+IGluZGV4IDUxZGQ4ZTAu
LjMzNGMwMDkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMNCj4+
ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2kuYw0KPj4gQEAgLTIzMSw2ICsyMzEsMTEg
QEAgc3RhdGljIHZvaWQgeGhjaV9wY2lfcXVpcmtzKHN0cnVjdCBkZXZpY2UgKmRldiwgDQo+PiBz
dHJ1Y3QgeGhjaV9oY2QgKnhoY2kpDQo+PiDCoMKgwqDCoMKgIGlmIChwZGV2LT52ZW5kb3IgPT0g
UENJX1ZFTkRPUl9JRF9USSAmJiBwZGV2LT5kZXZpY2UgPT0gMHg4MjQxKQ0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgeGhjaS0+cXVpcmtzIHw9IFhIQ0lfTElNSVRfRU5EUE9JTlRfSU5U
RVJWQUxfNzsNCj4+DQo+PiArwqDCoMKgwqAgaWYgKChwZGV2LT52ZW5kb3IgPT0gUENJX1ZFTkRP
Ul9JRF9CUk9BRENPTSB8fA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBwZGV2LT52ZW5kb3IgPT0g
UENJX1ZFTkRPUl9JRF9DQVZJVU0pICYmDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgIHBkZXYtPmRl
dmljZSA9PSAweDkwMjYpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhoY2ktPnF1aXJr
cyB8PSBYSENJX1JFU0VUX1BMTF9PTl9ESVNDT05ORUNUOw0KPj4gKw0KPj4gwqDCoMKgwqDCoCBp
ZiAoeGhjaS0+cXVpcmtzICYgWEhDSV9SRVNFVF9PTl9SRVNVTUUpDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB4aGNpX2RiZ190cmFjZSh4aGNpLCB0cmFjZV94aGNpX2RiZ19xdWlya3Ms
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICJRVUlSSzogUmVzZXR0aW5nIG9uIHJlc3VtZSIpOw0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2hvc3QveGhjaS1yaW5nLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmluZy5j
DQo+PiBpbmRleCBmMGE5OWFhLi4zNDJkZDVhYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNi
L2hvc3QveGhjaS1yaW5nLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yaW5nLmMN
Cj4+IEBAIC0xNTE3LDYgKzE1MTcsMzUgQEAgc3RhdGljIHZvaWQgaGFuZGxlX2RldmljZV9ub3Rp
ZmljYXRpb24oc3RydWN0IA0KPj4geGhjaV9oY2QgKnhoY2ksDQo+PiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB1c2Jfd2FrZXVwX25vdGlmaWNhdGlvbih1ZGV2LT5wYXJlbnQsIHVkZXYtPnBv
cnRudW0pOw0KPj4gwqAgfQ0KPj4NCj4+ICsvKg0KPj4gKyAqIFF1aXJrIGhhbmxkZXIgZm9yIGVy
cmF0YSBzZWVuIG9uIENhdml1bSBUaHVuZGVyWDIgcHJvY2Vzc29yIFhIQ0kNCj4+ICsgKiBDb250
cm9sbGVyLg0KPj4gKyAqIEFzIHBlciBUaHVuZGVyWDJlcnJhdGEtMTI5IFVTQiAyIGRldmljZSBt
YXkgY29tZSB1cCBhcyBVU0IgMQ0KPj4gKyAqIElmIGEgY29ubmVjdGlvbiB0byBhIFVTQiAxIGRl
dmljZSBpcyBmb2xsb3dlZCBieSBhbm90aGVyIGNvbm5lY3Rpb24NCj4+ICsgKiB0byBhIFVTQiAy
IGRldmljZS4NCj4+ICsgKg0KPj4gKyAqIFJlc2V0IHRoZSBQSFkgYWZ0ZXIgdGhlIFVTQiBkZXZp
Y2UgaXMgZGlzY29ubmVjdGVkIGlmIGRldmljZSBzcGVlZA0KPj4gKyAqIGlzIGxlc3MgdGhhbiBI
Q0RfVVNCMy4NCj4+ICsgKiBSZXRyeSB0aGUgcmVzZXQgc2VxdWVuY2UgbWF4IG9mIDQgdGltZXMg
Y2hlY2tpbmcgdGhlIFBMTCBsb2NrIHN0YXR1cy4NCj4+ICsgKg0KPj4gKyAqLw0KPj4gK3N0YXRp
YyB2b2lkIHhoY2lfaGFuZGxlX3R4Ml93cmFwcGVyX3Jlc2V0KHN0cnVjdCB4aGNpX2hjZCAqeGhj
aSkNCj4gDQo+IE1heWJlIHJlbmFtZSB0aGlzIHRvIG1ha2UgaXQgbW9yZSBvYnZpb3VzIGl0J3Mg
YWJvdXQgYSBxdWlyay4NCj4geGhjaV9jYXZpdW1fcmVzZXRfcGh5X3F1aXJrKCkgbWF5YmU/DQpZ
ZXMgd2lsbCBkbw0KPiANCj4+ICt7DQo+PiArwqDCoMKgwqAgc3RydWN0IHVzYl9oY2QgKmhjZCA9
IHhoY2lfdG9faGNkKHhoY2kpOw0KPj4gK8KgwqDCoMKgIHUzMiBwbGxfbG9ja19jaGVjazsNCj4+
ICvCoMKgwqDCoCB1MzIgcmV0cnlfY291bnQgPSA0Ow0KPj4gKw0KPj4gK8KgwqDCoMKgIGRvIHsN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogQXNzZXJ0IFBIWSByZXNldCAqLw0KPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3cml0ZWwoMHg2RiwgaGNkLT5yZWdzICsgMHgxMDQ4
KTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWRlbGF5KDEwKTsNCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLyogRGUtYXNzZXJ0IHRoZSBQSFkgcmVzZXQgKi8NCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVsKDB4N0YsIGhjZC0+cmVncyArIDB4MTA0OCk7DQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVkZWxheSgyMDApOw0KPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBwbGxfbG9ja19jaGVjayA9IHJlYWRsKGhjZC0+cmVncyArIDB4MTA3MCk7
DQo+PiArwqDCoMKgwqAgfSB3aGlsZSAoIShwbGxfbG9ja19jaGVjayAmIDB4MSkgJiYgLS1yZXRy
eV9jb3VudCk7DQo+PiArfQ0KPj4gKw0KPj4gwqAgc3RhdGljIHZvaWQgaGFuZGxlX3BvcnRfc3Rh
dHVzKHN0cnVjdCB4aGNpX2hjZCAqeGhjaSwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHVuaW9uIHhoY2lfdHJiICpldmVudCkNCj4+IMKgIHsNCj4+IEBAIC0xNjQyLDggKzE2NzEsMTIg
QEAgc3RhdGljIHZvaWQgaGFuZGxlX3BvcnRfc3RhdHVzKHN0cnVjdCB4aGNpX2hjZCANCj4+ICp4
aGNpLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBjbGVhbnVwOw0KPj4gwqDC
oMKgwqDCoCB9DQo+Pg0KPj4gLcKgwqDCoMKgIGlmIChoY2QtPnNwZWVkIDwgSENEX1VTQjMpDQo+
PiArwqDCoMKgwqAgaWYgKGhjZC0+c3BlZWQgPCBIQ0RfVVNCMykgew0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgeGhjaV90ZXN0X2FuZF9jbGVhcl9iaXQoeGhjaSwgcG9ydCwgUE9SVF9Q
TEMpOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoKHBvcnRzYyAmIFBPUlRfQ1ND
KSAmJiAhKHBvcnRzYyAmIDB4MSkgJiYNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAoeGhjaS0+cXVpcmtzICYgWEhDSV9SRVNFVF9QTExfT05fRElTQ09OTkVDVCkpDQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4aGNpX2hhbmRsZV90eDJf
d3JhcHBlcl9yZXNldCh4aGNpKTsNCj4+ICvCoMKgwqDCoCB9DQo+IA0KPiBDaGVjayBmb3IgdGhl
IHF1aXJrIGZpcnN0LCB0aGlzIHdheSBJIGNhbiBpZ25vcmUgdGhlIHJlc3Qgb2YgdGhlIGNvZGUg
d2hlbg0KPiBkZWJ1Z2dpbmcgb3RoZXIgaXNzdWVzLMKgIGFuZCB1c2UgUE9SVF9DT05ORUNUIGlu
c3RlYWQgb2YgMHgxDQo+IA0KPiBzb21ldGhpbmcgbGlrZToNCj4gDQo+IGlmICgoeGhjaS0+cXVp
cmtzICYgWEhDSV9SRVNFVF9QTExfT05fRElTQ09OTkVDVCkgJiYNCj4gIMKgwqDCoCAocG9ydHNj
ICYgUE9SVF9DU0MpICYmICEocG9ydHNjICYgUE9SVF9DT05ORUNUKSkNCg0KWWVzIEkgd2lsbCBk
byB0aGUgY2hhbmdlcyBhbmQgcG9zdCBuZXcgdmVyc2lvbi4NCj4gDQo+IFRoYW5rcw0KPiAtTWF0
aGlhcw0KDQpSZWdhcmRzDQotR2VvcmdlDQo=
