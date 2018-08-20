Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC1CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B457208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="oBEeZzzC";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="1MgYflPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B457208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbeHTKYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:24:16 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:37287 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbeHTKYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:24:15 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 28FF720EC6;
        Mon, 20 Aug 2018 10:09:45 +0300 (MSK)
Received: from smtpcorp1o.mail.yandex.net (smtpcorp1o.mail.yandex.net [2a02:6b8:0:1a2d::30])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id mWrWIfh9Ec-9i8aqtwZ;
        Mon, 20 Aug 2018 10:09:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534748985; bh=v2UiUhFBFDW+wYuJgRzxbrXopFfwTO6oBrcAWPpFxCE=;
        h=Subject:From:To:Date:Message-ID;
        b=oBEeZzzCDN71Zye+HL3I7FkpsnS4zUCxulvxVDY5kQxM5pa3twoT8Z7EvGUua1BnX
         naBOgIsSjiIj1+iYmKjgLxvxmefQdLnUNbnLxvMrn8fjYz/isg3tO0aL5WOvvWHw4v
         IbfaoLQai0R9FqFJUOHKC6yKjpau4MikSwXejlC8=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ac1b:4357:f84c:a04a])
        by smtpcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id RYALdQGwKc-9iNmAwJh;
        Mon, 20 Aug 2018 10:09:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534748984; bh=v2UiUhFBFDW+wYuJgRzxbrXopFfwTO6oBrcAWPpFxCE=;
        h=Subject:From:To:Date:Message-ID;
        b=1MgYflPpAMOuW97ij7qwfZtupaRnzFsG+eiXldWsD8oXkS46dzo33ynOXc4UNdGhg
         5JVzf2ANss6sbHzY2nUd4QWZ9ZQqSG7feEpKcC09KMxHQdvjpKlFaCpWY49rxZkRS6
         57fiYJsdwA4DOqQ8+gVhYJa8CckWp8qgOuWDIuWM=
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] fanotify: use killable wait for waiting response for
 permission events
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Date:   Mon, 20 Aug 2018 10:09:42 +0300
Message-ID: <153474898224.6806.12518115530793064797.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiting in uninterruptible state for response from userspace
easily produces deadlocks and hordes of unkillable tasks.

This patch makes this wait killable.

At receiving fatal signal task will remove queued event and die.
If event is already handled then response will be received as usual.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/notify/fanotify/fanotify.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index eb4e75175cfb..7a0c37790c89 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -64,7 +64,27 @@ static int fanotify_get_response(struct fsnotify_group *group,
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
-	wait_event(group->fanotify_data.access_waitq, event->response);
+	ret = wait_event_killable(group->fanotify_data.access_waitq,
+				  event->response);
+	if (ret) {
+		/* Try to remove pending event from the queue */
+		spin_lock(&group->notification_lock);
+		if (!list_empty(&event->fae.fse.list))
+			list_del_init(&event->fae.fse.list);
+		else
+			ret = 0;
+		spin_unlock(&group->notification_lock);
+
+		if (ret)
+			return ret;
+
+		/*
+		 * We cannot return, this will destroy event while
+		 * process_access_response() fills response.
+		 * Just wait for wakeup and continue normal flow.
+		 */
+		wait_event(group->fanotify_data.access_waitq, event->response);
+	}
 
 	/* userspace responded, convert to something usable */
 	switch (event->response & ~FAN_AUDIT) {

