Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B40ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27C7216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 20:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IdFmqOaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27C7216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeJUE1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 00:27:43 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60496 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJUE1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 00:27:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id CB7B09D4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 20:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Yns40YGkQ4DE for <linux-kernel@vger.kernel.org>;
        Sat, 20 Oct 2018 15:16:05 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 95A55A32
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 15:16:05 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id e197-v6so7430486ita.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 13:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AoEN0wakW3qdWmyZIEle8huh1zI8eS+bLgZW4WFQzEw=;
        b=IdFmqOaK2UI29izlSRLG2YBjJIHkz0DnSH3APK4XPzTPDD9F7rSM9swwGTzQ5Mp5X9
         g08GoeRcfmnC5XNyiVSGCjz230ol15xLVCRVXED3gnTG85mpM5plB8csv973UwdWC9Rk
         ZdfAixuAP8rc4IrvvdLzlTUKLBNxG/EzF9RrNUclllUj7GMzluutyKFxXko1hQBAPGZX
         v1gDdJbCuOTqNmJaDKw23PrnZ26xCBKa2ztXPw3UfCHIPIgInlIj/71jhSNRRF/Xuuyf
         h3xSBvSt/mT/DZZagz6A/58RVjN80TidHTad4zddKxxxjcZlgjE4djcfHO36RbYgIUD2
         qqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AoEN0wakW3qdWmyZIEle8huh1zI8eS+bLgZW4WFQzEw=;
        b=nWrnHbxdKxzgs22ZdkVoRAztEilQdqb8TJbwAsX5tajTOEWS3lg0JXKoaw6M2tmlz/
         fNHsr4Eu9eccN2n5LeFdiklJkbF3HY5D/N4i7cjaULvmv32Nw/1/yfLrX02l6NMaxXnL
         B5T1j9LgceXqcL//G709OEhSEU4c6leNL32jbMASSzquECyiwSWsRf7D+nKYB0P014r6
         Xe1oFWj83a6mJ8DjjkRQN1KcwoczeVJSoAnN5eVf9Xi7sQkWYiFquj79Hm5UAHw12YtE
         jmj1IWOuYMW/4hiIkjrOZ+h2Rl5C3kiK2+mBOm9Z7JRk0e8ZJHTyYb+trsxYDQaX/+Qr
         /zxA==
X-Gm-Message-State: ABuFfogQvj8P8yWE+tFRAmrGdI1ie8I/3KRQQ2j0jeOviptX60lISaHE
        oHFYQFwXJ7pho2pfHy6fl6NIyEQQBBXemOn1TgPez7Nck+tjoS3ZaFAAXrNCpZpdhErGKzkXcTl
        RJlyNIBiS+4zZPOAteWc1OuB4pv5F
X-Received: by 2002:a02:38c:: with SMTP id e12-v6mr29278305jae.71.1540066565263;
        Sat, 20 Oct 2018 13:16:05 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62IIK1yq7hhGAerZpuHJVLJLD7VXtnb5H7aYV9qC3XhQT8cLKrPLkhy/rOsFTSv5v03wLW9ZA==
X-Received: by 2002:a02:38c:: with SMTP id e12-v6mr29278299jae.71.1540066565054;
        Sat, 20 Oct 2018 13:16:05 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id z186-v6sm2604188itd.43.2018.10.20.13.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 13:16:04 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thunderbolt: fix a missing-check bug
Date:   Sat, 20 Oct 2018 15:15:56 -0500
Message-Id: <1540066556-18088-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tb_ring_poll(), the flag of the frame, i.e.,
'ring->descriptors[ring->tail].flags', is checked to see whether the frame
is completed. If yes, the frame including the flag will be read from the
ring and returned to the caller. The problem here is that the flag is
actually in a DMA region, which is allocated through dma_alloc_coherent()
in tb_ring_alloc(). Given that the device can also access this DMA region,
it is possible that a malicious device controlled by an attacker can modify
the flag between the check and the copy. By doing so, the attacker can
bypass the check and supply uncompleted frame, which can cause undefined
behavior of the kernel and introduce potential security risk.

This patch firstly copies the flag into a local variable 'desc_flags' and
then performs the check and copy using 'desc_flags'. Through this way, the
above issue can be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/thunderbolt/nhi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 5cd6bdf..481b1f2 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -289,6 +289,7 @@ struct ring_frame *tb_ring_poll(struct tb_ring *ring)
 {
 	struct ring_frame *frame = NULL;
 	unsigned long flags;
+	enum ring_desc_flags desc_flags;
 
 	spin_lock_irqsave(&ring->lock, flags);
 	if (!ring->running)
@@ -296,7 +297,8 @@ struct ring_frame *tb_ring_poll(struct tb_ring *ring)
 	if (ring_empty(ring))
 		goto unlock;
 
-	if (ring->descriptors[ring->tail].flags & RING_DESC_COMPLETED) {
+	desc_flags = ring->descriptors[ring->tail].flags;
+	if (desc_flags & RING_DESC_COMPLETED) {
 		frame = list_first_entry(&ring->in_flight, typeof(*frame),
 					 list);
 		list_del_init(&frame->list);
@@ -305,7 +307,7 @@ struct ring_frame *tb_ring_poll(struct tb_ring *ring)
 			frame->size = ring->descriptors[ring->tail].length;
 			frame->eof = ring->descriptors[ring->tail].eof;
 			frame->sof = ring->descriptors[ring->tail].sof;
-			frame->flags = ring->descriptors[ring->tail].flags;
+			frame->flags = desc_flags;
 		}
 
 		ring->tail = (ring->tail + 1) % ring->size;
-- 
2.7.4

