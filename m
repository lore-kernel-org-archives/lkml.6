Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59202C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6B421486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6B421486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeIXRoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:44:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51174 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729028AbeIXRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:44:54 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 318CE1072;
        Mon, 24 Sep 2018 11:43:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ronny Chevalier <ronny.chevalier@hp.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 095/105] audit: fix use-after-free in audit_add_watch
Date:   Mon, 24 Sep 2018 13:34:21 +0200
Message-Id: <20180924113122.291270269@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
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

From: Ronny Chevalier <ronny.chevalier@hp.com>

[ Upstream commit baa2a4fdd525c8c4b0f704d20457195b29437839 ]

audit_add_watch stores locally krule->watch without taking a reference
on watch. Then, it calls audit_add_to_parent, and uses the watch stored
locally.

Unfortunately, it is possible that audit_add_to_parent updates
krule->watch.
When it happens, it also drops a reference of watch which
could free the watch.

How to reproduce (with KASAN enabled):

    auditctl -w /etc/passwd -F success=0 -k test_passwd
    auditctl -w /etc/passwd -F success=1 -k test_passwd2

The second call to auditctl triggers the use-after-free, because
audit_to_parent updates krule->watch to use a previous existing watch
and drops the reference to the newly created watch.

To fix the issue, we grab a reference of watch and we release it at the
end of the function.

Signed-off-by: Ronny Chevalier <ronny.chevalier@hp.com>
Reviewed-by: Richard Guy Briggs <rgb@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/audit_watch.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -414,6 +414,13 @@ int audit_add_watch(struct audit_krule *
 	struct path parent_path;
 	int h, ret = 0;
 
+	/*
+	 * When we will be calling audit_add_to_parent, krule->watch might have
+	 * been updated and watch might have been freed.
+	 * So we need to keep a reference of watch.
+	 */
+	audit_get_watch(watch);
+
 	mutex_unlock(&audit_filter_mutex);
 
 	/* Avoid calling path_lookup under audit_filter_mutex. */
@@ -422,8 +429,10 @@ int audit_add_watch(struct audit_krule *
 	/* caller expects mutex locked */
 	mutex_lock(&audit_filter_mutex);
 
-	if (ret)
+	if (ret) {
+		audit_put_watch(watch);
 		return ret;
+	}
 
 	/* either find an old parent or attach a new one */
 	parent = audit_find_parent(parent_path.dentry->d_inode);
@@ -444,6 +453,7 @@ int audit_add_watch(struct audit_krule *
 	*list = &audit_inode_hash[h];
 error:
 	path_put(&parent_path);
+	audit_put_watch(watch);
 	return ret;
 }
 


