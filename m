Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7326FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4285320811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298830;
	bh=pjjKzhySXPSvHH/cV/xYlmDDv5YbG8FjW4npavzuL8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iSwk7ZC8GjGNCrirQLNRLiUHEAOSOSuw36eXD0U85uyoldh3X6Tw28GB5pWvrjKcW
	 UB9GiTWLQsMtvCcfFaKYZEZuK0C7SnDmMoiU4i21dBfuWHXp7qvZwb9ur9V5bHBUtM
	 ECjSd817YkKE82qIBACzQdovV52OWVfOFSjXSZcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbeLTJYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbeLTJYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:24:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D55A217D9;
        Thu, 20 Dec 2018 09:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297879;
        bh=pjjKzhySXPSvHH/cV/xYlmDDv5YbG8FjW4npavzuL8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BffXtd9ZjNq9MyZh+Ar5KnGcPJIH/12S1y7peXn7nc2FxhbxVVk2CgSJflUggK5M7
         mcyTS0nXeQy6ZD4fIkmGtNKhZvB9Ip+vUjJWLvq/68hcjztRZs/7qDT9UDpeMMs8li
         bccABhBhJrjWLD1/bfaXBt/VqlSZ6GPlIeir63U0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Edward Cree <ecree@solarflare.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 50/61] bpf: check pending signals while verifying programs
Date:   Thu, 20 Dec 2018 10:18:50 +0100
Message-Id: <20181220085845.774712211@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
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
index 1438b7396cb4..335c00209f74 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2919,6 +2919,9 @@ static int do_check(struct bpf_verifier_env *env)
 			goto process_bpf_exit;
 		}
 
+		if (signal_pending(current))
+			return -EAGAIN;
+
 		if (need_resched())
 			cond_resched();
 
-- 
2.19.1



