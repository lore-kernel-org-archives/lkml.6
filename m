Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E438C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E2020870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676451;
	bh=KW4z1bgq6eQp5xJ3wJyepnskVMAquAF/2ehkHFnMcw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GXSdZQwBQ6ar/JDk5cfrt1ULxgp2NEI58hyg0LdDJVUqJhXNEDZM2zTY0ziFzPkKt
	 ea2jE90ZOFljsp5r2Ub9q+UZ+GoD+MmoJdCjRf5o3roYtauxvR/0wyvISrTKJNCArd
	 i4KSOOdqVvA+VGM6ZSXbyIpk2+2NNopES06CCFCM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E2020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeLMEra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbeLMEaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A5B20873;
        Thu, 13 Dec 2018 04:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675411;
        bh=KW4z1bgq6eQp5xJ3wJyepnskVMAquAF/2ehkHFnMcw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRk373K9bZH9+iVLdoYXDRQmFd00WZMSWqgHv2+CJBIwJyhfqd38oIR+7tJRteqR6
         cMLLRbpMQiGX0fLHjt7LLuXZ1kvXiJ0rVx7PGmCPk6KDWqJCgMos+ulGwiVPKXqFls
         ce4PVQ1BapQf4XPvairuavyIiY+7AqmjeLy3WZp8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 50/73] bpf: check pending signals while verifying programs
Date:   Wed, 12 Dec 2018 23:28:15 -0500
Message-Id: <20181213042838.75160-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

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
index 5780876ac81a..a320e6587dd3 100644
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

