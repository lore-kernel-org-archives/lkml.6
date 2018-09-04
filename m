Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0DC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485242073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485242073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbeIEDFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:05:45 -0400
Received: from nautica.notk.org ([91.121.71.147]:41259 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEDFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:05:45 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 05C77C009; Wed,  5 Sep 2018 00:38:32 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Omar Sandoval <osandov@osandov.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v3] proc/kcore: fix invalid memory access in multi-page read optimization
Date:   Wed,  5 Sep 2018 00:38:22 +0200
Message-Id: <1536100702-28706-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1536100545-26905-1-git-send-email-asmadeus@codewreck.org>
References: <1536100545-26905-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'm' kcore_list item could point to kclist_head, and it is incorrect to
look at m->addr / m->size in this case.
There is no choice but to run through the list of entries for every address
if we did not find any entry in the previous iteration

Reset 'm' to NULL in that case at Omar Sandoval's suggestion.

Fixes: bf991c2231117 ("proc/kcore: optimize multiple page reads")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

Sorry, resent v2 because From didn't match sob tag

 fs/proc/kcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index ad72261ee3fe..578926032880 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -464,6 +464,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				ret = -EFAULT;
 				goto out;
 			}
+			m = NULL;
 		} else if (m->type == KCORE_VMALLOC) {
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
-- 
2.17.1

