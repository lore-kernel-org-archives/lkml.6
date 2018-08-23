Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD5CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B0BF2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0BF2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeHWM1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHWM1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:07 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B7A4C83;
        Thu, 23 Aug 2018 08:58:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Laight <David.Laight@ACULAB.COM>,
        Taeung Song <treeze.taeung@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 189/324] samples/bpf: Check the error of write() and read()
Date:   Thu, 23 Aug 2018 09:54:15 +0200
Message-Id: <20180823075005.620304410@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Taeung Song <treeze.taeung@gmail.com>

[ Upstream commit 02a2f000a3629274bfad60bfc4de9edec49e63e7 ]

test_task_rename() and test_urandom_read()
can be failed during write() and read(),
So check the result of them.

Reviewed-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 samples/bpf/test_overhead_user.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/samples/bpf/test_overhead_user.c
+++ b/samples/bpf/test_overhead_user.c
@@ -6,6 +6,7 @@
  */
 #define _GNU_SOURCE
 #include <sched.h>
+#include <errno.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <asm/unistd.h>
@@ -44,8 +45,13 @@ static void test_task_rename(int cpu)
 		exit(1);
 	}
 	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++)
-		write(fd, buf, sizeof(buf));
+	for (i = 0; i < MAX_CNT; i++) {
+		if (write(fd, buf, sizeof(buf)) < 0) {
+			printf("task rename failed: %s\n", strerror(errno));
+			close(fd);
+			return;
+		}
+	}
 	printf("task_rename:%d: %lld events per sec\n",
 	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
 	close(fd);
@@ -63,8 +69,13 @@ static void test_urandom_read(int cpu)
 		exit(1);
 	}
 	start_time = time_get_ns();
-	for (i = 0; i < MAX_CNT; i++)
-		read(fd, buf, sizeof(buf));
+	for (i = 0; i < MAX_CNT; i++) {
+		if (read(fd, buf, sizeof(buf)) < 0) {
+			printf("failed to read from /dev/urandom: %s\n", strerror(errno));
+			close(fd);
+			return;
+		}
+	}
 	printf("urandom_read:%d: %lld events per sec\n",
 	       cpu, MAX_CNT * 1000000000ll / (time_get_ns() - start_time));
 	close(fd);


