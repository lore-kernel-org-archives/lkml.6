Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DCDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD3C20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="WOgPI7+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD3C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeKZWul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 17:50:41 -0500
Received: from mail-eopbgr20089.outbound.protection.outlook.com ([40.107.2.89]:2752
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbeKZWul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 17:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmypB9cmzhlZtUh6Xye82NMmj9bxMgaldK31PaFV5sw=;
 b=WOgPI7+nZvANl9Ps3cF9UAE0FYkHNTNWnwpT3IV9KT/Vp1fh6tPwktriFN+yM2lLrEQZNCe04X0YGQw7/ndrxWWdqcZP7qSmiz99ioMPcx1Fa/epvk0yGlNteCBRbeFLYApMiKrhSbXX7mQFXuu8vXNlSVG2BwmkIDh4odziQgs=
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com (20.178.13.96) by
 VI1PR08MB3405.eurprd08.prod.outlook.com (20.177.58.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 26 Nov 2018 11:56:36 +0000
Received: from VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b]) by VI1PR08MB4223.eurprd08.prod.outlook.com
 ([fe80::b9e5:694c:a7d1:d37b%4]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 11:56:36 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rich Felker <dalias@libc.org>
CC:     nd <nd@arm.com>, Florian Weimer <fweimer@redhat.com>,
        carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
Thread-Topic: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl
 init and thread creation
Thread-Index: AQHUgcmYxLh54Hb0r0GDFIJAvPiE/6Vb3dCAgAAH4gCAAALtAIAACQMAgAALv8yAAAU3AIAAA3NZgAAC1ACAAU9hQIAAFdiAgAArwgCAAAb7gIAABiiAgAAMMACAACrKgIAEHJ0A
Date:   Mon, 26 Nov 2018 11:56:36 +0000
Message-ID: <00967681-1fcf-6b22-cbd2-4a09840b8ab9@arm.com>
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com>
 <20181122171010.GH23599@brightrain.aerifal.cx>
 <871s7cvt1l.fsf@oldenburg.str.redhat.com>
 <20181123142843.GJ23599@brightrain.aerifal.cx>
 <1150466925.11664.1542992720871.JavaMail.zimbra@efficios.com>
 <20181123173019.GK23599@brightrain.aerifal.cx>
 <865273158.11687.1542995541389.JavaMail.zimbra@efficios.com>
 <20181123183558.GM23599@brightrain.aerifal.cx>
 <1758017676.12041.1543007347347.JavaMail.zimbra@efficios.com>
In-Reply-To: <1758017676.12041.1543007347347.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-originating-ip: [217.140.106.49]
x-clientproxiedby: CWLP265CA0382.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5e::34) To VI1PR08MB4223.eurprd08.prod.outlook.com
 (2603:10a6:803:b5::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB3405;6:QkjpbUi7Buaap6co8cJgJmaNaRVAPwheknd3sbViR9cVH3E8gHRi0m46g4eME4zILff0VMW4vXx8c8mFyi8RsUKnG44AomgkNB7oQwCeudrlu0D0elbGN8hVXJmcC0cPo/pSlZg64Ful4/LH+xA3ZHkDNoVy57uFKX84dok/gmgEyMu4r47pfP4zknXgkdLyHD4L/36pIJjP/20RUG0M0teFlzHq/J4ZKu7kd6ctLnXf7M5VSs1EfX+GipofTZcATHKwGBuqMkTgfMYffAAzMmJxC0J39B0wTbuFsmEHqniZ1V57BxbUwcX+pX0shHBWeB9nA1SOBqry4HuyeQin/pZDFrcdZvpoLZS4PpaRjcR38+3TGRZ1Wfn5XTJJrm/KPKT3G6ZoNvg+17PF8kUutwcrUhGP5MmG+I5ZS7nxcRwOlZuvfzkDpOvrpX7rwdNBXYwEpg/NzPUEpUhu6ZFIDw==;5:KbDOtd+07p7KLEI7Yf7htF+NVMMPnzOWx3m9bvDBeZX2NgEI0IQGCLUN07bl2KVZFdQeOLgGhNXPdkg/4O8Pa+09LtJHBNwyAvaROKS69rRcCSzj4FoH8XDJyNTvuNi0XMlOyfVQgzbA2f8dkIiz74wnmg8l8P20EVFByNsNchM=;7:t5rROvF9+DiKBlIs5a5M8zYBI2kV1RQPEWZB7rhKj00Cylr7AR/2WFi0IkiLC0k0Ri8yvBXdaBwCvCVWqdCiSBF/4TCVd5MHyt442lzWINDUYZKV7XKdS8HOvs+52FXfJXknuOLVy1D4kPpRlB3iAA==
x-ms-office365-filtering-correlation-id: 9c7c794a-f659-4cf8-1080-08d65396377b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3405;
x-ms-traffictypediagnostic: VI1PR08MB3405:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB3405D2CE9587E691E813875FEDD70@VI1PR08MB3405.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231443)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB3405;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3405;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(6436002)(217873002)(4326008)(8936002)(478600001)(8676002)(81156014)(81166006)(99286004)(5660300001)(65826007)(54906003)(14454004)(229853002)(186003)(105586002)(58126008)(93886005)(3846002)(6116002)(316002)(25786009)(72206003)(110136005)(97736004)(7736002)(6486002)(305945005)(7416002)(2616005)(53546011)(6512007)(6506007)(386003)(102836004)(31686004)(486006)(44832011)(446003)(11346002)(68736007)(26005)(65806001)(476003)(66066001)(65956001)(6246003)(53936002)(39060400002)(76176011)(106356001)(14444005)(31696002)(256004)(52116002)(2906002)(86362001)(36756003)(71190400001)(71200400001)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3405;H:VI1PR08MB4223.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TO8/8NbO6f0Ar7sDJlLKBaJ7bchezr1mGfoWdyknK3wyNMfIa3QB/UCkUl2vC6JbhLAirEgNUF8wyODwoPQ69OHlnv3a7/oPVmCv35BrCoQ5tbgGEou2zC+GLNbwQctoiziXRa+FQnB5cP1hmDmrnSYy359Q6wEaPnsd7Yu2//JefFI6sSeU/BaXl0lJ5D3KQp9NqyN70LB9WKRWRuFLUmBCARYWnBuDV1ZsW1vaj7ywmWFBV3yBUwCRjCRMZkwF/uRqoLsS+6p3tYJorxMxOErz4ycWvIIDfcD/OhBot1gXWazbsmGfLvGjngLd1BxKPbosEx9DZCVkQxSHMqGELezM2xEMOGOa69Qp118mpVA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <8401165586C1614F817C35E872CA2917@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7c794a-f659-4cf8-1080-08d65396377b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 11:56:36.4998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMTEvMTggMjE6MDksIE1hdGhpZXUgRGVzbm95ZXJzIHdyb3RlOg0KPiAtLS0tLSBPbiBO
b3YgMjMsIDIwMTgsIGF0IDE6MzUgUE0sIFJpY2ggRmVsa2VyIGRhbGlhc0BsaWJjLm9yZyB3cm90
ZToNCj4gDQo+PiBPbiBGcmksIE5vdiAyMywgMjAxOCBhdCAxMjo1MjoyMVBNIC0wNTAwLCBNYXRo
aWV1IERlc25veWVycyB3cm90ZToNCj4+PiAtLS0tLSBPbiBOb3YgMjMsIDIwMTgsIGF0IDEyOjMw
IFBNLCBSaWNoIEZlbGtlciBkYWxpYXNAbGliYy5vcmcgd3JvdGU6DQo+Pj4NCj4+Pj4gT24gRnJp
LCBOb3YgMjMsIDIwMTggYXQgMTI6MDU6MjBQTSAtMDUwMCwgTWF0aGlldSBEZXNub3llcnMgd3Jv
dGU6DQo+Pj4+PiAtLS0tLSBPbiBOb3YgMjMsIDIwMTgsIGF0IDk6MjggQU0sIFJpY2ggRmVsa2Vy
IGRhbGlhc0BsaWJjLm9yZyB3cm90ZToNCj4+Pj4+IFsuLi5dDQo+Pj4+Pj4NCj4+Pj4+PiBBYnNv
bHV0ZWx5LiBBcyBsb25nIGFzIGl0J3MgaW4gbGliYywgaW1wbGljaXQgZGVzdHJ1Y3Rpb24gd2ls
bCBoYXBwZW4uDQo+Pj4+Pj4gQWN0dWFsbHkgSSB0aGluayB0aGUgZ2xpYmMgY29kZSBzaG91bmQg
dW5jb25kaXRpb25hbGx5IHVucmVnaXN0ZXIgdGhlDQo+Pj4+Pj4gcnNlcSBhZGRyZXNzIGF0IGV4
aXQgKGFmdGVyIGJsb2NraW5nIHNpZ25hbHMsIHNvIG5vIGFwcGxpY2F0aW9uIGNvZGUNCj4+Pj4+
PiBjYW4gcnVuKSBpbiBjYXNlIGEgdGhpcmQtcGFydHkgcnNlcSBsaWJyYXJ5IHdhcyBsaW5rZWQg
YW5kIGZhaWxlZCB0bw0KPj4+Pj4+IGRvIHNvIGJlZm9yZSB0aHJlYWQgZXhpdCAoZS5nLiBkdWUg
dG8gbWlzbWF0Y2hlZCByZWYgY291bnRzKSByYXRoZXINCj4+Pj4+PiB0aGFuIHJlc3BlY3Rpbmcg
dGhlIHJlZmVyZW5jZSBjb3VudCwgc2luY2UgaXQga25vd3MgaXQncyB0aGUgbGFzdA0KPj4+Pj4+
IHVzZXIuIFRoaXMgd291bGQgbWFrZSBwb3RlbnRpYWxseS1idWdneSBjb2RlIHNhZmVyLg0KPj4+
Pj4NCj4+Pj4+IE9LLCBsZXQgbWUgZ28gYWhlYWQgd2l0aCBhIGZldyBpZGVhcy9xdWVzdGlvbnMg
YWxvbmcgdGhhdCBwYXRoLg0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeXl5eXl5eXl5eXl5eXl4NCj4+Pj4+DQo+Pj4+PiBMZXQncyBzYXkgb3Vy
IHN0YXRlZCBnb2FsIGlzIHRvIGxldCB0aGUgImV4aXQiIHN5c3RlbSBjYWxsIGZyb20gdGhlDQo+
Pj4+PiBnbGliYyB0aHJlYWQgZXhpdCBwYXRoIHBlcmZvcm0gcnNlcSB1bnJlZ2lzdHJhdGlvbiAo
d2l0aG91dCBleHBsaWNpdA0KPj4+Pj4gdW5yZWdpc3RyYXRpb24gYmVmb3JlaGFuZCkuIExldCdz
IGxvb2sgYXQgd2hhdCB3ZSBuZWVkLg0KPj4+Pg0KPj4+PiBUaGlzIGlzIG5vdCAiYWxvbmcgdGhh
dCBwYXRoIi4gVGhlIGFib3ZlLXF1b3RlZCB0ZXh0IGlzIG5vdCBhYm91dA0KPj4+PiBhc3N1bWlu
ZyBpdCdzIHNhZmUgdG8gbWFrZSBTWVNfZXhpdCB3aXRob3V0IHVucmVnaXN0ZXJpbmcgdGhlIHJz
ZXENCj4+Pj4gb2JqZWN0LCBidXQgcmF0aGVyIGFib3V0IGdsaWJjIGJlaW5nIGFibGUgdG8gcGVy
Zm9ybSB0aGUNCj4+Pj4gcnNlcS11bnJlZ2lzdGVyIHN5c2NhbGwgd2l0aG91dCBjYXJpbmcgYWJv
dXQgcmVmZXJlbmNlIGNvdW50cywgc2luY2UNCj4+Pj4gaXQga25vd3Mgbm8gb3RoZXIgY29kZSB0
aGF0IG1pZ2h0IGRlcGVuZCBvbiByc2VxIGNhbiBydW4gYWZ0ZXIgaXQuDQo+Pj4NCj4+PiBXaGVu
IHNheWluZyAiYWxvbmcgdGhhdCBwYXRoIiwgd2hhdCBJIG1lYW4gaXM6IGlmIHdlIGdvIGluIHRo
YXQgZGlyZWN0aW9uLA0KPj4+IHRoZW4gd2Ugc2hvdWxkIGxvb2sgaW50byBnb2luZyBhbGwgdGhl
IHdheSB0aGVyZSwgYW5kIHJlbHkgb24gdGhyZWFkDQo+Pj4gZXhpdCB0byBpbXBsaWNpdGx5IHVu
cmVnaXN0ZXIgdGhlIFRMUyBhcmVhLg0KPj4+DQo+Pj4gRG8geW91IHNlZSBhbnkgcmVhc29uIGZv
ciBkb2luZyBhbiBleHBsaWNpdCB1bnJlZ2lzdHJhdGlvbiBhdCB0aHJlYWQNCj4+PiBleGl0IHJh
dGhlciB0aGFuIHNpbXBseSByZWx5IG9uIHRoZSBleGl0IHN5c3RlbSBjYWxsID8NCj4+DQo+PiBX
aGV0aGVyIHRoaXMgaXMgbmVlZGVkIGlzIGFuIGltcGxlbWVudGF0aW9uIGRldGFpbCBvZiBnbGli
YyB0aGF0DQo+PiBzaG91bGQgYmUgcGVybWl0dGVkIHRvIHZhcnkgYmV0d2VlbiB2ZXJzaW9ucy4g
VW5sZXNzIGdsaWJjIHdhbnRzIHRvDQo+PiBwcm9taXNlIHRoYXQgaXQgd291bGQgYmVjb21lIGEg
cHVibGljIGd1YXJhbnRlZSwgaXQncyBub3QgcGFydCBvZiB0aGUNCj4+IGRpc2N1c3Npb24gYXJv
dW5kIHRoZSBBUEkvQUJJLiBPbmx5IHBhcnQgb2YgdGhlIGRpc2N1c3Npb24gYXJvdW5kDQo+PiBp
bXBsZW1lbnRhdGlvbiBpbnRlcm5hbHMgb2YgdGhlIGdsaWJjIHJzZXEgc3R1ZmYuDQo+Pg0KPj4g
T2YgY291cnNlIEkgbWF5IGJlIGJpYXNlZCB0aGlua2luZyBhcHBsaWNhdGlvbiBjb2RlIHNob3Vs
ZCBub3QgYXNzdW1lDQo+PiB0aGlzIHNpbmNlIGl0J3Mgbm90IHRydWUgb24gbXVzbCAtLSBmb3Ig
ZGV0YWNoZWQgdGhyZWFkcywgdGhlIHRocmVhZA0KPj4gZnJlZXMgaXRzIG93biBzdGFjayBiZWZv
cmUgZXhpdGluZyAoYW5kIHRodXMgaGFzIHRvIHVucmVnaXN0ZXINCj4+IHNldF90aWRfYWRkcmVz
cyBhbmQgc2V0X3JvYnVzdGxpc3QgYmVmb3JlIGV4aXRpbmcpLg0KPiANCj4gT0ssIHNvIG9uIGds
aWJjLCB0aGUgaW1wbGVtZW50YXRpb24gY291bGQgcmVseSBvbiBleGl0IHNpZGUtZWZmZWN0IHRv
DQo+IGltcGxpY2l0bHkgdW5yZWdpc3RlciByc2VxLiBPbiBtdXNsLCBiYXNlZCBvbiB0aGUgc2Nl
bmFyaW8geW91IGRlc2NyaWJlLA0KPiB0aGUgbGlicmFyeSBzaG91bGQgdW5yZWdpc3RlciByc2Vx
IGV4cGxpY2l0bHkgYmVmb3JlIHN0YWNrIHJlY2xhaW0uDQo+IA0KPiBBbSBJIHVuZGVyc3RhbmRp
bmcgdGhlIHNpdHVhdGlvbiBjb3JyZWN0bHkgPw0KDQppIHRoaW5rIHRoZSBwb2ludCBpcyB0aGF0
IHlvdSBkb24ndCBuZWVkIHRvIGtub3cgdGhlc2UNCmRldGFpbHMgaW4gb3JkZXIgdG8gY29tZSB1
cCB3aXRoIGEgZGVzaWduIHRoYXQgYWxsb3dzDQpib3RoIGltcGxlbWVudGF0aW9ucy4gKHRoZW4g
dGhlIGxpYmMgY2FuIGNoYW5nZSBsYXRlcikNCg0Kc28NCi0gaXMgdGhlcmUgYSBuZWVkIGZvciBw
dWJsaWMgdW5yZWdpc3RlciBhcGkgKGRvZXMgdGhlDQp1c2VyIGRvIGl0IG9yIHRoZSByc2VxIGxp
YnJhcnkgaW1wbGljaXRseSB1bnJlZ2lzdGVycyk/DQotIGlzIHRoZXJlIGEgbmVlZCBmb3IgcmVm
IGNvdW50aW5nIChvciB0aGUgcnNlcSBsaWINCnVuY29uZGl0aW9uYWxseSB1bnJlZ2lzdGVycyBh
dCB0aGUgZW5kIG9mIGEgdGhyZWFkLA0KdGhlIGxpYmMgY2FuIGNlcnRhaW5seSBkbyB0aGlzKT8N
Cg0KPj4+IE9LLCBBRkFJVSBzbyB5b3UgYXJndWUgZm9yIGxlYXZpbmcgdGhlIF9fcnNlcV9hYmkg
c3ltYm9sICJ3ZWFrIi4gSnVzdCBtYWtpbmcNCj4+PiBzdXJlIEkgY29ycmVjdGx5IHVuZGVyc3Rh
bmQgeW91ciBwb3NpdGlvbi4NCj4+DQo+PiBJIGRvbid0IHRoaW5rIGl0IG1hdHRlcnMsIGFuZCBJ
IGRvbid0IHRoaW5rIG1ha2luZyBpdCB3ZWFrIGlzDQo+PiBtZWFuaW5nZnVsIG9yIHVzZWZ1bCAo
d2VhayBpbiBhIHNoYXJlZCBsaWJyYXJ5IGlzIGxhcmdlbHkgbWVhbmluZ2xlc3MpDQo+PiBidXQg
bWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nIGhlcmUuDQo+IA0KPiBVc2luZyBhICJ3ZWFrIiBz
eW1ib2wgaW4gZWFybHkgYWRvcHRlciBsaWJyYXJpZXMgaXMgaW1wb3J0YW50LCBzbyB0aGV5DQo+
IGNhbiBiZSBsb2FkZWQgdG9nZXRoZXIgaW50byB0aGUgc2FtZSBwcm9jZXNzIHdpdGhvdXQgY2F1
c2luZyBsb2FkZXINCj4gZXJyb3JzIGR1ZSB0byBtYW55IGRlZmluaXRpb25zIG9mIHRoZSBzYW1l
IHN0cm9uZyBzeW1ib2wuDQo+IA0KPiBVc2luZyAid2VhayIgaW4gYSBDIGxpYnJhcnkgaXMgc29t
ZXRoaW5nIEknbSBub3Qgc3VyZSBpcyBhIGNoYXJhY3RlcmlzdGljDQo+IHdlIHdhbnQgb3IgbmVl
ZCwgYmVjYXVzZSBJIGRvdWJ0IHdlIHdvdWxkIGV2ZXIgd2FudCB0byBsb2FkIHR3byBsaWJjIGF0
IHRoZQ0KPiBzYW1lIHRpbWUgaW4gYSBnaXZlbiBwcm9jZXNzLg0KPiANCj4gVGhlIG9ubHkgcmVh
c29uIEkgc2VlIGZvciB1c2luZyAid2VhayIgZm9yIHRoZSBfX3JzZXFfYWJpIHN5bWJvbCBpbiB0
aGUNCj4gbGliYyBpcyBpZiB3ZSB3YW50IHRvIGFsbG93IGVhcmx5IGFkb3B0ZXIgYXBwbGljYXRp
b25zIHRvIGRlZmluZQ0KPiBfX3JzZXFfYWJpIGFzIGEgc3Ryb25nIHN5bWJvbCwgd2hpY2ggd291
bGQgbWFrZSBzb21lIHNlbnNlLg0KDQp3ZWFrIHJlYWxseSBkb2VzIG5vdCBtYXR0ZXIgaW4gZHlu
YW1pYyBsaW5raW5nDQoodW5sZXNzIHlvdSBzZXQgdGhlIExEX0RZTkFNSUNfV0VBSyBlbnYgdmFy
IGZvcg0KYmFja3dhcmQgY29tcGF0IHdpdGggdmVyeSBvbGQgZ2xpYmMsIG9yIGlmIGl0J3MNCmFu
IHVuZGVmaW5lZCB3ZWFrIHJlZmVyZW5jZSkNCg0KPj4gSnVzdCBibG9ja2luZyBhdCBzdGFydC9l
eGl0IHdvbid0IHNvbHZlIHRoZSBwcm9ibGVtIGJlY2F1c2UNCj4+IGdsb2JhbC1keW5hbWljIFRM
UyBpbiBnbGliYyBpbnZvbHZlcyBkeW5hbWljIGFsbG9jYXRpb24sIHdoaWNoIGlzIGhhcmQNCj4+
IHRvIG1ha2UgQVMtc2FmZSBhbmQgb2YgY291cnNlIGNhbiBmYWlsLCBsZWF2aW5nIG5vIHdheSB0
byBtYWtlIGZvcndhcmQNCj4+IHByb2dyZXNzLg0KPiANCj4gSG93IGhhcmQgd291bGQgaXQgYmUg
dG8gY3JlYXRlIGEgYXN5bmMtc2lnbmFsLXNhZmUgbWVtb3J5IHBvb2wsIHdoaWNoIHdvdWxkDQo+
IGJlIGFsd2F5cyBhY2Nlc3NlZCB3aXRoIHNpZ25hbHMgYmxvY2tlZCwgc28gd2UgY291bGQgZml4
IHRob3NlIGNvcm5lci1jYXNlcw0KPiBmb3IgZ29vZCA/DQoNCnRoYXQgaXMgaGFyZC4NCg0KaW4g
bXVzbCB0bHMgYWNjZXNzIGlzIGFzLXNhZmUsIGJ1dCBpdCB1c2VzIGEgZGlmZmVyZW50DQphcHBy
b2FjaDogaXQgZG9lcyBhbGwgYWxsb2NhdGlvbnMgYXQgdGhyZWFkIGNyZWF0aW9uIG9yDQpkbG9w
ZW4gdGltZS4NCg0KZ2xpYmMgaGFzIGZ1cnRoZXIgaXNzdWVzIGJlY2F1c2UgaXQgc3VwcG9ydHMg
ZGxjbG9zZQ0Kd2l0aCBtb2R1bGUgdW5sb2FkaW5nIGFuZCB0aGVuIGR5bmFtaWMgdGxzIHJlbGF0
ZWQNCmludGVybmFsIHN0cnVjdHVyZXMgYXJlIGhhcmQgdG8gZnJlZSAoaXQgaXMgdmFsaWQgdG8N
CmltcGxlbWVudCBkbGNsb3NlIGFzIGEgbm9vcCwgd2hpY2ggaXMgd2hhdCBtdXNsIGRvZXMuDQp0
bHMgYWNjZXNzIG5lZWRzIHRvIHN5bmNocm9uaXplIHdpdGggZGxvcGVuIGFuZCBkbGNsb3NlDQp3
aGVuIGFjY2Vzc2luZyBpbnRlcm5hbCBzdHJ1Y3R1cmVzLCBidXQgeW91IG5lZWQgYQ0KbG9jay1m
cmVlIG1lY2hhbmlzbSBpZiB0aGUgYWNjZXNzIGhhcyB0byBiZSBhcy1zYWZlLA0KYW5kIGRsY2xv
c2UgaXMgaGFyZGVyIHRvIGRvIHRoYXQgd2F5IHRoYW4gZGxvcGVuKQ0K
