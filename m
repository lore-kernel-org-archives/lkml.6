Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27867C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9642148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789828;
	bh=kGPn44POXcr1cm6LnGg8xi5OesJ0PYxwW7NQVuioPfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gmyJ3gTQz3Oy+/dlSE1U2ZpCmL5WZc6XHtL4GgUy7aq5bni/i3ucEZd9dpniPEzP0
	 4iMl1nPew80OVyPhQG7GB88w38bVhyy8yEHbZZHIcKmrJqIRSbBJ7AL3cI2Ti7Vh2n
	 ZcEu3t0WfUCvVg7y+h2MWWE0SJdiT5muU0uq23uw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9642148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbeLNMRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732864AbeLNMRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:17:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84AC1214F1;
        Fri, 14 Dec 2018 12:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789822;
        bh=kGPn44POXcr1cm6LnGg8xi5OesJ0PYxwW7NQVuioPfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHYzyY5m+DjRR8fPe8SRo5RK9GHf5dgRHkEK0F4RuHDWAuxZIUnkgia+YVYpNidcz
         LugqaKSAKKQuu0lTWBVL/EFhk51NxltNLUvl2AD++R4kpwD2FLoKCvyxgOq8JjOuuf
         hdQfAM+LzFdJpVPQV6jYngvQY2+9Q4QOH5uNWQWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 82/88] proc: dont use FOLL_FORCE for reading cmdline and environment
Date:   Fri, 14 Dec 2018 13:00:56 +0100
Message-Id: <20181214115708.851388434@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 272ddc8b37354c3fe111ab26d25e792629148eee upstream.

Now that Lorenzo cleaned things up and made the FOLL_FORCE users
explicit, it becomes obvious how some of them don't really need
FOLL_FORCE at all.

So remove FOLL_FORCE from the proc code that reads the command line and
arguments from user space.

The mem_rw() function actually does want FOLL_FORCE, because gdd (and
possibly many other debuggers) use it as a much more convenient version
of PTRACE_PEEKDATA, but we should consider making the FOLL_FORCE part
conditional on actually being a ptracer.  This does not actually do
that, just moves adds a comment to that effect and moves the gup_flags
settings next to each other.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/base.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -254,7 +254,7 @@ static ssize_t proc_pid_cmdline_read(str
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	rv = access_remote_vm(mm, arg_end - 1, &c, 1, FOLL_FORCE);
+	rv = access_remote_vm(mm, arg_end - 1, &c, 1, 0);
 	if (rv <= 0)
 		goto out_free_page;
 
@@ -272,8 +272,7 @@ static ssize_t proc_pid_cmdline_read(str
 			int nr_read;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count,
-					FOLL_FORCE);
+			nr_read = access_remote_vm(mm, p, page, _count, 0);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -308,8 +307,7 @@ static ssize_t proc_pid_cmdline_read(str
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count,
-					FOLL_FORCE);
+			nr_read = access_remote_vm(mm, p, page, _count, 0);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -358,8 +356,7 @@ skip_argv:
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count,
-					FOLL_FORCE);
+			nr_read = access_remote_vm(mm, p, page, _count, 0);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -871,7 +868,7 @@ static ssize_t mem_rw(struct file *file,
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
-	unsigned int flags = FOLL_FORCE;
+	unsigned int flags;
 
 	if (!mm)
 		return 0;
@@ -884,6 +881,8 @@ static ssize_t mem_rw(struct file *file,
 	if (!atomic_inc_not_zero(&mm->mm_users))
 		goto free;
 
+	/* Maybe we should limit FOLL_FORCE to actual ptrace users? */
+	flags = FOLL_FORCE;
 	if (write)
 		flags |= FOLL_WRITE;
 
@@ -1007,8 +1006,7 @@ static ssize_t environ_read(struct file
 		max_len = min_t(size_t, PAGE_SIZE, count);
 		this_len = min(max_len, this_len);
 
-		retval = access_remote_vm(mm, (env_start + src),
-			page, this_len, FOLL_FORCE);
+		retval = access_remote_vm(mm, (env_start + src), page, this_len, 0);
 
 		if (retval <= 0) {
 			ret = retval;


