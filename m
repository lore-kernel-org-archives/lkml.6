Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF88CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE9A2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="PoHz4P2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfBKTMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:12:55 -0500
Received: from mail-eopbgr780083.outbound.protection.outlook.com ([40.107.78.83]:43384
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731993AbfBKTMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7SY6fS/6xh84fMhknWdfY+1oHjWqYT+WVzQP1jp8XQ=;
 b=PoHz4P2lcN/Oa81vgRPhrw8NoGxcH6ANRZkfj9inRiHfCOTpMZl1ejAdcMEcpeZkbD1XyfJjDy61jxfhulca8XFlhHPuD3wcCV3K2mFJDtfKkHL2GXkeXvqQBmHxDCPkbchAtyR/IK/UetgjZjctae0TZxFolca0dORqdBIcN/4=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4887.namprd05.prod.outlook.com (52.135.235.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.15; Mon, 11 Feb 2019 19:12:41 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::99ab:18fb:f393:df31%3]) with mapi id 15.20.1622.016; Mon, 11 Feb 2019
 19:12:41 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Julien Freche <jfreche@vmware.com>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] vmw_balloon: release lock on error in vmballoon_reset()
Thread-Topic: [PATCH] vmw_balloon: release lock on error in vmballoon_reset()
Thread-Index: AQHUwjoOYf9D88vwg0+0GFI5wJvZV6Xa9w8A
Date:   Mon, 11 Feb 2019 19:12:40 +0000
Message-ID: <A3173F98-AE61-48DF-8AA8-6757C3C086F7@vmware.com>
References: <20190211184545.GC22106@kadam>
In-Reply-To: <20190211184545.GC22106@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4887;20:3LPt8TzuIBtgkSDgt3lON2WyKaC4VyFZeFZD/8znzI2UkQykIg+uV9Wm5TpQS/NSJyag8qKYzlgAmijoe1ACOfjVaHMSyBYSitn0fkh8adOAeXRiXDVVSEqv6Yi6UztzdvBXI3On7zHuUZuN0CtYfAE3eEIRQnyHwxz8VH+JEkY=
x-ms-office365-filtering-correlation-id: df305bb3-86f2-4bec-5b74-08d69054e4d5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4887;
x-ms-traffictypediagnostic: BYAPR05MB4887:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB4887610982E8C91290978631D0640@BYAPR05MB4887.namprd05.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(53546011)(102836004)(6486002)(486006)(229853002)(106356001)(476003)(2616005)(11346002)(316002)(446003)(82746002)(97736004)(6506007)(256004)(3846002)(14444005)(6116002)(186003)(26005)(68736007)(36756003)(2906002)(86362001)(8936002)(71190400001)(71200400001)(83716004)(4744005)(81156014)(81166006)(99286004)(33656002)(66066001)(76176011)(6436002)(8676002)(110136005)(54906003)(7736002)(53936002)(6512007)(6246003)(105586002)(25786009)(478600001)(305945005)(4326008)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4887;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 00bCMD3sxQnRhBBY32Uak8KU0w6pDTO8ulb7sxb5C8B1xJwLMHWOA9asH8D6ow5ds1zSx3JfrfGv+jVtg5s5Mo81E1LJnbXNVQ3meu6CPKEsQ5175a0i9yLd3knHkYa04NqfEn1n/Ijz8rBF/Kj8Ac9dIagholWhcxkQQMVKTKwtvEMDGWJoHKG1C+YGnF24ItaN9eO1LmFt6tUjLUTA7NavxsITZHvY+iEHqqPE5A/mgvOiaoMQDsH81vANuGySgbLmzWYClQYbiQU2XjLaZ9noTL/JPRa5DCSze3pgPBZ9NnosC9njAvNftV9hnYdNPLaW+DPQZ4/TG4bsbsDa5R3IwEtmkiv8KAOUI/oN7oFaDWI3U0yRabfWP3xSDtKgGSA0UtSY16LOFEz821a9T4T4fJNGsVxlGwHHRFMKNn8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31142581715661478BC3BD1CBCB0AC9E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df305bb3-86f2-4bec-5b74-08d69054e4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 19:12:40.9033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4887
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGZWIgMTEsIDIwMTksIGF0IDEwOjQ1IEFNLCBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVu
dGVyQG9yYWNsZS5jb20+IHdyb3RlOg0KPiANCj4gV2UgYWRkZWQgc29tZSBsb2NraW5nIHRvIHRo
aXMgZnVuY3Rpb24gYnV0IGZvcmdvdCB0byBkcm9wIHRoZSBsb2NrIG9uDQo+IHRoZXNlIHR3byBl
cnJvciBwYXRocy4gIFRoaXMgYnVnIHdvdWxkIGxlYWQgdG8gYW4gaW1tZWRpYXRlIGRlYWRsb2Nr
Lg0KPiANCj4gRml4ZXM6IGM3YjM2OTBmYjE1MiAoInZtd19iYWxsb29uOiBzdGF0cyByZXdvcmsi
KQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5j
b20+DQoNCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQpSZXZpZXdlZC1ieTogTmFkYXYgQW1p
dCA8bmFtaXRAdm13YXJlLmNvbT4NCg0KLS0NCg0KWWVzLCBJIHNjcmV3ZWQgdXAuIFRoYW5rcyBm
b3IgY2F0Y2hpbmcgaXQhDQoNCknigJlsbCBnbyB0byBjaGVjayB3aHkgbXkgZXJyb3IgaW5qZWN0
aW9uIHRlc3RzIGRpZG7igJl0IGNhdGNoIGl0Lg0KDQo=
