Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50288C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F8120855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547732961;
	bh=QzWU3YoM84khii1xIC4owFdP2KYK4WgnHL2KCobrLR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FxnzD5TmlrHNBeKFXnWCAGpC280IboFwAn9msb2fxiHzW89R5vzp3QqAknc0V51tW
	 mkCAWbUsaLGMHCeRfAyUxhqhCdX/zKzW/NJ/ptmBH/eohjzY19i9ZR9ybQioDpCBfm
	 90kzw58AEGSfMoMyT1x5V0w3n8cQNJoK/3E2RfDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfAQNtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfAQNtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:49:19 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33FF20851;
        Thu, 17 Jan 2019 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547732958;
        bh=QzWU3YoM84khii1xIC4owFdP2KYK4WgnHL2KCobrLR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xIMif9SBZNj/HHEmFaC6W523c+kNBNA2/LFRgMnoY5ntvrtMhyMgJtHkcMMAZSi0B
         CiWxMRy2cozJqWP2v4Fn9mClEVIul0tCnZ5IVSjO2W6OsZ1bFr8DP3E2T0YAswWBbp
         tjrATXrM0W8ArtKXOVtAJiwTIL/eD9vHbdLJWxs4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tracing: probeevent: Do not accumulate on ret variable
Date:   Thu, 17 Jan 2019 22:48:55 +0900
Message-Id: <154773293570.2285.15635282580280627220.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154773287750.2285.5509629487576876823.stgit@devbox>
References: <154773287750.2285.5509629487576876823.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not accumulate strlen result on ret local variable, because
it is accumulated on total local variable for array case.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe_tmpl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 5c56afc17cf8..e69b05a9f57c 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -88,7 +88,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
 		if (code->op == FETCH_OP_ST_STRING) {
-			ret += fetch_store_strlen(val + code->offset);
+			ret = fetch_store_strlen(val + code->offset);
 			code++;
 			goto array;
 		} else

