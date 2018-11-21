Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5886DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DB6214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ss1Yjarh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DB6214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbeKVFGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:06:03 -0500
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:64663
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbeKVFGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:06:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abcNXYj9NU+3s0Y9zuoS2JSBG17LBwLgtJGpt+55WqQ=;
 b=Ss1Yjarh0B9pvg3UCDZBCMIQPvZz833LMGBigsMu+f9Msp897FK6KxxZFWEgPXOuGXI6jlg3dgRBuIW825emVXzRgX3x2D8OykVFZtCDoQ26+5Dx0hRtwdUGpx50AWEY0FT4vHLDw8bibhXZRV0dNZuU0rcleKQQ/sCVPjClHYA=
Received: from VI1PR08MB3662.eurprd08.prod.outlook.com (20.177.61.89) by
 VI1PR08MB0736.eurprd08.prod.outlook.com (10.163.169.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Wed, 21 Nov 2018 18:30:30 +0000
Received: from VI1PR08MB3662.eurprd08.prod.outlook.com
 ([fe80::e828:653d:10db:ec36]) by VI1PR08MB3662.eurprd08.prod.outlook.com
 ([fe80::e828:653d:10db:ec36%6]) with mapi id 15.20.1294.045; Wed, 21 Nov 2018
 18:30:30 +0000
From:   Matt Sealey <Matt.Sealey@arm.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Dave Rodgman <dave.rodgman@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>
Subject: RE: [PATCH 2/6] lib/lzo: enable 64-bit CTZ on Arm
Thread-Topic: [PATCH 2/6] lib/lzo: enable 64-bit CTZ on Arm
Thread-Index: AQHUgZGqULV2oqigzk6I0IddWXlQv6VafN0AgAAAOYA=
Date:   Wed, 21 Nov 2018 18:30:29 +0000
Message-ID: <VI1PR08MB36621658EEBA73ADD5294E90EEDA0@VI1PR08MB3662.eurprd08.prod.outlook.com>
References: <20181121115922.22864-2-dave.rodgman@arm.com>
 <20181121115922.22864-3-dave.rodgman@arm.com>
 <20181121173114.GA14352@infradead.org>
In-Reply-To: <20181121173114.GA14352@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sealey@arm.com; 
x-originating-ip: [217.140.111.135]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR08MB0736;6:GuhlvoHfO/OmT8e2Rl2xXuvDjn3+hJ0JuDNkLzo3CL2neh3BsOADB1nm/TL6oDUBHP7yI135iQTs7BgANlAM+sDEYrE5lEgWe1PEUns3LfM05iBAdkxOwFgDN/L98VFo8rgs6zn4WRNoooKZVr9xtcdk5GIrvRGzfu1TuVHPAUgi7ZDTLTwZkkNeINpLFRvdy1azKwmlmxWLZHBEjnpyc4dL+34UCF6vOUrrNU0uiO4+uD7LyS1v8t7vZmQ+AXf403nU1Sz9r2ScFheP2zatRYYh8Z073gzxiaDdIVRPQQPek+VSp0TsajNuY4Mzy3aOEXs35zcwEEbBjViMQpNx5WeKyAAZp6LF5UUqVakFFGspMMkMu/ZVZNZRQLktefap8Anh1C4sMflFXSCZ6DraOFgfEPj+0OFmFjRbeiZeZTg8tD6wZwIHLEFGJm+nb0hrs9g3EoiZfHUxhsYJPhSJwQ==;5:n0lw5mmJSyB+EZaqCZL5iS4ilrhMw8pr4m+7FL34+ThWp2zQVGQ6ftHo9ZAF0dX4T5lJe203SUTJjVqsYpfenPhKdiPS9EYOvN/wX4mli8Lk/tfLY8K6u7IgModAXaEw+PPmMKGyb+bdvKiJLqjweURYLSQa4fUi8e3n1X7gAqU=;7:zwyCNzC8WsyFp2I7tQZxHD9jsTF1Z61cFSY93ZIiMsQ6IEJuBHIKMBcKgx7qzzNk6bIx3yFlP1Y0ut7E8e+7PfTWW7G5SWZIG+Z4x6dKZTJ0mhYshxW4tw1NpQJcnSjicgFfsu2PIeef1OLjexgiXg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 07bb1e2a-def0-420c-076f-08d64fdf6a5e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB0736;
x-ms-traffictypediagnostic: VI1PR08MB0736:
nodisclaimer: True
x-microsoft-antispam-prvs: <VI1PR08MB073669121D03CC2DC69C2D18EEDA0@VI1PR08MB0736.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR08MB0736;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB0736;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(5660300001)(68736007)(305945005)(7736002)(97736004)(4326008)(74316002)(6246003)(39060400002)(66066001)(106356001)(71200400001)(71190400001)(25786009)(256004)(72206003)(105586002)(478600001)(53936002)(476003)(11346002)(486006)(316002)(110136005)(81156014)(446003)(8936002)(26005)(6506007)(76176011)(81166006)(8676002)(86362001)(186003)(54906003)(102836004)(55016002)(7696005)(9686003)(3846002)(2906002)(33656002)(6636002)(99286004)(14454004)(2900100001)(6436002)(229853002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB0736;H:VI1PR08MB3662.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oDGlRCTspoppOiYKojJ7e+H00jx8tzyqJTLpPHb6cy5Ci8woZHt8NlbaU4/x9JJeqx5BluPXqKBj2wFwg8hSyFJNBW9/Zl+Yt93pQqHdxKEV2x9jc0VJyhBfAX6DncZFpLlXbOYMf0mqQ7LaQph0OPySO5DyPHaUOkouEnV7TCc18vm4iHnWZjQfLrAa0GosWgGLu2vJgkWFro1flu8oxvJKUehcxVsF66NJtsMr7ZaXZVR4ceemUNLVEVxmLW3jJDjBtCG9xRh0oaUQ45sNJHnoi6/2xGXEcz7bDts8wzyN4bu4VyEBTI3KKUHYqV4A6seU7JNgkZow9aj8I5AZdf8RUwlF4a+U51VBVIDJxc4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bb1e2a-def0-420c-076f-08d64fdf6a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 18:30:29.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB0736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hyaXN0b3BoLA0KDQo+ID4gICNkZWZpbmUgTFpPX1VTRV9DVFozMgkxDQo+ID4gICNlbGlm
IGRlZmluZWQoX19pMzg2X18pIHx8IGRlZmluZWQoX19wb3dlcnBjX18pDQo+ID4gICNkZWZpbmUg
TFpPX1VTRV9DVFozMgkxDQo+ID4gLSNlbGlmIGRlZmluZWQoX19hcm1fXykgJiYgKF9fTElOVVhf
QVJNX0FSQ0hfXyA+PSA1KQ0KPiA+ICsjZWxpZiBkZWZpbmVkKF9fYXJtX18pDQo+ID4gKyNpZiAo
X19MSU5VWF9BUk1fQVJDSF9fID49IDUpDQo+ID4gICNkZWZpbmUgTFpPX1VTRV9DVFozMgkxDQo+
ID4gICNlbmRpZg0KPiA+ICsjaWYgKF9fTElOVVhfQVJNX0FSQ0hfXyA+PSA2KSAmJiAoQ09ORklH
X1RIVU1CMl9LRVJORUwpDQo+ID4gKyNkZWZpbmUgTFpPX1VTRV9DVFo2NAkxDQo+IA0KPiBBbGwg
b2YgdGhpcyByZWFsbHkgbmVlZHMgdG8gYmUgZHJpdmVuIGJ5IEtjb25maWcgc3ltYm9scyB0aGF0
DQo+IHRoZSBhcmNoaXRlY3R1cmUgc2VsZWN0cyBpbnN0ZWFkIG9mIG1hZ2ljIGFyY2ggaWZkZWZz
IGhlcmUuDQoNClRMO0RSIHN1bW1hcnk6IExvdyBoYW5naW5nIGZydWl0Lg0KDQpUTCBleHBsYW5h
dGlvbiBvZiB0aGUgdGhvdWdodCBwcm9jZXNzOg0KDQpSYXRoZXIgdGhhbiB1c2luZyBhcmNoIGlm
ZGVmcywgaXQgc2VlbXMgd2UgY2FuIGRvIF9fYnVpbHRpbl9jdHpsbCgpDQphbmQgX19idWlsdGlu
X2NsemxsKCkgb24gYWxsIGFyY2hpdGVjdHVyZXMgd2l0aCBubyBtZWFzdXJhYmxlIGltcGFjdA0K
dG8gY29kZWdlbiAtIGxpYmdjYyBpbXBsZW1lbnRzIHRoZW0gYXMgX19idWlsdGluX2N0ei9jbHog
ZXZlcnl3aGVyZQ0KSSd2ZSBsb29rZWQsIHNvIGdjYyBhdCBsZWFzdCBpcyBnb2luZyB0byB1c2Ug
dGhhdCBjb2RlIGZvciB0aGUNCmJ1aWx0aW5zLiBPbiAzMi1iaXQgQXJtIGl0IGludHJvZHVjZXMg
YSB0aW55IGJpdCBvZiBleHRyYSByZWdpc3Rlcg0KcHJlc3N1cmUgaW4gdGhlIGluc3RydWN0aW9u
IHNlcXVlbmNlIGJ1dCBpdCdzIG5vdCBtZWFzdXJhYmxlLg0KDQpUaGF0IGlzIHRvIHNheSB0aGF0
IHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gYXJjaGl0ZWN0dXJlcyBvcg0KYXJjaGl0ZWN0dXJlIHZl
cnNpb25zIGlzbid0IHRoZSBhdmFpbGFiaWxpdHkgb2YgYSBjb3VudC1sZWFkaW5nLXplcm9zDQpv
cHRpbWl6YXRpb24gb3IgdGhlIGJ1aWx0aW4gb3IgYW4gZWZmaWNpZW50IGFsZ29yaXRobSwgYnV0
IHRoZSBjb2RlDQpwcmVjZWRpbmcgaXQgdG8gY29sbGVjdCBhIDY0LWJpdCBxdWFudGl0eSB0byBj
b3VudC4NCg0KVGhhdCBpcyBhIHdob2xlIG90aGVyIGNsZWFudXAuDQoNCkxvbmdlcjoNCg0KSnVz
dCB0byBmdXJ0aGVyIHRoZSBwb2ludCwgdGhvdWdoLCBpZiB3ZSByYXRpb25hbGl6ZSB0aGUgdXNl
IG9mDQpidWlsdGlucyB0byB1c2UgdGhlIDY0LWJpdCB2ZXJzaW9ucywgdGhlbiB3ZSBtYXkgYXMg
d2VsbCB1c2UgdGhlDQprZXJuZWwgdmVyc2lvbiAtLSBfX2ZmczY0IGlzIF9fYnVpbHRpbl9jbHps
bCBpbiBhc20tZ2VuZXJpYyB3aXRoDQp0aGUgcmlnaHQgbWFnaWMgYXJjaCBLY29uZmlnLCBhbmQg
aWYgbm90IGFyY2hlcyBwcm92aWRlIGV4YWN0bHkNCnRoZSBzYW1lIGNvZGUgYXMgTFpPJ3MgZmFs
bGJhY2sgd2hlbiBMWk9fVVNFX0N4Wm5uIGlzbid0IGRlZmluZWQuDQoNCkV2ZW4gdGhlIGRpc3Rp
bmN0aW9uIGJldHdlZW4gbGl0dGxlIGFuZCBiaWcgZW5kaWFuIGlzIG1vb3QsIHNpbmNlDQoNCiAg
ICBfX2J1aWx0aW5fY2x6bGwoY3B1X3RvX2JlMzIobikpIA0KDQphbW91bnRzIHRvIHByZWNpc2Vs
eSB0aGUgc2FtZSBkaXNhc3NlbWJseSBvbiBib3RoIGFybSBhbmQgYXJtNjQNCmFzIF9fYnVpbHRp
bl9jdHpsbChuKSwgc28gd2UgY2FuIGp1c3QgZ28gdGhlIHdob2xlIGhvZywgcmVwbGFjZQ0KdGhl
IDMyLWJpdCBsb2FkcyBhbmQgeG9yIHdpdGggNjQtYml0IG9uZXMsIGFuZCBkbzoNCg0KICAgIF9f
ZmZzNjQoY3B1X3RvX2JlMzIobikpDQoNCndoaWNoIGdyZWF0bHkgcmVkdWNlcyBjb2RlIGNvbXBs
ZXhpdHkgaW4gdGhlIG1haW4gTFpPIGNvZGUgYnkNCnJlbW92aW5nIHRoZSBkaXN0aW5jdGlvbi4N
Cg0KSXQgdHVybnMgb3V0IHRoZSBjb21waWxlciBrbm93cyB3aGF0IGl0J3MgZG9pbmcsIGFuZCB3
aGVyZSBpdA0KZG9lc24ndCwgdGhlIGFyY2ggbWFpbnRhaW5lcnMgZG8uDQoNClRoZXJlaW4gbGll
cyB0aGUgcnViOyB0aGUgc291cmNlIGdldHMgc21hbGxlciBhbmQgd2UgbG9zZSB0aGUNCmFyY2gv
ZW5kaWFuIGRpc3RpbmN0aW9uIGJ1dCB0aGUgZWZmaWNpZW5jeSBvZiB0aGUgcHJlY2VkaW5nIDY0
LWJpdA0KbG9hZCBhbmQgZXhjbHVzaXZlLW9yIG5lZWRzIGludmVzdGlnYXRpb24uIFdlIHN0aWxs
IGhhdmUgdG8NCmZpZ3VyZSBvdXQgcGVyIGFyY2hpdGVjdHVyZSB3aGF0IHRoZSBtb3N0IGVmZmlj
aWVudCBlbGVtZW50IHNpemUNCmlzIG9yIGlmIHRoZXJlJ3MgYSBoaWRlb3VzIHhvcigodTY0KSBu
KSBpbXBsZW1lbnRhdGlvbi4NCg0KSSBzaW1wbHkgZG9uJ3QgaGF2ZSBjb25maWRlbmNlIGluIGFu
eXRoaW5nIGV4Y2VwdCB0aGF0IHRoZSBtYWdpYw0KYXJjaCBpZmRlZnMgd29yayB0byBpbXByb3Zl
IHBlcmZvcm1hbmNlIHdpdGhvdXQgY2hhbmdpbmcgdG9vIG11Y2gsDQphbmQgdGhlIG1lc3MgaXQg
aW50cm9kdWNlcyBoZXJlIGJlbGllcyB0aGUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQNCml0IHBy
b3ZpZGVzLiBWZXJzdXMgdGhlIHRydWUgc2NvcGUgb2YgdGhlIGNvZGUgY2xlYW51cCB0byBkbyBp
dA0KcmlnaHQsIGl0J3MgYSB2ZXJ5IGNvbmNpc2UgYW5kIHJlbGlhYmxlIGFuZCB3aXRoaW4tc3R5
bGUgaW1wcm92ZW1lbnQuDQoNCldvdWxkIHdlIGFncmVlIHRvIGxldCBpdCBpbiBmb3Igbm93IG9u
IHRoZSBiYXNpcyB0aGF0IHdlIHRob3VnaHQNCmFib3V0IGl0IGJ1dCBJIHNpZGUgd2l0aCBNRlhK
TydzIHVyZ2VuY3k/DQoNClRhIQ0KTWF0dCBTZWFsZXkgPG1hdHQuc2VhbGV5QGFybS5jb20+DQpB
cm0gUGFydG5lciBFbmFibGVtZW50IEdyb3VwDQoNCg==
