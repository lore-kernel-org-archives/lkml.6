Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC5C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F167C2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0K3B/XV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F167C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbeJKXPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJKXPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:43 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 539EB2098A;
        Thu, 11 Oct 2018 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272876;
        bh=3e9j3LzU2eVbbwbY4xJWGkiJxsMpleI0UAcxW1/++oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0K3B/XVTmTlnGHfM2Gj7P0a9Jl5HH4LFqhABXAMRo2O+HVMwQfDCOCrcPJr5CkK7
         Wg0Mubw6f4wJnNf8/HUPR98n3zjxS6KkSShyOrBdZFAf9XhrhOsuJYaQDDyYE6Emwi
         VVbEvMnjwr1l5+U96yZqntJGOSIpUhZoN0YJBvDI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.18 25/44] dm mpath: fix attached_handler_name leak and dangling hw_handler_name pointer
Date:   Thu, 11 Oct 2018 17:40:03 +0200
Message-Id: <20181011152453.538311351@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Snitzer <snitzer@redhat.com>

commit b592211c33f745af67a3271ce77c10fc1e6d6241 upstream.

Commit e8f74a0f0011 ("dm mpath: eliminate need to use
scsi_device_from_queue") introduced 2 regressions:
1) memory leak occurs if attached_handler_name is not assigned to
   m->hw_handler_name
2) m->hw_handler_name can become a dangling pointer if the
   RETAIN_ATTACHED_HW_HANDLER flag is set and scsi_dh_attach() returns
   -EBUSY.

Fix both of these by clearing 'attached_handler_name' pointer passed to
setup_scsi_dh() after it is assigned to m->hw_handler_name.  And if
setup_scsi_dh() doesn't consume 'attached_handler_name' parse_path()
will kfree() it.

Fixes: e8f74a0f0011 ("dm mpath: eliminate need to use scsi_device_from_queue")
Cc: stable@vger.kernel.org # 4.16+
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-mpath.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -806,19 +806,19 @@ static int parse_path_selector(struct dm
 }
 
 static int setup_scsi_dh(struct block_device *bdev, struct multipath *m,
-			 const char *attached_handler_name, char **error)
+			 const char **attached_handler_name, char **error)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	int r;
 
 	if (test_bit(MPATHF_RETAIN_ATTACHED_HW_HANDLER, &m->flags)) {
 retain:
-		if (attached_handler_name) {
+		if (*attached_handler_name) {
 			/*
 			 * Clear any hw_handler_params associated with a
 			 * handler that isn't already attached.
 			 */
-			if (m->hw_handler_name && strcmp(attached_handler_name, m->hw_handler_name)) {
+			if (m->hw_handler_name && strcmp(*attached_handler_name, m->hw_handler_name)) {
 				kfree(m->hw_handler_params);
 				m->hw_handler_params = NULL;
 			}
@@ -830,7 +830,8 @@ retain:
 			 * handler instead of the original table passed in.
 			 */
 			kfree(m->hw_handler_name);
-			m->hw_handler_name = attached_handler_name;
+			m->hw_handler_name = *attached_handler_name;
+			*attached_handler_name = NULL;
 		}
 	}
 
@@ -867,7 +868,7 @@ static struct pgpath *parse_path(struct
 	struct pgpath *p;
 	struct multipath *m = ti->private;
 	struct request_queue *q;
-	const char *attached_handler_name;
+	const char *attached_handler_name = NULL;
 
 	/* we need at least a path arg */
 	if (as->argc < 1) {
@@ -890,7 +891,7 @@ static struct pgpath *parse_path(struct
 	attached_handler_name = scsi_dh_attached_handler_name(q, GFP_KERNEL);
 	if (attached_handler_name || m->hw_handler_name) {
 		INIT_DELAYED_WORK(&p->activate_path, activate_path_work);
-		r = setup_scsi_dh(p->path.dev->bdev, m, attached_handler_name, &ti->error);
+		r = setup_scsi_dh(p->path.dev->bdev, m, &attached_handler_name, &ti->error);
 		if (r) {
 			dm_put_device(ti, p->path.dev);
 			goto bad;
@@ -905,6 +906,7 @@ static struct pgpath *parse_path(struct
 
 	return p;
  bad:
+	kfree(attached_handler_name);
 	free_pgpath(p);
 	return ERR_PTR(r);
 }


