Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B14C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2191C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2191C20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solarflare.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbeKPWMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:12:20 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:57022 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727727AbeKPWMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:12:19 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id AE6862800B9;
        Fri, 16 Nov 2018 12:00:14 +0000 (UTC)
Received: from ec-desktop.uk.solarflarecom.com (10.17.20.45) by
 ocex03.SolarFlarecom.com (10.20.40.36) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 16 Nov 2018 04:00:08 -0800
From:   Edward Cree <ecree@solarflare.com>
Subject: [PATCH bpf] bpf: fix off-by-one error in adjust_subprog_starts
To:     <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Message-ID: <bce0322a-6392-3fd4-a6fb-562160c26198@solarflare.com>
Date:   Fri, 16 Nov 2018 12:00:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.17.20.45]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24226.005
X-TM-AS-Result: No-1.187500-4.000000-10
X-TMASE-MatchedRID: 0WNpcueVtr4vRbVu13x7nsAmcZEx8XHJt0+V7ekgRpgTf11Tnw43V+Qt
        5At0KMO6+E4F49aGGdllp59T3E6O3GlYwyKLpRk4syNb+yeIRAooUVkB7ifJnjUsHjosUACSU7g
        EPucszGdOFu8ssjxG8/JKsIzII36T6EovbiVesMlL6wfFL8xa+EDwlkRNC6PCwDR44lliPu1TsN
        hCV6hrfjUJquLkByfMYnAKxv9nxqVNfs8n85Te8oMbH85DUZXy3QfwsVk0UbvqwGfCk7KUsxpjA
        miOmZG+8Mh6PZPsN9L45dQ8KkjDhRteT8ovypFSHLXwhhVPjvkCPSTf+GaamgHQGhjI0OyEFaJy
        Z91ZT5m8OV5ZShvUdVrMCKBXF1d6I2VNggMWJCP4LggrmsRgvTwNB+BE7PnlftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.187500-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24226.005
X-MDID: 1542369615-odVFHRiXW1wA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When patching in a new sequence for the first insn of a subprog, the start
 of that subprog does not change (it's the first insn of the sequence), so
 adjust_subprog_starts should check start <= off (rather than < off).
Also added a test to test_verifier.c (it's essentially the syz reproducer).

Fixes: cc8b0b92a169 ("bpf: introduce function calls (function boundaries)")
Reported-by: syzbot+4fc427c7af994b0948be@syzkaller.appspotmail.com
Signed-off-by: Edward Cree <ecree@solarflare.com>
---
I'm assuming I don't need to get a Signed-off-by from syzkaller to use its
 reproducer like this; I'm not an expert on the copyright niceties of works
 written by bots.

 kernel/bpf/verifier.c                       |  2 +-
 tools/testing/selftests/bpf/test_verifier.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1971ca325fb4..6dd419550aba 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5650,7 +5650,7 @@ static void adjust_subprog_starts(struct bpf_verifier_env *env, u32 off, u32 len
 		return;
 	/* NOTE: fake 'exit' subprog should be updated as well. */
 	for (i = 0; i <= env->subprog_cnt; i++) {
-		if (env->subprog_info[i].start < off)
+		if (env->subprog_info[i].start <= off)
 			continue;
 		env->subprog_info[i].start += len - 1;
 	}
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 6f61df62f690..550b7e46bf4a 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -13896,6 +13896,25 @@ static struct bpf_test tests[] = {
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
