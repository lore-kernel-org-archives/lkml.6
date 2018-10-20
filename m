Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18892C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B572421530
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 18:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WU7TtOeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B572421530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJUCtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 22:49:46 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:45718 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeJUCtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 22:49:45 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id EF511C0F
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 18:38:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KvMngmCBytLv for <linux-kernel@vger.kernel.org>;
        Sat, 20 Oct 2018 13:38:25 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id C37F0C03
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 13:38:25 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id z15-v6so34498286iob.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K/HRzL0TWJHlMEnLub2V2LNhxxuQcqc+oSoqXqDFA3U=;
        b=WU7TtOeB5sHMa+L4VlW6wZP3WOf/XOIeWd8+8UpMOHEX+OEH7DXv1Wy9Z4WWqqwlLU
         /9OoBK8YaltwDyNTFf3wKn4u07fke6zbFkYKrmzE8LfosxsCIB+sNh446bPXlk5r2tJf
         ZByrWekZ8uuAVNQb4c3oAIuAG0HOD5jot0Yc30gNDquaqezdhRCCCZ1eeSEaycRwRT4n
         8iI+R3aZw1elTcrc8jFOVtLKVT2//otE9dhC6v4R48fwmY+EKmzYklAXpn7rnuLHlv/p
         XHSUsQ/TW31yeVLE6qNLk+dO7+Pesa7BQB9EZ3qTQtUdehfDR0y+CwAjw990McEjDnvG
         cfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K/HRzL0TWJHlMEnLub2V2LNhxxuQcqc+oSoqXqDFA3U=;
        b=I4BvMWpVAqjQdgr0yPlm4qLegfDeBip8RwQr+ZD99H9/R47TQpz4DvrF0FRhA8GsR6
         hQ1aCZWcCK2/zTch/3UdlPhop275BiUst/KcXcnoyY14nzKIazzHP/efK7wDLC77m7jT
         F3k81qDKJDKTgD9BFYByninL2MzN8zQrWiiwsejYt4aJ/nlIU4mH7FW4I5XFfhFQPHac
         xWSpvzvLB+s2zR/++F+taNejP25D5CM5q3SMieGVUqezTKyagGEzqRXockqYSKda1E41
         BifDA63byUQKyrfZGUnbOPWbKpLZtkz/T0/GNnD4o0F6KFhnFncAoa7UoqlzfTTNMCYO
         3SNg==
X-Gm-Message-State: AGRZ1gJYy75Mou7FYI1tVFSyeHvXrHed8MpNluqY3g5Qc8pNdxWLE4Cy
        GcdmwCluaYHUbNVdp5zaqwJJ7/iG8EhEWtAhX6fT91lkBZ1Y2JjxGy8r+kMSjLpk2s/WfBWQ+Y7
        hg3ua6xpjCGwbzt2zWi4KUIJbdNoA
X-Received: by 2002:a6b:8fc5:: with SMTP id r188-v6mr3123806iod.128.1540060705432;
        Sat, 20 Oct 2018 11:38:25 -0700 (PDT)
X-Google-Smtp-Source: AJdET5cCNVTjus3AL7I6zTWud8UGAqWfjxA+CzxaQhOdULkZvozFL25fTOOsNcGwd+De1Ax4JCTOlA==
X-Received: by 2002:a6b:8fc5:: with SMTP id r188-v6mr3123799iod.128.1540060705200;
        Sat, 20 Oct 2018 11:38:25 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id g19-v6sm8523374ioh.30.2018.10.20.11.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 11:38:24 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thunderbolt: fix a missing-check bug
Date:   Sat, 20 Oct 2018 13:38:18 -0500
Message-Id: <1540060698-17331-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In icm_copy(), the packet id 'hdr->packet_id' is firstly compared against
'req->npackets'. If it is less than 'req->npackets', the received packet.
i.e., 'pkg->buffer', is then copied to 'req->response + offset' through
memcpy(). It is worth noting that 'offset' is also calculated based on
'hdr->packet_id'. The problem here is that both the check and the
calculation are conducted directly on 'pkg->buffer', which is actually a
DMA memory region. Given that a device can also access the DMA region at
any time, it is possible that a malicious device controlled by an attacker
can modify the packet id after the check. By doing so, the attacker can
supply comprised value into 'offset' and thus cause unexpected errors.

This patch firstly copies the header of the packet and performs the check
and the calculation on the copied version to fix the above issue. This
patch also rewrites the header in 'req->response + offset' using the
copied header to avoid a potential inconsistency issue.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/thunderbolt/icm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 28fc4ce..3beec4b 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -186,15 +186,18 @@ static bool icm_match(const struct tb_cfg_request *req,
 
 static bool icm_copy(struct tb_cfg_request *req, const struct ctl_pkg *pkg)
 {
-	const struct icm_pkg_header *hdr = pkg->buffer;
+	struct icm_pkg_header hdr;
 
-	if (hdr->packet_id < req->npackets) {
-		size_t offset = hdr->packet_id * req->response_size;
+	memcpy(&hdr, pkg->buffer, sizeof(hdr));
+
+	if (hdr.packet_id < req->npackets) {
+		size_t offset = hdr.packet_id * req->response_size;
 
 		memcpy(req->response + offset, pkg->buffer, req->response_size);
+		(struct icm_pkg_header *)(req->response + offset) = hdr;
 	}
 
-	return hdr->packet_id == hdr->total_packets - 1;
+	return hdr.packet_id == hdr.total_packets - 1;
 }
 
 static int icm_request(struct tb *tb, const void *request, size_t request_size,
-- 
2.7.4

