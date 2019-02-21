Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C93C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5BE2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760095;
	bh=Iz1BDuXWWXpqviAlGb8bEp19XhGsmXoX1ZkLrnHJeOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rzEsMmuzOI+Yd+f0PRPdiPAczDxeEK11WnpminiJzk5QSOUIE/qpw/v+9sp88LSdL
	 GXbP/wJdDsIjSCtwt57VfRbv3Uh6PFtJJraP5wam+/iCC0D5T9qsgNW/KmOkZcvRdX
	 NdKSNVa5TcmIVocLt76WPiaij/arTHO39smFHCT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfBUOld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbfBUOlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:41:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D922085A;
        Thu, 21 Feb 2019 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760091;
        bh=Iz1BDuXWWXpqviAlGb8bEp19XhGsmXoX1ZkLrnHJeOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGl+dWt46HEteBO3ziBKZrs/CsTmCIQOmoPWSAwo8AQOXJRdyeXagf0xTr7Whc87M
         ilgteSnW5BQIu/Z1aijA2B67ImojmK7sVbNDfaNKw+jjHkEW/4R0xC5/Hxw2RMdxR0
         Rgt3QhhkhWAfVLKiHruHTROvS7QWdI2J0T/+tHLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 23/30] x86_64: increase stack size for KASAN_EXTRA
Date:   Thu, 21 Feb 2019 15:36:05 +0100
Message-Id: <20190221125251.864751477@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qian Cai <cai@lca.pw>

commit a8e911d13540487942d53137c156bd7707f66e5d upstream.

If the kernel is configured with KASAN_EXTRA, the stack size is
increasted significantly because this option sets "-fstack-reuse" to
"none" in GCC [1].  As a result, it triggers stack overrun quite often
with 32k stack size compiled using GCC 8.  For example, this reproducer

  https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise06.c

triggers a "corrupted stack end detected inside scheduler" very reliably
with CONFIG_SCHED_STACK_END_CHECK enabled.

There are just too many functions that could have a large stack with
KASAN_EXTRA due to large local variables that have been called over and
over again without being able to reuse the stacks.  Some noticiable ones
are

  size
  7648 shrink_page_list
  3584 xfs_rmap_convert
  3312 migrate_page_move_mapping
  3312 dev_ethtool
  3200 migrate_misplaced_transhuge_page
  3168 copy_process

There are other 49 functions are over 2k in size while compiling kernel
with "-Wframe-larger-than=" even with a related minimal config on this
machine.  Hence, it is too much work to change Makefiles for each object
to compile without "-fsanitize-address-use-after-scope" individually.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715#c23

Although there is a patch in GCC 9 to help the situation, GCC 9 probably
won't be released in a few months and then it probably take another
6-month to 1-year for all major distros to include it as a default.
Hence, the stack usage with KASAN_EXTRA can be revisited again in 2020
when GCC 9 is everywhere.  Until then, this patch will help users avoid
stack overrun.

This has already been fixed for arm64 for the same reason via
6e8830674ea ("arm64: kasan: Increase stack size for KASAN_EXTRA").

Link: http://lkml.kernel.org/r/20190109215209.2903-1-cai@lca.pw
Signed-off-by: Qian Cai <cai@lca.pw>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/page_64_types.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -7,7 +7,11 @@
 #endif
 
 #ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_EXTRA
+#define KASAN_STACK_ORDER 2
+#else
 #define KASAN_STACK_ORDER 1
+#endif
 #else
 #define KASAN_STACK_ORDER 0
 #endif


