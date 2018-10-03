Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8148C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A6D213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 20:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="i7K6iNSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A6D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJDDT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 23:19:58 -0400
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:11595
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbeJDDT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 23:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ+iEYmU6u8rXqu88v6QCYAgAsdQBs0PHGjpwC199s8=;
 b=i7K6iNSzuxJcaF6cdo4vTxUz5yTPJ1Nzbs3ZhgGUcM8sQd3W/L+Ej7ptChPl0XA5ZVWcewtQDLII2zwitChawpKTMtHDtL21k+hsxLKT2+PsjbyFRSYEq6yjcw2VHqzg1ELgvHJ5+D29KDu+4CgiUOT1PqhLk5EBBQ142sqs3qg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4934.namprd05.prod.outlook.com (52.135.235.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.16; Wed, 3 Oct 2018 20:29:58 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%3]) with mapi id 15.20.1207.018; Wed, 3 Oct 2018
 20:29:58 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH v8 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Topic: [PATCH v8 02/10] Makefile: Prepare for using macros for inline
 asm
Thread-Index: AQHUT5bXKvBkh+LIPE6RXFqGVNbGXKUCTuyAgACWSoCACPmyAIACJI6AgAANDgA=
Date:   Wed, 3 Oct 2018 20:29:58 +0000
Message-ID: <6B0803C6-0DB8-4376-B1C6-E556088343F8@vmware.com>
References: <20180918212847.199085-1-namit@vmware.com>
 <20180918212847.199085-3-namit@vmware.com>
 <1aa5a1f3-ef3d-5cd3-831c-2202d73d3c9e@rasmusvillemoes.dk>
 <307823F9-DCCF-4384-9FBE-28642FAD6B4E@vmware.com>
 <20181002105952.GA13611@gmail.com>
 <24BB4662-B220-4295-9040-17CF4C7B8CCE@zytor.com>
In-Reply-To: <24BB4662-B220-4295-9040-17CF4C7B8CCE@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4934;20:ZC/TNQn9JxE5464J/pJTKtMms/YAyEwtSo+VZ6OgHumHafDPVcgrmXuhG68MPPaiZnehhc36XAENc+2aTLGvGNRLNsnEkz5u7ub8p/v2BcsP8+eIfE3Ym5GbC3/xDlxtvYvwIIXbHt8voL/5xKbhIfh9Nx8g+zn9qsSQhT8AIZI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7df507fe-e71f-45e0-39a1-08d6296efcbd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4934;
x-ms-traffictypediagnostic: BYAPR05MB4934:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB49340F96BB34F97F05DBB5D0D0E90@BYAPR05MB4934.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR05MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4934;
x-forefront-prvs: 0814A2C7A3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(82746002)(5250100002)(8936002)(14454004)(71200400001)(229853002)(68736007)(93886005)(6246003)(71190400001)(83716004)(86362001)(5660300001)(66066001)(7416002)(2501003)(2906002)(97736004)(36756003)(3846002)(6116002)(33656002)(106356001)(105586002)(2616005)(476003)(446003)(6506007)(486006)(53936002)(478600001)(11346002)(6512007)(99286004)(2900100001)(558084003)(76176011)(26005)(186003)(102836004)(54906003)(305945005)(7736002)(110136005)(25786009)(81166006)(81156014)(316002)(8676002)(6436002)(256004)(4326008)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4934;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JSaK6Ja7wksvbiE5jns9CveL0rV4HUA3oNxUWNRqlRGG/lUMnJoWMbmDOkCeAAVm61qfZQiSnN0d7HanEwK9cG9+KB8FsXy8u6TE88td0W+Kz1BdZ4VdiDN2+kQDayofH0UkXmXg0jpb3zl8XTVW0wwOdl9dzjWCCFs/cf7Oa7IsI5ovAkklGMxBl45YIgUvnTZgZiZKjQh/ImAhPdaCRlFiy/9oLlylOx7cvcsX1feQCeDbCOlpP6ZYUYtwZxfCz3ZaggIBpPDi58Z7NXA2aMvjGV6e6kncLsreJOsjYTvxg70OhhS6HyDLuEIeQXBPLOlFm/cdRukmFibZVm/DpTeU6NTxZlLPK+Vh5FiIH7M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C77597D9B4BDD24BB326AC5DCA46B406@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df507fe-e71f-45e0-39a1-08d6296efcbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2018 20:29:58.0372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YXQgMTI6NDMgUE0sIGhwYUB6eXRvci5jb20gd3JvdGU6DQoNCj4gDQo+IERvZXMgLXBpcGUgYWN0
dWFsbHkgd2luIGFueXRoaW5nIHRoZXNlIGRheXM/DQoNClNvcnJ5LCBJIGRvbuKAmXQgaGF2ZSB0
aGUgdGltZSB0byBjaGVjayBpdCByaWdodCBub3cuIEFueWhvdywgSSBwcmVzdW1lIGl0IGlzDQpi
ZXN0IHRoYXQgc3VjaCBhIGNoYW5nZSB3aWxsIGJlIGluIGEgc2VwYXJhdGUgcGF0Y2guDQoNCg==
