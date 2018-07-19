Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7742DC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25189206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25189206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbeGSJBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:01:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:58621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbeGSJBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:01:06 -0400
Received: from x201.localdomain ([220.112.58.66]) by mail.gmx.com (mrgmx103
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M5MIN-1fxTNL40rf-00zTUC; Thu, 19
 Jul 2018 10:18:53 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     akpm@linux-foundation.org, jack@suse.cz,
        mgorman@techsingularity.net, jlayton@redhat.com,
        ak@linux.intel.com, mawilcox@microsoft.com,
        tim.c.chen@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] mm: adjust max read count in generic_file_buffered_read()
Date:   Thu, 19 Jul 2018 16:17:26 +0800
Message-Id: <20180719081726.3341-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:vUaRjAszsrA+f+IbVOq7BtUA8fsuvc0whhVq6Z7wC0bFJSU7adj
 bxiJ5WLma2wtUUBfMs2uVHsDFZwVSnT0jhTcTxw1XFgnFtnwvTR10B6dl5mVpPhhhAc3wsy
 2Z8WDtWWUrUS4g1X2y0/nrFM5bKRx/Wf+zwZxTFb/04sip2FiPH3sFQprVaWExjBkoXepdf
 NnnN9m1BSMwF7ddUJFZbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:73aCmyVpLvs=:HOIJUJfRfNIaXrpQKITfxR
 Cyg84OXU3GnvOuqzyl48vXPal34FgU4+9Uh8BBKy6sSzb8p5QlYiKmj2FWl/A4TFeuAv8/Ild
 2xZhlSYJmOpl4CxfnFdrREZ89LbSMTCMTwZdCNrHKbEhJjRXaM9Y2JfvTNPX39P4rZALxCdJr
 pa+mmuvPUXy3M9fPeS5cHlG6jyYBf54dDAYhqAaPMqVa4cRbIOcWn3jxj9g4/Wt75F6QdEbO0
 Q+tnmUKvRkVkO918ia8hsynHYzdC2wnCnslco6gqFqOH2+DjGVazu0VPNlXrKcDIAmWdWAXt1
 fr+SwWwGxP5dtSE+k5QPD4wDRuc3BmT59IKK3pYU2QH6Igon/Xil8sicb8QGLFxhDLJhUvn8M
 rkKm+AWg3SI2xBXtBX33xw6829EWlDz9x+Emh82e8pAfNkkQ0A/aPbJaaJd4IFEy27lNlAFN7
 TwMEjjgPvpw+K9BkzWVPJL+nb6UTIM8MvSNkXiEDgXvo5a7+HgpQipPwP8+DgkUq2v+//niOP
 jeTog0EJLIPlxjB6/Uu0jJqrzFekGwCKkdBTUHb0IBE7+Wm7xZ48BVmX25i+MDMDvmqECTonH
 lNde/+223l6/2Qv8wIXpdsNXyUyPnfZ0pJC4ZzH6RjvRgkws1/rYgmxak1jTABdmieSDqrQXC
 3V8q1xrX4defV1Eq3Q8qRYK8MRNOrWni0YTB5ihaUbBHfWLhlFrYN8yE3WwJoR7kpXpfWE+s6
 FkUJ5kbXpanADyRBTdLZ+bfblUpB3jqIX9lHsVJkBtaJrUSNgGvEg8ObA/k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we try to truncate read count in generic_file_buffered_read(),
should deliver (sb->s_maxbytes - offset) as maximum count not
sb->s_maxbytes itself.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 52517f28e6f4..5c2d481d21cf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2064,7 +2064,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
 		return 0;
-	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
+	iov_iter_truncate(iter, inode->i_sb->s_maxbytes - *ppos);
 
 	index = *ppos >> PAGE_SHIFT;
 	prev_index = ra->prev_pos >> PAGE_SHIFT;
-- 
2.17.1

