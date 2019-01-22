Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63D7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4FB20854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xmqHmAe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfAVPxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:53:22 -0500
Received: from mail-eopbgr750055.outbound.protection.outlook.com ([40.107.75.55]:47252
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728734AbfAVPxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9a7DqzM0nvk7/x2Qi6fcQDuoz2vHSHi+WdJdv0RVXUQ=;
 b=xmqHmAe1MK4Oe5zKPdvkW/c0gOGldg3h0JbBa0CUHUmx6buZyvBT9GXu3Cn3+TkbbEZcYpQjiR0gBEH6bbMrxZGDN60svYAlBksR97uHrRh1m3YgekWH10KfCHTSeu/AVSo7JUbCZUF9CyS4S8JLypLyaQSzxqH2SBhAm2owzZQ=
Received: from DM6PR12MB2844.namprd12.prod.outlook.com (20.176.117.96) by
 DM6PR12MB2715.namprd12.prod.outlook.com (20.176.116.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Tue, 22 Jan 2019 15:53:18 +0000
Received: from DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d]) by DM6PR12MB2844.namprd12.prod.outlook.com
 ([fe80::c40:929a:abab:308d%3]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 15:53:18 +0000
From:   "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
To:     "joro@8bytes.org" <joro@8bytes.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Thread-Topic: [PATCH] iommu/amd: Fix IOMMU page flush when detach all devices
 from a domain
Thread-Index: AQHUrVI/ylqJsNQGs0C49TFTH04R5KWx458AgAALuQCAADJSAIABBWMAgAf9UwCAAFYdgA==
Date:   Tue, 22 Jan 2019 15:53:18 +0000
Message-ID: <e27055c1-89b0-e804-b99c-c94965de5344@amd.com>
References: <20190116041546.3541-1-Suravee.Suthikulpanit@amd.com>
 <20190116132648.i5n3hz3k7d2wxbrx@8bytes.org>
 <60c24182-c58e-0575-b085-c7eebc00c49b@amd.com>
 <20190116170852.GD4681@8bytes.org>
 <0a61c07d-edfe-2738-380d-33d39e40fc0a@amd.com>
 <20190122104454.nke2knuyqiswfh5w@8bytes.org>
In-Reply-To: <20190122104454.nke2knuyqiswfh5w@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
x-originating-ip: [110.169.70.41]
x-clientproxiedby: SG2PR06CA0156.apcprd06.prod.outlook.com
 (2603:1096:1:1f::34) To DM6PR12MB2844.namprd12.prod.outlook.com
 (2603:10b6:5:45::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR12MB2715;20:gpIkQJIt/QCCGxXAHPQW7/2t9xnThgnbRY/G0JHskxCcP5dCEf+i53vqiFa7ctxfkWZbwOimAfB04l11sRE3b8HqU06/RunKB55S6L2qAIo72gU9U7fW8Yv7aeQcizS/gTsvYMqyW2OTQXnrMFnWSBZkKeMwfAs+vSxG1B4+G7F55QQ931mjVZudbz47y9xnYEFw2HHyNdmkaO1223O+EIDWN43E1kVBbj9Q13QR7oh/klRLuUtQ+ipDgzPvYJdt
x-ms-office365-filtering-correlation-id: 32cb2b43-9d33-4b9f-4fe0-08d68081b9e5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2715;
x-ms-traffictypediagnostic: DM6PR12MB2715:
x-microsoft-antispam-prvs: <DM6PR12MB27151272E0FF3D653E8AF193F3980@DM6PR12MB2715.namprd12.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(376002)(346002)(51914003)(199004)(189003)(11346002)(8936002)(478600001)(58126008)(99286004)(6246003)(36756003)(105586002)(229853002)(2906002)(486006)(561944003)(305945005)(93886005)(97736004)(106356001)(316002)(446003)(68736007)(65826007)(66066001)(54906003)(31686004)(81156014)(1730700003)(81166006)(102836004)(65956001)(65806001)(6436002)(5640700003)(8676002)(26005)(72206003)(7736002)(53546011)(186003)(2616005)(386003)(6506007)(6486002)(86362001)(14454004)(3846002)(6116002)(25786009)(2351001)(476003)(53936002)(31696002)(6512007)(71200400001)(5024004)(256004)(2501003)(76176011)(52116002)(71190400001)(4326008)(64126003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2715;H:DM6PR12MB2844.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1vYrY/CfnYP/RCEVP8oLlSrRDaRxy4pQQDewtLdRiFY6EzqNAs6Qkyrb61k23jLr+hzNe+EqotqRRba9zLQnZY+yH45Jx5Bw85GB1uTNnCUTfhUF2p8bdZLMJFD7Ecp21H4K5gWNd7BZU2A9RcH6Ogkduc99S7mrlTYsIWqEjmyQS5IrmBSu+Dr5z6lkgV9g2h3i0uzPP8iSy5ZUdgQ+k/lyK/Qn0M51F+flRuWU+M0lPXh4uzVHUMZtYD4QvYQmvbuh6Ggw3jqx5jfjpvBzeWJzA0mlBg09RT5Trc2hhGQRBqMMovwg3TZoF77IlL/yDoB9gL3E8NUIgrghb12joD/Dmj0+JmBbU5N8kKFUvdjvuRaHlUf6hl6PgikW6VK6nhB+cfZkCaswvVubxchMQhHA65MVDhTy6x0Awyuc71o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C06E346A8976942BC2F062223E2406A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cb2b43-9d33-4b9f-4fe0-08d68081b9e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 15:53:15.9190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sm9lcmcsDQoNCk9uIDEvMjIvMTkgNTo0NCBQTSwgam9yb0A4Ynl0ZXMub3JnIHdyb3RlOg0KPiBI
aSBTdXJhdmVlLA0KPiANCj4gT24gVGh1LCBKYW4gMTcsIDIwMTkgYXQgMDg6NDQ6MzZBTSArMDAw
MCwgU3V0aGlrdWxwYW5pdCwgU3VyYXZlZSB3cm90ZToNCj4+IFRoZW4sIGluIF9fZG9tYWluX2Zs
dXNoX3BhZ2VzLCB3ZSBpc3N1ZSBjb21tYW5kIHdoZW4gdGhlIGRldl9pb21tdVtdID49IDAuDQo+
PiBUaGlzIHNob3VsZCBwcmVzZXJ2ZSBwcmV2aW91cyBiZWhhdmlvciwgYW5kIG9ubHkgYWRkIGZs
dXNoaW5nIGNvbmRpdGlvbiB0bw0KPj4gdGhlIHNwZWNpZmljIElPTU1VIGluIGRldGFjaGVkIHN0
YXRlLiBQbGVhc2UgbGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuDQo+IA0KPiBJIHRoaW5rIHRo
ZSB3aG9sZSBwb2ludCB3aHkgVkZJTyBpcyBkZXRhY2hpbmcgYWxsIGRldmljZXMgZmlyc3QgYW5k
IHRoZW4NCj4gZ29lcyBpbnRvIHVubWFwcGluZyBwYWdlcyBpcyB0aGF0IHRoZXJlIGFyZSBubyBm
bHVzaGVzIG5lZWRlZCBhbnltb3JlDQo+IHdoZW4gZGV2aWNlcyBhcmUgZGV0YWNoZWQuDQo+IA0K
PiBCdXQgd2hlbiB3ZSBmb2xsb3cgeW91ciBwcm9wb3NhbCB3ZSB3b3VsZCBzdGlsbCBkbyBJT1RM
QiBmbHVzaGVzIGV2ZW4NCj4gd2hlbiBubyBkZXZpY2VzIGFyZSBhdHRhY2hlZCBhbnltb3JlLiBT
byBJJ2QgbGlrZSB0byBhdm9pZCB0aGlzLCBnaXZlbg0KPiB0aGUgaW1wbGljYXRpb25zIG9uIHVu
bWFwcGluZyBwZXJmb3JtYW5jZS4gV2Ugc2hvdWxkIGp1c3QgZmx1c2ggdGhlDQo+IElPTU1VIFRM
QiBhdCBkZXRhY2ggdGltZSBhbmQgYmUgZG9uZSB3aXRoIGl0Lg0KPiANCj4gTWFrZXMgc2Vuc2U/
DQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gCUpvZXJnDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBkZXRh
aWwuIEFscmlnaHQgdGhlbiwgbGV0J3MganVzdCBnbyB3aXRoIHRoZSB2ZXJzaW9uIHlvdQ0Kc2Vu
dCBvbiAxLzE2LzE5LiBEbyB5b3Ugd2FudCBtZSB0byByZXNlbmQgVjMgd2l0aCB0aGF0IGNoYW5n
ZXMsIG9yDQp3b3VsZCB5b3UgYmUgdGFraW5nIGNhcmUgb2YgdGhhdD8NCg0KVGhhbmtzLA0KU3Vy
YXZlZQ0K
