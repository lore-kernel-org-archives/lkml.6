Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E99C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501042;
	bh=QlmTI38CikDwlNWP3hb4ZB2iiqiFem2te4/0+e1hb48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=imo62NbhrKIAJVoRY63iJ9qWHGEhlbiJhcWUuEeNs/1ZL23zrqR0YjG/Uk8qABEQm
	 mgyOj0OTXYAblHFo3XkmJSjz61+jzurzxXwGaiWC1UyrVU3E3D0qIHV0nnyUTQG+cT
	 HAgYYeee3pPsoPef4/HErRKp0YZamCeNyO6nYeYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfBROoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:44:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbfBRNst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBEBE21906;
        Mon, 18 Feb 2019 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497729;
        bh=QlmTI38CikDwlNWP3hb4ZB2iiqiFem2te4/0+e1hb48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2zL5BCElWvnW1UxfidIECOnWZ8mbf40kkwwXEXGZluQBIim0fKNZLPq3D3RljLHh
         0ylKEdGmNPSphJD/OP547PDQ9hzkfY1W2w0INcpxu07Hs4mIVRVx8/cxhB/H6DEo4C
         4Yoq8xQU8XQ0NlwmSqYNzHthVVKtYSBEdjRtSh1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Derek Robson <robsonde@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Matz <matz@suse.de>, x86@kernel.org
Subject: [PATCH 4.20 84/92] x86/a.out: Clear the dump structure initially
Date:   Mon, 18 Feb 2019 14:43:27 +0100
Message-Id: <20190218133503.140579864@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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
@@ -51,7 +51,7 @@ static unsigned long get_dr(int n)
 /*
  * fill in the user structure for a core dump..
  */
-static void dump_thread32(struct pt_regs *regs, struct user32 *dump)
+static void fill_dump(struct pt_regs *regs, struct user32 *dump)
 {
 	u32 fs, gs;
 	memset(dump, 0, sizeof(*dump));
@@ -157,10 +157,12 @@ static int aout_core_dump(struct coredum
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


