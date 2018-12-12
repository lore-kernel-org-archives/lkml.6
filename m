Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBAAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B6520811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="hupDtHvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B6520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeLLGbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:31:05 -0500
Received: from mail-eopbgr740057.outbound.protection.outlook.com ([40.107.74.57]:7296
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbeLLGbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89HY2Jv2iOEdYcP5pVK15flHGEe7OIty96GuxWT3nG8=;
 b=hupDtHvkKTFABpJbCj2hnlT5++Yk9puOdVj0BBbY6qCasO8hNcbIg21/e6/+uSBn6B0KxHUWGjQNCbcU37HZVFpvNc6ZcP684PEFEnEOqXSLO+fPOZ7sV28Ro4KUGwawEWbm3BGZyp8uLUi0WQnWLQapy7q1Mk+DK84A0UmYx4g=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5382.namprd05.prod.outlook.com (20.177.184.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.10; Wed, 12 Dec 2018 06:30:57 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::9155:fea7:9c0c:68c7%4]) with mapi id 15.20.1446.006; Wed, 12 Dec 2018
 06:30:56 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "jannh@google.com" <jannh@google.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "deneen.t.dock@intel.com" <deneen.t.dock@intel.com>
Subject: Re: [PATCH v2 4/4] x86/vmalloc: Add TLB efficient x86 arch_vunmap
Thread-Topic: [PATCH v2 4/4] x86/vmalloc: Add TLB efficient x86 arch_vunmap
Thread-Index: AQHUka9WxGYYYvHGvUG9E8loVoLjfqV6pRmA
Date:   Wed, 12 Dec 2018 06:30:56 +0000
Message-ID: <90B10050-0CF1-48B2-B671-508FB092C2FE@vmware.com>
References: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
 <20181212000354.31955-5-rick.p.edgecombe@intel.com>
In-Reply-To: <20181212000354.31955-5-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:647:4580:b719:556e:cbaa:858b:f6f3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5382;20:YFdBNi+KTiNkuvGCttBlrE7S3U6YGP6ob6e+IiTCKjKBlE5nqwPbMqqopeNRtuSIopvNt/r9EDvjgYs+fjiFytKRuDwXDTL8RqyR5fBgQvixeRb03AwCa8H8Qs2q40hPqFAmvU0swS4PkDBFIiEd2/kycLqsJ8iJnNKNYfX54Cg=
x-ms-office365-filtering-correlation-id: 60c38c5f-eec9-4f2d-8d08-08d65ffb5fe4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5382;
x-ms-traffictypediagnostic: BYAPR05MB5382:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-prvs: <BYAPR05MB5382C51AD29AEA2EE18B9FB0D0A70@BYAPR05MB5382.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231472)(944501520)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5382;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5382;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(81166006)(7736002)(81156014)(8936002)(8676002)(6116002)(54906003)(53936002)(4326008)(33656002)(6512007)(6246003)(102836004)(186003)(97736004)(305945005)(46003)(6916009)(53546011)(99286004)(6486002)(446003)(82746002)(105586002)(6436002)(11346002)(86362001)(256004)(71190400001)(316002)(6506007)(5660300001)(76176011)(229853002)(2616005)(106356001)(486006)(476003)(478600001)(7416002)(14444005)(71200400001)(25786009)(14454004)(2906002)(36756003)(68736007)(83716004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5382;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dBmShlgqzyB3WD8PP1cTkrIOMgJiyPHYoDPVyd5/xQdQlnTUq6zYhiM6fSe7n/ARB5v/RQUtzvgBP2ycovoazXLAl+dUFyegh4zOY/uzRHcWvuPC8fmLxxstzz+bTYL88vM6SIHoyfHd/Wq01Rr0MyneTXurb+Pf4c7MaZidYpygai6964KbV5KOdiu7IL/lX2KOAFP1ja8TAoaiv2tY5h5wk8gpFZsdm1Nd+EuBrr8bO+PgpkPYUS/LFQcxil9aAWkCf6jJGQeOgVP5zd//SH54J3f5TCUuxo+c+i0T3UUgcXeyuzBwXes0RLYGfJT8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D8FBBAF5802454AB9BBEEE3320BC3F6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c38c5f-eec9-4f2d-8d08-08d65ffb5fe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 06:30:56.6375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 11, 2018, at 4:03 PM, Rick Edgecombe <rick.p.edgecombe@intel.com> =
wrote:
>=20
> This adds a more efficient x86 architecture specific implementation of
> arch_vunmap, that can free any type of special permission memory with onl=
y 1 TLB
> flush.
>=20
> In order to enable this, _set_pages_p and _set_pages_np are made non-stat=
ic and
> renamed set_pages_p_noflush and set_pages_np_noflush to better communicat=
e
> their different (non-flushing) behavior from the rest of the set_pages_*
> functions.
>=20
> The method for doing this with only 1 TLB flush was suggested by Andy
> Lutomirski.
>=20

[snip]

> +	/*
> +	 * If the vm being freed has security sensitive capabilities such as
> +	 * executable we need to make sure there is no W window on the directma=
p
> +	 * before removing the X in the TLB. So we set not present first so we
> +	 * can flush without any other CPU picking up the mapping. Then we rese=
t
> +	 * RW+P without a flush, since NP prevented it from being cached by
> +	 * other cpus.
> +	 */
> +	set_area_direct_np(area);
> +	vm_unmap_aliases();

Does vm_unmap_aliases() flush in the TLB the direct mapping range as well? =
I
can only find the flush of the vmalloc range.

