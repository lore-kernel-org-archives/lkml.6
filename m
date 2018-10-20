Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF11C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4142021533
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 17:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4142021533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jjacky.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJUB6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 21:58:21 -0400
Received: from mail.jjacky.com ([23.29.69.116]:57419 "EHLO mail.jjacky.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbeJUB6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 21:58:19 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2018 21:58:16 EDT
Received: by mail.jjacky.com (OpenSMTPD) with ESMTP id e9a5ce3c;
        Sat, 20 Oct 2018 17:40:24 +0000 (UTC)
From:   Olivier Brunel <jjk@jjacky.com>
To:     Network Development <netdev@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Olivier Brunel <jjk@jjacky.com>
Subject: [PATCH 1/2] umh: Add command line to user mode helpers
Date:   Sat, 20 Oct 2018 19:39:56 +0200
Message-Id: <20181020173957.31239-2-jjk@jjacky.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181020173957.31239-1-jjk@jjacky.com>
References: <20180826180816.04ef7d16@jjacky.com> <20180827183122.0b4ac65e@jjacky.com> <20180828033500.g3siwst5h2ckewwb@ast-mbp> <20180905175243.78a6ba81@jjacky.com> <CAADnVQ+xFfwV67BRXD0epoTwKz54W3mcYHXVWBd1iWb94p+zpg@mail.gmail.com>
 <20181020173957.31239-1-jjk@jjacky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User mode helpers were spawned without a command line, and because
an empty command line is used by many tools to identify processes as
kernel threads, this could cause some issues.

Notably during killing spree on shutdown, since such helper would then
be skipped (i.e. not killed) which would result in the process remaining
alive, and thus preventing unmouting of the rootfs (as experienced with
the bpfilter umh).

Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")
Signed-off-by: Olivier Brunel <jjk@jjacky.com>
---
 include/linux/umh.h |  1 +
 kernel/umh.c        | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/umh.h b/include/linux/umh.h
index 5c812acbb..235f51b62 100644
--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -44,6 +44,7 @@ struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
 			  int (*init)(struct subprocess_info *info, struct cred *new),
 			  void (*cleanup)(struct subprocess_info *), void *data);
 struct umh_info {
+	const char *cmdline;
 	struct file *pipe_to_umh;
 	struct file *pipe_from_umh;
 	pid_t pid;
diff --git a/kernel/umh.c b/kernel/umh.c
index c44985894..0baa672e0 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -405,11 +405,19 @@ struct subprocess_info *call_usermodehelper_setup_file(struct file *file,
 		void (*cleanup)(struct subprocess_info *info), void *data)
 {
 	struct subprocess_info *sub_info;
+	struct umh_info *info = data;
+	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
 
 	sub_info = kzalloc(sizeof(struct subprocess_info), GFP_KERNEL);
 	if (!sub_info)
 		return NULL;
 
+	sub_info->argv = argv_split(GFP_KERNEL, cmdline, NULL);
+	if (!sub_info->argv) {
+		kfree(sub_info);
+		return NULL;
+	}
+
 	INIT_WORK(&sub_info->work, call_usermodehelper_exec_work);
 	sub_info->path = "none";
 	sub_info->file = file;
@@ -458,10 +466,11 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
 	return 0;
 }
 
-static void umh_save_pid(struct subprocess_info *info)
+static void umh_clean_and_save_pid(struct subprocess_info *info)
 {
 	struct umh_info *umh_info = info->data;
 
+	argv_free(info->argv);
 	umh_info->pid = info->pid;
 }
 
@@ -471,6 +480,9 @@ static void umh_save_pid(struct subprocess_info *info)
  * @len: length of the blob
  * @info: information about usermode process (shouldn't be NULL)
  *
+ * If info->cmdline is set it will be used as command line for the
+ * user process, else "usermodehelper" is used.
+ *
  * Returns either negative error or zero which indicates success
  * in executing a blob of bytes as a usermode process. In such
  * case 'struct umh_info *info' is populated with two pipes
@@ -500,7 +512,7 @@ int fork_usermode_blob(void *data, size_t len, struct umh_info *info)
 
 	err = -ENOMEM;
 	sub_info = call_usermodehelper_setup_file(file, umh_pipe_setup,
-						  umh_save_pid, info);
+						  umh_clean_and_save_pid, info);
 	if (!sub_info)
 		goto out;
 
-- 
2.19.0

