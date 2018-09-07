Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09C3C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE6F2086B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="UzJqB5uI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE6F2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbeIGSTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:19:50 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38826 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbeIGSTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:19:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33-v6so11552122edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3a/c2oMd9v69Zdf5hDPreXO2X9N0YgX5307ChuDaW4=;
        b=UzJqB5uIdvu+5i4Ph4/XNi279/jcckDIEKe3r4Nulprmdz0haRAKMz3+7qLcFBxBOe
         vajQ0eugDo2VBs2vCMG0Q/vjv76a25o9Yh5+isOeQm9eHsbJ6huwJXp2bGM3g+Vx1YXx
         4OOuOQeiPGY6YWBQO5UVVTzXfQO7qmQxRVuCYhVKrShdyb0PgAtfa8j7YzNt5BEBVLPH
         cjgCd62n7XO/Sh4Z78qod4nKQHJ+WAvbgGXuqsFcVaD9c39vQxSGd/aUUyaacGWDW07C
         LBIy4P9JiD50VQPxU+RT+z9aSg+TqjbhqPornH2vw1XjPEB1lu+SfaCgNH0UYepvDY+9
         l7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3a/c2oMd9v69Zdf5hDPreXO2X9N0YgX5307ChuDaW4=;
        b=SR8gntWmgeV/PT+lleRrpRnVoLkRDoena7e1GS+u5oM+uRnoZgi1JwluL6QT+7Mig4
         PaIy9WGAFrjvbp98eB/fiW1JzkckB6mIdrJj+5G0NvMuTfd00bPhKVs0UF6MQEoYANno
         faS7ORWhQHj4hV4DZYf9OU/wCUH3wfujegBQRMKfYXjRZR7ThJHnz1fnOqdYypw0yVed
         Jtfp/t+3ABG1nTQXxPwKh78KgMrMWSt1S4bIz/dvc+qdsKb9eY3uXteOfHk65QDHO6mB
         V4WF37ql2lGxq0OGaeijQpdoWe+Galou2dZMVhHjIr1CoZeijvlYvsOpJFBHrFSCxbN/
         NanQ==
X-Gm-Message-State: APzg51BX7jQAC3Kx8SgLedU7PZHEihn1NFjryqEYBl71bmYTG7BL2N03
        HdCmTndTZvilm8g6ajPSfcjZWQ==
X-Google-Smtp-Source: ANB0VdYQlu4e030UvBbK8XZiqMko5tpQYCmK0oySI1d1MvpAPFm6pdBQGKpE9HWiHelNbgvdlXabhA==
X-Received: by 2002:a50:b941:: with SMTP id m59-v6mr8826970ede.20.1536327527129;
        Fri, 07 Sep 2018 06:38:47 -0700 (PDT)
Received: from maco.fra.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id v49-v6sm2120857edc.10.2018.09.07.06.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 06:38:46 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     gregkh@linuxfoundation.org, tkjos@google.com, arve@android.com,
        dan.carpenter@oracle.com
Cc:     john.stultz@linaro.org, amit.pundir@linaro.org,
        smoreland@google.com, peskal@google.com, robenea@google.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        maco@google.com, Martijn Coenen <maco@android.com>
Subject: [PATCH v2] ANDROID: binder: Add BINDER_GET_NODE_INFO_FOR_REF ioctl.
Date:   Fri,  7 Sep 2018 15:38:37 +0200
Message-Id: <20180907133837.66047-1-maco@android.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
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
v2: made sure reserved fields are aligned, and enforce caller zeroes
    all fields except handle, as suggested by Dan Carpenter.

 drivers/android/binder.c            | 55 +++++++++++++++++++++++++++++
 include/uapi/linux/android/binder.h | 10 ++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d58763b6b0090..5b25412e15ccf 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4544,6 +4544,42 @@ static int binder_ioctl_set_ctx_mgr(struct file *filp)
 	return ret;
 }
 
+static int binder_ioctl_get_node_info_for_ref(struct binder_proc *proc,
+		struct binder_node_info_for_ref *info)
+{
+	struct binder_node *node;
+	struct binder_context *context = proc->context;
+	__u32 handle = info->handle;
+
+	if (info->strong_count || info->weak_count || info->reserved1 ||
+	    info->reserved2 || info->reserved3) {
+		binder_user_error("%d BINDER_GET_NODE_INFO_FOR_REF: only handle may be non-zero.",
+				  proc->pid);
+		return -EINVAL;
+	}
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
@@ -4638,6 +4674,25 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
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
index bfaec6903b8bc..b9ba520f7e4bb 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -200,6 +200,15 @@ struct binder_node_debug_info {
 	__u32            has_weak_ref;
 };
 
+struct binder_node_info_for_ref {
+	__u32            handle;
+	__u32            strong_count;
+	__u32            weak_count;
+	__u32            reserved1;
+	__u32            reserved2;
+	__u32            reserved3;
+};
+
 #define BINDER_WRITE_READ		_IOWR('b', 1, struct binder_write_read)
 #define BINDER_SET_IDLE_TIMEOUT		_IOW('b', 3, __s64)
 #define BINDER_SET_MAX_THREADS		_IOW('b', 5, __u32)
@@ -208,6 +217,7 @@ struct binder_node_debug_info {
 #define BINDER_THREAD_EXIT		_IOW('b', 8, __s32)
 #define BINDER_VERSION			_IOWR('b', 9, struct binder_version)
 #define BINDER_GET_NODE_DEBUG_INFO	_IOWR('b', 11, struct binder_node_debug_info)
+#define BINDER_GET_NODE_INFO_FOR_REF	_IOWR('b', 12, struct binder_node_info_for_ref)
 
 /*
  * NOTE: Two special error codes you should check for when calling
-- 
2.19.0.rc2.392.g5ba43deb5a-goog

