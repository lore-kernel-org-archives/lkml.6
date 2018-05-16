Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeEPL2X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:28:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752095AbeEPL2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:28:18 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] selftests: cgroup: memcontrol: add basic test for socket accounting
Date: Wed, 16 May 2018 14:28:09 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18051611-0044-0000-0000-0000055308F7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051611-0045-0000-0000-000028947611
Message-Id: <1526470089-27010-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test verifies that with active TCP traffic memory.current and
memory.stat.sock have similar values.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 184 +++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index beae06c9c899..0efdb1009175 100644
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
@@ -772,6 +778,183 @@ static int test_memcg_oom_events(const char *root)
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
+		if (current < 0)
+			goto close_sk;
+
+		sock = cg_read_key_long(cgroup, "memory.stat", "sock ");
+		if (sock < 0)
+			goto close_sk;
+
+		if (values_close(current, sock, 3)) {
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
+	int bind_retries = 5, ret = KSFT_FAIL, pid, status;
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
+		if (read(args.ctl[0], &ret, sizeof(ret)) != sizeof(ret))
+			goto cleanup;
+		close(args.ctl[0]);
+
+		if (!ret)
+			break;
+		if (ret != EADDRINUSE)
+			goto cleanup;
+
+		waitpid(pid, NULL, 0);
+	}
+
+	if (!ret) {
+		ret = tcp_client(memcg, port);
+
+		waitpid(pid, &status, 0);
+		if (WEXITSTATUS(status))
+			ret = KSFT_FAIL;
+	} else if (ret == EADDRINUSE) {
+		ret = KSFT_SKIP;
+	} else {
+		ret = KSFT_FAIL;
+	}
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
@@ -785,6 +968,7 @@ struct memcg_test {
 	T(test_memcg_max),
 	T(test_memcg_oom_events),
 	T(test_memcg_swap_max),
+	T(test_memcg_sock),
 };
 #undef T
 
-- 
2.7.4
