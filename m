Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4824C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A998218A1
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277615;
	bh=l2WektBcJyBZejXsMFxm0AU68hN/47LqgaNyFXkcG4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Muvfps+WeHnhqNGHPVv+ZzEZ5TXIQuFindnew5rRx2WcT207SJO6QC3hh4GZqqBBN
	 +fUQz9QGqjniSVkmn56PKoo3LH5akM8enoCdVgRthzqGW8ql3vYKYHiDmO2NTk0C1b
	 ya8A1gv+ZacG3vhXZjdre7OoaglfXL3DmaHenAqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732797AbfBDKxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:53:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732763AbfBDKxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:53:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11D0A2184B;
        Mon,  4 Feb 2019 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277610;
        bh=l2WektBcJyBZejXsMFxm0AU68hN/47LqgaNyFXkcG4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GphzHmXTKNBIA+UyfLnl7rrNvvYt7bhFUPA2+fkYyozxSgi1JFHk10L65Ba5QnFLj
         9XnQiieKXNMooO0mb0ZqRi6o0m6vT2kNjPgwR4QFloJ1EiDbidxEMoyxny0syNrXGI
         FnQwx8pJzrty2GK4HUSzIUt4w3WwVrFui11W9Z4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 69/80] mm/hugetlb.c: teach follow_hugetlb_page() to handle FOLL_NOWAIT
Date:   Mon,  4 Feb 2019 11:37:29 +0100
Message-Id: <20190204103629.622186172@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Andrea Arcangeli <aarcange@redhat.com>

commit 1ac25013fb9e4ed595cd608a406191e93520881e upstream.

hugetlb needs the same fix as faultin_nopage (which was applied in
commit 96312e61282a ("mm/gup.c: teach get_user_pages_unlocked to handle
FOLL_NOWAIT")) or KVM hangs because it thinks the mmap_sem was already
released by hugetlb_fault() if it returned VM_FAULT_RETRY, but it wasn't
in the FOLL_NOWAIT case.

Link: http://lkml.kernel.org/r/20190109020203.26669-2-aarcange@redhat.com
Fixes: ce53053ce378 ("kvm: switch get_user_page_nowait() to get_user_pages_unlocked()")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Tested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/hugetlb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4270,7 +4270,8 @@ long follow_hugetlb_page(struct mm_struc
 				break;
 			}
 			if (ret & VM_FAULT_RETRY) {
-				if (nonblocking)
+				if (nonblocking &&
+				    !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
 					*nonblocking = 0;
 				*nr_pages = 0;
 				/*


