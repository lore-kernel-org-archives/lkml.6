Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeDYVn2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:43:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39658 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753344AbeDYVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:43:23 -0400
X-Google-Smtp-Source: AIpwx4/ps8dW7epmzIP0kw9IZJQ6fNz6gsQosG+JT+3INMAmIprx6IGYxLVzls36ClMP3/5qC3xVMg==
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
Subject: [PATCH v2 net-next 2/2] selftests: net: tcp_mmap must use TCP_ZEROCOPY_RECEIVE
Date: Wed, 25 Apr 2018 14:43:07 -0700
Message-Id: <20180425214307.159264-3-edumazet@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180425214307.159264-1-edumazet@google.com>
References: <20180425214307.159264-1-edumazet@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After prior kernel change, mmap() on TCP socket only reserves VMA.

We have to use setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE, ...)
to perform the transfert of pages from skbs in TCP receive queue into such VMA.

struct tcp_zerocopy_receive {
	__u64 address;		/* in: address of mapping */
	__u32 length;		/* in/out: number of bytes to map/mapped */
	__u32 recv_skip_hint;	/* out: amount of bytes to skip */
};

After a successful setsockopt(...TCP_ZEROCOPY_RECEIVE...), @length contains
number of bytes that were mapped, and @recv_skip_hint contains number of bytes
that should be read using conventional read()/recv()/recvmsg() system calls,
to skip a sequence of bytes that can not be mapped, because not properly page
aligned.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
---
 tools/testing/selftests/net/tcp_mmap.c | 63 +++++++++++++++-----------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_mmap.c b/tools/testing/selftests/net/tcp_mmap.c
index dea342fe6f4e88b5709d2ac37b2fc9a2a320bf44..5b381cdbdd6319556ba4e3dad530fae8f13f5a9b 100644
--- a/tools/testing/selftests/net/tcp_mmap.c
+++ b/tools/testing/selftests/net/tcp_mmap.c
@@ -76,9 +76,10 @@
 #include <time.h>
 #include <sys/time.h>
 #include <netinet/in.h>
-#include <netinet/tcp.h>
 #include <arpa/inet.h>
 #include <poll.h>
+#include <linux/tcp.h>
+#include <assert.h>
 
 #ifndef MSG_ZEROCOPY
 #define MSG_ZEROCOPY    0x4000000
@@ -134,11 +135,12 @@ void hash_zone(void *zone, unsigned int length)
 void *child_thread(void *arg)
 {
 	unsigned long total_mmap = 0, total = 0;
+	struct tcp_zerocopy_receive zc;
 	unsigned long delta_usec;
 	int flags = MAP_SHARED;
 	struct timeval t0, t1;
 	char *buffer = NULL;
-	void *oaddr = NULL;
+	void *addr = NULL;
 	double throughput;
 	struct rusage ru;
 	int lu, fd;
@@ -153,41 +155,45 @@ void *child_thread(void *arg)
 		perror("malloc");
 		goto error;
 	}
+	if (zflg) {
+		addr = mmap(NULL, chunk_size, PROT_READ, flags, fd, 0);
+		if (addr == (void *)-1)
+			zflg = 0;
+	}
 	while (1) {
 		struct pollfd pfd = { .fd = fd, .events = POLLIN, };
 		int sub;
 
 		poll(&pfd, 1, 10000);
 		if (zflg) {
-			void *naddr;
+			int res;
 
-			naddr = mmap(oaddr, chunk_size, PROT_READ, flags, fd, 0);
-			if (naddr == (void *)-1) {
-				if (errno == EAGAIN) {
-					/* That is if SO_RCVLOWAT is buggy */
-					usleep(1000);
-					continue;
-				}
-				if (errno == EINVAL) {
-					flags = MAP_SHARED;
-					oaddr = NULL;
-					goto fallback;
-				}
-				if (errno != EIO)
-					perror("mmap()");
+			zc.address = (__u64)addr;
+			zc.length = chunk_size;
+			zc.recv_skip_hint = 0;
+			res = setsockopt(fd, IPPROTO_TCP, TCP_ZEROCOPY_RECEIVE,
+					 &zc, sizeof(zc));
+			if (res == -1)
 				break;
+
+			if (zc.length) {
+				assert(zc.length <= chunk_size);
+				total_mmap += zc.length;
+				if (xflg)
+					hash_zone(addr, zc.length);
+				total += zc.length;
 			}
-			total_mmap += chunk_size;
-			if (xflg)
-				hash_zone(naddr, chunk_size);
-			total += chunk_size;
-			if (!keepflag) {
-				flags |= MAP_FIXED;
-				oaddr = naddr;
+			if (zc.recv_skip_hint) {
+				assert(zc.recv_skip_hint <= chunk_size);
+				lu = read(fd, buffer, zc.recv_skip_hint);
+				if (lu > 0) {
+					if (xflg)
+						hash_zone(buffer, lu);
+					total += lu;
+				}
 			}
 			continue;
 		}
-fallback:
 		sub = 0;
 		while (sub < chunk_size) {
 			lu = read(fd, buffer + sub, chunk_size - sub);
@@ -228,6 +234,8 @@ void *child_thread(void *arg)
 error:
 	free(buffer);
 	close(fd);
+	if (zflg)
+		munmap(addr, chunk_size);
 	pthread_exit(0);
 }
 
@@ -371,7 +379,8 @@ int main(int argc, char *argv[])
 		setup_sockaddr(cfg_family, host, &listenaddr);
 
 		if (mss &&
-		    setsockopt(fdlisten, SOL_TCP, TCP_MAXSEG, &mss, sizeof(mss)) == -1) {
+		    setsockopt(fdlisten, IPPROTO_TCP, TCP_MAXSEG,
+			       &mss, sizeof(mss)) == -1) {
 			perror("setsockopt TCP_MAXSEG");
 			exit(1);
 		}
@@ -402,7 +411,7 @@ int main(int argc, char *argv[])
 	setup_sockaddr(cfg_family, host, &addr);
 
 	if (mss &&
-	    setsockopt(fd, SOL_TCP, TCP_MAXSEG, &mss, sizeof(mss)) == -1) {
+	    setsockopt(fd, IPPROTO_TCP, TCP_MAXSEG, &mss, sizeof(mss)) == -1) {
 		perror("setsockopt TCP_MAXSEG");
 		exit(1);
 	}
-- 
2.17.0.441.gb46fe60e1d-goog
