Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5237C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A911E208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1hkLdye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A911E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbeKTC6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbeKTC6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D706C2086A;
        Mon, 19 Nov 2018 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645281;
        bh=WTIjHzhxqyA2sdUTX9aUTheKmSc7cYKv7A2EWkFS1rY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1hkLdyewq1jfv3VNEOjB+LzlVYRM/NnCpJP7SINInKErdsgXUsbizTxQy0dbSWJB
         +6iTkj58h4VrT2tLpBBQQ+nOmvYiy4jw60vfnvR4uaZCkxBZmYG9OCK5fHPT4Tq4/e
         t1vH5HxQ0ot0rznK9ojJqCcE/jjeKYDLchVcashg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmai
Subject: [PATCH 4.19 067/205] fuse: set FR_SENT while locked
Date:   Mon, 19 Nov 2018 17:26:14 +0100
Message-Id: <20181119162629.039148297@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 4c316f2f3ff315cb48efb7435621e5bfb81df96d upstream.

Otherwise fuse_dev_do_write() could come in and finish off the request, and
the set_bit(FR_SENT, ...) could trigger the WARN_ON(test_bit(FR_SENT, ...))
in request_end().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reported-by: syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmai
Fixes: 46c34a348b0a ("fuse: no fc->lock for pqueue parts")
Cc: <stable@vger.kernel.org> # v4.2
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1319,8 +1319,8 @@ static ssize_t fuse_dev_do_read(struct f
 	}
 	list_move_tail(&req->list, &fpq->processing);
 	__fuse_get_request(req);
-	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
+	spin_unlock(&fpq->lock);
 	/* matches barrier in request_wait_answer() */
 	smp_mb__after_atomic();
 	if (test_bit(FR_INTERRUPTED, &req->flags))


