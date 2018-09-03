Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E6FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A449920779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A449920779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=polito.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbeICVX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:23:28 -0400
Received: from fm2nodo1.polito.it ([130.192.180.17]:49776 "EHLO
        fm2nodo1.polito.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbeICVX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:23:27 -0400
Received: from polito.it (frontmail2.polito.it [130.192.180.42])
        by fm2nodo1.polito.it  with ESMTP id w83H25JO026335-w83H25JQ026335
        (version=TLSv1.0 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=CAFAIL);
        Mon, 3 Sep 2018 19:02:05 +0200
X-ExtScanner: Niversoft's FindAttachments (free)
Received: from [130.192.225.241] (account d040768@polito.it HELO localhost.localdomain)
  by polito.it (CommuniGate Pro SMTP 6.2.5)
  with ESMTPSA id 78881517; Mon, 03 Sep 2018 19:02:05 +0200
From:   Mauricio Vasquez B <mauricio.vasquez@polito.it>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH bpf] selftests/bpf/test_progs: do not check errno == 0
Date:   Mon,  3 Sep 2018 19:01:59 +0200
Message-Id: <1535994119-4853-1-git-send-email-mauricio.vasquez@polito.it>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The errno man page states: "The value in errno is significant only when
the return value of the call indicated an error..." then it is not correct
to check it, it could be different than zero even if the function
succeeded.

It causes some false positives if errno is set by a previous function.

Signed-off-by: Mauricio Vasquez B <mauricio.vasquez@polito.it>
---
 tools/testing/selftests/bpf/test_progs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 0ef68204c84b..63a671803ed6 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -112,13 +112,13 @@ static void test_pkt_access(void)
 
 	err = bpf_prog_test_run(prog_fd, 100000, &pkt_v4, sizeof(pkt_v4),
 				NULL, NULL, &retval, &duration);
-	CHECK(err || errno || retval, "ipv4",
+	CHECK(err || retval, "ipv4",
 	      "err %d errno %d retval %d duration %d\n",
 	      err, errno, retval, duration);
 
 	err = bpf_prog_test_run(prog_fd, 100000, &pkt_v6, sizeof(pkt_v6),
 				NULL, NULL, &retval, &duration);
-	CHECK(err || errno || retval, "ipv6",
+	CHECK(err || retval, "ipv6",
 	      "err %d errno %d retval %d duration %d\n",
 	      err, errno, retval, duration);
 	bpf_object__close(obj);
@@ -153,14 +153,14 @@ static void test_xdp(void)
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
 
-	CHECK(err || errno || retval != XDP_TX || size != 74 ||
+	CHECK(err || retval != XDP_TX || size != 74 ||
 	      iph->protocol != IPPROTO_IPIP, "ipv4",
 	      "err %d errno %d retval %d size %d\n",
 	      err, errno, retval, size);
 
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
 				buf, &size, &retval, &duration);
-	CHECK(err || errno || retval != XDP_TX || size != 114 ||
+	CHECK(err || retval != XDP_TX || size != 114 ||
 	      iph6->nexthdr != IPPROTO_IPV6, "ipv6",
 	      "err %d errno %d retval %d size %d\n",
 	      err, errno, retval, size);
@@ -185,13 +185,13 @@ static void test_xdp_adjust_tail(void)
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
 
-	CHECK(err || errno || retval != XDP_DROP,
+	CHECK(err || retval != XDP_DROP,
 	      "ipv4", "err %d errno %d retval %d size %d\n",
 	      err, errno, retval, size);
 
 	err = bpf_prog_test_run(prog_fd, 1, &pkt_v6, sizeof(pkt_v6),
 				buf, &size, &retval, &duration);
-	CHECK(err || errno || retval != XDP_TX || size != 54,
+	CHECK(err || retval != XDP_TX || size != 54,
 	      "ipv6", "err %d errno %d retval %d size %d\n",
 	      err, errno, retval, size);
 	bpf_object__close(obj);
@@ -254,14 +254,14 @@ static void test_l4lb(const char *file)
 
 	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
-	CHECK(err || errno || retval != 7/*TC_ACT_REDIRECT*/ || size != 54 ||
+	CHECK(err || retval != 7/*TC_ACT_REDIRECT*/ || size != 54 ||
 	      *magic != MAGIC_VAL, "ipv4",
 	      "err %d errno %d retval %d size %d magic %x\n",
 	      err, errno, retval, size, *magic);
 
 	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v6, sizeof(pkt_v6),
 				buf, &size, &retval, &duration);
-	CHECK(err || errno || retval != 7/*TC_ACT_REDIRECT*/ || size != 74 ||
+	CHECK(err || retval != 7/*TC_ACT_REDIRECT*/ || size != 74 ||
 	      *magic != MAGIC_VAL, "ipv6",
 	      "err %d errno %d retval %d size %d magic %x\n",
 	      err, errno, retval, size, *magic);
@@ -343,14 +343,14 @@ static void test_xdp_noinline(void)
 
 	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v4, sizeof(pkt_v4),
 				buf, &size, &retval, &duration);
-	CHECK(err || errno || retval != 1 || size != 54 ||
+	CHECK(err || retval != 1 || size != 54 ||
 	      *magic != MAGIC_VAL, "ipv4",
 	      "err %d errno %d retval %d size %d magic %x\n",
 	      err, errno, retval, size, *magic);
 
 	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v6, sizeof(pkt_v6),
 				buf, &size, &retval, &duration);
-	CHECK(err || errno || retval != 1 || size != 74 ||
+	CHECK(err || retval != 1 || size != 74 ||
 	      *magic != MAGIC_VAL, "ipv6",
 	      "err %d errno %d retval %d size %d magic %x\n",
 	      err, errno, retval, size, *magic);
-- 
2.7.4

