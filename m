Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E515AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C08620864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C08620864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935005AbeFRISF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:18:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54406 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934957AbeFRISC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:18:02 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BABDFC7F;
        Mon, 18 Jun 2018 08:18:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Gargi Sharma <gs051095@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 069/279] proc: fix /proc/loadavg regression
Date:   Mon, 18 Jun 2018 10:10:54 +0200
Message-Id: <20180618080611.676135740@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Dobriyan <adobriyan@gmail.com>

[ Upstream commit 9a1015b32faa7cebfe19663c886b0cfe90be1d49 ]

Commit 95846ecf9dac ("pid: replace pid bitmap implementation with IDR
API") changed last field of /proc/loadavg (last pid allocated) to be off
by one:

	# unshare -p -f --mount-proc cat /proc/loadavg
	0.00 0.00 0.00 1/60 2	<===

It should be 1 after first fork into pid namespace.

This is formally a regression but given how useless this field is I
don't think anyone is affected.

Bug was found by /proc testsuite!

Link: http://lkml.kernel.org/r/20180413175408.GA27246@avx2
Fixes: 95846ecf9dac508 ("pid: replace pid bitmap implementation with IDR API")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Gargi Sharma <gs051095@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/platforms/cell/spufs/sched.c |    2 +-
 fs/proc/loadavg.c                         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -1093,7 +1093,7 @@ static int show_spu_loadavg(struct seq_f
 		LOAD_INT(c), LOAD_FRAC(c),
 		count_active_contexts(),
 		atomic_read(&nr_spu_contexts),
-		idr_get_cursor(&task_active_pid_ns(current)->idr));
+		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
 	return 0;
 }
 
--- a/fs/proc/loadavg.c
+++ b/fs/proc/loadavg.c
@@ -24,7 +24,7 @@ static int loadavg_proc_show(struct seq_
 		LOAD_INT(avnrun[1]), LOAD_FRAC(avnrun[1]),
 		LOAD_INT(avnrun[2]), LOAD_FRAC(avnrun[2]),
 		nr_running(), nr_threads,
-		idr_get_cursor(&task_active_pid_ns(current)->idr));
+		idr_get_cursor(&task_active_pid_ns(current)->idr) - 1);
 	return 0;
 }
 


