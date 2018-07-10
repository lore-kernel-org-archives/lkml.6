Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D9C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE38208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kArPiVey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE38208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933600AbeGJOBf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933248AbeGJOBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:01:32 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA8D208E5;
        Tue, 10 Jul 2018 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531231292;
        bh=rTBPS2lTBV4tvGy1bAXhJwa9kjE2MD8nXDGQjALKBFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kArPiVeyLFR9Ai1JHx8cjeNeFfo+Lc0B5XJBttsPV2D37k3niaPTFCnz/IRUGouhj
         OVvKZ3GNwCOL1Y2AchFNMniIk5RGGd/MvpKyTi5F3APjPC672fasneo4dOappGyvg6
         ENIhWxZepsNHe33aaqtZHDoAhEEe3ONMpZvcs9FE=
From:   Jeff Layton <jlayton@kernel.org>
To:     viro@ZenIV.linux.org.uk, dhowells@redhat.com
Cc:     willy@infradead.org, andres@anarazel.de, cmaiolino@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/4] errseq: add a new errseq_scrape function
Date:   Tue, 10 Jul 2018 10:01:25 -0400
Message-Id: <20180710140127.20739-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710140127.20739-1-jlayton@kernel.org>
References: <20180710140127.20739-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

To grab the current value of an errseq_t, mark it as seen and then
return the value with the seen bit masked off.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 include/linux/errseq.h |  1 +
 lib/errseq.c           | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index fc2777770768..de165623fa86 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -9,6 +9,7 @@ typedef u32	errseq_t;
 
 errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
+errseq_t errseq_scrape(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
 int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
 #endif
diff --git a/lib/errseq.c b/lib/errseq.c
index 81f9e33aa7e7..8ded0920eed3 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -108,7 +108,7 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 EXPORT_SYMBOL(errseq_set);
 
 /**
- * errseq_sample() - Grab current errseq_t value.
+ * errseq_sample() - Grab current errseq_t value (or 0 if it hasn't been seen)
  * @eseq: Pointer to errseq_t to be sampled.
  *
  * This function allows callers to initialise their errseq_t variable.
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(errseq_set);
  * see it the next time it checks for an error.
  *
  * Context: Any context.
- * Return: The current errseq value.
+ * Return: The current errseq value or 0 if it wasn't previously seen
  */
 errseq_t errseq_sample(errseq_t *eseq)
 {
@@ -130,6 +130,35 @@ errseq_t errseq_sample(errseq_t *eseq)
 }
 EXPORT_SYMBOL(errseq_sample);
 
+/**
+ * errseq_scrape() - Grab current errseq_t value
+ * @eseq: Pointer to errseq_t to be sampled.
+ *
+ * This function allows callers to scrape the current value of an errseq_t.
+ * Unlike errseq_sample, this will always return the current value with
+ * the SEEN flag unset, even when the value has not yet been seen.
+ *
+ * Context: Any context.
+ * Return: The current errseq value with ERRSEQ_SEEN masked off
+ */
+errseq_t errseq_scrape(errseq_t *eseq)
+{
+	errseq_t old = READ_ONCE(*eseq);
+
+	/*
+	 * For the common case of no errors ever having been set, we can skip
+	 * marking the SEEN bit. Once an error has been set, the value will
+	 * never go back to zero.
+	 */
+	if (old != 0) {
+		errseq_t new = old | ERRSEQ_SEEN;
+		if (old != new)
+			cmpxchg(eseq, old, new);
+	}
+	return old & ~ERRSEQ_SEEN;
+}
+EXPORT_SYMBOL(errseq_scrape);
+
 /**
  * errseq_check() - Has an error occurred since a particular sample point?
  * @eseq: Pointer to errseq_t value to be checked.
-- 
2.17.1

