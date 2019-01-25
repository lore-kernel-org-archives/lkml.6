Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C95C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D3F21872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="e3B5hMpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfAYUb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:31:29 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12594 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfAYUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:31:29 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4b71fa0000>; Fri, 25 Jan 2019 12:30:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 12:31:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 12:31:27 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 20:31:26 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.52) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 25 Jan 2019 20:31:26 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3447.namprd12.prod.outlook.com (20.178.196.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Fri, 25 Jan 2019 20:31:08 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 20:31:08 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Thread-Index: AQHUtCaoqz5N11EqJkeckmeQlifKWKXAYa0AgAANI4A=
Date:   Fri, 25 Jan 2019 20:31:08 +0000
Message-ID: <BYAPR12MB339829FC6F2F95F833FE45A1C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
 <dcc1e094-638e-5b04-7a61-bdbc24ee068f@gmail.com>
In-Reply-To: <dcc1e094-638e-5b04-7a61-bdbc24ee068f@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3447;6:4LUqD/JaRkfBWMJvdMRK1JtSliIO6Q57nESgAjNQIt+G7Fw0RcPlfDxfYVrOH0j3J3DZeiP2yiLjuxvOvnbK/S6yREk4xrSja9m5P47FPRkrWCiIO83xSqt4HR+UAJ829tmupN/WyvhJF/bOKJzEXtYxr9RJw0WbR5NHOQn4RQxjhW3oKnncLl3LMpcf2W+OWZsLcHm1Pk6dDAiOKVyB+mFzTZaQIyU7SgfSqgOFY66vc99DL6d45hjM2DMKXWOZh8HgGHnNieqc83Efru2RFrijaUN7fgryyF2TDURhCwDNs1NI9jOLez0alP1YTCnCm3GjN0G7TtCCbGZXan2NkDSwELjRKRIIPWtK2kY17PKs7BCECx2SDThq/030FyTkgP1Q0O/TsxZX80nfi/fXsnEga9X1WpkraMady7G+5xA2srvqLqE/OqMtgYJl8BX7uWpxS+QTHtbfG+7d9NB+oQ==;5:Ykw9hJyTzvbW4DmxmRtAIYEhu2ubsA9Dc42737Fm3335EbVLjt0APiBItEE/1T3f/ACi2OlEBOjvSkGFYVL/pT1e/D+KwWG4YFuC4Ty7iJAWFffKtm7erHaYm0lJFoEZrNmZ6FIZJTqWp1SRu/2DgMWnaijHyCytnCZCzoEEfYHl49ODnkH5qBsKjvXsMBOWwoe8c5zQJWJiWSLvkO3IkA==;7:eNbsrB05kC4oXyCH650rm9Bo+DwNWYmw/3F8eHae7HAgRhSAo1QB8iv6QvLGfDyBZHvF+qdImCSR/ZQZWHRUhoVkF7ETWZ13T8FL954wQqpdjjfzNPMWqYEAj7r51YSH72P2P0ZHj4DrvCFHV+X11w==
x-ms-office365-filtering-correlation-id: b48a5cb9-1080-4a41-014b-08d6830409f1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3447;
x-ms-traffictypediagnostic: BYAPR12MB3447:
x-microsoft-antispam-prvs: <BYAPR12MB3447EB606791516A4B215C07C29B0@BYAPR12MB3447.namprd12.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(97736004)(71200400001)(102836004)(39060400002)(71190400001)(229853002)(54906003)(6116002)(6506007)(2906002)(110136005)(3846002)(476003)(186003)(486006)(2501003)(6246003)(316002)(14444005)(26005)(6636002)(256004)(74316002)(9686003)(11346002)(86362001)(55016002)(25786009)(14454004)(446003)(4744005)(33656002)(8936002)(99286004)(478600001)(66066001)(6436002)(4326008)(7736002)(76176011)(305945005)(68736007)(7696005)(53936002)(81166006)(8676002)(81156014)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3447;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kBf9ZtcDiwsA8uym+ReZkgw3ntdjtTunFkHyk60D8sFn1i6ZXwettyrV5bXaaFccrdcuBy7s/HWSvFRVnb9mR2fx/yb09EGGkk9UT3kWYatjOtyFw6uWXwxnMpP3/QHUwZ4phtQKlOCaIkaJdNemhjYMx5zHsKbwKpuqE5y/8mDLMhYB//O/+3OTGkVGRMRfog/qPCIF1pNExUNO3nPXxb/MBXYvcEuojdN4RWdPEeqtAdK3fqVwdrMRlJfE6oCxP3oo/IDFFMcgHIbl6o8MG6YQBzDLzjpOHgYWQgYBKN020nrCHCUW7knWKMv8NYOOy3jvtCkEYmcxC8JQpIcUkeTo2eWwA7JgJlB1nMH7fhVzwrxR7o+pd0SQ2hlsaJT/RVDzH+2C7a9wBVCQg8Q7aBxr2j7H4BI8fm9ofqon9yA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b48a5cb9-1080-4a41-014b-08d6830409f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 20:31:08.6939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3447
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548448250; bh=kP9XGxXBYwbpJsEDaneEtCHYkaIpId07iklOEhHA4LA=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=e3B5hMpBVfDYzp/ih0n3nFq/orAgxlql/j3doFtbuqsSt+j8cq8tvX4xdd4MZYO05
         Bsb366KMhNM4h3SAdcghmQt06AUB+Gyl4ycRbUFs7czBSz4ZbTwU9Uxo6oOhliA4PB
         GftLaa+51leNkx1vXlBQtccGDEBf9tDK+RZy6TkCx7J33TkP+5+0t48neD9EyyCmrp
         Av/tN1Qhe5ujafFyiBgjtdu86NNYiQERCpnEv+OG0+YDuZ3Fe+bJ2Pm0dSFt6Now1k
         nthtR9bzDwEXgecVVVhb34Ji1VsUn6joJqTxBVybKL3tJIZBNKGkEaUJEuIJgYt89P
         g4aP2foD4z8VQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gKwlpZiAoaTJjX2Rldi0+aGFzX2RtYSkgew0KPiA+ICsJCXJldCA9IHRlZ3JhX2kyY19p
bml0X2RtYV9wYXJhbShpMmNfZGV2LCB0cnVlKTsNCj4gPiArCQlpZiAocmV0ID09IC1FUFJPQkVf
REVGRVIpDQo+ID4gKwkJCWdvdG8gZGlzYWJsZV9kaXZfY2xrOw0KPiA+ICsJCXJldCA9IHRlZ3Jh
X2kyY19pbml0X2RtYV9wYXJhbShpMmNfZGV2LCBmYWxzZSk7DQo+ID4gKwkJaWYgKHJldCA9PSAt
RVBST0JFX0RFRkVSKQ0KPiA+ICsJCQlnb3RvIGRpc2FibGVfZGl2X2NsazsNCj4NCj4gU28gdGVn
cmFfaTJjX2luaXRfZG1hX3BhcmFtKCkgY291bGQgZmFpbCwgcHJpbnRpbmcgYSBlcnJvciBtZXNz
YWdlLCBhbmQgcHJvYmUgd2lsbCBzdWNjZWVkPyBJZiBhbGxvY2F0aW9uIGZhaWxzIGR1cmluZyB0
aGUgZHJpdmVyJ3MgcHJvYmUsIHRoZW4ganVzdCBmYWlsIHRoZSBwcm9iZS4gUGxlYXNlIGdpdmUg
dGhlIHJhdGlvbmFsZS4NCg0KSWYgQVBCIERNQSBwcm9iZSBkb2VzbuKAmXQgaGFwcGVuIHByaW9y
IHRvIHRlZ3JhIGkyYywgRE1BIGlzIG5vdCBhdmFpbGFibGUgYnkgdGhlIHRpbWUgdGVncmFfaW5p
dF9kbWFfcGFyYW0gdHJpZXMgdG8gcmVxdWVzdCBzbGF2ZSBjaGFubmVsIGFuZCBpbiB0aG9zZSBj
YXNlcyBkbWFfcmVxdWVzdF9zbGF2ZV9jaGFubmVsX3JlYXNvbiB3aWxsIHJldHVybiBFUFJPQkVf
REVGRVIgZm9yIHRlZ3JhIEkyQyBwcm9iZSB0byByZXRyeQ0KDQpJbiBjYXNlIGlmIERNQSBpcyBh
dmFpbGFibGUgYnV0IERNQSBidWZmZXIgYWxsb2NhdGlvbiBmYWlscywgdGhlbiB0ZWdyYV9pMmNf
aW5pdF9kbWFfcGFyYW0gcmV0dXJucyBFTk9NRU0gYW5kIHByb2JlIGFsc28gZmFpbHMgcmV0dXJu
aW5nIHNhbWUgRU5PTUVNDQoNClRoYW5rcw0KU293amFueWENCg0K
