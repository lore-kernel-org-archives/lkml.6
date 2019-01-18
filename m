Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63AAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5966520855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="CF7rZFyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfARJkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:40:05 -0500
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:37687
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfARJkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XWPmsgZ2qBJ/E5EarTyv7tZur171yNVb1UhAYC+NGY=;
 b=CF7rZFyiYEcl/2FgAefwu3tM8hq1aMsokOfKCtNw3xz//Ho4wkZEnJdkr1Mc8G1CAC8w49vcb25iW+cGQue33XCUKLhHPU1yX3If/3jxlFo4ln7rlDa3Wff8TlqkfoXVpvdOzdeaxb3N0lsVuomObREtmC1PeyA3qFNctpzfj/c=
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com (20.177.33.25) by
 AM6PR03MB4647.eurprd03.prod.outlook.com (20.177.35.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 09:40:00 +0000
Received: from AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37]) by AM6PR03MB4327.eurprd03.prod.outlook.com
 ([fe80::844b:fab6:64d8:2f37%3]) with mapi id 15.20.1516.019; Fri, 18 Jan 2019
 09:40:00 +0000
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Gerd Hoffmann <kraxel@redhat.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "noralf@tronnes.org" <noralf@tronnes.org>
Subject: Re: [PATCH v2] drm/xen-front: Make shmem backed display buffer
 coherent
Thread-Topic: [PATCH v2] drm/xen-front: Make shmem backed display buffer
 coherent
Thread-Index: AQHUrNs7IxVSN/1nuUaI+Ik1wHznAaWxcBsAgAAB0ICAAAHygIABvZOAgAGYZ4A=
Date:   Fri, 18 Jan 2019 09:40:00 +0000
Message-ID: <1cfc5cb4-e481-5d71-29df-958db76fb681@epam.com>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
 <20190116063631.GA10881@infradead.org>
 <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
 <20190117091815.GA7090@infradead.org>
In-Reply-To: <20190117091815.GA7090@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
x-originating-ip: [85.223.209.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR03MB4647;6:bsQQ7uqCy1AEf81m4cRSaL5QKWtcsv4fXJ13rFVi4hZQ4zgTqYf2/rTBl3zhPKoWQc42YAJX7YPzJAtRT2Ifk3p944HrVIi0IQbVx9G8/myn/Mnd42gZfRxmp76ft4JmECEFBrubobw40mT5T8PsOVgzZ/lg7BduNv+8MzsI3XlZNm1oKRsrVAM4TRGbIgVvusuUe5/qhlXArJXtQ2X0HddZJU8m2wwJUXAjPoDSEf8SM5uaUNSrYQe/CBesVLuzG4/jI4rluV3p+uGC0xwuKZc1cOSRJDSYe0kx7HXso+77QcGBLqxdIn2Hbe8ax8rx25ZY/zXukW3kHJKwOQvsU1L0QreUpZXm8e8FLa23MkwV5V2Yz2ewQ9PRs+yYhBk9nA2DTS5945Aupghwcx6GirgBRgyJWyX69iBwr3rKAIYondnfCBeN10296P1fTwqBV0nuBSphZVjGZIaOAs9Phg==;5:eCRjh7qss0M5dFeuDB9OYmxN5czgMRYBqrIqp8Yr/OGCKUHHfzvD4arwzLd+kwt8ZSEB0PPRFZnpKYfR1mTBvs8hKddpDaMwoAQrl6aXWwNA0d4a6VaUFgt5gA0l58oyIUVxg4LPJ5M9unPedcjK8pTEdWfLUBRRweslH4vXTeeqJ91ZMQNOWdcldtbAUMqAxdcH+SVp0BJaWSI45f9Qbg==;7:Na1Lr26+MHJc83sAIh+R5JvNNiIMa34F0ErUxPtr1xWG3Mz9cTBl5lTkcV+YjueBH7tiYKr7J7Nl7GZzlUc68H0oNNzC/pCrGILiMwh5jHyr+MwZL9I2TDOIvGIr6hRonzTyZmqKzMYUGh6NpceQwQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f9d2decd-ab1b-4f4a-6085-08d67d28ea98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR03MB4647;
x-ms-traffictypediagnostic: AM6PR03MB4647:
x-microsoft-antispam-prvs: <AM6PR03MB464771752C710306AF1AA7DDE79C0@AM6PR03MB4647.eurprd03.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(396003)(39860400002)(189003)(199004)(2616005)(81166006)(53936002)(6916009)(81156014)(305945005)(36756003)(6512007)(8936002)(68736007)(7736002)(8676002)(256004)(5660300001)(106356001)(99286004)(14454004)(2906002)(72206003)(4326008)(3846002)(6116002)(102836004)(6246003)(478600001)(39060400002)(76176011)(486006)(71200400001)(316002)(54906003)(97736004)(80792005)(11346002)(31686004)(53546011)(66066001)(229853002)(25786009)(93886005)(7416002)(26005)(86362001)(186003)(6436002)(446003)(71190400001)(6486002)(6506007)(31696002)(105586002)(476003)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR03MB4647;H:AM6PR03MB4327.eurprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eIt9vDrbhSvvZ3vmc5KDZZmxaqdUo8MePFPWzhDnuRaOhZVss4eojBr8ihTzjLde/NVkPF7t8ml7pIzv4t1w9WBlVCprWsJkFRlOIYEs3RJ2HoaugvocGbMxEVo4wp2HyJ60dhfn51f+ejv0QKew/Zam6mLk/+IcmI+7oMARJHSIuu0ayD5FiFf4jfP5E5Dtle02Pv20LTtAdW4Xb1EY01ow7MutRPgkFPqKizyT2+yrPkBvy5tjexj1XGlIer0uT4jMegw2rtwJ1sr03/TRxgL8+MnWHBiKEoV1yJXO+hglvKFYG1dQcuCkSY1n3bRXYSSMRm2TP7hGhHsBWQlw3QSb/bVt0SAo/4uOwcVthI+LFUa/qweAtAWJo7fSUuFhE7QOtVoPY16rS0/oOaq07jmZL5oDHb3WlLBeMtESv4U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <204A5FE564B9DB4094A3E9EF25F30501@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d2decd-ab1b-4f4a-6085-08d67d28ea98
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 09:40:00.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xNy8xOSAxMToxOCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwg
SmFuIDE2LCAyMDE5IGF0IDA2OjQzOjI5QU0gKzAwMDAsIE9sZWtzYW5kciBBbmRydXNoY2hlbmtv
IHdyb3RlOg0KPj4+IFRoaXMgd2hvbGUgaXNzdWUga2VlcHMgZ2V0dGluZyBtb3JlIGFuZCBtb3Jl
IGNvbmZ1c2luZy4NCj4+IFdlbGwsIEkgZG9uJ3QgcmVhbGx5IGRvIERNQSBoZXJlLCBidXQgaW5z
dGVhZCB0aGUgYnVmZmVycyBpbg0KPj4gcXVlc3Rpb24gYXJlIHNoYXJlZCB3aXRoIG90aGVyIFhl
biBkb21haW4sIHNvIGVmZmVjdGl2ZWx5IGl0DQo+PiBjb3VsZCBiZSB0aG91Z2h0IG9mIHNvbWUg
c29ydCBvZiBETUEgaGVyZSwgd2hlcmUgdGhlICJkZXZpY2UiIGlzDQo+PiB0aGF0IHJlbW90ZSBk
b21haW4uIElmIHRoZSBidWZmZXJzIGFyZSBub3QgZmx1c2hlZCB0aGVuIHRoZQ0KPj4gcmVtb3Rl
IHBhcnQgc2VlcyBzb21lIGluY29uc2lzdGVuY3kgd2hpY2ggaW4gbXkgY2FzZSByZXN1bHRzDQo+
PiBpbiBhcnRpZmFjdHMgb24gc2NyZWVuIHdoaWxlIGRpc3BsYXlpbmcgdGhlIGJ1ZmZlcnMuDQo+
PiBXaGVuIGJ1ZmZlcnMgYXJlIGFsbG9jYXRlZCB2aWEgRE1BIEFQSSB0aGVuIHRoZXJlIGFyZSBu
byBhcnRpZmFjdHM7DQo+PiBpZiBidWZmZXJzIGFyZSBhbGxvY2F0ZWQgd2l0aCBzaG1lbSArIERN
QSBtYXBwaW5nIHRoZW4gdGhlcmUgYXJlIG5vDQo+PiBhcnRpZmFjdHMgYXMgd2VsbC4NCj4+IFRo
ZSBvbmx5IG9mZmVuZGluZyB1c2UtY2FzZSBpcyB3aGVuIEkgdXNlIHNobWVtIGJhY2tlZCBidWZm
ZXJzLA0KPj4gYnV0IGRvIG5vdCBmbHVzaCB0aGVtDQo+IFRoZSByaWdodCBhbnN3ZXIgd291bGQg
YmUgdG8gaW1wbGVtZW50IGNhY2hlIG1haW50YWluYW5jZSBob29rcyBmb3INCj4gdGhpcyBjYXNl
IGluIHRoZSBYZW4gYXJjaCBjb2RlLiAgVGhlc2Ugd291bGQgYmFzaWNhbGx5IGxvb2sgdGhlIHNh
bWUNCj4gYXMgdGhlIGxvdy1sZXZlbCBjYWNoZSBtYWludGFpbmFuY2UgdXNlZCBieSB0aGUgRE1B
IG9wcywgYnV0IHdpdGhvdXQNCj4gZ29pbmcgdGhyb3VnaCB0aGUgRE1BIG1hcHBpbmcgbGF5ZXIs
IGluIGZhY3QgdGhleSBzaG91bGQgcHJvYmFibHkNCj4gcmV1c2UgdGhlIHNhbWUgbG93LWxldmVs
IGFzc2VtYmx5IHJvdXRpbmVzLg0KPg0KPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgdGhlIGZpcnN0
IHVzYWdlIG9mIHN1Y2ggWGVuIGJ1ZmZlciBzaGFyaW5nLCBzbw0KPiB3aGF0IGRvIHRoZSBvdGhl
ciB1c2VycyBkbz8NCkknbGwgaGF2ZSB0byBnZXQgZXZlbiBkZWVwZXIgaW50byBpdC4gSW5pdGlh
bGx5IEkNCmxvb2tlZCBhdCB0aGUgY29kZSwgYnV0IGRpZG4ndCBmaW5kIGFueXRoaW5nIHVzZWZ1
bC4NCk9yIG1heWJlIEkgaGF2ZSBqdXN0IG92ZXJsb29rZWQgb2J2aW91cyB0aGluZ3MgdGhlcmUN
Cg0KVGhhbmsgeW91LA0KT2xla3NhbmRy
