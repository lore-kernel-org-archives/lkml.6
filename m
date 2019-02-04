Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9298CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1CB2175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549314460;
	bh=awcOFxXuAB7snDuDrXhqyOS89kVZGjIAerQumthlT+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=g2mllyQqEzBi473JVbaMUGga2Hxw3Y5x3+ZYkzr4LRIs63DeFyOYDP6T7+nJwbaxZ
	 4+QZ2z7iUrHD0DIFAPLoeEVhx/AMWWjYIMn0JGixhJGCOB3KCjZZMgQD/wJqxNitqQ
	 Il15cdnTA3dk9W/hRPWFwLVR2O9RsZS2wLyP1lFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfBDVHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:07:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbfBDVHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:07:33 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15252082E;
        Mon,  4 Feb 2019 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549314453;
        bh=awcOFxXuAB7snDuDrXhqyOS89kVZGjIAerQumthlT+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=AeEGIThexPWAv3KZRfIjqQezZdY+cydXQd54QFrf0a2CzF7Wspj1QgyZAXzKqrD3G
         iylF4/lHtCQeXAM6VUrT0EJB/wej6QluXOI8D2OHuleWbZpaQEa6eG8pezqn4lmb1w
         AryA0uNuoXZts6erimzMtV7XCPoSFggdVUFTPumE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 1/2] tracing: Use str_has_prefix() in synth_event_create()
Date:   Mon,  4 Feb 2019 15:07:23 -0600
Message-Id: <03418373fd1e80030e7394b8e3e081c5de28a710.1549309756.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1549309756.git.tom.zanussi@linux.intel.com>
References: <cover.1549309756.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Since we now have a str_has_prefix() that returns the length, we can
use that instead of explicitly calculating it.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Joe Perches <joe@perches.com>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 449d90cfa151..c4a667503bf0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1200,8 +1200,8 @@ static int synth_event_create(int argc, const char **argv)
 
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
-		len = sizeof(SYNTH_SYSTEM "/") - 1;
-		if (strncmp(name, SYNTH_SYSTEM "/", len))
+		len = str_has_prefix(name, SYNTH_SYSTEM "/");
+		if (len == 0)
 			return -EINVAL;
 		name += len;
 	}
-- 
2.14.1

