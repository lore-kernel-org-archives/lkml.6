Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B73ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8960420652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="QnOvrCDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8960420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbeGTRLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:11:41 -0400
Received: from 8bytes.org ([81.169.241.247]:35720 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387822AbeGTRLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:11:40 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 13787450; Fri, 20 Jul 2018 18:22:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532103759; bh=kqBTbTaBbz8EbgmB3AwTXiJkPwtCRz2xn4k5jm1THBA=;
        h=From:To:Cc:Subject:Date:From;
        b=QnOvrCDSIhdvOhhlrMVQod/lTfpktKj6qW9SCFLDSjnjM5eMaDQxR8X2qcf6hS7wl
         OjflpAVni5W23c2KejbtgqWTSKNFeXW6aFSfo3WZzJTelCbNaIPjAVpScRSrtVUatA
         bfWIBWUnNfncBe7gfLHX1CiFGmnZtrYz1V/4ObVBhIFp+leTyA+4I2KO+aaJo+widB
         1OApjs8dgjrFuoXOFm3YzxCV8pLQM4E4syVF0mJ+cDnVKfTyGFsLU8GAKSI1RoBFD2
         jvnsvmkrMbAj5ego3xDskNdvymwn26GZxz8fyyUMZ09WRw6tPTFTPzIhy5x2yZvlTx
         /Nh9itgLWiigA==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, joro@8bytes.org
Subject: [PATCH 0/3] PTI for x86-32 Fixes and Updates
Date:   Fri, 20 Jul 2018 18:22:21 +0200
Message-Id: <1532103744-31902-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are 3 patches which update the PTI-x86-32 patches recently merged
into the tip-tree. The patches are ordered by importance:

	Patch 1: Very important, it fixes a vmalloc-fault in NMI context
		 when PTI is enabled. This is pretty unlikely to hit
		 when starting perf on an idle machine, which is why I
		 didn't find it earlier in my testing. I always started
		 'perf top' first :/ But when I start 'perf top' last
		 when the kernel-compile already runs, it hits almost
		 immediatly.

	Patch 2: Fix the 'from-kernel-check' in SWITCH_TO_KERNEL_STACK
	         to also take VM86 into account. This is not strictly
		 necessary because the slow-path also works for VM86
		 mode but it is not how the code was intended to work.
		 And it breaks when Patch 3 is applied on-top.

	Patch 3: Implement the reduced copying in the paranoid
		 entry/exit path as suggested by Andy Lutomirski while
		 reviewing version 7 of the original patches.

I have the x86/tip branch with these patches on-top running my test for
6h now, with no issues so far. So for now it looks like there are no
scheduling points or irq-enabled sections reached from the paranoid
entry/exit paths and we always return to the entry-stack we came from.

I keep the test running over the weekend at least.

Please review.

[ If Patch 1 looks good to the maintainers I suggest applying it soon,
  before too many linux-next testers run into this issue. It is actually
  the reason why I send out the patches _now_ and didn't wait until next
  week when the other two patches got more testing from my side. ]

Thanks,

	Joerg

Joerg Roedel (3):
  perf/core: Make sure the ring-buffer is mapped in all page-tables
  x86/entry/32: Check for VM86 mode in slow-path check
  x86/entry/32: Copy only ptregs on paranoid entry/exit path

 arch/x86/entry/entry_32.S   | 82 ++++++++++++++++++++++++++-------------------
 kernel/events/ring_buffer.c | 10 ++++++
 2 files changed, 58 insertions(+), 34 deletions(-)

-- 
2.7.4

