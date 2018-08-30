Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08548C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEB220658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEB220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbeH3UeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:34:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:17759 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeH3UeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:34:17 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="76796152"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Aug 2018 09:31:18 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fvPqZ-000EFl-Pd; Fri, 31 Aug 2018 00:31:03 +0800
Date:   Fri, 31 Aug 2018 00:30:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jann Horn <jannh@google.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: [tip:x86/urgent 9/11] arch/x86/kernel/dumpstack.c:107:17: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <201808310034.DEhufz3F%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
head:   16f54a362e4083218ac8d67a4879532c6eef2d98
commit: a644cf538b1125410421584c68b2013fdbecbd79 [9/11] x86/dumpstack: Don't dump kernel memory based on usermode RIP
reproduce:
        # apt-get install sparse
        git checkout a644cf538b1125410421584c68b2013fdbecbd79
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> arch/x86/kernel/dumpstack.c:107:17: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const volatile [noderef] <asn:1>*<noident> @@    got olatile [noderef] <asn:1>*<noident> @@
   arch/x86/kernel/dumpstack.c:107:17:    expected void const volatile [noderef] <asn:1>*<noident>
   arch/x86/kernel/dumpstack.c:107:17:    got unsigned char [usertype] *prologue

vim +107 arch/x86/kernel/dumpstack.c

    73	
    74	/*
    75	 * There are a couple of reasons for the 2/3rd prologue, courtesy of Linus:
    76	 *
    77	 * In case where we don't have the exact kernel image (which, if we did, we can
    78	 * simply disassemble and navigate to the RIP), the purpose of the bigger
    79	 * prologue is to have more context and to be able to correlate the code from
    80	 * the different toolchains better.
    81	 *
    82	 * In addition, it helps in recreating the register allocation of the failing
    83	 * kernel and thus make sense of the register dump.
    84	 *
    85	 * What is more, the additional complication of a variable length insn arch like
    86	 * x86 warrants having longer byte sequence before rIP so that the disassembler
    87	 * can "sync" up properly and find instruction boundaries when decoding the
    88	 * opcode bytes.
    89	 *
    90	 * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
    91	 * guesstimate in attempt to achieve all of the above.
    92	 */
    93	void show_opcodes(struct pt_regs *regs, const char *loglvl)
    94	{
    95	#define PROLOGUE_SIZE 42
    96	#define EPILOGUE_SIZE 21
    97	#define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
    98		u8 opcodes[OPCODE_BUFSIZE];
    99		u8 *prologue = (u8 *)(regs->ip - PROLOGUE_SIZE);
   100		bool bad_ip;
   101	
   102		/*
   103		 * Make sure userspace isn't trying to trick us into dumping kernel
   104		 * memory by pointing the userspace instruction pointer at it.
   105		 */
   106		bad_ip = user_mode(regs) &&
 > 107			__range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
   108	
   109		if (bad_ip || probe_kernel_read(opcodes, prologue, OPCODE_BUFSIZE)) {
   110			printk("%sCode: Bad RIP value.\n", loglvl);
   111		} else {
   112			printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
   113			       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
   114			       opcodes[PROLOGUE_SIZE], opcodes + PROLOGUE_SIZE + 1);
   115		}
   116	}
   117	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
