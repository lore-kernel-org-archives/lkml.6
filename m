Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D0AC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD2E20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS2fwmY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD2E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbeKIHdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeKIHdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:35 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6614220989;
        Thu,  8 Nov 2018 21:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714168;
        bh=/eN8I6diW1pbQM6bLYyyyNPM2u62KXmSQuctOGPD1TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HS2fwmY1j5BZ3eBk2tGQjhe2ZBs/luHWHAiCUyimhxGJl8tUyMaSvdhIqfaAny8Dk
         +0dI/AIPO8c6EVySW+e2FWjMnlbRlNp1lbuElqm8jQj9k4e93/DehJeeIVoraGg9QT
         pYyutr32csWtHE8ogzFdaWap+nDCGD+up7rMsnjw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 089/144] dm: fix AB-BA deadlock in __dm_destroy()
Date:   Thu,  8 Nov 2018 13:51:00 -0800
Message-Id: <20181108215101.858874763@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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

[ Upstream commit 2a708cff93f1845b9239bc7d6310aef54e716c6a ]

__dm_destroy() takes io_barrier SRCU lock (dm_get_live_table) and
suspend_lock in reverse order.  Doing so can cause AB-BA deadlock:

  __dm_destroy                    dm_swap_table
  ---------------------------------------------------
                                  mutex_lock(suspend_lock)
  dm_get_live_table()
    srcu_read_lock(io_barrier)
                                  dm_sync_table()
                                    synchronize_srcu(io_barrier)
                                      .. waiting for dm_put_live_table()
  mutex_lock(suspend_lock)
    .. waiting for suspend_lock

Fix this by taking the locks in proper order.

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Fixes: ab7c7bb6f4ab ("dm: hold suspend_lock while suspending device during device deletion")
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1d08dc6fa0b5..00c86ff3c721 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2599,14 +2599,14 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
 	 * do not race with internal suspend.
 	 */
 	mutex_lock(&md->suspend_lock);
+	map = dm_get_live_table(md, &srcu_idx);
 	if (!dm_suspended_md(md)) {
 		dm_table_presuspend_targets(map);
 		dm_table_postsuspend_targets(map);
 	}
-	mutex_unlock(&md->suspend_lock);
-
 	/* dm_put_live_table must be before msleep, otherwise deadlock is possible */
 	dm_put_live_table(md, srcu_idx);
+	mutex_unlock(&md->suspend_lock);
 
 	/*
 	 * Rare, but there may be I/O requests still going to complete,
-- 
2.17.1



