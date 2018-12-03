Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF85C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B34120881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QrsUQ90+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B34120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbeLCDF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:05:26 -0500
Received: from mail-oln040092008108.outbound.protection.outlook.com ([40.92.8.108]:22486
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbeLCDF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpBK0Sx+/JBnvPLSHUYv04WkEzkkY9U3k8t5gUNSzb8=;
 b=QrsUQ90+xDQ0q2Uhddh922xLLJtvcT/S802FGAWUdcopMubOLx0jrOROhhtLsTPkifv5uaoB4G39LePc1M6fh5AbUjcF6i1Cnubb0EH2jCy8WiYL/+GKVu7jTQhWZlt8R5tWunGnIKZvkkRLtDA/wjx6vIGjMI3ew7EyIxvP6KwgRgHAO4pqHnmP/nPQztv18n4JMqmctxMwudPx2A3rTcFFSIZZKZQ37cRAKB1h6/QGAWOTsWTZpUZGgiRPR+z9fZk0McmXdMoscchEVrOwi4PHTsYrtsV5retOeibychexY0ErWioxVyD8MQ2v9i+JLdmemEqaLQmZRPUUf58mNQ==
Received: from BY2NAM03FT009.eop-NAM03.prod.protection.outlook.com
 (10.152.84.57) by BY2NAM03HT231.eop-NAM03.prod.protection.outlook.com
 (10.152.85.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1382.18; Mon, 3 Dec
 2018 03:05:20 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com (10.152.84.60) by
 BY2NAM03FT009.mail.protection.outlook.com (10.152.84.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18 via Frontend Transport; Mon, 3 Dec 2018 03:05:20 +0000
Received: from BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3]) by BLUPR13MB0289.namprd13.prod.outlook.com
 ([fe80::19ff:b7ea:dfaa:2ee3%2]) with mapi id 15.20.1404.011; Mon, 3 Dec 2018
 03:05:20 +0000
From:   Yueyi Li <liyueyi@live.com>
To:     Dave Rodgman <dave.rodgman@arm.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>, "w@1wt.eu" <w@1wt.eu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "donb@securitymouse.com" <donb@securitymouse.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>, nd <nd@arm.com>
Subject: Re: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Topic: [PATCH v2] lzo: fix ip overrun during compress.
Thread-Index: AQHUhuxfhCM/itRkZUmE23ES7mjh0qVlNWoAgAHDqgCAAKwqAIAAmyGAgAQWjQCAAAU6gA==
Date:   Mon, 3 Dec 2018 03:05:20 +0000
Message-ID: <BLUPR13MB02898F35858E65FF9FF7CD57DFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
References: <BLUPR13MB0289EFEB79833470EE62F48EDFD10@BLUPR13MB0289.namprd13.prod.outlook.com>
 <20181128135242.gy3avmbp2pdmjaka@twin.jikos.cz>
 <c03227b3-1c79-d214-5880-19f2f1ea0491@arm.com>
 <SN1PR13MB030426DBA527C725AE28B5A9DFD30@SN1PR13MB0304.namprd13.prod.outlook.com>
 <3bde9678-ac05-62f1-bfc3-434832adda11@arm.com>
 <BLUPR13MB02895D29089318B8B3519D9ADFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
In-Reply-To: <BLUPR13MB02895D29089318B8B3519D9ADFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:36::15) To BLUPR13MB0289.namprd13.prod.outlook.com
 (2a01:111:e400:5951::22)
x-incomingtopheadermarker: OriginalChecksum:ABAADEE7ED90770B4E7A2451EDCB9EAFE811455BB33D4655C8A5050C0DD91DDA;UpperCasedChecksum:34D465781ECCAE0F013A724C79F7B103874D00260F5395E1D2F0961579302D0B;SizeAsReceived:8112;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [I0EgOL1vl2eZsMHykdWUqpGmiWGH5KqW]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2NAM03HT231;6:FwdDj0sClKAwWHcPDYkubMZtZuEWbABzVysS3p8xG2GEsQQm19HY4ThzLPpD7Jxl0rbpsgQAz6QpAvQ2cDPfNJogjBYQrEmoxJ7O9Q9lYVAXzAsECmx6dHWaPNW7xfqheN1v99aHUveeZe47bIAA4FpiUVaGpCNCZVdxRX8eCl2vHAb/Y5W+cQzltpo9T+jSDI+ya1KNNr+48efIjSR5+Zb9Lgfl5ts7qNvV7VfYVc3O0AbaHkq1u30h9LbaBPCbz2HO9QIxueGOFUqJuwu5Z68mtbvzHLuMg96lO2/jIeK88kqteDjL7rkOOPyObuFvObPdP6PBe+TJcf3NAUjwBFIXUno17XXPGGLI7bnGSWy8ZdTXMyzdd4/GB67Eg6JceI8B6BYqLprIaVXLuLi6rRQ8pN8qJXior1mAEvwK2AfVj6kkNzBtKgY5Ly31C0Q0JizM7nsrmJ13at8ZkJGPgw==;5:gEYWQJMdGHdWvlz+wsjArMGRNdnJENOiibu8zmSh5jhnzk6wYzEE7R25DKWtJVK9ytAkFWUYITOgW1AxDKdRwqIop0F5F5MulUBw7CIYqnEIYb2d2YFcpPEvDJdj+1cHexVJKdM3vCkrR9lpUo/06+bxkZ/VdTyCCcGILRhnKUk=;7:rJ1/U8zvX808wSXUixNtcjXLqdmh18g+PraTlq/meE3DwwkhDwOvvLvK05dhXwVVhxl2//RU+m+JzdTMLHdJ/dyrXlI0TmhhIv+V7+lQRCPA8yyiusVFRE+fAo4vKwZguUtk8pyeBZ+an7CFtRq6aw==
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:BY2NAM03HT231;
x-ms-traffictypediagnostic: BY2NAM03HT231:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:BY2NAM03HT231;BCL:0;PCL:0;RULEID:;SRVR:BY2NAM03HT231;
x-microsoft-antispam-message-info: OKXTjYP8jWH6euv9hupSWFugH0Bey7odokhlSpOVfZyAwubOIyL/BhSLYHQ1HSm0
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E6702891EB38A4CAAF261FAD23CF1C7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d186e9-754b-4ff3-a5ab-08d658cc289e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: f12efbb0-867f-4c93-8261-502eceebfafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 03:05:20.3031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2NAM03HT231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMTgvMTIvMyAxMDo0NiwgWXVleWkgTGkgd3JvdGU6DQo+DQo+DQo+IE9uIDIwMTgv
MTEvMzAgMjA6MjAsIERhdmUgUm9kZ21hbiB3cm90ZToNCj4+PiBPbiAyMDE4LzExLzMwIDA6NDks
IERhdmUgUm9kZ21hbiB3cm90ZToNCj4+Pj4gT24gMjgvMTEvMjAxOCAxOjUyIHBtLCBEYXZpZCBT
dGVyYmEgd3JvdGU6DQo+Pj4+DQo+Pj4+PiBUaGUgZml4IGlzIGFkZGluZyBhIGZldyBicmFuY2hl
cyB0byBjb2RlIHRoYXQncyBzdXBwb3NlZCB0byBiZSBhcyANCj4+Pj4+IGZhc3QNCj4+Pj4+IGFz
IHBvc3NpYmxlLiBUaGUgYnJhbmNoZXMgd291bGQgYmUgZXZhbHVhdGVkIGFsbCB0aGUgdGltZSB3
aGlsZQ0KPj4+Pj4gcHJvdGVjdGluZyBhZ2FpbnN0IG9uZSBzaWdubGUgYmFkIHBhZ2UgYWRkcmVz
cy4gVGhpcyBkb2VzIG5vdCBsb29rIA0KPj4+Pj4gbGlrZQ0KPj4+Pj4gYSBnb29kIHBlcmZvcm1h
bmNlIHRyYWRlb2ZmLg0KPj4+PiBBcyBhbiBhbHRlcm5hdGl2ZSwgZm9yIGFsbCBidXQgdGhlIGZp
cnN0IGNhc2UsIGluc3RlYWQgb2Y6DQo+Pj4+DQo+Pj4+IGlmICh1bmxpa2VseShPVkVSRkxPV19B
RERfQ0hFQ0soaXAsIG1fbGVuKSB8fCAoaXAgKyBtX2xlbiA+PSBpcF9lbmQpKSkNCj4+Pj4NCj4+
Pj4gSSdkIHN1Z2dlc3Qgd2UgZG86DQo+Pj4+DQo+Pj4+IGlmICh1bmxpa2VseSgoaXBfZW5kIC0g
aXApIDw9IG1fbGVuKSkNCj4+Pj4NCj4+Pj4gd2hpY2ggd2lsbCBiZSBhYm91dCBhcyBlZmZpY2ll
bnQgYXMgd2hhdCdzIGN1cnJlbnRseSB0aGVyZSwgYnV0IA0KPj4+PiBkb2Vzbid0DQo+Pj4+IGhh
dmUgaXNzdWVzIHdpdGggb3ZlcmZsb3cuDQo+Pj4gT29oLCB5ZXMsIHByZXR0eSBnb29kIHNvbHV0
aW9uIHRvIHRoaXMsIHRoYW5rcy4NCj4+IE5wIDotKQ0KPj4NCj4+IEFjdHVhbGx5LCBsb29raW5n
IG1vcmUgY2xvc2VseSBhdCB0aGUgZmlyc3QgY2FzZSwgc29tZXRoaW5nIGxpa2UgdGhpcw0KPj4g
d29ya3MgcXVpdGUgd2VsbDoNCj4+DQo+PiBzaXplX3QgaW5jID0gMSArICgoaXAgLSBpaSkgPj4g
NSk7DQo+PiBpZiAodW5saWtlbHkoKGlwX2VuZCAtIGlwKSA8PSBpbmMpKQ0KPj4gICAgIGJyZWFr
Ow0KPj4gaXAgKz0gaW5jOw0KPj4NCj4+IE9uIGFybTY0LCB0aGlzIGdlbmVyYXRlcyBvbmx5IGEg
c2luZ2xlIGJyYW5jaCBpbnN0cnVjdGlvbiwgc28gaXQncyBvbmx5DQo+PiB0d28gZXh0cmEgYXJp
dGhtZXRpYyBvcGVyYXRpb25zIG1vcmUgdGhhbiB0aGUgb3JpZ2luYWwgY29kZSAodXNpbmcgdGhl
DQo+PiBtYWNybyByZXN1bHRzIGluIGFuIGFkZGl0aW9uYWwgY29tcGFyZSAmIGJyYW5jaCkuDQo+
Pg0KPiBIb3cgYWJvdXQganVzdCBpbnN0ZWFkIG9mOg0KPg0KPiAgIGlmICh1bmxpa2VseShpcCA+
PSBpcF9lbmQpKQ0KPiAgICAgICAgIGJyZWFrOw0KPg0KPiB0bzoNCj4NCj4gICBpZih1bmxpa2Vs
eSgoaXAgLSBpcF9lbmQpIDwgfmluX2xlbikpDQo+ICAgICAgICAgYnJlYWs7DQo+DQo+IFRoaXMg
anVzdCBnZW5lcmF0ZXMgb25seSBvbmUgbW9yZSBhcml0aG1ldGljIG9wZXJhdGlvbiB0aGFuIG9y
aWdpbmFsIA0KPiBjb2RlLCBub3QgZWFzeSB0byBncmFzcCBidXQgbW9yZSBlZmZpY2llbnQuDQo+
DQo+DQoNClNvcnJ5LCBzaG91bGQgYmU6DQoNCiAgIGlmKHVubGlrZWx5KChpcCAtIGlwX2VuZCkg
PCB+KGluX2xlbiAtIDIwKSkpDQogICAgICAgICBicmVhazsNCg0KPiBUaGFua3MsDQo+IFl1ZXlp
DQo+DQo+DQoNCg==
