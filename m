Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD80C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE75206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u1xUboUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbeLPXle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:41:34 -0500
Received: from mail-eopbgr710053.outbound.protection.outlook.com ([40.107.71.53]:7549
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730888AbeLPXle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oRvHG5/KawtnFwGS7YhVEjylHb/lzEowsD++GZZcm0=;
 b=u1xUboUIH3Gljo0ZQQd+hdYSc8fBI0MCVcjQVTU4jFOAc8mwLbDxI4OxeB28YYpr3b3O7iy2wHmMB65FrCwuNG3i7/NWjGlOGuHddi4RTXBRLKYimoMFGqeq1/17qbGdECe0JYL1HiI5jtCL0yP1Eht3EIsHOjn60Tn94ED7jrs=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB2429.namprd12.prod.outlook.com (52.132.195.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Sun, 16 Dec 2018 23:41:29 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::bc0e:7f7f:ee65:e2d5%6]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 23:41:29 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] kernel/dma/direct: Do not include SME mask in the DMA
 supported check
Thread-Topic: [PATCH] kernel/dma/direct: Do not include SME mask in the DMA
 supported check
Thread-Index: AQHUkzZYZbIHsqBVPUqwArkjtx2NOqV/ot4AgAJobQA=
Date:   Sun, 16 Dec 2018 23:41:28 +0000
Message-ID: <6954879c-90df-b6bd-7925-f0985980ed18@amd.com>
References: <20181213225110.6567.69313.stgit@tlendack-t1.amdoffice.net>
 <20181215105510.GA1806@lst.de>
In-Reply-To: <20181215105510.GA1806@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0062.namprd04.prod.outlook.com
 (2603:10b6:805:2a::39) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB2429;20:pmkwm2aE5qqBGmDwBuUQOgeEJZGwXdiEHHHWW9SuOrfGAusWaALhj7AkoftVHRbSA0V2SMoCAJl4qA89OFKz6dar/GCVCMZ4DOTfzoawWMJAybsMo9yFt39NXTk0u9rn+2rDWeWqUFkSCUJDb/syd+xfurYBUh6Wj+t+OCNG29120Y2ljL7kpiRaOXDEYURqEmJ9nf4TWGNWA93vrjXAoD6tJzzU5yqFpyymW6u1vJ6t1a2BBsaCXU42aFKGNdHF
x-ms-office365-filtering-correlation-id: 114a5227-029f-4047-fcbe-08d663afffe0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2429;
x-ms-traffictypediagnostic: SN1PR12MB2429:
x-microsoft-antispam-prvs: <SN1PR12MB2429B5B5F3E8EC6DACF55C17ECA30@SN1PR12MB2429.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB2429;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2429;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(4326008)(76176011)(106356001)(6246003)(36756003)(68736007)(102836004)(186003)(8676002)(2616005)(11346002)(486006)(6486002)(446003)(52116002)(6506007)(53546011)(476003)(81166006)(8936002)(71200400001)(71190400001)(229853002)(386003)(2906002)(31696002)(6916009)(86362001)(26005)(6436002)(7736002)(256004)(6512007)(53936002)(81156014)(54906003)(3846002)(31686004)(25786009)(5660300001)(305945005)(99286004)(39060400002)(316002)(6116002)(14454004)(105586002)(66066001)(97736004)(72206003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2429;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: z0rrj7IaqUe57xE2kVN5wydn7GmQeq6ea3vn33Ki8s7ewNOuYr7TsqzjMwap8DzOSuVqFnr6BGJ/3dkllBAB9Hcl+gz8YFSJofzrFJRzreWK4pidM5S7RNQflcCILvJ3seSR49pkNgwqLuOgQutd0ChtucurQNXlXLdv4Y0ipWIfW2YgNRDezQUlUZJR+ZpVi1d9pnfB3ItHpqmfi50nSUYWHt3OzGjhbR2MU9sQEVjQXPsdL5ssiN9MEEdvTmv5prebMCbWpwIqB0QM4E1MaL2xQ4WyJw6ApOiqvTG/q7Yt9ohZ4xNO/9bQqV9Zfq0w
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACAD12723F46B647928E2F04641FC891@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114a5227-029f-4047-fcbe-08d663afffe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 23:41:28.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTUvMjAxOCAwNDo1NSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBt
YWlsIHNlZW1zIHRvIGJlIHNvIG9kZGx5IGVuY29kZWQgc28gdGhhdCBnaXQtYW0gZmFpbHMgb24g
aXQuICBDYW4NCj4geW91IHJlc2VuZCBhcyBwbGFpbiB0ZXh0Pw0KDQpIbW1tLi4uIG5vdCBzdXJl
IHdoYXQgaGFwcGVuZWQgd2l0aCB0aGF0LCBidXQgeWVhaCwgbG9va2luZyBhdCB0aGUgbWVzc2Fn
ZQ0Kc291cmNlIHNob3dzIHNvbWV0aGluZyBzdHJhbmdlIHdlbnQgb24uIExldCBtZSB0YWtlIGEg
bG9vayBhbmQgSSdsbCB0cnkgdG8NCmdldCBhIGdvb2QgdmVyc2lvbiB0byB5b3UgdG9tbW9yb3cg
KE1vbmRheSkuDQoNClRoYW5rcywNClRvbQ0KDQo+IA0K
