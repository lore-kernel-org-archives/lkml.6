Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDB9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7786E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="JaOxs/Sd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7786E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeK0HwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:52:17 -0500
Received: from mail-eopbgr740137.outbound.protection.outlook.com ([40.107.74.137]:50460
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727105AbeK0HwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4BPa4CBlxH2/iFA48bTrShQbAjXxR8zRKo71qr2pwg=;
 b=JaOxs/SdW1tbAgxfBhFm289hngHe3aO6YK/jksybW9gdwwvyqXdRJW3jangYd0moSt0OkcuKj7cXoV3LYbRDDFLCVPLiRaFWEoIIBWGTEk+P8HtUaawBKF6Q9ly/s8ixOWJXOyuFLx/ophgQiuLImc337XvSeXz2tCA7G5tS/OQ=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0759.namprd21.prod.outlook.com (10.173.192.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1404.5; Mon, 26 Nov 2018 20:56:50 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::f597:e00a:584b:fd8c%2]) with mapi id 15.20.1404.002; Mon, 26 Nov 2018
 20:56:50 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@armm.com" <catalin.marinas@armm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Thread-Topic: [PATCH 3/4] Drivers: hv: vmbus: Add hooks for per-CPU IRQ
Thread-Index: AQHUghEmRPt7Kjul9E+Q8Cz+6wluT6VidjKAgAAFstCAAAR8gIAAAInQ
Date:   Mon, 26 Nov 2018 20:56:50 +0000
Message-ID: <CY4PR21MB0773AFA3555BC08A4CC129D4D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-3-kys@linuxonhyperv.com>
 <20181126192101.GC32208@kroah.com>
 <CY4PR21MB07735AB610D4BFD3EB7556D5D7D70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <20181126195727.GA9957@kroah.com>
In-Reply-To: <20181126195727.GA9957@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-26T20:56:48.3225463Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:ed00:bad5:da35:76f9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0759;6:cja+cqgmVwLt84SJjnQ79GE3i+Um4utf431R6IKoIb+AM1dnbRQQhTL4Q5XzMPE98Rkn6pNdC0K+5ZiCOclmn+FPReB7lInPdrVSpuApWl3wBikEtBGltUpeF111HOrKbsqPJP0DV7U/5MaMgErdMoGMFUFIyPa9vjhWBr6QjPpCR6B8ppKoa0KUYQIjgVEclleT038EippYlpjL4db769IIhbfQP7S+rnOm2cBvQBDWsEbOKHzVfZ5WN6GnvPJUd2PKPhDXdhFLhLEvcxtIGEIIwVWon2eLYjWHChB1dUcqZHwnYZCM7iLBgwEHaGbq8Kf2Rnn25e0vXDpkH9ICxDW49FuKKjSCluOKS2IwaCCXOerZpT3OPagzxEPiBR9Gk4/dLsF2KPhr0vIXWAMKdUW6FuPDPYFq91wUQR8CPoMg0o1LxOMKiL8aVuA0XJzepsx9p/gBlFjGBAsbqNdzxg==;5:MkWT5sZHxoNCilRh/wqrIPlZOuoZIpjYsSAS68gB+thLNPaNMlkBSU4AiN3O9F7T51VYHUENYHRLDzXmdhfYXZlr1pRbRxCi5E5ms2iGoV7DTIiby1VXd3bpCjff//uvWsS2FYtzGPDR9A/Bzv4X3zZSQyF6NZra5yYs+7v6+eU=;7:ieIj3cU7ECkg8ocI8XDjK0ntvX6KqaG1hVV1dT4zkgSyTZYCXydg+GvwGV5ihs2wEh559pgOSBkvpj72wgbYSw0TSZ4xQA7maiTocHf91GvIt4BdV3ZEu0v9Wae2cETA4a30PQXSUSRMC4jF0xZSoQ==
x-ms-office365-filtering-correlation-id: 4b3378c6-ebe0-4072-1091-08d653e1b017
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0759;
x-ms-traffictypediagnostic: CY4PR21MB0759:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB0759C841060D01BF6427690CD7D70@CY4PR21MB0759.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231443)(944501421)(2018427008)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY4PR21MB0759;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0759;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(396003)(136003)(346002)(39860400002)(199004)(189003)(478600001)(4326008)(229853002)(25786009)(14454004)(186003)(33656002)(68736007)(81166006)(8936002)(81156014)(105586002)(446003)(11346002)(10290500003)(106356001)(8676002)(46003)(6916009)(6116002)(8990500004)(2906002)(10090500001)(486006)(476003)(99286004)(7696005)(9686003)(54906003)(76176011)(74316002)(6436002)(305945005)(7736002)(55016002)(53936002)(256004)(86362001)(5660300001)(6506007)(6246003)(93886005)(22452003)(316002)(7416002)(86612001)(71190400001)(102836004)(97736004)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0759;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iSGZ20BjqLwGCWhrdDqo0Su3srRxH4PRZ5EqQ9lG6jKAbOgx8Fu7sFqhLKy9KHlA2AGXpfIjp7S/i2aI64+7EhaDgxdtamyhXylzy/5oTKo3czx1hVSphS+A/vNWilAPNETEou2WNKtwr7pde2XcE7rBGnGi2dSbfwyW6N21XVgod6fszZKk2l1INYcsDc8MxQ6f72UopZB/H1wpUhUem47uA5BuEX4w91dR1UMw4qtrRhXEnLgW3BjI9x7TvGDyIyGgH/eiQ7/UyS+H5FHl6sI7t4ecrwnEdW57IwmWxEQ40kUtZUFsVLs7rBVpiHsuG5OepcO7DPxWMKk+BmRKjfk0y+ajNWYCy7xjoumRpGA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3378c6-ebe0-4072-1091-08d653e1b017
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 20:56:50.4150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org>  Monday, November 26, 2018 11:57=
 AM

> > > You created "null" hooks that do nothing, for no one in this patch
> > > series, why?
> > >
> >
> > hv_enable_vmbus_irq() and hv_disable_vmbus_irq() have non-null
> > implementations in the ARM64 code in patch 2 of this series.  The
> > implementations are in the new file arch/arm64/hyperv/mshyperv.c.
> > Or am I misunderstanding your point?
>=20
> So you use a hook in an earlier patch and then add it in a later one?
>=20
> Shouldn't you do it the other way around?  As it is, the earlier patch
> should not work properly, right?

The earlier patch implements the hook on the ARM64 side but it is
unused -- it's not called.  The later patch then calls it.  Wouldn't the
other way around be backwards?

The general approach is for patches 1 and 2 of the series to provide
all the new code under arch/arm64 to enable Hyper-V.  But the code
won't get called (or even built) with just these two patches because
CONFIG_HYPERV can't be selected.  Patch 3 is separate because it
applies to architecture independent code and arch/x86 code -- I thought
there might be value in keeping the ARM64 and x86 patches distinct.=20
Patch 4 applies to architecture independent code, and enables the
ARM64 code in patches 1 and 2 to be compiled and run when
CONFIG_HYPERV is selected.

If combining some of the patches in the series is a better approach, I'm
good with that.

Michael
