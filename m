Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABF1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD1B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="e/Nxaqjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfAHJvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:51:54 -0500
Received: from mail-eopbgr730086.outbound.protection.outlook.com ([40.107.73.86]:53376
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbfAHJvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj0OZwEox1+p/ik+eVqmd+BdEtgPtyivAKOKNKTZ2hE=;
 b=e/NxaqjqLPWzYttivhJTwiyDgtTpedZYD/S6YTwuAbY/qjopZZt2X25vATaVS/heca2VTMIQBixAWHujGajTreM4X8qe3sd+1nISRsCygsFMiPs7PZWaTrjnAmAWVAzC9+iH5SzwXmuc2TbDooIPEz5mJZnj7s3S+hkclOlGecM=
Received: from BYAPR05MB5592.namprd05.prod.outlook.com (20.177.186.153) by
 BYAPR05MB5383.namprd05.prod.outlook.com (20.177.184.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.2; Tue, 8 Jan 2019 09:51:45 +0000
Received: from BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919]) by BYAPR05MB5592.namprd05.prod.outlook.com
 ([fe80::4a1:2561:2487:5919%4]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 09:51:45 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: fix DMA ops layering violations in vmwgfx
Thread-Topic: fix DMA ops layering violations in vmwgfx
Thread-Index: AQHUpMzZVFIPYaGKbE2WJhk3NBDIkqWlJeuA
Date:   Tue, 8 Jan 2019 09:51:45 +0000
Message-ID: <99091bb861e21d5bb4182f08dedbc494c637cc0f.camel@vmware.com>
References: <20190105080108.14837-1-hch@lst.de>
In-Reply-To: <20190105080108.14837-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5383;20:6IlN+6pUb54SF2GLU10QS6UkNOTRPSR57XR+OTxqxWk2xvoWmA1J5clTshYUa3YKcjaSndojL1AZRXPNsHzH7TDUd8FH0bQyKQHFxcdHlfcRDTX7fz4KTZl3VIXdc0XuVE7UczeO1B7kIXR5aNGZjIIbbx0Gz03jmgtBchKVmpQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f0142efe-8d50-42f8-290b-08d6754ee67c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5383;
x-ms-traffictypediagnostic: BYAPR05MB5383:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB5383315D111F1E6AB45697A2A18A0@BYAPR05MB5383.namprd05.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(136003)(189003)(199004)(6486002)(71190400001)(71200400001)(476003)(2616005)(14454004)(118296001)(26005)(186003)(8936002)(4326008)(6246003)(229853002)(5640700003)(86362001)(66066001)(478600001)(446003)(11346002)(6436002)(2351001)(6916009)(2906002)(102836004)(6506007)(5660300001)(68736007)(97736004)(256004)(14444005)(53936002)(2501003)(7736002)(305945005)(486006)(76176011)(6512007)(105586002)(36756003)(106356001)(81166006)(3846002)(81156014)(1730700003)(25786009)(6116002)(8676002)(316002)(99286004)(54906003)(17423001)(156123004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5383;H:BYAPR05MB5592.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aUnYtmtgFYA1xkCM3WFEo+M6QcgmUsEqi5fg/wmz4yJU9V2lVFOOHZkIIyVLgDX55NSNoo3ZYsYa880Ju3Om2Z7ksNexhY46RtYusiGpDjgXKfDiuQ9LTkvQ+u7C6As2zOktwg9y9nafZ568dpuPHTa8rj/Pylp/pK2NJ3By7esAEExonzcJGM8d7a7swSnxsnjrZ8r5uzgZ2qGY8ePcuFIzQheZ4OVPRknLYzZ34Ph+xn4JS6jJHZIEpIvDg5Bsp515t8eJt7ogfxhyIdA2GqElypwAbJHUOM5yKm1ERHBvTrffDFuGD0+qJcu20FtA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1584723A4D4FBB41B929C5765478E42A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0142efe-8d50-42f8-290b-08d6754ee67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 09:51:45.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5383
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIENocmlzdG9waCwNCg0KT24gU2F0LCAyMDE5LTAxLTA1IGF0IDA5OjAxICswMTAwLCBDaHJp
c3RvcGggSGVsbHdpZyB3cm90ZToNCj4gSGkgVGhvbWFzLA0KPiANCj4gdm13Z2Z4IGhhcyBiZWVu
IGRvaW5nIHNvbWUgb2RkIGNoZWNrcyBiYXNlZCBvbiBETUEgb3BzIHdoaWNoIHJlbHkNCj4gb24g
ZGVlcCBETUEgbWFwcGluZyBsYXllciBpbnRlcm5hbHMsIGFuZCBJIHRoaW5rIHRoZSBjaGFuZ2Vz
IGluDQo+IExpbnV4IDQuMjEgZmluYWxseSBicm9rZSBtb3N0IG9mIHRoZXNlIGltcGxpY2l0IGFz
c3VtcHRpb25zLg0KDQpUaGFua3MuIA0KV2hhdCB3ZSdyZSByZWFsbHkgdHJ5aW5nIHRvIGRvIGhl
cmUgaXMgdG8gdHJ5IHRvIGRldGVjdCB0aGUgc2l0dWF0aW9uDQp3aGVyZSBETUEgcmVtYXBwaW5n
IHVzaW5nIGhhcmR3YXJlIElPTU1VcyBpcyBnb2luZyBvbiBidXQgbWVtb3J5IGlzDQpzdGlsbCBj
b2hlcmVudCwgc2luY2UgdGhlIGRyaXZlciBjYW4gY3VycmVudGx5IG9ubHkgd29yayB3aXRoIGNv
aGVyZW50DQptZW1vcnlbMV0uIEN1cnJlbnRseSB3ZSB1c2UgaW50ZWxfaW9tbXVfZW5hYmxlZCB0
byBkZXRlY3QgdGhpcw0Kc2l0dWF0aW9uLCBidXQgaXQgd291bGQgYmUgcmVhbGx5IGhlbHBmdWwg
aWYgdGhlcmUgd2VyZSBhIGdlbmVyaWMgYm9vbA0KdGhhdCBhZHZlcnRpemVzIHRoaXMgc2l0dWF0
aW9uIHNpbmNlIHdlIG5lZWQgdG8gZGVhbCB3aXRoIG90aGVyIElPTU1Vcw0KYXMgd2VsbCBnb2lu
ZyBmb3J3YXJkLiBBbnkgc3VnZ2VzdGlvbj8NCg0KQ29tbWVudHMgb24gdGhlIHBhdGNoZXMgc2Vw
YXJhdGVseS4NCg0KVGhhbmtzLA0KVGhvbWFzDQoNCg0KDQoNCj4gDQo+IFRoZSByZWFsIGZpeCBp
cyBpbiBwYXRjaCAzLCBidXQgSSB0aGluayB0aGUgb3RoZXJzIGFyZSBpbXBvcnRhbnQNCj4gdG8g
bWFrZSBpdCBjbGVhciB3aGF0IGlzIGFjdHVhbGx5IGdvaW5nIG9uLg0K
