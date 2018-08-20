Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D767C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CC8206B2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="WNl+6ou/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CC8206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeHTVvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:51:25 -0400
Received: from mail-eopbgr730113.outbound.protection.outlook.com ([40.107.73.113]:28539
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbeHTVvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W8rchIZuBBwWufoescXf9LVkpw2kurORbSR6aWKOJY=;
 b=WNl+6ou/3UFbXkti3RTNOO4bOvT7DkH3kAG6EGsbJvTDYXj/ToUBuC0/gvrCC94/rAXl5Kg362nAI8mRPSUC5a5yDwd3lhvolVswK2jNr7piFUzKCzcEYze97kVa+O/6Nudv9WajXxB9EzhmhUVBioqm0/wV664htDA+YrbimQE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4936.namprd08.prod.outlook.com (2603:10b6:a03:6a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 18:34:20 +0000
Date:   Mon, 20 Aug 2018 11:34:17 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v8 1/2] kbuild: Allow asm-specific compiler_types.h
Message-ID: <20180820183417.dejfsluih7elbclu@pburton-laptop>
References: <20180818181017.1246-1-paul.burton@mips.com>
 <20180818181017.1246-2-paul.burton@mips.com>
 <CAK7LNASM_ZThZRwFQJFaYqurqUVayNGPM6c7gnuHERYN7T4M3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASM_ZThZRwFQJFaYqurqUVayNGPM6c7gnuHERYN7T4M3g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR1001CA0029.namprd10.prod.outlook.com
 (2603:10b6:405:28::42) To BYAPR08MB4936.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d4341a1-46d0-4e8e-ff7b-08d606cb8bbc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4936;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;3:qfmyxYBdyOPmRo1IFu85z+hNmECcQQpfg77VNZ58RClYl7mfeIH+PGS7IV6fhvcRWLAwUC661MKIwlnKuebAWJl9uOAFA3JZ56/NoW/ydG+xmbjMJkLzdqwY8g8dzBvvfrZvoLatUbms6O5p1Ny9EKZ2qCr+T1sTS+iFjxvIWZheFA5Zdrt9mZry8t3lHJv7ITwXyqy1kP58NnwRG6BaZCL3chb1Q8z7pKXm2rsfqhI3PpWIrXxwUsHZCAew6k9U;25:PKtLmCtfCoZoaM5zTSAiu8kK3xLPcGDGg0K59OGukg6+f/M5iUdeBH2TiQFJmbGDhJTKd20Z4meiSrQuHq29TvxWNEChI09hcQxtKA1KPj+4wZNaM42Aus4yZGp9M30vMI/WU4P+YZZezLP3WtX0cMC/g/Az+mxlyBowy+nJKz5T25MPEtcwUU91aeRl5mDfFvl4yuX1Ht5YpwUzB827X41tkEDAsXrQFlRSNp2nFGuwRT6P112aJbZJfkQngvH1OVXA7SYV6lJUm4THfsvDKocgxPSVz06pielOfjA5Q7ICrjq9DvnY4XItOAd4cMt23PVltf+csgIzD5zG9Tp5Eg==;31:RlsDyX1dvHWLVp8GBNUfwy5T6DDtPcEhf0QYaG1QLYup7SsKPsKposBuDxpERExg3RUJxAkGVewcRgIUBdGKOE0mT1WoMyWyTNR3Tx/ZVgbzRlVMMkMgAnIj4uurqS7WL8I5rby3p58Xk8hdINMQANiWc7naU/6PP3Br9156u3lnzElP5+JNbGtLAl2GSmovujDhCoGZF6ruIwdSKkeK42PJrmzezwqbhjOfrT7Ekvw=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4936:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;20:Oplfunm77ShnefCMAFUs/060PxTWvxCjgZtF3xRZag27P52z5+eAlNXbpmb0G9gVkQJTuCm1zcO2BwyIVctP25+kGnZ1Gfq8dFrGYhZXmBgOGqZwgXjlr1KOV5N2Rm2R36gn1tAgSzLkHq4cIHJHoxLxTz2gGXocwJ+uCS/W+WvVjHyfuqIRHLbn9hS0YBpqIE2VDLchvEnFhmUx9+dpEpJINcrA5Cenr2TLsJM4I2uRrguEfzKZTlKOp4eWX+AP;4:J2d/+9x3/Ixz0e3bWg7WJLX1a72d0+RNIGRkQcfa8rf+8rGH5Ugb/xxSjWktpiCkHyi8g7F6Q1Vig3VC9o++Q1bjKHIcWbATeO/W+SGpcEEXmWYlA+ke+sl5o5lCDTNGeiNu/XGwfvBb5f6o9QTXb3fmqufERa6xkeoxjNAQatWc19Yd5Llw9AfkUkdimltaHqP1nc59tW2Ty+bUqOxFif7M3I4iFkbbYaj3HThrTkNUO+iTspYB8tmvsG5HAUmL7vU+DW1xnl35ujZ3V4yAzg==
X-Microsoft-Antispam-PRVS: <BYAPR08MB493657E74086BFC7EEAE616BC1320@BYAPR08MB4936.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(20161123555045)(201703061421075)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4936;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4936;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(136003)(376002)(346002)(199004)(189003)(33896004)(33716001)(6496006)(52116002)(66066001)(229853002)(6486002)(25786009)(76176011)(50466002)(305945005)(4326008)(9686003)(6246003)(76506005)(7736002)(3846002)(53936002)(105586002)(6666003)(106356001)(47776003)(1076002)(23726003)(6116002)(54906003)(956004)(476003)(6916009)(486006)(58126008)(42882007)(97736004)(16586007)(446003)(68736007)(11346002)(2906002)(44832011)(81166006)(81156014)(26005)(508600001)(16526019)(186003)(14444005)(386003)(8676002)(8936002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4936;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4936;23:Lscs4PA/nndwiOPFMbEheomNDE/2YXLOwEHGLzC38?=
 =?us-ascii?Q?aB5ba2hZvLZCVZVVssczQWA6L44Jjtt6F9mLOJt622yk2wkf75X7okj4jqKZ?=
 =?us-ascii?Q?3fMz0SQQeMtuiy9x/zc123+K2c8t1Pk9UrUGt8OLjzkmo9oCwcJEgSHR0UoN?=
 =?us-ascii?Q?psOaSyt7LVLps9pCHiN5IfjNCBzgEvpnBxtCGQrO3MOPXhJ1F0qa5d8LrvPZ?=
 =?us-ascii?Q?M5NunyueMypbpgEKy8Mxm7NlVGjflFSCVpBzEf6coRQNg6PjGU55U530td+L?=
 =?us-ascii?Q?4/4hN8KBdZHSb+R5NKjiLU88ipMEtN5xWkRgd4zN/Ks3V5FI5vx6200TQKnv?=
 =?us-ascii?Q?YjXnpxWBg2gfdXf1DCWRjqT+s8dcRfdg6pTjTs8dqMkIn0QevQaKVd6jQxmI?=
 =?us-ascii?Q?nQ/mT+DPyTWr+U+LY/raOlQpssPvaNYAiNftf1SACzmyPmZkavEKNTiP5r2/?=
 =?us-ascii?Q?aGuQyEI/3hrfjmsUNqbnPv7rjZwaojiAczE8x+GMdldsUd7G5r7TMYkiKliO?=
 =?us-ascii?Q?PGcBJO0MlxU7Cv5iDEzAAKVAq1se9I2/FQh9LN3J82oKl2Yc8U43ZeyQ2/6m?=
 =?us-ascii?Q?1UG4sL/gDqp/za2AgdB5Kc4EaDVpiLUkHJzCu9xUwRqas27aQ7f+pgRgSW+8?=
 =?us-ascii?Q?MhuaiFGEybWSCbjJr5b/NNHKexABa0upi60Sg+OsISKbiKkeh/XSYTPCf5dJ?=
 =?us-ascii?Q?mUonMHpZ1HANo07/JvPrcQccE/WwA/z8obWHk9OLS6MOKfNFd4VCtXp/x4J+?=
 =?us-ascii?Q?b3ITuzL6r7BjE5DkI+K/6ji+JrTc5Gl9WZ5QJCjlfPLRIOyJ9EVD/z4hHPXR?=
 =?us-ascii?Q?rU+jHAbFlUAFPjb86gEklsYVLYFGZR8/YIX+1f+f/s22gDf0NZxaMfMOGfUO?=
 =?us-ascii?Q?5ymeDQJmTJjwEHcnmkk0jHkt8FLmw2dqqREsGwX8SFAR/OiLuqs2Fm373n5O?=
 =?us-ascii?Q?ylwN1IJMyC4dBy2AL9ShpuRNmPox2nzYG6S7ud17QLcKtSD5B9/wBzQfl0Lz?=
 =?us-ascii?Q?9V1i7LN8nkBLVxlkCf+qrWYDs0L3JEWv1YPmA3D5VLIkOr2ACzjm56/3VOtd?=
 =?us-ascii?Q?reSH3P2QOBRWX0yRE8TalqEy7R6nzCZJauqD7R0TUGjLabywHcOJUptzpqgx?=
 =?us-ascii?Q?zXSCPBN8SCZ6obbF3wNdn/HFsbdSJtJRxwsLRiIld8jPonZ5O2X9X8DCv0iD?=
 =?us-ascii?Q?DIV0mZK5Tz4gTQZDWn5VvvKa0xDkUuFkSk3Cu5WTZlPNLbZG1dw8Voc26PUq?=
 =?us-ascii?Q?7RCP/5h/7nlXXcxisbEb1TR3SvMzFfHDAJmWUaP?=
X-Microsoft-Antispam-Message-Info: dAUgtHxLUGpwxhb7+zZrUx6eWDpW4x6goI2Sip4iHZVYVxrw+wo/93h7J5Uivb80t1JC80uJbtP75NhM5+Q8iIV/Vq0vy+1/SkbcDNygQREA6539r+SxxxJ2ZAQyKwrdp6QUD8hgrnQglYvi/ZGzXffiZCxXM5B5RXh63rNOQH+k58C894XI59z3EvMBgN72GWvlv3zPFLejTz6ntBwP0Z6fKdyE8AlU2OSMff48oefKlGhCgGO5c7iErFzTrnHWaQU3UcvPaVLut2Zbd+gTTp3vY+IkEUZx2kjEl8XpYg+5oio0jWmYelF1w7FnPq6c6Tg0HXrl03s6NDv0QT8efhtXbATcDPmvZrO22Umgmzg=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;6:mR3OKIuQ3pOs4p8mJwKKFpxq/LFhuquVjpY1XABAYAjtQkKeaxVs7YOYek5kM2EKAFxdVL7lHgoomJM8pihHuij7yzC/SU8dtw62y0DYuAxx0KgNaaAE3DXVWJ8LSKvY4zEbVzNCbWscyH9MKynHypjpDFH1ond6ffym+wPS/2XNo5dehhW5jlNPLe+Oy0U5ii9j23EqtlMsZEa5dGKLNoiHtBKHpUDJIFXSSduQRaYLfPpxfzssS8F58zkapVDN1lohW1TRkG/X9ZFvgXLg0ohacCRqTkT6vge37tcVd9n57RoS9/lpNcgbqMaRXOEzXBSx9E+ZTIFr6S0cSUK2f0yx26D+K80IH2Z8ZnR1h/eWY5Vbf5GIIYdH7p89zrzk+uuh1awExEnpBe4rOxqx9YHlC7dE0t56uH1Zy3aVV5vT+etS9+7CFMi37JDqP0KNA/oNgHK8rLyBRguf/98JeQ==;5:6OhKaOXFW39Vw4uC4SGeS7MQ0KLAVKRmMkCzaCsv6/FfTamzw66ygtjrcMrlr+bHTRl6V8ZpuG8Id8XQ8JnbOptaQ9KpnvgSGv+NUa/LzanpdLB8MH9EYlf/gvVu1fm0LwdkTcd2TfyQjuMCno8L6CuVdeODwuBsj11+sZYbkh8=;7:eldkB2uFtae/QFfyZL8ih+3JcXdo134na80h03m8QK8f0pkeebeH0vcyHnpC+UJuRUQ9Y8/f2HwknNXl68YX56nQX32wlmLvnujisMpOYiEt0uo86h2s/vddor1Zmzut8p4SuCBfl89m5Tmc/bVskm/IcIK6XR17NWtGldVu6I29Ki/ASivK/En+1MZpylM9b45MSmupqn4l2JkT7kCaWJXFsC/SJqkSEXZbYLsgAWHQKtn61heYNOy7OAhJnJ2m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 18:34:20.8925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4341a1-46d0-4e8e-ff7b-08d606cb8bbc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Mon, Aug 20, 2018 at 02:04:24PM +0900, Masahiro Yamada wrote:
> 2018-08-19 3:10 GMT+09:00 Paul Burton <paul.burton@mips.com>:
> > We have a need to override the definition of
> > barrier_before_unreachable() for MIPS, which means we either need to add
> > architecture-specific code into linux/compiler-gcc.h or we need to allow
> > the architecture to provide a header that can define the macro before
> > the generic definition. The latter seems like the better approach.
> >
> > A straightforward approach to the per-arch header is to make use of
> > asm-generic to provide a default empty header & adjust architectures
> > which don't need anything specific to make use of that by adding the
> > header to generic-y. Unfortunately this doesn't work so well due to
> > commit a95b37e20db9 ("kbuild: get <linux/compiler_types.h> out of
> > <linux/kconfig.h>") which moved the inclusion of linux/compiler.h to
> > cflags using the -include compiler flag.
> >
> > Because the -include flag is present for all C files we compile, we need
> > the architecture-provided header to be present before any C files are
> > compiled. If any C files can be compiled prior to the asm-generic header
> > wrappers being generated then we hit a build failure due to missing
> > header. Such cases do exist - one pointed out by the kbuild test robot
> > is the compilation of arch/ia64/kernel/nr-irqs.c, which occurs as part
> > of the archprepare target [1].
> >
> > This leaves us with a few options:
> >
> >   1) Use generic-y & fix any build failures we find by enforcing
> >      ordering such that the asm-generic target occurs before any C
> >      compilation, such that linux/compiler_types.h can always include
> >      the generated asm-generic wrapper which in turn includes the empty
> >      asm-generic header. This would rely on us finding all the
> >      problematic cases - I don't know for sure that the ia64 issue is
> >      the only one.
> >
> >   2) Add an actual empty header to each architecture, so that we don't
> >      need the generated asm-generic wrapper. This seems messy.
> >
> >   3) Give up & add #ifdef CONFIG_MIPS or similar to
> >      linux/compiler_types.h. This seems messy too.
> >
> >   4) Include the arch header only when it's actually needed, removing
> >      the need for the asm-generic wrapper for all other architectures.
> >
> > This patch allows us to use approach 4, by including an
> > asm/compiler_types.h header using the -include flag in the same way we
> > do for linux/compiler_types.h, but only if the header actually exists.
> 
> I agree with the approach 4),
> but I am of two minds about how to implement it.
> 
> I guess the cost of evaluating 'wildcard' for each C file
> is unnoticeable level, but I am slightly in favor of
> including <asm/compilr_types.h> from <linux/compiler_types.h>
> conditionally.
> 
> I am not sure about the CONFIG name, but for example, like this.
> 
> #ifdef CONFIG_HAVE_ARCH_COMPILER_TYPES
> #include <asm/compiler_types.h>
> #endif
> 
> What do you think?

That sounds fine to me - I'll submit a v9 shortly :)

Thanks,
    Paul
