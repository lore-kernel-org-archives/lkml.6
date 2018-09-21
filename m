Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60398ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B3E21550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 19:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JnSD29D0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B3E21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391270AbeIVAyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:54:46 -0400
Received: from mail-eopbgr720119.outbound.protection.outlook.com ([40.107.72.119]:3424
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391156AbeIVAyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAfCIhTcO6YmPIodxy7eRDn1JkKw0Bf85t3jdLwvPWs=;
 b=JnSD29D0FMi9C2wXCXH964GWufRupo8BRFcXI8sWmLvCRxW1TbWzyw8KgFlm7fnTqFIk3F0VlS08+WtLmh1LGT7OZrWhgGVEfd69/jluLbki823Z/M/+sizll8OlCG7lKqW8NWC52Q96rr6P6HDffROI+OvdYWVQSML8+BsHcJk=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0635.namprd21.prod.outlook.com (10.175.111.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Fri, 21 Sep 2018 19:04:30 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 19:04:30 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "mhocko@suse.com" <mhocko@suse.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v4 1/5] mm: Provide kernel parameter to allow disabling
 page init poisoning
Thread-Topic: [PATCH v4 1/5] mm: Provide kernel parameter to allow disabling
 page init poisoning
Thread-Index: AQHUUTEJUetFnXyPxkiXMreNCU4+e6T7GXWA
Date:   Fri, 21 Sep 2018 19:04:30 +0000
Message-ID: <a40a78c0-207b-03b7-344c-847b12a4f896@microsoft.com>
References: <20180920215824.19464.8884.stgit@localhost.localdomain>
 <20180920222415.19464.38400.stgit@localhost.localdomain>
In-Reply-To: <20180920222415.19464.38400.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0635;6:TXZw0stgLbtJ6LkBCcQFzL4NlPLevGjfQ87i5KHkvzN7PHhmwZ+zTW6VKWjPDz1Pataf3FZQn6Mqi4V9HgoE0BGIThBfZOfJEnOzSxPc3NpyaaHUKNd4jb1fHe3CHBI2bwIbsRyuBLedsKqVar8EjrBnmcgZCLM2nYCONBMi6yTFVDyeJJCbm2UFrDWJIYl8Y8rXkZ/skH1okE01jObqHkFi0MlOzDuArUN2mFmsqTGNSXIydFyuc8CdW44nsVZ4LeStVvgetMFcmIHB7tbPjhJfMZsCrjMo2FNFzNhMaWvYlvYkX9CCJs/3j3fzoPSuDCk5ZdadoOEmj6b+HzZD1wbr7STNwyNvb148Ys/8btk0pVC4uF8O2iZ2AKCsK3UaKIARrZtcT5RMZNOdKXJDwfNEu1A1Tlu0VA6aHfmZLfOJC2APlQ/x090yoBc5rIk5vvUxDZioIBRXQfIK9DCAaw==;5:I5D0+CFUFaUdDN/SC95Fsx7XCGqzQ6kQtWrS3Lv7bPr9ZWrGkcBlGCtC5/6XCjErBGRXdHO+Jaiy5CSYyasr/a+owqZr1z8BCwIbi4ujmXGsN+CsrRIMHv8j5GhHjnsHZLAJnDUPrhUK542H6KgaqeKHzYO1YdZKD7VK6QiXuj4=;7:e2LrVOV/DAGBHfOuPmUM1DdkQO4zJV9w65SbszMmulbjPz69Can9tuU21B2L8U3+B/vQuVYG3xFEj65brQcrQ+7NEaSGlKZ54UR/Mjm4KGYzCOI1tlBQWDZ24IF55hIk6iZq2YTkPYYR2SpenRxPP4OwpsUm/nK8Xw5l9bAplW+c6gtnxefP/0P0Vy1ChlFGy8ctkpHCeoTMFrfExwjcsdzROxjpXBrDhmJV/WL6CA1uQeUYSTHNgqPSS6da28xR
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b78df5d6-26ba-4643-178b-08d61ff50f50
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0635;
x-ms-traffictypediagnostic: DM5PR21MB0635:
x-microsoft-antispam-prvs: <DM5PR21MB063556E99B2FF37757EC84F89D120@DM5PR21MB0635.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(6055026)(149050)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:DM5PR21MB0635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0635;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(396003)(376002)(366004)(189003)(199004)(4326008)(105586002)(106356001)(186003)(22452003)(6346003)(102836004)(31686004)(110136005)(26005)(54906003)(316002)(2900100001)(8936002)(7416002)(53936002)(68736007)(2906002)(7736002)(81156014)(81166006)(36756003)(305945005)(66066001)(6436002)(6512007)(229853002)(72206003)(6486002)(8676002)(5660300001)(99286004)(486006)(6246003)(97736004)(476003)(11346002)(14444005)(256004)(3846002)(6116002)(478600001)(2501003)(2616005)(76176011)(5250100002)(31696002)(86612001)(86362001)(2201001)(446003)(25786009)(6506007)(14454004)(10090500001)(71200400001)(10290500003)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0635;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: 9C2BvYWcuYdnf0nJu15zXwYidwfwWDQbTJD2qGNgbEFuYEnPs+ggaR8pgoCiceeHsnHHhBQ5b9UMQaF3Y+FSjjdn1zAIcVazQaUT8J6Z+KmT/BC07AQ+S6eEqYnZDoL6JtYhafCgN/LVUyT2b+Nu/UcnzS12mWkIs8EvdJkYIQAN3H6J/EEYVvJcVljO+pfQ2NiVfPt8TumtzirTzd01HTL4eL6RHdTLmqB1/GhGsok6OO1cjUnFlnQAN9oqdt1GOFRYBIxagpUPZNENS93NvSSRl/xHqEX1geIY6Biok7lD14uAq+zmgpXoCvJ1pNTVs3we0KlZZ0qHcSX8Ph6a5wgWLZcson5rb70BEdHVuOc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC10A7A3A3CEBF40AA05D8612D8B3C0C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78df5d6-26ba-4643-178b-08d61ff50f50
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 19:04:30.3479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ICsJCQlwcl9lcnIoInZtX2RlYnVnIG9wdGlvbiAnJWMnIHVua25vd24uIHNraXBwZWRcbiIs
DQo+ICsJCQkgICAgICAgKnN0cik7DQo+ICsJCX0NCj4gKw0KPiArCQlzdHIrKzsNCj4gKwl9DQo+
ICtvdXQ6DQo+ICsJaWYgKHBhZ2VfaW5pdF9wb2lzb25pbmcgJiYgIV9fcGFnZV9pbml0X3BvaXNv
bmluZykNCj4gKwkJcHJfd2FybigiUGFnZSBzdHJ1Y3QgcG9pc29uaW5nIGRpc2FibGVkIGJ5IGtl
cm5lbCBjb21tYW5kIGxpbmUgb3B0aW9uICd2bV9kZWJ1ZydcbiIpOw0KDQpOZXcgbGluZXMgJ1xu
JyBjYW4gYmUgcmVtb3ZlZCwgdGhleSBhcmUgbm90IG5lZWRlZCBmb3Iga3ByaW50ZnMuDQoNCg0K
UmV2aWV3ZWQtYnk6IFBhdmVsIFRhdGFzaGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29t
Pg==
