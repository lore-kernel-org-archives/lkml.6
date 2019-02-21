Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A604C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D05E208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Ls77zZQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfBUUgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:36:11 -0500
Received: from mail-eopbgr790099.outbound.protection.outlook.com ([40.107.79.99]:45569
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726075AbfBUUgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvVxTgaQCC/ZO97TeK5sWX6YQMyaynKuyT708mUQdk8=;
 b=Ls77zZQeB9bfFkzaul5ONFTwtWwNVdY3mimYkjT+AU7mT1gtSj1DX2R/3F3L9v39RfuxaybydPS8uf98JtDQ0rLRauVTi48zD8PQ9iySdI2WB2j1vi8swppJfsOmy4u2cZXQhFzVpVI/VXy1zyfG3K8BrELLiGD9p3B1SKZAGqU=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1021.namprd22.prod.outlook.com (10.174.167.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 21 Feb 2019 20:36:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 20:36:07 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Lars Persson <lars.persson@axis.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Lars Persson <larper@axis.com>
Subject: Re: [PATCH] mm: migrate: add missing flush_dcache_page for non-mapped
 page migrate
Thread-Topic: [PATCH] mm: migrate: add missing flush_dcache_page for
 non-mapped page migrate
Thread-Index: AQHUyiUSoroQVsfK+02zHKedVgOtOQ==
Date:   Thu, 21 Feb 2019 20:36:07 +0000
Message-ID: <20190221203606.mzkgcaln6kw7xaxh@pburton-laptop>
References: <20190219123212.29838-1-larper@axis.com>
In-Reply-To: <20190219123212.29838-1-larper@axis.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00515087-bed6-4c29-5454-08d6983c34ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1021;
x-ms-traffictypediagnostic: MWHPR2201MB1021:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1021;23:or2LWksf57Jzls32f1BsZTiNcze4wyBt6Xo/0A3?=
 =?us-ascii?Q?MiwjLBSocSyPDaOjYpuQrI1mOCNIWSP2RQzCdOXGIGiwL329tUotpcXMHydO?=
 =?us-ascii?Q?1FP3eSCIIiE7FZgtqzEy5BOT3Z1hCIyliyl6e5Fw6094o6QhiBd/267FvdPh?=
 =?us-ascii?Q?pHx67kxSFqdHm6Sst9aaT1/GR1UfR/EaWQ3joQ9PlmPmMI1B9RlzlmU9McRW?=
 =?us-ascii?Q?w0lXMBG3swQMLQunIH3hUU4x/kkXpwBiq+7BR3R0TrAZwTdN87JgsMJZE5Km?=
 =?us-ascii?Q?nMA4Q4hvnF+qyPQJkTUv8sfh4mM+BJhEBHKYPcsxjqR0RT9eMa9UjERaVz+Y?=
 =?us-ascii?Q?NMWlK8Dv+o20JuYU2bCXiL1txQVJUY7OuqB8hC5pGMMGE134yd98TWjO9hjW?=
 =?us-ascii?Q?pdgZTFmt9DcSUN9pek0mbKjSGQ4EEeusNs9ou3t6DdtSc4qf1j2JGdEaEhtk?=
 =?us-ascii?Q?ApCFSaQ9oKAL8GgOY+kmt0Y0dZPJ9rTmQSRAeSVP1R6plxppc3/0m6BDHKD3?=
 =?us-ascii?Q?7IW8vH/AMbcO1ttFuB1Y+mnkQr3hqq73YadPQ+pPSrevsv3JBovkhpMLKqj6?=
 =?us-ascii?Q?wjHufXSyWpcCjvXvvzVw15Fq00T1X6FDbpisIlcs6HyxO4VHeV5t94k8pANg?=
 =?us-ascii?Q?kNwHjmFD9pi93wcadkr1g5XDNWV8/VeRrQ7LjudAd2xd5bquTFQpQNHbZibh?=
 =?us-ascii?Q?nj5GXC7MbIO6m7SRBVa2EvtuwrjxPv6xxyiwK15NrI/uD0QvZM4HznQyeRVy?=
 =?us-ascii?Q?BIPBFL8jGjaQuDBfOjiOcBVKfE06uJcRBEMcGnBBjQrhIvbOulugJwbNE6Ox?=
 =?us-ascii?Q?EhpH5toSYIwa/CQBqNlfq0lxwEBQ9wZTOi58D6rEscXY+Q79AdUU0zVt074r?=
 =?us-ascii?Q?surDSlUzCwoaoSOx0NttOmteYoaMdxbTukh2KgL4DBDsYW13a9AU/VwfWMU5?=
 =?us-ascii?Q?vZjW7g7q1ideNJBQZainaSC+iIkfw80UK5DjfBNq9XCVfjICp5ZqdXbw9qpa?=
 =?us-ascii?Q?4vqT0G7SOACVs+jiLOyYcvHBJRnqbfN17RD0SPOyfW+IbQGVca/D8LniMsbG?=
 =?us-ascii?Q?gHKITlvNcD8gJjba9vhgeRJh6NGoqzswpN0ht1Wlp8ZFLvLfvHawLPYhZRRh?=
 =?us-ascii?Q?T+5NwbAH2z7jX4CrA4sV9OYOqfkJSj0vUPcgInqk9QL6W/anjDkih/RQK7LY?=
 =?us-ascii?Q?FM8WmkqF6xJg0MSU69M5hqi4W13FcI2LHnITmSQoecYpk19xMOa78SeL1QBY?=
 =?us-ascii?Q?4Utm4/uySrX2qZjXlppXUjwK9G6oHW1Bae6USR1Yqd4TyVn4zub4ULbFdN+1?=
 =?us-ascii?Q?7gDXWRhadL+9KuzGWDxGuSOZWMaRfeXB2gPiGpfTf3PZr?=
x-microsoft-antispam-prvs: <MWHPR2201MB10210BEAEDF2E8EC92A0E210C17E0@MWHPR2201MB1021.namprd22.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39850400004)(396003)(366004)(376002)(346002)(136003)(199004)(189003)(305945005)(44832011)(7736002)(476003)(9686003)(186003)(6512007)(81166006)(71200400001)(8936002)(81156014)(105586002)(106356001)(25786009)(71190400001)(8676002)(6486002)(6346003)(26005)(6436002)(97736004)(102836004)(99286004)(68736007)(486006)(316002)(229853002)(6916009)(58126008)(33716001)(6506007)(33896004)(386003)(76176011)(446003)(3846002)(6116002)(53936002)(11346002)(54906003)(14454004)(52116002)(256004)(5660300002)(14444005)(2906002)(6246003)(42882007)(4326008)(1076003)(478600001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1021;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JW9hGi75CRVl95jsZX74CeVCFw2/xM8XPjtAq424n7cW8CWfkmZ1kaoX6SmpKqfBfDxouyYd1Fw3ouvrDu0czh0C3JXABjn7W2bFRyWewWwwZE8nhpnPDDkqzN+H2TJAaVVK5d3HBaKC+dwKoBQ0iCELph0s/slTsfqV7/2JvlQShkuMlhGGSmfIeTut923cJkgZIt4HHIiR2txHsML51UvHbuB+JM89l5jr5SpO+SRMCrgPVbC9dtclFfQLe9TwD4n8jsfzFTEYuYeu/6P81LHppsja0CYr0OJBOXJbn7PvElI0FjoW11K+9eHF+u6ROCQOtWxdiVGWHtI//nzK9Ojt98DmegTut2h22ml1acg7O/yvxpg3kPuLni5rxS1qEQZsCdcDJ8WzKKnoZXlWS30gXV97zgHz1IVHfSmFy/Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CAEBE38F92F5394B84B05B0045FFD62B@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00515087-bed6-4c29-5454-08d6983c34ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 20:36:07.2306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Tue, Feb 19, 2019 at 01:32:12PM +0100, Lars Persson wrote:
> Our MIPS 1004Kc SoCs were seeing random userspace crashes with SIGILL
> and SIGSEGV that could not be traced back to a userspace code
> bug. They had all the magic signs of an I/D cache coherency issue.
>=20
> Now recently we noticed that the /proc/sys/vm/compact_memory interface
> was quite efficient at provoking this class of userspace crashes.
>=20
> Studying the code in mm/migrate.c there is a distinction made between
> migrating a page that is mapped at the instant of migration and one
> that is not mapped. Our problem turned out to be the non-mapped pages.
>=20
> For the non-mapped page the code performs a copy of the page content
> and all relevant meta-data of the page without doing the required
> D-cache maintenance. This leaves dirty data in the D-cache of the CPU
> and on the 1004K cores this data is not visible to the I-cache. A
> subsequent page-fault that triggers a mapping of the page will happily
> serve the process with potentially stale code.
>=20
> What about ARM then, this bug should have seen greater exposure? Well
> ARM became immune to this flaw back in 2010, see commit c01778001a4f
> ("ARM: 6379/1: Assume new page cache pages have dirty D-cache").
>=20
> My proposed fix moves the D-cache maintenance inside move_to_new_page
> to make it common for both cases.
>=20
> Signed-off-by: Lars Persson <larper@axis.com>

Reviewed-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  mm/migrate.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
