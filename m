Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57E5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB562147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866641;
	bh=qp/jlSUKY+kembumNDz8a/yENm8nZuTUjLFNzD48Mhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o41Fp4o7jTS8e9jFu97n4C+f6Yk04OY5YOmtujGCCa+UldgYt+4fIciZMv97O5d7u
	 UG06Gi/7zHqZYczNOd3WosQ7FZ9pdNoXXIztA2tCo0lXAHFxcwy7nvlhQ+UlfsfBGS
	 sONfnPI0bWivzqaznHu0CqwK1fHTg3FWr5G8BQCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfAGNJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:09:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:56208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731801AbfAGNJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:09:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 181B82089F;
        Mon,  7 Jan 2019 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866549;
        bh=qp/jlSUKY+kembumNDz8a/yENm8nZuTUjLFNzD48Mhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXypJ0+npXWc072Qs1XkwaSsUXLtV5j9SkjMA973+fB4onrv+zXPc9A3Ft9pETIxA
         blRghbh+JN8MhGBMFeb61JBc7PDJmLVbII+lxWdX4FdFwE19jk1NWHN3leVoiaRoy8
         OfQKzsg1RL2eFRblpU4jAGoF57tZYfbHtlyorMHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 20/71] vhost: make sure used idx is seen before log in vhost_add_used_n()
Date:   Mon,  7 Jan 2019 13:32:49 +0100
Message-Id: <20190107105333.956136898@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 841df922417eb82c835e93d4b93eb6a68c99d599 ]

We miss a write barrier that guarantees used idx is updated and seen
before log. This will let userspace sync and copy used ring before
used idx is update. Fix this by adding a barrier before log_write().

Fixes: 8dd014adfea6f ("vhost-net: mergeable buffers support")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2145,6 +2145,8 @@ int vhost_add_used_n(struct vhost_virtqu
 		return -EFAULT;
 	}
 	if (unlikely(vq->log_used)) {
+		/* Make sure used idx is seen before log. */
+		smp_wmb();
 		/* Log used index update. */
 		log_write(vq->log_base,
 			  vq->log_addr + offsetof(struct vring_used, idx),


