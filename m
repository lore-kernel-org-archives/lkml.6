Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E525BC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF582083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF582083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbeLGVCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:02:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726041AbeLGVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 16:02:35 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB7KwqiO002095
        for <linux-kernel@vger.kernel.org>; Fri, 7 Dec 2018 16:02:34 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p7x2ddqmv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 16:02:33 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 7 Dec 2018 21:02:32 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Dec 2018 21:02:28 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB7L2Rbu655632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Dec 2018 21:02:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D59EFA405C;
        Fri,  7 Dec 2018 21:02:27 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26D37A405F;
        Fri,  7 Dec 2018 21:02:27 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.137])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Dec 2018 21:02:27 +0000 (GMT)
Date:   Fri, 7 Dec 2018 23:02:25 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Sam Creasey <sammy@sammy.net>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] m68k: Fix memblock-related crashes
References: <20181207165011.31497-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207165011.31497-1-geert@linux-m68k.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120721-0020-0000-0000-000002F41F4F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120721-0021-0000-0000-000021443822
Message-Id: <20181207210224.GA19067@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812070171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 05:50:11PM +0100, Geert Uytterhoeven wrote:
> When running the kernel in Fast RAM on Atari:
> 
>     Ignoring memory chunk at 0x0:0xe00000 before the first chunk
>     ...
>     Unable to handle kernel NULL pointer dereference at virtual address (ptrval)
>     Oops: 00000000
>     Modules linked in:
>     PC: [<0069dbac>] free_all_bootmem+0x12c/0x186
>     SR: 2714  SP: (ptrval)  a2: 005e3314
>     d0: 00000000    d1: 0000000a    d2: 00000e00    d3: 00000000
>     d4: 005e1fc0    d5: 0000001a    a0: 01000000    a1: 00000000
>     Process swapper (pid: 0, task=(ptrval))
>     Frame format=7 eff addr=00000736 ssw=0505 faddr=00000736
>     wb 1 stat/addr/data: 0000 00000000 00000000
>     wb 2 stat/addr/data: 0000 00000000 00000000
>     wb 3 stat/addr/data: 0000 00000736 00000000
>     push data: 00000000 00000000 00000000 00000000
>     Stack from 005e1f84:
>             00000000 0000000a 027d3260 006b5006 00000000 00000000 00000000 00000000
>             0004f062 0003a220 0069e272 005e1ff8 0000054c 00000000 00e00000 00000000
>             00000001 00693cd8 027d3260 0004f062 0003a220 00691be6 00000000 00000000
>             00000000 00000000 00000000 00000000 006b5006 00000000 00690872
>     Call Trace: [<0004f062>] printk+0x0/0x18
>      [<0003a220>] parse_args+0x0/0x2d4
>      [<0069e272>] memblock_virt_alloc_try_nid+0x0/0xa4
>      [<00693cd8>] mem_init+0xa/0x5c
>      [<0004f062>] printk+0x0/0x18
>      [<0003a220>] parse_args+0x0/0x2d4
>      [<00691be6>] start_kernel+0x1ca/0x462
>      [<00690872>] _sinittext+0x872/0x11f8
>     Code: 7a1a eaae 2270 6db0 0061 ef14 2f01 2f03 <96a9> 0736 2203 e589 d681 e78b d6a9 0732 2f03 2f40 0034 4eb9 0069 b8d0 260e 4fef
>     Disabling lock debugging due to kernel taint
>     Kernel panic - not syncing: Attempted to kill the idle task!
> 
> As the kernel must run in the memory chunk with the lowest address,
> ST-RAM is ignored, and removed from the m68k_memory[] array.
> However, it is not removed from memblock, causing a crash later.
> 
> More investigation shows that there are 3 places where memory chunks are
> ignored, all after the calls to memblock_add() in m68k_parse_bootinfo(),
> and thus causing crashes:
>   1. On classic m68k CPUs with a MMU, paging_init() ignores all memory
>      chunks below the first chunk, cfr. above,
>   2. On Amigas equipped with a Zorro III bus, config_amiga() ignores all
>      Zorro II memory,
>   3. If CONFIG_SINGLE_MEMORY_CHUNK=y, m68k_parse_bootinfo() ignores all
>      but the first memory chunk.
> 
> Fix this by moving the calls to memblock_add() from
> m68k_parse_bootinfo() to paging_init(), after all ignored memory chunks
> have been removed from m68k_memory[].
> 
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Fixes: 1008a11590b966b4 ("m68k: switch to MEMBLOCK + NO_BOOTMEM")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> As all 3 cases involve ignoring memory chunks, thus not requiring real
> memory present in the ignored chunks, I managed to test all 3 cases on
> my Amiga 4000 by using a memfile describing nonexistent memory in the
> Zorro II or 32-bit address space, below system RAM.
> 
> Sun-3 must be broken before this fix, as it fills in m68k_memory[0] in
> config_sun3(), i.e. after m68k_parse_bootinfo().
> Sun-3 is not fixed by this fix, as it uses its own paging_init(), not
> the one in motorola.c.
> Fixing Sun-3 requires adding memblock_add()/memblock_reserve() calls to
> the Sun-3 memory management code.

I think that adding memblock_add() to config_sun3 would be sufficient,
something like the diff below. This will make memblock aware of the
available physical memory and it seems there no allocations in sun3 before
paging_init().

diff --git a/arch/m68k/sun3/config.c b/arch/m68k/sun3/config.c
index 542c440..9a5b9dd 100644
--- a/arch/m68k/sun3/config.c
+++ b/arch/m68k/sun3/config.c
@@ -150,6 +150,7 @@ void __init config_sun3(void)
 
 	m68k_num_memory=1;
         m68k_memory[0].size=*(romvec->pv_sun3mem);
+	memblock_add(memory_start, memory_end - memory_start);
 
 	sun3_bootmem_alloc(memory_start, memory_end);
 }
 
> v3:
>   - Move memblock_add() after memory block removal instead of sprinkling
>     memblock_remove() all over the place,
>   - Remove Suggested-by, Tested-by.
> 
> v2:
>   - Add missing #include <linux/memblock.h>.
> ---
>  arch/m68k/kernel/setup_mm.c | 2 --
>  arch/m68k/mm/motorola.c     | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
> index a1a3eaeaf58c960d..ad0195cbe04255ea 100644
> --- a/arch/m68k/kernel/setup_mm.c
> +++ b/arch/m68k/kernel/setup_mm.c
> @@ -164,8 +164,6 @@ static void __init m68k_parse_bootinfo(const struct bi_record *record)
>  					be32_to_cpu(m->addr);
>  				m68k_memory[m68k_num_memory].size =
>  					be32_to_cpu(m->size);
> -				memblock_add(m68k_memory[m68k_num_memory].addr,
> -					     m68k_memory[m68k_num_memory].size);
>  				m68k_num_memory++;
>  			} else
>  				pr_warn("%s: too many memory chunks\n",
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index 7497cf30bf1cd41b..3f3d0bf360910c0d 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -228,6 +228,7 @@ void __init paging_init(void)
>  
>  	min_addr = m68k_memory[0].addr;
>  	max_addr = min_addr + m68k_memory[0].size;
> +	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
>  	for (i = 1; i < m68k_num_memory;) {
>  		if (m68k_memory[i].addr < min_addr) {
>  			printk("Ignoring memory chunk at 0x%lx:0x%lx before the first chunk\n",
> @@ -238,6 +239,7 @@ void __init paging_init(void)
>  				(m68k_num_memory - i) * sizeof(struct m68k_mem_info));
>  			continue;
>  		}
> +		memblock_add(m68k_memory[i].addr, m68k_memory[i].size);
>  		addr = m68k_memory[i].addr + m68k_memory[i].size;
>  		if (addr > max_addr)
>  			max_addr = addr;
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

