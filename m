Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B14C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE992147D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vdQLWKLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE992147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbeKTDA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbeKTDAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:00:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684D621479;
        Mon, 19 Nov 2018 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645406;
        bh=xaoyrTsrv3/VD4kZLWqR8sYKi93iI/jLaNUfG8K1wbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdQLWKLrUZu+P90x14q8Zfr3ZV02RmXp2016hP7xRlI+fhLYSp4QhFgR+HKLgZPEP
         lXnJLfyjHv2b5GB9vlx/Ulm/kAqLTW4/DO8lFgw/gOZaVnfRzHCJ3vLgHe5Wor7GUX
         24x4X5UrNCL9yTUXkU/q4m84EN+FZTKXQ6bgABOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wengang Wang <wen.gang.wang@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 102/205] ocfs2: free up write context when direct IO failed
Date:   Mon, 19 Nov 2018 17:26:49 +0100
Message-Id: <20181119162633.496649826@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wengang Wang <wen.gang.wang@oracle.com>

commit 5040f8df56fb90c7919f1c9b0b6e54c843437456 upstream.

The write context should also be freed even when direct IO failed.
Otherwise a memory leak is introduced and entries remain in
oi->ip_unwritten_list causing the following BUG later in unlink path:

  ERROR: bug expression: !list_empty(&oi->ip_unwritten_list)
  ERROR: Clear inode of 215043, inode has unwritten extents
  ...
  Call Trace:
  ? __set_current_blocked+0x42/0x68
  ocfs2_evict_inode+0x91/0x6a0 [ocfs2]
  ? bit_waitqueue+0x40/0x33
  evict+0xdb/0x1af
  iput+0x1a2/0x1f7
  do_unlinkat+0x194/0x28f
  SyS_unlinkat+0x1b/0x2f
  do_syscall_64+0x79/0x1ae
  entry_SYSCALL_64_after_hwframe+0x151/0x0

This patch also logs, with frequency limit, direct IO failures.

Link: http://lkml.kernel.org/r/20181102170632.25921-1-wen.gang.wang@oracle.com
Signed-off-by: Wengang Wang <wen.gang.wang@oracle.com>
Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ocfs2/aops.c            |   12 ++++++++++--
 fs/ocfs2/cluster/masklog.h |    9 +++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2412,8 +2412,16 @@ static int ocfs2_dio_end_io(struct kiocb
 	/* this io's submitter should not have unlocked this before we could */
 	BUG_ON(!ocfs2_iocb_is_rw_locked(iocb));
 
-	if (bytes > 0 && private)
-		ret = ocfs2_dio_end_io_write(inode, private, offset, bytes);
+	if (bytes <= 0)
+		mlog_ratelimited(ML_ERROR, "Direct IO failed, bytes = %lld",
+				 (long long)bytes);
+	if (private) {
+		if (bytes > 0)
+			ret = ocfs2_dio_end_io_write(inode, private, offset,
+						     bytes);
+		else
+			ocfs2_dio_free_write_ctx(inode, private);
+	}
 
 	ocfs2_iocb_clear_rw_locked(iocb);
 
--- a/fs/ocfs2/cluster/masklog.h
+++ b/fs/ocfs2/cluster/masklog.h
@@ -178,6 +178,15 @@ do {									\
 			      ##__VA_ARGS__);				\
 } while (0)
 
+#define mlog_ratelimited(mask, fmt, ...)				\
+do {									\
+	static DEFINE_RATELIMIT_STATE(_rs,				\
+				      DEFAULT_RATELIMIT_INTERVAL,	\
+				      DEFAULT_RATELIMIT_BURST);		\
+	if (__ratelimit(&_rs))						\
+		mlog(mask, fmt, ##__VA_ARGS__);				\
+} while (0)
+
 #define mlog_errno(st) ({						\
 	int _st = (st);							\
 	if (_st != -ERESTARTSYS && _st != -EINTR &&			\


