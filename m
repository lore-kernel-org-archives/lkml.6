Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3799C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B45E2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2hqCN5CE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B45E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbeLEJuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729617AbeLEJuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:50:01 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 270E2213A2;
        Wed,  5 Dec 2018 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003400;
        bh=qHcYHsQPPA1K6C+5HwlYTMEiraOxiID9WooPkQCi9Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hqCN5CExVq20eoVh6khvX670raj+BxkXYeHtka+gf+zuC2KjbaDmM+SCPWKQTB0r
         QokF8gURxP/1oUxsxnXQHB3SKZEnTSGl6Hesx57MIuMfimos7BXqHxKVOVnzM2p4xW
         c7g2xK5B1q0TTZmqpT4ijjUrEjMBqtXmvzs/CElM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martynas Pumputis <m@lambda.lt>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 20/45] bpf: fix check of allowed specifiers in bpf_trace_printk
Date:   Wed,  5 Dec 2018 04:46:41 -0500
Message-Id: <20181205094706.7225-20-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094706.7225-1-sashal@kernel.org>
References: <20181205094706.7225-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martynas Pumputis <m@lambda.lt>

[ Upstream commit 1efb6ee3edea57f57f9fb05dba8dcb3f7333f61f ]

A format string consisting of "%p" or "%s" followed by an invalid
specifier (e.g. "%p%\n" or "%s%") could pass the check which
would make format_decode (lib/vsprintf.c) to warn.

Fixes: 9c959c863f82 ("tracing: Allow BPF programs to call bpf_trace_printk()")
Reported-by: syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com
Signed-off-by: Martynas Pumputis <m@lambda.lt>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/bpf_trace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 41805fb3c661..7cc06f267be5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -161,11 +161,13 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 			i++;
 		} else if (fmt[i] == 'p' || fmt[i] == 's') {
 			mod[fmt_cnt]++;
-			i++;
-			if (!isspace(fmt[i]) && !ispunct(fmt[i]) && fmt[i] != 0)
+			/* disallow any further format extensions */
+			if (fmt[i + 1] != 0 &&
+			    !isspace(fmt[i + 1]) &&
+			    !ispunct(fmt[i + 1]))
 				return -EINVAL;
 			fmt_cnt++;
-			if (fmt[i - 1] == 's') {
+			if (fmt[i] == 's') {
 				if (str_seen)
 					/* allow only one '%s' per fmt string */
 					return -EINVAL;
-- 
2.17.1

