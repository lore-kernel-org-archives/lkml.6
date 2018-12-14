Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CA4C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEFC2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789888;
	bh=NJHspLz/WGWcC50f9uFlHL510jE5InGCIq2y+4Y58ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hwH6noSHVmLXJQRLIolROXj8M4FxpFAAJGEJlfdtI8aHa5ePnNn9iM1g9+cHJDZ+p
	 HwwZfOh9x10AUJPsA4C6jx7LnkUhJxqUofJyFL8fz3l8R/MelTzvfTbyN1FZQjtw/R
	 K2Y8EIt5dzgwqftyL9xQbZnq8npbJdOq4SIbEmUU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEFC2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732725AbeLNMSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:18:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:36956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732810AbeLNMQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35152148E;
        Fri, 14 Dec 2018 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789804;
        bh=NJHspLz/WGWcC50f9uFlHL510jE5InGCIq2y+4Y58ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uE3wLUknvHkytto3/nhXg20NqTPx/mdKwhKT5jG5tPeAjvFUfzUZXdslFVZik85E2
         LxrOiwauJ7dpE5gcYnBoEtgw+vqU1favrTtn96a5n/+6WG+shmAMhEQ3xcRiyijc4U
         nQKxGH8B32GEEOoITyqHI9Ahd8uv81BSKkot34yQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 62/88] bpf: support 8-byte metafield access
Date:   Fri, 14 Dec 2018 13:00:36 +0100
Message-Id: <20181214115707.501910891@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@fb.com>

commit cedaf52693f02372010548c63b2e63228b959099 upstream.

The verifier supported only 4-byte metafields in
struct __sk_buff and struct xdp_md. The metafields in upcoming
struct bpf_perf_event are 8-byte to match register width in struct pt_regs.
Teach verifier to recognize 8-byte metafield access.
The patch doesn't affect safety of sockets and xdp programs.
They check for 4-byte only ctx access before these conditions are hit.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1844,7 +1844,8 @@ static int do_check(struct verifier_env
 			if (err)
 				return err;
 
-			if (BPF_SIZE(insn->code) != BPF_W) {
+			if (BPF_SIZE(insn->code) != BPF_W &&
+			    BPF_SIZE(insn->code) != BPF_DW) {
 				insn_idx++;
 				continue;
 			}
@@ -2220,9 +2221,11 @@ static int convert_ctx_accesses(struct v
 	for (i = 0; i < insn_cnt; i++, insn++) {
 		u32 cnt;
 
-		if (insn->code == (BPF_LDX | BPF_MEM | BPF_W))
+		if (insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
+		    insn->code == (BPF_LDX | BPF_MEM | BPF_DW))
 			type = BPF_READ;
-		else if (insn->code == (BPF_STX | BPF_MEM | BPF_W))
+		else if (insn->code == (BPF_STX | BPF_MEM | BPF_W) ||
+			 insn->code == (BPF_STX | BPF_MEM | BPF_DW))
 			type = BPF_WRITE;
 		else
 			continue;


