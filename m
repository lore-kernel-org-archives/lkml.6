Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D6C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA09320844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA09320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbeIHCYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:24:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbeIHCYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:24:04 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DCFA61010;
        Fri,  7 Sep 2018 21:41:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Serge Hallyn <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.4 34/47] userns: move user access out of the mutex
Date:   Fri,  7 Sep 2018 23:10:30 +0200
Message-Id: <20180907210908.241189276@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210904.607934824@linuxfoundation.org>
References: <20180907210904.607934824@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 5820f140edef111a9ea2ef414ab2428b8cb805b1 upstream.

The old code would hold the userns_state_mutex indefinitely if
memdup_user_nul stalled due to e.g. a userfault region. Prevent that by
moving the memdup_user_nul in front of the mutex_lock().

Note: This changes the error precedence of invalid buf/count/*ppos vs
map already written / capabilities missing.

Fixes: 22d917d80e84 ("userns: Rework the user_namespace adding uid/gid...")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Christian Brauner <christian@brauner.io>
Acked-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/user_namespace.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -604,7 +604,16 @@ static ssize_t map_write(struct file *fi
 	struct uid_gid_extent *extent = NULL;
 	unsigned long page = 0;
 	char *kbuf, *pos, *next_line;
-	ssize_t ret = -EINVAL;
+	ssize_t ret;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	/* Slurp in the user data */
+	if (copy_from_user(kbuf, buf, count))
+		return -EFAULT;
+	kbuf[count] = '\0';
 
 	/*
 	 * The userns_state_mutex serializes all writes to any given map.
@@ -645,17 +654,6 @@ static ssize_t map_write(struct file *fi
 	if (!page)
 		goto out;
 
-	/* Only allow < page size writes at the beginning of the file */
-	ret = -EINVAL;
-	if ((*ppos != 0) || (count >= PAGE_SIZE))
-		goto out;
-
-	/* Slurp in the user data */
-	ret = -EFAULT;
-	if (copy_from_user(kbuf, buf, count))
-		goto out;
-	kbuf[count] = '\0';
-
 	/* Parse the user data */
 	ret = -EINVAL;
 	pos = kbuf;


