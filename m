Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF261C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7C020664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQTE8vnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7C020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731875AbeKAILs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731786AbeKAILq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76A8F20664;
        Wed, 31 Oct 2018 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027495;
        bh=38CQqjNPdkf85su4LPhgFzWJF01rCq5Ud/kzbqz4pv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQTE8vnrQGcfXxD6ebNBYLxITc6B4aVGdXauDM4kG3Cq4FqIoS3Af7ig2Qzf3oB1B
         oiWYBMwLtG3FYbbL9q9j4Zv94O1qDP1u6uLGVhma3zzzKOpozmxJv0orrIMLgOOBNF
         p4/M9pSQyQfjKlC16ZLwqMXPY9u5bdBJEjHt9cqE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 46/48] signal: Always deliver the kernel's SIGKILL and SIGSTOP to a pid namespace init
Date:   Wed, 31 Oct 2018 19:10:52 -0400
Message-Id: <20181031231054.29333-46-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 3597dfe01d12f570bc739da67f857fd222a3ea66 ]

Instead of playing whack-a-mole and changing SEND_SIG_PRIV to
SEND_SIG_FORCED throughout the kernel to ensure a pid namespace init
gets signals sent by the kernel, stop allowing a pid namespace init to
ignore SIGKILL or SIGSTOP sent by the kernel.  A pid namespace init is
only supposed to be able to ignore signals sent from itself and
children with SIG_DFL.

Fixes: 921cf9f63089 ("signals: protect cinit from unblocked SIG_DFL signals")
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 4364e57e6038..424306163edc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -991,7 +991,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t,
-			from_ancestor_ns || (info == SEND_SIG_FORCED)))
+			from_ancestor_ns || (info == SEND_SIG_PRIV) || (info == SEND_SIG_FORCED)))
 		goto ret;
 
 	pending = group ? &t->signal->shared_pending : &t->pending;
-- 
2.17.1

