Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414753-2-6733391590311004418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414753; b=LGRxUP4vJfb3zDeg+suPSQJ/VefOayouW/99HI+Lct7Nomq
    qR2bVHFAXqCQ6kyAz9OX1+eY8ftKEfVFPcKeJ2AcPInawbxEhoZ0YtJE7sHGkM44
    AsSbpMaVOEMOjB29oWyx1uc8paB0z5GdAbY95Bn+2+VhD4V+48yANvPnYv+RBYCk
    73dIyz0ue+kJxo3UfOon/Rs3K8AJhQgBHJAcvlAJygGUNR+uYq2kDOR3/rbesTA6
    0clLofTh7Soh95c6wdKIc/nIqu2fH43WiaN2kQgM1xAbU6eyGHcKsp+fMItAI4o6
    JZwzezT9kfhtFFTmMhTqFgm+yAU1eOmpxFKzv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414753; bh=rQDKzcZHB5Oymhh9fwQpKYlLYA
    Po3oc5WtZpnUM+0qw=; b=GmSa31dOKuARM8nbR4VYw6dVdgjgPNHBwTOWvVuBkK
    onxQdywtW6hqCpgbbHaBLvLUtXM60EvHx1LystJ1CVSvb+b6huddGWC03NLUtjfo
    YrhiYb3R6PL6fDBl3jBt2zUATBbRy+kkilhnnlZGoWMcrcJEELGY4pBuF2Vytr0A
    Ab0FeIs/qt8hWfrt+FwjgnxTJwG1RmFXo88RJ538S5bSMZ6AdAwvRCUyfWnk5unM
    2UrUI0tONDu+sLOB+KWUoYEIhiakN04YvgDv0aBg4rhbiolA5LTFSOHmHxNsQFLp
    Aqw9JVt2RlDgO4SXT++LgX9/+ECEqPWCXF9fT4o1rMcA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934603AbeBWStv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:51 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45440 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934134AbeBWStt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.14 019/159] dnotify: Handle errors from fsnotify_add_mark_locked() in fcntl_dirnotify()
Date: Fri, 23 Feb 2018 19:25:27 +0100
Message-Id: <20180223170745.516049276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit b3a0066005821acdc0cdb092cb72587182ab583f upstream.

fsnotify_add_mark_locked() can fail but we do not check its return
value. This didn't matter before commit 9dd813c15b2c "fsnotify: Move
mark list head from object into dedicated structure" as none of possible
failures could happen for dnotify but after that commit -ENOMEM can be
returned. Handle this error properly in fcntl_dirnotify() as
otherwise we just hit BUG_ON(dn_mark->dn) in dnotify_free_mark().

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reported-by: syzkaller
Fixes: 9dd813c15b2c101168808d4f5941a29985758973
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/notify/dnotify/dnotify.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/fs/notify/dnotify/dnotify.c
+++ b/fs/notify/dnotify/dnotify.c
@@ -319,7 +319,11 @@ int fcntl_dirnotify(int fd, struct file
 		dn_mark = container_of(fsn_mark, struct dnotify_mark, fsn_mark);
 		spin_lock(&fsn_mark->lock);
 	} else {
-		fsnotify_add_mark_locked(new_fsn_mark, inode, NULL, 0);
+		error = fsnotify_add_mark_locked(new_fsn_mark, inode, NULL, 0);
+		if (error) {
+			mutex_unlock(&dnotify_group->mark_mutex);
+			goto out_err;
+		}
 		spin_lock(&new_fsn_mark->lock);
 		fsn_mark = new_fsn_mark;
 		dn_mark = new_dn_mark;
@@ -345,6 +349,7 @@ int fcntl_dirnotify(int fd, struct file
 		 */
 		if (dn_mark == new_dn_mark)
 			destroy = 1;
+		error = 0;
 		goto out;
 	}
 
