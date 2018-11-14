Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814BEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BA022419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 18:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v3HMdWKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BA022419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbeKOEHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 23:07:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbeKOEHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 23:07:19 -0500
Received: from ebiggers.mtv.corp.google.com (unknown [104.132.1.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF30C21780;
        Wed, 14 Nov 2018 18:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542218586;
        bh=a2WhmBeZzt2mlohrRWK6xogUa3I/TV4DiusWV0Ecbxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v3HMdWKvX/DNINNazhk5/z17HaUYL3xtZ66p3oGbd+aee15umxPuFS2zNVlzW5dBY
         SW8XfTpTX3pdxUiiCxeFID6WF8NXMrGL/CO9fXNOlFfphjrd8qGwObqcYB62IPpm0M
         atXzglTthJYnnK5V8wV+c1POJf/zA0ol+g8gL9Yw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Herrmann <dh.herrmann@googlemail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH] HID: uhid: prevent uhid_char_write() under KERNEL_DS
Date:   Wed, 14 Nov 2018 10:02:17 -0800
Message-Id: <20181114180217.195917-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181114171447.GA87768@gmail.com>
References: <20181114171447.GA87768@gmail.com>
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
sendfile(), this can read from kernel memory.  Therefore, UHID_CREATE
must not be allowed in this case.

For consistency and to make sure all current and future uhid commands
are covered, apply the restriction to uhid_char_write() as a whole
rather than to UHID_CREATE specifically.

Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
helpers fault on kernel addresses"), allowing this bug to be found.

Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events")
Cc: <stable@vger.kernel.org> # v3.6+
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/hid/uhid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 3c55073136064..e94c5e248b56e 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -705,6 +705,12 @@ static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 	int ret;
 	size_t len;
 
+	if (uaccess_kernel()) { /* payload may contain a __user pointer */
+		pr_err_once("%s: process %d (%s) called from kernel context, this is not allowed.\n",
+			    __func__, task_tgid_vnr(current), current->comm);
+		return -EACCES;
+	}
+
 	/* we need at least the "type" member of uhid_event */
 	if (count < sizeof(__u32))
 		return -EINVAL;
-- 
2.19.1.930.g4563a0d9d0-goog

