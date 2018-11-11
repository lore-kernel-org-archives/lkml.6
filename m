Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4CAC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011042154B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPtaoxka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011042154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbeKLISY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732732AbeKLISX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:23 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9B521527;
        Sun, 11 Nov 2018 22:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975306;
        bh=Jm7k4xB1B+WYhI453kUhLXtsrU2a9OxI2c8ALHu4hzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPtaoxkaBb8CI5UXFR0ysLly14d54CTStwj76ObRjBDVCE88Gu54U/UNBT5IK3kAt
         Vpu/B4P6jRVDTaTK+4v2jSOkumjjyaxcyhZ46i13M+K0XSh9D7+EXk4L+zdsN2NeNE
         VcgcIDMhzjZvL4SKNkBy9GshMGq9qx8ZnW8OwQb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 275/361] dm ioctl: harden copy_params()s copy_from_user() from malicious users
Date:   Sun, 11 Nov 2018 14:20:22 -0800
Message-Id: <20181111221655.352396081@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1720,8 +1720,7 @@ static void free_params(struct dm_ioctl
 }
 
 static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kernel,
-		       int ioctl_flags,
-		       struct dm_ioctl **param, int *param_flags)
+		       int ioctl_flags, struct dm_ioctl **param, int *param_flags)
 {
 	struct dm_ioctl *dmi;
 	int secure_data;
@@ -1762,18 +1761,13 @@ static int copy_params(struct dm_ioctl _
 
 	*param_flags |= DM_PARAMS_MALLOC;
 
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


