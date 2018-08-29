Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D8CC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6722064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="q0RK63SH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6722064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeH2VnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:43:24 -0400
Received: from mail-co1nam03on0088.outbound.protection.outlook.com ([104.47.40.88]:46112
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727204AbeH2VnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQwQHERdB5P8HVnsqpldVKldpmDGk/hOpDqhob46n3I=;
 b=q0RK63SHH9YQZG7t41mWkScrg5AbIgoJW7eq7FiNfp2CuRWzKsSmfHppkl6nZsA9gkJtvD0P7lYEI3loxyBYzb/WBfa9bGHe4GCswWPKBuv6CU5S+qsqLY0zb6EuUUoi2aSLQbC7smBubgOUPnfnq3CEjNEtIMSoMbs851FJmaM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3944.namprd05.prod.outlook.com (52.135.195.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.13; Wed, 29 Aug 2018 17:45:21 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.007; Wed, 29 Aug 2018
 17:45:21 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/6] x86/alternatives: initializing temporary mm for
 patching
Thread-Topic: [RFC PATCH 4/6] x86/alternatives: initializing temporary mm for
 patching
Thread-Index: AQHUP3AvABIZHRncFEqQhxMuKUQWO6TWt5uAgABJn4A=
Date:   Wed, 29 Aug 2018 17:45:21 +0000
Message-ID: <08328D6F-0380-4FCC-A99C-C7CD281DF582@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-5-namit@vmware.com>
 <20180829222149.adfeee806322a332bb1e4ab9@kernel.org>
In-Reply-To: <20180829222149.adfeee806322a332bb1e4ab9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3944;20:PD+/P75NO0WNdJ47L3jXtwO1VJ6A7Kv1ZsYVAm7CM8EFFC3phi3vXM3KCyjskDf7MTpsTClKgHg4rPn7ykyPYCai84URYcIgMmnFAU/mnMDDywBAOhTQH9wDCu0mymVuvfEzu1QcVO6pT3xSqDP16VjMVP/ySWXKfWNkbc7eRjQ=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4b0250da-60af-4ad4-dd55-08d60dd7316f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3944;
x-ms-traffictypediagnostic: BYAPR05MB3944:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB39449E3234F0B91EBAE33E46D0090@BYAPR05MB3944.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:BYAPR05MB3944;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB3944;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(6916009)(6512007)(217873002)(4326008)(8676002)(575784001)(186003)(82746002)(53936002)(76176011)(86362001)(99286004)(102836004)(54906003)(316002)(6506007)(2906002)(6486002)(26005)(83716003)(6436002)(6246003)(2616005)(11346002)(97736004)(229853002)(446003)(5250100002)(5660300001)(486006)(476003)(478600001)(68736007)(2900100001)(33656002)(36756003)(14454004)(305945005)(256004)(7736002)(105586002)(106356001)(14444005)(6116002)(81156014)(66066001)(81166006)(3846002)(8936002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3944;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 3Ylq6gqvRemMTH6qizdi+IkaEn2JPSMvvnmljy0CdYXStogjPOsApk51V5+y2dTGSdMGtttQ28NZKvAOsrIcrEvtZQ856LN+j/Ro/Snd6WGoc/fH851uKY7sShTN1kz5Yc0lzii0tggvbKKNtTzV34b8+ODEUPrFY36OscEck5N2TkV99xWrHqGJs3deH9Zx0iukkbMIFM6CoP7ifsmMGIghKvIeW0SoalNo7E2G50a+IaakE/fPKW6HNmgWsBHRM6zVsLWzgpCU+mvat+QgcSwtSgpH9X8PUyIfJcdh3TwoezFPE7eLJw4cGFdLxGRSxBBQsWq2YoXKLM7YC3uuB6jKVH/1zXUzPjrg+kAUlTQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E12148A2DF791048AC8EF18E3981D9A9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0250da-60af-4ad4-dd55-08d60dd7316f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 17:45:21.6485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 6:21 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Wed, 29 Aug 2018 01:11:45 -0700
> Nadav Amit <namit@vmware.com> wrote:
>=20
>> To prevent improper use of the PTEs that are used for text patching, we
>> want to use a temporary mm struct. We initailize it by copying the init
>> mm.
>>=20
>> The address that will be used for patching is taken from the lower area
>> that is usually used for the task memory. Doing so prevents the need to
>> frequently synchronize the temporary-mm (e.g., when BPF programs are
>> installed), since different PGDs are used for the task memory.
>>=20
>> Finally, we randomize the address of the PTEs to harden against exploits
>> that use these PTEs.
>>=20
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Suggested-by: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> arch/x86/include/asm/pgtable.h       |  4 ++++
>> arch/x86/include/asm/text-patching.h |  2 ++
>> arch/x86/mm/init_64.c                | 35 ++++++++++++++++++++++++++++
>> include/asm-generic/pgtable.h        |  4 ++++
>> init/main.c                          |  1 +
>> 5 files changed, 46 insertions(+)
>>=20
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtab=
le.h
>> index e4ffa565a69f..c65d2b146ff6 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1022,6 +1022,10 @@ static inline void __meminit init_trampoline_defa=
ult(void)
>> 	/* Default trampoline pgd value */
>> 	trampoline_pgd_entry =3D init_top_pgt[pgd_index(__PAGE_OFFSET)];
>> }
>> +
>> +void __init poking_init(void);
>> +#define poking_init poking_init
>=20
> Would we need this macro?
>=20
>> +
>> # ifdef CONFIG_RANDOMIZE_MEMORY
>> void __meminit init_trampoline(void);
>> # else
>> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm=
/text-patching.h
>> index e85ff65c43c3..ffe7902cc326 100644
>> --- a/arch/x86/include/asm/text-patching.h
>> +++ b/arch/x86/include/asm/text-patching.h
>> @@ -38,5 +38,7 @@ extern void *text_poke(void *addr, const void *opcode,=
 size_t len);
>> extern int poke_int3_handler(struct pt_regs *regs);
>> extern void *text_poke_bp(void *addr, const void *opcode, size_t len, vo=
id *handler);
>> extern int after_bootmem;
>> +extern __ro_after_init struct mm_struct *poking_mm;
>> +extern __ro_after_init unsigned long poking_addr;
>>=20
>> #endif /* _ASM_X86_TEXT_PATCHING_H */
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index dd519f372169..ed4a46a89946 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -33,6 +33,7 @@
>> #include <linux/nmi.h>
>> #include <linux/gfp.h>
>> #include <linux/kcore.h>
>> +#include <linux/sched/mm.h>
>>=20
>> #include <asm/processor.h>
>> #include <asm/bios_ebda.h>
>> @@ -54,6 +55,7 @@
>> #include <asm/init.h>
>> #include <asm/uv/uv.h>
>> #include <asm/setup.h>
>> +#include <asm/text-patching.h>
>>=20
>> #include "mm_internal.h"
>>=20
>> @@ -1389,6 +1391,39 @@ unsigned long memory_block_size_bytes(void)
>> 	return memory_block_size_probed;
>> }
>>=20
>> +/*
>> + * Initialize an mm_struct to be used during poking and a pointer to be=
 used
>> + * during patching. If anything fails during initialization, poking wil=
l be done
>> + * using the fixmap, which is unsafe, so warn the user about it.
>> + */
>> +void __init poking_init(void)
>> +{
>> +	unsigned long poking_addr;
>> +
>> +	poking_mm =3D copy_init_mm();
>> +	if (!poking_mm)
>> +		goto error;
>> +
>> +	/*
>> +	 * Randomize the poking address, but make sure that the following page
>> +	 * will be mapped at the same PMD. We need 2 pages, so find space for =
3,
>> +	 * and adjust the address if the PMD ends after the first one.
>> +	 */
>> +	poking_addr =3D TASK_UNMAPPED_BASE +
>> +		(kaslr_get_random_long("Poking") & PAGE_MASK) %
>> +		(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
>> +
>> +	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) =3D=3D 0)
>> +		poking_addr +=3D PAGE_SIZE;
>> +
>> +	return;
>> +error:
>> +	if (poking_mm)
>> +		mmput(poking_mm);
>> +	poking_mm =3D NULL;
>=20
> At this point, only poking_mm =3D=3D NULL case jumps into error. So we do=
n't
> need above 3 lines.

Right. Will be fixed in the next version.=20

>=20
>> +	pr_err("x86/mm: error setting a separate poking address space\n");
>> +}
>> +
>> #ifdef CONFIG_SPARSEMEM_VMEMMAP
>> /*
>>  * Initialise the sparsemem vmemmap using huge-pages at the PMD level.
>> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable=
.h
>> index 88ebc6102c7c..c66579d0ee67 100644
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -1111,6 +1111,10 @@ static inline bool arch_has_pfn_modify_check(void=
)
>>=20
>> #ifndef PAGE_KERNEL_EXEC
>> # define PAGE_KERNEL_EXEC PAGE_KERNEL
>> +
>> +#ifndef poking_init
>> +static inline void poking_init(void) { }
>> +#endif
>=20
> Hmm, this seems a bit tricky. Maybe we can make an __weak function
> in init/main.c.

Of course - __weak is much better. Thanks!




