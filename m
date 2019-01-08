Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8E2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE04F217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546975617;
	bh=SOsfVzCKaisJ8DmdxNlxAhvOw/qrhgn0Wa8EhkLmq3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jQld94GQq09M4Hk0URyeXk/F5vD9D7gZsMw3QSI80Z0uuOh3QoUXt0gq2u9FndwpC
	 JM4+Lc4QIk9Sk7q0QAAMSf8PWZaSXGemx2bzpEcYYTimi60fh8PnmfE6Qse9T10qXN
	 aihdK6flaN8J2TnVCzidb1a0wjJ6wm6p4KattR38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbfAHT05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:26:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:32780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbfAHT0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:26:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A131C20883;
        Tue,  8 Jan 2019 19:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975614;
        bh=SOsfVzCKaisJ8DmdxNlxAhvOw/qrhgn0Wa8EhkLmq3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QsoYA5goh67OSw2k3xmeHNSJkJC1f/DBJYSKraWdorVxNa4abUbaqfa3rScCQHgYW
         7oDL93RaUkJcA+nAIxKnDMSlnekZDWjIgN70oyFbIT1+cL3DvzIg/du4aq6mr0mxZo
         1lxRrtRCAs0ntsZoabbQ1VIC/OGkmWUrBycgmv6w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrey Ignatov <rdna@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 015/117] bpf: Allow narrow loads with offset > 0
Date:   Tue,  8 Jan 2019 14:24:43 -0500
Message-Id: <20190108192628.121270-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ignatov <rdna@fb.com>

[ Upstream commit 46f53a65d2de3e1591636c22b626b09d8684fd71 ]

Currently BPF verifier allows narrow loads for a context field only with
offset zero. E.g. if there is a __u32 field then only the following
loads are permitted:
  * off=0, size=1 (narrow);
  * off=0, size=2 (narrow);
  * off=0, size=4 (full).

On the other hand LLVM can generate a load with offset different than
zero that make sense from program logic point of view, but verifier
doesn't accept it.

E.g. tools/testing/selftests/bpf/sendmsg4_prog.c has code:

  #define DST_IP4			0xC0A801FEU /* 192.168.1.254 */
  ...
  	if ((ctx->user_ip4 >> 24) == (bpf_htonl(DST_IP4) >> 24) &&

where ctx is struct bpf_sock_addr.

Some versions of LLVM can produce the following byte code for it:

       8:       71 12 07 00 00 00 00 00         r2 = *(u8 *)(r1 + 7)
       9:       67 02 00 00 18 00 00 00         r2 <<= 24
      10:       18 03 00 00 00 00 00 fe 00 00 00 00 00 00 00 00         r3 = 4261412864 ll
      12:       5d 32 07 00 00 00 00 00         if r2 != r3 goto +7 <LBB0_6>

where `*(u8 *)(r1 + 7)` means narrow load for ctx->user_ip4 with size=1
and offset=3 (7 - sizeof(ctx->user_family) = 3). This load is currently
rejected by verifier.

Verifier code that rejects such loads is in bpf_ctx_narrow_access_ok()
what means any is_valid_access implementation, that uses the function,
works this way, e.g. bpf_skb_is_valid_access() for __sk_buff or
sock_addr_is_valid_access() for bpf_sock_addr.

The patch makes such loads supported. Offset can be in [0; size_default)
but has to be multiple of load size. E.g. for __u32 field the following
loads are supported now:
  * off=0, size=1 (narrow);
  * off=1, size=1 (narrow);
  * off=2, size=1 (narrow);
  * off=3, size=1 (narrow);
  * off=0, size=2 (narrow);
  * off=2, size=2 (narrow);
  * off=0, size=4 (full).

Reported-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h | 16 +---------------
 kernel/bpf/verifier.c  | 21 ++++++++++++++++-----
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index a8b9d90a8042..25a556589ae8 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -675,24 +675,10 @@ static inline u32 bpf_ctx_off_adjust_machine(u32 size)
 	return size;
 }
 
-static inline bool bpf_ctx_narrow_align_ok(u32 off, u32 size_access,
-					   u32 size_default)
-{
-	size_default = bpf_ctx_off_adjust_machine(size_default);
-	size_access  = bpf_ctx_off_adjust_machine(size_access);
-
-#ifdef __LITTLE_ENDIAN
-	return (off & (size_default - 1)) == 0;
-#else
-	return (off & (size_default - 1)) + size_access == size_default;
-#endif
-}
-
 static inline bool
 bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
 {
-	return bpf_ctx_narrow_align_ok(off, size, size_default) &&
-	       size <= size_default && (size & (size - 1)) == 0;
+	return size <= size_default && (size & (size - 1)) == 0;
 }
 
 #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 51ba84d4d34a..a81f52b2c92e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5789,10 +5789,10 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 	int i, cnt, size, ctx_field_size, delta = 0;
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn insn_buf[16], *insn;
+	u32 target_size, size_default, off;
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
-	u32 target_size;
 
 	if (ops->gen_prologue || env->seen_direct_write) {
 		if (!ops->gen_prologue) {
@@ -5885,9 +5885,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		 * we will apply proper mask to the result.
 		 */
 		is_narrower_load = size < ctx_field_size;
+		size_default = bpf_ctx_off_adjust_machine(ctx_field_size);
+		off = insn->off;
 		if (is_narrower_load) {
-			u32 size_default = bpf_ctx_off_adjust_machine(ctx_field_size);
-			u32 off = insn->off;
 			u8 size_code;
 
 			if (type == BPF_WRITE) {
@@ -5915,12 +5915,23 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 
 		if (is_narrower_load && size < target_size) {
-			if (ctx_field_size <= 4)
+			u8 shift = (off & (size_default - 1)) * 8;
+
+			if (ctx_field_size <= 4) {
+				if (shift)
+					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
+									insn->dst_reg,
+									shift);
 				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
 								(1 << size * 8) - 1);
-			else
+			} else {
+				if (shift)
+					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
+									insn->dst_reg,
+									shift);
 				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
 								(1 << size * 8) - 1);
+			}
 		}
 
 		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
-- 
2.19.1

