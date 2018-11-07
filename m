Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E3AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F093E2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F093E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeKHIEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:04:22 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36721 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeKHIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:04:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id r127-v6so15293462oie.3;
        Wed, 07 Nov 2018 14:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3CYnbqPAmqUfHKzmMcRqlFYTfeL9hdSDgbdLKoosjak=;
        b=VXtgf+m+r1n4iSX2VsRzo0o8CtPHcBDzcYfi6wJVmwYj8gEP6RxDcCHtx71XEyW0jg
         87XnhJvGyFS2ToPel4v4IGUbAHWFojGiVZQlaRmbV5TzUX06FguZ8kVyGHAvr5mI/kG4
         pES+seEl8Hl+8oinUIS3CBGz1UdepiFXckJO3WPepaBP9rd2F+ndPmjfv+WThgQY2MZe
         CUHwzTIHj0TlkOj63maTtrd53eTcvyWSCKvKXyB7VMojog3R1fCDvFc6qno0yDM3OKAm
         3012CBrt/zXOC9vbMyv9s5I8qRGcM+OYq7UdbRditK9WLz5HjVymDYs2D2RWowZl1MWJ
         xu6w==
X-Gm-Message-State: AGRZ1gK/ASxbmq0YMljLYD7WgKi9nu09HXUkY94s1TDSD8gtwznSceSv
        n0GjNiOUjoMY/2err18NeA==
X-Google-Smtp-Source: AJdET5c+xdUxQlfG3drLEoPlu8caF7l86lh5vRSuJZ6UUGUa4RqjJTE17lUsD0QtfyHrmr2E5IHkyA==
X-Received: by 2002:aca:5596:: with SMTP id j144-v6mr1324611oib.54.1541629913931;
        Wed, 07 Nov 2018 14:31:53 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f9sm750959oth.17.2018.11.07.14.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:31:53 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 1/8] fs/openpromfs: use full_name instead of path_component_name
Date:   Wed,  7 Nov 2018 16:31:44 -0600
Message-Id: <20181107223151.14991-2-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107223151.14991-1-robh@kernel.org>
References: <20181107223151.14991-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove struct device_node.path_component_name, use
full_name instead. kbasename is used so full_name can be used whether it
is the full path or just the node's name and unit-address.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 fs/openpromfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 607092f367ad..3d8e9bcfe239 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -199,10 +199,11 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 
 	child = dp->child;
 	while (child) {
-		int n = strlen(child->path_component_name);
+		const char *node_name = kbasename(child->full_name);
+		int n = strlen(node_name);
 
 		if (len == n &&
-		    !strncmp(child->path_component_name, name, len)) {
+		    !strncmp(node_name, name, len)) {
 			ent_type = op_inode_node;
 			ent_data.node = child;
 			ino = child->unique_id;
@@ -293,8 +294,8 @@ static int openpromfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 	while (child) {
 		if (!dir_emit(ctx,
-			    child->path_component_name,
-			    strlen(child->path_component_name),
+			    kbasename(child->full_name),
+			    strlen(kbasename(child->full_name)),
 			    child->unique_id, DT_DIR))
 			goto out;
 
-- 
2.19.1

