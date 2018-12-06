Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E16C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A843520850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A843520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeLFR2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:28:46 -0500
Received: from mail-eopbgr720045.outbound.protection.outlook.com ([40.107.72.45]:61725
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbeLFR2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XBQ+4SnQRlhRS5/OWwachcQtQlrzm2YxRqyT/qEnNc=;
 b=oWZXu7kw/0tIuVo3HeIbFvDueaL8mWNVArG2mNGgwPdEIUxmi3moxud8PnV7zHK6DHatFTLN+z1c9lGDhmBGVYRGYam/6f4Ra7OozKQbyfvvfyR9sCT0f9vZgE+seC5gmlGybzRM8zWiezCcSeGJCfCYMYIdKu6NHFAxdY5S8nA=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4597.namprd05.prod.outlook.com (52.135.233.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.8; Thu, 6 Dec 2018 17:28:40 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%3]) with mapi id 15.20.1425.006; Thu, 6 Dec 2018
 17:28:40 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Damian Tometzki <linux_dti@icloud.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Thread-Topic: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Thread-Index: AQHUjHgCm5HQo9wG+kmVhMEM5+sZ86VxezGAgAB+H4A=
Date:   Thu, 6 Dec 2018 17:28:40 +0000
Message-ID: <8CEBF480-E245-4F7E-A683-D95057CAFFF7@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-14-namit@vmware.com>
 <20181206095715.GD13538@hirez.programming.kicks-ass.net>
In-Reply-To: <20181206095715.GD13538@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4597;20:yecqnb4W5fsycEQkTVk+zFSs/Mz16weOmByJElkxo1yJ3f/H5iLLGavjdw7D5ZLzfBzv+99mq5ONpMmH9Yfscv1lRAKGb8mlHJVnG3zBtyjH7eiMzMGifN2ZQqdrBlxZgJxeLOUjFXfXuliATv70Vc2X3WSyC5GSZqC5srUOrBQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 246abe56-4e2e-44e4-c8fc-08d65ba043aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4597;
x-ms-traffictypediagnostic: BYAPR05MB4597:
x-microsoft-antispam-prvs: <BYAPR05MB45978F55E260FD0E010BF705D0A90@BYAPR05MB4597.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231455)(999002)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4597;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4597;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39860400002)(136003)(189003)(199004)(8676002)(6116002)(8936002)(54906003)(99286004)(36756003)(33656002)(2906002)(81166006)(81156014)(316002)(106356001)(76176011)(478600001)(53546011)(4326008)(6506007)(5660300001)(102836004)(2616005)(446003)(6916009)(6512007)(7416002)(26005)(256004)(6486002)(476003)(105586002)(6436002)(11346002)(14454004)(186003)(66066001)(83716004)(486006)(39060400002)(53936002)(86362001)(25786009)(6246003)(7736002)(229853002)(305945005)(71190400001)(71200400001)(97736004)(68736007)(3846002)(82746002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4597;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hAy4Utu9SEL8gTre/Ah0eHCUXIq0HDthVFPrAbpj3gFBbgpbMfzj2fM07fw6lieR+AovhesR+mjPm+DGMeRG+YuyECf73KlNcR63E0ij2KRIJEE0cacYRiqCxy2eoCqBgq9YLj7rcUiGckw7ZFwU2D4/YIsYsp5lvxBuHlcfHGLxMP6/fhGD06DzyPT85VlYhx7HPqciu4nBHI9JES6xa22gyScu7EwUAWJZ0LtE1We6n1l22X+RjlXtzJ2Nnvsgnc4T6PywIUzjiM+7HDhJj/Gc9JQRD+iVP2DAQ9gNlKLmulU9pYplXRe+gqp0wBmZFDjfVE+LBDth0Q36kNVOUOc5wlxLrAbkFUFtSFTQ6zQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <16618B2CAF578949881C829868F3E8D3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246abe56-4e2e-44e4-c8fc-08d65ba043aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 17:28:40.5633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBEZWMgNiwgMjAxOCwgYXQgMTo1NyBBTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgRGVjIDA0LCAyMDE4IGF0IDA1OjM0OjA3
UE0gLTA4MDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+IA0KPj4gU28gbGV0J3MgcmVtb3ZlIGl0LiBB
bmR5IHN1Z2dlc3RlZCB0aGF0IHRoZSBjaGFuZ2VzIG9mIHRoZSBQVEVzIGNhbiBiZQ0KPj4gYXZv
aWRlZCAoZXhjbHVkaW5nIHRoZSBkaXJlY3QtbWFwcGluZyBhbGlhcyksIHdoaWNoIGlzIHRydWUu
IEhvd2V2ZXIsDQo+PiBpbiB4ODYgaXQgcmVxdWlyZXMgc29tZSBjbGVhbnVwIG9mIHRoZSBjb250
aWd1b3VzIHBhZ2UgYWxsb2NhdG9yLCB3aGljaA0KPj4gaXMgb3V0c2lkZSBvZiB0aGUgc2NvcGUg
b2YgdGhpcyBwYXRjaC1zZXQuDQo+IA0KPiBJIHRoaW5rIHg4Ni1jcGEgc3RhbmRzIGZvciBjaGFu
Z2VfcGFnZV9hdHRyKCkgOi0pDQoNClRoYW5rcyAtIGl0IG1ha2VzIG11Y2ggbW9yZSBzZW5zZeKA
piBJIHRvb2sgdGhlIGZpcnN0IHRoaW5nIHRoYXQgR29vZ2xlDQpzaG93ZWQuDQoNCg==
