Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1977CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C840B2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C840B2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeHWL3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:29:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44370 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbeHWL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:29:37 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DBBE9CA0;
        Thu, 23 Aug 2018 08:01:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "linux-kernel@vger.kernel.org, kernel-team@android.com, Daniel Rosenberg" 
        <drosen@google.com>, Daniel Rosenberg <drosen@google.com>
Subject: [PATCH 4.4 66/79] staging: android: ion: check for kref overflow
Date:   Thu, 23 Aug 2018 09:53:42 +0200
Message-Id: <20180823074923.483861489@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074918.641878835@linuxfoundation.org>
References: <20180823074918.641878835@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Rosenberg <drosen@google.com>

This patch is against 4.4. It does not apply to master due to a large
rework of ion in 4.12 which removed the affected functions altogther.
4c23cbff073f3b9b ("staging: android: ion: Remove import interface")

Userspace can cause the kref to handles to increment
arbitrarily high. Ensure it does not overflow.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: Fixed patch corruption :(


It applies from 3.18 to 4.11, although with a trivial conflict resolution
for the later branches.
 drivers/staging/android/ion/ion.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/drivers/staging/android/ion/ion.c
+++ b/drivers/staging/android/ion/ion.c
@@ -15,6 +15,7 @@
  *
  */
 
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/file.h>
@@ -387,6 +388,16 @@ static void ion_handle_get(struct ion_ha
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
@@ -433,9 +444,9 @@ static struct ion_handle *ion_handle_get
 
 	handle = idr_find(&client->idr, id);
 	if (handle)
-		ion_handle_get(handle);
+		return ion_handle_get_check_overflow(handle);
 
-	return handle ? handle : ERR_PTR(-EINVAL);
+	return ERR_PTR(-EINVAL);
 }
 
 struct ion_handle *ion_handle_get_by_id(struct ion_client *client,
@@ -1202,7 +1213,7 @@ struct ion_handle *ion_import_dma_buf(st
 	/* if a handle exists for this buffer just take a reference to it */
 	handle = ion_handle_lookup(client, buffer);
 	if (!IS_ERR(handle)) {
-		ion_handle_get(handle);
+		handle = ion_handle_get_check_overflow(handle);
 		mutex_unlock(&client->lock);
 		goto end;
 	}


