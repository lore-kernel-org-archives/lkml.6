Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD51AC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCD420895
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACCD420895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeI2PLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 11:11:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbeI2PLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 11:11:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C8398762B;
        Sat, 29 Sep 2018 08:43:29 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0C6A106A790;
        Sat, 29 Sep 2018 08:43:24 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        linux-mm@kvack.org, Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kselftest@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] userfaultfd: selftest: generalize read and poll
Date:   Sat, 29 Sep 2018 16:43:10 +0800
Message-Id: <20180929084311.15600-3-peterx@redhat.com>
In-Reply-To: <20180929084311.15600-1-peterx@redhat.com>
References: <20180929084311.15600-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 29 Sep 2018 08:43:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do very similar things in read and poll modes, but we're copying the
codes around.  Share the codes properly on reading the message and
handling the page fault to make the code cleaner.  Meanwhile this solves
previous mismatch of behaviors between the two modes on that the old
code:

- did not check EAGAIN case in read() mode
- ignored BOUNCE_VERIFY check in read() mode

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 76 +++++++++++++-----------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 2a84adaf8cf8..f79706f13ce7 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -449,6 +449,42 @@ static int copy_page(int ufd, unsigned long offset)
 	return __copy_page(ufd, offset, false);
 }
 
+static int uffd_read_msg(int ufd, struct uffd_msg *msg)
+{
+	int ret = read(uffd, msg, sizeof(*msg));
+
+	if (ret != sizeof(*msg)) {
+		if (ret < 0)
+			if (errno == EAGAIN)
+				return 1;
+			else
+				perror("blocking read error"), exit(1);
+		else
+				fprintf(stderr, "short read\n"), exit(1);
+	}
+
+	return 0;
+}
+
+/* Return 1 if page fault handled by us; otherwise 0 */
+static int uffd_handle_page_fault(struct uffd_msg *msg)
+{
+	unsigned long offset;
+
+	if (msg->event != UFFD_EVENT_PAGEFAULT)
+		fprintf(stderr, "unexpected msg event %u\n",
+			msg->event), exit(1);
+
+	if (bounces & BOUNCE_VERIFY &&
+	    msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
+		fprintf(stderr, "unexpected write fault\n"), exit(1);
+
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+	offset &= ~(page_size-1);
+
+	return copy_page(uffd, offset);
+}
+
 static void *uffd_poll_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
@@ -456,7 +492,6 @@ static void *uffd_poll_thread(void *arg)
 	struct uffd_msg msg;
 	struct uffdio_register uffd_reg;
 	int ret;
-	unsigned long offset;
 	char tmp_chr;
 	unsigned long userfaults = 0;
 
@@ -480,25 +515,15 @@ static void *uffd_poll_thread(void *arg)
 		if (!(pollfd[0].revents & POLLIN))
 			fprintf(stderr, "pollfd[0].revents %d\n",
 				pollfd[0].revents), exit(1);
-		ret = read(uffd, &msg, sizeof(msg));
-		if (ret < 0) {
-			if (errno == EAGAIN)
-				continue;
-			perror("nonblocking read error"), exit(1);
-		}
+		if (uffd_read_msg(uffd, &msg))
+			continue;
 		switch (msg.event) {
 		default:
 			fprintf(stderr, "unexpected msg event %u\n",
 				msg.event), exit(1);
 			break;
 		case UFFD_EVENT_PAGEFAULT:
-			if (msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
-				fprintf(stderr, "unexpected write fault\n"), exit(1);
-			offset = (char *)(unsigned long)msg.arg.pagefault.address -
-				area_dst;
-			offset &= ~(page_size-1);
-			if (copy_page(uffd, offset))
-				userfaults++;
+			userfaults += uffd_handle_page_fault(&msg);
 			break;
 		case UFFD_EVENT_FORK:
 			close(uffd);
@@ -526,8 +551,6 @@ static void *uffd_read_thread(void *arg)
 {
 	unsigned long *this_cpu_userfaults;
 	struct uffd_msg msg;
-	unsigned long offset;
-	int ret;
 
 	this_cpu_userfaults = (unsigned long *) arg;
 	*this_cpu_userfaults = 0;
@@ -536,24 +559,9 @@ static void *uffd_read_thread(void *arg)
 	/* from here cancellation is ok */
 
 	for (;;) {
-		ret = read(uffd, &msg, sizeof(msg));
-		if (ret != sizeof(msg)) {
-			if (ret < 0)
-				perror("blocking read error"), exit(1);
-			else
-				fprintf(stderr, "short read\n"), exit(1);
-		}
-		if (msg.event != UFFD_EVENT_PAGEFAULT)
-			fprintf(stderr, "unexpected msg event %u\n",
-				msg.event), exit(1);
-		if (bounces & BOUNCE_VERIFY &&
-		    msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
-			fprintf(stderr, "unexpected write fault\n"), exit(1);
-		offset = (char *)(unsigned long)msg.arg.pagefault.address -
-			 area_dst;
-		offset &= ~(page_size-1);
-		if (copy_page(uffd, offset))
-			(*this_cpu_userfaults)++;
+		if (uffd_read_msg(uffd, &msg))
+			continue;
+		(*this_cpu_userfaults) += uffd_handle_page_fault(&msg);
 	}
 	return (void *)NULL;
 }
-- 
2.17.1

