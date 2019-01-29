Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FF8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CF720880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763207;
	bh=PhlWMkrBJIiWRvzMitFnktTgelxhuONNMrl80yNT45w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V/euOp5klOQJiZbmvQ/GEHQRJbr8rwuRAlTXRevFqq4XLydbxT/SYGCpjZVjSzYI3
	 +7Hh5wqvNc+hg45xJqhJZNPI4j+UhG/Fd15kBRpX5uf46LBwoBJNyrd1ZQhJn5ATpe
	 ucjlrrwkfs9BQxJ1Tke4XtluGdhAEaeWwcoUFzOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbfA2Lqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:46:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730248AbfA2Lqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74B221871;
        Tue, 29 Jan 2019 11:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762393;
        bh=PhlWMkrBJIiWRvzMitFnktTgelxhuONNMrl80yNT45w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hcbHkH+5SlcIT/iziwBpDk5vt7u9i2HY1mi3sUE0tQMR0bJe+16gYDf5xcs6jsBJ
         f+k7c7XdcfiBF9MLqR4vQ+X7hAE0iJUHnq8VriZfjTgCKQGN8zqC0fobRrbD5f5Bsz
         REC0SVQ1Q895LWOGOEiVKl06WxFfYc4BuwC0uuG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 092/103] bpf: restrict stack pointer arithmetic for unprivileged
Date:   Tue, 29 Jan 2019 12:36:09 +0100
Message-Id: <20190129113207.058598277@linuxfoundation.org>
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

[ commit e4298d25830a866cc0f427d4bccb858e76715859 upstream ]

Restrict stack pointer arithmetic for unprivileged users in that
arithmetic itself must not go out of bounds as opposed to the actual
access later on. Therefore after each adjust_ptr_min_max_vals() with
a stack pointer as a destination we simulate a check_stack_access()
of 1 byte on the destination and once that fails the program is
rejected for unprivileged program loads. This is analog to map
value pointer arithmetic and needed for masking later on.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 63 ++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 110ca915cfb6..aa2944d54e7a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1238,6 +1238,31 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	}
 }
 
+static int check_stack_access(struct bpf_verifier_env *env,
+			      const struct bpf_reg_state *reg,
+			      int off, int size)
+{
+	/* Stack accesses must be at a fixed offset, so that we
+	 * can determine what type of data were returned. See
+	 * check_stack_read().
+	 */
+	if (!tnum_is_const(reg->var_off)) {
+		char tn_buf[48];
+
+		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+		verbose(env, "variable stack access var_off=%s off=%d size=%d",
+			tn_buf, off, size);
+		return -EACCES;
+	}
+
+	if (off >= 0 || off < -MAX_BPF_STACK) {
+		verbose(env, "invalid stack off=%d size=%d\n", off, size);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
 /* check read/write into map element returned by bpf_map_lookup_elem() */
 static int __check_map_access(struct bpf_verifier_env *env, u32 regno, int off,
 			      int size, bool zero_size_allowed)
@@ -1736,24 +1761,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		}
 
 	} else if (reg->type == PTR_TO_STACK) {
-		/* stack accesses must be at a fixed offset, so that we can
-		 * determine what type of data were returned.
-		 * See check_stack_read().
-		 */
-		if (!tnum_is_const(reg->var_off)) {
-			char tn_buf[48];
-
-			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-			verbose(env, "variable stack access var_off=%s off=%d size=%d",
-				tn_buf, off, size);
-			return -EACCES;
-		}
 		off += reg->var_off.value;
-		if (off >= 0 || off < -MAX_BPF_STACK) {
-			verbose(env, "invalid stack off=%d size=%d\n", off,
-				size);
-			return -EACCES;
-		}
+		err = check_stack_access(env, reg, off, size);
+		if (err)
+			return err;
 
 		state = func(env, reg);
 		err = update_stack_depth(env, state, off);
@@ -2884,11 +2895,19 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	/* For unprivileged we require that resulting offset must be in bounds
 	 * in order to be able to sanitize access later on.
 	 */
-	if (!env->allow_ptr_leaks && dst_reg->type == PTR_TO_MAP_VALUE &&
-	    check_map_access(env, dst, dst_reg->off, 1, false)) {
-		verbose(env, "R%d pointer arithmetic of map value goes out of range, prohibited for !root\n",
-			dst);
-		return -EACCES;
+	if (!env->allow_ptr_leaks) {
+		if (dst_reg->type == PTR_TO_MAP_VALUE &&
+		    check_map_access(env, dst, dst_reg->off, 1, false)) {
+			verbose(env, "R%d pointer arithmetic of map value goes out of range, "
+				"prohibited for !root\n", dst);
+			return -EACCES;
+		} else if (dst_reg->type == PTR_TO_STACK &&
+			   check_stack_access(env, dst_reg, dst_reg->off +
+					      dst_reg->var_off.value, 1)) {
+			verbose(env, "R%d stack pointer arithmetic goes out of range, "
+				"prohibited for !root\n", dst);
+			return -EACCES;
+		}
 	}
 
 	return 0;
-- 
2.19.1



