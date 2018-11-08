Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2792ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E7B20989
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ud6rNtXQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E7B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbeKIHfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:35:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbeKIHfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:35:36 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC4020892;
        Thu,  8 Nov 2018 21:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714287;
        bh=yA8nd/eCdmXL759eisJIFbBhRZIz9MLUFnl0TwbW+Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ud6rNtXQdZ2ehdkn+MPBDugSPrAnjIc4HHlJ5J7qSAF4CrVQr6X0SDq3e055Drm+w
         +elabQ6OHnyxxqu7JURd691xDyVzXY6BjDvzetxoKz8lS1vJFOZtVbhLS5zBLxvpZa
         CHb6iW+aofLxAVgMCggnqmjZ2p6AcEN3IxdqWvtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 126/144] unix: correctly track in-flight fds in sending process user_struct
Date:   Thu,  8 Nov 2018 13:51:37 -0800
Message-Id: <20181108215107.231326943@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
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

[ Upstream commit 415e3d3e90ce9e18727e8843ae343eda5a58fad6 ]

The commit referenced in the Fixes tag incorrectly accounted the number
of in-flight fds over a unix domain socket to the original opener
of the file-descriptor. This allows another process to arbitrary
deplete the original file-openers resource limit for the maximum of
open files. Instead the sending processes and its struct cred should
be credited.

To do so, we add a reference counted struct user_struct pointer to the
scm_fp_list and use it to account for the number of inflight unix fds.

Fixes: 712f4aad406bb1 ("unix: properly account for FDs passed over unix sockets")
Reported-by: David Herrmann <dh.herrmann@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/af_unix.h | 4 ++--
 include/net/scm.h     | 1 +
 net/core/scm.c        | 7 +++++++
 net/unix/af_unix.c    | 4 ++--
 net/unix/garbage.c    | 8 ++++----
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index e830c3dff61a..7bb69c9c3c43 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -6,8 +6,8 @@
 #include <linux/mutex.h>
 #include <net/sock.h>
 
-void unix_inflight(struct file *fp);
-void unix_notinflight(struct file *fp);
+void unix_inflight(struct user_struct *user, struct file *fp);
+void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_gc(void);
 void wait_for_unix_gc(void);
 struct sock *unix_get_socket(struct file *filp);
diff --git a/include/net/scm.h b/include/net/scm.h
index 262532d111f5..59fa93c01d2a 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -21,6 +21,7 @@ struct scm_creds {
 struct scm_fp_list {
 	short			count;
 	short			max;
+	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
 };
 
diff --git a/net/core/scm.c b/net/core/scm.c
index d30eb057fa7b..cad57a1390dd 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -87,6 +87,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		*fplp = fpl;
 		fpl->count = 0;
 		fpl->max = SCM_MAX_FD;
+		fpl->user = NULL;
 	}
 	fpp = &fpl->fp[fpl->count];
 
@@ -107,6 +108,10 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		*fpp++ = file;
 		fpl->count++;
 	}
+
+	if (!fpl->user)
+		fpl->user = get_uid(current_user());
+
 	return num;
 }
 
@@ -119,6 +124,7 @@ void __scm_destroy(struct scm_cookie *scm)
 		scm->fp = NULL;
 		for (i=fpl->count-1; i>=0; i--)
 			fput(fpl->fp[i]);
+		free_uid(fpl->user);
 		kfree(fpl);
 	}
 }
@@ -337,6 +343,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 		for (i = 0; i < fpl->count; i++)
 			get_file(fpl->fp[i]);
 		new_fpl->max = new_fpl->count;
+		new_fpl->user = get_uid(fpl->user);
 	}
 	return new_fpl;
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 29b1f4dc48ca..1bd4ba6b6aa4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1469,7 +1469,7 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	UNIXCB(skb).fp = NULL;
 
 	for (i = scm->fp->count-1; i >= 0; i--)
-		unix_notinflight(scm->fp->fp[i]);
+		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
 }
 
 static void unix_destruct_scm(struct sk_buff *skb)
@@ -1534,7 +1534,7 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 		return -ENOMEM;
 
 	for (i = scm->fp->count - 1; i >= 0; i--)
-		unix_inflight(scm->fp->fp[i]);
+		unix_inflight(scm->fp->user, scm->fp->fp[i]);
 	return max_level;
 }
 
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 58783dcfd35d..1105a60468ac 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -122,7 +122,7 @@ struct sock *unix_get_socket(struct file *filp)
  *	descriptor if it is for an AF_UNIX socket.
  */
 
-void unix_inflight(struct file *fp)
+void unix_inflight(struct user_struct *user, struct file *fp)
 {
 	struct sock *s = unix_get_socket(fp);
 
@@ -139,11 +139,11 @@ void unix_inflight(struct file *fp)
 		}
 		unix_tot_inflight++;
 	}
-	fp->f_cred->user->unix_inflight++;
+	user->unix_inflight++;
 	spin_unlock(&unix_gc_lock);
 }
 
-void unix_notinflight(struct file *fp)
+void unix_notinflight(struct user_struct *user, struct file *fp)
 {
 	struct sock *s = unix_get_socket(fp);
 
@@ -158,7 +158,7 @@ void unix_notinflight(struct file *fp)
 			list_del_init(&u->link);
 		unix_tot_inflight--;
 	}
-	fp->f_cred->user->unix_inflight--;
+	user->unix_inflight--;
 	spin_unlock(&unix_gc_lock);
 }
 
-- 
2.17.1



