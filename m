Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20282C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B0C21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900560;
	bh=W5aHUB5JG86hnPsgC5USulLR+hcfb8pTzTgcmcDoHJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=He4Zy7Q2pR3lEYVL1H3aJJT1AvRWvl5uuQyRxzJEO1eKJbVyFVnaJ7ln57iZcI2nO
	 q7jwGxNOWjYHd/NmwG3LY5ooAyMEJltAWyCu0j2s5qaKB3UEj2gXSn/JYlZWk3O/Un
	 mmzCoRYdMcv0+K1eq86tVu6hsuvcbUg/Hg5+4QBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfBKOeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:34:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730886AbfBKOeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:34:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA88F204EC;
        Mon, 11 Feb 2019 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895683;
        bh=W5aHUB5JG86hnPsgC5USulLR+hcfb8pTzTgcmcDoHJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmrifAzKx4LyBsgcclduClClUUmP3GfRZ78+CirCs3l+GsbWHi3Hsv49IvGLXJs/h
         sqXKpPj7XinOpM9vgq9HTI8etE2IGKPamtVXsg19ySuiwmH/xz2JozcJYpE93nLJYT
         iqFzwLUej90qkzeugQDinyESdERW2nxRVtgyZSFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 288/352] kernel/kcov.c: mark write_comp_data() as notrace
Date:   Mon, 11 Feb 2019 15:18:35 +0100
Message-Id: <20190211141905.245111090@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 634724431607f6f46c495dfef801a1c8b44a96d9 ]

Since __sanitizer_cov_trace_const_cmp4 is marked as notrace, the
function called from __sanitizer_cov_trace_const_cmp4 shouldn't be
traceable either.  ftrace_graph_caller() gets called every time func
write_comp_data() gets called if it isn't marked 'notrace'.  This is the
backtrace from gdb:

 #0  ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:179
 #1  0xffffff8010201920 in ftrace_caller () at ../arch/arm64/kernel/entry-ftrace.S:151
 #2  0xffffff8010439714 in write_comp_data (type=5, arg1=0, arg2=0, ip=18446743524224276596) at ../kernel/kcov.c:116
 #3  0xffffff8010439894 in __sanitizer_cov_trace_const_cmp4 (arg1=<optimized out>, arg2=<optimized out>) at ../kernel/kcov.c:188
 #4  0xffffff8010201874 in prepare_ftrace_return (self_addr=18446743524226602768, parent=0xffffff801014b918, frame_pointer=18446743524223531344) at ./include/generated/atomic-instrumented.h:27
 #5  0xffffff801020194c in ftrace_graph_caller () at ../arch/arm64/kernel/entry-ftrace.S:182

Rework so that write_comp_data() that are called from
__sanitizer_cov_trace_*_cmp*() are marked as 'notrace'.

Commit 903e8ff86753 ("kernel/kcov.c: mark funcs in __sanitizer_cov_trace_pc() as notrace")
missed to mark write_comp_data() as 'notrace'. When that patch was
created gcc-7 was used. In lib/Kconfig.debug
config KCOV_ENABLE_COMPARISONS
	depends on $(cc-option,-fsanitize-coverage=trace-cmp)

That code path isn't hit with gcc-7. However, it were that with gcc-8.

Link: http://lkml.kernel.org/r/20181206143011.23719-1-anders.roxell@linaro.org
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 97959d7b77e2..c2277dbdbfb1 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -112,7 +112,7 @@ void notrace __sanitizer_cov_trace_pc(void)
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
 
 #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
-static void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
+static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 {
 	struct task_struct *t;
 	u64 *area;
-- 
2.19.1



