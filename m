Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D1FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC76920652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="kFy1kXZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC76920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeIEWSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:18:31 -0400
Received: from mail-bl2nam02on0138.outbound.protection.outlook.com ([104.47.38.138]:59635
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbeIEWSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrLc8JNF5DuGxNKXETWPafk8LIxuCw9MG9QVm1OBvLQ=;
 b=kFy1kXZsTbLLBCbsiGGWAs+8l1QpJOl1JFf9q7J4MV7Vsp3ZpA9AGSIHscCrpJ8SNkjuIeWE8bSOpxdMOcm/5I9anlIezO1h6xdrJzWP/S+d21togowseeXyjrlQrVpWEKhKEGHHN5VqtY5dsymw36qSsuJD1tsxDgmFTZobMw4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4931.namprd08.prod.outlook.com (2603:10b6:408:28::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Wed, 5 Sep 2018 17:47:12 +0000
Date:   Wed, 5 Sep 2018 10:47:10 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mips: switch to NO_BOOTMEM
Message-ID: <20180905174709.pz2rmyt2oob6bxpz@pburton-laptop>
References: <1535356775-20396-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180830214856.cwqyjksz36ujxydm@pburton-laptop>
 <20180831211747.GA31133@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831211747.GA31133@rapoport-lnx>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:404:23::21) To BN7PR08MB4931.namprd08.prod.outlook.com
 (2603:10b6:408:28::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80bbd258-a63f-49aa-235a-08d613579c8d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4931;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;3:yjJH/KRQdRMXM8gKDA6gqwUNkDgVzt+AcUc3hN5R2PgfaboG/5fX/R/37TBpU8xsscCCX/H/REjWBHQohQ4I2BxEtMutw8vyyE+79yVHh0SmDnD2AdD+bZ+Mm4RR7a9h9ICQ13pSZ1eY2GhRkohuQRD1zN9NNjT/W9DLQ0AfDTJPkWn6rl3+KZU2dx+hKbTjg6uS5FZM6Q4T4GGT7QptZ54318K60HminNYrW7yXBqblFoG6RZvVvDWYbONQcL09;25:yKj/l3c1qkg1/WaHWKtpbTAOhzBIKiHyXgkY09Q4Nd+BorFX698TsH3++lpNFgRsMHinYoGyM01hPR7YoKnb1yn/vZJd6OFcEmDjT27ayCLyEQYJ/Ksi8VF+9b7YM9lmOSTHqPGrtN165agnG6iz66TQmgqvHY+HJlIcDMNxju/w0Tl2FlDdvQyzcwoTo4XTHTVT9/kwp6FBVxo1wqcVgJBJYhV6Kfl42yur6X8M+mAgxURysQa1xhkVzobyEfp2MAWcssLOyUa45e9255Facs61wfxefIXiz1r+uq1ZUFZiKlpbES8N7L0gzMia8oDugdOOWsk5KgfZxiQWPi//bg==;31:V/PWwyeu0x9FF5JKg76aiBz+7C3rHTQHR9r1/35pyPst+ppwa6ouOK55n1/hXI0eMndp9BmJhlluh6+I5UPgnGxirZia67BmwHp9/SNDCBnbGo4ltNzDUOioiNdzEzevfjy0jR5Awt4Las83WppmYnA50e4dYr3VyOFLciZOMCCaO4GmG+P+fQOrMzRVhn3UMO5CAy5y8zJEyQbI3i9WB6PC7b+Xm0lBcNp0C5iixjg=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4931:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;20:zlgufP/TVDcy8QaMshNxi9neWd9bt3dCGtcwfiVMmpX2LxM6nsvhBA3ipkevHQGALVqhriIpbmWwdstbW10mMGS+gUyPyDGI+FVrVf/lMaI6nwCsvcK+4AZiCNgR1TRw+sK09VHZohPu2QJ9sumdJ5Fzs0+BFL8QG1L0b/8Lo9kIKXmH3kAGwg2vXqJt1UJGAeO5k6yKyw6cNmD8jTJf/Nnz3SR7bvPCJsxerVb04KJPqRc1q+Smac4Ybf/j4D9x;4:N4sKgt85XJc/BRv4CSu5JPu11bMBTenuEPyDrBeNYh1EWmEEZ2Bg//4nok5T3yJd8wzo78Ic1xx9fLo4edfokPrhMN8Ei/Ou0L6nSpEtmvVTdOBiY0v/J7Lr39JFcWcpPZA7vbcoqq8OeOm5gc5ZteSMtwYUzGYvyiJacsnSao/QDAAZLCI841UhqxmP3QfR6a7ZR+K5Mt6GoVK9nbZKVfzfHLSTpCX2h4q/pA22P9x71JCqjgl6pyfX8/f0NC/dtAIDPpzoHETAQ0gvngvnEpNTYsaNhlmziq170bQx/HxM4XRjkgUH9vPjwhEAFC0h
X-Microsoft-Antispam-PRVS: <BN7PR08MB4931A4E8778A26248061AFD3C1020@BN7PR08MB4931.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BN7PR08MB4931;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4931;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(136003)(376002)(346002)(39850400004)(366004)(199004)(189003)(8676002)(386003)(3846002)(14444005)(6116002)(26005)(23726003)(7736002)(47776003)(66066001)(305945005)(9686003)(105586002)(229853002)(575784001)(97736004)(76506005)(1076002)(6486002)(186003)(16526019)(42882007)(58126008)(8936002)(68736007)(316002)(478600001)(2906002)(52116002)(33716001)(476003)(50466002)(956004)(81166006)(16586007)(486006)(81156014)(6246003)(54906003)(11346002)(6496006)(106356001)(6916009)(446003)(25786009)(5660300001)(44832011)(76176011)(4326008)(39060400002)(33896004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4931;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4931;23:zpvm69b0VsTtrx+bjEMjIj+028W6tk7rLoXKj8MW3?=
 =?us-ascii?Q?5J/MJQP8QPo7SpAQaftxymtk7Lx/SblUrFFeaNvW+W5zXiIzi0Vp8bbE8smU?=
 =?us-ascii?Q?O//rPywprr32S2mkP7JFDgYY+qQywXg57u5Ig7LDNJAoQ3xSHKImuqW11fIf?=
 =?us-ascii?Q?gjCG4VqKWQfKRiBBOws9pNGSvLi3M9pWDZAeyl5SIOkCKxjhe2VGfCmIQmop?=
 =?us-ascii?Q?wXV0H5wzdSB0u4zOrMWn5NZReK5qiFusDGrzT3U8i+cx9AxL6P0G2pJf+0t8?=
 =?us-ascii?Q?R67lB7qfHdJ0f7fuxH1WO9wpRzubF4OI2a5ed2664p58nBuKxuRsmhIRpJTm?=
 =?us-ascii?Q?KsKBqoK0pSutvvdbAU8aiBMamJ51DRVgbocm/eWWGFF5fQqk96BrKQeoeTna?=
 =?us-ascii?Q?pkROjFZpBzCouGELXYfj1nhcSbOkujuiYqOViR0IsWvOwNwoqT4SAIuU94ty?=
 =?us-ascii?Q?3O9FjAP13m0nQw3J4drkNbMIU4dcUgBAsUK/RRO+gWJxUKQFxU4ttV/D3GTw?=
 =?us-ascii?Q?0kxmfWmpdDE0Ly9/K93/xGtV2SIxmrPVDEaxVlSp0V/sMvk+cSYirIn+Hlam?=
 =?us-ascii?Q?M4/EfRlLefow2brAwYLEEcs7PoRbi1mE7sVmjBOCixinyXQkldpO2d/QIzlJ?=
 =?us-ascii?Q?/qCZFbmTxcZvHQc4frpKSWD61jajWwpFcz/37rJ6Sx/JVm8qwX5h+NvGomJ4?=
 =?us-ascii?Q?KDhxqBMQACcgOkR/33oEiW7Ze+zsmxFOuUHhS3mB/2LzwJ36QOuJBsCbBdJa?=
 =?us-ascii?Q?0ahm26CjqNCUG9RJkLHFuNDDxsElGgI++xvOQj+PqzRYc90WdchR5D3nbfVz?=
 =?us-ascii?Q?8mjTFxkDFIqxQwCp/zzIvJYdSiKOPhWwwa4sBELgT6/HrQySE99fePeBGnfu?=
 =?us-ascii?Q?6dwghkiLimCGo6fsiP4WfYQVCCgTDm1l4wKo9r9EyvquyeMoU+gq0/aQZ/2b?=
 =?us-ascii?Q?t4Vaz9dUbXNAoSUPs+iqYlTEH9ZAu0/P0KYd8R6EmajA+CR+u858lc2HqVX3?=
 =?us-ascii?Q?NGzVSRxkYhDwOU4tIPux0hHcK5rl/XBHR1HdKC0DGxtB18TrrBgVCRT9CHfB?=
 =?us-ascii?Q?TjG91VfGsYFVjXPWWciTB2g39RNSlSf8sYCJ6Zqxg8JbkVGbpk6ZpxL4+f5p?=
 =?us-ascii?Q?fcp3TeiPe6QZoy7xxies415n//yrbOsF3yxebjEv+N3ETiloE6Wz5M4mbDwh?=
 =?us-ascii?Q?1V0efkYRO0fbetd5mOJJSKcHrLZkBZQ+C8EIALQeBnyAHqA0Cec/MQkUw8ch?=
 =?us-ascii?Q?tVfuYbtN2qlYiDu3JfBSy95u80/F32xKdTQFzjHXvfc7A4Y0bwrytRQZ2sKh?=
 =?us-ascii?Q?ucRZ1A9Qxa1QgbuJrscSLXqjKmQ0NZdUjevGJ+G7BzRmMVGo/p4T2BRIk1M/?=
 =?us-ascii?Q?HX6eQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: n3Vc2gCb6ZF2dHICwj3YhAZ8rddoluqI/QuYJ5fCHLKJ4c+wFils7VsiIcFSPJWO90mGTaxuXFjOStKxuFKEo8rAK5PYkBOpbJniSk+bn3GNVzv4rQBfUgURPlp7eZHMgbpLT1N7nbRCQ9ftz5xknmVOzMGUqfC63RyJsoN0OoFXedA1hvdiVFgq2mB+daOYcyzlimY+OpUYJmJaaowqJWjBb2++0ZBcujG1aYLZE/qCGI+H1+4LnhuZZUHFMFwooJdWctdR6ke+uOn/PV3KbV4pqHE012LxyNnGntNWsTlwTBEGknPEz7dnpQ7dztma33E0OLijDeIWIZhNo6sPw/aXBSaUcsZR+XADXAgHr2o=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4931;6:r6+vSN1CyRpBnhH8vS5EDSAImkOERMzJR7TXouwREZ80kfVrsmQ1x6XcgjPvYV7lTfqE1oOJdd7er+DN3BtxdB5Vx1NPYdGUkIZ0sdVD8hKmOWTPedH4mmM60Fy+HZKDyNY4IFHuyTet5U6rd4+27My9/RhbpseQ4tHaEv8DMzzK7SSz/X7fPvRmgvP3RIO8uhhcjSn/AMjYbWi10soQ8P1oOKLWAhCmwZLEsOrECCAeuICjGXo98odyM+sC/DOfCytQRyzxJhfCHYGOOr/uP9y+vW5SHMmcKCdvmUX5OwDLMGieWug2WleXYEStMS3MLICntPu7P0f4jGTHLWwn80eVjQZBED4OGo2XV/e9jIgwEu7gn1Kt7SVLL67npAgxVq0XCcCAycHzKeYGOTm2HnUW00vUOwQFdQv/wZpo+YgnN1XW/6jaqBlcK8iyEnR+lyRCo1htxr8rgimSeM/fFw==;5:uYcG0x4q9RZddoY8R4Zt3jHrqjRD0lDeTAOWQuRVkkHEqXiImMJyzjaDXDcBosqCvUnfEb4shR0lv0LyjqlYIuzW+rU77fuZHQ7PKgz6Hr5wYz90QcKdxpbdbv4w+IUPBhEWuYp214t/IgMlyNJbzVk1/6+tprCApWB56KczBZc=;7:nSKbwU4r+F58prpJ8t8SR9Wow2M3zIDX1MgNIPthB06R9WC+1jZ7KoF0+IY8+7dmawWLZdeHfl6YyRhDo1g9qharBe4GRp/8UB2aH/ELOFZsiU+bBRAsyuOZ4EAjP0Hoi7tznXSZT1loQEg09Th+ZFNQxGyx/ro0Y0AAHXszFE4jxUE898IrLBYE30LyhxQyKE85SDLawkglwfWt7ssTjft8AZj/V+Zr0jJLujWEyFlW/RjlDTsQ3TMKz2EZwVuA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 17:47:12.6559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bbd258-a63f-49aa-235a-08d613579c8d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Sat, Sep 01, 2018 at 12:17:48AM +0300, Mike Rapoport wrote:
> On Thu, Aug 30, 2018 at 02:48:57PM -0700, Paul Burton wrote:
> > On Mon, Aug 27, 2018 at 10:59:35AM +0300, Mike Rapoport wrote:
> > > MIPS already has memblock support and all the memory is already registered
> > > with it.
> > > 
> > > This patch replaces bootmem memory reservations with memblock ones and
> > > removes the bootmem initialization.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > > ---
> > > 
> > >  arch/mips/Kconfig                      |  1 +
> > >  arch/mips/kernel/setup.c               | 89 +++++-----------------------------
> > >  arch/mips/loongson64/loongson-3/numa.c | 34 ++++++-------
> > >  arch/mips/sgi-ip27/ip27-memory.c       | 11 ++---
> > >  4 files changed, 33 insertions(+), 102 deletions(-)
> > 
> > Thanks for working on this. Unfortunately it breaks boot for at least a
> > 32r6el_defconfig kernel on QEMU:
> > 
> >   $ qemu-system-mips64el \
> >     -M boston \
> >     -kernel arch/mips/boot/vmlinux.gz.itb \
> >     -serial stdio \
> >     -append "earlycon=uart8250,mmio32,0x17ffe000,115200 console=ttyS0,115200 debug memblock=debug mminit_loglevel=4"
> >   [    0.000000] Linux version 4.19.0-rc1-00008-g82d0f342eecd (pburton@pburton-laptop) (gcc version 8.1.0 (GCC)) #23 SMP Thu Aug 30 14:38:06 PDT 2018
> >   [    0.000000] CPU0 revision is: 0001a900 (MIPS I6400)
> >   [    0.000000] FPU revision is: 20f30300
> >   [    0.000000] MSA revision is: 00000300
> >   [    0.000000] MIPS: machine is img,boston
> >   [    0.000000] Determined physical RAM map:
> >   [    0.000000]  memory: 10000000 @ 00000000 (usable)
> >   [    0.000000]  memory: 30000000 @ 90000000 (usable)
> >   [    0.000000] earlycon: uart8250 at MMIO32 0x17ffe000 (options '115200')
> >   [    0.000000] bootconsole [uart8250] enabled
> >   [    0.000000] memblock_reserve: [0x00000000-0x009a8fff] setup_arch+0x224/0x718
> >   [    0.000000] memblock_reserve: [0x01360000-0x01361ca7] setup_arch+0x3d8/0x718
> >   [    0.000000] Initrd not found or empty - disabling initrd
> >   [    0.000000] memblock_virt_alloc_try_nid: 7336 bytes align=0x40 nid=-1 from=0x00000000 max_addr=0x00000000 early_init_dt_alloc_memory_arch+0x20/0x2c
> >   [    0.000000] memblock_reserve: [0xbfffe340-0xbfffffe7] memblock_virt_alloc_internal+0x120/0x1ec
> >   <hang>
> > 
> > It looks like we took a TLB store exception after calling memset() with
> > a bogus address from memblock_virt_alloc_try_nid() or something inlined
> > into it.
> 
> Memblock tries to allocate from the top and the resulting address ends up
> in the high memory. 
> 
> With the hunk below I was able to get to "VFS: Cannot open root device"
> 
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 4114d3c..4a9b0f7 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -577,6 +577,8 @@ static void __init bootmem_init(void)
>          * Reserve initrd memory if needed.
>          */
>         finalize_initrd();
> +
> +       memblock_set_bottom_up(true);
>  }

That does seem to fix it, and some basic tests are looking good.

I notice you submitted this as part of your larger series to remove
bootmem - are you still happy for me to take this one through mips-next?

Thanks,
    Paul
