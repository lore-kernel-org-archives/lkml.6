Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A974C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536292075C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278368;
	bh=JTHLdlqJvTqGR4pF+fed10XzztucltY7/0kBhDxYKSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NiT0sZAtdKXQn9h9Y/VuOiiJQhjR6mfNr4kNmjZVoiQqOSpHbYTKH358WQqU4K0L2
	 QLHYZMTG64oxXKWOFx8Nzg8obY5hxIjgRqWBQmd0mBkUXZc6y6xOqSHVM3DzYacezj
	 U5zKZQ1+56m6RCZQaliSa8B5EfbIRPeIiBgbjHWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfBDLGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbfBDKoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:44:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1E42070C;
        Mon,  4 Feb 2019 10:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277040;
        bh=JTHLdlqJvTqGR4pF+fed10XzztucltY7/0kBhDxYKSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXBYziDaWmlEhXquuF8goD770TO/O0Bkg4/wYBGdepQU6n6IlRa7i+s1PL0bnveX+
         glaHB/uWmn/gVgGjoXK44yIVeG7eNTSGgEs7iVXeE6pEVgjaSvHbcntfuttsoqnIIz
         Bg3NFbrK+FqavuQvSA8KEf3F7arqy/XYNATyzzsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Jane Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 25/30] mm: hwpoison: use do_send_sig_info() instead of force_sig()
Date:   Mon,  4 Feb 2019 11:37:03 +0100
Message-Id: <20190204103609.932566838@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103605.271746870@linuxfoundation.org>
References: <20190204103605.271746870@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

commit 6376360ecbe525a9c17b3d081dfd88ba3e4ed65b upstream.

Currently memory_failure() is racy against process's exiting, which
results in kernel crash by null pointer dereference.

The root cause is that memory_failure() uses force_sig() to forcibly
kill asynchronous (meaning not in the current context) processes.  As
discussed in thread https://lkml.org/lkml/2010/6/8/236 years ago for OOM
fixes, this is not a right thing to do.  OOM solves this issue by using
do_send_sig_info() as done in commit d2d393099de2 ("signal:
oom_kill_task: use SEND_SIG_FORCED instead of force_sig()"), so this
patch is suggesting to do the same for hwpoison.  do_send_sig_info()
properly accesses to siglock with lock_task_sighand(), so is free from
the reported race.

I confirmed that the reported bug reproduces with inserting some delay
in kill_procs(), and it never reproduces with this patch.

Note that memory_failure() can send another type of signal using
force_sig_mceerr(), and the reported race shouldn't happen on it because
force_sig_mceerr() is called only for synchronous processes (i.e.
BUS_MCEERR_AR happens only when some process accesses to the corrupted
memory.)

Link: http://lkml.kernel.org/r/20190116093046.GA29835@hori1.linux.bs1.fc.nec.co.jp
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reported-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory-failure.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -336,7 +336,8 @@ static void kill_procs(struct list_head
 			if (fail || tk->addr_valid == 0) {
 				pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
 				       pfn, tk->tsk->comm, tk->tsk->pid);
-				force_sig(SIGKILL, tk->tsk);
+				do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
+						 tk->tsk, PIDTYPE_PID);
 			}
 
 			/*


