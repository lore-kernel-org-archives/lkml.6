Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DF4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E5E2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FXN3f0Cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfA2J1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:27:25 -0500
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:61229
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfA2J1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:27:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+pzC84rXpvxv+fbLD1IfwWr2q4rWIWW306IBuS3jbg=;
 b=FXN3f0Cvo32PhA7vdDpTFnhoB//GTc4WW4VsmXkw9RY/oHO0npvEn2U/ZTBjglzl6FXitdZJACaut9V3Skux2xYJ9VeL1tEECq7yi/KZOIYkCY9a/AwDGnpWEX71C6+Kl/l0mlJQv+neGGVVk8xCuwMC1nQCNQBT7YWHtfgwwac=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.148.143) by
 AM0PR04MB4835.eurprd04.prod.outlook.com (20.176.215.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Tue, 29 Jan 2019 09:26:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903%3]) with mapi id 15.20.1558.023; Tue, 29 Jan 2019
 09:26:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Andy Duan <fugang.duan@nxp.com>
Subject: RE: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Topic: [Xen-devel] [RFC] virtio_ring: check dma_mem for xen_domain
Thread-Index: AQHUsUUJrf+HCksNJUevQFBecw2Jm6W7t2+AgAC8CgCAAOh3gIAAAqqAgAJgxoCABJ0ngIABj44Q
Date:   Tue, 29 Jan 2019 09:26:41 +0000
Message-ID: <AM0PR04MB448123F7FEBCEBD63DE0AF8088970@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
 <20190123071232.GA20526@infradead.org>
 <alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260>
 <20190123211405.GA4971@infradead.org>
 <AM0PR04MB4481F3986CFB6D1EF26FA135889B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20190128080028.GA18476@infradead.org>
In-Reply-To: <20190128080028.GA18476@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4835;6:a66CUhZyTY/Jqnbyo2Dg5NHXV9ybIUc4G6DWKkYD9CwLcDrqY1NHvo3Ay1td237c4J5qm0TO8qBPT/3/qj2x9+jsu29oBkwhU+0sXzGJZ8nXTvXfLdsu7nxZao2br9qAX+TJp4rXqGGvDS5tJnxwWPbOmtHoR/d2FssHTapd/bskm2d0Wsz4PrejMoSgzYWhzvsYcf4/ZneEeR/kIvcTOfvC7uFMMLm2pRnaIlZMno6WUpl7SY4BgDzl62MWDXOWSwPj3p2BicVG1q8cOk1/WJuvg5PbHjfieS8fnWvofPeu1QtVzo+ExjthH/owrCiVrmP41DO7dXP32zD/0xhpIderXRQYgTErdI0mR6u/5fYoju5Z70wqtGABRf3+MEAG765OJcnYnl+t2Y0GIiGw7TiHj6tHRzhzE1jhiL/j0p0d1Ggeosxj5kd5TcOgiLHyrLO6jKkhhzqOnYyhlc1URQ==;5:yLlg/+1UOtEto9/ACyKTFDK3p/Db2CQCP3WVHQGuPKAuIZYZYElxE4PUcabcvTZSiJUPil/30Xmru8yTUV7FjU4kuT9YUpFfzNWP+VLt1OEZ44+2lrQnZMCdcZ9wRpxzLPH3c41o+VUG7w1WWtdCpsRh5OUb2THed1gwrEkrO5MtRFxsR+lS0ASHUYMVH1Mel9S9dk92yRUSAgnFBi8F9g==;7:TRFgBjx+m0i+d0Uya9JoROsO3N+IHtUswK6Sl6uJE716DeUldFm+D1uTMcNniz88Eim4LNbCl0+w/U3njnTW1z3sz/60o6hanCDD2x/46hVsNsuK8lvUxQlnaZQMSyLYghYQZmAyiAbhnlB/CzyfRA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c1acabf1-9502-4069-b94f-08d685cbe09e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4835;
x-ms-traffictypediagnostic: AM0PR04MB4835:
x-microsoft-antispam-prvs: <AM0PR04MB4835E9C06FE0357FB1FE699688970@AM0PR04MB4835.eurprd04.prod.outlook.com>
x-forefront-prvs: 093290AD39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(136003)(346002)(13464003)(51914003)(199004)(189003)(6916009)(2906002)(478600001)(2501003)(33656002)(229853002)(26005)(7416002)(53936002)(53546011)(4326008)(6506007)(66066001)(86362001)(446003)(25786009)(102836004)(105586002)(256004)(14454004)(486006)(44832011)(11346002)(316002)(7696005)(106356001)(476003)(55016002)(2351001)(54906003)(7736002)(6246003)(186003)(5640700003)(9686003)(99286004)(74316002)(6436002)(93886005)(68736007)(305945005)(8936002)(1730700003)(71200400001)(8676002)(76176011)(71190400001)(3846002)(6116002)(81156014)(97736004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4835;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Oh4jJqVm4uSpkGxjuaIdkHgJIj+0KrttZZ5cRcjGZRc5HMO8xKr+RZJy0mDUBoyl1bMb6u6k9A+/IT8bT2kuBvlsbr+mi7pIez/Y1rq5yjET1d6x5h9miGdHBqSd0uw+DaaO8Y2C7RoAaBOHqIa2aFTXyKBbMPMmSLxWrinNzV6Kqo+Znv9h/d+1ZllGQPIV/Bv2LFURAoMIF7MimPdHAR0RP1S8YUVkJbagqgJFERqeHpPgoORffLxrQcKCC8TeDo5gRDS1HLlQA7xDslucWoRWJD10mJqXsjMoooB/juvR/exDaMrrIzOcv1H9f6j4wPvz06MpmJ/ClIm7DMYYAXRHHsds9ahWg91RQZdvibALQp1O4uMPTOvIbWNYLXnyLRhz6YDViTSgr+Juoq+3Un2ApiZbhRLCsV+LR8O0FC0=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1acabf1-9502-4069-b94f-08d685cbe09e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2019 09:26:41.2047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogaGNoQGluZnJhZGVhZC5v
cmcgW21haWx0bzpoY2hAaW5mcmFkZWFkLm9yZ10NCj4gU2VudDogMjAxOcTqMdTCMjjI1SAxNjow
MA0KPiBUbzogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IENjOiBoY2hAaW5mcmFkZWFk
Lm9yZzsgU3RlZmFubyBTdGFiZWxsaW5pIDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPjsNCj4gbXN0
QHJlZGhhdC5jb207IGphc293YW5nQHJlZGhhdC5jb207IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9q
ZWN0Lm9yZzsNCj4gbGludXgtcmVtb3RlcHJvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnOyBsdXRvQGtlcm5lbC5vcmc7IGpncm9zc0BzdXNlLmNvbTsNCj4gYm9yaXMub3N0cm92
c2t5QG9yYWNsZS5jb207IEFuZHkgRHVhbiA8ZnVnYW5nLmR1YW5AbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtYZW4tZGV2ZWxdIFtSRkNdIHZpcnRpb19yaW5nOiBjaGVjayBkbWFfbWVtIGZvciB4
ZW5fZG9tYWluDQo+IA0KPiBPbiBGcmksIEphbiAyNSwgMjAxOSBhdCAwOTo0NToyNkFNICswMDAw
LCBQZW5nIEZhbiB3cm90ZToNCj4gPiBKdXN0IGhhdmUgYSBxdWVzdGlvbiwNCj4gPg0KPiA+IFNp
bmNlIHZtYWxsb2NfdG9fcGFnZSBpcyBvayBmb3IgY21hIGFyZWEsIG5vIG5lZWQgdG8gdGFrZSBj
bWEgYW5kIHBlcg0KPiA+IGRldmljZSBjbWEgaW50byBjb25zaWRlcmF0aW9uIHJpZ2h0Pw0KPiAN
Cj4gVGhlIENNQSBhcmVhIGl0c2VsZiBpdCBhIHBoeXNpY2FsIG1lbW9yeSByZWdpb24uICBJZiBp
dCBpcyBhIG5vbi1oaWdobWVtDQo+IHJlZ2lvbiB5b3UgY2FuIGNhbGwgdmlydF90b19wYWdlIG9u
IHRoZSB2aXJ0dWFsIGFkZHJlc3NlcyBmb3IgaXQuICBJZiBpdCBpcyBpbg0KPiBoaWdobWVtIGl0
IGRvZXNuJ3QgZXZlbiBoYXZlIGEga2VybmVsIHZpcnR1YWwgYWRkcmVzcyBieSBkZWZhdWx0Lg0K
PiANCj4gPiB3ZSBvbmx5IG5lZWQgdG8gaW1wbGVtZW50IGEgcGllY2UgY29kZSB0byBoYW5kbGUg
cGVyIGRldmljZSBzcGVjaWZpYw0KPiA+IHJlZ2lvbiB1c2luZyBSRVNFUlZFRE1FTV9PRl9ERUNM
QVJFLCBqdXN0IGxpa2U6DQo+ID4gUkVTRVJWRURNRU1fT0ZfREVDTEFSRShycG1zZy1kbWEsICJy
cG1zZy1kbWEtcG9vbCIsDQo+ID4gcm1lbV9ycG1zZ19kbWFfc2V0dXApOyBBbmQgaW1wbGVtZW50
IHRoZSBkZXZpY2VfaW5pdCBjYWxsIGJhY2sgYW5kDQo+ID4gYnVpbGQgYSBtYXAgYmV0d2VlbiBw
YWdlIGFuZCBwaHlzLg0KPiA+IFRoZW4gaW4gcnBtc2cgZHJpdmVyLCBzY2F0dGVyIGxpc3QgY291
bGQgdXNlIHBhZ2Ugc3RydWN0dXJlLCBubyBuZWVkDQo+ID4gdm1hbGxvY190b19wYWdlIGZvciBw
ZXIgZGV2aWNlIGRtYS4NCj4gPg0KPiA+IElzIHRoaXMgdGhlIHJpZ2h0IHdheT8NCj4gDQo+IEkg
dGhpbmsgdGhpcyBzaG91bGQgd29yayBmaW5lLiAgSWYgeW91IGhhdmUgdGhlIGN5Y2xlcyBmb3Ig
aXQgSSdkIGFjdHVhbGx5IGxvdmUgdG8NCj4gYmUgYWJsZSB0byBoYXZlIGdlbmVyaWMgQ01BIERU
IGdsdWUgZm9yIG5vbiBETUEgQVBJIGRyaXZlciBhbGxvY2F0aW9ucywgYXMNCj4gdGhlcmUgb2J2
aW91c2x5IGlzIGEgbmVlZCBmb3IgaXQuICBTbyBiYXNpY2FsbHkgdGhlIHNhbWUgYXMgYWJvdmUs
IGp1c3QgYWRkZWQNCj4gdG8ga2VybmVsL2NtYS5jIGFzIGEgZ2VuZXJpYyBBUEkuDQoNClRoYW5r
cyBmb3IgdGhlIGhpbnRzLiBJJ2xsIHRyeSB0byBhZGQgdGhhdC4NCg0KVGhhbmtzLA0KUGVuZy4N
Cg0KDQo=
