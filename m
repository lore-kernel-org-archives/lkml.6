Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE85C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A188E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="cqdQSSbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbeLTR4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:56:21 -0500
Received: from mail-eopbgr740098.outbound.protection.outlook.com ([40.107.74.98]:7872
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388248AbeLTR4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhT/u+S21skuitstRa6rAxObNyDO4WQ06Dd+1SLa5p4=;
 b=cqdQSSbieZY0B22pjS6DJeCPbyRfeDRbGNlz7c/XrqIF1spRTrsh/os4TeQm4VyBgosb6DU18KMAhAQ4v1YN7pXzjyw6o2Sv5qyQjcwx8+iLZvlREsYdW88pLgC8EvVayo4FXTV1G50Pj3p7EeY+fFfSLSENeH/+H1yamgsz5I4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1343.namprd22.prod.outlook.com (10.174.162.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Thu, 20 Dec 2018 17:56:13 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 17:56:13 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Hugh Dickins <hughd@google.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Rich Felker <dalias@libc.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
Thread-Topic: Fixing MIPS delay slot emulation weakness?
Thread-Index: AQHUlKsnfXRylMltrkarAU/KL34KxKWFfjSAgAEXsQCAAVtSgA==
Date:   Thu, 20 Dec 2018 17:56:12 +0000
Message-ID: <20181220175605.t6oogok42f62th2w@pburton-laptop>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
 <20181219043155.nkaofln64lbp2gfz@pburton-laptop>
 <alpine.LSU.2.11.1812191249560.24428@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1812191249560.24428@eggly.anvils>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0396.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::24) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1343;6:dG0rzHbrGtFVo0apmd2rC2IcyuQS1cjBU9IYjKV9wkHs1OCOgrRn7TZTFRFW06j7xpEoERmwxEpfW9HnkeRSn9eJhWzwcrFdUnTNsU1bVeGm+puzMNEYcgQdQY/uAnIbh/67GRVwC8rzT39iP2ZgPz9nuyuu77hZYd923FY4RgpQS6gRM2etz7wv53afwidExxJEIXvaLbInkLtLr1GZwTHyscuMmqWHcl5Vp09KyFNhGDwHtN9nWurwFsp9/jTB23pfzAKlqzLrY00y/HZWIXGHfZ/5GEsk9N7rTaSVtlQnZRa5bXr4HMJjzp+lt17d3rch/zldtd2XCG0X5sm9VZddwfuGSF/AxsrIHExpVq0q87R9VIQJcfa2LhELtp1uOZhSwndBb8NN45WpQemDdF4jmbtSpzspElSb7N5W6FSpvDUNbmEP1Ud8Ko6itFON1xVFxkN+XQ+7rSkhcOWr+A==;5:mm5qjMDlZbMj3fZ/EH96sfFME601gfF+pgwXs2Lkgw4Bwx59K9vksWJYx/o2n+C5DPkKt7nGavbHj5NWH1XbUG8xoswAmVUndo+OSFFxIaCoWj3m3TINYMUTeLsPaT40T4Dh3KOS4Qvtc+8UwXyFPrdw0grJGMlGMjIyMgFGLqY=;7:Kndi2nG7Mwz6EXn94Wd1nV0yioM9/nqgDlMOMNR0J2DkjcoAkoWtvTxVHzjQv5bwoiyACYUM40WkQve2AZNKcJ7IF0J316khWIB49lXECLqxGGcv0wvn4XfLnOV+3BY7UCvayhKUGeGGSni12oD8jg==
x-ms-office365-filtering-correlation-id: 7d8ffd22-9058-46c4-8a84-08d666a46de6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1343;
x-ms-traffictypediagnostic: MWHPR2201MB1343:
x-microsoft-antispam-prvs: <MWHPR2201MB13430EF040207A718C7BE761C1BF0@MWHPR2201MB1343.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(3231475)(944501520)(52105112)(149066)(150057)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1343;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1343;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(366004)(39840400004)(396003)(376002)(136003)(189003)(199004)(9686003)(6306002)(66066001)(6512007)(6916009)(7736002)(2906002)(1076003)(42882007)(5660300001)(6436002)(8936002)(33716001)(6486002)(8676002)(305945005)(256004)(229853002)(81166006)(81156014)(476003)(106356001)(76176011)(6116002)(71190400001)(3846002)(71200400001)(486006)(26005)(44832011)(68736007)(102836004)(105586002)(33896004)(186003)(6246003)(54906003)(14454004)(58126008)(97736004)(966005)(316002)(53936002)(6506007)(386003)(11346002)(446003)(52116002)(25786009)(508600001)(4326008)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1343;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YfUCgI78mBqFIWxdoRh9Isu6M5bCxZoVeNZgOm46BOExXmfv3Sa7DizrOA5tNs9xcHrheQPh06U9cUwh/xj2nmycadm1t393mf7ulWzv74L+H8pn4XKW92Ra7BfvRpKxBl1kKtpFf7u24Qoohka1R9/xTHQKWSSTUjreiWE3dTCIaMm4iACtr8fYWZaDkko1oM/chGw32qJ8XQN7Oi4PZFCNU4sDmYMvRy4qPCTG0uaqvHrXQYzpoPHN5R5xXdrxHYkvsRJwiyI3fsoMl/UoR1YSVGmlI/5LgIbhETj2iw916gEHtD7EAWl7sNpUQw3C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29BE76999D94964782932B09CAD869F4@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8ffd22-9058-46c4-8a84-08d666a46de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 17:56:13.1635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Wed, Dec 19, 2018 at 01:12:58PM -0800, Hugh Dickins wrote:
> > is_cow_mapping() returns true if the VM_MAYWRITE flag is set and
> > VM_SHARED is not set - this suggests a private & potentially-writable
> > area, right? That fits in nicely with an area we'd want to COW. Why the=
n
> > does check_vma_flags() use the inverse of this to indicate a shared
> > area? This fails if we have a private mapping where VM_MAYWRITE is not
> > set, but where FOLL_FORCE would otherwise provide a means of writing to
> > the memory.
> >=20
> > If I remove this check in check_vma_flags() then I have a nice simple
> > patch which seems to work well, leaving the user mapping of the delay
> > slot emulation page non-writeable. I'm not sure I'm following the mm
> > innards here though - is there something I should change about the dela=
y
> > slot page instead? Should I be marking it shared, even though it isn't
> > really? Or perhaps I'm misunderstanding what VM_MAYWRITE does & I shoul=
d
> > set that - would that allow a user to use mprotect() to make the region
> > writeable..?
>=20
> Exactly, in that last sentence above you come to the right understanding
> of VM_MAYWRITE: it allows mprotect to add VM_WRITE whenever.  So I think
> your issue in setting up the mmap, is that you're (rightly) doing it with
> VM_flags to mmap_region(), but giving it a combination of flags that an
> mmap() syscall from userspace would never arrive at, so does not match
> expectations in is_cow_mapping().  Look for VM_MAYWRITE in mm/mmap.c:
> you'll find do_mmap() first adding VM_MAYWRITE unconditionally, then
> removing it just from the case of a MAP_SHARED without FMODE_WRITE.
>=20
> > diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> > index 48a9c6b90e07..9476efb54d18 100644
> > --- a/arch/mips/kernel/vdso.c
> > +++ b/arch/mips/kernel/vdso.c
> > @@ -126,8 +126,7 @@ int arch_setup_additional_pages(struct linux_binprm=
 *bprm, int uses_interp)
> > =20
> >  	/* Map delay slot emulation page */
> >  	base =3D mmap_region(NULL, STACK_TOP, PAGE_SIZE,
> > -			   VM_READ|VM_WRITE|VM_EXEC|
> > -			   VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > +			   VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYEXEC,
>=20
> So, remove the VM_WRITE by all means, but leave in the VM_MAYWRITE.

Thanks Hugh - it works fine when I leave in VM_MAYWRITE.

My 4am self had become convinced that it would be problematic if a user
program could mprotect() the memory & make it writable... But in reality
if a user program wants to do that then by all means, the kernel isn't
going to be able to prevent it doing silly things.

For anyone looking for the outcome, the patch I wound up with is here:

https://lore.kernel.org/linux-mips/20181220174514.24953-1-paul.burton@mips.=
com/

Thanks,
    Paul
