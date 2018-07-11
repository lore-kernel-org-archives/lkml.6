Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E842C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F4D20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="IAX5mQ9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F4D20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389483AbeGKTQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:16:24 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:14256
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726457AbeGKTQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTXhXtKzZdRQgR7+tLsqwIN6jpymc7vE6c9N5UWX88U=;
 b=IAX5mQ9J38C2oyG0HCyp0VuLnh0sqPeieVH497ujse/aW2fnzDIZ2MV2fLOdKT5PkRQWqFfADKJvl+GwrKFyuc1R2ETeWUtGa6qydu2O8cJSG9iAqoDvCsi8YbMz09fq8EmJ1shN/6IfjxJBoQ/cK3EMD52RTVCJEFHegniNl4M=
Received: from DB6PR0502MB2901.eurprd05.prod.outlook.com (10.172.249.140) by
 DB6PR0502MB2902.eurprd05.prod.outlook.com (10.172.249.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Wed, 11 Jul 2018 19:10:38 +0000
Received: from DB6PR0502MB2901.eurprd05.prod.outlook.com
 ([fe80::68db:4d69:9ef5:f7e0]) by DB6PR0502MB2901.eurprd05.prod.outlook.com
 ([fe80::68db:4d69:9ef5:f7e0%2]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 19:10:38 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "jannh@google.com" <jannh@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "leon@kernel.org" <leon@kernel.org>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net v2] net/mlx5: fix uaccess beyond "count" in debugfs
 read/write handlers
Thread-Topic: [PATCH net v2] net/mlx5: fix uaccess beyond "count" in debugfs
 read/write handlers
Thread-Index: AQHUFWZ9EShNbOvOz0qKYfq8Ca06e6SKauUA
Date:   Wed, 11 Jul 2018 19:10:38 +0000
Message-ID: <063e455ca5fc8af9f888eb9afd03f24f4320db25.camel@mellanox.com>
References: <20180706201809.105152-1-jannh@google.com>
In-Reply-To: <20180706201809.105152-1-jannh@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0502MB2902;7:SgX0PVUN1dJjqrr2RhLlm6jbHi6GkjGoiuuw6sFjUpM+xDS8ztEzC969l3yZ+Kr19dbN+rD7esBXuHMrz8ymEoP+68tS56SGo7hWYAIPzkCRBPLIeWaEl9HcAu9C1dZz/0Yd8xjqXwB/HsLhK52P0Y9Ru82IswF8/tCHd1RpHvjBZiNJEMC1hm9sLLl7rCKsRSNobb9UXMTZ627pWBXdjOYV9RErveP7InM7GMomFwVYP0sKDHMCDqwOZMb5tuut
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 39c08413-4c1d-42e5-319e-08d5e761fcee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB2902;
x-ms-traffictypediagnostic: DB6PR0502MB2902:
x-microsoft-antispam-prvs: <DB6PR0502MB29027C90706F1AEB02E1E8BABE5A0@DB6PR0502MB2902.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705)(211936372134217)(153496737603132)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0502MB2902;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB2902;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(6246003)(256004)(476003)(3846002)(186003)(118296001)(106356001)(14444005)(2900100001)(105586002)(54906003)(14454004)(446003)(2616005)(6116002)(110136005)(11346002)(2906002)(25786009)(6506007)(305945005)(66066001)(76176011)(6486002)(36756003)(26005)(50226002)(2501003)(4326008)(99286004)(7736002)(6436002)(229853002)(102836004)(5250100002)(81166006)(2201001)(8676002)(8936002)(5660300001)(478600001)(97736004)(6512007)(53936002)(486006)(81156014)(316002)(86362001)(68736007)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB2902;H:DB6PR0502MB2901.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AU8lL4Ejp1wg3Uzf0dm4H31VKttamXSTNdy1f6cwzI1tR7o3kLti9KQx7bgmJpPTQ9YuSLLaMyT0dkYEjuJUG1eq5eB2jzm2jDOP6l5HYFCrYjww0EmXksLN1OyiaupGq5e0oNesGupHh1iY1SciZ6r0t4BnL0W/ggddokQ1EXQIkDR873N9DPa45scKRpt+i03ESa5nyJLEjAcWExbZ5W+N3PbaHP0z35w3T2zkuRxBu5sQtPa3MibCltRRYnrZwyTOytaLoQ7CDAboa48tVm8i7ApXHqYyHL5P5WaWImr7LT3XZG1UYo/jmSfEnIaNL3S657BS/u/XqVAwZgpG0NqjfWuCcxPQW5Rr0BVDm24=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <72918A0A00DFAC49B498D4A7054AE0BC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c08413-4c1d-42e5-319e-08d5e761fcee
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 19:10:38.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB2902
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA3LTA2IGF0IDIyOjE4ICswMjAwLCBKYW5uIEhvcm4gd3JvdGU6DQo+IElu
IGdlbmVyYWwsIGFjY2Vzc2luZyB1c2Vyc3BhY2UgbWVtb3J5IGJleW9uZCB0aGUgbGVuZ3RoIG9m
IHRoZQ0KPiBzdXBwbGllZA0KPiBidWZmZXIgaW4gVkZTIHJlYWQvd3JpdGUgaGFuZGxlcnMgY2Fu
IGxlYWQgdG8gYm90aCBrZXJuZWwgbWVtb3J5DQo+IGNvcnJ1cHRpb24NCj4gKHZpYSBrZXJuZWxf
cmVhZCgpL2tlcm5lbF93cml0ZSgpLCB3aGljaCBjYW4gZS5nLiBiZSB0cmlnZ2VyZWQgdmlhDQo+
IHN5c19zcGxpY2UoKSkgYW5kIHByaXZpbGVnZSBlc2NhbGF0aW9uIGluc2lkZSB1c2Vyc3BhY2Uu
DQo+IA0KPiBJbiB0aGlzIGNhc2UsIHRoZSBhZmZlY3RlZCBmaWxlcyBhcmUgaW4gZGVidWdmcyAo
YW5kIHNob3VsZCB0aGVyZWZvcmUNCj4gb25seQ0KPiBiZSBhY2Nlc3NpYmxlIHRvIHJvb3QpIGFu
ZCBjaGVjayB0aGF0ICpwb3MgaXMgemVybyAod2hpY2ggcHJldmVudHMNCj4gdGhlDQo+IHN5c19z
cGxpY2UoKSB0cmljaykuIFRoZXJlZm9yZSwgdGhpcyBpcyBub3QgYSBzZWN1cml0eSBmaXgsIGJ1
dA0KPiByYXRoZXIgYQ0KPiBzbWFsbCBjbGVhbnVwLg0KPiANCj4gRm9yIHRoZSByZWFkIGhhbmRs
ZXJzLCBmaXggaXQgYnkgdXNpbmcgc2ltcGxlX3JlYWRfZnJvbV9idWZmZXIoKQ0KPiBpbnN0ZWFk
IG9mDQo+IGN1c3RvbSBsb2dpYy4NCj4gRm9yIHRoZSB3cml0ZSBoYW5kbGVyLCBhZGQgYSBjaGVj
ay4NCj4gDQo+IGNoYW5nZWQgaW4gdjI6DQo+ICAtIGFsc28gZml4IGRiZ193cml0ZSgpDQo+IA0K
PiBGaXhlczogZTEyNmJhOTdkYmE5ICgibWx4NTogQWRkIGRyaXZlciBmb3IgTWVsbGFub3ggQ29u
bmVjdC1JQg0KPiBhZGFwdGVycyIpDQo+IFNpZ25lZC1vZmYtYnk6IEphbm4gSG9ybiA8amFubmhA
Z29vZ2xlLmNvbT4NCj4gDQoNCkFwcGxpZWQgdG8gbWx4NS1uZXh0LCBUaGFua3MhIQ0K
