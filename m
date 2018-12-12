Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B59C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD77B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="mjkv4hi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD77B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeLLJZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 04:25:32 -0500
Received: from mail-eopbgr680062.outbound.protection.outlook.com ([40.107.68.62]:39392
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbeLLJZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 04:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0Ry76Rvcam/P6sRou/ufnzgX4RhRoR6b6EN1cVLdbo=;
 b=mjkv4hi9vFQOk+BjqCJ2lqgmigivKu3i6ILx/yYlJuWJbZGuwh63AO2v5GFGMR/9Wzyjt+oAdxH+uGVxcuLtWWbItAAzY2+JbN/qZpH8clWg5MufhYWkitaAp9kD57pMgAoMqkPXOQeM0STRvlklZX00Yv8tNIHG+daeinqum9g=
Received: from SN6PR03MB4398.namprd03.prod.outlook.com (20.177.255.219) by
 SN6PR03MB3936.namprd03.prod.outlook.com (52.135.104.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 12 Dec 2018 09:25:27 +0000
Received: from SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc]) by SN6PR03MB4398.namprd03.prod.outlook.com
 ([fe80::7c2a:de77:a4ce:5ccc%3]) with mapi id 15.20.1404.026; Wed, 12 Dec 2018
 09:25:27 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Marcin Wojtas <mw@semihalf.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        netdev <netdev@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        =?utf-8?B?R3LDqWdvcnkgQ2xlbWVudA==?= <gregory.clement@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Thread-Topic: [PATCH net] net: mvneta: fix operation for 64K PAGE_SIZE
Thread-Index: AQHUkVET6MmkkP0I6kWJw6RDslXtBqV67EkA///Y2oCAAA/4AA==
Date:   Wed, 12 Dec 2018 09:25:27 +0000
Message-ID: <20181212172006.0814cf03@xhacker.debian>
References: <1544533009-12425-1-git-send-email-mw@semihalf.com>
        <20181212104304.49026ed2@xhacker.debian>
        <CAPv3WKctDNJVq7SgHBZLO_TU50ponCLu7h5oMKLTndBiDadhaA@mail.gmail.com>
In-Reply-To: <CAPv3WKctDNJVq7SgHBZLO_TU50ponCLu7h5oMKLTndBiDadhaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:404:f6::36) To SN6PR03MB4398.namprd03.prod.outlook.com
 (2603:10b6:805:fd::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR03MB3936;6:XMREmoQd781G4vFTgCmlW1j8OfInAepVWaROa6P1cTml0THNp0juCxXkY6DkryRkRtmUeslosSb0FNVcXPbJrpY7BvcE7QLXcd4jGFeYoCZPdqSdwmnWjUpjIEu6td1m+OfSU0MP8QH78H0BqV4KeBOJanlRCaU30xDU/k+7PI6k0AuWoo83WsoupShUrT8wRB6JLbJE+q62D5PqaRsU1XnEG4zMrbSZD6V7IQXAu+mQcIq4sPJLOk42kI/+QG8vHjathosDVxKyMjwpfC3/0rgRQiB/Iftuf4ZAcTZm4HsYK9cVPsVNgpMKSliHhccF3k/giZ9suOX9tX9fYyN0hW66c9UqtzznViCfMKuMHvwhrnvwE367OfUz6pDV7yV6BAnw0t/9l6BPDF6ObCRKmKfOpCRd4w6o5C+XNu1Aru+pN2xroUhAAj3jwyqYwb5JkBBGnvCbGx9vozgbRsbirg==;5:vhqEZgEniivOfA3l9aIfVxDCJNfrNLkDHO/EEOJa/BMt7pjhd4K8egcjIATJZ2RaCidjefG3uJu3DboT42/WswuB0Fp++UFikv5qC9NmkH5QdLJNQEJFtOqdFH+r+YKsjNvlJ5gI6jhixX4fRqC86qFkBeKUHXSOdqGh09v5GOA=;7:RhP6xomPQpNL4Fu9AYcK/o92qWeTe7wZTSaGs7PxXxxTkRTExNuwkvrT7uMAgUp7v/3wazbZL1ipYjcHgtrzD7d13UyIBD4SV2xV6l+vNT4U+4FtV56dvPiL79IfB3lvPdLCl7ii+LIhTO95L37jLQ==
x-ms-office365-filtering-correlation-id: 03a69327-3418-4c38-38c1-08d66013c07b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN6PR03MB3936;
x-ms-traffictypediagnostic: SN6PR03MB3936:
x-microsoft-antispam-prvs: <SN6PR03MB39362B90249D05757E31565AEDA70@SN6PR03MB3936.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:SN6PR03MB3936;BCL:0;PCL:0;RULEID:;SRVR:SN6PR03MB3936;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(53936002)(71200400001)(305945005)(8676002)(81166006)(9686003)(81156014)(71190400001)(6512007)(6436002)(229853002)(25786009)(6486002)(105586002)(8936002)(6246003)(86362001)(106356001)(66066001)(54906003)(68736007)(6506007)(186003)(386003)(33896004)(72206003)(3846002)(26005)(446003)(102836004)(6116002)(2906002)(52116002)(316002)(14454004)(4326008)(99286004)(76176011)(256004)(6916009)(14444005)(7416002)(486006)(11346002)(478600001)(476003)(5660300001)(1076002)(97736004)(7736002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3936;H:SN6PR03MB4398.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rYHSXLZgKL4Cu4z+Zmo6F/9Fd1aTfCvPXJir34pwfRMa2bYC8RSS2Fr+BcZI3tEPpSA90DNFeQp+nLINpYRbzGwk1upaYGunuln+hwmF4yJOh4skXtXRUmtdfkgworeI1u9vwocxv4mQOLaQmQBKwU3ul8slxvo6dNj5sa0FZLo/BiS3vrlha3stSqV8D9Wm5PMxGfQWnMztoWESMLueia+Z2uY3nhBK7KfOylep/LVnCJe7HwS4IEBepKgO/XPOAJ/23pHvvLMcLSqBanXie1Ixdxt3gBbjAGjjBIYUIqnDyH77lLRzEiGtvuBSQfSu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C76B765DA763747893BA29883457F71@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a69327-3418-4c38-38c1-08d66013c07b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 09:25:27.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyY2luLA0KDQpPbiBXZWQsIDEyIERlYyAyMDE4IDA5OjIyOjU3ICswMTAwIE1hcmNpbiBX
b2p0YXMgPG13QHNlbWloYWxmLmNvbT4gd3JvdGU6DQoNCj4gSGkgSmlzaGVuZywNCj4gDQo+IMWb
ci4sIDEyIGdydSAyMDE4IG8gMDM6NDggSmlzaGVuZyBaaGFuZyA8SmlzaGVuZy5aaGFuZ0BzeW5h
cHRpY3MuY29tPiBuYXBpc2HFgihhKToNCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gT24gVHVlLCAx
MSBEZWMgMjAxOCAxMzo1Njo0OSArMDEwMCBNYXJjaW4gV29qdGFzIHdyb3RlOg0KPiA+ICANCj4g
PiA+IFJlY2VudCBjaGFuZ2VzIGluIHRoZSBtdm5ldGEgZHJpdmVyIHJld29ya2VkIGFsbG9jYXRp
b24NCj4gPiA+IGFuZCBoYW5kbGluZyBvZiB0aGUgaW5ncmVzcyBidWZmZXJzIHRvIHVzZSBlbnRp
cmUgcGFnZXMuDQo+ID4gPiBBcGFydCBmcm9tIHRoYXQgaW4gU1cgQk0gc2NlbmFyaW8gdGhlIEhX
IG11c3QgYmUgaW5mb3JtZWQNCj4gPiA+IHZpYSBQUlhEUVMgYWJvdXQgdGhlIGJpZ2dlc3QgcG9z
c2libGUgaW5jb21pbmcgYnVmZmVyDQo+ID4gPiB0aGF0IGNhbiBiZSBwcm9wYWdhdGVkIGJ5IFJY
IGRlc2NyaXB0b3JzLg0KPiA+ID4NCj4gPiA+IFRoZSBCdWZmZXJTaXplIGZpZWxkIHdhcyBmaWxs
ZWQgYWNjb3JkaW5nIHRvIHRoZSBNVFUtZGVwZW5kZW50DQo+ID4gPiBwa3Rfc2l6ZSB2YWx1ZS4g
TGF0ZXIgY2hhbmdlIHRvIFBBR0VfU0laRSBicm9rZSBSWCBvcGVyYXRpb24NCj4gPiA+IHdoZW4g
dXNpbiA2NEsgcGFnZXMsIGFzIHRoZSBmaWVsZCBpcyBzaW1wbHkgdG9vIHNtYWxsLg0KPiA+ID4N
Cj4gPiA+IFRoaXMgcGF0Y2ggY29uZGl0aW9uYWxseSBsaW1pdHMgdGhlIHZhbHVlIHBhc3NlZCB0
byB0aGUgQnVmZmVyU2l6ZQ0KPiA+ID4gb2YgdGhlIFBSWERRUyByZWdpc3RlciwgZGVwZW5kaW5n
IG9uIHRoZSBQQUdFX1NJWkUgdXNlZC4NCj4gPiA+IE9uIHRoZSBvY2Nhc2lvbiByZW1vdmUgbm93
IHVudXNlZCBmcmFnX3NpemUgZmllbGQgb2YgdGhlIG12bmV0YV9wb3J0DQo+ID4gPiBzdHJ1Y3R1
cmUuDQo+ID4gPg0KPiA+ID4gRml4ZXM6IDU2MmUyZjQ2N2U3MSAoIm5ldDogbXZuZXRhOiBJbXBy
b3ZlIHRoZSBidWZmZXIgYWxsb2NhdGlvbg0KPiA+ID4gbWV0aG9kIGZvciBTV0JNIikgIA0KPiA+
DQo+ID4gSU1ITywgd2UnZCBiZXR0ZXIgcmV2ZXJ0IDU2MmUyZjQ2N2U3MSBhbmQgN2U0N2ZkODRi
NTZiYg0KPiA+DQo+ID4gVGhlIGlzc3VlIGNvbW1pdCA1NjJlMmY0NjdlNzEgd2FudHMgdG8gc29s
dmUgaXMgZHVlIHRvIGNvbW1pdCA3ZTQ3ZmQ4NGI1NmJiDQo+ID4gSXQgbG9va3MgYSBiaXQgd2ly
ZWQsIHRvIGludHJvZHVjZSByZWdyZXNzaW9uIHRoZW4gc3VibWl0IGFub3RoZXIgY29tbWl0KGlu
DQo+ID4gdGhlIHNhbWUgcGF0Y2ggc2V0KSBzb2x2ZSBpdA0KPiA+DQo+ID4gUGVyIG15IHRlc3Qs
IGFmdGVyIHJldmVydGluZyA1NjJlMmY0NjdlNzEgYW5kIDdlNDdmZDg0YjU2YmIsIEkgY2FuJ3Qg
cmVwcm9kdWNlDQo+ID4gd2hhdCdzIGNsYWltZWQgaW4gY29tbWl0IDU2MmUyZjQ2N2U3MSAtLSAi
V2l0aCBzeXN0ZW0gaGF2aW5nIGEgc21hbGwgbWVtb3J5DQo+ID4gKGFyb3VuZCAyNTZNQiksIHRo
ZSBzdGF0ZSAiY2Fubm90IGFsbG9jYXRlIG1lbW9yeSB0byByZWZpbGwgd2l0aCBuZXcgYnVmZmVy
Ig0KPiA+IGlzIHJlYWNoIHByZXR0eSBxdWlja2x5LiIgIA0KPiANCj4gSSBhbSBub3QgdGhlIG9u
ZSB0byBkZWNpZGUgYWJvdXQgcGF0Y2ggcmV2ZXJ0aW5nLiBGcm9tIHdoYXQgSQ0KPiB1bmRlcnN0
YW5kLCBjb21taXQgN2U0N2ZkODRiNTZiYiB3YXMgaW50b3JkdWNlZCBpbiBvcmRlciB0byBpbmNy
ZWFzZQ0KPiBwZXJmb3JtYW5jZSB0aGFua3MgdG8gcmVwbGFjaW5nIG12bmV0YV9mcmFnX2FsbG9j
L2ZyZWUgd2l0aCB1c2luZw0KPiBlbnRpcmUgcGFnZXMgZm9yIFJYIGJ1ZmZlcnMuIEkgaGF2ZSAy
IHF1ZXN0aW9uczoNCj4gLSB3aXRob3V0IHJldmVydGluZyBhbnl0aGluZywgZG8geW91IG9ic2Vy
dmUgbWVtb3J5IGFsbG9jYXRpb24NCj4gcHJvYmxlbXMgZHVyaW5nIHJlZmlsbD8NCg0KSSBzZWUg
bWVtb3J5IHdhc3RlOiBGb3Igbm9ybWFsIDE1MDAgTVRVLCBiZWZvcmUgY29tbWl0IDdlNDdmZDg0
YjU2YmIgd2UNCmFsbG9jYXRlIDE5MjBCeXRlcyBmb3IgcnguIEFmdGVyIGNvbW1pdCA3ZTQ3ZmQ4
NGI1NmJiLCB3ZSBhbHdheXMgYWxsb2NhdGUNClBBR0VfU0laRSBieXRlcywgaWYgUEFHRV9TSVpF
PTQwOTYsIHdlIHdhc3RlIDUzJSBtZW1vcnkgZm9yIGVhY2ggcnggYnVmLg0KDQo+IC0gYXJlIHlv
dSBhYmxlIHRvIGNoZWNrIEwyIGZvcndhcmRpbmcgbnVtYmVycyBvbiB0b3Agb2YgdGhlIHB1cmUN
Cj4gbWFpbmxpbmUgYnJhbmNoIGFuZCBhZnRlciByZXZlcnRpbmcgdGhlIG1lbnRpb25lZCBwYXRj
aGVzPyBJJ20NCj4gd29uZGVyaW5nIHdoYXQgd291bGQgYmUgdGhlIHBlcmZvcm1hbmNlIHBlbmFs
dHkgKGlmIGFueSkuDQoNCkkgZGlkbid0IGhhdmUgdGhlIG51bWJlcnMuIElNSE8sIHdoZW4gdGhl
IHBlcmZvcm1hbmNlIG51bWJlciBzaG91bGQNCmJlIHB1dCBpbnRvIHRoZSBjb21taXQgbXNnIHdo
ZW4gaW50cm9kdWNpbmcgY29tbWl0IDdlNDdmZDg0YjU2YmIuDQoNClRoYW5rcw0KDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IE1hcmNpbg0KPiANCj4gPg0KPiA+ICANCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNYXJjaW4gV29qdGFzIDxtd0BzZW1paGFsZi5jb20+DQo+ID4gPiAtLS0NCj4g
PiA+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212bmV0YS5jIHwgNiArKystLS0NCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tYXJ2ZWxsL212bmV0
YS5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWFydmVsbC9tdm5ldGEuYw0KPiA+ID4gaW5kZXgg
ZTUzOTdjOC4uNjFiMjM0OSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L21hcnZlbGwvbXZuZXRhLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21hcnZl
bGwvbXZuZXRhLmMNCj4gPiA+IEBAIC00MDgsNyArNDA4LDYgQEAgc3RydWN0IG12bmV0YV9wb3J0
IHsNCj4gPiA+ICAgICAgIHN0cnVjdCBtdm5ldGFfcGNwdV9zdGF0cyBfX3BlcmNwdSAgICAgICAq
c3RhdHM7DQo+ID4gPg0KPiA+ID4gICAgICAgaW50IHBrdF9zaXplOw0KPiA+ID4gLSAgICAgdW5z
aWduZWQgaW50IGZyYWdfc2l6ZTsNCj4gPiA+ICAgICAgIHZvaWQgX19pb21lbSAqYmFzZTsNCj4g
PiA+ICAgICAgIHN0cnVjdCBtdm5ldGFfcnhfcXVldWUgKnJ4cXM7DQo+ID4gPiAgICAgICBzdHJ1
Y3QgbXZuZXRhX3R4X3F1ZXVlICp0eHFzOw0KPiA+ID4gQEAgLTI5MDUsNyArMjkwNCw5IEBAIHN0
YXRpYyB2b2lkIG12bmV0YV9yeHFfaHdfaW5pdChzdHJ1Y3QgbXZuZXRhX3BvcnQgKnBwLA0KPiA+
ID4gICAgICAgaWYgKCFwcC0+Ym1fcHJpdikgew0KPiA+ID4gICAgICAgICAgICAgICAvKiBTZXQg
T2Zmc2V0ICovDQo+ID4gPiAgICAgICAgICAgICAgIG12bmV0YV9yeHFfb2Zmc2V0X3NldChwcCwg
cnhxLCAwKTsNCj4gPiA+IC0gICAgICAgICAgICAgbXZuZXRhX3J4cV9idWZfc2l6ZV9zZXQocHAs
IHJ4cSwgcHAtPmZyYWdfc2l6ZSk7DQo+ID4gPiArICAgICAgICAgICAgIG12bmV0YV9yeHFfYnVm
X3NpemVfc2V0KHBwLCByeHEsIFBBR0VfU0laRSA8IFNaXzY0SyA/DQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBR0VfU0laRSA6DQo+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1WTkVUQV9SWF9CVUZfU0laRShwcC0+cGt0X3Np
emUpKTsNCj4gPiA+ICAgICAgICAgICAgICAgbXZuZXRhX3J4cV9ibV9kaXNhYmxlKHBwLCByeHEp
Ow0KPiA+ID4gICAgICAgICAgICAgICBtdm5ldGFfcnhxX2ZpbGwocHAsIHJ4cSwgcnhxLT5zaXpl
KTsNCj4gPiA+ICAgICAgIH0gZWxzZSB7DQo+ID4gPiBAQCAtMzc2MCw3ICszNzYxLDYgQEAgc3Rh
dGljIGludCBtdm5ldGFfb3BlbihzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KPiA+ID4gICAgICAg
aW50IHJldDsNCj4gPiA+DQo+ID4gPiAgICAgICBwcC0+cGt0X3NpemUgPSBNVk5FVEFfUlhfUEtU
X1NJWkUocHAtPmRldi0+bXR1KTsNCj4gPiA+IC0gICAgIHBwLT5mcmFnX3NpemUgPSBQQUdFX1NJ
WkU7DQo+ID4gPg0KPiA+ID4gICAgICAgcmV0ID0gbXZuZXRhX3NldHVwX3J4cXMocHApOw0KPiA+
ID4gICAgICAgaWYgKHJldCkgIA0KPiA+ICANCg0K
