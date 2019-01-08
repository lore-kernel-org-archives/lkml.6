Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36936C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15B6218AD
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977312;
	bh=KcFeW3P2svcfvbfRibNPI4rXUXIn+IDXesS+I8bBApg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hk9fbJcT2cSP2eUl3UDTjA5VlEPZbYMIFrAghpmM6mz2+XZTeaXGlE+W+ybeB6rEc
	 E1rxvEdNUj5TzVvZO5m8SMDRWW+JM5bZLLO10lPU7tev3me9W3DRDdpd9CvSWbMjjH
	 t5sLVx3Q8e8F+zXWrq7mXu1Zf/O940ZiIWvQlDh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfAHTzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:55:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730739AbfAHTaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D76220827;
        Tue,  8 Jan 2019 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975822;
        bh=KcFeW3P2svcfvbfRibNPI4rXUXIn+IDXesS+I8bBApg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hLUv7j3Ar6pomZPgwl1+P2USV5xT9Qq5Tl7xrHJILkjN9mRoU90aqYTUub5QZAfYP
         NiWKQdPaQn+vyw4nzK6wuEathxu1TX6qXWMjTNC8YUxc3V96Z1guardhscsYS3OW+F
         LXy/wBF7+uUkOZjOp8EZElkpm8fIyT7U1VPCkYwo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Daniel T. Lee" <danieltimlee@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/97] samples: bpf: fix: error handling regarding kprobe_events
Date:   Tue,  8 Jan 2019 14:28:31 -0500
Message-Id: <20190108192949.122407-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
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

