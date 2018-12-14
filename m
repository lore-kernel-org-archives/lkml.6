Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A802C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F824214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789812;
	bh=ruSLP9VwaAlmIf5IH/TBC2PwoyjpD3ReN7tdyjKEfZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dTMCl0IhnWlI/YpoKCdVYA1i4LZpzDFfiAgxrkpI8okX6bb4r5vYzh+ZMzpkNCbI8
	 LL9dxeN/B9oqK1kO5l8GZEEcJMx4sfG+P0tkE6t6nE0DM9sg9VIgzyQwnSHlix2vhB
	 Ctd68fuJjooEu5CGbNxzPNiYyirzMdrpubUVTJL8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F824214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbeLNMQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:16:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732816AbeLNMQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2066B21479;
        Fri, 14 Dec 2018 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789806;
        bh=ruSLP9VwaAlmIf5IH/TBC2PwoyjpD3ReN7tdyjKEfZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQzrzl02Lue22tyAJX9Rlquw0Qd1IfY+tSef36dYL0ul/eyXFeZDQEhjPluIGDs1w
         3wjoTQOkx4nEV1fwA/CyXDhdZK7h4/nHIv4b0qOSQ7fGvCMx4iEz3eLuNr3MK75awS
         3qXEcIBkmU9iQX7X1XUxiZNKq8/3LMra6jJr5zEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 63/88] bpf/verifier: Add spi variable to check_stack_write()
Date:   Fri, 14 Dec 2018 13:00:37 +0100
Message-Id: <20181214115707.571996388@linuxfoundation.org>
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
@@ -572,7 +572,7 @@ static bool is_spillable_regtype(enum bp
 static int check_stack_write(struct verifier_state *state, int off, int size,
 			     int value_regno)
 {
-	int i;
+	int i, spi = (MAX_BPF_STACK + off) / BPF_REG_SIZE;
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
@@ -587,15 +587,13 @@ static int check_stack_write(struct veri
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
-			(struct reg_state) {};
+		state->spilled_regs[spi] = (struct reg_state) {};
 
 		for (i = 0; i < size; i++)
 			state->stack_slot_type[MAX_BPF_STACK + off + i] = STACK_MISC;


