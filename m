Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E190EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910682145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910682145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbeIXRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:49:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbeIXRia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:38:30 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B8A41061;
        Mon, 24 Sep 2018 11:36:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Gustavo Romero <gromero@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 019/105] selftests/powerpc: Kill child processes on SIGINT
Date:   Mon, 24 Sep 2018 13:33:05 +0200
Message-Id: <20180924113115.467861231@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 7c27a26e1ed5a7dd709aa19685d2c98f64e1cf0c ]

There are some powerpc selftests, as tm/tm-unavailable, that run for a long
period (>120 seconds), and if it is interrupted, as pressing CRTL-C
(SIGINT), the foreground process (harness) dies but the child process and
threads continue to execute (with PPID = 1 now) in background.

In this case, you'd think the whole test exited, but there are remaining
threads and processes being executed in background. Sometimes these
zombies processes are doing annoying things, as consuming the whole CPU or
dumping things to STDOUT.

This patch fixes this problem by attaching an empty signal handler to
SIGINT in the harness process. This handler will interrupt (EINTR) the
parent process waitpid() call, letting the code to follow through the
normal flow, which will kill all the processes in the child process group.

This patch also fixes a typo.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/powerpc/harness.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

--- a/tools/testing/selftests/powerpc/harness.c
+++ b/tools/testing/selftests/powerpc/harness.c
@@ -81,13 +81,13 @@ wait:
 	return status;
 }
 
-static void alarm_handler(int signum)
+static void sig_handler(int signum)
 {
-	/* Jut wake us up from waitpid */
+	/* Just wake us up from waitpid */
 }
 
-static struct sigaction alarm_action = {
-	.sa_handler = alarm_handler,
+static struct sigaction sig_action = {
+	.sa_handler = sig_handler,
 };
 
 int test_harness(int (test_function)(void), char *name)
@@ -97,8 +97,14 @@ int test_harness(int (test_function)(voi
 	test_start(name);
 	test_set_git_version(GIT_VERSION);
 
-	if (sigaction(SIGALRM, &alarm_action, NULL)) {
-		perror("sigaction");
+	if (sigaction(SIGINT, &sig_action, NULL)) {
+		perror("sigaction (sigint)");
+		test_error(name);
+		return 1;
+	}
+
+	if (sigaction(SIGALRM, &sig_action, NULL)) {
+		perror("sigaction (sigalrm)");
 		test_error(name);
 		return 1;
 	}


