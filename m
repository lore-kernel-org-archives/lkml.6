Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF57FC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661EC2172C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 01:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rIJuDYad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661EC2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHUEtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 00:49:35 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37757 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeHUEte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 00:49:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id c6-v6so3132174pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 18:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9t4ihFo9ifk1rbXHovFAPzVpTkXayIhM+kWxk3doFU4=;
        b=rIJuDYadO6QFrvw85dMcd+0QR6Kt/urzybKOdjZiCF8cnA8+zUsyz1f1O9Rn+gqwAs
         Masz50b0q8aHpfoWvE3CwtzPA0EobtdATN9OXACwHM8W6gLoU7fvFvxwyCpM8KN1wpZK
         F37LrL8oQANusPiaaIFa244FiiKw7yYLgbsUeeSLYjZhN3+d89u9wUQ80/kfec55W40A
         lCwi/u+p33HLHDyclUIE2CQwcU7N+i92JO4xPUPvdMod8Ny5QfvMVrZ8BD6tszi4rjsq
         qFHgAi0B5d7QRn7mVSXoiu9xv2thb83lePmJoDJFTMFjVlcTsxvYRLxzkd00cLIn0MKo
         +gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9t4ihFo9ifk1rbXHovFAPzVpTkXayIhM+kWxk3doFU4=;
        b=HMmR8aOeR34cd7ID40LSUcfHhbdi3hTtjroZyFn5wPj4YEmmKCbbePfItHlCQe278L
         Q59i3pQDQim5f3fMF/wR2VNEFczb7qHdEwA0VSVHMamq0RlVoDYXz300vIjtyo7bcmrA
         AsQcBpLScjl3dN55lfxdg1WlskeFMK6rtUcReUxxmFfomXQzQFClqCmdzO5fBntzGjPn
         mz8/cqbr+eSsrOK5P4d9FrAgSnP5Mlab8uTEWsnuuPOaxwy3wInW1PlK0i1NT9rZF84Q
         ySI03avekQoFsnadA7sHjzwjhNFRDVVu+MAkyOnlLXwypPN/RFbGsDtiw6VKQXR4+YGh
         4+wg==
X-Gm-Message-State: AOUpUlEfAgr76m3A5l0sJ4yCAO9M+VR6onxXM7mCFO18G4k5zSRInOIt
        NLtM5N0FPxjlJpQxP1Wl4EjHmQ==
X-Google-Smtp-Source: AA+uWPyj7P17O6OQ3LV1VQmWMg7YmqMC9De8uzcUmX4hflMIYiH44EvILUFhV88ilzP2TWjt4SMh/A==
X-Received: by 2002:a17:902:aa46:: with SMTP id c6-v6mr47281732plr.313.1534815096043;
        Mon, 20 Aug 2018 18:31:36 -0700 (PDT)
Received: from drosen.mtv.corp.google.com ([2620:0:1000:1612:726:adc3:41a6:c383])
        by smtp.gmail.com with ESMTPSA id n9-v6sm15774850pfg.21.2018.08.20.18.31.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 18:31:35 -0700 (PDT)
From:   Daniel Rosenberg <drosen@google.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Subject: [PATCH] staging: android: ion: check for kref overflow
Date:   Mon, 20 Aug 2018 18:30:57 -0700
Message-Id: <20180821013057.139644-1-drosen@google.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace can cause the kref to handles to increment
arbitrarily high. Ensure it does not overflow.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---

This patch is against 4.4. It does not apply to master due to a large
rework of ion in 4.12 which removed the affected functions altogther.
It applies from 3.18 to 4.11, although with a trivial conflict resolution
for the later branches.
4c23cbff073f3b9b ("staging: android: ion: Remove import interface")

 drivers/staging/android/ion/ion.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
index 374f840f31a48..11f93a6314fdb 100644
--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -15,6 +15,7 @@
  *
  */
 
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/file.h>
@@ -387,6 +388,15 @@ static void ion_handle_get(struct ion_handle *handle)
 	kref_get(&handle->ref);
 }
 
+/* Must hold the client lock */
+static struct ion_handle *ion_handle_get_check_overflow(
+					struct ion_handle *handle)
+{
+	if (atomic_read(&handle->ref.refcount) + 1 == 0)
+		return ERR_PTR(-EOVERFLOW);
+	ion_handle_get(handle);
+	return handle;
+}
+
 static int ion_handle_put_nolock(struct ion_handle *handle)
 {
 	int ret;
@@ -433,9 +443,9 @@ static struct ion_handle *ion_handle_get_by_id_nolock(struct ion_client *client,
 
 	handle = idr_find(&client->idr, id);
 	if (handle)
-		ion_handle_get(handle);
+		return ion_handle_get_check_overflow(handle);
 
-	return handle ? handle : ERR_PTR(-EINVAL);
+	return ERR_PTR(-EINVAL);
 }
 
 struct ion_handle *ion_handle_get_by_id(struct ion_client *client,
@@ -1202,7 +1212,7 @@ struct ion_handle *ion_import_dma_buf(struct ion_client *client, int fd)
 	/* if a handle exists for this buffer just take a reference to it */
 	handle = ion_handle_lookup(client, buffer);
 	if (!IS_ERR(handle)) {
-		ion_handle_get(handle);
+		handle = ion_handle_get_check_overflow(handle);
 		mutex_unlock(&client->lock);
 		goto end;
 	}
-- 
2.18.0.865.gffc8e1a3cd6-goog

