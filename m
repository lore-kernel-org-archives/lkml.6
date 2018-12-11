Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25CFC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7C12084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="M/r+trmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7C12084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLKWRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:17:38 -0500
Received: from mail-eopbgr770059.outbound.protection.outlook.com ([40.107.77.59]:15088
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbeLKWRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpQzmwVikPnf2RwcbsU0/0KgaQNoCfB7LknbNQI8AxM=;
 b=M/r+trmbOHAoaaeauYbshx9XjeSIN4WFJAmbpxQPmlvsYUzmEqNrcPukusSlOmbO4lVUtVfvhBmFxodp/DyKU7D7PntvA389yPTnBLx+tRHi/lQS81EY1FJwCHW/wFrbfaXEUCIlweQCa1t+PLPXE9whSWezElEm7KDPbJ89R2s=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0238.namprd12.prod.outlook.com (10.162.3.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Tue, 11 Dec 2018 22:17:31 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Tue, 11 Dec 2018
 22:17:31 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Topic: [PATCH] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Index: AQHUkYUdUUqHSw55jUaGOaWlduXUMaV5hSQAgACGSgCAABAjgA==
Date:   Tue, 11 Dec 2018 22:17:30 +0000
Message-ID: <d054e17f-87e4-a8cc-425c-f56b9c6d4588@amd.com>
References: <20181211190959.28321.56433.stgit@tlendack-t1.amdoffice.net>
 <3308b5d2-0c59-fa33-472b-f56633d39575@amd.com>
 <20181211211944.GT27375@zn.tnic>
In-Reply-To: <20181211211944.GT27375@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:805:8e::45) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0238;20:ZwRg3cJdzTtHXN+DpwMdeOoIJ+2vq0kANC7oyjs2uen5GfkpVC3tdZsPxCsIlURKsr1pEze3UH3Ch1YQ9WY5v/uQLuZ4M976ae2rTP0ooBI5TAnQeS3GpV8jNZugKs+xwuA3EV7qCDD29D7JTJqVbcEqZtcbyzdFVCULQVRAeL5nVOTBx2bKtqoh+IN3ytdBOmWM40dIFqZnlaA5kyX75oyAGKLIjGKNrUous/11QTshINMfxWVDlwcUqwiTpqXA
x-ms-office365-filtering-correlation-id: cb60a0b4-ee79-45bd-ac06-08d65fb67110
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0238;
x-ms-traffictypediagnostic: SN1PR12MB0238:
x-microsoft-antispam-prvs: <SN1PR12MB023801830BC01904BB17AF0BECA60@SN1PR12MB0238.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0238;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0238;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(199004)(189003)(99286004)(478600001)(305945005)(8936002)(53936002)(86362001)(66066001)(2906002)(7736002)(26005)(102836004)(6916009)(186003)(106356001)(5660300001)(53546011)(6506007)(386003)(4326008)(31696002)(7416002)(6512007)(6246003)(229853002)(256004)(316002)(6436002)(105586002)(8676002)(97736004)(486006)(71190400001)(71200400001)(52116002)(476003)(6486002)(3846002)(72206003)(6116002)(54906003)(81156014)(11346002)(25786009)(81166006)(76176011)(31686004)(36756003)(68736007)(2616005)(446003)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0238;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: C7ltUSdCJYD6AVKqKPUGY/Zs58Bv0UQiS61jhg0bVZzkKkF99kIND0w4q/Cn/Ggoma53jhf+jEPlZcEhZCsOFVXYckJfJU0RTGH8f4ntDPxWpGSgDAIVfIwRBFMZKRc30BO7IdQAr8aBi/GQG8yiwlG5tKldfINuRs99Y5vgtF/H0nb61mYCkJfNuADZaS+vXycAfWpu1+nLCN7EjRFjfrYnh/CnnRsmRAzW6tHTDkSq3Pq9OnnaKRhx5aIhgDHWkrrCj6kx90g3PrL1+Bx8BL4DTIVuBZSgjyBNg+Me7FKY/ISLVxcCLBhU2Uu9vFx1
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <42DEA73DD3428C4684C1C176EA5A5AA9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb60a0b4-ee79-45bd-ac06-08d65fb67110
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 22:17:31.1013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTEvMjAxOCAwMzoxOSBQTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBUdWUs
IERlYyAxMSwgMjAxOCBhdCAwNzoxOTowOVBNICswMDAwLCBMZW5kYWNreSwgVGhvbWFzIHdyb3Rl
Og0KPj4gQWx0ZXJuYXRpdmVseSwgSSBjYW4gcmV1c2UgU1BFQ1RSRV9WMl9VU0VSX1NUUklDVCBh
bmQgaXNzdWUgcHJfaW5mb19vbmNlKCkNCj4+IHRvIHNob3cgdGhhdCB0aGUgbWV0aG9kIGhhcyBi
ZWVuIHN3aXRjaGVkLiAgVGhpcyB3b3VsZCByZWR1Y2UgdGhlIGNoYW5nZXMNCj4+IHRvIHRoZSBj
b2RlLCBidXQgdGhlbiB0aGUgc3lzZnMgaW5mb3JtYXRpb24gZG9lc24ndCBzaG93IHRoZSBzd2l0
Y2ggKHdoaWNoDQo+PiBtYXkgYmUganVzdCBmaW5lKS4NCj4gDQo+IFlvdSBjYW4gc3RpbGwgcXVl
cnkgWDg2X0ZFQVRVUkVfQU1EX1NUSUJQX0FMV0FZU19PTiBpbiBzdGlicF9zdGF0ZSgpLA0KPiBu
bz8NCg0KSWYgdXNpbmcganVzdCBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUIHRoZW4gdGhlIGNvZGUg
aW4gc3RpYnBfc3RhdGUoKSB3b3VsZA0KaGF2ZSB0byBiZSBhYmxlIGRpZmZlcmVudGlhdGUgYmV0
d2VlbiB0aGUgY2FzZSB3aGVyZSB0aGUgbW9kZSB3YXMgc3dpdGNoZWQNCmJlY2F1c2Ugb2YgWDg2
X0ZFQVRVUkVfQU1EX1NUSUJQX0FMV0FZU19PTiB2cyBhIGtlcm5lbCBjb21tYW5kIGxpbmUgd2l0
aA0KInNwZWN0cmVfdjJfdXNlcj1vbiIuIEkgY291bGQgYWx3YXlzIHNldCBhbmQgdXNlIGEgc3Rh
dGljIHZhcmlhYmxlIGluIHRoZQ0KZmlsZSBqdXN0IGZvciB0aGUgc3RpYnBfc3RhdGUoKSBjYXNl
Lg0KDQo+IA0KPiBCdXQgeWVhaCwgZm9yY2luZyBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUIG9uIFNU
SUJQX0FMV0FZU19PTiBtYWtlcyBzZW5zZQ0KPiB0byBtZSwgd2l0aCB0aGUgYWxyZWFkeSBnYXpp
bGxpb24gb3B0aW9ucyB3ZSBoYXZlIDotXA0KDQpJJ2xsIGdpdmUgaXQgYSBiaXQgb2YgdGltZSBh
bmQgc2VlIGlmIHRoZXJlJ3MgYW55IG90aGVyIGRpc2N1c3Npb24gYW5kDQpyZS1zdWJtaXQgd2l0
aG91dCB0aGUgbmV3IFNQRUNUUkVfVjJfVVNFUl9TVFJJQ1RfUFJFRkVSUkVEIHZhbHVlLg0KDQpU
aGFua3MsDQpUb20NCg0KPiANCg==
