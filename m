Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE64C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD7F206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 19:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FBnn188s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbeLNT3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:29:44 -0500
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:63940
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730123AbeLNT3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 14:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VR2BRpsO929GsbFygTnAfa0/M/uLjo4tGJWuJuINUA=;
 b=FBnn188soZGTH3k0SdlBTnJqsDbcYWFRoAzRD4/HzXoHtMAp2R3cvNg7Gfc7iT8Wty39LgcK7uQknanSBUDBVtYCkc211LB+VoyqtDl4+lGLxKcJ3q7DFRxprGp79Zm8OnEy+Fj0zh+Z0pcPgkhtSTMNBM89FxB2XWN68rjuY0A=
Received: from DB8PR08MB4107.eurprd08.prod.outlook.com (20.179.11.13) by
 DB8PR08MB4042.eurprd08.prod.outlook.com (20.179.10.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 14 Dec 2018 19:28:57 +0000
Received: from DB8PR08MB4107.eurprd08.prod.outlook.com
 ([fe80::3c72:426b:5847:22e3]) by DB8PR08MB4107.eurprd08.prod.outlook.com
 ([fe80::3c72:426b:5847:22e3%5]) with mapi id 15.20.1404.026; Fri, 14 Dec 2018
 19:28:57 +0000
From:   Dave P Martin <Dave.Martin@arm.com>
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>
CC:     nd <nd@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Hayward <Alan.Hayward@arm.com>
Subject: Re: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Topic: [PATCH 0/3] arm64/sve: UAPI: Disentangle ptrace.h from
 sigcontext.h
Thread-Index: AQHUkYd5TQtknm9R4kqjkh+b7I8GJaV+jmIAgAADSQCAAAm4gIAACA+A
Date:   Fri, 14 Dec 2018 19:28:57 +0000
Message-ID: <20181214192855.GD4719@e103592.cambridge.arm.com>
References: <1544556407-19897-1-git-send-email-Dave.Martin@arm.com>
 <2abbbd29-cc87-a0ad-80b7-e2a1d039235e@arm.com>
 <20181214182518.GH3505@e103592.cambridge.arm.com>
 <5e96f169-d77d-63d0-11ba-f59f572b0219@arm.com>
In-Reply-To: <5e96f169-d77d-63d0-11ba-f59f572b0219@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0263.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::35) To DB8PR08MB4107.eurprd08.prod.outlook.com
 (2603:10a6:10:ac::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB8PR08MB4042;6:/AbJXshxndZPkBb29Q1G/DKmU3q/dsOMjQfyZzdFsiEwB0sVFi4lFTBfq9Zh1NNnexVIFnHKLIrdOB/nTWeEhshl99zMOorMBCDH/0udCcNiro7Agn6DJ6wquzSD2OJpMjbSSON9W54r5DgtmvE2pdt471YL/CNqjvogmAgHFOQQ0QN+tjU3XcPLEP2JzbtVW4CGP9Y1Joi31U8cL9GBamVtxxmWrvYaBk/V0Uf+95V2EAQAkOa9bnieRhby0WR6KYxFGm7DSQeQXGnH0QXiNUCiogSTY8R0eM0J53tJcvfBY0Q5SLC6ZU+k7OKUOtltHGa5/UzAyVy5yzmvt/Ahs/EbReGLehBNq1jeiITG5cc0oKxOmdpX9gXB/+6wzBTaZySodVkkmDNp/TBVWTNZQCPQXZBx5/tRBx23A8rbV0534P4SaV5FnNI784jyqwpMPD2MyLU9tRS0Ieq+VWriZw==;5:d4lNf6FDZr/hdN4/wIKlbZx80zBqlm10WEI1aHSmKNNd2FNuyCiiqpTYkKkGu8owcLh6qlXi+xCRUcJ+RkyO9eLpEcC1GFrhs865Hw7KLpc3K7iaRnFSZgnopvFB+Df/ouRX+Vel92woEZSUXsaGZ8daLKAGHepED5XBntIrW+s=;7:ENuLTf4lsFqUNb+vUunQpwwB12GUZvIpIIDxEp2EzPfsq7stQLVqOmMoqyf18smLNIDtsT7hA2xJZ58OmEdfM3usjBGJ5gJa2FlR+O8CaWlvI94Wbrrj10Q5BXjs/6N/d8hS0ws7Gm2l/uMLUVo9NA==
x-ms-office365-filtering-correlation-id: 30e1f369-5ef1-4a3f-1595-08d661fa6454
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR08MB4042;
x-ms-traffictypediagnostic: DB8PR08MB4042:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB8PR08MB404254EF45561D73772A3D7BFEA10@DB8PR08MB4042.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231475)(944501520)(4982022)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB8PR08MB4042;BCL:0;PCL:0;RULEID:;SRVR:DB8PR08MB4042;
x-forefront-prvs: 08864C38AC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(136003)(396003)(199004)(189003)(6636002)(476003)(446003)(11346002)(2906002)(486006)(305945005)(97736004)(26005)(71190400001)(186003)(71200400001)(256004)(6486002)(76176011)(53546011)(386003)(102836004)(5660300001)(6436002)(229853002)(3846002)(86362001)(6116002)(1076002)(478600001)(53936002)(14454004)(7736002)(72206003)(966005)(54906003)(6506007)(66066001)(4326008)(99286004)(6862004)(52116002)(93886005)(33656002)(6512007)(316002)(58126008)(6306002)(106356001)(68736007)(6246003)(25786009)(105586002)(81156014)(8936002)(8676002)(81166006)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4042;H:DB8PR08MB4107.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d34bPWIS+mheXW2l6JCjLn9+rblso/T/dVNjjpSNp8ztQr9Pc0iFP67JBuJqGvqTmYy8bMjKmLh13CubY0xBGXB9QKsJM5PdqOLPVxT5PBnNv5fupagMzUCBi2BjTBHbh7/s/049dwROmIiO6O0b/glQYp21C2CxtJWaJu5kXOXY41VTXO/xegPg8svAoNQtks3+wJivuhiC+Ct2ANF7DYzbZjEUPBqlXd4+MbnFrS6BJRHhhZIOQK7pQlfdyUDeYKBhYnAhQQe2neD/6ZGvNNg+W6kAPis0wzK5NQsVV30TFdWat5hLAq5PN2/Wm7RA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B58B088301928442A52305442D84A4C5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e1f369-5ef1-4a3f-1595-08d661fa6454
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2018 19:28:57.4775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 07:00:07PM +0000, Szabolcs Nagy wrote:
> On 14/12/2018 18:25, Dave Martin wrote:
> > On Fri, Dec 14, 2018 at 06:13:33PM +0000, Szabolcs Nagy wrote:
> >> On 11/12/2018 19:26, Dave Martin wrote:
> >>> This patch refactors the UAPI header definitions for the Arm SVE
> >>> extension to avoid multiple-definition problems when userspace mixes =
its
> >>> own sigcontext.h definitions with the kernel's ptrace.h (which is
> >>> apparently routine).
> >>>
> >>> A common backend header is created to hold common definitions, suitab=
ly
> >>> namespaced, and with an appropriate header guard.
> >>>
> >>> See the commit message in patch 3 for further explanation of why this
> >>> is needed.
> >>>
> >>> Because of the non-trivial header guard in the new sve_context.h, pat=
ch
> >>> 1 adds support to headers_install.sh to munge #if defined(_UAPI_FOO) =
in
> >>> a similar way to the current handling of #ifndef _UAPI_FOO.
> >>>
> >>
> >> thanks for doing this.
> >>
> >> the patches fix the gdb build issue on musl libc with an
> >> additional gdb patch:
> >> https://sourceware.org/ml/gdb-patches/2018-12/msg00152.html
> >> (in userspace i'd expect users relying on signal.h providing
> >> whatever is in asm/sigcontext.h.)
> >>
> >> i think sve_context.h could be made to work with direct include,
> >> even if that's not useful because there is no public api there.
> >> (and then you dont need the first patch)
> >=20
> > My general view is that if you want the sigframe types userspace should
> > usually include <ucontext.h> and refer to mcontext_t.
> >=20
>=20
> ucontext.h does not expose the asm/sigcontext.h types in glibc,
> but it is compatible with the inclusion of asm/sigcontext.h
> (or signal.h).
>=20
> in musl ucontext.h includes signal.h and signal.h provides
> the asm/sigcontext.h api with abi compatible definitions.
>=20
> > Because the prototype for sa_sigaction() specifies a void * for the
> > ucontext argument, I've generally assumed that <signal.h> is not
> > sufficient to get ucontext_t (or mcontext_t) (but maybe I'm too paranoi=
d
> > there).
>=20
> http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/signal.h.html
>=20
> "The <signal.h> header shall define the ucontext_t type as a structure
>  that shall include at least the following members:
> ...
>  mcontext_t  uc_mcontext A machine-specific representation of the saved
>              context."
>=20
> so signal.h must define ucontext_t but mcontext_t can be opaque.
> (it is opaque with posix conform feature tests to avoid
> namespace pollution, but with _GNU_SOURCE defined all
> asm/sigcontext.h apis are there and mcontext_t matches
> struct sigcontext)

I see.  Sounds reasonable.

> >=20
> > Non-POSIX-flavoured software might include <asm/sigcontext.h> directly.
> > In glibc/musl libc will that conflict with <signal.h>, or can the two
> > coexist?
>=20
> if you compile e.g in standard conform mode then
> i think signal.h and asm/sigcontext.h are compatible.

So long as we don't break any existing usage (?) I guess this is fine.

Cheers
---Dave
