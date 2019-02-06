Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AC7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBC6217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yh92W0jz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfBFT4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:56:41 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5501 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFT4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:56:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5b3be80000>; Wed, 06 Feb 2019 11:56:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 11:56:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Feb 2019 11:56:37 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 19:56:37 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 19:56:37 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2983.namprd12.prod.outlook.com (20.178.53.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 19:56:35 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 19:56:35 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V11 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V11 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvTDCDPnIVpzHqk6xXRbmupPKeqXRQyqAgAGZ9oCAAACmAIAALSQAgAAbuUA=
Date:   Wed, 6 Feb 2019 19:56:34 +0000
Message-ID: <BYAPR12MB33987640AE0D0C76ADB42BF1C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
 <1549356985-25726-3-git-send-email-skomatineni@nvidia.com>
 <a9e264e2-87c9-e263-808a-b561e8ed4073@gmail.com> <20190206145343.GA3651@ulmo>
 <5e66803c-b13b-cb00-e2ff-d096a1650612@gmail.com>
 <37987664-d354-4f89-cc60-9cc37ca87322@gmail.com>
In-Reply-To: <37987664-d354-4f89-cc60-9cc37ca87322@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2983;6:aFoDBfc70KG4UghkdjFNS1Dv3oZmWKojI/SmAiUNMV1tlV/zx0myZuq8DCNZroOJmVYqB67pPxLKOrDfi3NxehQeHivS2sAz8TqZzcyacjmQ6y0thi+xlE6MeDmXmpLQ7FJTQV9go45eMa9dPW2Xv54rFPPzjIoW9kvcfq+7CkXAuj8pw44JIRaqzAIrHl0gSpyIqv1E+dA+MDgk/rHWc1YUBvYpp3nYbOBSL08lqmhcu+T4Os0L17+wS/X0kqYxoitElFzwMOh7+f2O7M3exgBEyncMgsDI5hZuCcISexk+ANlXOuFoN2zfwgo14HXIAGssQJh/LNc96yAO1JMf/++7Pt6KiqZy8HL6O9tdsQpu9hz80EJlnJGEJjRzvrQtWS3+nUyqcMjDaOfgDWScmRR33DHtUQFtYXQQPGxPu3sEqwgm+QZ4A0WF4VCUI+ZWYHQ3uidI9cO+fD6bxa+uFA==;5:sPnjWw3kYlDtgpzmKTmvmyScW9DFjvAG659tqjhcpJr9xuPfk6K5YNljWISJeX/VgHL4UUmx8oV5bkp811PDT4og3ZN5T5zwA0o71gpWiZE+3k6pzvfaY16xg/4bY8O9sH+iTpRXPVBDZvl3xp0BdS0RfynchMzi0jfTazpnRPc16+ii5XVVh0GdYXqvIizyRD15b5/vUkuRocivWMEVeg==;7:ErjCJlB/zP+5FQX5haNFfzSU06gt7/EQxZRppyuxMH4Z2Hg3Kgbu83X6+iKArT1jmBg5RUgNfv2TH3tKZ/xvcW/kuMICD2Ut4KOvpY3BT64qJb7l9b57Wdk1FMXzfPkYwAW8OifRYf4sJSYiVeo2Fg==
x-ms-office365-filtering-correlation-id: a4b942de-a035-47c0-effa-08d68c6d32c6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2983;
x-ms-traffictypediagnostic: BYAPR12MB2983:
x-microsoft-antispam-prvs: <BYAPR12MB2983A6810A2DC2832F874EFEC26F0@BYAPR12MB2983.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(105586002)(81156014)(486006)(229853002)(106356001)(33656002)(81166006)(8676002)(66066001)(97736004)(11346002)(476003)(446003)(71190400001)(102836004)(55016002)(186003)(9686003)(71200400001)(14454004)(6436002)(6506007)(8936002)(7696005)(68736007)(93886005)(7736002)(4326008)(53936002)(316002)(76176011)(74316002)(25786009)(99286004)(86362001)(26005)(5024004)(14444005)(256004)(6246003)(6116002)(3846002)(305945005)(2906002)(478600001)(54906003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2983;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nx+qo9Qypy5zl1Ss9DkkJmMncbhXKsludQWH/Yw1I+kDTCNLbptE0MlIT9TO/6LQA+YdY3/Pbhn8ObtvYPsnO/3ivc/QWMkqqbvckQSm3yUOOfJnGd7FTHdLnHTZBX+OFFdR8MDyXSk85oZd/dfsY+6BgArPw2WrupCoh7q7x27KjQ7t5jwoYrHg3qrhlH0Fnz040TJBdNGiqgUs6bUDVbaZsn6eK6RkJBzOFDmu+af0UnwbYnRONRTLwTHuwPANhHY4OB9Hw+8gv/cwduvPqr3Yn67YEkoSGEzlDLKr7l4izATM2uk07WqdK6vHxVsHtnAnCylkr+aP6IR9kwZt3Vuqo9kphm1RJVJwq2do6A9QYtT4Tb3nlDOI9RHeAcjRo6tmmcUvZ9H3ZzwXHW9sOul1lQOOEBSlbBf8rSeTIr8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b942de-a035-47c0-effa-08d68c6d32c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 19:56:34.8854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2983
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549482984; bh=eIMZkO5P7L8emuBKRT95/ScIRMyZkHDAqzlXEVOM6bA=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=Yh92W0jz0xfxzgmrcJ88QHxsfZ/wpTVIIUtET1qRjjhw7uw/Cv2tIU8Rb1vOBjwYA
         8pYPFyFJznOcMM0iwkPTX852vCAafLODS2D2wDerAfVJ/M6FtkooUlQUtvghiz/Tff
         SZt5Vzd6xoRuL/mbT2CaCrSkYoRqr10+HOx0XFGGk9nGsPzj4zzjdfSejiYBIKq6xe
         RZTHrN+JhQ/JmvTokopjaxovkt3wwQQECRB1XG8H7wyHipDTeCpAmVzgJ0vHO1WbpA
         ai+qGRXJkjaDzbcmkAesUOUMPSBHEeumhi2cd3BFteDBMFZPtdbsBVtnhty9uHWNol
         f5kAkqdXahtiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+PiBPaCwgYW5vdGhlciBpbXBvcnRhbnQgbW9tZW50IGlzIHRoYXQgcGh5c2ljYWxseSBj
b250aWd1b3VzIGRtYV9idWYgDQo+ID4+PiBhbGxvY2F0aW9uIGlzbid0IGd1YXJhbnRlZWQgYnkg
dGhlIERNQSBBUEkuIFRoaXMgbWF5IGJlY29tZSBhIA0KPiA+Pj4gcHJvYmxlbSBmb3IgVDE4Nisg
dGhhdCBjYW4gdHJhbnNmZXIgdXAgdG8gNjRLLiBXZSBuZWVkIHRvIGVuZm9yY2UgDQo+ID4+PiB0
aGUgY29udGlndW91cy1hbGxvY2F0aW9uIHJlcXVpcmVtZW50IGJ5IHVzaW5nDQo+ID4+PiBkbWFf
YWxsb2NfYXR0cnMoRE1BX0FUVFJfRk9SQ0VfQ09OVElHVU9VUykgaW5zdGVhZCBvZiB0aGUgDQo+
ID4+PiBkbWFfYWxsb2NfY29oZXJlbnQoKSwgcGxlYXNlIHNlZSBteSBvdGhlciBjb21tZW50IGJl
bG93Lg0KPiA+Pg0KPiA+PiBBY3R1YWxseSBJIGRvbid0IHRoaW5rIHRoYXQncyBuZWNlc3Nhcnkg
aGVyZS4gDQo+ID4+IERNQV9BVFRSX0ZPUkNFX0NPTlRJR1VPVVMgb25seSBzZWVtcyByZWxldmFu
dCBpZiB5b3UndmUgZ290IGFuIElPTU1VIA0KPiA+PiBhdHRhY2hlZCB0byB0aGUgZGV2aWNlIHRv
IG1ha2Ugc3VyZSB0aGUgcGh5c2ljYWwgbWVtb3J5IGlzIGFsc28gY29udGlndW91cy4NCj4gPj4N
Cj4gPj4gU2VlIHRoaXMgZXh0cmFjdCBmcm9tIERvY3VtZW50YXRpb24vRE1BLWF0dHJpYnV0ZXMu
dHh0Og0KPiA+Pg0KPiA+PiB8IERNQV9BVFRSX0ZPUkNFX0NPTlRJR1VPVVMNCj4gPj4gfCAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+IHwgDQo+ID4+IHwgQnkgZGVmYXVsdCBETUEtbWFw
cGluZyBzdWJzeXN0ZW0gaXMgYWxsb3dlZCB0byBhc3NlbWJsZSB0aGUgYnVmZmVyIA0KPiA+PiB8
IGFsbG9jYXRlZCBieSBkbWFfYWxsb2NfYXR0cnMoKSBmdW5jdGlvbiBmcm9tIGluZGl2aWR1YWwg
cGFnZXMgaWYgaXQgDQo+ID4+IHwgY2FuIGJlIG1hcHBlZCBhcyBjb250aWd1b3VzIGNodW5rIGlu
dG8gZGV2aWNlIGRtYSBhZGRyZXNzIHNwYWNlLiBCeSANCj4gPj4gfCBzcGVjaWZ5aW5nIHRoaXMg
YXR0cmlidXRlIHRoZSBhbGxvY2F0ZWQgYnVmZmVyIGlzIGZvcmNlZCB0byBiZSANCj4gPj4gfCBj
b250aWd1b3VzIGFsc28gaW4gcGh5c2ljYWwgbWVtb3J5Lg0KPiA+Pg0KPiA+PiBXZSBkb24ndCBo
YXZlIGFuIElPTU1VIGF0dGFjaGVkIHRvIEkyQyBvciBBUEJETUEsIHNvIHRoaXMgY2FuJ3QgDQo+
ID4+IGhhcHBlbiBhbmQgZXZlbiBpZiB3ZSBoYWQgYW4gSU9NTVUgYXR0YWNoZWQsIGFsbCB3ZSBj
YXJlIGFib3V0IGlzIHRoZSANCj4gPj4gZGV2aWNlJ3MgRE1BIGFkZHJlc3Mgc3BhY2UsIHdoaWNo
IG1lYW5zIElPVkEgc3BhY2UsIGFuZCB0aGF0IHdvdWxkIA0KPiA+PiBzdGlsbCBiZSBndWFyYW50
ZWVkIHRvIGJlIGNvbnRpZ3VvdXMsIGFjY29yZGluZyB0byB0aGUgYWJvdmUuDQo+ID4gDQo+ID4g
WWVzLCBidXQgZG9lc24ndCBUMTg2KyBoYXZlIElPTU1VIHN1cHBvcnQgZm9yIHRoZSBETUEgY29u
dHJvbGxlcj8NCj4gPiANCj4NCj4gQWgsIHNvcnJ5IEkgcHJvYmFibHkgc2tpbW1lZCB3YXkgdG9v
IHF1aWNrbHkgdGhvcm91Z2ggdGhlIG1lc3NhZ2UuIEhtbS4uIHdlbGwsIHNlZW1zIEkgd2FzIHdy
b25nLg0KPg0KPiBTb3dqYW55YSwgYWZ0ZXIgYWxsIGxvb2tzIGxpa2UgaXQgc2hvdWxkIGJlIGZp
bmUgdG8gdXNlIHRoZSBkZWZhdWx0IGRtYV9hbGxvY19jb2hlcmVudCgpIGhlbHBlci4gUGxlYXNl
IHB1dCBpdCBiYWNrIGluIHYxNC4NCg0KTGF0ZXN0IFYxNCB1c2VzIGRtYV9hbGxvY19jb2hlcmVu
dCBhbG9uZyB3aXRoIGJlbG93IGZpeGVzLg0KLSBGaXhlZCBmaWZvIHRyaWcgbGV2ZWwgdG8gZG8g
cmVnaXN0ZXIgd3JpdGUgd2l0aCBjb25zdHJ1Y3RlZCB2YWx1ZSBmcm9tIHNjcmF0Y2ggYXMgZmx1
c2ggaXMgZG9uZSBwcmlvciB0byB0aGF0IGFuZCBubyBvdGhlciBiaXRzIG90aGVyIHRoYW4gdHJp
ZyBsZXZlbC4gU28gd3JpdGluZyB2YWx1ZSBkaXJlY3QgaXMgc2ltcGxlcg0KLSBGaXhlZCB0byBh
Y2NvdW50IERWQyBvZmZzZXQgZm9yIEZJRk8gcmVnaXN0ZXIgZHVyaW5nIGRtYSBzbGF2ZSBjb25m
aWcgc291cmNlIGFuZCBkZXN0aW5hdGlvbiBhZGRyZXNzZXMNCi0gQWxzbyBpbiA1dGggcGF0Y2gg
aW4gc2VyaWVzLCB1cGRhdGVkIHRvIHVzZSBpbnRlcmZhY2UgdGltaW5nIGZsYWcgaW4gaHcgZmVh
dHVyZSBhcyB0ZWdyYTExNCBhbmQgcHJpb3IgZG9lc27igJl0IHN1cHBvcnQgaW50ZXJmYWNlIHRp
bWluZyByZWdpc3RlciBzbyBhbGxvd2luZyBwcm9ncmFtbWluZyBvZiB0aW1pbmcgcmVnaXN0ZXIg
b25seSBmb3IgbGF0ZXIgdGVncmEgY2hpcHMuIFRlZ3JhMTE0IGFuZCBwcmlvciB1c2VzIGZpeGVk
IFRMT1cgYW5kIFRISUdIIHdoaWNoIGFyZSBwYXJ0IG9mIGh3IGZlYXR1cmUgYWxyZWFkeS4NCg0K
SG9wZWZ1bGx5IGFsbCBmaXhlcyBhcmUgaW4uIFRlc3RlZCBieSBmb3JjaW5nIERNQSBvbmx5IGFu
ZCBQSU8gT25seSBhbmQgYWxzbyBETUEvUElPIGJhY2stdG8tYmFjay4NCg0Kc293amFueWENCg==
