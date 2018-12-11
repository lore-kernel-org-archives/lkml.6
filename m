Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAADC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B94C20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mOksNH0G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B94C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeLKWqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:46:23 -0500
Received: from mail-eopbgr720046.outbound.protection.outlook.com ([40.107.72.46]:34114
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726361AbeLKWqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CumKVzNJIVp3sFfpHVZSP953H8JPy5OIFTFWZUlbY1I=;
 b=mOksNH0GcPfrwUSuGS1cRHzhiu5aTCrHN3rn0HYgBoXKCAbQ96Hf7woL66qRrQE0v3vNuB/TgyddZ9J3frUPDrBPNhQZRwEAqM5DY6TbJAm4xHCiVCzAddFEfWIboiraypI8j5EYT3UcRljY1f/aLCpL10xdjsiNvocH9mPq1eI=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB2445.namprd12.prod.outlook.com (52.132.195.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Tue, 11 Dec 2018 22:46:17 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 22:46:17 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2] x86/speculation: Add support for STIBP always-on preferred
 mode
Thread-Topic: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Index: AQHUkaNTNctPywnCTEqVxIZjhKo+lQ==
Date:   Tue, 11 Dec 2018 22:46:16 +0000
Message-ID: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2445;20:S22ogREjwXjOPovUb0cPYNPuwA6l941tV0wCSNvroG2O8uS/2ZovdyzqM+gLUMMHLPp7vw9c/SR9N4uMNc7nTRsP1Iui4fV8pT/laHJCAaNVv+jsRCcrOG86ogIehedWmOozAZGdkhkGfFCLGBZVNuOQmPZ3NRY3DSmK+ofvsnlaLh8W+DEQx6zh7b3a3X5VOHmqo49RcTJaoqcmCoc7u3hSMwGYsJiRDKJhIJORlrwbP2DA7kdM607/xILc25mo
x-ms-office365-filtering-correlation-id: 8d7c8a71-e271-4fb0-5693-08d65fba75db
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2445;
x-ms-traffictypediagnostic: SN1PR12MB2445:
x-microsoft-antispam-prvs: <SN1PR12MB24458608CC65212FE2D118CEECA60@SN1PR12MB2445.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB2445;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2445;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(189003)(81156014)(71200400001)(316002)(8676002)(8936002)(81166006)(54906003)(71190400001)(476003)(6506007)(478600001)(7416002)(486006)(110136005)(99286004)(4326008)(386003)(52116002)(68736007)(2906002)(97746001)(33896004)(256004)(14444005)(7736002)(86362001)(97736004)(102836004)(186003)(26005)(6486002)(5660300001)(9686003)(1076002)(6512007)(305945005)(14454004)(66066001)(6436002)(3846002)(103116003)(53936002)(2501003)(6116002)(72206003)(106356001)(25786009)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2445;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +hGrp9Jb3zc4KrFzqNJ12Cwd1M7x2ewpkBVp+BwPL3AYChXSpYweP3TMsKXf3ku2F4pi1UuCYsdHba+qF6jasUK3neOICqeU019qJCouFW0fXWG7z6NQmRIrKGFB3Of9uGOLBbx/jUNAZ+1G3eICbGe/P5dQVkCRqzh01LonDJCLdqfIKAfmRmZkXNtO94U6x0JMTv/qJbWbYuA0tH0JTzAhiyEVBApCl5Nxg/NuzP7A9FfUoADdYAkZ/wSlYyIhUj1pUyMG2epuV4zNLlUWIJXNJp75vNTITzrf1GuslsILE+IGxCo3zJxB7Z2dW7Fu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A76A1C96716C144A7102BD39F6F412A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7c8a71-e271-4fb0-5693-08d65fba75db
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 22:46:16.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGlmZmVyZW50IEFNRCBwcm9jZXNzb3JzIG1heSBoYXZlIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlv
bnMgb2YgU1RJQlAuDQpXaGVuIFNUSUJQIGlzIGNvbmRpdGlvbmFsbHkgZW5hYmxlZCwgc29tZSBp
bXBsZW1lbnRhdGlvbnMgd291bGQgYmVuZWZpdA0KZnJvbSBoYXZpbmcgU1RJQlAgYWx3YXlzIG9u
IGluc3RlYWQgb2YgdG9nZ2xpbmcgdGhlIFNUSUJQIGJpdCB0aHJvdWdoIE1TUg0Kd3JpdGVzLiBU
aGlzIHByZWZlcmVuY2UgaXMgYWR2ZXJ0aXNlZCB0aHJvdWdoIGEgQ1BVSUQgZmVhdHVyZSBiaXQu
DQoNCldoZW4gY29uZGl0aW9uYWwgU1RJQlAgc3VwcG9ydCBpcyByZXF1ZXN0ZWQgYXQgYm9vdCBh
bmQgdGhlIENQVSBhZHZlcnRpc2VzDQpTVElCUCBhbHdheXMtb24gbW9kZSBhcyBwcmVmZXJyZWQs
IHN3aXRjaCB0byBTVElCUCAib24iIHN1cHBvcnQuIFByaW50IGENCm1lc3NhZ2UgdG8gbGV0IHRo
ZSB1c2VyIGtub3cgdGhpcyBvY2N1cnJlZC4gQWxzbywgcHJvdmlkZSBhIGJvb2xlYW4gdGhhdA0K
YmUgdXNlZCBpbiBzdGlicF9zdGF0ZSgpIHRvIHJldHVybiBhIG1lc3NhZ2UgdGFpbG9yZWQgdG8g
dGhlIGFsd2F5cy1vbg0Kc3VwcG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogVG9tIExlbmRhY2t5IDx0
aG9tYXMubGVuZGFja3lAYW1kLmNvbT4NCi0tLQ0KDQpUaGlzIHBhdGNoIGlzIGFnYWluc3QgdGhl
IHg4Ni9wdGkgYnJhbmNoIG9mIHRoZSB0aXAgdHJlZToNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAuZ2l0IHg4Ni9wdGkNCg0KQ2hhbmdlcyBm
cm9tIHYxOg0KLSBSZW1vdmVkIGV4cGxpY2l0IFNQRUNUUkVfVjJfVVNFUl9TVFJJQ1RfUFJFRkVS
UkVEIG1vZGUNCi0gQWRkZWQgYSBtZXNzYWdlIHdoZW4gc3dpdGNoaW5nIHRvIGFsd2F5cy1vbiBt
b2RlDQotIFNldCBhbmQgdXNlZCBhIHN0YXRpYyBib29sZWFuIGZvciB0aGUgc3RyaW5nIGluIHN0
aWJwX3N0YXRlKCkNCg0KIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmggfCAgICAx
ICsNCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYyAgICAgICAgIHwgICAxNyArKysrKysrKysr
KysrKysrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaCBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmgNCmluZGV4IDI4YzRhNTAuLmRmOGU5NGUy
IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KKysrIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vY3B1ZmVhdHVyZXMuaA0KQEAgLTI4NCw2ICsyODQsNyBAQA0K
ICNkZWZpbmUgWDg2X0ZFQVRVUkVfQU1EX0lCUEIJCSgxMyozMisxMikgLyogIiIgSW5kaXJlY3Qg
QnJhbmNoIFByZWRpY3Rpb24gQmFycmllciAqLw0KICNkZWZpbmUgWDg2X0ZFQVRVUkVfQU1EX0lC
UlMJCSgxMyozMisxNCkgLyogIiIgSW5kaXJlY3QgQnJhbmNoIFJlc3RyaWN0ZWQgU3BlY3VsYXRp
b24gKi8NCiAjZGVmaW5lIFg4Nl9GRUFUVVJFX0FNRF9TVElCUAkJKDEzKjMyKzE1KSAvKiAiIiBT
aW5nbGUgVGhyZWFkIEluZGlyZWN0IEJyYW5jaCBQcmVkaWN0b3JzICovDQorI2RlZmluZSBYODZf
RkVBVFVSRV9BTURfU1RJQlBfQUxXQVlTX09OCSgxMyozMisxNykgLyogIiIgU2luZ2xlIFRocmVh
ZCBJbmRpcmVjdCBCcmFuY2ggUHJlZGljdG9ycyBhbHdheXMtb24gcHJlZmVycmVkICovDQogI2Rl
ZmluZSBYODZfRkVBVFVSRV9BTURfU1NCRAkJKDEzKjMyKzI0KSAvKiAiIiBTcGVjdWxhdGl2ZSBT
dG9yZSBCeXBhc3MgRGlzYWJsZSAqLw0KICNkZWZpbmUgWDg2X0ZFQVRVUkVfVklSVF9TU0JECQko
MTMqMzIrMjUpIC8qIFZpcnR1YWxpemVkIFNwZWN1bGF0aXZlIFN0b3JlIEJ5cGFzcyBEaXNhYmxl
ICovDQogI2RlZmluZSBYODZfRkVBVFVSRV9BTURfU1NCX05PCQkoMTMqMzIrMjYpIC8qICIiIFNw
ZWN1bGF0aXZlIFN0b3JlIEJ5cGFzcyBpcyBmaXhlZCBpbiBoYXJkd2FyZS4gKi8NCmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVn
cy5jDQppbmRleCA1ODY4OWFjLi5kYjE1NmUxIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVs
L2NwdS9idWdzLmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jDQpAQCAtNjEsNiAr
NjEsOCBAQA0KIC8qIENvbnRyb2wgdW5jb25kaXRpb25hbCBJQlBCIGluIHN3aXRjaF9tbSgpICov
DQogREVGSU5FX1NUQVRJQ19LRVlfRkFMU0Uoc3dpdGNoX21tX2Fsd2F5c19pYnBiKTsNCiANCitz
dGF0aWMgYm9vbCBzdGlicF9hbHdheXNfb247DQorDQogdm9pZCBfX2luaXQgY2hlY2tfYnVncyh2
b2lkKQ0KIHsNCiAJaWRlbnRpZnlfYm9vdF9jcHUoKTsNCkBAIC0zNTUsNiArMzU3LDE4IEBAIHN0
YXRpYyB2b2lkIF9faW5pdCBzcGVjX3YyX3VzZXJfcHJpbnRfY29uZChjb25zdCBjaGFyICpyZWFz
b24sIGJvb2wgc2VjdXJlKQ0KIAkJYnJlYWs7DQogCX0NCiANCisJLyoNCisJICogQXQgdGhpcyBw
b2ludCwgYW4gU1RJQlAgbW9kZSBvdGhlciB0aGFuICJvZmYiIGhhcyBiZWVuIHNldC4NCisJICog
SWYgU1RJQlAgc3VwcG9ydCBpcyBub3QgYmVpbmcgZm9yY2VkLCBjaGVjayBpZiBTVElCUCBhbHdh
eXMtb24NCisJICogaXMgcHJlZmVycmVkLg0KKwkgKi8NCisJaWYgKG1vZGUgIT0gU1BFQ1RSRV9W
Ml9VU0VSX1NUUklDVCAmJg0KKwkgICAgYm9vdF9jcHVfaGFzKFg4Nl9GRUFUVVJFX0FNRF9TVElC
UF9BTFdBWVNfT04pKSB7DQorCQlzdGlicF9hbHdheXNfb24gPSB0cnVlOw0KKwkJbW9kZSA9IFNQ
RUNUUkVfVjJfVVNFUl9TVFJJQ1Q7DQorCQlwcl9pbmZvKCJtaXRpZ2F0aW9uOiBTVElCUCBhbHdh
eXMtb24gaXMgcHJlZmVycmVkXG4iKTsNCisJfQ0KKw0KIAkvKiBJbml0aWFsaXplIEluZGlyZWN0
IEJyYW5jaCBQcmVkaWN0aW9uIEJhcnJpZXIgKi8NCiAJaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVB
VFVSRV9JQlBCKSkgew0KIAkJc2V0dXBfZm9yY2VfY3B1X2NhcChYODZfRkVBVFVSRV9VU0VfSUJQ
Qik7DQpAQCAtMTA4OCw3ICsxMTAyLDggQEAgc3RhdGljIGNoYXIgKnN0aWJwX3N0YXRlKHZvaWQp
DQogCWNhc2UgU1BFQ1RSRV9WMl9VU0VSX05PTkU6DQogCQlyZXR1cm4gIiwgU1RJQlA6IGRpc2Fi
bGVkIjsNCiAJY2FzZSBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUOg0KLQkJcmV0dXJuICIsIFNUSUJQ
OiBmb3JjZWQiOw0KKwkJcmV0dXJuIHN0aWJwX2Fsd2F5c19vbiA/ICIsIFNUSUJQOiBhbHdheXMt
b24iDQorCQkJCSAgICAgICA6ICIsIFNUSUJQOiBmb3JjZWQiOw0KIAljYXNlIFNQRUNUUkVfVjJf
VVNFUl9QUkNUTDoNCiAJY2FzZSBTUEVDVFJFX1YyX1VTRVJfU0VDQ09NUDoNCiAJCWlmIChzdGF0
aWNfa2V5X2VuYWJsZWQoJnN3aXRjaF90b19jb25kX3N0aWJwKSkNCg0K
