Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA13ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16537214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16537214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeIQPb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:31:59 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:58374 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeIQPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:31:59 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id ca5F1y00b3XaVaC01a5F97; Mon, 17 Sep 2018 12:05:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g1qP5-000653-N8; Mon, 17 Sep 2018 12:05:15 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g1oUN-0002qi-7K; Mon, 17 Sep 2018 10:02:35 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dm raid: Remove bogus const from decipher_sync_action() return type
Date:   Mon, 17 Sep 2018 10:02:34 +0200
Message-Id: <20180917080234.10909-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-4.1.2:

    drivers/md/dm-raid.c:3357: warning: type qualifiers ignored on function return type

Remove the "const" keyword to fix this.

Fixes: 36a240a706d43383 ("dm raid: fix RAID leg rebuild errors")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/md/dm-raid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 5ba067fa0c729bc8..c44925e4e4813d24 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3353,7 +3353,7 @@ static const char *sync_str(enum sync_state state)
 };
 
 /* Return enum sync_state for @mddev derived from @recovery flags */
-static const enum sync_state decipher_sync_action(struct mddev *mddev, unsigned long recovery)
+static enum sync_state decipher_sync_action(struct mddev *mddev, unsigned long recovery)
 {
 	if (test_bit(MD_RECOVERY_FROZEN, &recovery))
 		return st_frozen;
-- 
2.17.1

