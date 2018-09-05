Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFDEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D39D2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 07:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Z50zz5Ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D39D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeIEMCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:02:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33209 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIEMCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:02:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id d8-v6so5292652edv.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBUCXZz0Wo0vJcYf+CpKd8r6lsRNt/uuKLuXehrG3Qk=;
        b=Z50zz5Ea6DVTb5AmMgZRPDy8zgddg/120aFMoZVp6OZ3UukuNkXfp31L3zjq94+g1Z
         wI4L44gV5U1OR9jPJD37vsOgu/RIa8soitpqGWAGAnknEreSTSgebD9HZ58Qnq/4f0p2
         iR2sr61kqK0jo/zjnzlIbgY6RYhtAKpxUtsJhUYgU8nLWmMKXZL2L/tVbWEUCeedIbk6
         HjB+ZW7rgzCHlN96IiGnWBPrXXsckoB6nSjycfQmUm1IhcetOxKsNKxQ3rSMmJCDK5hv
         IlacH+DPa/6BbtRVmZcJ/Tmuo8++5xWefIO946SNegZalzZnD0nfBs51UtfHseN2fiS2
         v05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBUCXZz0Wo0vJcYf+CpKd8r6lsRNt/uuKLuXehrG3Qk=;
        b=jEK+79j5PSWbGYCTglIGQkFzY7+uanA/r9LjJD6XCjt38eEXYxZ7N31BfHaZ1NGKQd
         btuOtp5qLq/mAe76+yZoe8rhbo0t6u/6Hm4BFU4aNSC0RR5Lc+o5K82f0EvFhEUNeZtB
         xRmzPwuT3nQ5w8qgX+Cc/UytBbYFwplr+an+FGbawaK8TLr+BxXhcz11fSmhYg9o+zpO
         fLWrERL2BtXIp0qW4eQEIN1828x5xeL61BKL5tRDsZEhrfYkDZ/n3BgI60fZcNWwxOa2
         0QxZFXCQ/X9ouiLCulflTjGszf2J+DxxYpKdRKRwTB9/HF6EXbWekoz8Y0qZrWyv4Iwz
         WzKQ==
X-Gm-Message-State: APzg51CQ0Ijv9ct0FjdqV+Mq/oHBzFR2+c9GA0LSXVB/k+ZTiNsLsg/E
        0Zk9blfbO1cP9rOHAClutkj/Uw==
X-Google-Smtp-Source: ANB0VdbGUpJ1d1BSF1QWTWgb9gENOG2gSnvkteXlnE6NQzau+3ubQvy9Q3+g8NwoelLa1ma5SSCrvA==
X-Received: by 2002:a05:6402:1545:: with SMTP id p5mr38999754edx.104.1536132830917;
        Wed, 05 Sep 2018 00:33:50 -0700 (PDT)
Received: from maco.fra.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id t17-v6sm868848edb.27.2018.09.05.00.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 00:33:50 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     gregkh@linuxfoundation.org, tkjos@google.com, arve@android.com
Cc:     john.stultz@linaro.org, amit.pundir@linaro.org,
        smoreland@google.com, peskal@google.com, robenea@google.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        maco@google.com, Martijn Coenen <maco@android.com>
Subject: [PATCH] ANDROID: binder: Add BINDER_GET_NODE_INFO_FOR_REF ioctl.
Date:   Wed,  5 Sep 2018 09:33:46 +0200
Message-Id: <20180905073346.157318-1-maco@android.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the context manager to retrieve information about nodes
that it holds a reference to, such as the current number of
references to those nodes.

Such information can for example be used to determine whether the
servicemanager is the only process holding a reference to a node.
This information can then be passed on to the process holding the
node, which can in turn decide whether it wants to shut down to
reduce resource usage.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/android/binder.c            | 50 +++++++++++++++++++++++++++++
 include/uapi/linux/android/binder.h |  8 +++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d58763b6b0090..1c7e965241fb8 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4544,6 +4544,37 @@ static int binder_ioctl_set_ctx_mgr(struct file *filp)
 	return ret;
 }
 
+static int binder_ioctl_get_node_info_for_ref(struct binder_proc *proc,
+		struct binder_node_info_for_ref *info)
+{
+	struct binder_node *node;
+	struct binder_context *context = proc->context;
+	__u32 handle = info->handle;
+
+	memset(info, 0, sizeof(*info));
+
+	/* This ioctl may only be used by the context manager */
+	mutex_lock(&context->context_mgr_node_lock);
+	if (!context->binder_context_mgr_node ||
+		context->binder_context_mgr_node->proc != proc) {
+		mutex_unlock(&context->context_mgr_node_lock);
+		return -EPERM;
+	}
+	mutex_unlock(&context->context_mgr_node_lock);
+
+	node = binder_get_node_from_ref(proc, handle, true, NULL);
+	if (!node)
+		return -EINVAL;
+
+	info->strong_count = node->local_strong_refs +
+		node->internal_strong_refs;
+	info->weak_count = node->local_weak_refs;
+
+	binder_put_node(node);
+
+	return 0;
+}
+
 static int binder_ioctl_get_node_debug_info(struct binder_proc *proc,
 				struct binder_node_debug_info *info)
 {
@@ -4638,6 +4669,25 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	}
+	case BINDER_GET_NODE_INFO_FOR_REF: {
+		struct binder_node_info_for_ref info;
+
+		if (copy_from_user(&info, ubuf, sizeof(info))) {
+			ret = -EFAULT;
+			goto err;
+		}
+
+		ret = binder_ioctl_get_node_info_for_ref(proc, &info);
+		if (ret < 0)
+			goto err;
+
+		if (copy_to_user(ubuf, &info, sizeof(info))) {
+			ret = -EFAULT;
+			goto err;
+		}
+
+		break;
+	}
 	case BINDER_GET_NODE_DEBUG_INFO: {
 		struct binder_node_debug_info info;
 
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index bfaec6903b8bc..a54a680ff2936 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -200,6 +200,13 @@ struct binder_node_debug_info {
 	__u32            has_weak_ref;
 };
 
+struct binder_node_info_for_ref {
+	__u32            handle;
+	__u32            strong_count;
+	__u32            weak_count;
+	__u64            reserved;
+};
+
 #define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
 #define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
 #define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
@@ -208,6 +215,7 @@ struct binder_node_debug_info {
 #define BINDER_THREAD_EXIT		_IOW('b', 8, __s32)
 #define BINDER_VERSION			_IOWR('b', 9, struct binder_version)
 #define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debug_info)
+#define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_info_for_ref)
 
 /*
  * NOTE: Two special error codes you should check for when calling
-- 
2.19.0.rc1.350.ge57e33dbd1-goog

