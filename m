Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50DCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8497B217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170692;
	bh=ZRjjvbRg0U8VrZAIH6rcEIDvpAUC2l9AVTIQKjQLbbc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2NYhKzfZRHxPPIWsYkjo0au4pC1VD4cup0dWdO2tEcnRD1MOHVUvFxR6jW1A55KzI
	 t9A1nuHZxUdiZGJHXMQtdBNC78GE36xZnrL3WfFJai16/xChzghY+AGGCiGHDEYeq7
	 sL0vPHuSvGU0LChfX7yzGzNFI2VsegCTLhZhpg58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfAVPYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:24:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:38032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbfAVPYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:24:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2DDA217D8;
        Tue, 22 Jan 2019 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170660;
        bh=ZRjjvbRg0U8VrZAIH6rcEIDvpAUC2l9AVTIQKjQLbbc=;
        h=From:To:Cc:Subject:Date:From;
        b=lBarISVofbIgT0jzpcaUdGMDNSFNTUBISIC6yceuDoEGf8zIqWrrgXGz4N0T3KKD3
         WG/aRgpSFk+FpyK8tL6KJ39+r6i1nSVjCZd7kTpdniu7lvRwoOASmvaazeS8D5S6TJ
         X3PJmJpHOCr3Y6UUrQkPnVrQ8NHYkxHJ0qmhnc7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: [PATCH] futex: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:21:39 +0100
Message-Id: <20190122152151.16139-40-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/futex.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index be3bff2315ff..c2ed57b084a4 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -321,12 +321,8 @@ static int __init fail_futex_debugfs(void)
 	if (IS_ERR(dir))
 		return PTR_ERR(dir);
 
-	if (!debugfs_create_bool("ignore-private", mode, dir,
-				 &fail_futex.ignore_private)) {
-		debugfs_remove_recursive(dir);
-		return -ENOMEM;
-	}
-
+	debugfs_create_bool("ignore-private", mode, dir,
+			    &fail_futex.ignore_private);
 	return 0;
 }
 
-- 
2.20.1

