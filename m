Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B853C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0DA20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfAKGNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:13:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19975 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728042AbfAKGNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:13:23 -0500
X-IronPort-AV: E=Sophos;i="5.56,464,1539619200"; 
   d="scan'208";a="51771161"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Jan 2019 14:13:20 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 912FD4BAD914;
        Fri, 11 Jan 2019 14:13:17 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 11 Jan 2019 14:13:15 +0800
Date:   Fri, 11 Jan 2019 14:12:21 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Pingfan Liu <kernelfans@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Tejun Heo <tj@kernel.org>, Baoquan He <bhe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, <x86@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCHv2 1/7] x86/mm: concentrate the code to memblock allocator
 enabled
Message-ID: <20190111061221.GB13263@localhost.localdomain>
References: <1547183577-20309-1-git-send-email-kernelfans@gmail.com>
 <1547183577-20309-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1547183577-20309-2-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 912FD4BAD914.ADDB6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 01:12:51PM +0800, Pingfan Liu wrote:
>This patch identifies the point where memblock alloc start. It has no
>functional.
[...]
>+#ifdef CONFIG_MEMORY_HOTPLUG
>+	/*
>+	 * Memory used by the kernel cannot be hot-removed because Linux
>+	 * cannot migrate the kernel pages. When memory hotplug is
>+	 * enabled, we should prevent memblock from allocating memory
>+	 * for the kernel.
>+	 *
>+	 * ACPI SRAT records all hotpluggable memory ranges. But before
>+	 * SRAT is parsed, we don't know about it.
>+	 *
>+	 * The kernel image is loaded into memory at very early time. We
>+	 * cannot prevent this anyway. So on NUMA system, we set any
>+	 * node the kernel resides in as un-hotpluggable.
>+	 *
>+	 * Since on modern servers, one node could have double-digit
>+	 * gigabytes memory, we can assume the memory around the kernel
>+	 * image is also un-hotpluggable. So before SRAT is parsed, just
>+	 * allocate memory near the kernel image to try the best to keep
>+	 * the kernel away from hotpluggable memory.
>+	 */
>+	if (movable_node_is_enabled())
>+		memblock_set_bottom_up(true);

Hi Pingfan,

In my understanding, 'movable_node' is based on the that memory near
kernel is considered as in the same node as kernel in high possibility.

If SRAT has been parsed early, do we still need the kernel parameter
'movable_node'? Since you have got the memory information about hot-remove,
so I wonder if it's OK to drop 'movable_node', and if memory-hotremove is
enabled, change memblock allocation according to SRAT.

If there is something wrong in my understanding, please let me know.

Thanks,
Chao Fan

>+#endif
> 	init_mem_mapping();
>+	memblock_set_current_limit(get_max_mapped());
> 
> 	idt_setup_early_pf();
> 
>@@ -1145,8 +1145,6 @@ void __init setup_arch(char **cmdline_p)
> 	 */
> 	mmu_cr4_features = __read_cr4() & ~X86_CR4_PCIDE;
> 
>-	memblock_set_current_limit(get_max_mapped());
>-
> 	/*
> 	 * NOTE: On x86-32, only from this point on, fixmaps are ready for use.
> 	 */
>-- 
>2.7.4
>
>
>


