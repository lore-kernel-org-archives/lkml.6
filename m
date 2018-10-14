Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654D0C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F4C20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F4C20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeJNXdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:33:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36121 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727877AbeJNXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLl-0004cg-4y; Sun, 14 Oct 2018 16:30:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000hC-F7; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Julian Wiedmann" <jwi@linux.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.151144951@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 316/366] s390/qdio: fix access to uninitialized
 qdio_q fields
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Wiedmann <jwi@linux.ibm.com>

commit e521813468f786271a87e78e8644243bead48fad upstream.

Ever since CQ/QAOB support was added, calling qdio_free() straight after
qdio_alloc() results in qdio_release_memory() accessing uninitialized
memory (ie. q->u.out.use_cq and q->u.out.aobs). Followed by a
kmem_cache_free() on the random AOB addresses.

For older kernels that don't have 6e30c549f6ca, the same applies if
qdio_establish() fails in the DEV_STATE_ONLINE check.

While initializing q->u.out.use_cq would be enough to fix this
particular bug, the more future-proof change is to just zero-alloc the
whole struct.

Fixes: 104ea556ee7f ("qdio: support asynchronous delivery of storage blocks")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/cio/qdio_setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -90,7 +90,7 @@ static int __qdio_allocate_qs(struct qdi
 	int i;
 
 	for (i = 0; i < nr_queues; i++) {
-		q = kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
+		q = kmem_cache_zalloc(qdio_q_cache, GFP_KERNEL);
 		if (!q)
 			return -ENOMEM;
 

