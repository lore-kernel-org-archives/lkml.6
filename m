Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CEDC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB48F20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Z+uqzcwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB48F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeILSdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:33:02 -0400
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:28056
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726754AbeILSdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KU/eSnVfcKTXLRN28DRj7KRBjoJ3kfl6Uuw5NsgLNnE=;
 b=Z+uqzcwXUjo8nZCkJ0CFHXMi3KnnCzxXY9/QyUPtgX9sAskqJD/8jcjLGuiFHA/PQ7TskL276BXFYThDx+Ks6rzRAi76m5lZ+6Cu+7fzHVDsJCNgpQ94Odeh8t9wjPdDsw1nWAtMOEn+RV7Su4EN79ZQG0g4yOORL4rs6TQjuc8=
Received: from DM5PR21MB0508.namprd21.prod.outlook.com (10.172.91.142) by
 DM5PR21MB0507.namprd21.prod.outlook.com (10.172.91.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Wed, 12 Sep 2018 13:28:25 +0000
Received: from DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5]) by DM5PR21MB0508.namprd21.prod.outlook.com
 ([fe80::88e6:fdc:1d8e:71f5%4]) with mapi id 15.20.1164.006; Wed, 12 Sep 2018
 13:28:25 +0000
From:   Pasha Tatashin <Pavel.Tatashin@microsoft.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>,
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
Subject: Re: [PATCH 2/4] mm: Create non-atomic version of SetPageReserved for
 init use
Thread-Topic: [PATCH 2/4] mm: Create non-atomic version of SetPageReserved for
 init use
Thread-Index: AQHUSWAihxpsnDr+CU6FWKzflwtDSKTspjUA
Date:   Wed, 12 Sep 2018 13:28:25 +0000
Message-ID: <f4f6a343-7be1-4290-802e-7ff96e93bc2a@microsoft.com>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234348.4068.92164.stgit@localhost.localdomain>
In-Reply-To: <20180910234348.4068.92164.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.117.57.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0507;6:K+V/87lJiYgqwbhkEg05NxgXLk9eLLKg90xttBUNvXIolpHBZ+1qhAzttLmQ9hoRnTw92OY8AfcbYerls6sicaEJhJZJXKNVWhyzN4ai2zCHGzQV/kL1M5HXgdwZP+TUYHEWs0FncvfkQqYK0u+wQu92U1nJS0dMYpuxrIMxwQQp7k2cHxvza1Xyni/2JLU3CSxn1XIbT5ZiKqnEmxmC1SrGhzi9ypWp0KNMYnUu6ajtytI/vy/nx8qmjCXfkBtPTDrZCjk96ZDi+2Y8/MMslIPZa0oX7bK7DVmfh5tyKg6ymr7rlQuN1M0OEzzICKMVly9IPqwvo8BYPNj11TQD5DaEh+0TWLDZWUIbPLQXB+w305T7/vHTgU6RawdqMIGip3o8IZvTGbi716ICtBRS/QKl3khU9fBYKLbXbxQ7FwrwQ9nsn+UxqpNqpF07oRPcmJ6br2OESaM911BWW2fYsg==;5:peJge/dgTkKQuU7JNrlAJ+h3d99/C3cogCZoNndoKxgb5EPhhBiNomyYbIJmreo53sqEREtRhuLxemsPgAOKVxg0zh8/K8PdnQidwnAwt6GR8q1OBiWyWJw+esfZjHlkk23E9srnvPGgvzkQfAROPIRwTRHbhOeegmlhuxkrwRU=;7:9v8vVxL0sVv1hFqjcqRzqOwOfnhZ8ipriQ4yfNIjxMowjls0NguEAbUV7OFsXEIdLcUhLpU56flHwl4Wqo4c/cn7t8wIVkZ8Zo15RYfGjsfJ9wZwi+iwo5hOkFiroRiPNPwUEeh3zqe34JWmkLcFkwA2hNvbo6jMoybeZv6cxa0Q+mYRMcDLliLZ6Ib/qiQd/AqxImEOik1CbTi9ep5cMpzcnYP3jwjkRrui49FDvPHpu3tmfc9HK8Xx7XC3JllX
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bd8e5998-0cd0-46bd-ff21-08d618b39e74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0507;
x-ms-traffictypediagnostic: DM5PR21MB0507:
x-microsoft-antispam-prvs: <DM5PR21MB0507AF69285D865212DCBCB79D1B0@DM5PR21MB0507.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(209352067349851)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:DM5PR21MB0507;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0507;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(97736004)(81156014)(10290500003)(81166006)(6512007)(8936002)(186003)(26005)(8676002)(14454004)(2501003)(76176011)(54906003)(110136005)(105586002)(86362001)(316002)(36756003)(478600001)(86612001)(31696002)(2201001)(6486002)(99286004)(72206003)(6436002)(5250100002)(68736007)(31686004)(22452003)(53936002)(229853002)(256004)(5660300001)(305945005)(7736002)(6116002)(6246003)(3846002)(2906002)(39060400002)(25786009)(7416002)(66066001)(102836004)(6506007)(53546011)(10090500001)(6346003)(106356001)(2900100001)(476003)(11346002)(2616005)(446003)(486006)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0507;H:DM5PR21MB0508.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Pavel.Tatashin@microsoft.com; 
x-microsoft-antispam-message-info: 0lGz627HNURgMzVSc8rovyBuS6PHtmyef9pkA+n1r4im/Q2neZfRlRL1XDSLac8+nYuBKj4XrSuoHECVGN+dPDgNu6PY8Dmv3Tl0M6hxEJZRQC5+9ZPrgJ31AFz2cnIeD32sBLeyzsrVc8paGZAFK7oDGkyd4XbiIc4mE+jDcu+GmYnWIMruK6KuDrsJE7OK93AAa1eDh3b2KyAfOGjYtUbSSy9l20Whz7f2x0JWvtCu5skxRYE8+UWsU699ddZJKMiMJd3QD8GwtwD/dfVeuBD+VQyQrJVq/gcmUC5G0yE5GGJXktVNHMklxkN1BeVM0Fu65BRSgI4gp2BsmOFJV/FmOmHZ4fRKulSO4dr66Fs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <569B95AED34CEF49BC65C5B37016D013@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8e5998-0cd0-46bd-ff21-08d618b39e74
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 13:28:25.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA5LzEwLzE4IDc6NDMgUE0sIEFsZXhhbmRlciBEdXljayB3cm90ZToNCj4gRnJvbTogQWxl
eGFuZGVyIER1eWNrIDxhbGV4YW5kZXIuaC5kdXlja0BpbnRlbC5jb20+DQo+IA0KPiBJdCBkb2Vz
bid0IG1ha2UgbXVjaCBzZW5zZSB0byB1c2UgdGhlIGF0b21pYyBTZXRQYWdlUmVzZXJ2ZWQgYXQg
aW5pdCB0aW1lDQo+IHdoZW4gd2UgYXJlIHVzaW5nIG1lbXNldCB0byBjbGVhciB0aGUgbWVtb3J5
IGFuZCBtYW5pcHVsYXRpbmcgdGhlIHBhZ2UNCj4gZmxhZ3MgdmlhIHNpbXBsZSAiJj0iIGFuZCAi
fD0iIG9wZXJhdGlvbnMgaW4gX19pbml0X3NpbmdsZV9wYWdlLg0KPiANCj4gVGhpcyBwYXRjaCBh
ZGRzIGEgbm9uLWF0b21pYyB2ZXJzaW9uIF9fU2V0UGFnZVJlc2VydmVkIHRoYXQgY2FuIGJlIHVz
ZWQNCj4gZHVyaW5nIHBhZ2UgaW5pdCBhbmQgc2hvd3MgYWJvdXQgYSAxMCUgaW1wcm92ZW1lbnQg
aW4gaW5pdGlhbGl6YXRpb24gdGltZXMNCj4gb24gdGhlIHN5c3RlbXMgSSBoYXZlIGF2YWlsYWJs
ZSBmb3IgdGVzdGluZy4gT24gdGhvc2Ugc3lzdGVtcyBJIHNhdw0KPiBpbml0aWFsaXphdGlvbiB0
aW1lcyBkcm9wIGZyb20gYXJvdW5kIDM1IHNlY29uZHMgdG8gYXJvdW5kIDMyIHNlY29uZHMgdG8N
Cj4gaW5pdGlhbGl6ZSBhIDNUQiBibG9jayBvZiBwZXJzaXN0ZW50IG1lbW9yeS4NCj4gDQo+IEkg
dHJpZWQgYWRkaW5nIGEgYml0IG9mIGRvY3VtZW50YXRpb24gYmFzZWQgb24gY29tbWl0IDxmMWRk
MmNkMTNjND4gKCJtbSwNCj4gbWVtb3J5X2hvdHBsdWc6IGRvIG5vdCBhc3NvY2lhdGUgaG90YWRk
ZWQgbWVtb3J5IHRvIHpvbmVzIHVudGlsIG9ubGluZSIpLg0KPiANCj4gSWRlYWxseSB0aGUgcmVz
ZXJ2ZWQgZmxhZyBzaG91bGQgYmUgc2V0IGVhcmxpZXIgc2luY2UgdGhlcmUgaXMgYSBicmllZg0K
PiB3aW5kb3cgd2hlcmUgdGhlIHBhZ2UgaXMgaW5pdGlhbGl6YXRpb24gdmlhIF9faW5pdF9zaW5n
bGVfcGFnZSBhbmQgd2UgaGF2ZQ0KPiBub3Qgc2V0IHRoZSBQR19SZXNlcnZlZCBmbGFnLiBJJ20g
bGVhdmluZyB0aGF0IGZvciBhIGZ1dHVyZSBwYXRjaCBzZXQgYXMNCj4gdGhhdCB3aWxsIHJlcXVp
cmUgYSBtb3JlIHNpZ25pZmljYW50IHJlZmFjdG9yLg0KPiANCj4gQWNrZWQtYnk6IE1pY2hhbCBI
b2NrbyA8bWhvY2tvQHN1c2UuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgRHV5Y2sg
PGFsZXhhbmRlci5oLmR1eWNrQGludGVsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFBhdmVsIFRhdGFz
aGluIDxwYXZlbC50YXRhc2hpbkBtaWNyb3NvZnQuY29tPg0KDQpUaGFuayB5b3UsDQpQYXZlbA==
