Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CB421905
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499220;
	bh=YPe4yvoudXS+CHeARtuNVNWXbRSiQfKWLv2cQQBvh5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V5wxBa+skgqWEfec/Oe6OHiDnK+tn8UswXaEr0jrHfNIIMcneFVUL/gEHF9Xoh/7W
	 p4mAwGVE75uvEcWb23+t4YxsvMdXFqUrKD5Gq0SONy6byw/xyIsQLqaaZw8c2nh3yU
	 EVtiO26Z3ZZxX5uYlbVWDOGI54wp6Fv9fAdVfqkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392395AbfBRONj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392351AbfBRONa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:13:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D5DC21916;
        Mon, 18 Feb 2019 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499210;
        bh=YPe4yvoudXS+CHeARtuNVNWXbRSiQfKWLv2cQQBvh5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mk5MKm+zWfpnRwDGKuLb/C3mof9FS0SQ1azEFRxu7Fvmtt0Nk3yj/Xb3B5iF3Crp5
         lhGfjDTtbIcnKdvLYQVLXJUuJaYjiA9QKmJs9DMiAzWmNnuoItoyWKw60ixFTQZrHt
         cNjC3mv+3wBTxaGf83psIyYdsfX6Y2CEjTUynC1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Derek Robson <robsonde@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Matz <matz@suse.de>, x86@kernel.org
Subject: [PATCH 3.18 104/108] x86/a.out: Clear the dump structure initially
Date:   Mon, 18 Feb 2019 14:44:40 +0100
Message-Id: <20190218133524.495775511@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit 10970e1b4be9c74fce8ab6e3c34a7d718f063f2c upstream.

dump_thread32() in aout_core_dump() does not clear the user32 structure
allocated on the stack as the first thing on function entry.

As a result, the dump.u_comm, dump.u_ar0 and dump.signal which get
assigned before the clearing, get overwritten.

Rename that function to fill_dump() to make it clear what it does and
call it first thing.

This was caught while staring at a patch by Derek Robson
<robsonde@gmail.com>.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Derek Robson <robsonde@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Matz <matz@suse.de>
Cc: x86@kernel.org
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190202005512.3144-1-robsonde@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/ia32/ia32_aout.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/ia32/ia32_aout.c
+++ b/arch/x86/ia32/ia32_aout.c
@@ -50,7 +50,7 @@ static unsigned long get_dr(int n)
 /*
  * fill in the user structure for a core dump..
  */
-static void dump_thread32(struct pt_regs *regs, struct user32 *dump)
+static void fill_dump(struct pt_regs *regs, struct user32 *dump)
 {
 	u32 fs, gs;
 	memset(dump, 0, sizeof(*dump));
@@ -156,10 +156,12 @@ static int aout_core_dump(struct coredum
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 	has_dumped = 1;
+
+	fill_dump(cprm->regs, &dump);
+
 	strncpy(dump.u_comm, current->comm, sizeof(current->comm));
 	dump.u_ar0 = offsetof(struct user32, regs);
 	dump.signal = cprm->siginfo->si_signo;
-	dump_thread32(cprm->regs, &dump);
 
 	/*
 	 * If the size of the dump file exceeds the rlimit, then see


