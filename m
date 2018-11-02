Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0771C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8978C2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ucOlCrJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8978C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeKBXOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:14:52 -0400
Received: from mail-eopbgr730044.outbound.protection.outlook.com ([40.107.73.44]:46912
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbeKBXOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K4B/MoSuoU7A3MjjwT5e6wdlngnOyzcePU4Qd9QdCE=;
 b=ucOlCrJVB2J34F3pX4A4TTH98jnN647m6Bw6yXCLpHulJohOQbwP13PVRyCKn0TsTlBeUvq8qDlDEBIfFlRK353YKTQA2PnlLCFhTe2hIu0+vdNWP4mKa1TEssZLV+KHBqjJ28+iNST6RuvO1ucj7asFGCeDIvYI+RL2RlgBOn8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1130.namprd12.prod.outlook.com (10.168.236.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Fri, 2 Nov 2018 14:07:28 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%4]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 14:07:28 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Jon Masters <jcm@jonmasters.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/11] arch/x86: AMD QoS support
Thread-Topic: [PATCH v2 00/11] arch/x86: AMD QoS support
Thread-Index: AQHUXO3CTn+1tr8+o06JtjDxs0CMcKU8NM8AgAB55IA=
Date:   Fri, 2 Nov 2018 14:07:28 +0000
Message-ID: <DM5PR12MB2471CBFC505B18288C1443BD95CF0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <20181005205512.29545-1-babu.moger@amd.com>
 <9e6f6616-5c79-80a3-7d83-a675683c6924@jonmasters.org>
In-Reply-To: <9e6f6616-5c79-80a3-7d83-a675683c6924@jonmasters.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1130;20:UxYUEsYEh3hEavqFWW+dPjBIsPtEDNoAhKt8/B9gGHC4ETB6GIUsV/JrDwtZ3u/XZd+jswUKoDIShE8N5AIEeszfUmkb6YvJuK6fCofDH6LyV+HMu8iKaMn/CpaSP/ZZ/Wv2nQ5FecXGQnSrS3YHahhCd66fmMxuszhdO3TrDIqNNWCX+MpL8JzqbBDYbJKuMoWtAQHMQKFR4soAVx8BlIsypkcYwYX6fih9VMid/VH8xWaJc/u5dS387JGBKXGC
x-ms-office365-filtering-correlation-id: 526505e4-1427-457f-6715-08d640cc8622
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1130;
x-ms-traffictypediagnostic: DM5PR12MB1130:
x-microsoft-antispam-prvs: <DM5PR12MB1130A4A9E21ABD56918039F595CF0@DM5PR12MB1130.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699)(180628864354917)(198206253151910)(146755900322472)(211936372134217)(95223839027130)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1130;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1130;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(396003)(39860400002)(366004)(13464003)(199004)(189003)(7736002)(446003)(8936002)(81156014)(81166006)(25786009)(8676002)(4326008)(102836004)(74316002)(68736007)(11346002)(476003)(7416002)(26005)(966005)(5660300001)(33656002)(6436002)(2900100001)(2501003)(256004)(9686003)(6116002)(6306002)(6246003)(14454004)(110136005)(53936002)(54906003)(55016002)(3846002)(105586002)(106356001)(71200400001)(478600001)(86362001)(2201001)(71190400001)(99286004)(186003)(76176011)(7696005)(229853002)(66066001)(316002)(53546011)(6506007)(97736004)(486006)(2906002)(72206003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1130;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /gQf9D4WQiiu81RzrUGyqSfdBl8PsuT0vuQwySvxez0/UGPv70O1C7ebX8YCDDr3qmh/nq4xyy+73Nxh9QQDXLuN5j2ftfJAl2tYi2xSiqb8zl7V0qENi9rqw44Wifc4V1Uq9KsEDG1tHfW6dQ9LqTQj2Nw6eFLDELq+zSk7276ZefBbMI3KBv6ZRmDmDfpem2OJb/ZQiqMXMRxCurRsKPFBjk91+Y1HgUZp25XtbMYxJxYv+Xxddbjryz/swEzE5qtUrsm2h1qhEnI7jp1L2R+0JFsPZ8ViB3Gz2u/HQ6OphptLhfGLhXzC0DGLopKVuUhHsWN3P2C3T7hp8Nlp6qK7/gnCIedBoZ1PpGBEbIE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526505e4-1427-457f-6715-08d640cc8622
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 14:07:28.5149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LWtlcm5l
bC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbC0NCj4gb3duZXJAdmdlci5rZXJu
ZWwub3JnPiBPbiBCZWhhbGYgT2YgSm9uIE1hc3RlcnMNCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJl
ciAyLCAyMDE4IDE6NDMgQU0NCj4gVG86IE1vZ2VyLCBCYWJ1IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+
OyB0Z2x4QGxpbnV0cm9uaXguZGU7DQo+IG1pbmdvQHJlZGhhdC5jb207IGhwYUB6eXRvci5jb207
IHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb207DQo+IGZlbmdodWEueXVAaW50ZWwuY29tOyBqYW1l
cy5tb3JzZUBhcm0uY29tOw0KPiB2aWthcy5zaGl2YXBwYUBsaW51eC5pbnRlbC5jb207IHRvbnku
bHVja0BpbnRlbC5jb20NCj4gQ2M6IHg4NkBrZXJuZWwub3JnOyBwZXRlcnpAaW5mcmFkZWFkLm9y
ZzsgcG9tYnJlZGFubmVAbmV4Yi5jb207DQo+IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBr
c3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnOyBicEBzdXNlLmRlOw0KPiByYWZhZWwuai53eXNv
Y2tpQGludGVsLmNvbTsgYWtAbGludXguaW50ZWwuY29tOw0KPiBraXJpbGwuc2h1dGVtb3ZAbGlu
dXguaW50ZWwuY29tOyB4aWFvY2hlbi5zaGVuQGludGVsLmNvbTsNCj4gY29saW4ua2luZ0BjYW5v
bmljYWwuY29tOyBIdXJ3aXR6LCBTaGVycnkgPHNoZXJyeS5odXJ3aXR6QGFtZC5jb20+Ow0KPiBM
ZW5kYWNreSwgVGhvbWFzIDxUaG9tYXMuTGVuZGFja3lAYW1kLmNvbT47IHBib256aW5pQHJlZGhh
dC5jb207DQo+IGR3bXdAYW1hem9uLmNvLnVrOyBsdXRvQGtlcm5lbC5vcmc7IGpyb2VkZWxAc3Vz
ZS5kZTsNCj4gamFubmhAZ29vZ2xlLmNvbTsgZGltYUBhcmlzdGEuY29tOyBqcG9pbWJvZUByZWRo
YXQuY29tOw0KPiB2a3V6bmV0c0ByZWRoYXQuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDAvMTFdIGFyY2gveDg2OiBBTUQgUW9TIHN1
cHBvcnQNCj4gDQo+IE9uIDEwLzUvMTggNDo1NSBQTSwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+IA0K
PiA+IFRoZSBwdWJsaWMgc3BlY2lmaWNhdGlvbiBmb3IgdGhpcyBmZWF0dXJlIGlzIGF2YWlsYWJs
ZSBhdA0KPiA+DQo+IGh0dHBzOi8vd3d3LmFtZC5jb20vc3lzdGVtL2ZpbGVzL1RlY2hEb2NzLzU2
Mzc1X1F1YWxpdHlfb2ZfU2VydmljZV9FDQo+IHh0ZW5zaW9ucy5wZGYNCj4gDQo+IDQwNCBlcnJv
cg0KU29ycnkgYWJvdXQgdGhhdC4gV2UgaGF2ZSBmaXhlZCB0aGUgbGluayBpbiB2NS4NCiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTgxMDE4MjI1MTI0LjIzMDQzLTEtYmFidS5tb2dl
ckBhbWQuY29tLw0KSGVyZSBpcyB0aGUgY29ycmVjdCBsaW5rLg0KaHR0cHM6Ly9kZXZlbG9wZXIu
YW1kLmNvbS93cC1jb250ZW50L3Jlc291cmNlcy81NjM3NS5wZGYNCg==
