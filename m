Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F89220675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pN3i+vYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393666AbfAPOfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:35:54 -0500
Received: from mail-eopbgr720065.outbound.protection.outlook.com ([40.107.72.65]:27025
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387533AbfAPOfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e837Q09fqJ2WF2xBa71eJR9LbxKi+UtOhYBKR+L4aLw=;
 b=pN3i+vYl/WdV7OnBNkZ4hDa2YqvIuXGtjzN2Qhuf2X19n3NKZXW/wOIx39YEXgnVzLbSAi24btNI7C6eGhPwJLN/WfLx8b2Xq9p3wHm/eUUXm9uyDyO4G3zB4JmDegN184zj0C/7++EYUDb53xSOGfLe5ayDHE1XS2qPY/YkPlM=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3483.namprd12.prod.outlook.com (20.178.199.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 16 Jan 2019 14:35:51 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1516.019; Wed, 16 Jan 2019
 14:35:51 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Mark translation invalid during device detach
Thread-Topic: [PATCH] iommu/amd: Mark translation invalid during device detach
Thread-Index: AQHUrVIS1FBDwqbIBkqoC3zkhHCLEaWx3SEAgAAZv4A=
Date:   Wed, 16 Jan 2019 14:35:51 +0000
Message-ID: <d6b75082-892a-9121-be83-e528633400fa@amd.com>
References: <20190116041432.3484-1-Suravee.Suthikulpanit@amd.com>
 <20190116130334.svrjkyr3dnfcj3u6@8bytes.org>
In-Reply-To: <20190116130334.svrjkyr3dnfcj3u6@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
x-originating-ip: [110.169.70.41]
x-clientproxiedby: SG2PR06CA0135.apcprd06.prod.outlook.com
 (2603:1096:1:1f::13) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3483;20:mhGmTLiBJCkMv0CVkdLU+xAB0XeodcGrMVdzQaogH4e8QqXxrM/Dmtz1L6LiCoQnT0WJki5HobdMa/FLh0YKPYw9NS/XZG++nNzHeF6lmXwsh/vqHnkFMj9MXswTBzC/TsvNbRTkb3MgdWFDX4knYePYjtmB49VzsKI29y87BtxT8yb3cAbiH41+pItD6U4g4yVBgJaQye1AV02fHSadSOzsUg1Rdv5UKCdYN32tqymHzn6i3hRZZV1hw45YWhbn
x-ms-office365-filtering-correlation-id: 866affe8-e107-46ba-18be-08d67bbfe9c8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3483;
x-ms-traffictypediagnostic: DM6PR12MB3483:
x-microsoft-antispam-prvs: <DM6PR12MB3483E4BB328E1119411B4B91F3820@DM6PR12MB3483.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(39860400002)(346002)(199004)(189003)(36756003)(97736004)(71190400001)(99286004)(2351001)(105586002)(58126008)(54906003)(106356001)(65956001)(65806001)(66066001)(71200400001)(53936002)(14454004)(4744005)(6246003)(8936002)(8676002)(5660300001)(31696002)(72206003)(65826007)(305945005)(86362001)(478600001)(256004)(6512007)(5024004)(14444005)(25786009)(81166006)(1730700003)(4326008)(81156014)(7736002)(76176011)(31686004)(102836004)(486006)(229853002)(53546011)(6506007)(386003)(2616005)(476003)(186003)(64126003)(26005)(6916009)(52116002)(5640700003)(68736007)(316002)(6436002)(3846002)(6116002)(2906002)(6486002)(2501003)(11346002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3483;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wLl6VTmjzxYXghy+KEnAy/ENJK3HFfO99l0msj3Zb6sOfJ788yjWqmlob5vi4HrVPSg3+Guqv2ERL0AY0P4LulRdUPBmpMTTqg8PeeHd4+ghXqxWkbGCBpoDCLzptzI421WahoCaSxFynjB2hrBZOC3xHGRxRW1b7S2aRMiLbyy2Z0gkqrsM2z6ew9GNWJom+xuvMRxu7GJI51tQeUMTEI/+5jYQD0Grd2inpxRPVfuPTVfRArujLM5mJFE39zvJXXzMrQqcnNcT2KV/W/G9AJOD8R9NrIVMyD0gf9y+1VJXXJBCMKTo32vbDNlA6JrR+kVNQIUbxcdaxN4yy3S4vjQh4qs7qHiCqcxDAuiQZOqgQsWd7dKba1zh4XPNq424m/CkkU4IN36wnsp1L3ReC5vWu6XSQqOULmcjZRu0nZg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C37A640A4C600F41BB35FC965BA032DA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866affe8-e107-46ba-18be-08d67bbfe9c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 14:35:49.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lcmcsDQoNCk9uIDEvMTYvMTkgODowMyBQTSwgam9yb0A4Ynl0ZXMub3JnIHdyb3RlOg0KPiBI
aSBTdXJhdmVlLA0KPiANCj4gT24gV2VkLCBKYW4gMTYsIDIwMTkgYXQgMDQ6MTU6MTBBTSArMDAw
MCwgU3V0aGlrdWxwYW5pdCwgU3VyYXZlZSB3cm90ZToNCj4+IEZyb206IFN1cmF2ZWUgU3V0aGlr
dWxwYW5pdCA8c3VyYXZlZS5zdXRoaWt1bHBhbml0QGFtZC5jb20+DQo+Pg0KPj4gV2hlbiBhIGRl
dmljZSBzd2l0Y2hlcyBkb21haW4sIElPTU1VIGRyaXZlciBkZXRhY2ggZGV2aWNlIGZyb20gdGhl
IG9sZA0KPj4gZG9tYWluLCBhbmQgYXR0YWNoIGRldmljZSB0byB0aGUgbmV3IGRvbWFpbi4gRHVy
aW5nIHRoaXMgcGVyaW9kDQo+PiB0aGUgaG9zdCB0YWJsZSByb290IHBvaW50ZXIgaXMgbm90IHNl
dCwgd2hpY2ggbWVhbnMgRE1BIHRyYW5zbGF0aW9uDQo+PiBzaG91bGQgYmUgbWFya2VkIGFzIGlu
dmFsaWQgKGNsZWFyIFRWIGJpdCkuDQo+Pg0KPj4gU28sIGNsZWFyIHRoZSBUViBiaXQgd2hlbiBk
ZXRhY2ggdGhlIGRldmljZS4gVGhlIFRWIGJpdCB3aWxsIGJlIHNldA0KPj4gYWdhaW4gd2hlbiBh
dHRhY2hpbmcgZGV2aWNlIHRvIHRoZSBuZXcgZG9tYWluLg0KPiANCj4gSXMgdGhlcmUgYSBzcGVj
aWZpYyBwcm9ibGVtIHdpdGggc2V0dGluZyB0aGUgVFYgYml0Pw0KDQpXZSBhcmUgbm90IGN1cnJl
bnRseSBzZWVpbmcgaXNzdWUuDQoNCj4gTm90ZSB0aGF0IHRoZSB1cGRhdGUgd2lsbCBjbGVhciBh
bGwgb3RoZXIgZmllbGRzIGluIHRoZSBmaXJzdCAxMjggYml0cw0KPiBvZiB0aGUgRFRFLCB3aGlj
aCBtZWFucyB0aGF0IElSLCBJVyBhbmQgTW9kZSBhcmUgYWxsIHNldCB0byAwLiBUaGlzDQo+IGVm
ZmVjdGl2bHkgYmxvY2tzIGFsbCBETUEgcmVxdWVzdHMgZnJvbSB0aGUgZGV2aWNlLCB3aGljaCBp
cyBieSBkZXNpZ24uDQoNCkFoaC4uIFRoaXMgbWFrZXMgc2Vuc2Ugbm93LiBJIG1pc3NlZCB0aGUg
SVIvSVcvTW9kZT0wIHBhcnQuDQpJdCB3YXMgbm90IGNsZWFyIHRvIHVzIGVhcmxpZXIuIFRoYW5r
cyBmb3IgY2xhcmlmaWNhdGlvbi4NCg0KUmVnYXJkcywNClN1cmF2ZWUNCg==
