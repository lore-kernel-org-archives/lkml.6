Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F43C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10B121655
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 19:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DTuoUL2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10B121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbeJUD7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 23:59:30 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:54338 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJUD73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 23:59:29 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id A8C38B74
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 19:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wU3ShUuVsI_j for <linux-kernel@vger.kernel.org>;
        Sat, 20 Oct 2018 14:47:57 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 73B6DB73
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 14:47:57 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id n10-v6so23006136iog.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4OD00mFOgXS33l3L33RU+jk5Bk+72Krd0v5DrofElt0=;
        b=DTuoUL2JMX3BFVigadGPw+ukEcJ0rSYDuOOqIfA4JjEwTUDS4+kS4RYUeUfoEzXssN
         Zy3E/ZMPpRK79Cqzi+W8+IqndwFF9MkpmKivhgEqBWt6MG2FgcEXB9++hdLO/Bxlw6u6
         mj+0SofxAbPtb+WAAQXWrN/URyY7yqZyiVum2HG20gHUW6HupMFsO2TMWfwp7bnblnqv
         9lMsphfu/9UGOHM3Y8Tk+aOkhYtu+BatjVvcxDoaSbDUk9fECdefE2ysk5ZcZ4xAL91y
         h68M8LIDBuFEI3FPp2k/Zv52Az5tInACRnCGpDheMuuPFXk+YROeuE+fKCQGVFUtySaC
         823w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4OD00mFOgXS33l3L33RU+jk5Bk+72Krd0v5DrofElt0=;
        b=DRPFeRMCbBM2t1Nv7BbyygeztMQr/RBsBA14aS8SETHBeekFOwtlCKsRFUEdUopPZo
         LFoldNISvHrzC7/3OmfnfIfJ0XYYk2BYWQX4dqXX6sCp6pg1mf46VQjwGjK9wMwKvBDS
         naCVjEtsPrfjHrRMgNi+uB+/8vEiPtm8iSH5OqTBHHlDpDiyBLE4YLu/vcO5RHmZ3ODD
         9C7227ic/GdvwkqNqeJH0Qz9EarytuTZ5YWCMuU9PTXNZXpUUExQZHA1LH+C5bB8aG+6
         A+VbELFgckEH0pWdQxKJMu6eGZ4nZsNDoqRMcbFdgrX46a/yizTAPEnpl7J4d9Rn0/7d
         5dkg==
X-Gm-Message-State: AGRZ1gJNIdIrwlhf/TsYiDbkD9HNuWVQm82At3Z3iApFVPhgs4jx39kj
        47TkXE3SQ49rMpjH5KBXJHyZDy7/eeHl+AoeoQ5D/IM75PkO/5YzszJ2LU4/Ts9sNog+QWRceRS
        J3jIKLoiqqRFycOSSRnYrzchsrRpm
X-Received: by 2002:a6b:8f49:: with SMTP id r70-v6mr3081341iod.212.1540064877121;
        Sat, 20 Oct 2018 12:47:57 -0700 (PDT)
X-Google-Smtp-Source: AJdET5dUVXzN5pOTWuMKpb9P4ESPnFWjYKQ25ReaY2YkeZk24G/ps5ZTAvL7PPj0GtqoenXKnOFH2Q==
X-Received: by 2002:a6b:8f49:: with SMTP id r70-v6mr3081332iod.212.1540064876905;
        Sat, 20 Oct 2018 12:47:56 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id r20-v6sm9271841ioj.17.2018.10.20.12.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 12:47:55 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thunderbolt: fix a missing-check bug
Date:   Sat, 20 Oct 2018 14:47:49 -0500
Message-Id: <1540064869-17849-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ring_work(), the first while loop is used to collect all completed
frames from the ring buffer. In each iteration of this loop, the flag of
the frame, i.e., 'ring->descriptors[ring->tail].flags' is firstly check to
see whether the frame is completed. If yes, the descriptor of the frame,
including the flag, is then copied. It is worth noting that the descriptor
is actually in a DMA region, which is allocated through
dma_alloc_coherent() in tb_ring_alloc(). Given that the device can also
access the DMA region, a malicious device controlled by an attacker can
race to modify the flag of the frame after the check but before the copy.
By doing so, the attacker can bypass the check and supply uncompleted
frame, which can cause undefined behavior of the kernel and introduce
potential security risk.

This patch firstly copies the flag into a local variable 'desc_flags' and
then performs the check and copy using 'desc_flags'. Through this way, the
above issue can be avoided.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/thunderbolt/nhi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 5cd6bdf..22bd6cf 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -215,6 +215,7 @@ static void ring_work(struct work_struct *work)
 	struct ring_frame *frame;
 	bool canceled = false;
 	unsigned long flags;
+	enum ring_desc_flags desc_flags;
 	LIST_HEAD(done);
 
 	spin_lock_irqsave(&ring->lock, flags);
@@ -228,8 +229,8 @@ static void ring_work(struct work_struct *work)
 	}
 
 	while (!ring_empty(ring)) {
-		if (!(ring->descriptors[ring->tail].flags
-				& RING_DESC_COMPLETED))
+		desc_flags = ring->descriptors[ring->tail].flags;
+		if (!(desc_flags & RING_DESC_COMPLETED))
 			break;
 		frame = list_first_entry(&ring->in_flight, typeof(*frame),
 					 list);
@@ -238,7 +239,7 @@ static void ring_work(struct work_struct *work)
 			frame->size = ring->descriptors[ring->tail].length;
 			frame->eof = ring->descriptors[ring->tail].eof;
 			frame->sof = ring->descriptors[ring->tail].sof;
-			frame->flags = ring->descriptors[ring->tail].flags;
+			frame->flags = desc_flags;
 		}
 		ring->tail = (ring->tail + 1) % ring->size;
 	}
-- 
2.7.4

