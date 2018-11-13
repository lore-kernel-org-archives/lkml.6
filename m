Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33493C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45092251A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0jAwG5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45092251A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbeKMPtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732881AbeKMPtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:49:03 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE43322510;
        Tue, 13 Nov 2018 05:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542088355;
        bh=O3jg4NgJzk7rsRQIy5RZoxYXQG7qSISPMntgICFBUaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0jAwG5E76190El1wjfabBvUlRPcL1zLm9g6ig5XnW7aQbcu9O77yADF6soibEl7O
         g1MvIX4+uG1tNydSGuP+WKJ3g8Rl61vu7OpeyUen0osZttlOJ2vTZeFYPjJ4KKqNgP
         wgMXI9Dk0I2nl8gs0t65Gy9togWEgXk/LXxd4aZI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 07/17] um: Give start_idle_thread() a return code
Date:   Tue, 13 Nov 2018 00:52:13 -0500
Message-Id: <20181113055223.79060-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113055223.79060-1-sashal@kernel.org>
References: <20181113055223.79060-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 7ff1e34bbdc15acab823b1ee4240e94623d50ee8 ]

Fixes:
arch/um/os-Linux/skas/process.c:613:1: warning: control reaches end of
non-void function [-Wreturn-type]

longjmp() never returns but gcc still warns that the end of the function
can be reached.
Add a return code and debug aid to detect this impossible case.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/os-Linux/skas/process.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 23025d645160..0a99d4515065 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -578,6 +578,11 @@ int start_idle_thread(void *stack, jmp_buf *switch_buf)
 		fatal_sigsegv();
 	}
 	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	printk(UM_KERN_ERR "impossible long jump!");
+	fatal_sigsegv();
+	return 0;
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
-- 
2.17.1

