Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A55C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EE021479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107584;
	bh=M3xdBRGww5er9HDj/rTcJZuyAagwtmdWp/U9raUGM9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Iuzgts5uCwJZIB8R8f8WQr5E4l5OGg2d5jQEc1tzy6fPhM4OkMwDZpuXzus0IS32S
	 SsKM7Ec/VgTlDrnZCJ1M4ZlfWBov4mlzRWJLINCD0YuwPXSi4Ou38iUEWC/XBK5X4e
	 TXsFSsk8QRiBC4/yMkehSBqkVbbrVu+wIAYV7k84=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EE021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbeLFOqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbeLFOqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E4202146D;
        Thu,  6 Dec 2018 14:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107576;
        bh=M3xdBRGww5er9HDj/rTcJZuyAagwtmdWp/U9raUGM9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVkJh6POCR03Y4pJUhFn+52GhVnNkXz6qrFAOHFU+mrEk3xjN1sxTju3iuOs8cN0x
         7ANT6QsAm8+dqRIUj7YHicIUAAHhuDFbz4k1xt4JuxT62we62u23mnXvdkTsrDAcS9
         5zDvpRB4s4n1yZv/dvf11e6hu/F5SXamuF9Pj3Ss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 058/101] bpf/verifier: Add spi variable to check_stack_write()
Date:   Thu,  6 Dec 2018 15:38:57 +0100
Message-Id: <20181206143014.935676158@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

Extracted from commit dc503a8ad984 "bpf/verifier: track liveness for
pruning".

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -543,7 +543,7 @@ static bool is_spillable_regtype(enum bp
 static int check_stack_write(struct bpf_verifier_state *state, int off,
 			     int size, int value_regno)
 {
-	int i;
+	int i, spi = (MAX_BPF_STACK + off) / BPF_REG_SIZE;
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
@@ -558,15 +558,13 @@ static int check_stack_write(struct bpf_
 		}
 
 		/* save register state */
-		state->spilled_regs[(MAX_BPF_STACK + off) / BPF_REG_SIZE] =
-			state->regs[value_regno];
+		state->spilled_regs[spi] = state->regs[value_regno];
 
 		for (i = 0; i < BPF_REG_SIZE; i++)
 			state->stack_slot_type[MAX_BPF_STACK + off + i] = STACK_SPILL;
 	} else {
 		/* regular write of data into stack */
-		state->spilled_regs[(MAX_BPF_STACK + off) / BPF_REG_SIZE] =
-			(struct bpf_reg_state) {};
+		state->spilled_regs[spi] = (struct bpf_reg_state) {};
 
 		for (i = 0; i < size; i++)
 			state->stack_slot_type[MAX_BPF_STACK + off + i] = STACK_MISC;


