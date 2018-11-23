Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566FAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD8620824
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD8620824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395375AbeKXFUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:20:25 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:60741 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbeKXFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 00:20:25 -0500
Received: from cpc118554-reig6-2-0-cust775.6-3.cable.virginm.net ([86.18.95.8] helo=xylophone.i.decadent.org.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gQGI5-0001K6-0V; Fri, 23 Nov 2018 18:34:57 +0000
Date:   Fri, 23 Nov 2018 18:34:55 +0000
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] bpf/verifier: Log instruction patching when verbose
 logging is enabled
Message-ID: <20181123183455.qjokyt6zpa2yck6s@xylophone.i.decadent.org.uk>
References: <20181123183356.5q4bu47zpj5wdufb@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123183356.5q4bu47zpj5wdufb@xylophone.i.decadent.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User-space does not have access to the patched eBPF code, but we
need to be able to test that patches are being applied.  Therefore
log distinct messages for each case that requires patching.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 kernel/bpf/verifier.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ce049cd30a3..ea4bc796e545 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5844,6 +5844,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			verbose(env, "bpf verifier is misconfigured\n");
 			return -EINVAL;
 		} else if (cnt) {
+			verbose(env, "patching in prologue\n");
 			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
@@ -5892,6 +5893,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			};
 
 			cnt = ARRAY_SIZE(patch);
+			verbose(env,
+				"patching in sanitization against SSB at %d\n",
+				i + delta);
 			new_prog = bpf_patch_insn_data(env, i + delta, patch, cnt);
 			if (!new_prog)
 				return -ENOMEM;
@@ -5973,6 +5977,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			}
 		}
 
+		verbose(env, "patching explicit ctx access at %d\n", i + delta);
 		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 		if (!new_prog)
 			return -ENOMEM;
@@ -6225,6 +6230,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 				cnt = ARRAY_SIZE(mask_and_mod) - (is64 ? 1 : 0);
 			}
 
+			verbose(env, "patching in divide-by-zero check at %d\n",
+				i + delta);
 			new_prog = bpf_patch_insn_data(env, i + delta, patchlet, cnt);
 			if (!new_prog)
 				return -ENOMEM;
@@ -6244,6 +6251,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 				return -EINVAL;
 			}
 
+			verbose(env, "patching implicit ctx access at %d\n",
+				i + delta);
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
@@ -6307,6 +6316,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 								 map)->index_mask);
 			insn_buf[2] = *insn;
 			cnt = 3;
+			verbose(env, "patching in tail-call bounds check at %d",
+				i + delta);
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
@@ -6342,6 +6353,8 @@ static int fixup_bpf_calls(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
+				verbose(env, "patching in map lookup at %d",
+					i + delta);
 				new_prog = bpf_patch_insn_data(env, i + delta,
 							       insn_buf, cnt);
 				if (!new_prog)
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


