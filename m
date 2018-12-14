Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD5FC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FF9214C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789870;
	bh=Jbm01gQtGCnIpRmTJIqywSKEtZ+xQiggI+2BnWPWU/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qt80yIvYQ2En86SM7nYHshOwVnQR1L5iDiS8JrDcJitPhaa9n5krt71/Ahq8/kyct
	 9ggeFtLnXwHrbOxduCcxk/Czg/fhvhqqjKrcXWrWTD7ESLfdAtb5ert9juetJ77tXl
	 oCA7kgWMJpoeJ3be5ftBmjGVA6rcXQL/iuQv5f3Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FF9214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbeLNMRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732847AbeLNMRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:17:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED240214DE;
        Fri, 14 Dec 2018 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789819;
        bh=Jbm01gQtGCnIpRmTJIqywSKEtZ+xQiggI+2BnWPWU/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ayq1tdrzid9jaRhNuIik64ayVXz8gFC4sda7fwtdQpEYkqIHADoILIb8OSc/UUTS/
         YZGCxjNlwfGl8DJwHBGJkoq6oqFYpQXcKfgDOQYqFAMq4zuxFoOPO4lnPcycKtIKoD
         CNDXlR6zRZHmgSWDJN72+d3GMUghtPZLEuQMwK9Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 81/88] mm: replace access_remote_vm() write parameter with gup_flags
Date:   Fri, 14 Dec 2018 13:00:55 +0100
Message-Id: <20181214115708.779806966@linuxfoundation.org>
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

From: Lorenzo Stoakes <lstoakes@gmail.com>

commit 6347e8d5bcce33fc36e651901efefbe2c93a43ef upstream.

This removes the 'write' argument from access_remote_vm() and replaces
it with 'gup_flags' as use of this function previously silently implied
FOLL_FORCE, whereas after this patch callers explicitly pass this flag.

We make this explicit as use of FOLL_FORCE can result in surprising
behaviour (and hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/base.c     |   19 +++++++++++++------
 include/linux/mm.h |    2 +-
 mm/memory.c        |   11 +++--------
 mm/nommu.c         |    7 +++----
 4 files changed, 20 insertions(+), 19 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -254,7 +254,7 @@ static ssize_t proc_pid_cmdline_read(str
 	 * Inherently racy -- command line shares address space
 	 * with code and data.
 	 */
-	rv = access_remote_vm(mm, arg_end - 1, &c, 1, 0);
+	rv = access_remote_vm(mm, arg_end - 1, &c, 1, FOLL_FORCE);
 	if (rv <= 0)
 		goto out_free_page;
 
@@ -272,7 +272,8 @@ static ssize_t proc_pid_cmdline_read(str
 			int nr_read;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count,
+					FOLL_FORCE);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -307,7 +308,8 @@ static ssize_t proc_pid_cmdline_read(str
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count,
+					FOLL_FORCE);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -356,7 +358,8 @@ skip_argv:
 			bool final;
 
 			_count = min3(count, len, PAGE_SIZE);
-			nr_read = access_remote_vm(mm, p, page, _count, 0);
+			nr_read = access_remote_vm(mm, p, page, _count,
+					FOLL_FORCE);
 			if (nr_read < 0)
 				rv = nr_read;
 			if (nr_read <= 0)
@@ -868,6 +871,7 @@ static ssize_t mem_rw(struct file *file,
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
+	unsigned int flags = FOLL_FORCE;
 
 	if (!mm)
 		return 0;
@@ -880,6 +884,9 @@ static ssize_t mem_rw(struct file *file,
 	if (!atomic_inc_not_zero(&mm->mm_users))
 		goto free;
 
+	if (write)
+		flags |= FOLL_WRITE;
+
 	while (count > 0) {
 		int this_len = min_t(int, count, PAGE_SIZE);
 
@@ -888,7 +895,7 @@ static ssize_t mem_rw(struct file *file,
 			break;
 		}
 
-		this_len = access_remote_vm(mm, addr, page, this_len, write);
+		this_len = access_remote_vm(mm, addr, page, this_len, flags);
 		if (!this_len) {
 			if (!copied)
 				copied = -EIO;
@@ -1001,7 +1008,7 @@ static ssize_t environ_read(struct file
 		this_len = min(max_len, this_len);
 
 		retval = access_remote_vm(mm, (env_start + src),
-			page, this_len, 0);
+			page, this_len, FOLL_FORCE);
 
 		if (retval <= 0) {
 			ret = retval;
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1191,7 +1191,7 @@ static inline int fixup_user_fault(struc
 
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
-		void *buf, int len, int write);
+		void *buf, int len, unsigned int gup_flags);
 
 long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		      unsigned long start, unsigned long nr_pages,
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3777,19 +3777,14 @@ static int __access_remote_vm(struct tas
  * @addr:	start address to access
  * @buf:	source or destination buffer
  * @len:	number of bytes to transfer
- * @write:	whether the access is a write
+ * @gup_flags:	flags modifying lookup behaviour
  *
  * The caller must hold a reference on @mm.
  */
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
-		void *buf, int len, int write)
+		void *buf, int len, unsigned int gup_flags)
 {
-	unsigned int flags = FOLL_FORCE;
-
-	if (write)
-		flags |= FOLL_WRITE;
-
-	return __access_remote_vm(NULL, mm, addr, buf, len, flags);
+	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
 }
 
 /*
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1967,15 +1967,14 @@ static int __access_remote_vm(struct tas
  * @addr:	start address to access
  * @buf:	source or destination buffer
  * @len:	number of bytes to transfer
- * @write:	whether the access is a write
+ * @gup_flags:	flags modifying lookup behaviour
  *
  * The caller must hold a reference on @mm.
  */
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
-		void *buf, int len, int write)
+		void *buf, int len, unsigned int gup_flags)
 {
-	return __access_remote_vm(NULL, mm, addr, buf, len,
-			write ? FOLL_WRITE : 0);
+	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
 }
 
 /*


