Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE99C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 11:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC3721721
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 11:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Lf/fQTru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfAFLAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 06:00:33 -0500
Received: from mail-eopbgr60120.outbound.protection.outlook.com ([40.107.6.120]:60416
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfAFLAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 06:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdtblxhV74nAZZaOS9ZaeLenc8Ysbmd2yQR8CMaGr2k=;
 b=Lf/fQTruAVIWYxYK6P0IUci0Sl0Uqojyl8hWeLnFPSLkVO7D1LnBgyycPhcTw7ZO0N6LWqXM9v4mfo6bdXENfrsxX9YzZakQwdjqoAmSYTz1mIQuNvhIxLifyJ4yGuL/6aZd2GzwQAq5/oTpcNCO7eh8DYWML3w4m2XC9eK+WgU=
Received: from DB7PR08MB3771.eurprd08.prod.outlook.com (20.178.47.26) by
 DB7PR08MB3787.eurprd08.prod.outlook.com (20.178.84.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.10; Sun, 6 Jan 2019 11:00:24 +0000
Received: from DB7PR08MB3771.eurprd08.prod.outlook.com
 ([fe80::83:10e6:94a0:6bb8]) by DB7PR08MB3771.eurprd08.prod.outlook.com
 ([fe80::83:10e6:94a0:6bb8%4]) with mapi id 15.20.1495.011; Sun, 6 Jan 2019
 11:00:24 +0000
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Westphal <fw@strlen.de>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com" 
        <syzbot+7713f3aa67be76b1552c@syzkaller.appspotmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "bridge@lists.linux-foundation.org" 
        <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH v2] netfilter: account ebt_table_info to kmemcg
Thread-Topic: [PATCH v2] netfilter: account ebt_table_info to kmemcg
Thread-Index: AQHUoxJ4/Xmbwt4hu0KymQz2SLq3QKWiF9eA
Date:   Sun, 6 Jan 2019 11:00:24 +0000
Message-ID: <5cc8efad-9d3d-3136-3ddc-1f8a640cb1f8@virtuozzo.com>
References: <20190103031431.247970-1-shakeelb@google.com>
In-Reply-To: <20190103031431.247970-1-shakeelb@google.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0166.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::14) To DB7PR08MB3771.eurprd08.prod.outlook.com
 (2603:10a6:10:7c::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.69.177.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR08MB3787;20:HFdwqPcsZHM1qpYAQle5Ahk4VT1Cx04xQ3qMd/VoRHEtYa2sBl9jrZEuypFV9CVOTDG27Q4QtGraqoBYvecT4SRaWdXRxea0ZFEdHOxIzW8WCImKjo3+tPTAT3rMK8dWWV4UB57zj4FANXs3edfBmdmGQcjbNns5uuGv3VKScEc=
x-ms-office365-filtering-correlation-id: f26f57ff-16a1-4f2a-adda-08d673c627e4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3787;
x-ms-traffictypediagnostic: DB7PR08MB3787:
x-microsoft-antispam-prvs: <DB7PR08MB3787D26C9C6A9EB7DB6CAEA2CD880@DB7PR08MB3787.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(10201501046)(93006095)(93001095)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR08MB3787;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3787;
x-forefront-prvs: 09090B6B69
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39840400004)(346002)(136003)(376002)(54534003)(199004)(189003)(99286004)(186003)(36756003)(26005)(31686004)(110136005)(66066001)(15650500001)(106356001)(81156014)(8936002)(105586002)(81166006)(575784001)(54906003)(316002)(6512007)(86362001)(256004)(14444005)(52116002)(4326008)(76176011)(97736004)(486006)(71190400001)(53546011)(6506007)(8676002)(386003)(7736002)(55236004)(305945005)(102836004)(71200400001)(476003)(2616005)(11346002)(446003)(6246003)(478600001)(68736007)(6486002)(53936002)(31696002)(6436002)(229853002)(2906002)(25786009)(6116002)(3846002)(7416002)(14454004)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3787;H:DB7PR08MB3771.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QlF1OaYwUfDJkQgJImIMcFeDZDFQGJCkSlzfg9q+q5/YNrIQQf5QvFS861g3r7/Y30b4J2ry20CEj3oncauRO2t+cs5H1wvASXLxiG4HGbsGhveKZHQvlJjGjs6WAwqUMkfognamLsFrgk5MkQ3wNqlHlmteJlZvRn4JQ/UC4Jh+PqtC4GqAWWD4UtdaidxBd4RW4xD9UbsJS+mhdbp7Ow75AnWR4xBns0srWtrwl0cS/82M1hWlUmuOiuNIgGTbNoAvJwwjs6LfuRE34ulf+GkoU4zHeXsk7cXZJBUwfYAcTamX49RnD2y/YfG2Mga4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <44C40DD317502844B1969825E000CB76@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26f57ff-16a1-4f2a-adda-08d673c627e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2019 11:00:21.0687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDEuMjAxOSAwNjoxNCwgU2hha2VlbCBCdXR0IHdyb3RlOg0KPiBUaGUgW2lwLGlwNixh
cnBdX3RhYmxlcyB1c2UgeF90YWJsZXNfaW5mbyBpbnRlcm5hbGx5IGFuZCB0aGUgdW5kZXJseWlu
Zw0KPiBtZW1vcnkgaXMgYWxyZWFkeSBhY2NvdW50ZWQgdG8ga21lbWNnLiBEbyB0aGUgc2FtZSBm
b3IgZWJ0YWJsZXMuIFRoZQ0KPiBzeXpib3QsIGJ5IHVzaW5nIHNldHNvY2tvcHQoRUJUX1NPX1NF
VF9FTlRSSUVTKSwgd2FzIGFibGUgdG8gT09NIHRoZQ0KPiB3aG9sZSBzeXN0ZW0gZnJvbSBhIHJl
c3RyaWN0ZWQgbWVtY2csIGEgcG90ZW50aWFsIERvUy4NCj4gDQo+IEJ5IGFjY291bnRpbmcgdGhl
IGVidF90YWJsZV9pbmZvLCB0aGUgbWVtb3J5IHVzZWQgZm9yIGVidF90YWJsZV9pbmZvIGNhbg0K
PiBiZSBjb250YWluZWQgd2l0aGluIHRoZSBtZW1jZyBvZiB0aGUgYWxsb2NhdGluZyBwcm9jZXNz
LiBIb3dldmVyIHRoZQ0KPiBsaWZldGltZSBvZiBlYnRfdGFibGVfaW5mbyBpcyBpbmRlcGVuZGVu
dCBvZiB0aGUgYWxsb2NhdGluZyBwcm9jZXNzIGFuZA0KPiBpcyB0aWVkIHRvIHRoZSBuZXR3b3Jr
IG5hbWVzcGFjZS4gU28sIHRoZSBvb20ta2lsbGVyIHdpbGwgbm90IGJlIGFibGUgdG8NCj4gcmVs
aWV2ZSB0aGUgbWVtb3J5IHByZXNzdXJlIGR1ZSB0byBlYnRfdGFibGVfaW5mbyBtZW1vcnkuIFRo
ZSBtZW1vcnkgZm9yDQo+IGVidF90YWJsZV9pbmZvIGlzIGFsbG9jYXRlZCB0aHJvdWdoIHZtYWxs
b2MuIEN1cnJlbnRseSB2bWFsbG9jIGRvZXMgbm90DQo+IGhhbmRsZSB0aGUgb29tLWtpbGxlZCBh
bGxvY2F0aW5nIHByb2Nlc3MgY29ycmVjdGx5IGFuZCBvbmUgbGFyZ2UNCj4gYWxsb2NhdGlvbiBj
YW4gYnlwYXNzIG1lbWNnIGxpbWl0IGVuZm9yY2VtZW50LiBTbywgd2l0aCB0aGlzIHBhdGNoLA0K
PiBhdCBsZWFzdCB0aGUgc21hbGwgYWxsb2NhdGlvbnMgd2lsbCBiZSBjb250YWluZWQuIEZvciBs
YXJnZSBhbGxvY2F0aW9ucywNCj4gd2UgbmVlZCB0byBmaXggdm1hbGxvYy4NCj4gDQo+IFJlcG9y
dGVkLWJ5OiBzeXpib3QrNzcxM2YzYWE2N2JlNzZiMTU1MmNAc3l6a2FsbGVyLmFwcHNwb3RtYWls
LmNvbQ0KPiBTaWduZWQtb2ZmLWJ5OiBTaGFrZWVsIEJ1dHQgPHNoYWtlZWxiQGdvb2dsZS5jb20+
DQo+IENjOiBGbG9yaWFuIFdlc3RwaGFsIDxmd0BzdHJsZW4uZGU+DQo+IENjOiBNaWNoYWwgSG9j
a28gPG1ob2Nrb0BrZXJuZWwub3JnPg0KPiBDYzogS2lyaWxsIFRraGFpIDxrdGtoYWlAdmlydHVv
enpvLmNvbT4NCj4gQ2M6IFBhYmxvIE5laXJhIEF5dXNvIDxwYWJsb0BuZXRmaWx0ZXIub3JnPg0K
PiBDYzogSm96c2VmIEthZGxlY3NpayA8a2FkbGVjQGJsYWNraG9sZS5rZmtpLmh1Pg0KPiBDYzog
Um9vcGEgUHJhYmh1IDxyb29wYUBjdW11bHVzbmV0d29ya3MuY29tPg0KPiBDYzogTmlrb2xheSBB
bGVrc2FuZHJvdiA8bmlrb2xheUBjdW11bHVzbmV0d29ya3MuY29tPg0KPiBDYzogQW5kcmV3IE1v
cnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IExpbnV4IE1NIDxsaW51eC1t
bUBrdmFjay5vcmc+DQo+IENjOiBuZXRmaWx0ZXItZGV2ZWxAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBjb3JldGVhbUBuZXRmaWx0ZXIub3JnDQo+IENjOiBicmlkZ2VAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcNCj4gQ2M6IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IC0t
LQ0KPiBDaGFuZ2Vsb2cgc2luY2UgdjE6DQo+IC0gTW9yZSBkZXNjcmlwdGl2ZSBjb21taXQgbWVz
c2FnZS4NCg0KUmV2aWV3ZWQtYnk6IEtpcmlsbCBUa2hhaSA8a3RraGFpQHZpcnR1b3p6by5jb20+
DQoNCj4gDQo+ICBuZXQvYnJpZGdlL25ldGZpbHRlci9lYnRhYmxlcy5jIHwgNiArKysrLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbmV0L2JyaWRnZS9uZXRmaWx0ZXIvZWJ0YWJsZXMuYyBiL25ldC9icmlkZ2Uv
bmV0ZmlsdGVyL2VidGFibGVzLmMNCj4gaW5kZXggNDkxODI4NzEzZTBiLi41ZTU1Y2VmMGNlYzMg
MTAwNjQ0DQo+IC0tLSBhL25ldC9icmlkZ2UvbmV0ZmlsdGVyL2VidGFibGVzLmMNCj4gKysrIGIv
bmV0L2JyaWRnZS9uZXRmaWx0ZXIvZWJ0YWJsZXMuYw0KPiBAQCAtMTEzNywxNCArMTEzNywxNiBA
QCBzdGF0aWMgaW50IGRvX3JlcGxhY2Uoc3RydWN0IG5ldCAqbmV0LCBjb25zdCB2b2lkIF9fdXNl
ciAqdXNlciwNCj4gIAl0bXAubmFtZVtzaXplb2YodG1wLm5hbWUpIC0gMV0gPSAwOw0KPiAgDQo+
ICAJY291bnRlcnNpemUgPSBDT1VOVEVSX09GRlNFVCh0bXAubmVudHJpZXMpICogbnJfY3B1X2lk
czsNCj4gLQluZXdpbmZvID0gdm1hbGxvYyhzaXplb2YoKm5ld2luZm8pICsgY291bnRlcnNpemUp
Ow0KPiArCW5ld2luZm8gPSBfX3ZtYWxsb2Moc2l6ZW9mKCpuZXdpbmZvKSArIGNvdW50ZXJzaXpl
LCBHRlBfS0VSTkVMX0FDQ09VTlQsDQo+ICsJCQkgICAgUEFHRV9LRVJORUwpOw0KPiAgCWlmICgh
bmV3aW5mbykNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gIAlpZiAoY291bnRlcnNpemUp
DQo+ICAJCW1lbXNldChuZXdpbmZvLT5jb3VudGVycywgMCwgY291bnRlcnNpemUpOw0KPiAgDQo+
IC0JbmV3aW5mby0+ZW50cmllcyA9IHZtYWxsb2ModG1wLmVudHJpZXNfc2l6ZSk7DQo+ICsJbmV3
aW5mby0+ZW50cmllcyA9IF9fdm1hbGxvYyh0bXAuZW50cmllc19zaXplLCBHRlBfS0VSTkVMX0FD
Q09VTlQsDQo+ICsJCQkJICAgICBQQUdFX0tFUk5FTCk7DQo+ICAJaWYgKCFuZXdpbmZvLT5lbnRy
aWVzKSB7DQo+ICAJCXJldCA9IC1FTk9NRU07DQo+ICAJCWdvdG8gZnJlZV9uZXdpbmZvOw0KPiAN
Cg0K
