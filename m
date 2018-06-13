Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1BE6EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0CA208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 18:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="OFUqYg+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0CA208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935494AbeFMS1Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 14:27:25 -0400
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:52595
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935006AbeFMS1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 14:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veR4nhuapD7bbISGVRh0XsuDMzQxvws+Ox6WYW+xB0U=;
 b=OFUqYg+EXCU2DVdjkmw1grYMPvpF6UeqygtfM+lV2y+DsCDKcmrx0leS76gB5r1AZZk9bGr1bMzwM7AUAtTge/G1pQVOWUf6I8HuRraWJcFnZ9YIjufM00qqInyKVw5+zH4v+rpBZHJw1yqfMGYC+cXp/JrS7TbpvkCNOGUgwEQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4104.namprd05.prod.outlook.com (52.135.199.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.6; Wed, 13 Jun 2018 18:27:22 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::1010:9926:76ba:c7b7%2]) with mapi id 15.20.0863.016; Wed, 13 Jun 2018
 18:27:22 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/7] vmw_balloon: fix inflation of 64-bit GFNs
Thread-Topic: [PATCH 3/7] vmw_balloon: fix inflation of 64-bit GFNs
Thread-Index: AQHUA0L/rUOafrnadEG4L9kKimvHMqRegDWAgAABlgA=
Date:   Wed, 13 Jun 2018 18:27:22 +0000
Message-ID: <5AE4EB83-47A7-45CB-A5A5-D25607A808BE@vmware.com>
References: <20180613110359.109033-1-namit@vmware.com>
 <20180613110359.109033-4-namit@vmware.com> <20180613182137.GC29631@kroah.com>
In-Reply-To: <20180613182137.GC29631@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4104;7:a7dTTjY/OmGcarjvjy7pBLm2NoG84o9+w1jIBJULXmDtEv6q2jsruLc7YIHOMiJf3dioqpE6L6qNKA2EwKVCz3XgxhNBw2LCUdnWElSMUxupo8nsTA9vKnZfF9VDJhUA0Cd7mH+ykJ6Jn26CNHxUrRg5kFu4YUSn5cm4ql3RWysBHJefY4bf1i31LSb0BZxLcAd7vk9e+eMLHa+ZXLuC3D5A0OG3hYeCTPQilaMSfb8sBHE2LUY8X3IzSWIf1mIy;20:gjlkBECqeT/+j56WJY75uTYMFScrP1FLINswlq+qRqkIZiDmFQEwZh43LCH+EECilQmJTDXe/GhhnWsCq6ZYC1qGxRNvbdhzKoYhChK2PA7XiPoAzqoLIiXqEzKem76JoH5YfiwEVjV/19sgJmc1PZvXjhWROnSGwlMmeEU/pMU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 8ad53628-e22b-4814-32d6-08d5d15b4e4a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4104;
x-ms-traffictypediagnostic: BYAPR05MB4104:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB4104F78B8F63C45E7D4B3CD7D07E0@BYAPR05MB4104.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4104;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4104;
x-forefront-prvs: 07025866F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(97736004)(11346002)(5660300001)(8936002)(66066001)(8676002)(6436002)(6116002)(3846002)(33656002)(2616005)(3660700001)(6512007)(76176011)(82746002)(14454004)(3280700002)(81166006)(81156014)(6916009)(99286004)(2906002)(486006)(68736007)(478600001)(446003)(476003)(4326008)(5250100002)(575784001)(86362001)(83716003)(6246003)(305945005)(26005)(186003)(25786009)(53936002)(105586002)(2900100001)(316002)(102836004)(54906003)(6506007)(36756003)(6486002)(7736002)(106356001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4104;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: u0zJSaXjAKzm9KNCxxvietsPqOBzXRrEHldC6N+ZwFIRNrxIgBCL099DNCNoJxEcNTGOnW2QueDG8+CvsXWAzl+UYQegELFiVuTg1uTGjqP0KrvxzyoJX/karfVGQT5PcuPErsTna31hlaC9+io4LuLCdh0LIh92K93p6V3sgFFb4c+JKJYdbFWEZaS7QVGt
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7869200B11530B4D99D1C320BE790A78@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad53628-e22b-4814-32d6-08d5d15b4e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2018 18:27:22.6476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTE6MjEgQU0sIEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+IHdyb3RlOg0KDQo+IE9uIFdlZCwgSnVuIDEzLCAyMDE4IGF0IDA0OjAzOjU1QU0gLTA3MDAs
IE5hZGF2IEFtaXQgd3JvdGU6DQo+PiBXaGVuIGJhbGxvb24gYmF0Y2hpbmcgaXMgbm90IHN1cHBv
cnRlZCBieSB0aGUgaHlwZXJ2aXNvciwgdGhlIGd1ZXN0DQo+PiBmcmFtZSBudW1iZXIgKEdGTikg
bXVzdCBmaXQgaW4gMzItYml0LiBIb3dldmVyLCBkdWUgdG8gYSBidWcsIHRoaXMgY2hlY2sNCj4+
IHdhcyBtaXN0YWtlbmx5IGlnbm9yZWQuIEluIHByYWN0aWNlLCB3aGVuIHRvdGFsIFJBTSBpcyBn
cmVhdGVyIHRoYW4NCj4+IDE2VEIsIHRoZSBiYWxsb29uIGRvZXMgbm90IHdvcmsgY3VycmVudGx5
LCBtYWtpbmcgdGhpcyBidWcgdW5saWtlbHkgdG8NCj4+IGhhcHBlbi4NCj4+IA0KPj4gRml4ZXM6
IGVmMGY4ZjExMjk4NCAoIlZNd2FyZSBiYWxsb29uOiBwYXJ0aWFsbHkgaW5saW5lDQo+PiB2bWJh
bGxvb25fcmVzZXJ2ZV9wYWdlLiIpDQo+IA0KPiBXaHkgaGF2ZSBhIGJ1Z2ZpeCBhcyB0aGUgM3Jk
IHBhdGNoIG9mIHRoZSBzZXJpZXM/ICBQbGVhc2UgcHV0IGl0IGZpcnN0LA0KPiBzbyB0aGF0IGl0
IGNhbiBnZXQgaW50byBMaW51cydzIHRyZWUgc29vbmVyLg0KPiANCj4gQWxzbywgbm8gbmVlZCB0
byBsaW5lLXdyYXAgdGhpcywgYW5kIGRyb3AgdGhlIGJsYW5rIGxpbmUuDQo+IA0KPiBBbmQgZmlu
YWxseSwgZG9lcyB0aGlzIG5lZWQgdG8gZ28gdG8gdGhlIHN0YWJsZSBrZXJuZWxzPyAgSWYgc28s
IHBsZWFzZQ0KPiBhZGQgdGhlIGNvcnJlY3QgbGluZSBmb3IgdGhhdC4NCg0KSSB3aWxsIGZpeCB0
aGUgbWVzc2FnZS4gUGF0Y2hlcyAzLTcgZGVhbCB3aXRoIG1pbm9yIGJ1Z3MsIHNvbWUgb2Ygd2hp
Y2ggaGF2ZQ0KYmVlbiB0aGVyZSBzaW5jZSBkYXkgb25lLCBzbyBJIGRpZG7igJl0IHB1dCBhIOKA
nEZpeGVz4oCdIHRhZy4NCg0KSeKAmWxsIGZvbGxvdyB5b3VyIGRpcmVjdGlvbiBhbmQgcHV0IHBh
dGNoZXMgMS0yIGF0IHRoZSBlbmQuDQoNCg==
