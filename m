Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91257C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55914205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FWu8CmSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404818AbfAPPOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:14:36 -0500
Received: from mail-eopbgr730081.outbound.protection.outlook.com ([40.107.73.81]:17536
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404806AbfAPPOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPmXf4aZrZg++27FrvpLWMdCau5wuit9iVoLQV94HYs=;
 b=FWu8CmSdQwBAE3GraSY+5sh2l1gJbPZaAHTacnSpM5R+LCJxpI1b13/JcSFTE8AOpooWXM7S6rB7/QLO+KqrDBwgZn7+opzDOynCzNP0zxHnUWBUZIzCH9ED48D9udz42CAoIVpL1D+O8oygmoIawzpPxfaLFxunK6KzyP2rrq4=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB3551.namprd12.prod.outlook.com (20.179.84.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Wed, 16 Jan 2019 15:14:29 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f%3]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:14:29 +0000
From:   S@vger.kernel.org
To:     Borislav Petkov <bp@alien8.de>, "S, Shirish" <Shirish.S@amd.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume path
 as well
Thread-Topic: [PATCH 2/2] x86/mce/amd: Ensure quirks are applied in resume
 path as well
Thread-Index: AQHUpnT6RX1zZkZcBk29IptIsRwq2qWngtqAgACqJYCABm8wAIAAVaaA///+GACAAMwsgIAA5geAgAFw8AA=
Date:   Wed, 16 Jan 2019 15:14:29 +0000
Message-ID: <8bed39c8-df48-dbb9-3674-dfbc4aea2967@amd.com>
References: <1546857399-2926-1-git-send-email-shirish.s@amd.com>
 <1546857399-2926-3-git-send-email-shirish.s@amd.com>
 <20190109220843.GK15665@zn.tnic>
 <7a9227c0-1bc3-67c5-14a8-a40d186a5ef8@amd.com>
 <20190114103312.GG2773@zn.tnic>
 <2ad4bb63-2b70-3652-3261-009cdbfc15a9@amd.com>
 <20190114153256.GM2773@zn.tnic>
 <4f8b532b-8613-feb5-7474-4bb0462cf1c7@amd.com>
 <20190115172659.GE6596@zn.tnic>
In-Reply-To: <20190115172659.GE6596@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB3551;20:DZqOaFK7n/oigZAUF87kl8kPhmHGdXs7iSYCTh1/ZkC1V/3HgaQRVKPH1s1fXm6sgFDSVUJ1Ubzs6TJNmrFsrU0Mqn85hGw/k4hOp/bZ6gzCf5wMM2P2XPi8FWb6ET26b7TrHAOMmpWDatC3Oz95TkqTdLnNCwgXCU+F8vg5ntE2fft8W99NwKgS1uumsFLXXSgCm4yxom6ppzqoarz0LLanDkn6IqzObe0scyoTt6iv5P4iP5Hw4oiOQ7IIWf2J
x-ms-office365-filtering-correlation-id: a87eb5a4-71ea-4299-e0bb-08d67bc54fc4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB3551;
x-ms-traffictypediagnostic: MN2PR12MB3551:
x-microsoft-antispam-prvs: <MN2PR12MB355129E89CC2657550AE19F4F2820@MN2PR12MB3551.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(106356001)(81156014)(6486002)(105586002)(31686004)(6636002)(31696002)(71200400001)(229853002)(71190400001)(4744005)(2906002)(7736002)(81166006)(256004)(6436002)(53936002)(8676002)(66066001)(8936002)(6512007)(305945005)(93886005)(5660300001)(316002)(110136005)(6506007)(54906003)(476003)(68736007)(25786009)(486006)(11346002)(99286004)(6116002)(72206003)(14454004)(4326008)(97736004)(3846002)(2616005)(76176011)(446003)(53546011)(52116002)(102836004)(478600001)(36756003)(386003)(186003)(26005)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3551;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ohh6jpHg7TlosgsPMYUxyUm6uJDI4HjfxoXFjjB8YMIC1vjFhoHyp/T8nRKjO8uUWJh4DJkLy+IwsBlMulMbo8qikO+sxwIkUKMmNqAr0gDnSKvv44iNi7svM8fdANjR1bIf7mkw1S63P+xfPlWFPXbPgotnvWLnr9X6pRa4TnkJqvr/RAqWZ/NsOCM6k2B85voWY/NP6bD0lLhcjxrVxrfVDPIklCYmYH2u1Ny+Xqwi+I0a9rv7HAppTczda6osg9SjL0HNCnCe04h+C4ryY9nU8nO/+Mrf1T6YfqcQY5SyCmNtAT3+1ZleYrFbQgD/vvngZUrkAzrwDYuZqzRkakpSOYv2GVHTvuAI7aduEqwnYurPzqorF8UUOoI6Bj2JmHF4YVu0LTHloQdSTx9YBbj2DpSlJGZhQ7JJJINp6xM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A01EB1E0957A34C9F2448754BEE605E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87eb5a4-71ea-4299-e0bb-08d67bc54fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:14:23.1223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzE1LzIwMTkgMTA6NTYgUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVl
LCBKYW4gMTUsIDIwMTkgYXQgMDM6MzA6NDJBTSArMDAwMCwgUyB3cm90ZToNCj4+IFBsZWFzZSB0
YWxrIHRvIHlvdXIgY29sbGVhZ3VlcyBob3cgdG8gZml4IHRoYXQuIEFkZGluZyBzb21lIG9mIHRo
ZW0gdG8NCj4+IENDLg0KPiBZb3VyIG1haWxlciBpcyBzdGlsbCBicm9rZW4uIEhvdyBkbyB5b3Ug
bWFuYWdlIHRvIGhhdmUgYW4gZW1wdHkgRnJvbTo/DQo+IElzIHlvdXIgZXhjaGFuZ2UgY2xpZW50
IG1pc2NvbmZpZ3VyZWQ/DQo+DQo+PiBMZXQgbWUga25vdyBpZiB5b3Ugd2FudCBtZSB0byBmaXgg
dGhpcyBhbmQgcmUtc2VuZCB0aGUgMyBwYXRjaGVzLg0KPiBXZWxsLCBwbGVhc2UgcmVkbyB0aGVt
IGJ5IG1vdmluZyB0aGUgcXVpcmsgZnVuY3Rpb24gdG8NCj4NCj4gICAgYXJjaC94ODYva2VybmVs
L2NwdS9tY2UvYW1kLmMNCj4NCj4gYW5kIGNhbGwgaXQgZnJvbSBtY2VfYW1kX2ZlYXR1cmVfaW5p
dCgpLiBUaGlzIHdpbGwgY29uY2VudHJhdGUgdGhlIGNvZGUNCj4gbW9yZSBhbmQgd29uJ3QgbmVl
ZCB0aGUgZ2xvYmFsbHkgdmlzaWJsZSBmdW5jdGlvbi4NCg0KRG9uZS4gSG9wZSB0aGUgbWFpbGVy
IGlzIGZpbmUgbm93LCBpIGhhdmUgYWRkZWQgLS1mcm9tIHdoaWxlIHNlbmRpbmcgdGhlIA0KbmV3
IHBhdGNoc2V0IGFuZCBhbHNvIGdvdCBpdCByZXZpZXdlZCBmcm9tIGZvbGtzIGhlcmUuDQoNClJl
Z2FyZHMsDQoNClNoaXJpc2ggUw0KDQo+IFRoeC4NCj4NCi0tIA0KUmVnYXJkcywNClNoaXJpc2gg
Uw0KDQo=
