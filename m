Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeDYITq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 04:19:46 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33267 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeDYITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 04:19:42 -0400
X-Google-Smtp-Source: AIpwx48yZOwBpGKlwsJ4OfCQ/pU2+9cfLKiE4UYpSe4lnes0ECyuH6GlWoefQjomLdcSEEqBBZ/mAg==
From: Leo Yan <leo.yan@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH bpf-next] bpf: Allow bpf_jit_enable = 2 with BPF_JIT_ALWAYS_ON config
Date: Wed, 25 Apr 2018 16:18:42 +0800
Message-Id: <1524644322-9263-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabled BPF_JIT_ALWAYS_ON config, bpf_jit_enable always equals to
1; it is impossible to set 'bpf_jit_enable = 2' and the kernel has no
chance to call bpf_jit_dump().

This patch relaxes bpf_jit_enable range to [1..2] when kernel config
BPF_JIT_ALWAYS_ON is enabled so can invoke jit dump.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 net/core/sysctl_net_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b1a2c5e..6a39b22 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -371,7 +371,7 @@ static int proc_dointvec_minmax_bpf_enable(struct ctl_table *table, int write,
 		.proc_handler	= proc_dointvec_minmax_bpf_enable,
 # ifdef CONFIG_BPF_JIT_ALWAYS_ON
 		.extra1		= &one,
-		.extra2		= &one,
+		.extra2		= &two,
 # else
 		.extra1		= &zero,
 		.extra2		= &two,
-- 
1.9.1
