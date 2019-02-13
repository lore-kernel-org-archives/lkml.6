Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849EFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A88222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HpD2ndjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbfBMG2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:28:16 -0500
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:6405
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbfBMG2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L28OJO1HxXl5Z8YPFLaRSL/S380+3itlqwKzVP7oFW4=;
 b=HpD2ndjGyHKuJiAFTiJW7fj2SNVL8v0w6b1/acDGfkqtFWG7++UtBtKQULtbZwMFdfD4YCwcEhBlNZFsBqmGa1nTindA4aTbg7PqWPPxaSYKSPTxczuQTV88csuCQRxql11dMBpZSZeZQ6/LWF7EwsfMVBNEiovsHxls/gJWBwY=
Received: from AM6PR05MB4167.eurprd05.prod.outlook.com (52.135.161.24) by
 AM6PR05MB5670.eurprd05.prod.outlook.com (20.178.86.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 13 Feb 2019 06:28:06 +0000
Received: from AM6PR05MB4167.eurprd05.prod.outlook.com
 ([fe80::c0e8:4363:53c6:6957]) by AM6PR05MB4167.eurprd05.prod.outlook.com
 ([fe80::c0e8:4363:53c6:6957%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 06:28:06 +0000
From:   Haggai Eran <haggaie@mellanox.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Aviad Yehezkel <aviadye@mellanox.com>
Subject: Re: [PATCH 1/1] RDMA/odp: convert to use HMM for ODP
Thread-Topic: [PATCH 1/1] RDMA/odp: convert to use HMM for ODP
Thread-Index: AQHUt/PsykunvwDRykiSsUeH8/rg2aXSod+AgAnJbACAAO9XAA==
Date:   Wed, 13 Feb 2019 06:28:05 +0000
Message-ID: <804b8721-70dd-646f-0b9e-cffad859170b@mellanox.com>
References: <20190129165839.4127-1-jglisse@redhat.com>
 <20190129165839.4127-2-jglisse@redhat.com>
 <f48ed64f-22fe-c366-6a0e-1433e72b9359@mellanox.com>
 <20190212161123.GA4629@redhat.com>
In-Reply-To: <20190212161123.GA4629@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0477.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::33) To AM6PR05MB4167.eurprd05.prod.outlook.com
 (2603:10a6:209:40::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haggaie@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd6919ea-7fa9-4e80-bcef-08d6917c6991
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR05MB5670;
x-ms-traffictypediagnostic: AM6PR05MB5670:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTZQUjA1TUI1NjcwOzIzOmp3QVJGVXFCbHZEOHlSblZ3TGxobUFNazY4?=
 =?utf-8?B?cWQxSFltd3ZSbk5iSGREVzhIQjZwSGFtR1pPOXdWL2pjaDNVMkFhblMyL09Q?=
 =?utf-8?B?YWpNaWkvQ21LbzdtR1h1NVN1RTlwdzZOYlVDVTBJUVoxQzhlVXJuUzk4STRQ?=
 =?utf-8?B?S3pOK29Lc1V1eWVXbUlEaG5mTGpXemFra3k0eWVhUlNHcjJ5YzBsSUMrWlM1?=
 =?utf-8?B?dks1dVRhTWY1dWV1TG84VnEzcFgzc3VNSlI1WGpBV25ja2h4VC9xMSt3Zm9U?=
 =?utf-8?B?NUtLcUlrY2RDSkxDeHFhZ0M4QW11bDEvMU9VTEh4R3BIcm5RcFg2RHRRTXdp?=
 =?utf-8?B?aXVPYzlaSzdFUGduMDA4QStvc2dLQjBPWC9BWFFCcjU1NWh3bkJUWi80U0lZ?=
 =?utf-8?B?ZktGWWNBUmpScHhFb0RLcUc0d2JWbWhFZDdRZzZrR1hZZ3k1Z2E2RHBNNnhC?=
 =?utf-8?B?SEowU2NMbkpiR0d2M2JBc3VOanNJcjFVcjRrZEppU21CM20xM0xBSHhid3NQ?=
 =?utf-8?B?OUk1aXd6dXhKbGNaTFZFUjZyeGRZdGswMW5MZ0wxNXV6NTR5bmdnSzFsRXpY?=
 =?utf-8?B?aFNsUjJLWmdjK1NvYWtLY01oemVIVTFhYzFqVEtDTzFYWDZuays4SmJNelF1?=
 =?utf-8?B?SXRhWmhSM0tFd1cyQzFsRDNtVk1zNWxrMVFIUFoxVTcrUHp6emNrbzRRTWZH?=
 =?utf-8?B?Y1NycExzMzd4bEJxS1V1QWJaTUZ2a1BtTm5KTDJ4Q0hZTEVtL0txMXU1c3c0?=
 =?utf-8?B?SEJKQS9nQjFOL2kvMEN0VHRwWVo3SVNIS1pqU3FrNmRmamhHcjZjQTRrUCtt?=
 =?utf-8?B?T2RCMzZmVWVVb3ltWUI3S0ZTdFNZVlpUdGZmVVZ2N3oyTStvdHlVK0RTcFR0?=
 =?utf-8?B?bmFTQXhKN1BoM1MxL1MxNWQ1dXhoZXE1U0doREIwRmQwcEc5TXlGNkUyUUx3?=
 =?utf-8?B?UXNjeUxrNng2bXZPbXFhbjZEaFBKMGFPUWJqdTZJY2w5b2J3Q0NwZEczTGVq?=
 =?utf-8?B?RVpKU2x4d0tsR2l2NE1yZjVRdkVkRUk4dFd3VE9YN3lBRzVJTUJxYkg2dWxu?=
 =?utf-8?B?T05HaTF3Q0t4REVPakRwVmk5RWZGTVVDZEZ6VjJCSGxJNWNiRmtMVW83dGVl?=
 =?utf-8?B?Wi83dlhZT1BsTGVXdUZKSVBCOVRrK1hlbXd6Ym1rcGFwZVpxYXFOV0hlcVVv?=
 =?utf-8?B?ek5CMnRMSk52bHVudDdDVEtWMGlKc1QxUzRUallhamxLYnZpeC94QkNyZ0Yz?=
 =?utf-8?B?T1VnZEhLY0xuY0NZWnMrZlA3VitYRVphSEhhVWh6NTZVTTNWUGhmWW9NcW53?=
 =?utf-8?B?d3N6aHl3SzM2OHhLWTdpTSsyM0xqcG1pNXJqUk43bzRRYWFUZ2pVOVdrcHND?=
 =?utf-8?B?d0NMLzJ6a0tOWjJ5MVZxNjVIQ3NTUWQrUTdDYjlkVmxtTjcvZThGYVBTdGtL?=
 =?utf-8?B?NlNkMzJPb2p0ajJzbG5aWkQvQ08yOWNFOVpEL1I1LytnY3IwdzBJa1ZrRUw0?=
 =?utf-8?B?YzhEZGdJb0g1UW5WdWs1MjRBZ0M0N0tnMlE5Z2dBUDBONFBnTlFqTlZDSHF5?=
 =?utf-8?B?NjY5bVMxb1MwLzUvb29BekhyMzJMdEQvVTVxWWxEaUtSYS83WDBhUHNJYkVo?=
 =?utf-8?B?aVV0Y1U2QkdrNE1VeDd0Znd5UGhSNHY1eGtaaElvRnAvb0pra3VUU1BIMnRq?=
 =?utf-8?B?TjlKUHA2NWorVlFEbFhGVEVQa0ZubkFVTzZ6VG11YUJhN3ZMdnhPN0R1cFFS?=
 =?utf-8?B?eWVhbVZBRFVJcTQ5dm1pMmlMVUtRT2ptdkFxbFRPaHRWc0tZUW9HUGdIQ2FX?=
 =?utf-8?Q?sEjH1aqGyOyvn?=
x-microsoft-antispam-prvs: <AM6PR05MB5670C4AE3942518F2BFE8B3BC1660@AM6PR05MB5670.eurprd05.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(54094003)(97736004)(71190400001)(6246003)(2906002)(81156014)(186003)(105586002)(8676002)(6116002)(3846002)(7736002)(81166006)(31696002)(107886003)(106356001)(6512007)(6916009)(486006)(53936002)(71200400001)(25786009)(8936002)(52116002)(4326008)(31686004)(76176011)(66066001)(305945005)(11346002)(54906003)(14454004)(93886005)(53546011)(86362001)(2616005)(476003)(446003)(478600001)(26005)(6436002)(36756003)(102836004)(99286004)(316002)(6486002)(68736007)(386003)(6506007)(256004)(229853002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5670;H:AM6PR05MB4167.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: icoLgY+Fv/UmAN+QK1AjhtyB8uwoN5Api7DoXScYzj8U1xrae1EtRvMVSkOl2wktmpM17jXKy0zpDf/NDRlX/5xJKGEVGRFBE0UKvKRlQ66tmVp106dvPTk0bxl6za0MI47BnCnamjaqCiqPv0n75I8Ak7Bcsp3pSRN+KWDFJkp35KuhkCIPCBwZ7rkeOKlMFbJtn1+e8AWdhQaO+s+M1Xy2THaC0wt4Sv3jkl6wFmdROqxkFgqas3Vp55n7ExW8TxnMff6HISGRvDQSLSzBxzuRdYVponkt5n5fRD6ofy8hgpbjU13MUIz+Wu5LC5nWxP2xB1lNUIdP0+yFwybnJFqgdOOLpG7LnPYFtVyGMKr993eojJezBlX8MFGySGARKr5gVp9gpggA3lVVPkXnFsLF0Wz6zBA281w53u/7DYY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F3C99886DA22448A6BC48B588A6701E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6919ea-7fa9-4e80-bcef-08d6917c6991
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 06:28:04.1486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5670
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8xMi8yMDE5IDY6MTEgUE0sIEplcm9tZSBHbGlzc2Ugd3JvdGU6DQo+IE9uIFdlZCwgRmVi
IDA2LCAyMDE5IGF0IDA4OjQ0OjI2QU0gKzAwMDAsIEhhZ2dhaSBFcmFuIHdyb3RlOg0KPj4gT24g
MS8yOS8yMDE5IDY6NTggUE0sIGpnbGlzc2VAcmVkaGF0LmNvbSB3cm90ZToNCj4+ICAgPiBDb252
ZXJ0IE9EUCB0byB1c2UgSE1NIHNvIHRoYXQgd2UgY2FuIGJ1aWxkIG9uIGNvbW1vbiBpbmZyYXN0
cnVjdHVyZQ0KPj4gICA+IGZvciBkaWZmZXJlbnQgY2xhc3Mgb2YgZGV2aWNlcyB0aGF0IHdhbnQg
dG8gbWlycm9yIGEgcHJvY2VzcyBhZGRyZXNzDQo+PiAgID4gc3BhY2UgaW50byBhIGRldmljZS4g
VGhlcmUgaXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0KPj4NCj4+IFRoYW5rcyBmb3Igc2VuZGlu
ZyB0aGlzIHBhdGNoLiBJIHRoaW5rIGluIGdlbmVyYWwgaXQgaXMgYSBnb29kIGlkZWEgdG8NCj4+
IHVzZSBhIGNvbW1vbiBpbmZyYXN0cnVjdHVyZSBmb3IgT0RQLg0KPj4NCj4+IEkgaGF2ZSBhIGNv
dXBsZSBvZiBxdWVzdGlvbnMgYmVsb3cuDQo+Pg0KPj4+IC1zdGF0aWMgdm9pZCBpYl91bWVtX25v
dGlmaWVyX2ludmFsaWRhdGVfcmFuZ2VfZW5kKHN0cnVjdCBtbXVfbm90aWZpZXIgKm1uLA0KPj4+
IC0JCQkJY29uc3Qgc3RydWN0IG1tdV9ub3RpZmllcl9yYW5nZSAqcmFuZ2UpDQo+Pj4gLXsNCj4+
PiAtCXN0cnVjdCBpYl91Y29udGV4dF9wZXJfbW0gKnBlcl9tbSA9DQo+Pj4gLQkJY29udGFpbmVy
X29mKG1uLCBzdHJ1Y3QgaWJfdWNvbnRleHRfcGVyX21tLCBtbik7DQo+Pj4gLQ0KPj4+IC0JaWYg
KHVubGlrZWx5KCFwZXJfbW0tPmFjdGl2ZSkpDQo+Pj4gLQkJcmV0dXJuOw0KPj4+IC0NCj4+PiAt
CXJidF9pYl91bWVtX2Zvcl9lYWNoX2luX3JhbmdlKCZwZXJfbW0tPnVtZW1fdHJlZSwgcmFuZ2Ut
PnN0YXJ0LA0KPj4+IC0JCQkJICAgICAgcmFuZ2UtPmVuZCwNCj4+PiAtCQkJCSAgICAgIGludmFs
aWRhdGVfcmFuZ2VfZW5kX3RyYW1wb2xpbmUsIHRydWUsIE5VTEwpOw0KPj4+ICAgIAl1cF9yZWFk
KCZwZXJfbW0tPnVtZW1fcndzZW0pOw0KPj4+ICsJcmV0dXJuIHJldDsNCj4+PiAgICB9DQo+PiBQ
cmV2aW91c2x5IHRoZSBjb2RlIGhlbGQgdGhlIHVtZW1fcndzZW0gYmV0d2VlbiByYW5nZV9zdGFy
dCBhbmQNCj4+IHJhbmdlX2VuZCBjYWxscy4gSSBndWVzcyB0aGF0IHdhcyBpbiBvcmRlciB0byBn
dWFyYW50ZWUgdGhhdCBubyBkZXZpY2UNCj4+IHBhZ2UgZmF1bHRzIHRha2UgcmVmZXJlbmNlIHRv
IHRoZSBwYWdlcyBiZWluZyBpbnZhbGlkYXRlZCB3aGlsZSB0aGUNCj4+IGludmFsaWRhdGlvbiBp
cyBvbmdvaW5nLiBJIGFzc3VtZSB0aGlzIGlzIG5vdyBoYW5kbGVkIGJ5IGhtbSBpbnN0ZWFkLA0K
Pj4gY29ycmVjdD8NCj4gDQo+IEl0IGlzIGEgbWl4IG9mIEhNTSBhbmQgZHJpdmVyIGluIHBhZ2Vm
YXVsdF9tcigpIG1seDUvb2RwLmMNCj4gICAgICBtdXRleF9sb2NrKCZvZHAtPnVtZW1fbXV0ZXgp
Ow0KPiAgICAgIGlmIChobW1fdm1hX3JhbmdlX2RvbmUocmFuZ2UpKSB7DQo+ICAgICAgLi4uDQo+
IA0KPiBUaGlzIGlzIHdoYXQgc2VyaWFsaXplIHByb2dyYW1taW5nIHRoZSBodyBhbmQgYW55IGNv
bmN1cnJlbnQgQ1BVIHBhZ2UNCj4gdGFibGUgaW52YWxpZGF0aW9uLiBUaGlzIGlzIGFsc28gb25l
IG9mIHRoZSB0aGluZyBpIHdhbnQgdG8gaW1wcm92ZQ0KPiBsb25nIHRlcm0gYXMgbWx4NV9pYl91
cGRhdGVfeGx0KCkgY2FuIGRvIG1lbW9yeSBhbGxvY2F0aW9uIGFuZCBpIHdvdWxkDQo+IGxpa2Ug
dG8gYXZvaWQgdGhhdCBpZSBtYWtlIG1seDVfaWJfdXBkYXRlX3hsdCgpIGFuZCBpdHMgc3ViLWZ1
bmN0aW9ucw0KPiBhcyBzbWFsbCBhbmQgdG8gdGhlIHBvaW50cyBhcyBwb3NzaWJsZSBzbyB0aGF0
IHRoZXkgY291bGQgb25seSBmYWlsIGlmDQo+IHRoZSBoYXJkd2FyZSBpcyBpbiBiYWQgc3RhdGUg
bm90IGJlY2F1c2Ugb2YgbWVtb3J5IGFsbG9jYXRpb24gaXNzdWVzLg0KSSB3b25kZXIgaWYgaXQg
d291bGQgYmUgcG9zc2libGUgdG8gbWFrZSB1c2Ugb2YgdGhlIG1lbW9yeSB0aGF0IGlzIA0KYWxy
ZWFkeSBhbGxvY2F0ZWQgKGliX3VtZW1fb2RwLT5kbWFfbGlzdCkgZm9yIHRoYXQgcHVycG9zZS4g
VGhpcyB3b3VsZCANCnByb2JhYmx5IG1lYW4gdGhhdCB0aGlzIGFyZWEgd2lsbCBuZWVkIHRvIGJl
IGZvcm1hdHRlZCBhY2NvcmRpbmcgdG8gdGhlIA0KZGV2aWNlIGhhcmR3YXJlIHJlcXVpcmVtZW50
cyAoZS5nLiwgYmlnIGVuZGlhbiksIGFuZCB0aGVuIHlvdSBjYW4gDQppbnN0cnVjdCB0aGUgZGV2
aWNlIHRvIERNQSB0aGUgdXBkYXRlZCB0cmFuc2xhdGlvbnMgZGlyZWN0bHkgZnJvbSB0aGVpci4N
Cg0KPiANCj4gDQo+Pg0KPj4+ICsNCj4+PiArc3RhdGljIHVpbnQ2NF90IG9kcF9obW1fZmxhZ3Nb
SE1NX1BGTl9GTEFHX01BWF0gPSB7DQo+Pj4gKwlPRFBfUkVBRF9CSVQsCS8qIEhNTV9QRk5fVkFM
SUQgKi8NCj4+PiArCU9EUF9XUklURV9CSVQsCS8qIEhNTV9QRk5fV1JJVEUgKi8NCj4+PiArCU9E
UF9ERVZJQ0VfQklULAkvKiBITU1fUEZOX0RFVklDRV9QUklWQVRFICovDQo+PiBJdCBzZWVtcyB0
aGF0IHRoZSBtbHg1X2liIGNvZGUgaW4gdGhpcyBwYXRjaCBjdXJyZW50bHkgaWdub3JlcyB0aGUN
Cj4+IE9EUF9ERVZJQ0VfQklUIChlLmcuLCBpbiB1bWVtX2RtYV90b19tdHQpLiBJcyB0aGF0IG9r
YXk/IE9yIGlzIGl0DQo+PiBoYW5kbGVkIGltcGxpY2l0bHkgYnkgdGhlIEhNTV9QRk5fU1BFQ0lB
TCBjYXNlPw0KPiANCj4gVGhpcyBpcyBiZWNhdXNlIEhNTSBleGNlcHQgYSBiaXQgZm9yIGRldmlj
ZSBtZW1vcnkgYXMgc2FtZSBBUEkgaXMNCj4gdXNlIGZvciBHUFUgd2hpY2ggaGF2ZSBkZXZpY2Ug
bWVtb3J5LiBJIGNhbiBhZGQgYSBjb21tZW50IGV4cGxhaW5pbmcNCj4gdGhhdCBpdCBpcyBub3Qg
dXNlIGZvciBPRFAgYnV0IHRoZXJlIGp1c3QgdG8gY29tcGx5IHdpdGggSE1NIEFQSS4NCj4gDQo+
Pg0KPj4+IEBAIC0zMjcsOSArMjg3LDEwIEBAIHZvaWQgcHV0X3Blcl9tbShzdHJ1Y3QgaWJfdW1l
bV9vZHAgKnVtZW1fb2RwKQ0KPj4+ICAgCXVwX3dyaXRlKCZwZXJfbW0tPnVtZW1fcndzZW0pOw0K
Pj4+ICAgDQo+Pj4gICAJV0FSTl9PTighUkJfRU1QVFlfUk9PVCgmcGVyX21tLT51bWVtX3RyZWUu
cmJfcm9vdCkpOw0KPj4+IC0JbW11X25vdGlmaWVyX3VucmVnaXN0ZXJfbm9fcmVsZWFzZSgmcGVy
X21tLT5tbiwgcGVyX21tLT5tbSk7DQo+Pj4gKwlobW1fbWlycm9yX3VucmVnaXN0ZXIoJnBlcl9t
bS0+bWlycm9yKTsNCj4+PiAgIAlwdXRfcGlkKHBlcl9tbS0+dGdpZCk7DQo+Pj4gLQltbXVfbm90
aWZpZXJfY2FsbF9zcmN1KCZwZXJfbW0tPnJjdSwgZnJlZV9wZXJfbW0pOw0KPj4+ICsNCj4+PiAr
CWtmcmVlKHBlcl9tbSk7DQo+Pj4gICB9DQo+PiBQcmV2aW91c2x5IHRoZSBwZXJfbW0gc3RydWN0
IHdhcyByZWxlYXNlZCB0aHJvdWdoIGNhbGwgc3JjdSwgYnV0IG5vdyBpdA0KPj4gaXMgcmVsZWFz
ZWQgaW1tZWRpYXRlbHkuIElzIGl0IHNhZmU/IEkgc2F3IHRoYXQgaG1tX21pcnJvcl91bnJlZ2lz
dGVyDQo+PiBjYWxscyBtbXVfbm90aWZpZXJfdW5yZWdpc3Rlcl9ub19yZWxlYXNlLCBzbyBJIGRv
bid0IHVuZGVyc3RhbmQgd2hhdA0KPj4gcHJldmVudHMgY29uY3VycmVudGx5IHJ1bm5pbmcgaW52
YWxpZGF0aW9ucyBmcm9tIGFjY2Vzc2luZyB0aGUgcmVsZWFzZWQNCj4+IHBlcl9tbSBzdHJ1Y3Qu
DQo+IA0KPiBZZXMgaXQgaXMgc2FmZSwgdGhlIGhtbSBzdHJ1Y3QgaGFzIGl0cyBvd24gcmVmY291
bnQgYW5kIG1pcnJvciBob2xkcyBhDQo+IHJlZmVyZW5jZSBvbiBpdCwgdGhlIG1tIHN0cnVjdCBp
dHNlbGYgaGFzIGEgcmVmZXJlbmNlIG9uIHRoZSBtbSBzdHJ1Y3QuDQo+IFNvIG5vIHN0cnVjdHVy
ZSBjYW4gdmFuaXNoIGJlZm9yZSB0aGUgb3RoZXIuIEhvd2V2ZXIgb25jZSByZWxlYXNlIGNhbGwt
DQo+IGJhY2sgaGFwcGVucyB5b3UgY2FuIG5vIGxvbmdlciBmYXVsdCBhbnl0aGluZyBpdCB3aWxs
IC1FRkFVTFQgaWYgeW91DQo+IHRyeSB0byAobm90IHRvIG1lbnRpb24gdGhhdCBieSB0aGVuIGFs
bCB0aGUgdm1hIGhhdmUgYmVlbiB0ZWFyIGRvd24pLg0KPiBTbyBldmVuIGlmIHNvbWUga2VybmVs
IHRocmVhZCByYWNlIHdpdGggZGVzdHJ1Y3Rpb24gaXQgd2lsbCBub3QgYmUgYWJsZQ0KPiB0byBm
YXVsdCBhbnl0aGluZyBvciB1c2UgbWlycm9yIHN0cnVjdCBpbiBhbnkgbWVhbmluZyBmdWxsIHdh
eS4NCj4gDQo+IE5vdGUgdGhhdCBpbiBhIHJlZ3VsYXIgdGVhciBkb3duIHRoZSBPRFAgcHV0X3Bl
cl9tbSgpIHdpbGwgaGFwcGVuIGJlZm9yZQ0KPiB0aGUgcmVsZWFzZSBjYWxsYmFjayBhcyBpaXJj
IGZpbGUgaW5jbHVkaW5nIGRldmljZSBmaWxlIGdldCBjbG9zZSBiZWZvcmUNCj4gdGhlIG1tIGlz
IHRlYXJkb3duLiBCdXQgaW4gYW55Y2FzZSBpdCB3b3VsZCB3b3JrIG5vIG1hdHRlciB3aGF0IHRo
ZSBvcmRlcg0KPiBpcy4NCkkgc2VlLiBJIHdhcyB3b3JyaWVkIGFib3V0IGNvbmN1cnJlbnQgaW52
YWxpZGF0aW9ucyBhbmQgaWJ2X2RlcmVnX21yLCANCmJ1dCBJIHVuZGVyc3RhbmQgaG1tIHByb3Rl
Y3RzIGFnYWluc3QgdGhhdCBpbnRlcm5hbGx5IHRocm91Z2ggdGhlIA0KbWlycm9yc19zZW0gc2Vt
YXBob3JlLg0KDQo+IA0KPj4NCj4+PiBAQCAtNTc4LDExICs1NzgsMjcgQEAgc3RhdGljIGludCBw
YWdlZmF1bHRfbXIoc3RydWN0IG1seDVfaWJfZGV2ICpkZXYsIHN0cnVjdCBtbHg1X2liX21yICpt
ciwNCj4+PiAgIA0KPj4+ICAgbmV4dF9tcjoNCj4+PiAgIAlzaXplID0gbWluX3Qoc2l6ZV90LCBi
Y250LCBpYl91bWVtX2VuZCgmb2RwLT51bWVtKSAtIGlvX3ZpcnQpOw0KPj4+IC0NCj4+PiAgIAlw
YWdlX3NoaWZ0ID0gbXItPnVtZW0tPnBhZ2Vfc2hpZnQ7DQo+Pj4gICAJcGFnZV9tYXNrID0gfihC
SVQocGFnZV9zaGlmdCkgLSAxKTsNCj4+PiArCW9mZiA9IChpb192aXJ0ICYgKH5wYWdlX21hc2sp
KTsNCj4+PiArCXNpemUgKz0gKGlvX3ZpcnQgJiAofnBhZ2VfbWFzaykpOw0KPj4+ICsJaW9fdmly
dCA9IGlvX3ZpcnQgJiBwYWdlX21hc2s7DQo+Pj4gKwlvZmYgKz0gKHNpemUgJiAofnBhZ2VfbWFz
aykpOw0KPj4+ICsJc2l6ZSA9IEFMSUdOKHNpemUsIDFVTCA8PCBwYWdlX3NoaWZ0KTsNCj4+PiAr
DQo+Pj4gKwlpZiAoaW9fdmlydCA8IGliX3VtZW1fc3RhcnQoJm9kcC0+dW1lbSkpDQo+Pj4gKwkJ
cmV0dXJuIC1FSU5WQUw7DQo+Pj4gKw0KPj4+ICAgCXN0YXJ0X2lkeCA9IChpb192aXJ0IC0gKG1y
LT5tbWtleS5pb3ZhICYgcGFnZV9tYXNrKSkgPj4gcGFnZV9zaGlmdDsNCj4+PiAgIA0KPj4+ICsJ
aWYgKG9kcF9tci0+cGVyX21tID09IE5VTEwgfHwgb2RwX21yLT5wZXJfbW0tPm1tID09IE5VTEwp
DQo+Pj4gKwkJcmV0dXJuIC1FTk9FTlQ7DQo+Pj4gKw0KPj4+ICsJcmV0ID0gaG1tX3JhbmdlX3Jl
Z2lzdGVyKCZyYW5nZSwgb2RwX21yLT5wZXJfbW0tPm1tLA0KPj4+ICsJCQkJIGlvX3ZpcnQsIGlv
X3ZpcnQgKyBzaXplLCBwYWdlX3NoaWZ0KTsNCj4+PiArCWlmIChyZXQpDQo+Pj4gKwkJcmV0dXJu
IHJldDsNCj4+PiArDQo+Pj4gICAJaWYgKHByZWZldGNoICYmICFkb3duZ3JhZGUgJiYgIW1yLT51
bWVtLT53cml0YWJsZSkgew0KPj4+ICAgCQkvKiBwcmVmZXRjaCB3aXRoIHdyaXRlLWFjY2VzcyBt
dXN0DQo+Pj4gICAJCSAqIGJlIHN1cHBvcnRlZCBieSB0aGUgTVINCj4+IElzbid0IHRoZXJlIGEg
bWlzdGFrZSBpbiB0aGUgY2FsY3VsYXRpb24gb2YgdGhlIHZhcmlhYmxlIHNpemU/IEl0aXMNCj4+
IGZpcnN0IHNldCB0byB0aGUgc2l6ZSBvZiB0aGUgcGFnZSBmYXVsdCByYW5nZSwgYnV0IHRoZW4g
eW91IGFkZCB0aGUNCj4+IHZpcnR1YWwgYWRkcmVzcywgc28gSSBndWVzcyBpdCBpcyBhY3R1YWxs
eSB0aGUgcmFuZ2UgZW5kLiBUaGVuIHlvdSBwYXNzDQo+PiBpb192aXJ0ICsgc2l6ZSB0byBobW1f
cmFuZ2VfcmVnaXN0ZXIuIERvZXNuJ3QgaXQgZG91YmxlIHRoZSBzaXplIG9mIHRoZQ0KPj4gcmFu
Z2UNCj4gDQo+IE5vIGkgdGhpbmsgaXQgaXMgY29ycmVjdCwgYmNudCBpcyB0aGUgYnl0ZSBjb3Vu
dCB3ZSBhcmUgYXNrIHRvIGZhdWx0LA0KPiB3ZSBhbGlnbiB0aGF0IG9uIHRoZSBtYXhpbXVtIHNp
emUgdGhlIGN1cnJlbnQgbXIgY292ZXJzIChtaW5fdCBhYm92ZSkNCj4gdGhlbiB3ZSBhbGlnbiB3
aXRoIHRoZSBwYWdlIHNpemUgc28gdGhhdCBmYXVsdCBhZGRyZXNzIGlzIHBhZ2UgYWxpZ24uDQpU
aGVyZSBhcmUgdGhyZWUgbGluZXMgdGhhdCB1cGRhdGUgc2l6ZSBhYm92ZSwgbm90IHR3bzoNCiA+
Pj4gICAJc2l6ZSA9IG1pbl90KHNpemVfdCwgYmNudCwgaWJfdW1lbV9lbmQoJm9kcC0+dW1lbSkg
LSBpb192aXJ0KTsNCiA+Pj4gKwlzaXplICs9IChpb192aXJ0ICYgKH5wYWdlX21hc2spKTsNCiA+
Pj4gKwlzaXplID0gQUxJR04oc2l6ZSwgMVVMIDw8IHBhZ2Vfc2hpZnQpOw0KQXMgeW91IHNhaWQs
IHRoZSBmaXJzdCBvbmUgYWxpZ25zIHRvIHRoZSBlbmQgb2YgdGhlIE1SLCB0aGUgdGhpcmQgb25l
IA0KYWxpZ25zIHRvIHBhZ2Ugc2l6ZSwgYnV0IHRoZSBtaWRkbGUgb25lIHNlZW1zIHRvIGFkZCB0
aGUgc3RhcnQuDQoNCj4gaG1tX3JhbmdlX3JlZ2lzdGVyKCkgdGFrZXMgc3RhcnQgYWRkcmVzcyBh
bmQgZW5kIGFkZHJlc3Mgd2hpY2ggaXMgdGhlDQo+IHN0YXJ0IGFkZHJlc3MgKyBzaXplLg0KPiAN
Cj4gb2ZmIGlzIHRoZSBvZmZzZXQgaWUgdGhlIG51bWJlciBvZiBleHRyYSBieXRlIHdlIGFyZSBm
YXVsdGluZyB0byBhbGlnbg0KPiBzdGFydCBvbiBwYWdlIHNpemUuIElmIHRoZXJlIGlzIGEgYnVn
IHRoaXMgbWlnaHQgYmU6DQo+ICAgICAgIG9mZiArPSAoc2l6ZSAmICh+cGFnZV9tYXNrKSk7DQoN
Cm9mZiBpcyB1c2VkIG9ubHkgdG8gY2FsY3VsYXRlIHRoZSBudW1iZXIgb2YgYnl0ZXMgbWFwcGVk
IGluIG9yZGVyIHRvIA0KcHJvY2VlZCB3aXRoIHRoZSBuZXh0IE1SIGluIHRoZSBwYWdlIGZhdWx0
IHdpdGggYW4gdXBkYXRlZCBieXRlIGNvdW50LiBJIA0KdGhpbmsgaXQgc2hvdWxkIGJlDQoJb2Zm
ID0gc3RhcnQgJiB+cGFnZV9tYXNrOw0KbWVhbmluZyBpdCBzaG91bGRuJ3QgYWxzbyBhZGQgaW4g
KGVuZCAmIH5wYWdlX21hc2spLg0KDQpSZWdhcmRzLA0KSGFnZ2FpDQo=
