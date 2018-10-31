Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA20220847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tu0NP/69"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA20220847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbeKAIWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:22:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731379AbeKAILB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BD4D2085A;
        Wed, 31 Oct 2018 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027450;
        bh=CqsgOk1L0cm00Cbk3rDnyrv0hJ6rYl1EHSNxB4d/3Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tu0NP/69dIxvPecpgKRYxpWG90xhdwlenHsXsVTMF2+EOLJDetvV6I5Pm66mQoJAQ
         k6AWFV2XDpuRJ7Zr6wK9JxkBQ+W/t5ysL/6p88SoKIoamKUBysWXSg4Vh5etNo0Qzz
         u9nBUfpbZ+YQ1QepK4GzIg5AH1ZMYi8sxHYVl1og=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 69/73] signal: Always deliver the kernel's SIGKILL and SIGSTOP to a pid namespace init
Date:   Wed, 31 Oct 2018 19:09:44 -0400
Message-Id: <20181031230948.29203-69-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
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
index b74acbec9876..7181215e9b64 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1003,7 +1003,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t,
-			from_ancestor_ns || (info == SEND_SIG_FORCED)))
+			from_ancestor_ns || (info == SEND_SIG_PRIV) || (info == SEND_SIG_FORCED)))
 		goto ret;
 
 	pending = group ? &t->signal->shared_pending : &t->pending;
-- 
2.17.1

