Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AF5C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62B720989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761934;
	bh=bxypVAWxNG2m5U7h1Si8jklAJ9XP+2/IBURtTuPD71U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xlCe0wa1utcbmsLa3aMUJ1pI5XUqEEOeQueiZ7UW/Xw9Z7zJWlxcHK0ayfB1+eTI8
	 TfdhUqJAG8uTFRDj5a1ommIPNJ/6T0QD8SGp2jm5uVR6aH8YG4aRvsCB6e598/Un7x
	 HF/EKITAxq2XJdxPgGo0/2j21EH9xvY28O2sNiyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfA2Liw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:55474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbfA2Lit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149CE20844;
        Tue, 29 Jan 2019 11:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761928;
        bh=bxypVAWxNG2m5U7h1Si8jklAJ9XP+2/IBURtTuPD71U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nawfp/Q4mORTicO5+9XfRbS82iZpMaIYatPrJdd4Dxgq9YslZ4Tg6iu40ouMP4BS2
         SBvRHPeIU+pvCwro+vDkqVMXKxQYh+dFD46pqY4hJFkUc3Bd4fej5tvN9+8/fy7KqU
         +TO68MCLsAbWZ+TvcB3tyOhr3X8Nx/IaHHqnZQK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 4.20 049/117] misc: ibmvsm: Fix potential NULL pointer dereference
Date:   Tue, 29 Jan 2019 12:35:00 +0100
Message-Id: <20190129113210.048342918@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit e25df7812c91f62581301f9a7ac102acf92e4937 upstream.

There is a potential NULL pointer dereference in case kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on *session*

Also, update the function header with information about the
expected return on failure and remove unnecessary variable rc.

This issue was detected with the help of Coccinelle.

Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/ibmvmc.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -820,21 +820,24 @@ static int ibmvmc_send_msg(struct crq_se
  *
  * Return:
  *	0 - Success
+ *	Non-zero - Failure
  */
 static int ibmvmc_open(struct inode *inode, struct file *file)
 {
 	struct ibmvmc_file_session *session;
-	int rc = 0;
 
 	pr_debug("%s: inode = 0x%lx, file = 0x%lx, state = 0x%x\n", __func__,
 		 (unsigned long)inode, (unsigned long)file,
 		 ibmvmc.state);
 
 	session = kzalloc(sizeof(*session), GFP_KERNEL);
+	if (!session)
+		return -ENOMEM;
+
 	session->file = file;
 	file->private_data = session;
 
-	return rc;
+	return 0;
 }
 
 /**


