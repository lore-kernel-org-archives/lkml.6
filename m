Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161135AbeE1Kai (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161117AbeE1Kab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:30:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Naresh Kamboju <naresh.kamboju@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 097/329] bpf: fix rlimit in reuseport net selftest
Date: Mon, 28 May 2018 12:00:26 +0200
Message-Id: <20180528100250.891100222@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 941ff6f11c020913f5cddf543a9ec63475d7c082 ]

Fix two issues in the reuseport_bpf selftests that were
reported by Linaro CI:

  [...]
  + ./reuseport_bpf
  ---- IPv4 UDP ----
  Testing EBPF mod 10...
  Reprograming, testing mod 5...
  ./reuseport_bpf: ebpf error. log:
  0: (bf) r6 = r1
  1: (20) r0 = *(u32 *)skb[0]
  2: (97) r0 %= 10
  3: (95) exit
  processed 4 insns
  : Operation not permitted
  + echo FAIL
  [...]
  ---- IPv4 TCP ----
  Testing EBPF mod 10...
  ./reuseport_bpf: failed to bind send socket: Address already in use
  + echo FAIL
  [...]

For the former adjust rlimit since this was the cause of
failure for loading the BPF prog, and for the latter add
SO_REUSEADDR.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://bugs.linaro.org/show_bug.cgi?id=3502
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/reuseport_bpf.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/reuseport_bpf.c
+++ b/tools/testing/selftests/net/reuseport_bpf.c
@@ -21,6 +21,7 @@
 #include <sys/epoll.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <sys/resource.h>
 #include <unistd.h>
 
 #ifndef ARRAY_SIZE
@@ -190,11 +191,14 @@ static void send_from(struct test_params
 	struct sockaddr * const saddr = new_any_sockaddr(p.send_family, sport);
 	struct sockaddr * const daddr =
 		new_loopback_sockaddr(p.send_family, p.recv_port);
-	const int fd = socket(p.send_family, p.protocol, 0);
+	const int fd = socket(p.send_family, p.protocol, 0), one = 1;
 
 	if (fd < 0)
 		error(1, errno, "failed to create send socket");
 
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)))
+		error(1, errno, "failed to set reuseaddr");
+
 	if (bind(fd, saddr, sockaddr_size()))
 		error(1, errno, "failed to bind send socket");
 
@@ -433,6 +437,21 @@ void enable_fastopen(void)
 	}
 }
 
+static struct rlimit rlim_old, rlim_new;
+
+static  __attribute__((constructor)) void main_ctor(void)
+{
+	getrlimit(RLIMIT_MEMLOCK, &rlim_old);
+	rlim_new.rlim_cur = rlim_old.rlim_cur + (1UL << 20);
+	rlim_new.rlim_max = rlim_old.rlim_max + (1UL << 20);
+	setrlimit(RLIMIT_MEMLOCK, &rlim_new);
+}
+
+static __attribute__((destructor)) void main_dtor(void)
+{
+	setrlimit(RLIMIT_MEMLOCK, &rlim_old);
+}
+
 int main(void)
 {
 	fprintf(stderr, "---- IPv4 UDP ----\n");
