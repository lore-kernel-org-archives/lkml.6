Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EDEECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9596B20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9596B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbeIOBwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 21:52:35 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:54401 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbeIOBwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 21:52:34 -0400
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id C6EDC605DE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 20:36:28 +0000 (UTC)
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id E106261;
        Fri, 14 Sep 2018 20:36:27 +0000 (UTC)
Received: from G9W8667.americas.hpqcorp.net (16.220.49.26) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 20:36:27 +0000
Received: from G1W8106.americas.hpqcorp.net (16.193.72.61) by
 G9W8667.americas.hpqcorp.net (16.220.49.26) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Sep 2018 20:36:27 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Fri, 14 Sep 2018 20:36:27 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB0898.NAMPRD84.PROD.OUTLOOK.COM (10.169.6.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Fri, 14 Sep 2018 20:36:24 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1143.014; Fri, 14 Sep 2018
 20:36:24 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "Hocko, Michal" <MHocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] ioremap: Rework pXd_free_pYd_page() API
Thread-Topic: [PATCH 1/5] ioremap: Rework pXd_free_pYd_page() API
Thread-Index: AQHUSoMKoOShLl5RW0iSVsyGvjy8o6TwQCwA
Date:   Fri, 14 Sep 2018 20:36:24 +0000
Message-ID: <71baefb8e0838fba89ee06262bbb2456e9091c7a.camel@hpe.com>
References: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
         <1536747974-25875-2-git-send-email-will.deacon@arm.com>
In-Reply-To: <1536747974-25875-2-git-send-email-will.deacon@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.219.147.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB0898;6:+lC3dS5TdbAnaFpCB7HKSMntF38kxwfKjysBxWQBKz0m/j9s6D6XDHURpyBWXCg92m9niBtuAZ/zViqFrWtxRt6zZHFDOpQTqvo2RCptU/8gSzUcIBYzvFqhJ0rSVU4bfQCo14c1vj3iLqUXcVOrcmiSkZhzMrMfxwNqPpiMnf51i2G17YQ1Ijp5n2v+TxwQa4PKlHIrW+eMwO1dQxSEwGCDG2JIYALE7cqV6QVOb/HlcTGQVmiZs2ogwpJbWVaGS5a/EKXwqpBvmuO5Zw7/pVXcRWF2BqKzqOtVxbv+khP8sqizMd/ejLRS+DTeN6FkyZuvBrKmqZlUYof6lXmeetw+q9/BvqqHTLcrAUbiPvPg3IT+nitDNfaulDfod+e4WFhWwj+GpjFegiNNWoVTFYzpsmSu9Tv+91NgbGj/ygtkMfp36S0UwzxbSiFYQjn+wRAUBuU1HW+GvqXuuEG6sw==;5:L6tU43Z5fnbFYQhvSQh7MBowigKIiUWwgd68lpeQNonwp7N81bKwUaAqZed/AWPFiIVGEhHQGAjy80vbRfZiDPO6N3dDwhtZimumGeo0cD5K5/vMBUw1rejBYNHBG2LLpHQd2Bi9weAPXPk5vPEE2JWAEI+4tFG7B/zHrR/1ark=;7:gcqP0TCRG+/qq81HCogRBfYRbkf+ey7vZsovvgwFeAvh71QShR/iLKhsnwqXxo62l5HLE46BYyWrW+5dckwhPDeNoW76f2Buw856k4lQwvw+4Dxb9Yb6Qev7xe37JZgpoQsnNInS+wt+I1HGw66DnW1nUH0/IK2XRressp9w7+Mc8t+19s+l7MBhfYhN4vCZi1u8vGM5jevpsYFzs5ZSr4oUJoGf2ZNgbsEU1DDUaEXaWirguGRoDUfq6i5XfCVC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 09597929-5fdf-4b7a-2b04-08d61a81bd2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB0898;
x-ms-traffictypediagnostic: AT5PR8401MB0898:
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-microsoft-antispam-prvs: <AT5PR8401MB08986EA3CF330A94E62D89D982190@AT5PR8401MB0898.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(180628864354917)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AT5PR8401MB0898;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB0898;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(105586002)(316002)(68736007)(118296001)(2616005)(14454004)(446003)(97736004)(6116002)(11346002)(2906002)(25786009)(106356001)(3846002)(6436002)(6512007)(4326008)(6486002)(6246003)(53936002)(229853002)(478600001)(2900100001)(2501003)(486006)(5250100002)(8936002)(6506007)(66066001)(102836004)(36756003)(256004)(8676002)(81166006)(2201001)(81156014)(76176011)(7736002)(5660300001)(110136005)(86362001)(305945005)(476003)(99286004)(54906003)(186003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB0898;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 1zBWgnltylU4aYsSYIC/F0FKFCkRg2H9xhc423bn6gSS0QpSh3TEYomNnFh5jN3zID+KHFHEGymso+sg4NJXH2r7tYK35qlYQhrJfuboAFjlbP8IU0LtU2dwJ8mONaB7Z0B1cdZBnxvEhV9hSfD37bFBYVz+iXzekP4M1ehTyFCRaOk3jqg4PZr0T44f7mvvR6X25ZzSKMIz74fNs/enxDzefSQIW99PrlrUwSwTioXQg21LTWvfS0n8vjK7ZPSBy4F6LJGAekBsH/j6l3YLor8FQ7rcet/OWEELYwSTmm+S4sf4l4/K4UbPYqQHq8nZzOauoivQQxSzVNOoFr2IT7UM2RDMMsNgF8Fs6JXaStA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDC81075871C414DBA737385CD30F171@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 09597929-5fdf-4b7a-2b04-08d61a81bd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 20:36:24.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0898
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA5LTEyIGF0IDExOjI2ICswMTAwLCBXaWxsIERlYWNvbiB3cm90ZToNCj4g
VGhlIHJlY2VudGx5IG1lcmdlZCBBUEkgZm9yIGVuc3VyaW5nIGJyZWFrLWJlZm9yZS1tYWtlIG9u
IHBhZ2UtdGFibGUNCj4gZW50cmllcyB3aGVuIGluc3RhbGxpbmcgaHVnZSBtYXBwaW5ncyBpbiB0
aGUgdm1hbGxvYy9pb3JlbWFwIHJlZ2lvbiBpcw0KPiBmYWlybHkgY291bnRlci1pbnR1aXRpdmUs
IHJlc3VsdGluZyBpbiB0aGUgYXJjaCBmcmVlaW5nIGZ1bmN0aW9ucw0KPiAoZS5nLiBwbWRfZnJl
ZV9wdGVfcGFnZSgpKSBiZWluZyBjYWxsZWQgZXZlbiBvbiBlbnRyaWVzIHRoYXQgYXJlbid0DQo+
IHByZXNlbnQuIFRoaXMgcmVzdWx0ZWQgaW4gYSBtaW5vciBidWcgaW4gdGhlIGFybTY0IGltcGxl
bWVudGF0aW9uLCBnaXZpbmcNCj4gcmlzZSB0byBzcHVyaW91cyBWTV9XQVJOIG1lc3NhZ2VzLg0K
PiANCj4gVGhpcyBwYXRjaCBtb3ZlcyB0aGUgcFhkX3ByZXNlbnQoKSBjaGVja3Mgb3V0IGludG8g
dGhlIGNvcmUgY29kZSwNCj4gcmVmYWN0b3JpbmcgdGhlIGNhbGxzaXRlcyBhdCB0aGUgc2FtZSB0
aW1lIHNvIHRoYXQgd2UgYXZvaWQgdGhlIGNvbXBsZXgNCj4gY29uanVuY3Rpb25zIHdoZW4gZGV0
ZXJtaW5pbmcgd2hldGhlciBvciBub3Qgd2UgY2FuIHB1dCBkb3duIGEgaHVnZQ0KPiBtYXBwaW5n
Lg0KPiANCj4gQ2M6IENoaW50YW4gUGFuZHlhIDxjcGFuZHlhQGNvZGVhdXJvcmEub3JnPg0KPiBD
YzogVG9zaGkgS2FuaSA8dG9zaGkua2FuaUBocGUuY29tPg0KPiBDYzogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENjOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNv
bT4NCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IFN1
Z2dlc3RlZC1ieTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3Jn
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4NCg0K
WWVzLCB0aGlzIGxvb2tzIG5pY2VyLg0KDQpSZXZpZXdlZC1ieTogVG9zaGkgS2FuaSA8dG9zaGku
a2FuaUBocGUuY29tPg0KDQpUaGFua3MsDQotVG9zaGkNCg==
