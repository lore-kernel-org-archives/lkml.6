Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32935C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1392082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AlN242Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbfBDQGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:06:42 -0500
Received: from mail-eopbgr750042.outbound.protection.outlook.com ([40.107.75.42]:48054
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731157AbfBDQGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:06:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7MX3LdRSDwFshG6o51D6t9ZpjFpp9zWX/MF5CXOHuM=;
 b=AlN242Bsg5ITKYOOZoujCmXZkfH79/RVuqaciAshLyFKg2QKvS2HixYqEi6bASYFfsHeZycnToQUpZREKfpnJoCmrTGtlA2UpJBiFvgWkuqaKl+/OqGrjUIms5GCW6G4FUtz4syjVvLBjOQN2wc2I8jrW0uFKLsCNRzCyls84W4=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB3067.namprd12.prod.outlook.com (20.178.30.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Mon, 4 Feb 2019 16:05:59 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1558.026; Mon, 4 Feb 2019
 16:05:59 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [PATCH] svm: Fix improper check when deactivate AVIC
Thread-Topic: [PATCH] svm: Fix improper check when deactivate AVIC
Thread-Index: AQHUt6n/PbEp8KQZn0iUg2/B2tUkjaXIALmAgALK0oCABQwbgA==
Date:   Mon, 4 Feb 2019 16:05:59 +0000
Message-ID: <a845d403-be02-ef43-2673-01b265e77fb3@amd.com>
References: <20190129080913.40998-1-suravee.suthikulpanit@amd.com>
 <8663e279-5ea2-a3a9-9ecc-7b7226ab48bc@redhat.com>
 <e587eb0a-cd73-bbf9-5a77-1cc598bd49ac@amd.com>
In-Reply-To: <e587eb0a-cd73-bbf9-5a77-1cc598bd49ac@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
x-originating-ip: [61.90.26.242]
x-clientproxiedby: SG2PR02CA0096.apcprd02.prod.outlook.com
 (2603:1096:4:90::36) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB3067;20:PR5PVirVA0UHsLWeB8nVry74AV3xsm+yvyzZn+BIl9Uz1BoeMJDV80qb8DMiM6JK3ZGjIfmBXRyLx5ntvmuAv3BU2yT25I7l0v0c4LBM2u2Ea4XPSIpaTZSs2jo7Ct1b4Qck+L1eKUTm76AvqHF4sxhvvE3EFtZ96RpgTptQ7vV/T8aMQievHxnfjJJqgp6uLBcSHiWaPxfuMSUK7JmHmOSb3qvu29k+IDv7z4kOpN2SEW5X+ySDeiTUL1ZaCDaH
x-ms-office365-filtering-correlation-id: e138ef42-cb16-4c9e-2a9a-08d68abaa6f2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB3067;
x-ms-traffictypediagnostic: DM6PR12MB3067:
x-microsoft-antispam-prvs: <DM6PR12MB306777FF4DD1AC11A1B05E67F36D0@DM6PR12MB3067.namprd12.prod.outlook.com>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(39860400002)(396003)(189003)(199004)(6486002)(6116002)(65826007)(65956001)(64126003)(76176011)(65806001)(66066001)(186003)(6512007)(36756003)(31686004)(102836004)(6436002)(386003)(6506007)(305945005)(105586002)(106356001)(110136005)(72206003)(2501003)(54906003)(53546011)(7736002)(68736007)(99286004)(7416002)(25786009)(478600001)(2906002)(58126008)(53936002)(52116002)(8676002)(81156014)(229853002)(6246003)(316002)(81166006)(14454004)(8936002)(4326008)(86362001)(71200400001)(71190400001)(31696002)(2201001)(26005)(476003)(256004)(486006)(97736004)(446003)(11346002)(2616005)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3067;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S2DHku4tywd5Yj6MK/Wa26Pq2h/lIg/1pE/bZswrb8otcARd8J4urSEplG84flGIlxM5vfd/Ufck6rtAj/McUjygyQHT/AbdV4zOVjPwdnpw9f6vraeTPoGzKoF07nAAv3G4NCjYpf+GlyLB2hq+oDsByskMY24NTOflSAsWfMEQTuDUu/9TZAGO4BiOYLHTqTJKbOLnDy51jRuehdzylzZ0PL0YUj4c0Z/Q2mR/DXbBo6mCDqs7v81XrajVY2qXGfGf9kCnXxsf2RArTlZPafNRVUEPOnxwuZUa0e9j3fY0Unpi8KNSlV9caGO0HOhC51Gkp/+47g89+LM7wfsLTt/WGma2QPKSMKVNOLLh4yA5hu7xzyt/Q836W+XZB57t1sHLZNmSotpBcf7GraJV6xidA9qLCbtkQFuFWn9KW5A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69687E50C50AA04196B51884A9B1EFC7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e138ef42-cb16-4c9e-2a9a-08d68abaa6f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 16:05:55.9221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGFvbG8sDQoNCk9uIDIvMS8xOSA2OjAxIFBNLCBTdXJhdmVlIFN1dGhpa3VscGFuaXQgd3JvdGU6
DQo+IFBhb2xvLA0KPiANCj4gT24gMS8zMC8xOSAxMToyMiBQTSwgUGFvbG8gQm9uemluaSB3cm90
ZToNCj4+IE9uIDI5LzAxLzE5IDA5OjA5LCBTdXRoaWt1bHBhbml0LCBTdXJhdmVlIHdyb3RlOg0K
Pj4+IFRoZSBmdW5jdGlvbiBzdm1fcmVmcmVzaF9hcGljdl9leGVjX2N0cmwoKSBhbHdheXMgcmV0
dXJuaW5nIHByZW1hdHVyZWx5DQo+Pj4gYXMga3ZtX3ZjcHVfYXBpY3ZfYWN0aXZlKCkgYWx3YXlz
IHJldHVybiBmYWxzZSB3aGVuIGNhbGxpbmcgZnJvbQ0KPj4+IHRoZSBmdW5jdGlvbiBhcmNoL3g4
Ni9rdm0veDg2LmM6a3ZtX3ZjcHVfZGVhY3RpdmF0ZV9hcGljdigpLg0KPj4+IFRoaXMgaXMgYmVj
YXVzZSB0aGUgYXBpY3ZfYWN0aXZlIGlzIHNldCB0byBmYWxzZSBqdXN0IGJlZm9yZSBjYWxsaW5n
DQo+Pj4gcmVmcmVzaF9hcGljdl9leGVjX2N0cmwoKS4NCj4+Pg0KPj4+IEFsc28sIHdlIG5lZWQg
dG8gbWFyayBWTUNCX0FWSUMgYml0IGFzIGRpcnR5IGluc3RlYWQgb2YgVk1DQl9JTlRSLg0KPj4+
DQo+Pj4gU28sIGZpeCBzdm1fcmVmcmVzaF9hcGljdl9leGVjX2N0cmwoKSB0byBwcm9wZXJseSBk
ZWFjdGl2YXRlIEFWSUMuDQo+Pj4NCj4+PiBGaXhlczogNjcwMzRiYjlkZDVlICgnS1ZNOiBTVk06
IEFkZCBpcnFjaGlwX3NwbGl0KCkgY2hlY2tzIGJlZm9yZSBlbmFibGluZyBBVklDJykNCj4+DQo+
PiBIYXZpbmcgdGhlIGxhcGljX2luX2tlcm5lbCBjaGVjayBpbiB5b3VyIGNvZGUgaXMgYSBiaXQg
dWdseSAtIHRoZSBjYWxsZXINCj4+IHNob3VsZCBjaGVjayBpdC7CoCBBbmQgYWN0dWFsbHksIGV2
ZW4gdGhvdWdoIGl0IGRvZXNuJ3QgY2hlY2sgaXQgcmlnaHQNCj4+IG5vdywgc3ZtX3JlZnJlc2hf
YXBpY3ZfZXhlY19jdHJsIGlzIG9ubHkgcmVhY2hhYmxlIGlmIGxhcGljX2luX2tlcm5lbA0KPj4g
cmV0dXJucyB0cnVlOyBzZWUgdGhlIEtWTV9DQVBfSFlQRVJWX1NZTklDIGNhc2Ugb2YNCj4+IGt2
bV92Y3B1X2lvY3RsX2VuYWJsZV9jYXAuDQo+Pg0KPj4gV2hhdCBhYm91dCB0aGlzIHNpbXBsZXIg
cGF0Y2g6DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2t2bS9zdm0uYyBiL2FyY2gveDg2
L2t2bS9zdm0uYw0KPj4gaW5kZXggMDFiNjZiYmNkZDdhLi43NGNlZGE0NzBlYWUgMTAwNjQ0DQo+
PiAtLS0gYS9hcmNoL3g4Ni9rdm0vc3ZtLmMNCj4+ICsrKyBiL2FyY2gveDg2L2t2bS9zdm0uYw0K
Pj4gQEAgLTUxMjIsMTEgKzUxMjIsMTEgQEAgc3RhdGljIHZvaWQgc3ZtX3JlZnJlc2hfYXBpY3Zf
ZXhlY19jdHJsKA0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdmNwdV9zdm0gKnN2bSA9IHRvX3N2bSh2
Y3B1KTsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IHZtY2IgKnZtY2IgPSBzdm0tPnZtY2I7DQo+Pg0K
Pj4gLcKgwqDCoCBpZiAoIWt2bV92Y3B1X2FwaWN2X2FjdGl2ZSgmc3ZtLT52Y3B1KSkNCj4+IC3C
oMKgwqDCoMKgwqDCoCByZXR1cm47DQo+PiAtDQo+PiAtwqDCoMKgIHZtY2ItPmNvbnRyb2wuaW50
X2N0bCAmPSB+QVZJQ19FTkFCTEVfTUFTSzsNCj4+IC3CoMKgwqAgbWFya19kaXJ0eSh2bWNiLCBW
TUNCX0lOVFIpOw0KPj4gK8KgwqDCoCBpZiAoa3ZtX3ZjcHVfYXBpY3ZfYWN0aXZlKHZjcHUpKQ0K
Pj4gK8KgwqDCoMKgwqDCoMKgIHZtY2ItPmNvbnRyb2wuaW50X2N0bCB8PSBBVklDX0VOQUJMRV9N
QVNLOw0KPj4gK8KgwqDCoCBlbHNlDQo+PiArwqDCoMKgwqDCoMKgwqAgdm1jYi0+Y29udHJvbC5p
bnRfY3RsICY9IH5BVklDX0VOQUJMRV9NQVNLOw0KPj4gK8KgwqDCoCBtYXJrX2RpcnR5KHZtY2Is
IFZNQ0JfQVZJQyk7DQo+PiDCoCB9DQo+Pg0KPj4gwqAgc3RhdGljIHZvaWQgc3ZtX2xvYWRfZW9p
X2V4aXRtYXAoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LCB1NjQNCj4+ICplb2lfZXhpdF9iaXRtYXAp
DQo+Pg0KPj4gPw0KPj4NCj4+IFRoYW5rcywNCj4+DQo+PiBQYW9sbw0KPj4NCj4gDQo+IFllcywg
dGhpcyB3b3VsZCB3b3JrLg0KPiANCj4gVGhpcyBwYXRjaCBpcyBhY3R1YWxseSBhIHByZWN1cnNv
ciBvZiBhIHBhdGNoIHNlcmllcyB0aGF0IEkgYW0gd29ya2luZyBvbg0KPiB0byBhbGxvdyBBVklD
IGVuYWJsaW5nL2Rpc2FibGluZyBkdXJpbmcgcnVuLXRpbWUuIEkgd2lsbCBzZW5kIG91dCBhIHNl
cmllcw0KPiBmb3IgUkZDIHNvb24uDQo+IA0KPiBUaGFua3MsDQo+IFN1cmF2ZWUNCg0KTm90IHN1
cmUgaWYgeW91IGhhdmUgYWxyZWFkeSBhcHBsaWVkIHRoaXMgY2hhbmdlLiBBbnlob3csIEkganVz
dCB3YW50IHRvIGxldA0KeW91IGtub3cgdGhhdCBJIGhhdmUgaW5jbHVkZWQgdGhlIGNoYW5nZSB5
b3Ugc3VnZ2VzdGVkIGFzIHBhdGNoIDEvOCBvZg0KdGhlIFJGQyBzZXJpZXMNCg0KIktWTTogeDg2
OiBzdm06IEVuYWJsaW5nIEFWSUMgd2l0aCBpbiBrZXJuZWwgaXJxY2hpcCINCg0KVGhhbmtzLA0K
U3VyYXZlZQ0K
