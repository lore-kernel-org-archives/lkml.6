Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8F6C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0CC20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UFfXdqyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0CC20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeLLPBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:01:55 -0500
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:37152
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727636AbeLLPBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwgLYwYMOD120XWZcSCSItD5OLblTBtWUxuaAnH5lGE=;
 b=UFfXdqyTCTLgpSrfxhQBzV2sPf0M3aodvWAuaFRcooVyILur+V+RH3pIe67ZdWUA/8B9UuitbTjpFtyRDrDq11i2BwgaRphtu5whP8wt7hlht8KbCrJ++wSD4SkmU8lPjDlo7v0YQS/vYyjglu5x3P4H8ox561mFR5jSsfbHC6o=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB2415.namprd12.prod.outlook.com (52.132.195.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 12 Dec 2018 15:01:51 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 15:01:51 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Topic: [PATCH v2] x86/speculation: Add support for STIBP always-on
 preferred mode
Thread-Index: AQHUkaNTNctPywnCTEqVxIZjhKo+laV6OXQAgAA7RQCAAGrJAP//39mAgABsbICAAAgoAA==
Date:   Wed, 12 Dec 2018 15:01:50 +0000
Message-ID: <5b183bfd-8ef7-2e83-3b2e-c2d889f56b38@amd.com>
References: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net>
 <20181212000518.GX27375@zn.tnic>
 <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de>
 <20181212095938.GA6653@zn.tnic>
 <be031a74-44d0-1fea-893a-bfdf3ba1655f@amd.com>
 <8B17355F-0AE0-4E3A-BFF5-120AB739DB8C@alien8.de>
In-Reply-To: <8B17355F-0AE0-4E3A-BFF5-120AB739DB8C@alien8.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0048.prod.exchangelabs.com (2603:10b6:800::16) To
 SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2415;20:2Jz1AB3X0Xq2yO/N8cAocJvrdeJKrNN/GPdhJW+zKn2bz7CEaIG6po1x8ta6yJZxkk+4NS/DTFprQq4cUHWoLt87AsvERMQuLjCOS0z5g9VtspYBp9LZAyGsbGudKDSW407Cq6wqkeGKBD854HYfmA5Z7TRPS4PKL/jIYBxqNfl4w+H4J7rJFe7MuNgt7sqUZukGXJiYBheIajY4kjQHWePpPOFDRlww1Eoa6l1evODfV+zQ0h52Ze55rIOO4G2j
x-ms-office365-filtering-correlation-id: 98a3c880-e70f-47f6-a390-08d66042bec1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2415;
x-ms-traffictypediagnostic: SN1PR12MB2415:
x-microsoft-antispam-prvs: <SN1PR12MB2415EAE518D2EA7241048222ECA70@SN1PR12MB2415.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231472)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB2415;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2415;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(199004)(53546011)(305945005)(36756003)(3846002)(6246003)(8936002)(6512007)(7416002)(4326008)(5660300001)(53936002)(14454004)(81166006)(8676002)(81156014)(256004)(14444005)(486006)(93886005)(316002)(476003)(25786009)(11346002)(2616005)(97736004)(6436002)(71190400001)(105586002)(66066001)(71200400001)(54906003)(106356001)(68736007)(6486002)(110136005)(7736002)(31686004)(478600001)(72206003)(229853002)(99286004)(31696002)(86362001)(186003)(386003)(102836004)(2906002)(76176011)(446003)(6506007)(52116002)(26005)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2415;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kDqSTBzGdFlqkuY4ZngpmjVaARrl4JqVeCS3+OFGUO52nHgRWXDddwDD5g4b2aIXwSXtql8yHuyCSvezXF0itsMh9BkHPlALSn4fMlC3AOxRBAfcJ1mpGncJOVp9/x1Ak0j7P7lQq4pwWjkj99wm5BiLCG9YShUo7iJoy5LSvFEZCZtcwIoifuiMsQaNAmIQSy/+K196oTpW35FxBaXvVJnrvO3URicb2lIeEUwXLvKtEs6dYS8JvaEvQBTsCPoimjoGwprmbb35a0hfgFoaehhFCisF+G/kYz6fi8LU6Xhuv57XgCEWwvzcreEebhEi
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <A017C04B02AA9348AAEE353B7AE829E3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a3c880-e70f-47f6-a390-08d66042bec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 15:01:50.8286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTIvMjAxOCAwODozMiBBTSwgQm9yaXMgUGV0a292IHdyb3RlOg0KPiBPbiBEZWNlbWJl
ciAxMiwgMjAxOCAzOjA0OjM1IFBNIEdNVCswMTowMCwgIkxlbmRhY2t5LCBUaG9tYXMiIDxUaG9t
YXMuTGVuZGFja3lAYW1kLmNvbT4gd3JvdGU6DQo+PiBOb3Qgc3VyZSBJIGNvbXBsZXRlbHkgZm9s
bG93LiBBcmUgeW91IHNheWluZyB0byBkbyB3aGF0IEkgZGlkIGluIG15DQo+PiBmaXJzdCBwYXRj
aCBvciBzb21ldGhpbmcgZGlmZmVyZW50IGZyb20gdGhhdCB5ZXQ/DQo+IA0KPiBJJ20gc2F5aW5n
IHRoYXQgU1RJQlBfQUxXQVlTX09OIHNob3VsZCBiZSBpbXBsZW1lbnRlZCB0aGUgc2FtZSB3YXkg
bGlrZSBJQlJTX0VOSEFOQ0VEIGlzIGFuZCB0aGVyZSdzIG5vIG5lZWQgZm9yIGEgc3RhdGljIGJv
b2wuIEFGQUlDVC4NCj4gDQo+IE9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmc/IA0KDQpPaywgSSB0
aGluayB5b3UncmUgc2F5aW5nIHRvIGRvIHdoYXQgbXkgZmlyc3QgcGF0Y2ggZGlkIG9yIHNvbWV0
aGluZyB2ZXJ5DQpjbG9zZSB0byB0aGF0LiBXaGljaCBpcyB0byBqdXN0IHNldCBhbHdheXMtb24g
bW9kZSBpZiBTVElCUCBwcm90ZWN0aW9uIGlzDQpyZXF1ZXN0ZWQgYW5kIHRoZSBTVElCUF9BTFdB
WVNfT04gQ1BVSUQgYml0IGlzIHNldCAoZXZlbiBpZiB0aGUgZXF1aXZhbGVudA0KIj1vbiIgaXMg
c3VwcGxpZWQgb24gdGhlIGNvbW1hbmQgbGluZT8pLiBUaGF0IHdvdWxkIG1lYW4gaGF2aW5nIHRo
ZSBuZXcNCm1vZGUgYW5kIG5ldyBzdHJpbmcocykuDQoNCklmIHRoYXQncyBub3Qgd2hhdCB5b3Un
cmUgc2F5aW5nLCB0aGVuIG1heWJlIEkganVzdCBuZWVkIG1vcmUgY29mZmVlIHRoaXMNCm1vcm5p
bmcgOikNCg0KVGhhbmtzLA0KVG9tDQoNCj4gDQo=
