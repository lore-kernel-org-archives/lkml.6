Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E29C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25C1217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298764;
	bh=kVNLncR6C4xFdPyghxs/rUN1z4pmmdSErKmQ1aNXkkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TuBffwkaSwVy00maR6XvnE2oLu4xQgE8mf8QSO7+9G/i3veCl137iLPaeFVJEA9K3
	 adYZ5ZWTBp6+9nCd4/GLAs0ou8cv8NaSbVOEta1MXAiuGbHgYfRc7D6RtLu3mAtlmX
	 XTDvkpQ4JHGzGaOQZBdDBMEeH0dZaWvmDb0jQrx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387474AbeLTJjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:39:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbeLTJZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4BF217D7;
        Thu, 20 Dec 2018 09:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297936;
        bh=kVNLncR6C4xFdPyghxs/rUN1z4pmmdSErKmQ1aNXkkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzBynnHvaAQID4yWbHVHuGwLVtzXfv807kBdZccA2LHZmy8hW61J8cynCMk8wp82e
         7ZjnfV5FFm7qCGb95QQMvxt7NU4f6XLn65dPThbIRTymzGo9J+bxdVWCqX8b+QQpNP
         p4Kbzq3z7jHnVaDiL9awoc9b5+6aHzwwTW0J12jU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Teigland <teigland@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 11/72] dm cache metadata: verify cache has blocks in blocks_are_clean_separate_dirty()
Date:   Thu, 20 Dec 2018 10:18:10 +0100
Message-Id: <20181220085922.779791469@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085922.332225035@linuxfoundation.org>
References: <20181220085922.332225035@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit 687cf4412a343a63928a5c9d91bdc0f522939d43 upstream.

Otherwise dm_bitset_cursor_begin() return -ENODATA.  Other calls to
dm_bitset_cursor_begin() have similar negative checks.

Fixes inability to create a cache in passthrough mode (even though doing
so makes no sense).

Fixes: 0d963b6e65 ("dm cache metadata: fix metadata2 format's blocks_are_clean_separate_dirty")
Cc: stable@vger.kernel.org
Reported-by: David Teigland <teigland@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-cache-metadata.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -929,6 +929,10 @@ static int blocks_are_clean_separate_dir
 	bool dirty_flag;
 	*result = true;
 
+	if (from_cblock(cmd->cache_blocks) == 0)
+		/* Nothing to do */
+		return 0;
+
 	r = dm_bitset_cursor_begin(&cmd->dirty_info, cmd->dirty_root,
 				   from_cblock(cmd->cache_blocks), &cmd->dirty_cursor);
 	if (r) {


