Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F3C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8092D223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8KkHvWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8092D223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeKLTtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:49:35 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53820 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbeKLTte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:49:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id f10-v6so7787163wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 01:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gEkvf3D0ybtQ1XCiNuNOR20e0/KEmaDMFTtp87FuqbE=;
        b=N8KkHvWqCG3FPBQKMMKSv7Pg/NLzZZA7xMvcJW6U01Wj0GNYTuJeCcya4ODW4IlfDY
         bjeINPfviBlUjWGw0A/F1Z2j5xFDixkEn+Wq8pjVDa2f0IyCUhwOwJnWnNFIaWBeVVTq
         d85CwbZ1TDnYV7195SRPVFTFCEtIMsDAzsBRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gEkvf3D0ybtQ1XCiNuNOR20e0/KEmaDMFTtp87FuqbE=;
        b=lD60VaFG6xAAtb1WpH992IKiEtaxXhB9pmOzX6udt4FEG1adb7mkbaugKMn7zcczpv
         1oj1pB95sHzEP2/W1+xhAVRSORgZonttpFhYsYFsDL7ZS9RMVpLn9YWYIWxiOH/0uxiV
         DoN+JAeN69d9SKZf9X5KxOpuAMTXagl3tvTRPp/8Eqw2Qewfd6AHlk8idFCZ3MRrmhY+
         x1QONpqO3vVM8K/Rx0yKIHXX9L004ffF/ghYVJHJcH9Tduq0xAWSB2GvzGkK5iMsdsMW
         4XAMAfFxCX3W2pHwlVj9GWk3cUODet0rGQjbY1b5oX+mA82sFQaiShU6VhPc/8sCXu5L
         Thbw==
X-Gm-Message-State: AGRZ1gIbvnyi+8EclyIZBR4wZEEGpJCVa0WVQxe5VtSqppbxJWuDznp6
        jsM2Xffd/ZjWFbz6hheJNzES8w==
X-Google-Smtp-Source: AJdET5fmKdDKURgKcd0/zNKsqHAs7FIXT38LFwZ+xmQ+O0/jj39RrDDpR/i7+8aP1nLdD0FN0ceDXg==
X-Received: by 2002:a1c:3954:: with SMTP id g81-v6mr6728831wma.139.1542016624983;
        Mon, 12 Nov 2018 01:57:04 -0800 (PST)
Received: from localhost.localdomain ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id r14-v6sm21273089wro.8.2018.11.12.01.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 01:57:04 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 01/12] kernfs: add function to find kernfs_node without increasing ref counter
Date:   Mon, 12 Nov 2018 10:56:21 +0100
Message-Id: <20181112095632.69114-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Ruocco <angeloruocco90@gmail.com>

The kernfs pseudo file system doesn't export any function to only find
a node by name, without also getting a reference on it.
But in some cases it is useful to just locate a kernfs node, while
using it or not depends on some other condition.

This commit adds a function to just look for a node, without getting
a reference on it.

Signed-off-by: Angelo Ruocco <angeloruocco90@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 fs/kernfs/dir.c        | 13 +++++++++++++
 include/linux/kernfs.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4ca0b5c18192..0003c665869d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -892,6 +892,19 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 	return parent;
 }
 
+struct kernfs_node *kernfs_find(struct kernfs_node *parent,
+				const unsigned char *name)
+{
+	struct kernfs_node *kn;
+
+	mutex_lock(&kernfs_mutex);
+	kn = kernfs_find_ns(parent, name, NULL);
+	mutex_unlock(&kernfs_mutex);
+
+	return kn;
+}
+EXPORT_SYMBOL_GPL(kernfs_find);
+
 /**
  * kernfs_find_and_get_ns - find and get kernfs_node with the given name
  * @parent: kernfs_node to search under
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 5b36b1287a5a..26e69d285964 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -309,6 +309,8 @@ void pr_cont_kernfs_path(struct kernfs_node *kn);
 struct kernfs_node *kernfs_get_parent(struct kernfs_node *kn);
 struct kernfs_node *kernfs_find_and_get_ns(struct kernfs_node *parent,
 					   const char *name, const void *ns);
+struct kernfs_node *kernfs_find(struct kernfs_node *parent,
+				const unsigned char *name);
 struct kernfs_node *kernfs_walk_and_get_ns(struct kernfs_node *parent,
 					   const char *path, const void *ns);
 void kernfs_get(struct kernfs_node *kn);
@@ -391,6 +393,11 @@ static inline struct kernfs_node *
 kernfs_find_and_get_ns(struct kernfs_node *parent, const char *name,
 		       const void *ns)
 { return NULL; }
+
+static inline struct kernfs_node *
+kernfs_find(struct kernfs_node *parent, const char *name)
+{ return NULL; }
+
 static inline struct kernfs_node *
 kernfs_walk_and_get_ns(struct kernfs_node *parent, const char *path,
 		       const void *ns)
-- 
2.16.1

