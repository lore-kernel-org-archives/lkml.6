Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B960C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E598D208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E598D208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965013AbeFRIW3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:22:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55538 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965435AbeFRIW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D479C7F;
        Mon, 18 Jun 2018 08:22:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 156/279] bpf, x64: fix memleak when not converging after image
Date:   Mon, 18 Jun 2018 10:12:21 +0200
Message-Id: <20180618080615.286989869@linuxfoundation.org>
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

[ Upstream commit 3aab8884c9eb99189a3569ac4e6b205371c9ac0b ]

While reviewing x64 JIT code, I noticed that we leak the prior allocated
JIT image in the case where proglen != oldproglen during the JIT passes.
Prior to the commit e0ee9c12157d ("x86: bpf_jit: fix two bugs in eBPF JIT
compiler") we would just break out of the loop, and using the image as the
JITed prog since it could only shrink in size anyway. After e0ee9c12157d,
we would bail out to out_addrs label where we free addrs and jit_data but
not the image coming from bpf_jit_binary_alloc().

Fixes: e0ee9c12157d ("x86: bpf_jit: fix two bugs in eBPF JIT compiler")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/net/bpf_jit_comp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1201,6 +1201,7 @@ skip_init_addrs:
 	for (pass = 0; pass < 20 || image; pass++) {
 		proglen = do_jit(prog, addrs, image, oldproglen, &ctx);
 		if (proglen <= 0) {
+out_image:
 			image = NULL;
 			if (header)
 				bpf_jit_binary_free(header);
@@ -1211,8 +1212,7 @@ skip_init_addrs:
 			if (proglen != oldproglen) {
 				pr_err("bpf_jit: proglen=%d != oldproglen=%d\n",
 				       proglen, oldproglen);
-				prog = orig_prog;
-				goto out_addrs;
+				goto out_image;
 			}
 			break;
 		}


