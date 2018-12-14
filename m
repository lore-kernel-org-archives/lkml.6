Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C9DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3AD2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789251;
	bh=6+WBP6JLgm7pO2DIRdO+66i/jbAbwpcIB5nQJXNWutE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=naADqnu6FjBxGsy/rmbTebSQVRkV1Xw0WKQdORGQkYUz8s2CisBStvhs4Q/6FRefS
	 78e+E1DqdmtwhW+hRwq7TU3jHWEZgboxAK8cMV3DJ6AKtsWyNp87KGwg3yFYEXA5ek
	 AWeqHYO1ZW7yAYFu8sBOVRLOwCh42tIA3r5dVD74=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3AD2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbeLNMHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbeLNMH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDEB2147D;
        Fri, 14 Dec 2018 12:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789245;
        bh=6+WBP6JLgm7pO2DIRdO+66i/jbAbwpcIB5nQJXNWutE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4FjlRL1x+Uf2sDGESuvfTSWiexsHrhjevPIj9S0etj0RYI1HaVeVtAiQXMHTEMvr
         4oCNGk0dXwktmYW+r3kIq3tNRs0Lmm6LTwlpQGshoXlqsI1K9DGYgqhQFw9A6qepud
         o0yKHA6YxNU5xYVJEuQtAnhFROngTGMwIXlOYpkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com,
        Edward Cree <ecree@solarflare.com>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.19 142/142] bpf: fix off-by-one error in adjust_subprog_starts
Date:   Fri, 14 Dec 2018 13:00:27 +0100
Message-Id: <20181214115752.714813088@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Cree <ecree@solarflare.com>

commit afd594240806acc138cf696c09f2f4829d55d02f upstream.

When patching in a new sequence for the first insn of a subprog, the start
 of that subprog does not change (it's the first insn of the sequence), so
 adjust_subprog_starts should check start <= off (rather than < off).
Also added a test to test_verifier.c (it's essentially the syz reproducer).

Fixes: cc8b0b92a169 ("bpf: introduce function calls (function boundaries)")
Reported-by: syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com
Signed-off-by: Edward Cree <ecree@solarflare.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/verifier.c                       |    2 +-
 tools/testing/selftests/bpf/test_verifier.c |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5283,7 +5283,7 @@ static void adjust_subprog_starts(struct
 		return;
 	/* NOTE: fake 'exit' subprog should be updated as well. */
 	for (i = 0; i <= env->subprog_cnt; i++) {
-		if (env->subprog_info[i].start < off)
+		if (env->subprog_info[i].start <= off)
 			continue;
 		env->subprog_info[i].start += len - 1;
 	}
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -12511,6 +12511,25 @@ static struct bpf_test tests[] = {
 		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 		.result = ACCEPT,
 	},
+	{
+		"calls: ctx read at start of subprog",
+		.insns = {
+			BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 5),
+			BPF_JMP_REG(BPF_JSGT, BPF_REG_0, BPF_REG_0, 0),
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
+			BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
+			BPF_MOV64_REG(BPF_REG_1, BPF_REG_0),
+			BPF_EXIT_INSN(),
+			BPF_LDX_MEM(BPF_B, BPF_REG_9, BPF_REG_1, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		},
+		.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
+		.errstr_unpriv = "function calls to other bpf functions are allowed for root only",
+		.result_unpriv = REJECT,
+		.result = ACCEPT,
+	},
 };
 
 static int probe_filter_length(const struct bpf_insn *fp)


