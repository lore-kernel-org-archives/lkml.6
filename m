Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BEC20449
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298408;
	bh=SfmGX+oyydCwk8zyL2AN8ylbeKXrhpEio5xDJNFaP0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uxgKRZOi2xUZpxjNHplqPrCOqGSIFs4lEFHvIg/23L2qmNXruGkgGelhAs5Zfa2Np
	 kTdBzDIEv3/uHD1jfxUx148luak0QrZeTJLIFsvD01MKpH5DvG9pA1/IfSImz+GC9I
	 MXSHTEjLEqMklGvy/nAu3YitC/rHN1A3PcYrObtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbeLTJd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732908AbeLTJa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F31F12177E;
        Thu, 20 Dec 2018 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298226;
        bh=SfmGX+oyydCwk8zyL2AN8ylbeKXrhpEio5xDJNFaP0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9T6OTNZMMYV8i6FBjbnq/d5oHgw9+jspziUj1uYqFL6a1LzGc//6DJwSP8AnImpu
         H5As20QZf0EUpAAblAvZbmU6nBhpWwB4w2F7lZH4x2z/EQxa5cXXcQRmsuLOYGqe9Q
         3G8QvXjWNygHvLFN9ZPyARNqtcrWQx8Ou3uPJDbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Edward Cree <ecree@solarflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 46/67] bpf: check pending signals while verifying programs
Date:   Thu, 20 Dec 2018 10:18:58 +0100
Message-Id: <20181220085905.365167847@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit c3494801cd1785e2c25f1a5735fa19ddcf9665da ]

Malicious user space may try to force the verifier to use as much cpu
time and memory as possible. Hence check for pending signals
while verifying the program.
Note that suspend of sys_bpf(PROG_LOAD) syscall will lead to EAGAIN,
since the kernel has to release the resources used for program verification.

Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Edward Cree <ecree@solarflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 56acfbb80104..2954e4b3abd5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4792,6 +4792,9 @@ static int do_check(struct bpf_verifier_env *env)
 			goto process_bpf_exit;
 		}
 
+		if (signal_pending(current))
+			return -EAGAIN;
+
 		if (need_resched())
 			cond_resched();
 
-- 
2.19.1



