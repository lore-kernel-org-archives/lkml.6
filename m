Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27B6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF9420832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 20:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0ROX7apq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF9420832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbeK2HiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:38:07 -0500
Received: from mail-eopbgr800083.outbound.protection.outlook.com ([40.107.80.83]:64240
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbeK2HiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 02:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qzi9VsTlAOR0r4Ned5lpoUz0Ac/HVGx4qupDW3uR4Uo=;
 b=0ROX7apqirQCtsz7my1APY6ODpeLCJPNR0e+CMBc+AAHKBkykp1M0eiTctGUIwHXJ3EhscyGKrRaMI0liK8NjlL6KfbAHYz5yu7iovjxIcyk+YnzayCPItKM4JBVidEGwrZo72oaelaEBRCquPdzDRoWeTaXrNZ/lqNFQ6PtFB0=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1292.namprd12.prod.outlook.com (10.168.237.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 20:35:11 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 20:35:11 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/resctrl: fix the uninitialized variable warning
Thread-Topic: [PATCH] x86/resctrl: fix the uninitialized variable warning
Thread-Index: AQHUh1cLHrV+vYgAEUixrLdncIDn7aVlo40AgAAA7MA=
Date:   Wed, 28 Nov 2018 20:35:11 +0000
Message-ID: <DM5PR12MB247105C0A0AF1FCBD77BF96895D10@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181128201450.31820-1-babu.moger@amd.com>
 <20181128202952.GA29570@zn.tnic>
In-Reply-To: <20181128202952.GA29570@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1292;20:QJMapgbXhNVN52icenZ13yZY4t2+W1H+oAYUH5n9fRL5S7xImtypRRniWtAlgnsOMoZyrsVyhQfwzoND3CejK8XJrBvTsxRxih4+xVo4HLNxoWuRqgCG4MP1ush0pAsqoPAKfQ0SXwExWzPMwghne8HXjq0WESxXoDjLSZnXtA8ngmThbM9YyE94WZx1CRARLEEjAgbuATHgtywY6ZOLt8q1pecdmyp5uDkiP4pH8n9MRtxiwHiB0bt730dqlYOM
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 84c8e94d-07a1-4ae9-f7f6-08d65570fe6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1292;
x-ms-traffictypediagnostic: DM5PR12MB1292:
x-microsoft-antispam-prvs: <DM5PR12MB12923B20A0891F1145052BF195D10@DM5PR12MB1292.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1292;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1292;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(13464003)(199004)(189003)(76176011)(86362001)(478600001)(102836004)(105586002)(9686003)(106356001)(7696005)(55016002)(72206003)(97736004)(14454004)(6506007)(53546011)(8936002)(33656002)(186003)(99286004)(68736007)(81156014)(81166006)(8676002)(26005)(53936002)(6246003)(229853002)(6436002)(74316002)(2906002)(66066001)(71200400001)(71190400001)(6916009)(5660300001)(305945005)(476003)(11346002)(486006)(446003)(54906003)(316002)(7736002)(4326008)(3846002)(6116002)(25786009)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1292;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IROQYiRPMcpyOZ5FLgos/MracvB6mzfNGZrSCvrru2IT+0x8YR5VHbAbdMHFTDNXW5eWVZaGvilREgj/o3VmygGANfBaprIVY+OQA8idJW6N3w8WTLbGuyrPIxUptJErNvT2yKwvF61Npg+CaCiLQQFeCSH95CZBng4KJydm32IXuF3CRxq4YtQocvd2Lw51agxbwMMPoRXO+5zwbrJckmo555L8e9kNNT+u13xT/z+ak8ZGaARkVBuJn4IUBKgejV7R/8hLhjlWuibV6nFLJQQLqoYIvW+QvcWKveaLd1ojDmgSBqq1jQfgLUJqGdjSgDoS9lCS6HZrhx/aa3nfPXyl6EFjjxife1JfhSKYiGQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c8e94d-07a1-4ae9-f7f6-08d65570fe6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 20:35:11.1319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm9yaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXNsYXYg
UGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjgsIDIw
MTggMjozMCBQTQ0KPiBUbzogTW9nZXIsIEJhYnUgPEJhYnUuTW9nZXJAYW1kLmNvbT4NCj4gQ2M6
IHRnbHhAbGludXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgaHBhQHp5dG9yLmNvbTsNCj4g
eDg2QGtlcm5lbC5vcmc7IGZlbmdodWEueXVAaW50ZWwuY29tOyByZWluZXR0ZS5jaGF0cmVAaW50
ZWwuY29tOw0KPiBkYW4uY2FycGVudGVyQG9yYWNsZS5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0geDg2L3Jlc2N0cmw6IGZpeCB0aGUgdW5p
bml0aWFsaXplZCB2YXJpYWJsZSB3YXJuaW5nDQo+IA0KPiBPbiBXZWQsIE5vdiAyOCwgMjAxOCBh
dCAwODoxNTowMlBNICswMDAwLCBNb2dlciwgQmFidSB3cm90ZToNCj4gPiBGaXggdGhlIGNvbXBp
bGVyIHdhcm5pbmcgY2F1c2VkIGJ5IGEgcmVjZW50IGNoYW5nZS4NCj4gDQo+IE5vdyB0YWtlIHlv
dXIgdGltZSBtYWNoaW5lLCBzZW5kIHlvdXJzZWxmIDYgbW9udGhzIGludG8gdGhlIGZ1dHVyZSwg
bG9vaw0KPiBhdCB0aGF0IGNvbW1pdCBtZXNzYWdlIGFuZCB0cnkgdG8gcmVtZW1iZXIgd2hhdCBp
dCB3YXMgZml4aW5nLiBDYW4geW91Pw0KPiANCj4gSSBjYW4ndC4NCj4gDQo+IElPVywgcGxlYXNl
IHN1bW1hcml6ZSB3aGF0IHNtYXRjaCAtIHRoZSBzdGF0aWMgY2hlY2tlciBub3QgdGhlIGNvbXBp
bGVyDQo+IC0gd2FzIGNvbXBsYWluaW5nIGFib3V0IGFuZCB3aHkgdGhpcyBpcyBhIGdvb2QgZml4
Lg0KWWVzLiBGb3Jnb3QgdG8gbWVudGlvbi4gU2VudCB2Mi4gSSB3aWxsIG1lbnRpb24gYWJvdXQg
c3RhdGljIGNoZWNrZXIgaW4gdjMuDQoNCj4gDQo+IFRoeC4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMv
R3J1c3MsDQo+ICAgICBCb3Jpcy4NCj4gDQo+IEdvb2QgbWFpbGluZyBwcmFjdGljZXMgZm9yIDQw
MDogYXZvaWQgdG9wLXBvc3RpbmcgYW5kIHRyaW0gdGhlIHJlcGx5Lg0K
