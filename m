Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeBTWI3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:08:29 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:52417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeBTWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:08:27 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: clean up unused-variable warning
Date: Tue, 20 Feb 2018 23:07:33 +0100
Message-Id: <20180220220744.305712-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:4lJxEsaYhNarphn7G2JDhV7A/lwM9+CZHf/GHQ+ofBeUnPTUzEw
 NuyrWsW/5I5Vvncjsww9QGK3exb+qlhmoo37Q33+XRK3stxwKK22a/uW2P/tfu6Ni3TOwv2
 b4hRJWwA8EUcazsrdl8k2hbqS2aIora4TmzjtFwbYz+h3odExAaHSJbosMK9KkJOVUp9K1Z
 qAjSoQYU5mVztMi5ZH/JA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PTeBjZDHzvM=:YDA1EXm6GRUtn2xEd12NQf
 HD8kS/ZepYiU/3QZP4vclgD1boz/xdpRjDy+masJrbU/2mWqgtFhsR8N7zgWEE9TGGA4x4pW5
 XuiJRqUW7TNelBJX3YqjxkMrQYlDD9WQ3PrYPgIcxH3ylAyVoh369UG713pqSzgmT4q7z+iZd
 Sxr0MHZm/iWNYisjmPKYaBhbyCgkmwvqdhdsoY3PvHdaYAp7ABKI54GqgdC+HhQBw/tUi9JOt
 8uydqVBea3W4lYuyOcV+hLg0lSiu1eN1q6YH9tBzNl9HRT+1J1/YCAJJqxl7dM0Tu0Gwzr27H
 oilruRb1bYYmN6dRJP79s+b5CxVrBQcqiRNtXPvcjbu52owPVIRK6tS0KFBhMZZcwG0yvFFiR
 ixU7PraoUCrLP4IV74pgKSevX2VJB4N32SyW+JdriNI5XH8CqalHQndi2kJvX0sSt/mhDdsVo
 yxgwUewwjZzpJs44wEiLiRNFjylQbu0N6GQzcmd2uhMx2Wd9XF9xhzL3KYGHHiBs8EMHyhnnr
 UjJs9iEwBaQaF10R2WKiElZXEPvYU4L19G2PTKBZ07KuMJ3j2oUIRz47AgCmPvlcZ0jILgPK8
 9CB9hraC4cg7uEmUl8x8HjncK+rSXzqerTXEQaKQoEXWgbucG5meaBdq6TOch9g33ITDap3ad
 I0NOR6dqBnbfbTkPtUy9yHmrhbgEcjzLDOLtZSOOu7vjQVH+ig1GHRQLdp6xyQj6rgqO/di06
 Ac/ptX3FPH8KcVa0RI0RlSQJiz2KbiIX4gs2YQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of this variable is inside of an #ifdef, causing
a warning without CONFIG_INET:

net/core/filter.c: In function '____bpf_sock_ops_cb_flags_set':
net/core/filter.c:3382:6: error: unused variable 'val' [-Werror=unused-variable]
  int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;

This replaces the #ifdef with a nicer IS_ENABLED() check that
makes the code more readable and avoids the warning.

Fixes: b13d88072172 ("bpf: Adds field bpf_sock_ops_cb_flags to tcp_sock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/core/filter.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 08ab4c65a998..0c121adbdbaa 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3381,17 +3381,13 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
 
-	if (!sk_fullsock(sk))
+	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
 		return -EINVAL;
 
-#ifdef CONFIG_INET
 	if (val)
 		tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
 
 	return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
-#else
-	return -EINVAL;
-#endif
 }
 
 static const struct bpf_func_proto bpf_sock_ops_cb_flags_set_proto = {
-- 
2.9.0
