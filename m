Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E49C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0022420661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0022420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeLIV5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:57:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36462 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726823AbeLIVzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:44 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW738-0002po-6G; Sun, 09 Dec 2018 21:55:42 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72f-0003Te-Mf; Sun, 09 Dec 2018 21:55:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jason Gunthorpe" <jgg@mellanox.com>,
        "Jann Horn" <jannh@google.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.983655782@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 191/328] RDMA/ucma: check fd type in ucma_migrate_id()
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 0d23ba6034b9cf48b8918404367506da3e4b3ee5 upstream.

The current code grabs the private_data of whatever file descriptor
userspace has supplied and implicitly casts it to a `struct ucma_file *`,
potentially causing a type confusion.

This is probably fine in practice because the pointer is only used for
comparisons, it is never actually dereferenced; and even in the
comparisons, it is unlikely that a file from another filesystem would have
a ->private_data pointer that happens to also be valid in this context.
But ->private_data is not always guaranteed to be a valid pointer to an
object owned by the file's filesystem; for example, some filesystems just
cram numbers in there.

Check the type of the supplied file descriptor to be safe, analogous to how
other places in the kernel do it.

Fixes: 88314e4dda1e ("RDMA/cma: add support for rdma_migrate_id()")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/ucma.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -113,6 +113,8 @@ static DEFINE_MUTEX(mut);
 static DEFINE_IDR(ctx_idr);
 static DEFINE_IDR(multicast_idr);
 
+static const struct file_operations ucma_fops;
+
 static inline struct ucma_context *_ucma_find_context(int id,
 						      struct ucma_file *file)
 {
@@ -1448,6 +1450,10 @@ static ssize_t ucma_migrate_id(struct uc
 	f = fdget(cmd.fd);
 	if (!f.file)
 		return -ENOENT;
+	if (f.file->f_op != &ucma_fops) {
+		ret = -EINVAL;
+		goto file_put;
+	}
 
 	/* Validate current fd and prevent destruction of id. */
 	ctx = ucma_get_ctx(f.file->private_data, cmd.id);

