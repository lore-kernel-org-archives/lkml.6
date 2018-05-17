Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeEQNGE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:06:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44454 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751619AbeEQNF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:05:59 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v2] selftests: cgroup/memcontrol: add basic test for socket accounting
Date: Thu, 17 May 2018 16:05:46 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18051713-0020-0000-0000-0000041E4144
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051713-0021-0000-0000-000042B3641D
Message-Id: <1526562346-27178-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805170121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
v2 changes:
* bumped error percentage for comparing memory.current with memory.stat.sock
* added checks that memory.stat.sock == 0 and memory.current >= 0 after TCP
server exits
* simplified error handling

 tools/testing/selftests/cgroup/test_memcontrol.c | 193 +++++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index beae06c9c899..cf0bddc9d271 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -9,6 +9,12 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <sys/socket.h>
+#include <sys/wait.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <netdb.h>
+#include <errno.h>
 
 #include "../kselftest.h"
 #include "cgroup_util.h"
@@ -772,6 +778,192 @@ static int test_memcg_oom_events(const char *root)
 	return ret;
 }
 
+struct tcp_server_args {
+	unsigned short port;
+	int ctl[2];
+};
+
+static int tcp_server(const char *cgroup, void *arg)
+{
+	struct tcp_server_args *srv_args = arg;
+	struct sockaddr_in6 saddr = { 0 };
+	socklen_t slen = sizeof(saddr);
+	int sk, client_sk, ctl_fd, yes = 1, ret = -1;
+
+	close(srv_args->ctl[0]);
+	ctl_fd = srv_args->ctl[1];
+
+	saddr.sin6_family = AF_INET6;
+	saddr.sin6_addr = in6addr_any;
+	saddr.sin6_port = htons(srv_args->port);
+
+	sk = socket(AF_INET6, SOCK_STREAM, 0);
+	if (sk < 0)
+		return ret;
+
+	if (setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0)
+		goto cleanup;
+
+	if (bind(sk, (struct sockaddr *)&saddr, slen)) {
+		write(ctl_fd, &errno, sizeof(errno));
+		goto cleanup;
+	}
+
+	if (listen(sk, 1))
+		goto cleanup;
+
+	ret = 0;
+	if (write(ctl_fd, &ret, sizeof(ret)) != sizeof(ret)) {
+		ret = -1;
+		goto cleanup;
+	}
+
+	client_sk = accept(sk, NULL, NULL);
+	if (client_sk < 0)
+		goto cleanup;
+
+	ret = -1;
+	for (;;) {
+		uint8_t buf[0x100000];
+
+		if (write(client_sk, buf, sizeof(buf)) <= 0) {
+			if (errno == ECONNRESET)
+				ret = 0;
+			break;
+		}
+	}
+
+	close(client_sk);
+
+cleanup:
+	close(sk);
+	return ret;
+}
+
+static int tcp_client(const char *cgroup, unsigned short port)
+{
+	const char server[] = "localhost";
+	struct addrinfo *ai;
+	char servport[6];
+	int retries = 0x10; /* nice round number */
+	int sk, ret;
+
+	snprintf(servport, sizeof(servport), "%hd", port);
+	ret = getaddrinfo(server, servport, NULL, &ai);
+	if (ret)
+		return ret;
+
+	sk = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
+	if (sk < 0)
+		goto free_ainfo;
+
+	ret = connect(sk, ai->ai_addr, ai->ai_addrlen);
+	if (ret < 0)
+		goto close_sk;
+
+	ret = KSFT_FAIL;
+	while (retries--) {
+		uint8_t buf[0x100000];
+		long current, sock;
+
+		if (read(sk, buf, sizeof(buf)) <= 0)
+			goto close_sk;
+
+		current = cg_read_long(cgroup, "memory.current");
+		sock = cg_read_key_long(cgroup, "memory.stat", "sock ");
+
+		if (current < 0 || sock < 0)
+			goto close_sk;
+
+		if (current < sock)
+			goto close_sk;
+
+		if (values_close(current, sock, 10)) {
+			ret = KSFT_PASS;
+			break;
+		}
+	}
+
+close_sk:
+	close(sk);
+free_ainfo:
+	freeaddrinfo(ai);
+	return ret;
+}
+
+/*
+ * This test checks socket memory accounting.
+ * The test forks a TCP server listens on a random port between 1000
+ * and 61000. Once it gets a client connection, it starts writing to
+ * its socket.
+ * The TCP client interleaves reads from the socket with check whether
+ * memory.current and memory.stat.sock are similar.
+ */
+static int test_memcg_sock(const char *root)
+{
+	int bind_retries = 5, ret = KSFT_FAIL, pid, err;
+	unsigned short port;
+	char *memcg;
+
+	memcg = cg_name(root, "memcg_test");
+	if (!memcg)
+		goto cleanup;
+
+	if (cg_create(memcg))
+		goto cleanup;
+
+	while (bind_retries--) {
+		struct tcp_server_args args;
+
+		if (pipe(args.ctl))
+			goto cleanup;
+
+		port = args.port = 1000 + rand() % 60000;
+
+		pid = cg_run_nowait(memcg, tcp_server, &args);
+		if (pid < 0)
+			goto cleanup;
+
+		close(args.ctl[1]);
+		if (read(args.ctl[0], &err, sizeof(err)) != sizeof(err))
+			goto cleanup;
+		close(args.ctl[0]);
+
+		if (!err)
+			break;
+		if (err != EADDRINUSE)
+			goto cleanup;
+
+		waitpid(pid, NULL, 0);
+	}
+
+	if (err == EADDRINUSE) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	if (tcp_client(memcg, port) != KSFT_PASS)
+		goto cleanup;
+
+	waitpid(pid, &err, 0);
+	if (WEXITSTATUS(err))
+		goto cleanup;
+
+	if (cg_read_long(memcg, "memory.current") < 0)
+		goto cleanup;
+
+	if (cg_read_key_long(memcg, "memory.stat", "sock "))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_destroy(memcg);
+	free(memcg);
+
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct memcg_test {
 	int (*fn)(const char *root);
@@ -785,6 +977,7 @@ struct memcg_test {
 	T(test_memcg_max),
 	T(test_memcg_oom_events),
 	T(test_memcg_swap_max),
+	T(test_memcg_sock),
 };
 #undef T
 
-- 
2.7.4
