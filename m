Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBCCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC15E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BDja72tk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC15E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeKTGv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 01:51:29 -0500
Received: from mail-eopbgr810051.outbound.protection.outlook.com ([40.107.81.51]:64761
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728938AbeKTGv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 01:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn2N8Vtzm9lYvAF/6PWh7AoXNMTIyeo9B4PgbMynxuM=;
 b=BDja72tkxT8asUWgg3QHn+s5vgtWe0kDrQkzGUU0qsItfin+G8n8fPx/1f2fsIQeLplqZsYxWErlFzVUJd4Da15ty8DFWGZcR5sg8EbezHhyv5lalB2aIIu6HQ3myPu/FIEDHaLsy4VVkop94strzT/c5mimOC3r1I/X1hK848Y=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1147.namprd12.prod.outlook.com (10.168.236.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Mon, 19 Nov 2018 20:26:07 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::7def:eb99:298c:2952%2]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 20:26:07 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 01/13] arch/resctrl: Start renaming the rdt files to
 more generic names
Thread-Topic: [PATCH v8 01/13] arch/resctrl: Start renaming the rdt files to
 more generic names
Thread-Index: AQHUfe6NWz4xLUMToUORxfHJiImFOaVVlD6AgAHnz4D//6uigIAAZ4mAgAABGgA=
Date:   Mon, 19 Nov 2018 20:26:07 +0000
Message-ID: <ab30c05b-aa6f-1528-42da-bdcab7e068c5@amd.com>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-2-babu.moger@amd.com> <20181118140735.GC19380@zn.tnic>
 <alpine.DEB.2.21.1811192012460.1669@nanos.tec.linutronix.de>
 <61f6e553-a72f-bfae-0887-44f066006118@amd.com>
 <20181119202207.GK14688@zn.tnic>
In-Reply-To: <20181119202207.GK14688@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0077.namprd12.prod.outlook.com
 (2603:10b6:802:20::48) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1147;20:ZgFGuEedvD0b+oqBdLTGrLpm1xqoU2bvuJEACN6pc+TliKMWMjrH3spU+LlRL64AbQJI/8nT5wWJmR10HeDPB6SxOouuCNhDYAxdXtxcNOckmW4oKMZf41LpvW7x25GBF7liTan647CX/DunhGhiT+wyn88Iz9t6HyaPe9XJbwjrxKHdO3BXzME2D33jLm4rtiTJkCzwo1uh82qYhc0x69kfYw0AlbzbVQhcLS5B6QeWcN3w7E+j9YzV9H5vMSAr
x-ms-office365-filtering-correlation-id: f602da07-0ce4-488b-7d7f-08d64e5d3c40
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1147;
x-ms-traffictypediagnostic: DM5PR12MB1147:
x-microsoft-antispam-prvs: <DM5PR12MB1147EF6D0173A28307E3B0DD95D80@DM5PR12MB1147.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231436)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1147;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1147;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(51444003)(4326008)(81156014)(53546011)(36756003)(25786009)(6506007)(386003)(97736004)(102836004)(5660300001)(93886005)(68736007)(6246003)(71200400001)(6512007)(256004)(2900100001)(26005)(186003)(71190400001)(8936002)(8676002)(76176011)(99286004)(81166006)(14454004)(53936002)(52116002)(31696002)(105586002)(86362001)(2616005)(486006)(476003)(106356001)(2906002)(11346002)(54906003)(316002)(229853002)(3846002)(6436002)(6116002)(7416002)(7406005)(72206003)(478600001)(305945005)(6486002)(7736002)(31686004)(66066001)(6916009)(446003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1147;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LGeCDe3xaHhuXCxxwn/sLEBchMPM/2UfxMFEle0dw+YVYVOewh53vvSxNfo5n9H+roYCA+zJfWSW+9+76jLDAezgmNYIzKpO97soygstlxA6/fQOVGRfiKuF/2brjyVj+VJsxbtAVWZqvT2de7CYBusylHdeC3jJTPjDeC7Qhj3Mc8drz8yCZ3ux22uRK3kSfNuhC+npOLb2sKYI9HgLxGO94DP4Tlfo6I/LpBh1NSm3V9nFQQA09L+KpJ5zuyKDXsAEoRXAScPAYylOZXhKyW2ijQZeKa4kwxY4EbrPsCj4pxTsbOhih3W9sz1UzIvy7HVnqbf2fA26koRoXPMjrmYEAMI2E4IcQN6qZog/b6s=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C038DE95C064AD47AF28E77951921B21@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f602da07-0ce4-488b-7d7f-08d64e5d3c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 20:26:07.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzE5LzE4IDI6MjIgUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9u
LCBOb3YgMTksIDIwMTggYXQgMDg6MTE6MzZQTSArMDAwMCwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+
PiBDaGFuZ2VkIGNvcmUuYyBhbmQgaW50ZXJuZWwuaCB0byByZXMuYyBhbmQgcmVzLmggcmVzcGVj
dGl2ZWx5LiBCb3RoIG9mDQo+PiB0aGVzZSBmaWxlcyBhcmUgYWJvdXQgcmVzb3VyY2UgZGVmaW5p
dGlvbnMgYW5kIGluaXRpYWxpemF0aW9uLg0KPiANCj4gSSBndWVzcyBidXQgdGhlIGNvcmUuYyB0
aGluZyB3ZSBkbyBhIGxvdCBpbiB0aGUga2VybmVsOg0KPiANCj4gJCBnaXQgbHMtZmlsZXMgfCBn
cmVwIC1FICIvY29yZVwuYyIgfCB3YyAtbA0KPiAxMDANCj4gDQo+IHdoaWNoIGRlbm90ZXMgd2hl
cmUgdGhlIGNvcmUgZnVuY3Rpb25hbGl0eSBpcyBsb2NhdGVkLiByZXMuYw0KPiBkb2Vzbid0IHRl
bGwgbWUgdGhhdC4gcmVzLmggZG9lc24ndCB0ZWxsIG1lIGVpdGhlciB0aGF0IGl0IGlzIGFuDQo+
IHJlc2N0cmwtaW50ZXJuYWwgaGVhZGVyLi4uDQo+IA0KPiBJT1csIGNhbGxpbmcgaXQgY29yZS5j
IGFuZCBpbnRlcm5hbC5oIGdpdmVzIHlvdSBhbiBhZGRpdGlvbmFsDQo+IGluZm9ybWF0aW9uIHdo
YXQgdGhvc2UgZmlsZXMgY29udGFpbi4gQW5kIEkgdGhpbmsgdGhhdCdzIHVzZWZ1bC4NCg0KT2su
IEZpbmUuIFdpbGwga2VlcCBpdCBhcyBjb3JlLmMgYW5kIGludGVybmVsLmguDQo=
