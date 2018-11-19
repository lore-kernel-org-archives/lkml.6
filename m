Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E523DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE318208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuCC8Bkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE318208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbeKTDFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:05:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732842AbeKTDFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:05:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38746214ED;
        Mon, 19 Nov 2018 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645671;
        bh=ap6nQ4RPxSkgz/ZpczyMjV0AU+holga1OP7vQ3NMbaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuCC8Bkdy2uWd0yFau/pdGq6MTxvIrsyi11pT8pFse8SgPOWpyPjFXEVrDQSHFl0j
         NxDHh/ozdzMVDYdqj1qZnGVUkk938z+D1zVbZEKRB4H6IJHNeEvANt6rMyGK3uZ4f9
         WheslcX82kmjzthBQJzUTNyyxQ6GmuzjiI2TkktA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.18 046/171] fuse: Fix use-after-free in fuse_dev_do_write()
Date:   Mon, 19 Nov 2018 17:27:22 +0100
Message-Id: <20181119162627.254324580@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Tkhai <ktkhai@virtuozzo.com>

commit d2d2d4fb1f54eff0f3faa9762d84f6446a4bc5d0 upstream.

After we found req in request_find() and released the lock,
everything may happen with the req in parallel:

cpu0                              cpu1
fuse_dev_do_write()               fuse_dev_do_write()
  req = request_find(fpq, ...)    ...
  spin_unlock(&fpq->lock)         ...
  ...                             req = request_find(fpq, oh.unique)
  ...                             spin_unlock(&fpq->lock)
  queue_interrupt(&fc->iq, req);   ...
  ...                              ...
  ...                              ...
  request_end(fc, req);
    fuse_put_request(fc, req);
  ...                              queue_interrupt(&fc->iq, req);


Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 46c34a348b0a ("fuse: no fc->lock for pqueue parts")
Cc: <stable@vger.kernel.org> # v4.2
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1877,16 +1877,20 @@ static ssize_t fuse_dev_do_write(struct
 
 	/* Is it an interrupt reply? */
 	if (req->intr_unique == oh.unique) {
+		__fuse_get_request(req);
 		spin_unlock(&fpq->lock);
 
 		err = -EINVAL;
-		if (nbytes != sizeof(struct fuse_out_header))
+		if (nbytes != sizeof(struct fuse_out_header)) {
+			fuse_put_request(fc, req);
 			goto err_finish;
+		}
 
 		if (oh.error == -ENOSYS)
 			fc->no_interrupt = 1;
 		else if (oh.error == -EAGAIN)
 			queue_interrupt(&fc->iq, req);
+		fuse_put_request(fc, req);
 
 		fuse_copy_finish(cs);
 		return nbytes;


