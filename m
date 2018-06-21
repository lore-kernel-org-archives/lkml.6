Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E59C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8B2223FD
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FMiyvCWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8B2223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933729AbeFUV0f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:26:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46328 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeFUV0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:26:30 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LLO7DD012494;
        Thu, 21 Jun 2018 21:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=hGUhu2AEO7AgSk9PxSWoxxGoNlwnWKxWwY8X7xbL5mM=;
 b=FMiyvCWrwGTEvUnceBMrXjWNJiP5I+zKoS17AhSV29HftT3M7mwKtM2ICHn+lOaqyhe+
 EYymQF4OMa7jiOAALu0rwqfBVSli+GzDQi9BHc56xgWWwrhqr4rLSWGAR1GpRH5PL+XS
 U4w+aH8qpphnkmvGlDFBtjfl8w0CIviQq1Pn7PyqNZ6/gmZ9OPdAzZexN+BDRPQgfgHC
 bqZPdD2/uw8XhnYIndFJkQ3w1uBE45fTRUVHCGro0/iTxcD1JInQVoKHPSkCdKRy3lrB
 rRHOFVCO4DFsM5mNF7qiVjIxZEqsZsxD8Z8GZghVMoWjPDGA5OmrlcdSY2xrZVf+M1y0 Eg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jmr2muvfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPUxb030684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:30 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5LLPRG5015026;
        Thu, 21 Jun 2018 21:25:27 GMT
Received: from xakep.us.oracle.com (/10.39.228.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 14:25:27 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: [PATCH v12 01/11] x86: text_poke() may access uninitialized struct pages
Date:   Thu, 21 Jun 2018 17:25:08 -0400
Message-Id: <20180621212518.19914-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621212518.19914-1-pasha.tatashin@oracle.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It supposed to be safe to modify static branches after jump_label_init().
But, because static key modifying code eventually calls text_poke() we
may end up with accessing struct page that have not been initialized.

Here is how to quickly reproduce the problem. Insert code like this
into init/main.c:

| +static DEFINE_STATIC_KEY_FALSE(__test);
| asmlinkage __visible void __init start_kernel(void)
| {
|        char *command_line;
|@@ -587,6 +609,10 @@ asmlinkage __visible void __init start_kernel(void)
|        vfs_caches_init_early();
|        sort_main_extable();
|        trap_init();
|+       {
|+       static_branch_enable(&__test);
|+       WARN_ON(!static_branch_likely(&__test));
|+       }
|        mm_init();

The following warnings show-up:
WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:701 text_poke+0x20d/0x230
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.18.0-rc1_pt_t1 #30
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.11.0-20171110_100015-anatol 04/01/2014
RIP: 0010:text_poke+0x20d/0x230
Code: 0f 0b 4c 89 e2 4c 89 ee 4c 89 f7 e8 7d 4b 9b 00 31 d2 31 f6 bf 86 02
00 00 48 8b 05 95 8e 24 01 e8 78 18 d8 00 e9 55 ff ff ff <0f> 0b e9 54 fe
ff ff 48 8b 05 75 a8 38 01 e9 64 fe ff ff 48 8b 1d
RSP: 0000:ffffffff94e03e30 EFLAGS: 00010046
RAX: 0100000000000000 RBX: fffff7b2c011f300 RCX: ffffffff94fcccf4
RDX: 0000000000000001 RSI: ffffffff94e03e77 RDI: ffffffff94fcccef
RBP: ffffffff94fcccef R08: 00000000fffffe00 R09: 00000000000000a0
R10: 0000000000000000 R11: 0000000000000040 R12: 0000000000000001
R13: ffffffff94e03e77 R14: ffffffff94fcdcef R15: fffff7b2c0000000
FS:  0000000000000000(0000) GS:ffff9adc87c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff9adc8499d000 CR3: 000000000460a001 CR4: 00000000000606b0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ? start_kernel+0x23e/0x4c8
 ? start_kernel+0x23f/0x4c8
 ? text_poke_bp+0x50/0xda
 ? arch_jump_label_transform+0x89/0xe0
 ? __jump_label_update+0x78/0xb0
 ? static_key_enable_cpuslocked+0x4d/0x80
 ? static_key_enable+0x11/0x20
 ? start_kernel+0x23e/0x4c8
 ? secondary_startup_64+0xa5/0xb0
---[ end trace abdc99c031b8a90a ]---

If the code above is moved after mm_init(), no warning is shown, as struct
pages are initialized during handover from memblock.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 2ecd34e2d46c..e85ff65c43c3 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -37,5 +37,6 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern int after_bootmem;
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a481763a3776..0230dbc3c599 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -686,13 +686,21 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
  *
  * Note: Must be called under text_mutex.
  */
-void *text_poke(void *addr, const void *opcode, size_t len)
+void __ref *text_poke(void *addr, const void *opcode, size_t len)
 {
 	unsigned long flags;
 	char *vaddr;
 	struct page *pages[2];
 	int i;
 
+	/* While boot memory allocator is runnig we cannot use struct
+	 * pages as they are not yet initialized. However, we also know
+	 * that this is early in boot, and it is safe to fallback to
+	 * text_poke_early.
+	 */
+	if (unlikely(!after_bootmem))
+		return text_poke_early(addr, opcode, len);
+
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
 		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
-- 
2.17.1

