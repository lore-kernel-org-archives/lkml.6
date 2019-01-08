Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDC0C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF5620660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546978153;
	bh=IRPOWe/6aYzrVVGq+urfv6B6FdjKWiCQTZVHs+aznx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NrMm71rTu8zor5XdgWhP1laUeZLt8WEx7+Q8u45WHVGCvNq6i4WeJ16n8m8Sz0dZm
	 hrP0PqT67vMR5+Z5OJoK2iLsvkAGHwWeL/IHVPt7EmFkIvZRO3BwCzq7TTawD9UCNB
	 I9OIS45TJAM1MZV5q+mxuqA97rqhTvnYwIJM3B5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfAHT1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:27:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbfAHT1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96F1C2176F;
        Tue,  8 Jan 2019 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975643;
        bh=IRPOWe/6aYzrVVGq+urfv6B6FdjKWiCQTZVHs+aznx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wsurmlxCPoIGqCwrzvRv7YfNAiwxxZJL322I+JsFmGjFa6aN2nnNgo/w0YuwNOusK
         KMczkzW45cILxvbXNDWpket71X+ZlgaJYqcyFoYkgXcgVLdLi+sRJBfYgCEJwN9F6j
         S13AoCvi4FL7skD1elhJQ94itOdWAd0RSw/w7mzc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Daniel T. Lee" <danieltimlee@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 029/117] samples: bpf: fix: error handling regarding kprobe_events
Date:   Tue,  8 Jan 2019 14:24:57 -0500
Message-Id: <20190108192628.121270-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel T. Lee" <danieltimlee@gmail.com>

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
index e6d7e0fe155b..96783207de4a 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -54,6 +54,23 @@ static int populate_prog_array(const char *event, int prog_fd)
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
@@ -165,10 +182,9 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 
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
@@ -176,10 +192,9 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
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
@@ -519,7 +534,7 @@ static int do_load_bpf_file(const char *path, fixup_map_cb fixup_map)
 		return 1;
 
 	/* clear all kprobes */
-	i = system("echo \"\" > /sys/kernel/debug/tracing/kprobe_events");
+	i = write_kprobe_events("");
 
 	/* scan over all elf sections to get license and map info */
 	for (i = 1; i < ehdr.e_shnum; i++) {
-- 
2.19.1

