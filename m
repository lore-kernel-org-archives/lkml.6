Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC51C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5095214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFWSGmeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5095214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbeJICCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B4A821479;
        Mon,  8 Oct 2018 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024554;
        bh=3xsmlAiZWSj2MHtwpmhvdc8zVXj6pTszw4KMiVq2fPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFWSGmeZvO40dFAzXlFMjISmUJdgTfDwWqIPIxpPdHh6+Asye9pw5dExS0U3C0g6y
         GXNhj18QUaaIzBsArRmPpYovNGr5VLDmnftHZVM6Hb/8WbnBrkYevlQMBAvSl0o91L
         d6AIiqVrx5q9xKXWllBXqVreI490KYpX6tlh5fQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>
Subject: [PATCH 4.18 078/168] bpf: 32-bit RSH verification must truncate input before the ALU op
Date:   Mon,  8 Oct 2018 20:30:58 +0200
Message-Id: <20181008175623.031212077@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit b799207e1e1816b09e7a5920fbb2d5fcf6edd681 upstream.

When I wrote commit 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification"), I
assumed that, in order to emulate 64-bit arithmetic with 32-bit logic, it
is sufficient to just truncate the output to 32 bits; and so I just moved
the register size coercion that used to be at the start of the function to
the end of the function.

That assumption is true for almost every op, but not for 32-bit right
shifts, because those can propagate information towards the least
significant bit. Fix it by always truncating inputs for 32-bit ops to 32
bits.

Also get rid of the coerce_reg_to_size() after the ALU op, since that has
no effect.

Fixes: 468f6eafa6c4 ("bpf: fix 32-bit ALU op verification")
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bpf/verifier.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2865,6 +2865,15 @@ static int adjust_scalar_min_max_vals(st
 	u64 umin_val, umax_val;
 	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 
+	if (insn_bitness == 32) {
+		/* Relevant for 32-bit RSH: Information can propagate towards
+		 * LSB, so it isn't sufficient to only truncate the output to
+		 * 32 bits.
+		 */
+		coerce_reg_to_size(dst_reg, 4);
+		coerce_reg_to_size(&src_reg, 4);
+	}
+
 	smin_val = src_reg.smin_value;
 	smax_val = src_reg.smax_value;
 	umin_val = src_reg.umin_value;
@@ -3100,7 +3109,6 @@ static int adjust_scalar_min_max_vals(st
 	if (BPF_CLASS(insn->code) != BPF_ALU64) {
 		/* 32-bit ALU ops are (32,32)->32 */
 		coerce_reg_to_size(dst_reg, 4);
-		coerce_reg_to_size(&src_reg, 4);
 	}
 
 	__reg_deduce_bounds(dst_reg);


