Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeA3Uzr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:55:47 -0500
Received: from home.regit.org ([37.187.126.138]:37364 "EHLO home.regit.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753322AbeA3Uze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:55:34 -0500
From: Eric Leblond <eric@regit.org>
To: daniel@iogearbox.net
Cc: alexei.starovoitov@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Leblond <eric@regit.org>
Subject: [PATCH bpf-next v8 5/5] samples/bpf: use bpf_set_link_xdp_fd
Date: Tue, 30 Jan 2018 21:55:04 +0100
Message-Id: <20180130205504.20826-5-eric@regit.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180130205504.20826-1-eric@regit.org>
References: <a26f90e9-5028-f8a9-a1e6-83a6c46b4e0b@iogearbox.net>
 <20180130205504.20826-1-eric@regit.org>
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bpf_set_link_xdp_fd instead of set_link_xdp_fd to remove some
code duplication and benefit of netlink ext ack errors message.

Signed-off-by: Eric Leblond <eric@regit.org>
---
 samples/bpf/bpf_load.c              | 102 ------------------------------------
 samples/bpf/bpf_load.h              |   2 +-
 samples/bpf/xdp1_user.c             |   4 +-
 samples/bpf/xdp_redirect_cpu_user.c |   6 +--
 samples/bpf/xdp_redirect_map_user.c |   8 +--
 samples/bpf/xdp_redirect_user.c     |   8 +--
 samples/bpf/xdp_router_ipv4_user.c  |  10 ++--
 samples/bpf/xdp_rxq_info_user.c     |   4 +-
 samples/bpf/xdp_tx_iptunnel_user.c  |   6 +--
 9 files changed, 24 insertions(+), 126 deletions(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index 242631aa4ea2..69806d74fa53 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -695,105 +695,3 @@ struct ksym *ksym_search(long key)
 	return &syms[0];
 }
 
-int set_link_xdp_fd(int ifindex, int fd, __u32 flags)
-{
-	struct sockaddr_nl sa;
-	int sock, seq = 0, len, ret = -1;
-	char buf[4096];
-	struct nlattr *nla, *nla_xdp;
-	struct {
-		struct nlmsghdr  nh;
-		struct ifinfomsg ifinfo;
-		char             attrbuf[64];
-	} req;
-	struct nlmsghdr *nh;
-	struct nlmsgerr *err;
-
-	memset(&sa, 0, sizeof(sa));
-	sa.nl_family = AF_NETLINK;
-
-	sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
-	if (sock < 0) {
-		printf("open netlink socket: %s\n", strerror(errno));
-		return -1;
-	}
-
-	if (bind(sock, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
-		printf("bind to netlink: %s\n", strerror(errno));
-		goto cleanup;
-	}
-
-	memset(&req, 0, sizeof(req));
-	req.nh.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg));
-	req.nh.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
-	req.nh.nlmsg_type = RTM_SETLINK;
-	req.nh.nlmsg_pid = 0;
-	req.nh.nlmsg_seq = ++seq;
-	req.ifinfo.ifi_family = AF_UNSPEC;
-	req.ifinfo.ifi_index = ifindex;
-
-	/* started nested attribute for XDP */
-	nla = (struct nlattr *)(((char *)&req)
-				+ NLMSG_ALIGN(req.nh.nlmsg_len));
-	nla->nla_type = NLA_F_NESTED | 43/*IFLA_XDP*/;
-	nla->nla_len = NLA_HDRLEN;
-
-	/* add XDP fd */
-	nla_xdp = (struct nlattr *)((char *)nla + nla->nla_len);
-	nla_xdp->nla_type = 1/*IFLA_XDP_FD*/;
-	nla_xdp->nla_len = NLA_HDRLEN + sizeof(int);
-	memcpy((char *)nla_xdp + NLA_HDRLEN, &fd, sizeof(fd));
-	nla->nla_len += nla_xdp->nla_len;
-
-	/* if user passed in any flags, add those too */
-	if (flags) {
-		nla_xdp = (struct nlattr *)((char *)nla + nla->nla_len);
-		nla_xdp->nla_type = 3/*IFLA_XDP_FLAGS*/;
-		nla_xdp->nla_len = NLA_HDRLEN + sizeof(flags);
-		memcpy((char *)nla_xdp + NLA_HDRLEN, &flags, sizeof(flags));
-		nla->nla_len += nla_xdp->nla_len;
-	}
-
-	req.nh.nlmsg_len += NLA_ALIGN(nla->nla_len);
-
-	if (send(sock, &req, req.nh.nlmsg_len, 0) < 0) {
-		printf("send to netlink: %s\n", strerror(errno));
-		goto cleanup;
-	}
-
-	len = recv(sock, buf, sizeof(buf), 0);
-	if (len < 0) {
-		printf("recv from netlink: %s\n", strerror(errno));
-		goto cleanup;
-	}
-
-	for (nh = (struct nlmsghdr *)buf; NLMSG_OK(nh, len);
-	     nh = NLMSG_NEXT(nh, len)) {
-		if (nh->nlmsg_pid != getpid()) {
-			printf("Wrong pid %d, expected %d\n",
-			       nh->nlmsg_pid, getpid());
-			goto cleanup;
-		}
-		if (nh->nlmsg_seq != seq) {
-			printf("Wrong seq %d, expected %d\n",
-			       nh->nlmsg_seq, seq);
-			goto cleanup;
-		}
-		switch (nh->nlmsg_type) {
-		case NLMSG_ERROR:
-			err = (struct nlmsgerr *)NLMSG_DATA(nh);
-			if (!err->error)
-				continue;
-			printf("nlmsg error %s\n", strerror(-err->error));
-			goto cleanup;
-		case NLMSG_DONE:
-			break;
-		}
-	}
-
-	ret = 0;
-
-cleanup:
-	close(sock);
-	return ret;
-}
diff --git a/samples/bpf/bpf_load.h b/samples/bpf/bpf_load.h
index 7d57a4248893..453c200b389b 100644
--- a/samples/bpf/bpf_load.h
+++ b/samples/bpf/bpf_load.h
@@ -61,5 +61,5 @@ struct ksym {
 
 int load_kallsyms(void);
 struct ksym *ksym_search(long key);
-int set_link_xdp_fd(int ifindex, int fd, __u32 flags);
+int bpf_set_link_xdp_fd(int ifindex, int fd, __u32 flags);
 #endif
diff --git a/samples/bpf/xdp1_user.c b/samples/bpf/xdp1_user.c
index fdaefe91801d..b901ee2b3336 100644
--- a/samples/bpf/xdp1_user.c
+++ b/samples/bpf/xdp1_user.c
@@ -25,7 +25,7 @@ static __u32 xdp_flags;
 
 static void int_exit(int sig)
 {
-	set_link_xdp_fd(ifindex, -1, xdp_flags);
+	bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
 	exit(0);
 }
 
@@ -116,7 +116,7 @@ int main(int argc, char **argv)
 	signal(SIGINT, int_exit);
 	signal(SIGTERM, int_exit);
 
-	if (set_link_xdp_fd(ifindex, prog_fd[0], xdp_flags) < 0) {
+	if (bpf_set_link_xdp_fd(ifindex, prog_fd[0], xdp_flags) < 0) {
 		printf("link set xdp fd failed\n");
 		return 1;
 	}
diff --git a/samples/bpf/xdp_redirect_cpu_user.c b/samples/bpf/xdp_redirect_cpu_user.c
index 35fec9fecb57..23744a8aaf21 100644
--- a/samples/bpf/xdp_redirect_cpu_user.c
+++ b/samples/bpf/xdp_redirect_cpu_user.c
@@ -26,7 +26,7 @@ static const char *__doc__ =
 
 /* Wanted to get rid of bpf_load.h and fake-"libbpf.h" (and instead
  * use bpf/libbpf.h), but cannot as (currently) needed for XDP
- * attaching to a device via set_link_xdp_fd()
+ * attaching to a device via bpf_set_link_xdp_fd()
  */
 #include "libbpf.h"
 #include "bpf_load.h"
@@ -67,7 +67,7 @@ static void int_exit(int sig)
 		"Interrupted: Removing XDP program on ifindex:%d device:%s\n",
 		ifindex, ifname);
 	if (ifindex > -1)
-		set_link_xdp_fd(ifindex, -1, xdp_flags);
+		bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
 	exit(EXIT_OK);
 }
 
@@ -682,7 +682,7 @@ int main(int argc, char **argv)
 	/* Remove XDP program when program is interrupted */
 	signal(SIGINT, int_exit);
 
-	if (set_link_xdp_fd(ifindex, prog_fd[prog_num], xdp_flags) < 0) {
+	if (bpf_set_link_xdp_fd(ifindex, prog_fd[prog_num], xdp_flags) < 0) {
 		fprintf(stderr, "link set xdp fd failed\n");
 		return EXIT_FAIL_XDP;
 	}
diff --git a/samples/bpf/xdp_redirect_map_user.c b/samples/bpf/xdp_redirect_map_user.c
index 978a532f0748..7eae07d7293e 100644
--- a/samples/bpf/xdp_redirect_map_user.c
+++ b/samples/bpf/xdp_redirect_map_user.c
@@ -34,9 +34,9 @@ static __u32 xdp_flags;
 
 static void int_exit(int sig)
 {
-	set_link_xdp_fd(ifindex_in, -1, xdp_flags);
+	bpf_set_link_xdp_fd(ifindex_in, -1, xdp_flags);
 	if (ifindex_out_xdp_dummy_attached)
-		set_link_xdp_fd(ifindex_out, -1, xdp_flags);
+		bpf_set_link_xdp_fd(ifindex_out, -1, xdp_flags);
 	exit(0);
 }
 
@@ -120,13 +120,13 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (set_link_xdp_fd(ifindex_in, prog_fd[0], xdp_flags) < 0) {
+	if (bpf_set_link_xdp_fd(ifindex_in, prog_fd[0], xdp_flags) < 0) {
 		printf("ERROR: link set xdp fd failed on %d\n", ifindex_in);
 		return 1;
 	}
 
 	/* Loading dummy XDP prog on out-device */
-	if (set_link_xdp_fd(ifindex_out, prog_fd[1],
+	if (bpf_set_link_xdp_fd(ifindex_out, prog_fd[1],
 			    (xdp_flags | XDP_FLAGS_UPDATE_IF_NOEXIST)) < 0) {
 		printf("WARN: link set xdp fd failed on %d\n", ifindex_out);
 		ifindex_out_xdp_dummy_attached = false;
diff --git a/samples/bpf/xdp_redirect_user.c b/samples/bpf/xdp_redirect_user.c
index 4475d837bf2c..d54e91eb6cbf 100644
--- a/samples/bpf/xdp_redirect_user.c
+++ b/samples/bpf/xdp_redirect_user.c
@@ -33,9 +33,9 @@ static __u32 xdp_flags;
 
 static void int_exit(int sig)
 {
-	set_link_xdp_fd(ifindex_in, -1, xdp_flags);
+	bpf_set_link_xdp_fd(ifindex_in, -1, xdp_flags);
 	if (ifindex_out_xdp_dummy_attached)
-		set_link_xdp_fd(ifindex_out, -1, xdp_flags);
+		bpf_set_link_xdp_fd(ifindex_out, -1, xdp_flags);
 	exit(0);
 }
 
@@ -114,13 +114,13 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	if (set_link_xdp_fd(ifindex_in, prog_fd[0], xdp_flags) < 0) {
+	if (bpf_set_link_xdp_fd(ifindex_in, prog_fd[0], xdp_flags) < 0) {
 		printf("ERROR: link set xdp fd failed on %d\n", ifindex_in);
 		return 1;
 	}
 
 	/* Loading dummy XDP prog on out-device */
-	if (set_link_xdp_fd(ifindex_out, prog_fd[1],
+	if (bpf_set_link_xdp_fd(ifindex_out, prog_fd[1],
 			    (xdp_flags | XDP_FLAGS_UPDATE_IF_NOEXIST)) < 0) {
 		printf("WARN: link set xdp fd failed on %d\n", ifindex_out);
 		ifindex_out_xdp_dummy_attached = false;
diff --git a/samples/bpf/xdp_router_ipv4_user.c b/samples/bpf/xdp_router_ipv4_user.c
index 916462112d55..6296741c1fbd 100644
--- a/samples/bpf/xdp_router_ipv4_user.c
+++ b/samples/bpf/xdp_router_ipv4_user.c
@@ -37,7 +37,7 @@ static void int_exit(int sig)
 	int i = 0;
 
 	for (i = 0; i < total_ifindex; i++)
-		set_link_xdp_fd(ifindex_list[i], -1, flags);
+		bpf_set_link_xdp_fd(ifindex_list[i], -1, flags);
 	exit(0);
 }
 
@@ -49,7 +49,7 @@ static void close_and_exit(int sig)
 	close(sock_arp);
 
 	for (i = 0; i < total_ifindex; i++)
-		set_link_xdp_fd(ifindex_list[i], -1, flags);
+		bpf_set_link_xdp_fd(ifindex_list[i], -1, flags);
 	exit(0);
 }
 
@@ -183,7 +183,7 @@ static void read_route(struct nlmsghdr *nh, int nll)
 			int i = 0;
 
 			for (i = 0; i < total_ifindex; i++)
-				set_link_xdp_fd(ifindex_list[i], -1, flags);
+				bpf_set_link_xdp_fd(ifindex_list[i], -1, flags);
 			exit(0);
 		}
 		assert(bpf_map_update_elem(map_fd[4], &route.iface, &route.iface, 0) == 0);
@@ -633,12 +633,12 @@ int main(int ac, char **argv)
 		}
 	}
 	for (i = 0; i < total_ifindex; i++) {
-		if (set_link_xdp_fd(ifindex_list[i], prog_fd[0], flags) < 0) {
+		if (bpf_set_link_xdp_fd(ifindex_list[i], prog_fd[0], flags) < 0) {
 			printf("link set xdp fd failed\n");
 			int recovery_index = i;
 
 			for (i = 0; i < recovery_index; i++)
-				set_link_xdp_fd(ifindex_list[i], -1, flags);
+				bpf_set_link_xdp_fd(ifindex_list[i], -1, flags);
 
 			return 1;
 		}
diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_user.c
index 32430e8b3a6a..478d95412de4 100644
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -56,7 +56,7 @@ static void int_exit(int sig)
 		"Interrupted: Removing XDP program on ifindex:%d device:%s\n",
 		ifindex, ifname);
 	if (ifindex > -1)
-		set_link_xdp_fd(ifindex, -1, xdp_flags);
+		bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
 	exit(EXIT_OK);
 }
 
@@ -521,7 +521,7 @@ int main(int argc, char **argv)
 	/* Remove XDP program when program is interrupted */
 	signal(SIGINT, int_exit);
 
-	if (set_link_xdp_fd(ifindex, prog_fd[0], xdp_flags) < 0) {
+	if (bpf_set_link_xdp_fd(ifindex, prog_fd[0], xdp_flags) < 0) {
 		fprintf(stderr, "link set xdp fd failed\n");
 		return EXIT_FAIL_XDP;
 	}
diff --git a/samples/bpf/xdp_tx_iptunnel_user.c b/samples/bpf/xdp_tx_iptunnel_user.c
index 715cd12eaca5..f0a787268a87 100644
--- a/samples/bpf/xdp_tx_iptunnel_user.c
+++ b/samples/bpf/xdp_tx_iptunnel_user.c
@@ -30,7 +30,7 @@ static __u32 xdp_flags = 0;
 static void int_exit(int sig)
 {
 	if (ifindex > -1)
-		set_link_xdp_fd(ifindex, -1, xdp_flags);
+		bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
 	exit(0);
 }
 
@@ -254,14 +254,14 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (set_link_xdp_fd(ifindex, prog_fd[0], xdp_flags) < 0) {
+	if (bpf_set_link_xdp_fd(ifindex, prog_fd[0], xdp_flags) < 0) {
 		printf("link set xdp fd failed\n");
 		return 1;
 	}
 
 	poll_stats(kill_after_s);
 
-	set_link_xdp_fd(ifindex, -1, xdp_flags);
+	bpf_set_link_xdp_fd(ifindex, -1, xdp_flags);
 
 	return 0;
 }
-- 
2.15.1
