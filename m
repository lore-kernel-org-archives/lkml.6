Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED031C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1DA52241B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLUrAhoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DA52241B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405871AbeKTD01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:26:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405332AbeKTD00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:26:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BC422241B;
        Mon, 19 Nov 2018 17:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646929;
        bh=Lx7aTaC2BH4u5Qv95aZq0E8RfWnwbfXaZAqE7ljSI/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLUrAhoDr5l2ESVPkiJuZ2m2+4wVDP7I0e1VtLq2l99lNgeDLJNcRilhwoFBR8K63
         2eBztx3j861MN0CbG9FoQ7nHJdJTB3m7eI+75z88JQQewu1hed4qV8x6mvmFxAyC6W
         /SsCB2XSSiDdLvhT7gA0jr0V/pYZDpDwolX4FOiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.4 108/160] fuse: Fix use-after-free in fuse_dev_do_read()
Date:   Mon, 19 Nov 2018 17:29:07 +0100
Message-Id: <20181119162641.315405113@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Tkhai <ktkhai@virtuozzo.com>

commit bc78abbd55dd28e2287ec6d6502b842321a17c87 upstream.

We may pick freed req in this way:

[cpu0]                                  [cpu1]
fuse_dev_do_read()                      fuse_dev_do_write()
   list_move_tail(&req->list, ...);     ...
   spin_unlock(&fpq->lock);             ...
   ...                                  request_end(fc, req);
   ...                                    fuse_put_request(fc, req);
   if (test_bit(FR_INTERRUPTED, ...))
         queue_interrupt(fiq, req);

Fix that by keeping req alive until we finish all manipulations.

Reported-by: syzbot+4e975615ca01f2277bdd@syzkaller.appspotmail.com
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 46c34a348b0a ("fuse: no fc->lock for pqueue parts")
Cc: <stable@vger.kernel.org> # v4.2
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1328,12 +1328,14 @@ static ssize_t fuse_dev_do_read(struct f
 		goto out_end;
 	}
 	list_move_tail(&req->list, &fpq->processing);
+	__fuse_get_request(req);
 	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
 	if (test_bit(FR_INTERRUPTED, &req->flags))
 		queue_interrupt(fiq, req);
+	fuse_put_request(fc, req);
 
 	return reqsize;
 


