Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B5C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1350620876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1350620876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeJNXPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:15:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36283 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728051AbeJNXME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:04 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cd-C1; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000VA-UM; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Alexei Starovoitov" <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Daniel Borkmann" <daniel@iogearbox.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.879041542@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 252/366] bpf, x64: fix memleak when not converging
 after image
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 3aab8884c9eb99189a3569ac4e6b205371c9ac0b upstream.

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
[bwh: Backported to 3.16: Deleted code is slightly different]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -914,6 +914,7 @@ void bpf_int_jit_compile(struct sk_filte
 	for (pass = 0; pass < 10 || image; pass++) {
 		proglen = do_jit(prog, addrs, image, oldproglen, &ctx);
 		if (proglen <= 0) {
+out_image:
 			image = NULL;
 			if (header)
 				module_free(NULL, header);
@@ -923,7 +924,7 @@ void bpf_int_jit_compile(struct sk_filte
 			if (proglen != oldproglen) {
 				pr_err("bpf_jit: proglen=%d != oldproglen=%d\n",
 				       proglen, oldproglen);
-				goto out;
+				goto out_image;
 			}
 			break;
 		}

