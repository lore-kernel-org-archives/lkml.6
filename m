Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A2AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1005214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1005214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbeIQQcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:32:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54507 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbeIQQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:32:24 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1rLL-0001Z2-KO; Mon, 17 Sep 2018 13:05:27 +0200
Date:   Mon, 17 Sep 2018 13:05:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     kernel test robot <rong.a.chen@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>, lkp@01.org
Subject: Re: [LKP] [x86/mm/cpa] c77d419f92:
 WARNING:at_arch/x86/mm/pageattr.c:#__change_page_attr_set_clr
In-Reply-To: <20180917003127.GJ7632@shao2-debian>
Message-ID: <alpine.DEB.2.21.1809171258560.16580@nanos.tec.linutronix.de>
References: <20180917003127.GJ7632@shao2-debian>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Sep 2018, kernel test robot wrote:
>
> [    5.168861] WARNING: CPU: 0 PID: 1 at arch/x86/mm/pageattr.c:829 __change_page_attr_set_clr+0x324/0x7b8

> [    5.172255] EIP: __change_page_attr_set_clr+0x324/0x7b8
> [    5.178966]  change_page_attr_set_clr+0x101/0x29c
> [    5.179497]  ? preempt_count_add+0x5b/0x8c
> [    5.179953]  set_memory_ro+0x19/0x1b
> [    5.180356]  set_pages_ro+0x14/0x16
> [    5.180757]  mark_rodata_ro+0x73/0xa5

That's caused by 32bit mark_rodata_ro() doing:

       set_ro(kernel_text)
       kernel_set_to_readonly = 1;
       set_ro(rodata);

kernel_set_to_readonly enables the protection mechanism in CPA and
consequently triggers the WARN_ON() telling that the existing PTE/PMD is
incorrect vs. static protections.

64bit does not trigger this because it makes kernel text and rodata
readonly in one go. There is no real reasons not to do so on 32bit, so the
fix is obvious.

Thanks,

	tglx

8<------------------
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -923,34 +923,19 @@ static void mark_nxdata_nx(void)
 void mark_rodata_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long size = PFN_ALIGN(_etext) - start;
+	unsigned long size = (unsigned long)__end_rodata - start;
 
 	set_pages_ro(virt_to_page(start), size >> PAGE_SHIFT);
-	printk(KERN_INFO "Write protecting the kernel text: %luk\n",
+	pr_info("Write protecting kernel text and read-only data: %luk\n",
 		size >> 10);
 
 	kernel_set_to_readonly = 1;
 
 #ifdef CONFIG_CPA_DEBUG
-	printk(KERN_INFO "Testing CPA: Reverting %lx-%lx\n",
-		start, start+size);
-	set_pages_rw(virt_to_page(start), size>>PAGE_SHIFT);
-
-	printk(KERN_INFO "Testing CPA: write protecting again\n");
-	set_pages_ro(virt_to_page(start), size>>PAGE_SHIFT);
-#endif
-
-	start += size;
-	size = (unsigned long)__end_rodata - start;
-	set_pages_ro(virt_to_page(start), size >> PAGE_SHIFT);
-	printk(KERN_INFO "Write protecting the kernel read-only data: %luk\n",
-		size >> 10);
-
-#ifdef CONFIG_CPA_DEBUG
-	printk(KERN_INFO "Testing CPA: undo %lx-%lx\n", start, start + size);
+	pr_info("Testing CPA: Reverting %lx-%lx\n", start, start + size);
 	set_pages_rw(virt_to_page(start), size >> PAGE_SHIFT);
 
-	printk(KERN_INFO "Testing CPA: write protecting again\n");
+	pr_info("Testing CPA: write protecting again\n");
 	set_pages_ro(virt_to_page(start), size >> PAGE_SHIFT);
 #endif
 	mark_nxdata_nx();


