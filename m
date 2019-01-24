Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C97C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F15921907
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358504;
	bh=mv9SVDBEnZXZxobwT4Cpu2wS+OzU/G0wETOEeo38ZDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zdt4EC9gyelg2vo1hYgWi9zjJx6gm9i4NKpbrcGdLTy9cMEaoUP3PukKP4NRr5U/S
	 5j88uMgDjiejoa1IjlAN7XNiSp3TGfPlWVDByPend6FEWg0bpiRbycXokbk481TvGV
	 wMRPLO+DMEOmf7oziqwyxO6Jp7vn1CFP5rtZziOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbfAXTfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731468AbfAXTe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14397218FC;
        Thu, 24 Jan 2019 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358497;
        bh=mv9SVDBEnZXZxobwT4Cpu2wS+OzU/G0wETOEeo38ZDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4EhKNcfrmcmPJhJ1kzZY9EBVcb/HnmSv3pkD48cvrRam3Ds/Jd7hglhUtU+Uir9k
         4n3bZ89raWus6Ze8MftL8UXJ35ki6njDPhh0hQhVw1BLu4qBPlkexALyakJOQOxbgj
         KtiI24XJG2aM8g8QlOTLWbXjgxd7cRft8RRGI2UE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Daniel T. Lee" <danieltimlee@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/106] samples: bpf: fix: error handling regarding kprobe_events
Date:   Thu, 24 Jan 2019 20:19:47 +0100
Message-Id: <20190124190208.284098390@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

[ Upstream commit 5a863813216ce79e16a8c1503b2543c528b778b6 ]

Currently, kprobe_events failure won't be handled properly.
Due to calling system() indirectly to write to kprobe_events,
it can't be identified whether an error is derived from kprobe or system.

    // buf = "echo '%c:%s %s' >> /s/k/d/t/kprobe_events"
    err = system(buf);
    if (err < 0) {
        printf("failed to create kprobe ..");
        return -1;
    }

For example, running ./tracex7 sample in ext4 partition,
"echo p:open_ctree open_ctree >> /s/k/d/t/kprobe_events"
gets 256 error code system() failure.
=> The error comes from kprobe, but it's not handled correctly.

According to man of system(3), it's return value
just passes the termination status of the child shell
rather than treating the error as -1. (don't care success)

Which means, currently it's not working as desired.
(According to the upper code snippet)

    ex) running ./tracex7 with ext4 env.
    # Current Output
    sh: echo: I/O error
    failed to open event open_ctree

    # Desired Output
    failed to create kprobe 'open_ctree' error 'No such file or directory'

The problem is, error can't be verified whether from child ps
or system. But using write() directly can verify the command
failure, and it will treat all error as -1. So I suggest using
write() directly to 'kprobe_events' rather than calling system().

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/bpf_load.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index 904e775d1a44..cf40a8284a38 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -55,6 +55,23 @@ static int populate_prog_array(const char *event, int prog_fd)
 	return 0;
 }
 
+static int write_kprobe_events(const char *val)
+{
+	int fd, ret, flags;
+
+	if ((val != NULL) && (val[0] == '\0'))
+		flags = O_WRONLY | O_TRUNC;
+	else
+		flags = O_WRONLY | O_APPEND;
+
+	fd = open("/sys/kernel/debug/tracing/kprobe_events", flags);
+
+	ret = write(fd, val, strlen(val));
+	close(fd);
+
+	return ret;
+}
+
 static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 {
 	bool is_socket = strncmp(event, "socket", 6) == 0;
@@ -166,10 +183,9 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 
 #ifdef __x86_64__
 		if (strncmp(event, "sys_", 4) == 0) {
-			snprintf(buf, sizeof(buf),
-				 "echo '%c:__x64_%s __x64_%s' >> /sys/kernel/debug/tracing/kprobe_events",
-				 is_kprobe ? 'p' : 'r', event, event);
-			err = system(buf);
+			snprintf(buf, sizeof(buf), "%c:__x64_%s __x64_%s",
+				is_kprobe ? 'p' : 'r', event, event);
+			err = write_kprobe_events(buf);
 			if (err >= 0) {
 				need_normal_check = false;
 				event_prefix = "__x64_";
@@ -177,10 +193,9 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 		}
 #endif
 		if (need_normal_check) {
-			snprintf(buf, sizeof(buf),
-				 "echo '%c:%s %s' >> /sys/kernel/debug/tracing/kprobe_events",
-				 is_kprobe ? 'p' : 'r', event, event);
-			err = system(buf);
+			snprintf(buf, sizeof(buf), "%c:%s %s",
+				is_kprobe ? 'p' : 'r', event, event);
+			err = write_kprobe_events(buf);
 			if (err < 0) {
 				printf("failed to create kprobe '%s' error '%s'\n",
 				       event, strerror(errno));
@@ -520,7 +535,7 @@ static int do_load_bpf_file(const char *path, fixup_map_cb fixup_map)
 		return 1;
 
 	/* clear all kprobes */
-	i = system("echo \"\" > /sys/kernel/debug/tracing/kprobe_events");
+	i = write_kprobe_events("");
 
 	/* scan over all elf sections to get license and map info */
 	for (i = 1; i < ehdr.e_shnum; i++) {
-- 
2.19.1



