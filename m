Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DF8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4B920862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4B920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbeICVxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:53:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47494 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeICVxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:53:31 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2B91CD18;
        Mon,  3 Sep 2018 17:32:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Marc Haber <mh+netdev@zugschlus.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 4.18 022/123] bpf, arm32: fix stack var offset in jit
Date:   Mon,  3 Sep 2018 18:56:06 +0200
Message-Id: <20180903165720.438298034@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

Commit 38ca93060163 ("bpf, arm32: save 4 bytes of unneeded stack
space") messed up STACK_VAR() by 4 bytes presuming it was related
to skb scratch buffer space, but it clearly isn't as this refers
to the top word in stack, therefore restore it. This fixes a NULL
pointer dereference seen during bootup when JIT is enabled and BPF
program run in sk_filter_trim_cap() triggered by systemd-udevd.

JIT rework in 1c35ba122d4a ("ARM: net: bpf: use negative numbers
for stacked registers") and 96cced4e774a ("ARM: net: bpf: access
eBPF scratch space using ARM FP register") removed the affected
parts, so only needed in 4.18 stable.

Fixes: 38ca93060163 ("bpf, arm32: save 4 bytes of unneeded stack space")
Reported-by: Peter Robinson <pbrobinson@gmail.com>
Reported-by: Marc Haber <mh+netdev@zugschlus.de>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm/net/bpf_jit_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -238,7 +238,7 @@ static void jit_fill_hole(void *area, un
 #define STACK_SIZE	ALIGN(_STACK_SIZE, STACK_ALIGNMENT)
 
 /* Get the offset of eBPF REGISTERs stored on scratch space. */
-#define STACK_VAR(off) (STACK_SIZE - off)
+#define STACK_VAR(off) (STACK_SIZE - off - 4)
 
 #if __LINUX_ARM_ARCH__ < 7
 


