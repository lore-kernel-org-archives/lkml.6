Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872FA20868
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx4QDobf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872FA20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbeKOIcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388803AbeKOIci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:32:38 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED582243E;
        Wed, 14 Nov 2018 21:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542232523;
        bh=OduJZ9R4wmCmaBxmHLPNRLiEHmmTlTEyLuPRaDRtCRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xx4QDobf7tdgquyHkJUHNggzvyTd8a9t3fppnN3z9ukhvL6SYsGJk+10Kh6nGjX/j
         uRcx20zErH0XK03DA00Gjwst093VUQz3IRIDeRb10WrdN2To6w1YH70nBwyfPYerKy
         kGJKPMJrYbmPCBPWQBk3WhK94msislsvWiY0WEXA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Herrmann <dh.herrmann@googlemail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges
Date:   Wed, 14 Nov 2018 13:55:09 -0800
Message-Id: <20181114215509.163600-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When a UHID_CREATE command is written to the uhid char device, a
copy_from_user() is done from a user pointer embedded in the command.
When the address limit is KERNEL_DS, e.g. as is the case during
sys_sendfile(), this can read from kernel memory.  Alternatively,
information can be leaked from a setuid binary that is tricked to write
to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.

No other commands in uhid_char_write() are affected by this bug and
UHID_CREATE is marked as "obsolete", so apply the restriction to
UHID_CREATE only rather than to uhid_char_write() entirely.

Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
helpers fault on kernel addresses"), allowing this bug to be found.

Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
Cc: <stable@vger.kernel.org> # v3.6+
Cc: Jann Horn <jannh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/hid/uhid.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 3c55073136064..051639c09f728 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -12,6 +12,7 @@
 
 #include <linux/atomic.h>
 #include <linux/compat.h>
+#include <linux/cred.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/hid.h>
@@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 
 	switch (uhid->input_buf.type) {
 	case UHID_CREATE:
+		/*
+		 * 'struct uhid_create_req' contains a __user pointer which is
+		 * copied from, so it's unsafe to allow this with elevated
+		 * privileges (e.g. from a setuid binary) or via kernel_write().
+		 */
+		if (file->f_cred != current_cred() || uaccess_kernel()) {
+			pr_err_once("UHID_CREATE from different security context by process %d (%s), this is not allowed.\n",
+				    task_tgid_vnr(current), current->comm);
+			ret = -EACCES;
+			goto unlock;
+		}
 		ret = uhid_dev_create(uhid, &uhid->input_buf);
 		break;
 	case UHID_CREATE2:
-- 
2.19.1.930.g4563a0d9d0-goog

