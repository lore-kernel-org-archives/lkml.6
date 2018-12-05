Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF2CC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C81214DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXHFyewP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C81214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbeLEJxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:53:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbeLEJxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:53:07 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17D34213A2;
        Wed,  5 Dec 2018 09:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003587;
        bh=AZjjAOE8DvrAPq1sDRFP9RVuHeof/+t+D3bR+6Zg+iA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXHFyewPItJKEHIFn4CJWzC49m7v4+5F9y+F66rB/vjWhF3th69SHIdG/85Ngsy5Z
         OsSqI1ssQYlPfduDRy9o8YfHIukrmlScEJV2qqLsqusJT3EOEK0sdLGWZLRkph3YS5
         2VbM/jp24AlxkMg7zDpCtn1M3HNPFC+q255aZb1I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martynas Pumputis <m@lambda.lt>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 13/33] bpf: fix check of allowed specifiers in bpf_trace_printk
Date:   Wed,  5 Dec 2018 04:51:11 -0500
Message-Id: <20181205095131.7685-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
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
index 4228fd3682c3..3dd40c736067 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -119,11 +119,13 @@ static u64 bpf_trace_printk(u64 r1, u64 fmt_size, u64 r3, u64 r4, u64 r5)
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

