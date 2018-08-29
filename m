Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048DBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA8A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 04:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA8A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeH2H7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:59:01 -0400
Received: from nautica.notk.org ([91.121.71.147]:43596 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbeH2H7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:59:00 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 7C870C009; Wed, 29 Aug 2018 06:04:10 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Omar Sandoval <osandov@osandov.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH] proc/kcore: fix invalid memory access in multi-page read optimization
Date:   Wed, 29 Aug 2018 06:04:07 +0200
Message-Id: <1535515447-21167-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <20180828105959.GA29204@nautica>
References: <20180828105959.GA29204@nautica>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'm' kcore_list item can point to kclist_head, and it is incorrect to
look at m->addr / m->size in this case.
There is no choice but to run through the list of entries for every address
if we did not find any entry in the previous iteration

Fixes: bf991c2231117 ("proc/kcore: optimize multiple page reads")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

I guess now I'm looking at bf991c2231117 again that it would be slightly
more efficient to remove the !m check and initialize m to point to
kclist_head like this:
 m = list_entry(&kclist_head, struct kcore_list, list);
but it feels a bit forced to me; deferring the choice to others.

 fs/proc/kcore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index ad72261ee3fe..50036f6e1f52 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -451,7 +451,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		 * If this is the first iteration or the address is not within
 		 * the previous entry, search for a matching entry.
 		 */
-		if (!m || start < m->addr || start >= m->addr + m->size) {
+		if (!m || &m->list == &kclist_head || start < m->addr ||
+		    start >= m->addr + m->size) {
 			list_for_each_entry(m, &kclist_head, list) {
 				if (start >= m->addr &&
 				    start < m->addr + m->size)
-- 
2.17.1

