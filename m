Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030E7C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 07:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C558D2089D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 07:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C558D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeI3OPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 10:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbeI3OPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 10:15:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D75FA70A;
        Sun, 30 Sep 2018 07:43:21 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 470DD60164;
        Sun, 30 Sep 2018 07:43:17 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, peterx@redhat.com,
        linux-mm@kvack.org, Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kselftest@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/3] userfaultfd: selftest: recycle lock threads first
Date:   Sun, 30 Sep 2018 15:42:59 +0800
Message-Id: <20180930074259.18229-4-peterx@redhat.com>
In-Reply-To: <20180930074259.18229-1-peterx@redhat.com>
References: <20180930074259.18229-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 30 Sep 2018 07:43:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we recycle the uffd servicing threads earlier than the lock
threads.  It might happen that when the lock thread is still blocked at
a pthread mutex lock while the servicing thread has already quitted for
the cpu so the lock thread will be blocked forever and hang the test
program.  To fix the possible race, recycle the lock threads first.

This never happens with current missing-only tests, but when I start to
run the write-protection tests (the feature is not yet posted upstream)
it happens every time of the run possibly because in that new test we'll
need to service two page faults for each lock operation.

Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 7a8c6937cc67..5d1db824f73a 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -626,6 +626,12 @@ static int stress(unsigned long *userfaults)
 	if (uffd_test_ops->release_pages(area_src))
 		return 1;
 
+
+	finished = 1;
+	for (cpu = 0; cpu < nr_cpus; cpu++)
+		if (pthread_join(locking_threads[cpu], NULL))
+			return 1;
+
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		char c;
 		if (bounces & BOUNCE_POLL) {
@@ -643,11 +649,6 @@ static int stress(unsigned long *userfaults)
 		}
 	}
 
-	finished = 1;
-	for (cpu = 0; cpu < nr_cpus; cpu++)
-		if (pthread_join(locking_threads[cpu], NULL))
-			return 1;
-
 	return 0;
 }
 
-- 
2.17.1

