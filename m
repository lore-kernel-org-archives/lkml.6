Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C4BC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFBE2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Opp5m9Cm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbfAYJpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:45:30 -0500
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:40838
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727689AbfAYJpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrkToTWg46AKA/YnezVCLe+JqTllz3ij3C03cFnfLKE=;
 b=Opp5m9CmTRssVNOvaDicU6Nb1Av+7vnYMojLM+IdOHK/yQQEK/ALXf/POtnUaFs+zlLlHa9eLDlBnruSaM5yJzZfVCfxCUEbA2uC5f3LgkhSrhXubqJm17cTzbHBidQio3e9XoEtF09Y/tl8UGqw8G3heJfc1ogWzCbWRNbdAv4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.148.143) by
 AM0PR04MB5636.eurprd04.prod.outlook.com (20.178.118.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Fri, 25 Jan 2019 09:45:26 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::69ce:7da3:3bcf:d903%3]) with mapi id 15.20.1537.032; Fri, 25 Jan 2019
 09:45:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     "mst@redhat.com" <mst@redhat.com>,
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
Thread-Index: AQHUsUUJrf+HCksNJUevQFBecw2Jm6W7t2+AgAC8CgCAAOh3gIAAAqqAgAJgxoA=
Date:   Fri, 25 Jan 2019 09:45:26 +0000
Message-ID: <AM0PR04MB4481F3986CFB6D1EF26FA135889B0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <20190121050056.14325-1-peng.fan@nxp.com>
 <alpine.DEB.2.10.1901221113410.17936@sstabellini-ThinkPad-X260>
 <20190123071232.GA20526@infradead.org>
 <alpine.DEB.2.10.1901230935280.17936@sstabellini-ThinkPad-X260>
 <20190123211405.GA4971@infradead.org>
In-Reply-To: <20190123211405.GA4971@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5636;6:NMERXxFSzhhxylxN0unqzD1s5OWmgW/umJBdUMw230eozuG5kO61wTS/ElKXhnIQi1Qx5gyfLnGN65oqb3wPiik0T6M4iB8NkP/zw/02rzxCmjw3XWuOkMiVWJK2iZcmCY3V85h3c9hdV0KtA3zce6QfvCvAvKRpKsJyv12b2g6d31LqanTtdU6IWbu/XDDPI0Rc4QbF2REr37oMGgwb1d7V1z7w8/ahGklqj1VZc52JRm5De7jZHmB4pcXv02yyvCIZyXiElMz3KRQohlxjc/RuhzML5e89xb+fT6oX8r6uJ04BjAekz9Et/65pwd1HMNK2TiarspJqck1LuRHonejO0pnMXtwLAwmFsqKILnRuW+qm1nsqIkZWeODR5tR/5BRq6+zTRdfVr5gi6XVCjxPJraZFNH/etvSe2TYxCP+lwI1xdO61J1Q049Bno1OaRaHMtcShYcS98E4nQDErDA==;5:tgAMHyHf6LUle4bUyDaVZXpZwMkmedbmnqrhlQ3OHFya4rovbBgBpmAyCqRLkLIllv3+u1jfH6bFq9zYmxaMFk6G6fUbISdqyUV6W1mm5EsVcDuhBxzsj7wv9YzOWnmobRozwq7lOgF16HKmbhWXyKHyWuKP+QC9yflHz+KemzoD7ceU7s9DP1J1vB00PWmbtlge/uGjj4w9zVfPINL+zA==;7:QEjzpCtNtazOF45tZLhNkQf8RVJTX8Vk4wdoVDNnj1yD7wYJeri/RSaEYclxWNJgkWtKvLnuJkDoIaa/JR0OikJs3KGVxdOpqdscdwnmokPCutiHxhQstls8v7jGv+LXc/22l49+vmRVUiJbwEyB+Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 48f2dae2-2b67-4545-b1e0-08d682a9d5ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5636;
x-ms-traffictypediagnostic: AM0PR04MB5636:
x-microsoft-antispam-prvs: <AM0PR04MB5636D05B19944A7EF29AB907889B0@AM0PR04MB5636.eurprd04.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(13464003)(105586002)(2906002)(106356001)(66066001)(6246003)(2501003)(305945005)(11346002)(446003)(486006)(476003)(478600001)(7736002)(74316002)(44832011)(256004)(53936002)(33656002)(14454004)(71190400001)(71200400001)(4326008)(7416002)(25786009)(93886005)(68736007)(26005)(81166006)(8676002)(81156014)(3846002)(186003)(8936002)(53546011)(6506007)(97736004)(54906003)(110136005)(6116002)(316002)(86362001)(76176011)(229853002)(9686003)(55016002)(102836004)(99286004)(6436002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5636;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EboySHfvzVLNcgK4MEeZ8hL2zRZJ0iSrwE7z758Sd5RifWzrXlksfnoVIEDRc2ALhEk2fpK8qQjzcjHt3MKW+oz3eHyIsBlNJrZr+rxYDlEv7s6Ja1L56x8hz9lWTz4fA/favuzrAOO9ug6mLOLRGnIWfNSi+ilIO9tZw4qhRvvyF0sQ412IqYn7QkRo2dgldCe+8qLOU/LiLCm08tQnnVFH8da+tdGwRztEP0pxq3aFcgwQ/ypnFaxPx9M0JgjoW+i18QsRyMxxMX2CscaGVhdJyw+4Lr9MmqtaG9jhU3tcVPMnjC7E69FvPqFyIzWk7ZBpZFtzNdO04VqPcO0b069t5fVqKTkVgG3LgZ+bpB2fnYlr42hFbWCNmGtHR2s8xNjoJjlI+BIDdXMs4yvv1/QJNmktE5sIrhW2oqgcP8c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f2dae2-2b67-4545-b1e0-08d682a9d5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 09:45:26.6481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogaGNoQGluZnJhZGVh
ZC5vcmcgW21haWx0bzpoY2hAaW5mcmFkZWFkLm9yZ10NCj4gU2VudDogMjAxOeW5tDHmnIgyNOaX
pSA1OjE0DQo+IFRvOiBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+
DQo+IENjOiBoY2hAaW5mcmFkZWFkLm9yZzsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBt
c3RAcmVkaGF0LmNvbTsNCj4gamFzb3dhbmdAcmVkaGF0LmNvbTsgeGVuLWRldmVsQGxpc3RzLnhl
bnByb2plY3Qub3JnOw0KPiBsaW51eC1yZW1vdGVwcm9jQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmc7IGx1dG9Aa2VybmVsLm9yZzsgamdyb3NzQHN1c2UuY29tOw0KPiBib3Jpcy5v
c3Ryb3Zza3lAb3JhY2xlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1hlbi1kZXZlbF0gW1JGQ10gdmly
dGlvX3Jpbmc6IGNoZWNrIGRtYV9tZW0gZm9yIHhlbl9kb21haW4NCj4gDQo+IE9uIFdlZCwgSmFu
IDIzLCAyMDE5IGF0IDAxOjA0OjMzUE0gLTA4MDAsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToN
Cj4gPiBJZiB2cmluZ191c2VfZG1hX2FwaSBpcyBhY3R1YWxseSBzdXBwb3NlZCB0byByZXR1cm4g
dHJ1ZSB3aGVuDQo+ID4gZG1hX2Rldi0+ZG1hX21lbSBpcyBzZXQsIHRoZW4gYm90aCBQZW5nJ3Mg
cGF0Y2ggYW5kIHRoZSBwYXRjaCBJIHdyb3RlDQo+ID4gYXJlIG5vdCBmaXhpbmcgdGhlIHJlYWwg
aXNzdWUgaGVyZS4NCj4gPg0KPiA+IEkgZG9uJ3Qga25vdyBlbm91Z2ggYWJvdXQgcmVtb3RlcHJv
YyB0byBrbm93IHdoZXJlIHRoZSBwcm9ibGVtDQo+ID4gYWN0dWFsbHkgbGllcyB0aG91Z2guDQo+
IA0KPiBUaGUgcHJvYmxlbSBpcyB0aGUgZm9sbG93aW5nOg0KPiANCj4gRGV2aWNlcyBjYW4gZGVj
bGFyZSBhIHNwZWNpZmljIG1lbW9yeSByZWdpb24gdGhhdCB0aGV5IHdhbnQgdG8gdXNlIHdoZW4g
dGhlDQo+IGRyaXZlciBjYWxscyBkbWFfYWxsb2NfY29oZXJlbnQgZm9yIHRoZSBkZXZpY2UsIHRo
aXMgaXMgZG9uZSB1c2luZyB0aGUNCj4gc2hhcmVkLWRtYS1wb29sIERUIGF0dHJpYnV0ZSwgd2hp
Y2ggY29tZXMgaW4gdHdvIHZhcmlhbnRzIHRoYXQgd291bGQgYmUgYQ0KPiBsaXR0bGUgdG8gbXVj
aCB0byBleHBsYWluIGhlcmUuDQo+IA0KPiByZW1vdGVwcm9jIG1ha2VzIHVzZSBvZiB0aGF0IGJl
Y2F1c2UgYXBwYXJlbnRseSB0aGUgZGV2aWNlIGNhbiBvbmx5DQo+IGNvbW11bmljYXRlIHVzaW5n
IHRoYXQgcmVnaW9uLiAgQnV0IGl0IHRoZW4gZmVlZHMgYmFjayBtZW1vcnkgb2J0YWluZWQNCj4g
d2l0aCBkbWFfYWxsb2NfY29oZXJlbnQgaW50byB0aGUgdmlydGlvIGNvZGUuICBGb3IgdGhhdCBp
dCBjYWxscw0KPiB2bWFsbG9jX3RvX3BhZ2Ugb24gdGhlIGRtYV9hbGxvY19jb2hlcmVudCwgd2hp
Y2ggaXMgYSBodWdlIG5vLWdvIGZvciB0aGUNCj4gxJBNQSBBUEkgYW5kIG9ubHkgd29ya2VkIGFj
Y2lkZW50YWxseSBvbiBhIGZldyBwbGF0Zm9ybSwgYW5kIGFwcGFyZW50bHkNCj4gYXJtNjQganVz
dCBjaGFuZ2VkIGEgZmV3IGludGVybmFscyB0aGF0IG1hZGUgaXQgc3RvcCB3b3JraW5nIGZvciBy
ZW1vdGVwcm9jLg0KPiANCj4gVGhlIHJpZ2h0IGFuc3dlciBpcyB0byBub3QgdXNlIHRoZSBETUEg
QVBJIHRvIGFsbG9jYXRlIG1lbW9yeSBmcm9tIGENCj4gZGV2aWNlLXNwZWZpY2ljIHJlZ2lvbiwg
YnV0IHRvIHRpZSB0aGUgZHJpdmVyIGRpcmVjdGx5IGludG8gdGhlIERUIHJlc2VydmVkDQo+IG1l
bW9yeSBBUEkgaW4gYSB3YXkgdGhhdCBhbGxvd3MgaXQgdG8gZWFzaWx0IG9idGFpbiBhIHN0cnVj
dCBkZXZpY2UgZm9yIGl0Lg0KDQpKdXN0IGhhdmUgYSBxdWVzdGlvbiwgDQoNClNpbmNlIHZtYWxs
b2NfdG9fcGFnZSBpcyBvayBmb3IgY21hIGFyZWEsIG5vIG5lZWQgdG8gdGFrZSBjbWEgYW5kIHBl
ciBkZXZpY2UNCmNtYSBpbnRvIGNvbnNpZGVyYXRpb24gcmlnaHQ/IA0KDQp3ZSBvbmx5IG5lZWQg
dG8gaW1wbGVtZW50IGEgcGllY2UgY29kZSB0byBoYW5kbGUgcGVyIGRldmljZSBzcGVjaWZpYyBy
ZWdpb24NCnVzaW5nIFJFU0VSVkVETUVNX09GX0RFQ0xBUkUsIGp1c3QgbGlrZToNClJFU0VSVkVE
TUVNX09GX0RFQ0xBUkUocnBtc2ctZG1hLCAicnBtc2ctZG1hLXBvb2wiLCANCnJtZW1fcnBtc2df
ZG1hX3NldHVwKTsNCkFuZCBpbXBsZW1lbnQgdGhlIGRldmljZV9pbml0IGNhbGwgYmFjayBhbmQg
YnVpbGQgYSBtYXAgYmV0d2VlbiBwYWdlIGFuZCBwaHlzLg0KVGhlbiBpbiBycG1zZyBkcml2ZXIs
IHNjYXR0ZXIgbGlzdCBjb3VsZCB1c2UgcGFnZSBzdHJ1Y3R1cmUsIG5vIG5lZWQgdm1hbGxvY190
b19wYWdlDQpmb3IgcGVyIGRldmljZSBkbWEuDQoNCklzIHRoaXMgdGhlIHJpZ2h0IHdheT8NCg0K
VGhhbmtzDQpQZW5nLg0KDQo+IA0KPiBUaGlzIGlzIG9ydGhvZ29uYWwgdG8gYW5vdGhlciBpc3N1
ZSwgYW5kIHRoYXQgaXMgdGhhdCBoYXJkd2FyZSB2aXJ0aW8gZGV2aWNlcw0KPiByZWFsbHkgYWx3
YXlzIG5lZWQgdG8gdXNlIHRoZSBETUEgQVBJLCBvdGhlcndpc2Ugd2UnbGwgYnlwYXNzIHN1Y2gg
ZmVhdHVyZXMNCj4gYXMgdGhlIGRldmljZSBzcGVjaWZpYyBETUEgcG9vbHMsIERNQSBvZmZzZXRz
LCBjYWNoZSBmbHVzaGluZywgZXRjLCBldGMuDQo=
