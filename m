Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D60C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1E20820
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 04:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nbq9QAUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfA3EWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 23:22:21 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:63856 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfA3EWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 23:22:20 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5126780000>; Wed, 30 Jan 2019 12:22:16 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 20:22:15 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 29 Jan 2019 20:22:15 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 30 Jan
 2019 04:22:14 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.52) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 30 Jan 2019 04:22:14 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3127.namprd12.prod.outlook.com (20.178.54.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Wed, 30 Jan 2019 04:22:10 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Wed, 30 Jan 2019
 04:22:10 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V5 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuCjcFQq4Ugnr9EajTUu9v/+Er6XHCbsAgAACEcCAABenIIAAEeJA
Date:   Wed, 30 Jan 2019 04:22:10 +0000
Message-ID: <BYAPR12MB3398502D8F00D4F7BFF25D27C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548803771-13424-1-git-send-email-skomatineni@nvidia.com>
        <1548803771-13424-3-git-send-email-skomatineni@nvidia.com>
 <20190130044214.65991195@dimatab>
 <BYAPR12MB339850895826781B4E6AF028C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB339812A2E876B76E95828EA1C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB339812A2E876B76E95828EA1C2900@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3127;6:GzxhGurT+fZtockNM+CvPWRrC1A1bnz7TeO4XBXNKzroDOW5Dl53+BVk8MGoWQL3MfNGujomVap57UgyRsjfor0C+xXUZCTcS38e0nVA0dOMSouAMzk7CJzFI5jWITR0THx7Y1d4icnVopgNIyp8e++KNNC5b2auVxtWLMmEYbJYQHuxb5oSFF7LVn9SzPwh2Q/7QeiLIvsg8OdR2G/DQ97lrfINirHh6PGoG6bhfv1YfyNDxyLDyVKTYFju1UTOLUs3gX8reJpPS5U3A7eXTnyT0QQyQ9sf+2eeh7lO5hgwjS+mQ326zLUc/iSmoKc6maTRZkWLUNRmHiC5lTGVkzTGBV1aLhrMcKr9OoMo7ig12xaIsBrJhjgQXlF0o4QIYNMmvsqHNcWXGIntLCsnUDmXCSlrDgoHKqaBULQv1cqvoRx0om1BtdHeY67Hwkp4RAxLSfED+vLgzGVYWeY+bw==;5:LglH/mXKvflJCmhYSw2iQY5rdaQDD2wZjHCCkwAgU8knoxRK7zvjBXzdfVysNGct/xs3BBhPFdyMVq4ixSlvSYFGXjDCwTc5qBTbuXYCZmGgpdqDUzEbVl/it9Q13l881YxKnjhV8zQnrh1Hf0qM6hCXNmLZxXGUSaWT3BT1hsOjlWe4GpoXUUk24hsdkcRs7x+XgobAsRqigAHneprZFg==;7:NW5TbTPdkvJqqq2m5/29uOtiHevwun4zyP+ooI3UTEffb8E01aUi5gzoc0QCmxAboPgiCfM5IHMzN9MvzFrtBJtH0j5jCEDlJMMoy9Depq4S1f9SIpgCDLunKKhvH6xxV33p0RxUttkkqsUng1oWAA==
x-ms-office365-filtering-correlation-id: 445c40b8-e581-4552-5677-08d6866a8109
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3127;
x-ms-traffictypediagnostic: BYAPR12MB3127:
x-microsoft-antispam-prvs: <BYAPR12MB312752F1674962E3416ECDABC2900@BYAPR12MB3127.namprd12.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(25584004)(199004)(189003)(26005)(97736004)(71190400001)(102836004)(4326008)(6506007)(8936002)(229853002)(71200400001)(8676002)(478600001)(81166006)(81156014)(1411001)(2940100002)(6246003)(6436002)(25786009)(66066001)(99286004)(3846002)(305945005)(966005)(7736002)(6116002)(93156006)(7696005)(53936002)(74316002)(6306002)(68736007)(33656002)(55016002)(256004)(76176011)(86362001)(14444005)(446003)(11346002)(316002)(106356001)(105586002)(54906003)(9686003)(39060400002)(186003)(486006)(93886005)(6916009)(14454004)(2906002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3127;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rQ7YaH+jbuu7I4flyP7vzxZbd1uay/n6536EFoiumU9HcEw8tcM9EPTtFsMxYWhCLz1W9Qd+SsQLvZiS7tbLbt3laQP4YJoBef4s7IFnAlUOCiURabuASYpuMKYSbw9N2empMW+6GpbeM/QFpb0FAZ7ZYeltn5C3F4ipXjlrP0yylMDOfGUkwj9DotlTwyOLei6HrBze3zg8Boggq7mShQoM1pOLRLD3k5PbpRVvtokHvPOcFTD+YXXDvrcZYAmWzOTzb9/v2mVtpYa9uaLH3Sxo65OyDhFF5V2bRWubgkV+q/YbrK1+jMhcoxnJHnOmugwbJv4MjkIxw23H+NMB+FqUiaC0HWCNfE1R6ktroAigKxViU5+VkHXSk6diK5NgrI9qSxbWDe6GtBBp0ISuN19xb6y8bfXdWCFs+39MGuU=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 445c40b8-e581-4552-5677-08d6866a8109
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 04:22:10.7070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548822136; bh=5CU3z6Q4OP8TfynzFWFXdu+wI50Ks2RIMONxzkP/z6w=;
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
        b=nbq9QAUJq1tDFBd41pjCaTAICZRR5mtR2YaEgDxFAu3FrZL1U5duwasnOhDBX75iU
         /tn/jz8hHrEw4kgikpPP4Lh0DAk+uOMxMs86dcZTh79uMGl8t4PbmPjSKHojvR/cr8
         7KXiNLH4sCPybxico3It2QEOVVVksr1yHhCe+dEJR5PgR/wABPZP8IC+uuGc+Gfc3/
         7KuPrM8r3HNJ+9BoiR3RKrO0YhhTL9zKYWDboJLeMSBgSuEUzDcIBgND8qiU3uujVD
         qCULkY0HpZg7buIUrZ2+Ig8G5Etw2D6nrQGLI/xuHxPA0jVTS1AOrmtKMlhzQz/7Cm
         vUkX28ESm+6vA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0NvcnJlY3Rpb25dDQoNCj4gPiBDb3VsZCB5b3UgcGxlYXNlIHRlbGwgd2hldGhlciB5b3UgbWlz
c2VkIG15IGNvbW1lbnRzIHRvIFYzIFswXSBvciBjaG9zZSB0byBpZ25vcmUgdGhlbT8gSWYgdGhl
IGZvcm1lciwgdGhlbiBJJ2Qgd2FudCB0byBnZXQgYW5zd2VycyB0byB0aG9zZSBxdWVzdGlvbnMg
YW5kIGNvbW1lbnRzLiBJJ2xsIHN0b3AgaGVyZSBmb3Igbm93Lg0KPiA+IA0KPiA+IFswXSBodHRw
czovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzEwMzEzNzkvDQo+DQo+IFNvbWVob3cgbWlz
c2VkIHRob3NlIGZyb20gbXVsdGlwbGUgY29tbWVudHMuIFdpbGwgZ28gdGhydSBhbmQgcmVzcG9u
ZCBiYWNrLg0KDQpWNiBpbmNsdWRlcyBmZWVkYmFjayBjaGFuZ2VzLiBXYW50IHRvIGNsYXJpZnkg
b24gZmV3IGZlZWRiYWNrIHBvaW50cw0KDQotIEFMSUdOIGlzIHVzZWQgZm9yIDQgYnl0ZSBib3Vu
ZGFyeSB0byB1c2Ugd2l0aCBETUEgYnV0IGV4dHJhIGJ5dGVzIGRvZXNu4oCZdCBnZXQgdHJhbnNm
ZXJyZWQgb3ZlciBJMkMgYXMgSTJDIGNvbnRyb2xsZXIgdHJhbnNmZXIgYnl0ZXMgYmFzZWQgb24g
c2l6ZSBzcGVjaWZpZWQgaW4gdGhlIHBhY2tldCBoZWFkZXIuDQogIERNQSBsZW5ndGggYW5kIG1l
bW9yeSBhZGRyZXNzIG5lZWQgdG8gYmUgNCBieXRlIGJvdW5kYXJ5Lg0KDQotIFJYIGNoYW5uZWwg
cmVsZWFzaW5nIHdoZW4gVFggaW5pdCBmYWlscz8NCiAgRm9yIEkyQyBib3RoIFRYIGFuZCBSWCBk
b2VzbuKAmXQgaGFwcGVuIGluIHNhbWUgdHJhbnNhY3Rpb24gYW5kIG5vIGRlcGVuZGVuY3kuIA0K
U28gaWYgUlggY2hhbm5lbCByZXF1ZXN0ICYgYnVmZmVyIGFsbG9jYXRpb24gc3VjY2VlZHMgYnV0
IFRYIGNoYW5uZWwgcmVxdWVzdCBmYWlscywgdGhlbiBSWCBETUEgY2FuIHN0aWxsIGJlIHVzZWQg
Zm9yIE1zZyByZWFkcyBhbmQgdHJhbnNtaXRzIGNhbiBoYXBwZW4gb24gUElPIG1vZGUNCg0KLSBk
bWFfYnVyc3QgPCA4IG5lZ2F0aXZlbHkgYWZmZWN0cyB0cmFuc2ZlciBlZmZpY2llbmN5PyBQZXJm
b3JtYW5jZSBzdGF0cyBmb3IgRE1BIFZzIFBJTyBtb2RlLg0KVGVzdGVkIHdpdGggMjU2IGJ5dGVz
IG9mIHRyYW5zZmVyIGFuZCBETUEgVnMgUElPIG1vZGUgdHJhbnNmZXIgcmF0ZSBpcyBhbG1vc3Qg
c2FtZS4NCkJ1dCB0aGUgbWFpbiByZWFzb24gZm9yIGFkZGluZyBETUEgbW9kZSBpcyB0byBhZGRy
ZXNzIGNvdXBsZSBvZiBjYXNlcyBtZW50aW9uZWQgZWFybGllciBhbmQgbm90IG1haW5seSBmcm9t
IHRoZSB0cmFuc2ZlciBwZXJmb3JtYW5jZSBwZXJzcGVjdGl2ZS4gDQoNCg0K
