Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFFC214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=landisgyr.com header.i=@landisgyr.com header.b="JqT725jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFFC214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landisgyr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbeKUXjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:39:55 -0500
Received: from mail-eopbgr10108.outbound.protection.outlook.com ([40.107.1.108]:62272
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727046AbeKUXjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQClCeoi/FZUYcPeqgdHgESkh0C27VAmt5GW6H2aYcM=;
 b=JqT725jnizDNAOZKrsmdpS8xikKxF2FH8KPS7LsOox+yQKsxBnmiA+W63K8UImhcghlXVZgZ9JxBmn4PIItmGihsxXmVLO3t/3xi636vfTYa6JwwJ9OdjAUO0xXIItNOoi1AZnwhs1N3KOXBd6PEDbb6Y0id8iZR5Cl1D4p8QuU=
Received: from AM6PR01MB4262.eurprd01.prod.exchangelabs.com (20.176.242.28) by
 AM6PR01MB4152.eurprd01.prod.exchangelabs.com (20.177.38.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 21 Nov 2018 13:05:32 +0000
Received: from AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 ([fe80::d547:38d1:d542:d499]) by AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 ([fe80::d547:38d1:d542:d499%4]) with mapi id 15.20.1361.013; Wed, 21 Nov 2018
 13:05:32 +0000
From:   "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
CC:     "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PATCH net : Micrel KSZ8061 PHY link failure after cable connect
Thread-Topic: PATCH net : Micrel KSZ8061 PHY link failure after cable connect
Thread-Index: AQHUgZrimVVhydpjB0ei4ScsvbakDQ==
Date:   Wed, 21 Nov 2018 13:05:32 +0000
Message-ID: <1542805518-10707-1-git-send-email-alexander.onnasch@landisgyr.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0052.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::41) To AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:20::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Onnasch@landisgyr.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.239.165.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR01MB4152;6:x1Vva4pjY3nC+GzMMH2qy4QKOGKZmue8Mmyg5O+fnAVbCE7bUeUV2XKslXOJB4uTsC5SsBzL5ksbh5jidglPwrfrLvsHIyBxLvLdUqBHE85iETrg+XcZDHo8pU/0TaYpBcwlXY6YrLxYxbYkjiUXGjWGw2EhEz6xe56BQCUbNEhCSBxNEqvz5s/nwZtsJd3B9U32/wa9vF7iiEeiFFIPAcSh3sNrAyYx6/Vjh0xUB8ozvLntAdWH3UWDoRrqZifl3AVJ3xJwX4tQhukFOBP6TpwKOhx645e9RXw7v18d/soA2zH4SrPG5Hv017jwCaOOQpBrt2KmnVMHc6sIYHkI2OE5qVdPQC+1wg19Y0/UJ+/vEqWCK0DuWqNXB11B6NaGA0ua9EAS0QbZFenfJU0+0XHHOxaeLmSBuBgW9KSqqErBafMp5Yu8JbG5N2INdLnOLkUsPzyEv+KzbxUzjkSi0Q==;5:MosUTAmkGRdVOYrzCA7aq7u34K2ktyuTIES/OhmrosGG30MrkgCY8WHrTDfOsxa3hdUmyIpm4en7k1ViP2ewtb2zwNCGL24duEvxKn2JlTt7JnEFwbpYwLuH0KinpsUI9MZK7TEpP5hXHZSXARAe4kuVN9zcYFxwbcC1tBUksAc=;7:195k/3kYz9ePoXJUeaSdiXrWUu7lDL0FeaShdXeCrPosKzRG46wX6uAb37AWmPJqnTcgiQHAg4mS6yfBszYeZtMq/Uh4zEUmQ9aaUk2fi/fG7x6FuKYjqPjTVwf4lzzu/KHuuRfyVtbTjFBqtfPRpw==
x-ms-office365-filtering-correlation-id: efb0a6af-c307-4089-ae74-08d64fb20476
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR01MB4152;
x-ms-traffictypediagnostic: AM6PR01MB4152:
x-microsoft-antispam-prvs: <AM6PR01MB415254D025587B79A78390E2F0DA0@AM6PR01MB4152.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(21532816269658)(84791874153150)(144836121648609);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231442)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR01MB4152;BCL:0;PCL:0;RULEID:;SRVR:AM6PR01MB4152;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(39860400002)(136003)(396003)(189003)(199004)(105586002)(97736004)(14454004)(478600001)(26005)(6486002)(54906003)(71190400001)(2906002)(6436002)(71200400001)(1671002)(5660300001)(102836004)(2900100001)(99286004)(52116002)(6506007)(386003)(256004)(316002)(14444005)(2616005)(86362001)(6512007)(7736002)(305945005)(186003)(39060400002)(109986005)(36756003)(3846002)(6116002)(66066001)(25786009)(72206003)(8936002)(81156014)(53936002)(81166006)(8676002)(68736007)(106356001)(4326008)(476003)(59246006)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR01MB4152;H:AM6PR01MB4262.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: landisgyr.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SwxF03bWXuUBIZve8ABXl9mVafDM5VjKjcTcgmP3OCKZPQhmQdJvNPBxuUA/JqX20IEjVj2xfqMSyAOhiMhRmEnbnUz+I2ZM7g3Mu1ggSFWodtvbX23/swO+LtjaBUkFv0Hn04b0utMpBGC+QNjGnZI5FdqPOE8zY8blOQwsUcj2NVq/TqJqgeve+mroFKSvCRvMiWs0F/8MeGKINpKTVz7iLhb7s/qkpZkhMt3MaYZrqF5oxS/4OoFTPmlgIFwr9QsNWLmoY/K8WgvQIct6GnwAoluMDSXfOnthnz6nzGoB7pprBwSmv8PwFw7WRI7gxZFLGmb7wY1xL5WaRnJgXsd609Me1G3Tk6Q0TihPH4k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D01D665070E77F4A996D39BA4C932977@eurprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb0a6af-c307-4089-ae74-08d64fb20476
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 13:05:32.0757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR01MB4152
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCkZvciB0cmVlOiBnaXQ6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZGF2ZW0vbmV0LmdpdA0K
DQpXaXRoIE1pY3JlbCBLU1o4MDYxIFBIWSwgdGhlIGxpbmsgbWF5IG9jY2FzaW9uYWxseSBub3Qg
Y29tZSB1cCBhZnRlcg0KRXRoZXJuZXQgY2FibGUgY29ubmVjdC4gVGhlIHZlbmRvcidzIChNaWNy
b2NoaXAsIGZvcm1lciBNaWNyZWwpIGVycmF0YQ0Kc2hlZXQgODAwMDA2ODhBLnBkZiBkZXNjcmli
ZXMgdGhlIHByb2JsZW0gYW5kIHBvc3NpYmxlIHdvcmthcm91bmRzIGluDQpkZXRhaWwsIHNlZSBi
ZWxvdy4NClRoZSBwYXRjaCBpbXBsZW1lbnRzIHdvcmthcm91bmQgMSwgd2hpY2ggcGVybWFuZW50
bHkgZml4ZXMgdGhlIGlzc3VlLg0KDQpERVNDUklQVElPTg0KTGluay11cCBtYXkgbm90IG9jY3Vy
IHByb3Blcmx5IHdoZW4gdGhlIEV0aGVybmV0IGNhYmxlIGlzIGluaXRpYWxseQ0KY29ubmVjdGVk
LiBUaGlzIGlzc3VlIG9jY3VycyBtb3JlIGNvbW1vbmx5IHdoZW4gdGhlIGNhYmxlIGlzIGNvbm5l
Y3RlZA0Kc2xvd2x5LCBidXQgaXQgbWF5IG9jY3VyIGFueSB0aW1lIGEgY2FibGUgaXMgY29ubmVj
dGVkLiBUaGlzIGlzc3VlIG9jY3Vycw0KaW4gdGhlIGF1dG8tbmVnb3RpYXRpb24gY2lyY3VpdCwg
YW5kIHdpbGwgbm90IG9jY3VyIGlmIGF1dG8tbmVnb3RpYXRpb24NCmlzIGRpc2FibGVkICh3aGlj
aCByZXF1aXJlcyB0aGF0IHRoZSB0d28gbGluayBwYXJ0bmVycyBiZSBzZXQgdG8gdGhlDQpzYW1l
IHNwZWVkIGFuZCBkdXBsZXgpLg0KDQpFTkQgVVNFUiBJTVBMSUNBVElPTlMNCldoZW4gdGhpcyBp
c3N1ZSBvY2N1cnMsIGxpbmsgaXMgbm90IGVzdGFibGlzaGVkLiBTdWJzZXF1ZW50IGNhYmxlDQpw
bHVnL3VucGx1ZyBjeWNsZXMgd2lsbCBub3QgY29ycmVjdCB0aGUgaXNzdWUuDQoNCldPUksgQVJP
VU5EDQpUaGVyZSBhcmUgZm91ciBhcHByb2FjaGVzIHRvIHdvcmsgYXJvdW5kIHRoaXMgaXNzdWU6
DQoxLiAgVGhpcyBpc3N1ZSBjYW4gYmUgcHJldmVudGVkIGJ5IHNldHRpbmcgYml0IDE1IGluIE1N
RCBkZXZpY2UgYWRkcmVzcyAxLA0KICAgIHJlZ2lzdGVyIDIsIHByaW9yIHRvIGNvbm5lY3Rpbmcg
dGhlICBjYWJsZSBvciBwcmlvciB0byBzZXR0aW5nIHRoZQ0KICAgIFJlc3RhcnQgQXV0by1OZWdv
dGlhdGlvbiBiaXQgaW4gcmVnaXN0ZXIgMGguVGhlIE1NRCByZWdpc3RlcnMgYXJlDQogICAgYWNj
ZXNzZWQgdmlhIHRoZSBpbmRpcmVjdCBhY2Nlc3MgcmVnaXN0ZXJzIERoIGFuZCBFaCwgb3Igdmlh
IHRoZSBNaWNyZWwNCiAgICBFdGhVdGlsIHV0aWxpdHkgYXMgc2hvd24gaGVyZToNCiAgICDigKIg
IElmIHVzaW5nIHRoZSBFdGhVdGlsIHV0aWxpdHkgKHVzdWFsbHkgd2l0aCBhIE1pY3JlbCBLU1o4
MDYxDQogICAgICAgRXZhbHVhdGlvbiBCb2FyZCksIHR5cGUgdGhlIGZvbGxvd2luZyBjb21tYW5k
czoNCiAgICAgICA+IGFkZHJlc3MgMQ0KICAgICAgID4gbW1kIDENCiAgICAgICA+IGl3IDIgYjYx
YQ0KICAgIOKAoiAgQWx0ZXJuYXRpdmVseSwgd3JpdGUgdGhlIGZvbGxvd2luZyByZWdpc3RlcnMg
dG8gd3JpdGUgdG8gdGhlDQogICAgICAgaW5kaXJlY3QgTU1EIHJlZ2lzdGVyOg0KICAgICAgIFdy
aXRlIHJlZ2lzdGVyIERoLCBkYXRhIDAwMDFoDQogICAgICAgV3JpdGUgcmVnaXN0ZXIgRWgsIGRh
dGEgMDAwMmgNCiAgICAgICBXcml0ZSByZWdpc3RlciBEaCwgZGF0YSA0MDAxaA0KICAgICAgIFdy
aXRlIHJlZ2lzdGVyIEVoLCBkYXRhIEI2MUFoDQoyLiAgVGhlIGlzc3VlIGNhbiBiZSBhdm9pZGVk
IGJ5IGRpc2FibGluZyBhdXRvLW5lZ290aWF0aW9uIGluIHRoZSBLU1o4MDYxLA0KICAgIGVpdGhl
ciBieSB0aGUgc3RyYXBwaW5nIG9wdGlvbiwgb3IgYnkgY2xlYXJpbmcgYml0IDEyIGluIHJlZ2lz
dGVyIDBoLg0KICAgIENhcmUgbXVzdCBiZSB0YWtlbiB0byBlbnN1cmUgdGhhdCB0aGUgS1NaODA2
MSBhbmQgdGhlIGxpbmsgcGFydG5lcg0KICAgIHdpbGwgbGluayB3aXRoIHRoZSBzYW1lIHNwZWVk
IGFuZCBkdXBsZXguIE5vdGUgdGhhdCB0aGUgS1NaODA2MQ0KICAgIGRlZmF1bHRzIHRvIGZ1bGwt
ZHVwbGV4IHdoZW4gYXV0by1uZWdvdGlhdGlvbiBpcyBvZmYsIGJ1dCBvdGhlcg0KICAgIGRldmlj
ZXMgbWF5IGRlZmF1bHQgdG8gaGFsZi1kdXBsZXggaW4gdGhlIGV2ZW50IG9mIGZhaWxlZA0KICAg
IGF1dG8tbmVnb3RpYXRpb24uDQozLiAgVGhlIGlzc3VlIGNhbiBiZSBhdm9pZGVkIGJ5IGNvbm5l
Y3RpbmcgdGhlIGNhYmxlIHByaW9yIHRvIHBvd2VyaW5nLXVwDQogICAgb3IgcmVzZXR0aW5nIHRo
ZSBLU1o4MDYxLCBhbmQgbGVhdmluZyBpdCBwbHVnZ2VkIGluIHRoZXJlYWZ0ZXIuDQo0LiAgSWYg
dGhlIGFib3ZlIG1lYXN1cmVzIGFyZSBub3QgdGFrZW4gYW5kIHRoZSBwcm9ibGVtIG9jY3Vycywg
bGluayBjYW4NCiAgICBiZSByZWNvdmVyZWQgYnkgc2V0dGluZyB0aGUgUmVzdGFydCBBdXRvLU5l
Z290aWF0aW9uIGJpdCBpbg0KICAgIHJlZ2lzdGVyIDBoLCBvciBieSByZXNldHRpbmcgb3IgcG93
ZXIgY3ljbGluZyB0aGUgZGV2aWNlLiBSZXNldCBtYXkNCiAgICBiZSBlaXRoZXIgaGFyZHdhcmUg
cmVzZXQgb3Igc29mdHdhcmUgcmVzZXQgKHJlZ2lzdGVyIDBoLCBiaXQgMTUpLg0KDQpQTEFODQpU
aGlzIGVycmF0YSB3aWxsIG5vdCBiZSBjb3JyZWN0ZWQgaW4gYSBmdXR1cmUgcmV2aXNpb24uDQoN
ClNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBPbm5hc2NoIDxhbGV4YW5kZXIub25uYXNjaEBsYW5k
aXNneXIuY29tPg0KLS0tDQogZHJpdmVycy9uZXQvcGh5L21pY3JlbC5jIHwgMTMgKysrKysrKysr
KysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMgYi9kcml2ZXJzL25ldC9waHkv
bWljcmVsLmMNCmluZGV4IDZjNDVmZjYuLmViODVjZjQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL25l
dC9waHkvbWljcmVsLmMNCisrKyBiL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYw0KQEAgLTMzOSw2
ICszMzksMTcgQEAgc3RhdGljIGludCBrc3o4MDQxX2NvbmZpZ19hbmVnKHN0cnVjdCBwaHlfZGV2
aWNlICpwaHlkZXYpDQogCXJldHVybiBnZW5waHlfY29uZmlnX2FuZWcocGh5ZGV2KTsNCiB9DQog
DQorc3RhdGljIGludCBrc3o4MDYxX2NvbmZpZ19pbml0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlk
ZXYpDQorew0KKwlpbnQgcmV0Ow0KKw0KKwlyZXQgPSBwaHlfd3JpdGVfbW1kKHBoeWRldiwgTURJ
T19NTURfUE1BUE1ELCBNRElPX0RFVklEMSwgMHhCNjFBKTsNCisJaWYgKHJldCkNCisJCXJldHVy
biByZXQ7DQorDQorCXJldHVybiBrc3pwaHlfY29uZmlnX2luaXQocGh5ZGV2KTsNCit9DQorDQog
c3RhdGljIGludCBrc3o5MDIxX2xvYWRfdmFsdWVzX2Zyb21fb2Yoc3RydWN0IHBoeV9kZXZpY2Ug
KnBoeWRldiwNCiAJCQkJICAgICAgIGNvbnN0IHN0cnVjdCBkZXZpY2Vfbm9kZSAqb2Zfbm9kZSwN
CiAJCQkJICAgICAgIHUxNiByZWcsDQpAQCAtOTM4LDcgKzk0OSw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
cGh5X2RyaXZlciBrc3BoeV9kcml2ZXJbXSA9IHsNCiAJLnBoeV9pZF9tYXNrCT0gTUlDUkVMX1BI
WV9JRF9NQVNLLA0KIAkuZmVhdHVyZXMJPSBQSFlfQkFTSUNfRkVBVFVSRVMsDQogCS5mbGFncwkJ
PSBQSFlfSEFTX0lOVEVSUlVQVCwNCi0JLmNvbmZpZ19pbml0CT0ga3N6cGh5X2NvbmZpZ19pbml0
LA0KKwkuY29uZmlnX2luaXQJPSBrc3o4MDYxX2NvbmZpZ19pbml0LA0KIAkuY29uZmlnX2FuZWcJ
PSBnZW5waHlfY29uZmlnX2FuZWcsDQogCS5yZWFkX3N0YXR1cwk9IGdlbnBoeV9yZWFkX3N0YXR1
cywNCiAJLmFja19pbnRlcnJ1cHQJPSBrc3pwaHlfYWNrX2ludGVycnVwdCwNCi0tIA0KMi43LjQN
Cg0K
