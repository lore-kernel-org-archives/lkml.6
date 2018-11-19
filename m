Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBCF214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw6HhPi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBCF214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406661AbeKTD3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:29:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405697AbeKTD3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:29:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8230F2148E;
        Mon, 19 Nov 2018 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542647090;
        bh=t6nbDjaxbkqHlvYOn97kO2s8z0ptO3o41zSVcB+71Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xw6HhPi6/5LYkznOhBFNqGf51snqBKXbFOch9R0UV+7yG3Q0D+Wv23CfZ6+k7TGjb
         q18xvLm1c1fK9myzauvPPP6T1Snlip8fMfjcGfFxqGoDRxx1neqQNLBvOK6B/WCO6o
         xBZJmf3Joap+tNCf5ifHLhPC9K8w7uvd6qNBXqNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 3.18 46/90] dm ioctl: harden copy_params()s copy_from_user() from malicious users
Date:   Mon, 19 Nov 2018 17:29:28 +0100
Message-Id: <20181119162628.273091078@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenwen Wang <wang6495@umn.edu>

commit 800a7340ab7dd667edf95e74d8e4f23a17e87076 upstream.

In copy_params(), the struct 'dm_ioctl' is first copied from the user
space buffer 'user' to 'param_kernel' and the field 'data_size' is
checked against 'minimum_data_size' (size of 'struct dm_ioctl' payload
up to its 'data' member).  If the check fails, an error code EINVAL will be
returned.  Otherwise, param_kernel->data_size is used to do a second copy,
which copies from the same user-space buffer to 'dmi'.  After the second
copy, only 'dmi->data_size' is checked against 'param_kernel->data_size'.
Given that the buffer 'user' resides in the user space, a malicious
user-space process can race to change the content in the buffer between
the two copies.  This way, the attacker can inject inconsistent data
into 'dmi' (versus previously validated 'param_kernel').

Fix redundant copying of 'minimum_data_size' from user-space buffer by
using the first copy stored in 'param_kernel'.  Also remove the
'data_size' check after the second copy because it is now unnecessary.

Cc: stable@vger.kernel.org
Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-ioctl.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1681,8 +1681,7 @@ static void free_params(struct dm_ioctl
 }
 
 static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kernel,
-		       int ioctl_flags,
-		       struct dm_ioctl **param, int *param_flags)
+		       int ioctl_flags, struct dm_ioctl **param, int *param_flags)
 {
 	struct dm_ioctl *dmi;
 	int secure_data;
@@ -1730,18 +1729,13 @@ static int copy_params(struct dm_ioctl _
 		return -ENOMEM;
 	}
 
-	if (copy_from_user(dmi, user, param_kernel->data_size))
-		goto bad;
+	/* Copy from param_kernel (which was already copied from user) */
+	memcpy(dmi, param_kernel, minimum_data_size);
 
-data_copied:
-	/*
-	 * Abort if something changed the ioctl data while it was being copied.
-	 */
-	if (dmi->data_size != param_kernel->data_size) {
-		DMERR("rejecting ioctl: data size modified while processing parameters");
+	if (copy_from_user(&dmi->data, (char __user *)user + minimum_data_size,
+			   param_kernel->data_size - minimum_data_size))
 		goto bad;
-	}
-
+data_copied:
 	/* Wipe the user buffer so we do not return it to userspace */
 	if (secure_data && clear_user(user, param_kernel->data_size))
 		goto bad;


