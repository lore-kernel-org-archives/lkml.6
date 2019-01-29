Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D2BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C742C20880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763230;
	bh=dtaV2EOXWyqKy1WBvsbo8QQYbnYgcjQKrlJSo1j1wZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zwOh0HuyftVBmV8tH3tpONKQ3ZNsOdCQzLU2PF4gq8N2NgzArgE5iVyyKXXTKmzxP
	 jO+kp8ExEnlVj0CXsbRMdNVVgzWEFNCsndayA+U74aJG2dDc5WPnnyLW95aO8W7v+m
	 D9fHFClNIYWXPB8rhI4o7hDkaZClTvXlMxvxusuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfA2MA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729599AbfA2LqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F3BE2086C;
        Tue, 29 Jan 2019 11:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762380;
        bh=dtaV2EOXWyqKy1WBvsbo8QQYbnYgcjQKrlJSo1j1wZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PB3cDw6g51DUjX6p/4Kj19A9ByuDlm/3bTuBFXX1RhL/KnzQ/XMt6GgfBSSXYzeRj
         bjXffGL4J/ucjYW/Rea1AbutFMi+3vhGSG2zJBFhghK3LjtR0QB6KwSilJx+GGcTjz
         1shnKWBwmyzmTl5Xcm70wAOCdCKsm3MIDxd4NoqQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Edward Cree <ecree@solarflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 087/103] bpf: add per-insn complexity limit
Date:   Tue, 29 Jan 2019 12:36:04 +0100
Message-Id: <20190129113206.757195314@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

[ commit ceefbc96fa5c5b975d87bf8e89ba8416f6b764d9 upstream ]

malicious bpf program may try to force the verifier to remember
a lot of distinct verifier states.
Put a limit to number of per-insn 'struct bpf_verifier_state'.
Note that hitting the limit doesn't reject the program.
It potentially makes the verifier do more steps to analyze the program.
It means that malicious programs will hit BPF_COMPLEXITY_LIMIT_INSNS sooner
instead of spending cpu time walking long link list.

The limit of BPF_COMPLEXITY_LIMIT_STATES==64 affects cilium progs
with slight increase in number of "steps" it takes to successfully verify
the programs:
                       before    after
bpf_lb-DLB_L3.o         1940      1940
bpf_lb-DLB_L4.o         3089      3089
bpf_lb-DUNKNOWN.o       1065      1065
bpf_lxc-DDROP_ALL.o     28052  |  28162
bpf_lxc-DUNKNOWN.o      35487  |  35541
bpf_netdev.o            10864     10864
bpf_overlay.o           6643      6643
bpf_lcx_jit.o           38437     38437

But it also makes malicious program to be rejected in 0.4 seconds vs 6.5
Hence apply this limit to unprivileged programs only.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d093003c723..2bbb98535b70 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -156,6 +156,7 @@ struct bpf_verifier_stack_elem {
 
 #define BPF_COMPLEXITY_LIMIT_INSNS	131072
 #define BPF_COMPLEXITY_LIMIT_STACK	1024
+#define BPF_COMPLEXITY_LIMIT_STATES	64
 
 #define BPF_MAP_PTR_UNPRIV	1UL
 #define BPF_MAP_PTR_POISON	((void *)((0xeB9FUL << 1) +	\
@@ -4735,7 +4736,7 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 	struct bpf_verifier_state_list *new_sl;
 	struct bpf_verifier_state_list *sl;
 	struct bpf_verifier_state *cur = env->cur_state;
-	int i, j, err;
+	int i, j, err, states_cnt = 0;
 
 	sl = env->explored_states[insn_idx];
 	if (!sl)
@@ -4762,8 +4763,12 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
 			return 1;
 		}
 		sl = sl->next;
+		states_cnt++;
 	}
 
+	if (!env->allow_ptr_leaks && states_cnt > BPF_COMPLEXITY_LIMIT_STATES)
+		return 0;
+
 	/* there were no equivalent states, remember current one.
 	 * technically the current state is not proven to be safe yet,
 	 * but it will either reach outer most bpf_exit (which means it's safe)
-- 
2.19.1



