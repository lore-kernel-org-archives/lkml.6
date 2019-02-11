Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B820C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6AD21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900477;
	bh=YmWo7/E7zEpJuMNMDx1Jb54q8BCkAR+VNCHaA/FWrXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pfHGt5pGP0o6L0tFMxjb6iSwGy8wyUsr4J6B/0a9TuLvrkdFrkbTcltothP4BudBH
	 uEm31vGyhVu7eWe5s129npd1vThzoEqtKYHIZlhfZAbg6aTZjukwAcGyj2sKPSEEgk
	 qzQ1rwRd7rXXk9kZbmMQ0EVOz4r04E9M8HoCQ0do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfBKOfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:35:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730749AbfBKOfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:35:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF07E2081B;
        Mon, 11 Feb 2019 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895732;
        bh=YmWo7/E7zEpJuMNMDx1Jb54q8BCkAR+VNCHaA/FWrXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWkWpzMA9Za8pqJ1nefLZeOIA2ltGXc0tpuQ9OdkFG5Bb3DKMZ/jQkX5XLRz62UO/
         xXYwSCaE3zOxJxYcyslDLyYAnHdKHRKwP+uXEZOR+6Mhjlce9iB54xpa+5f6W/Pwye
         sCrSQ6JJKhR87RKl5cRceOIkDNjJSs1fFuEMVzxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xu <yinxu@redhat.com>,
        syzbot+e33a3a138267ca119c7d@syzkaller.appspotmail.com,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 304/352] sctp: check and update stream->out_curr when allocating stream_out
Date:   Mon, 11 Feb 2019 15:18:51 +0100
Message-Id: <20190211141906.218437701@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit cfe4bd7a257f6d6f81d3458d8c9d9ec4957539e6 ]

Now when using stream reconfig to add out streams, stream->out
will get re-allocated, and all old streams' information will
be copied to the new ones and the old ones will be freed.

So without stream->out_curr updated, next time when trying to
send from stream->out_curr stream, a panic would be caused.

This patch is to check and update stream->out_curr when
allocating stream_out.

v1->v2:
  - define fa_index() to get elem index from stream->out_curr.
v2->v3:
  - repost with no change.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Reported-by: Ying Xu <yinxu@redhat.com>
Reported-by: syzbot+e33a3a138267ca119c7d@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/stream.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -84,6 +84,19 @@ static void fa_zero(struct flex_array *f
 	}
 }
 
+static size_t fa_index(struct flex_array *fa, void *elem, size_t count)
+{
+	size_t index = 0;
+
+	while (count--) {
+		if (elem == flex_array_get(fa, index))
+			break;
+		index++;
+	}
+
+	return index;
+}
+
 /* Migrates chunks from stream queues to new stream queues if needed,
  * but not across associations. Also, removes those chunks to streams
  * higher than the new max.
@@ -147,6 +160,13 @@ static int sctp_stream_alloc_out(struct
 
 	if (stream->out) {
 		fa_copy(out, stream->out, 0, min(outcnt, stream->outcnt));
+		if (stream->out_curr) {
+			size_t index = fa_index(stream->out, stream->out_curr,
+						stream->outcnt);
+
+			BUG_ON(index == stream->outcnt);
+			stream->out_curr = flex_array_get(out, index);
+		}
 		fa_free(stream->out);
 	}
 


