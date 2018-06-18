Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231DCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D062E20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D062E20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965549AbeFRIWd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:22:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55550 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965515AbeFRIW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:29 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C1D18C84;
        Mon, 18 Jun 2018 08:22:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 157/279] bpf, x64: fix memleak when not converging on calls
Date:   Mon, 18 Jun 2018 10:12:22 +0200
Message-Id: <20180618080615.325301681@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 39f56ca945af86112753646316c4c92dcd4acd82 ]

The JIT logic in jit_subprogs() is as follows: for all subprogs we
allocate a bpf_prog_alloc(), populate it (prog->is_func = 1 here),
and pass it to bpf_int_jit_compile(). If a failure occurred during
JIT and prog->jited is not set, then we bail out from attempting to
JIT the whole program, and punt to the interpreter instead. In case
JITing went successful, we fixup BPF call offsets and do another
pass to bpf_int_jit_compile() (extra_pass is true at that point) to
complete JITing calls. Given that requires to pass JIT context around
addrs and jit_data from x86 JIT are freed in the extra_pass in
bpf_int_jit_compile() when calls are involved (if not, they can
be freed immediately). However, if in the original pass, the JIT
image didn't converge then we leak addrs and jit_data since image
itself is NULL, the prog->is_func is set and extra_pass is false
in that case, meaning both will become unreachable and are never
cleaned up, therefore we need to free as well on !image. Only x64
JIT is affected.

Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/net/bpf_jit_comp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1249,7 +1249,7 @@ out_image:
 		prog = orig_prog;
 	}
 
-	if (!prog->is_func || extra_pass) {
+	if (!image || !prog->is_func || extra_pass) {
 out_addrs:
 		kfree(addrs);
 		kfree(jit_data);


