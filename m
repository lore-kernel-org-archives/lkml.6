Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A5DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C575620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="onxOngvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C575620839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeLLOEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:04:40 -0500
Received: from mail-eopbgr780083.outbound.protection.outlook.com ([40.107.78.83]:50400
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726649AbeLLOEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgLYNmLtgbI4U7XUk/htPAb4irqmZ3BhasZ6OtxTcys=;
 b=onxOngvQUQ6k93cGM0svi6ih20JwADnOOKeVIWfTgP2akIlWO/1ja29m7GA5LfnU8e9WOKr1sNYoewv6ZJzHdN9uwXyxLYu0Clu7xL1ZRmAZEGlGUCaKX+92MYlKhqY6zDXmEhLSdebQG4M3RWp/2mTS37SITrh6SXJh1HasS4k=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0238.namprd12.prod.outlook.com (10.162.3.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 14:04:35 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 14:04:35 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
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
Thread-Index: AQHUkaNTNctPywnCTEqVxIZjhKo+laV6OXQAgAA7RQCAAGrJAIAARG6A
Date:   Wed, 12 Dec 2018 14:04:35 +0000
Message-ID: <be031a74-44d0-1fea-893a-bfdf3ba1655f@amd.com>
References: <20181211224615.5373.65736.stgit@tlendack-t1.amdoffice.net>
 <20181212000518.GX27375@zn.tnic>
 <alpine.DEB.2.21.1812111910520.22893@nanos.tec.linutronix.de>
 <20181212095938.GA6653@zn.tnic>
In-Reply-To: <20181212095938.GA6653@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:805:66::39) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0238;20:WUTk+8U0Ehy5gDGxviOuD2OT2MnO/2gOnd4AJcWf5zn1s2FmDSEhoWjTLz79W7vGa0/m/AfS7gldTnpdLxfC7mGAhNDUp7a5FGKi4+pu3Z2dKW89d7uOR9Byw9q2nfQIMlB6aYj6/9/UdsA+svSgBvF9eG+a9ZdAIk+XGsw4Os+g751ULviNBIRAcgtYwWzIp2ehOOacniEhved9EEp2ccDE6MWupvJyV2fUdukz7K6G9NkbD6kpK+f89LO8aM3H
x-ms-office365-filtering-correlation-id: 4a70773f-c425-498c-9e0b-08d6603abf51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0238;
x-ms-traffictypediagnostic: SN1PR12MB0238:
x-microsoft-antispam-prvs: <SN1PR12MB023871EF17E00BA7E6A497F5ECA70@SN1PR12MB0238.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0238;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0238;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(53546011)(446003)(99286004)(305945005)(86362001)(66066001)(2906002)(8936002)(53936002)(7736002)(26005)(102836004)(186003)(106356001)(5660300001)(386003)(4326008)(31696002)(6512007)(6306002)(478600001)(7416002)(6246003)(476003)(229853002)(256004)(316002)(6436002)(93886005)(110136005)(6506007)(8676002)(105586002)(52116002)(486006)(71190400001)(71200400001)(966005)(6486002)(6116002)(54906003)(72206003)(3846002)(11346002)(81166006)(25786009)(68736007)(31686004)(97736004)(36756003)(76176011)(14454004)(2616005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0238;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sn5a08WJhCmttKTgAOw9JLccFV9oVvZXZhpDVEHwCE4IVH0DJxBJhVj+tqDvvtcpzLAT+GSO6ABvJc4J0znkr7mtYQB+mkLSs0FHRS0+kYzQwkS8ZUuEVo6TuaTb47qK0/h5AEcXTB+UlurgW7PY1OpSdUs2+xSGqASzm2V3dYPLN79byeSIFWoLlpENPKN3uV3BYi+1eRD62NmrCfFykWHIeYeAAxBDT9s4HltMw605bo2SZMaoXkyA1QTrzzdKZ+oZeCorVmEwugFEFon8D7q54PneBR1Sm69Q2WhpNQcTwdlqtakeD5yTSNvMAZJs
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B627228E7511A4FAFF20314D3EC4535@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a70773f-c425-498c-9e0b-08d6603abf51
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 14:04:35.7523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTIvMjAxOCAwMzo1OSBBTSwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPiBPbiBUdWUs
IERlYyAxMSwgMjAxOCBhdCAwNzozNzoyNlBNIC0wODAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+PiBIbW1tLiBJJ3ZlIG5vdCBzZWVuIHRoZSBWMSBvZiB0aGlzIChpdCdzIG5vdCBpbiBteSBp
bmJveCkgYnV0IHRoZSB2MS0+djINCj4+IGNoYW5nZXMgY29udGFpbjoNCj4gDQo+IFlvdSdyZSBv
biBDQzoNCj4gDQo+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxODEyMTExOTA5NTkuMjgz
MjEuNTY0MzMuc3RnaXRAdGxlbmRhY2stdDEuYW1kb2ZmaWNlLm5ldA0KPiANCj4+DQo+Pj4+IC0g
UmVtb3ZlZCBleHBsaWNpdCBTUEVDVFJFX1YyX1VTRVJfU1RSSUNUX1BSRUZFUlJFRCBtb2RlDQo+
Pg0KPj4gTm93IEkgcmVhbGx5IGhhdmUgdG8gYXNrIHdoeT8NCj4+DQo+PiBOZWl0aGVyIHRoZSBl
eHRyYSB2YXJpYWJsZSBub3IgdGhlIGNwdSBmZWF0dXJlIGNoZWNrIGFyZSBwcmV0dHkuIEFuDQo+
PiBleHBsaWNpdCBtb2RlIGlzIHdheSBiZXR0ZXIgaW4gdGVybXMgb2YgY29kZSBjbGFyaXR5IGFu
ZCB5b3UgZ2V0IHRoZSBwcm9wZXINCj4+IHByaW50b3V0IHZpYSBzcGVjdHJlX3YyX3VzZXJfc3Ry
aW5ncy4NCj4gDQo+IEFjdHVhbGx5LCBub3cgdGhhdCBJJ3ZlIHNsZXB0IG9uIGl0LCBJIHRoaW5r
IHdlIHNob3VsZCBkbyB0aGlzIGp1c3QNCj4gbGlrZSBYODZfRkVBVFVSRV9JQlJTX0VOSEFOQ0VE
IC0gYXMgYSBtb2RpZmllciBmb3IgU1BFQ1RSRV9WMl9DTURfQVVUTw0KPiBvciBfRk9SQ0Ugb3B0
aW9ucy4NCj4gDQo+IEFuZCB0aGF0IGhhcyBpdHMgb3duIG1vZGUgU1BFQ1RSRV9WMl9JQlJTX0VO
SEFOQ0VELg0KPiANCj4gTWFrZXMgc2Vuc2U/DQoNCk5vdCBzdXJlIEkgY29tcGxldGVseSBmb2xs
b3cuIEFyZSB5b3Ugc2F5aW5nIHRvIGRvIHdoYXQgSSBkaWQgaW4gbXkNCmZpcnN0IHBhdGNoIG9y
IHNvbWV0aGluZyBkaWZmZXJlbnQgZnJvbSB0aGF0IHlldD8NCg0KVGhhbmtzLA0KVG9tDQoNCj4g
DQo=
