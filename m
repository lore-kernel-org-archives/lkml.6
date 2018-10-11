Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E72C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C56B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGOub/YO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C56B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbeJKXHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC798213A2;
        Thu, 11 Oct 2018 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272367;
        bh=+KULaYzZjhEvU+XJKMcdOdPS7xvdryWMpD3jZZiy45k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JGOub/YOVuCxHigrhPvTsnrVWzzjDbOp9MSbTZZ50RDDFJnMOs42JxEvkkGdLTiEj
         w0dzPgoe9wqhczZj4tgJZLgvnNhzBMqljH5MvTjBsbjUx1tPUTM1TAmSOiWtPYwp8V
         rJsA+9gmoUrs57nQ5eupgwHcgY+/l+vUR3BT4gkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 084/120] RDMA/ucma: check fd type in ucma_migrate_id()
Date:   Thu, 11 Oct 2018 17:34:25 +0200
Message-Id: <20181011152553.275269216@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

[ Upstream commit 0d23ba6034b9cf48b8918404367506da3e4b3ee5 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/ucma.c |    6 ++++++
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
@@ -1416,6 +1418,10 @@ static ssize_t ucma_migrate_id(struct uc
 	f = fdget(cmd.fd);
 	if (!f.file)
 		return -ENOENT;
+	if (f.file->f_op != &ucma_fops) {
+		ret = -EINVAL;
+		goto file_put;
+	}
 
 	/* Validate current fd and prevent destruction of id. */
 	ctx = ucma_get_ctx(f.file->private_data, cmd.id);


