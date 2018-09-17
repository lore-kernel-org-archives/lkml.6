Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF0EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F275A214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F275A214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeIRAYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:24:07 -0400
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:14056 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeIRAYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:24:06 -0400
Received: from G9W9209.americas.hpqcorp.net (g9w9209.houston.hpecorp.net [16.220.66.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id C036963;
        Mon, 17 Sep 2018 18:55:28 +0000 (UTC)
Received: from G1W8106.americas.hpqcorp.net (16.193.72.61) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Sep 2018 18:55:27 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Mon, 17 Sep 2018 18:55:28 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0594.NAMPRD84.PROD.OUTLOOK.COM (10.169.4.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Mon, 17 Sep 2018 18:55:26 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1143.014; Mon, 17 Sep 2018
 18:55:26 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] lib/ioremap: Ensure break-before-make is used for
 huge p4d mappings
Thread-Topic: [PATCH 5/5] lib/ioremap: Ensure break-before-make is used for
 huge p4d mappings
Thread-Index: AQHUSoMPow4aud8a+UOTBYHkqaUlfqT02vAA
Date:   Mon, 17 Sep 2018 18:55:26 +0000
Message-ID: <5bb8514bd9cb344a6fdcf3fe7e96fcb2ecfd0136.camel@hpe.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
         <1536747974-25875-6-git-send-email-will.deacon@arm.com>
In-Reply-To: <1536747974-25875-6-git-send-email-will.deacon@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.163.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0594;6:O/sckKGAKxTGLWehvpY8py3xThB2kvUKe/hh1dJRhsASwcfj9dhXobqQrxKbvUT3ik/Q4EnGLfYL/Ux2mtYg8p0GxtWRNwIRHLLKM+SfDbdjQHHa/ZiAk5kjHtkeH44KmSRivkM79t/WMSdu4Sti2xwqGcNmcSgrwCcg68NX6khvAisBUjhPmMbOXbCWGSX7VOkwwonja0DsaSND7FcHJPKkkZRQpIWwp/8kksWuxgzekVbW2YkpPmHJsqgkBTWsMSAsIxDOyYISjUKyPZObrwHcfIV46P9SWaezUO5q67mu31fs99ek7WNfkePGTKINhfOCOyby3Hti5qOhNYU0VSKccfIXOq4VoTlmVaSi0sJ2KEGzk1QpS2zXgTdgy6rYje8GR1AQax1g9bkbtdw20F1qmd0HK8rjtaT3joYVWJ0l+GWwdmWeYRH39e5xxhjOZwH4Vns8QoYMLJ9Ari19kw==;5:vziyGoe5F+URZh5HDdr/nrjeehDimq+S9ARyhZ0p5VqSxs1WqoaIds3WBTWgaS6ogqZ03dtN071tDb0DV2hBGBxKrKlVDJknOMEMCYVFR7f07WlA1dOuWOCEPApejFW7AMBIIyMqc7fFdEVmK8g7+g5Ik1Xeuux3+OD8w0ajDnE=;7:OdwxHKjvVMa6t1UATJUD4Bd9HWvRB6DxGscgL1NRWdAo7TzVB71bYtGi6qxdqK2vz24pmT/zI55b6yk0JpBnarI5o4h9M3Em2ewPSVJJaUQEMC8nbneqELxioYJ7u2Pipy8/zWNeavGpV7eqrPrMiiPuq75UWGIKa4tAlX5TGaa/r3sgl4paGU7kJYRSrW0xPC4NK14hLK1GFyrdLd+spQoiLLRnLBmnzPUeanNC03eIJAN09H4ff7aKPOfMwinJ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bb1ab80c-e85d-4160-30c3-08d61ccf2157
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0594;
x-ms-traffictypediagnostic: AT5PR8401MB0594:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB0594C3BBC4C7D48832F46C19821E0@AT5PR8401MB0594.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(180628864354917)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:AT5PR8401MB0594;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0594;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(366004)(376002)(136003)(189003)(199004)(3846002)(6116002)(118296001)(86362001)(97736004)(5660300001)(102836004)(6436002)(316002)(7736002)(476003)(26005)(486006)(2201001)(6486002)(14454004)(478600001)(110136005)(106356001)(53936002)(4326008)(2906002)(54906003)(6512007)(68736007)(5250100002)(6246003)(99286004)(2501003)(25786009)(229853002)(186003)(105586002)(256004)(6506007)(446003)(8676002)(76176011)(36756003)(81166006)(66066001)(305945005)(81156014)(2900100001)(8936002)(11346002)(2616005)(42413003)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0594;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BhQ+QTc97DUSOZvEsxEJwYNCH97eXyJr4gWCFR5iy/mJGfl/2LStcHsG9qh6pyB+GhXXk8O1Qrb6Md//+XvYtaPdQPhwuORgkBrNOhy4oh8CNkRbnBeN15OoAq4Yjei+kKgtqIns3U3epJvkyZCib1N3JhvFExGuxsAtIBaUkgArcIVukcMdNeoe/613IeNx/YxemzPs9WCXrZWMgA11hL3HWRNkDartuoiv970ick5w4hVan1fbZ/qZkKdmz7CmZTq6YUixK7DuJY7krdgJedf7oa9dfdp4qnkmlVUy2vnysa3J82YhY3nbg/+Fnd4bAE0tZuG1n5xNe8vGLQBc3/wVFl0VEzEnvBFYsbuyNtM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1E31795310A8C4CAB787A806539C77C@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1ab80c-e85d-4160-30c3-08d61ccf2157
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 18:55:26.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0594
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA5LTEyIGF0IDExOjI2ICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
V2hpbHN0IG5vIGFyY2hpdGVjdHVyZXMgYWN0dWFsbHkgZW5hYmxlIHN1cHBvcnQgZm9yIGh1Z2Ug
cDRkIG1hcHBpbmdzDQo+IGluIHRoZSB2bWFwIGFyZWEsIHRoZSBjb2RlIHRoYXQgaXMgaW1wbGVt
ZW50ZWQgc2hvdWxkIGJlIHVzaW5nDQo+IGJyZWFrLWJlZm9yZS1tYWtlLCBhcyB3ZSBkbyBmb3Ig
cHVkIGFuZCBwbWQgaHVnZSBlbnRyaWVzLg0KPiANCj4gQ2M6IENoaW50YW4gUGFuZHlhIDxjcGFu
ZHlhQGNvZGVhdXJvcmEub3JnPg0KPiBDYzogVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBocGUuY29t
Pg0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENjOiBNaWNo
YWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4NCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFdpbGwgRGVhY29uIDx3aWxsLmRl
YWNvbkBhcm0uY29tPg0KDQpUaGFua3MuIFRoaXMga2VlcHMgdGhlIHA0ZCBwYXRoIGNvbnNpc3Rl
bnQuDQoNClJldmlld2VkLWJ5OiBUb3NoaSBLYW5pIDx0b3NoaS5rYW5pQGhwZS5jb20+DQoNCi1U
b3NoaQ0KDQo=
