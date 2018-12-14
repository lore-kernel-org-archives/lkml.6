Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0C7C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D068D21508
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789647;
	bh=E3oorWNOlYDLc1kVSFU3vmYZjJsfQQUVHfMqG2SUYZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S8W3sr2VK24BjzNt28ptjSWE4o7goaef5EFjMIc3aGkjZ6Rwwmx8hHGfUHM/zurUP
	 r9W9sHJZae23Ym3MOGHOibC6dlmzHZ+DZmqD3L/HtmeBotIQSi0Y+///JCzoFngj/+
	 SqiTrS1pz6qenfDwjNLLgL7Dd3dDxNvqF2w/8sqw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D068D21508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbeLNMOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730579AbeLNMOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:14:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0522C214F0;
        Fri, 14 Dec 2018 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789643;
        bh=E3oorWNOlYDLc1kVSFU3vmYZjJsfQQUVHfMqG2SUYZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNWgYrhyxXvSzB/tdMQO+TxecbbuhTiunlygICh+4RUbBxE4GHBKVTr3Gv4VhBJC6
         CDoA0KKiV1VpJy03Xg96/iCVSMjN3SYhvghZH7oVG4RawSOiUH0ZQWH8m19i5ZbRys
         I5kYRci7rBA+zVq5NNmysRpTl35nYLcXuzH8oafA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com,
        Martynas Pumputis <m@lambda.lt>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 21/88] bpf: fix check of allowed specifiers in bpf_trace_printk
Date:   Fri, 14 Dec 2018 12:59:55 +0100
Message-Id: <20181214115703.888579559@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



