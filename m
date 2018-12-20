Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D00FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D55420656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297941;
	bh=9dg8ncPMTT5Zo4u02dDVlvpyInHvZnFVwDMjiDjyrGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FoQyz2DguETXevMPJdhOi+7XZAEujOFZ9PZGLJns29kOsFlGDX3QJ1YttSiBh2+1S
	 NH0ZK9hytnBalhMd2ZhvIs5IXxPaMQEKtlpb0H7DnrcLp/E+z35l+SEXsMd5nO8sC2
	 xPdAcC/s+Zmv624hpuIvCYwsVSlHiJg0i06BW6RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731969AbeLTJZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:25:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731115AbeLTJZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E472186A;
        Thu, 20 Dec 2018 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297931;
        bh=9dg8ncPMTT5Zo4u02dDVlvpyInHvZnFVwDMjiDjyrGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YufBX3QDaaIKGYJB2y2JRRJO8smkrsw4+JzT0CY4UGqEBtw3EyJd6XnjG0Ad2l7Ip
         Gp0/ksuahfeeA/uqGkenEjiOFuKQzbz2meqGGSPCwA63MvzQeBlGnVhZetFOQKdx0C
         z6N+nxF7/GI6i+Dv+sJH+V+K7uSoXwgz0k2b0N3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 01/72] timer/debug: Change /proc/timer_list from 0444 to 0400
Date:   Thu, 20 Dec 2018 10:18:00 +0100
Message-Id: <20181220085922.387104356@linuxfoundation.org>
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

[ Upstream commit 8e7df2b5b7f245c9bd11064712db5cb69044a362 ]

While it uses %pK, there's still few reasons to read this file
as non-root.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timer_list.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -389,7 +389,7 @@ static int __init init_timer_list_procfs
 {
 	struct proc_dir_entry *pe;
 
-	pe = proc_create("timer_list", 0444, NULL, &timer_list_fops);
+	pe = proc_create("timer_list", 0400, NULL, &timer_list_fops);
 	if (!pe)
 		return -ENOMEM;
 	return 0;


