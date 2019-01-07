Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8554C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3359206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865269;
	bh=hhmGbfSYNiEePVo+2X98BGwAa0cTj33Vu7g6KtlmUMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c0B1J0lliQwwf2jnXj+LDHMky9Uo8sL4pyz17Min0hHeGq7xI+l757VDvuDGJ3gbX
	 B18n76CjGblt1K2Ic2wucnCgcwVzzUniTVP2HGPH1idtWpthG4eCYkYZ2EMfJ3RyRB
	 69j2GmYdcOsxlh/roL8Od41D5UpYCtP7P46yDwyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfAGMrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:47:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbfAGMro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:47:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7408220651;
        Mon,  7 Jan 2019 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865264;
        bh=hhmGbfSYNiEePVo+2X98BGwAa0cTj33Vu7g6KtlmUMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WF0ahmq198r7LSOJp57dKxPIQ+38Tr4Io9dE2vbU9cjTjNoiB72LABP941XIHX4tx
         wnhrIcMhXf/BkTlQqRdcwJ7uAhw2weQY1MCbDA4bKJJEv2HCPw66mm8jd5CWAiauyT
         vKWDtRfiKAytDcXXVzXF61fSUV+lf/R6x+jjeIAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 038/170] vhost: make sure used idx is seen before log in vhost_add_used_n()
Date:   Mon,  7 Jan 2019 13:31:05 +0100
Message-Id: <20190107104457.723229098@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2233,6 +2233,8 @@ int vhost_add_used_n(struct vhost_virtqu
 		return -EFAULT;
 	}
 	if (unlikely(vq->log_used)) {
+		/* Make sure used idx is seen before log. */
+		smp_wmb();
 		/* Log used index update. */
 		log_write(vq->log_base,
 			  vq->log_addr + offsetof(struct vring_used, idx),


