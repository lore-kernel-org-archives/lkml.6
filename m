Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBAFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB802183F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129615;
	bh=UkkHIB8YVvTGnflOkUabdf6Wr+AUoUopc6sHfSNANXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yuU/K+5wCQzyCP94oPR2C9YP8wvBSPMLVOncPXLf6lrf2Vws/Rp2w/GW5H173tIo+
	 Th4fhVsdCRWEQEIJjCndAV24G3swsOWsYWcEXzpwgwn/nZ377beJrf/V5oG1px1Zyy
	 q2oxU9asHSvsZFJUiAuzr9KsTs5bcBOI7U9BF2jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfBYVUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfBYVT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:19:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4EB205C9;
        Mon, 25 Feb 2019 21:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129598;
        bh=UkkHIB8YVvTGnflOkUabdf6Wr+AUoUopc6sHfSNANXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkAmuNTkDx4P8pZCmwjWhz7SwST/1+yjGjDWKvT1PCr2Y1W6CuNgkyK4fJY3Jh3XQ
         emJJf+Ls8nkHdHZ/1E8hl5r30rBWHdawadYZjMHlKaGll7o3VeywEmTqSDIu/j3prZ
         t4c6ZstK8rsBbGvI77nRa+t1x/OcIR/yP3uFkq54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 011/152] numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNODES
Date:   Mon, 25 Feb 2019 22:10:03 +0100
Message-Id: <20190225195044.424202937@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Campbell <rcampbell@nvidia.com>

commit 050c17f239fd53adb55aa768d4f41bc76c0fe045 upstream.

The system call, get_mempolicy() [1], passes an unsigned long *nodemask
pointer and an unsigned long maxnode argument which specifies the length
of the user's nodemask array in bits (which is rounded up).  The manual
page says that if the maxnode value is too small, get_mempolicy will
return EINVAL but there is no system call to return this minimum value.
To determine this value, some programs search /proc/<pid>/status for a
line starting with "Mems_allowed:" and use the number of digits in the
mask to determine the minimum value.  A recent change to the way this line
is formatted [2] causes these programs to compute a value less than
MAX_NUMNODES so get_mempolicy() returns EINVAL.

Change get_mempolicy(), the older compat version of get_mempolicy(), and
the copy_nodes_to_user() function to use nr_node_ids instead of
MAX_NUMNODES, thus preserving the defacto method of computing the minimum
size for the nodemask array and the maxnode argument.

[1] http://man7.org/linux/man-pages/man2/get_mempolicy.2.html
[2] https://lore.kernel.org/lkml/1545405631-6808-1-git-send-email-longman@redhat.com

Link: http://lkml.kernel.org/r/20190211180245.22295-1-rcampbell@nvidia.com
Fixes: 4fb8e5b89bcbbbb ("include/linux/nodemask.h: use nr_node_ids (not MAX_NUMNODES) in __nodemask_pr_numnodes()")
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Waiman Long <longman@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mempolicy.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1300,7 +1300,7 @@ static int copy_nodes_to_user(unsigned l
 			      nodemask_t *nodes)
 {
 	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
-	const int nbytes = BITS_TO_LONGS(MAX_NUMNODES) * sizeof(long);
+	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
 
 	if (copy > nbytes) {
 		if (copy > PAGE_SIZE)
@@ -1477,7 +1477,7 @@ static int kernel_get_mempolicy(int __us
 	int uninitialized_var(pval);
 	nodemask_t nodes;
 
-	if (nmask != NULL && maxnode < MAX_NUMNODES)
+	if (nmask != NULL && maxnode < nr_node_ids)
 		return -EINVAL;
 
 	err = do_get_mempolicy(&pval, &nodes, addr, flags);
@@ -1513,7 +1513,7 @@ COMPAT_SYSCALL_DEFINE5(get_mempolicy, in
 	unsigned long nr_bits, alloc_size;
 	DECLARE_BITMAP(bm, MAX_NUMNODES);
 
-	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
+	nr_bits = min_t(unsigned long, maxnode-1, nr_node_ids);
 	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
 
 	if (nmask)


