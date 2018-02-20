Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeBTVRp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:17:45 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:35151 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTVRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:17:43 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: hide a possibly unused variable
Date: Tue, 20 Feb 2018 22:16:45 +0100
Message-Id: <20180220211658.2653840-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:Wd3m1159afi0/gUhNZDvnipyIXg0Lf6DSLG//WQfAWbzdPln2fy
 /86hQ5O1Tsp5jar4AtlASRdJmSxXRVcG3uZW2gZz7wHNS4M7GQL5f4/yzPjgEG8dSyqdMIG
 D5keBu/s3kcq5N14/1h0LqOVrsCjN8CMv1OHekOH6VnHstVYQ0CtEhDoxBDPYYPx3BnxeHF
 g5dKiZr6msVggZOdIX0lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IhdV52ROGsg=:I9N2APto/s7W57vrlI9Uo6
 mBLdV/PfFKzOTacZSt2lF5HoOyggP7pgJdJBAEyJLALlaGUPqTHQZKCbCoOb32cMpGRDOjCIg
 70b7qIQ884m+r/3wJMsOPflLDjkd3tcyOAXtJMnjr7qDfPbAPJ4q393RdSKb3b3lMMViK+yZX
 lb50ZiG8ET/wNzG5o69GHHxyOjx6aJLQ3S/rd2aBh6ZtxR8omj64V69Of8mxnEEhDibJBBv8e
 3YiPxG+s/5ze8fVKCg1NnpnIFK7z8UqsEqLAvXot3XtlAN/ViCEq5e9bJ0QRJBNFVIYKGWggr
 ORZ++T10JPdPyXl1D5ZLu0HLvtt1lyFXuV9GddvAElj103x/Q3lmJS68D9IwtQ7gHUwarum7G
 lEWKQfLsl5H9QSlX9fRRMEhKYzRefpJlgz39H71ioQwMCcnCPEsCobBJDC3zMf3C1Z60lQzW5
 VE/czFSnmkerx2OnyuLHrKFMEh6SoPPAqMfzEpcod5rnzLegZz6JHHvg003Ex54yHp6g+zrtj
 VXelhTJA1qjFxuEAoFmDapxnGeuoL44AMLsNJ2x4yLg9khbpUUyDePGYwWL8avSx6zc+rYnxY
 6Fel0LWkcQ7pD11AWkaGhFLPDaHzug9IK/d7RJyx2PxrTdbi9GMcQBnUe7SuRQNaZZ3o/31qX
 Y1c5Zarxd0Bgo7hFumfhi8Zqz9RltNYxxoMzP7ug6a04tv0DZIoRwhL2cvnZdUXEunIZXM/qm
 SdI5sTAlY5xGP8hbaeI6WWAhOIYShcm83gExcQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of this variable is inside of an #ifdef, causing
a warning without CONFIG_INET:

net/core/filter.c: In function '____bpf_sock_ops_cb_flags_set':
net/core/filter.c:3382:6: error: unused variable 'val' [-Werror=unused-variable]
  int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;

This adds the same #ifdef around the declaration.

Fixes: b13d88072172 ("bpf: Adds field bpf_sock_ops_cb_flags to tcp_sock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 08ab4c65a998..c3dc6d60b4bb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3379,7 +3379,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, argval)
 {
 	struct sock *sk = bpf_sock->sk;
+#ifdef CONFIG_INET
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+#endif
 
 	if (!sk_fullsock(sk))
 		return -EINVAL;
-- 
2.9.0
