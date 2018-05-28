Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755433AbeE1N4K (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162910AbeE1KlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:41:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 322/329] selftests/net: fixes psock_fanout eBPF test case
Date: Mon, 28 May 2018 12:04:11 +0200
Message-Id: <20180528100307.762307760@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>

[ Upstream commit ddd0010392d9cbcb95b53d11b7cafc67b373ab56 ]

eBPF test fails due to verifier failure because log_buf is too small.
Fixed by increasing log_buf size

Signed-off-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/psock_fanout.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -97,6 +97,8 @@ static int sock_fanout_open(uint16_t typ
 
 static void sock_fanout_set_ebpf(int fd)
 {
+	static char log_buf[65536];
+
 	const int len_off = __builtin_offsetof(struct __sk_buff, len);
 	struct bpf_insn prog[] = {
 		{ BPF_ALU64 | BPF_MOV | BPF_X,   6, 1, 0, 0 },
@@ -109,7 +111,6 @@ static void sock_fanout_set_ebpf(int fd)
 		{ BPF_ALU   | BPF_MOV | BPF_K,   0, 0, 0, 0 },
 		{ BPF_JMP   | BPF_EXIT,          0, 0, 0, 0 }
 	};
-	char log_buf[512];
 	union bpf_attr attr;
 	int pfd;
 
