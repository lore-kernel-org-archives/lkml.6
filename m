Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83289C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D8E214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789404;
	bh=DBEF/xBM9PXIg9AOMwLI7z2CJpMt9Q0Ggg+PxFNQsJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HCxkLTC35Q52qz8nHaCgq+t7Ff2RaQayrpsJTiTxjeRA5UiAtWIug7xnqqo2+yjOF
	 GOumxRkQ/Uynxy6IVmFg3qve6vd7MH1e1wm5dVZm1mwtVIPu7WSpw5YA9dUMdUoVQK
	 xSluxPw9/lWxFAd0cuI9u8c19SSwNLyJtMii+5XI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D8E214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbeLNMKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731542AbeLNMKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0DE1214DE;
        Fri, 14 Dec 2018 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789400;
        bh=DBEF/xBM9PXIg9AOMwLI7z2CJpMt9Q0Ggg+PxFNQsJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=avdmKEBd5taKA5qQQ2rcNzZ7w66ATbzqjEXAQ7hQ1H1tsi3W8plgoMBk+aiLMTiKE
         5u7CDk0LDllhz2xOwWtyJTMVvptSQUTGrnQZAB3CeMIRV9LMnFCc8+WwBJajeebVRZ
         7kvaNUWZnRdjo7aoVM7JGNl72/tL8fuXOWaaQTAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+1ec5c5ec949c4adaa0c4@syzkaller.appspotmail.com,
        Martynas Pumputis <m@lambda.lt>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 45/89] bpf: fix check of allowed specifiers in bpf_trace_printk
Date:   Fri, 14 Dec 2018 12:59:58 +0100
Message-Id: <20181214115731.908325384@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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
index 6350f64d5aa4..f9dd8fd055a6 100644
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
2.19.1



