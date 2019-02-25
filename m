Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AE120842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131744;
	bh=jYWsgFCd2oX3j0XZASA3IxWZmqDMffAvZ237C2doQ8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xuQybivrTdDVClWQvyCsnF+kMaqJKsQaX8qzzTAF29Zfc5b/Xhrn/qqHlBJLhdh6X
	 4RAKdbUCWyVLQ/fwPLlDb5iUVcXx7RENp8haxMy/MlOWUr72BojV6JGCNNu6m0CCJL
	 U0NKN0b+YjWY0IUnFRIIMKAzpkx2McHHGYWfMi7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfBYVzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730672AbfBYVVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:21:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 247CD21852;
        Mon, 25 Feb 2019 21:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129702;
        bh=jYWsgFCd2oX3j0XZASA3IxWZmqDMffAvZ237C2doQ8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CnlWNxfH8u8R1JKePNByzXYILI+A1suxBtjWSKtfkiYDZyIOLEEYVgZgNLNmUJDqT
         hPNggh9gWDr19IcyxtX5oTI8k0oPKVRu3fA1GSPvGOfOdCwDzb6Vckl4SHdgZQopdu
         Ld0+7WlwzhBNExGEKbZAiI8eaVjDtoEBS21lEHJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ignatov <rdna@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/152] selftests/bpf: Test [::] -> [::1] rewrite in sys_sendmsg in test_sock_addr
Date:   Mon, 25 Feb 2019 22:10:32 +0100
Message-Id: <20190225195046.427823013@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 976b4f3a4646fbf0d189caca25f91f82e4be4b5a ]

Test that sys_sendmsg BPF hook doesn't break sys_sendmsg behaviour to
rewrite destination IPv6 = [::] with [::1] (BSD'ism).

Two test cases are added:

1) User passes dst IPv6 = [::] and BPF_CGROUP_UDP6_SENDMSG program
   doesn't touch it.

2) User passes dst IPv6 != [::], but BPF_CGROUP_UDP6_SENDMSG program
   rewrites it with [::].

In both cases [::1] is used by sys_sendmsg code eventually and datagram
is sent successfully for unconnected UDP socket.

Example of relevant output:
  Test case: sendmsg6: set dst IP = [::] (BSD'ism) .. [PASS]
  Test case: sendmsg6: preserve dst IP = [::] (BSD'ism) .. [PASS]

Signed-off-by: Andrey Ignatov <rdna@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_sock_addr.c | 53 ++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index aeeb76a54d633..e38f1cb7089d3 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -44,6 +44,7 @@
 #define SERV6_V4MAPPED_IP	"::ffff:192.168.0.4"
 #define SRC6_IP			"::1"
 #define SRC6_REWRITE_IP		"::6"
+#define WILDCARD6_IP		"::"
 #define SERV6_PORT		6060
 #define SERV6_REWRITE_PORT	6666
 
@@ -85,12 +86,14 @@ static int bind4_prog_load(const struct sock_addr_test *test);
 static int bind6_prog_load(const struct sock_addr_test *test);
 static int connect4_prog_load(const struct sock_addr_test *test);
 static int connect6_prog_load(const struct sock_addr_test *test);
+static int sendmsg_allow_prog_load(const struct sock_addr_test *test);
 static int sendmsg_deny_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_c_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_c_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test);
+static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test);
 
 static struct sock_addr_test tests[] = {
 	/* bind */
@@ -462,6 +465,34 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SYSCALL_ENOTSUPP,
 	},
+	{
+		"sendmsg6: set dst IP = [::] (BSD'ism)",
+		sendmsg6_rw_wildcard_prog_load,
+		BPF_CGROUP_UDP6_SENDMSG,
+		BPF_CGROUP_UDP6_SENDMSG,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+		SUCCESS,
+	},
+	{
+		"sendmsg6: preserve dst IP = [::] (BSD'ism)",
+		sendmsg_allow_prog_load,
+		BPF_CGROUP_UDP6_SENDMSG,
+		BPF_CGROUP_UDP6_SENDMSG,
+		AF_INET6,
+		SOCK_DGRAM,
+		WILDCARD6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_PORT,
+		SRC6_IP,
+		SUCCESS,
+	},
 	{
 		"sendmsg6: deny call",
 		sendmsg_deny_prog_load,
@@ -714,16 +745,27 @@ static int connect6_prog_load(const struct sock_addr_test *test)
 	return load_path(test, CONNECT6_PROG_PATH);
 }
 
-static int sendmsg_deny_prog_load(const struct sock_addr_test *test)
+static int sendmsg_ret_only_prog_load(const struct sock_addr_test *test,
+				      int32_t rc)
 {
 	struct bpf_insn insns[] = {
-		/* return 0 */
-		BPF_MOV64_IMM(BPF_REG_0, 0),
+		/* return rc */
+		BPF_MOV64_IMM(BPF_REG_0, rc),
 		BPF_EXIT_INSN(),
 	};
 	return load_insns(test, insns, sizeof(insns) / sizeof(struct bpf_insn));
 }
 
+static int sendmsg_allow_prog_load(const struct sock_addr_test *test)
+{
+	return sendmsg_ret_only_prog_load(test, /*rc*/ 1);
+}
+
+static int sendmsg_deny_prog_load(const struct sock_addr_test *test)
+{
+	return sendmsg_ret_only_prog_load(test, /*rc*/ 0);
+}
+
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 {
 	struct sockaddr_in dst4_rw_addr;
@@ -844,6 +886,11 @@ static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test)
 	return sendmsg6_rw_dst_asm_prog_load(test, SERV6_V4MAPPED_IP);
 }
 
+static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test)
+{
+	return sendmsg6_rw_dst_asm_prog_load(test, WILDCARD6_IP);
+}
+
 static int sendmsg6_rw_c_prog_load(const struct sock_addr_test *test)
 {
 	return load_path(test, SENDMSG6_PROG_PATH);
-- 
2.19.1



