Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0502BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A087D2238D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="5DjVunfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A087D2238D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeHIUo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:44:27 -0400
Received: from mail-eopbgr680064.outbound.protection.outlook.com ([40.107.68.64]:15104
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbeHIUo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGYU4uD+9/w97aqPxenQ/R2dE/ny4VdbNsIhibafCM0=;
 b=5DjVunfQBOYottE/f9tOMBJBrEl1Kzah+2o5GjxlEgvTgY51H14lDyPq8Oh/U5d5nLiHW3XxyYE+L93AxZ5r4C6q/+ZHmidL/kIP4A+xqDXpeIrA5YBysVw2v0ulTzOjVO6O6f0krCaZm+f/G3DuAtdifU0e/1Zx2jAUZjZckfs=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2772.namprd12.prod.outlook.com (20.176.178.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Thu, 9 Aug 2018 18:18:15 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::51e6:2f16:498f:8d96%4]) with mapi id 15.20.1017.020; Thu, 9 Aug 2018
 18:18:15 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 1/2] x86/MCE/AMD: Check for NULL banks in THR interrupt
 handler
Thread-Topic: [PATCH 1/2] x86/MCE/AMD: Check for NULL banks in THR interrupt
 handler
Thread-Index: AQHUL+qS6VdgoYLWuEWHUWlxV25aZqS3mKIAgAAh5ZA=
Date:   Thu, 9 Aug 2018 18:18:15 +0000
Message-ID: <BN7PR12MB259365671F2A73D5FF33C134F8250@BN7PR12MB2593.namprd12.prod.outlook.com>
References: <20180809140834.59264-1-Yazen.Ghannam@amd.com>
 <20180809161548.GA20928@nazgul.tnic>
In-Reply-To: <20180809161548.GA20928@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:1df9:74bd:2f19:7509]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2772;20:RiatfxbpJgNBsZQgQxItGkQCfoeiw+PFBNfiYJugagB9Ze2ax28dMAgxa7p56+bgZVUMFRXZZpw9KtHiByC3cP/nWdPH4N/LodWgaNjRkcThrJvKchwJ7Uz9W1DU+xshl5PJe+dy3StW0jgJMVsMttv2bKAZjtq8jQLiPnZPmDjRMQYJ2tPhSIZedrm6uBzHSSoXkxlzLlruBQYr1KEKsXvLnJT6ulXcPKOewUak7Jb6pwT+SI+XyCCxQsCaHLMW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eec87e37-ca7c-435e-9286-08d5fe2479ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2772;
x-ms-traffictypediagnostic: BN7PR12MB2772:
x-microsoft-antispam-prvs: <BN7PR12MB2772F0CD714CC349D6FB8946F8250@BN7PR12MB2772.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN7PR12MB2772;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2772;
x-forefront-prvs: 0759F7A50A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(366004)(13464003)(189003)(199004)(68736007)(15650500001)(8936002)(6116002)(97736004)(2900100001)(5250100002)(7696005)(81166006)(8676002)(11346002)(446003)(81156014)(486006)(476003)(256004)(6506007)(53936002)(102836004)(53546011)(46003)(186003)(54906003)(316002)(6916009)(76176011)(2906002)(4326008)(99286004)(5660300001)(74316002)(229853002)(305945005)(33656002)(86362001)(55016002)(7736002)(9686003)(6436002)(25786009)(6246003)(14454004)(72206003)(106356001)(105586002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2772;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BlVj5VTEv9IkpnDWrZPI/QgPcviZTeJArfII43Mzr4q1RkfrvVEvoRp/kfZRG5x5AR+u8O8IzdB8NIOLNQ63HlWWhpDHQHj8YjEfamvqLtTyiYVqGFODS+yh1aJeB2G1QTpVvH/EqU16ZO8Q2H9QYPNfCR/bI2XbVHE5m7oxAUavMzaUvde9E8e8wO3DrPQDywJRjOTmtUJ2wfLCsfkepAYC2I1l9iVdG2iojv+UNDuikeE6lgjJfrnGoLDenFAchPJiAPdIhczmmC9w1wt2v0xGxjvtc/jdIUY1hr4FoxhWQzXZ6K1m/UNJaEZ/AbekP5L3Jc9RQyYBfFbqhQwP9mHEfNvQpyZimoYow5Qrt0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec87e37-ca7c-435e-9286-08d5fe2479ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2018 18:18:15.4503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCA5LCAyMDE4IDExOjE2IEFNDQo+
IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzogbGludXgt
ZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHRv
bnkubHVja0BpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8yXSB4ODYvTUNFL0FNRDogQ2hlY2sgZm9yIE5VTEwgYmFua3MgaW4gVEhSDQo+IGludGVycnVw
dCBoYW5kbGVyDQo+IA0KPiBPbiBUaHUsIEF1ZyAwOSwgMjAxOCBhdCAwOTowODozM0FNIC0wNTAw
LCBZYXplbiBHaGFubmFtIHdyb3RlOg0KPiA+IEZyb206IFlhemVuIEdoYW5uYW0gPHlhemVuLmdo
YW5uYW1AYW1kLmNvbT4NCj4gPg0KPiA+IElmIHRocmVzaG9sZF9pbml0X2RldmljZSgpIGZhaWxz
IHRoZW4gcGVyX2NwdSh0aHJlc2hvbGRfYmFua3MpIHdpbGwgYmUNCj4gPiBkZWFsbG9jYXRlZC4g
VGhlIHRocmVzaG9sZGluZyBpbnRlcnJ1cHQgaGFuZGxlciB3aWxsIHN0aWxsIGJlIGFjdGl2ZSwg
c28NCj4gDQo+IFNvIGZpeCB0aGUgY29kZSBzbyB0aGF0ICp0aGF0KiBkb2Vzbid0IGhhcHBlbiBp
bnN0ZWFkIG9mIGFkZGluZyBjaGVja3MNCj4gdG8gdGhlIGludGVycnVwdCBoYW5kbGVyLg0KPiAN
Cj4gSS5lLiwNCj4gDQo+IAlpZiAoZXJyKSB7DQo+IAkJbWNlX3RocmVzaG9sZF92ZWN0b3IgPSBk
ZWZhdWx0X3RocmVzaG9sZF9pbnRlcnJ1cHQ7DQo+IAkJcmV0dXJuIGVycjsNCj4gCX0NCj4gDQoN
Ck9rYXkuIEknbGwgbWFrZSB0aGF0IGNoYW5nZS4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
