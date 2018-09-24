Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C80C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5EF208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5EF208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeIXRiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:38:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbeIXRiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:08 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C2AD51065;
        Mon, 24 Sep 2018 11:36:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Greg Kurz <groug@kaod.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 012/105] net/9p: fix error path of p9_virtio_probe
Date:   Mon, 24 Sep 2018 13:32:58 +0200
Message-Id: <20180924113114.656754144@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
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

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

[ Upstream commit 92aef4675d5b1b55404e1532379e343bed0e5cf2 ]

Currently when virtio_find_single_vq fails, we go through del_vqs which
throws a warning (Trying to free already-free IRQ).  Skip del_vqs if vq
allocation failed.

Link: http://lkml.kernel.org/r/20180524101021.49880-1-jean-philippe.brucker@arm.com
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Ron Minnich <rminnich@sandia.gov>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/9p/trans_virtio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -537,7 +537,7 @@ static int p9_virtio_probe(struct virtio
 	chan->vq = virtio_find_single_vq(vdev, req_done, "requests");
 	if (IS_ERR(chan->vq)) {
 		err = PTR_ERR(chan->vq);
-		goto out_free_vq;
+		goto out_free_chan;
 	}
 	chan->vq->vdev->priv = chan;
 	spin_lock_init(&chan->lock);
@@ -590,6 +590,7 @@ out_free_tag:
 	kfree(tag);
 out_free_vq:
 	vdev->config->del_vqs(vdev);
+out_free_chan:
 	kfree(chan);
 fail:
 	return err;


