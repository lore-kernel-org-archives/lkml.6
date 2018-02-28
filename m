Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2956071-1519782305-2-12354701083905759301
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519782304; b=tnHSCvGciDi4ImgapWHhxZFL6SX3IwaY1trqHODJFps1Mn1
    lVsZvk69VABwfxQv6u5kpP1mQicstPyZQO4OsIk/ftLVsE0ebHXLqONlWE54P4GK
    FULmqQsyhGzPyFEXS4v9H/mxNMylxMwhRv2xXv6/IhU9eBWDz4rDwZ8HrvHiHpEt
    JQoimBrwGPn12BJKhw9kuOoZRZUZK9j5iAnpJpv6HWYeHVmcuWXITh16JlZdKFhP
    9i1BrZ0gZQPiDx9UM7+FIvtOBjG/ujuqC0HUuLZAMxjDfsF26PeaSFzRusRxYr6R
    gDpd8pjKUzLr2mebtqWZbyHV9lyxIokITUpnTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519782304; bh=eHMe08aO2UCvDQlW4NGq+Dh/B3
    jaTPeBrF54BQwtrw0=; b=rUlqKcNJR6HwHtYxWpAFM461h4VQ+pp3zXFQ8KLp1j
    s2AMRHTkFGILuaYjPAh45b0LSr8RzyAErAGdGn7Qb+qDbGNywRb3ss0I9hgQcdJn
    4W4AREFpC3M7aiBkHG1x4ex5mVBDURxq6O3lzxyhqLc7ellSKRkko2jF9XtiJJUy
    N+uFYkiS4ph/KPwA8vaG7p0+dw/2CCMMHGezqNwNqbwAGpDWv9T3sjQYnyNSgwzs
    Z8Msq1tl82x5Pug08BF5fQGMqXc9ofqzDiH6YDZAF5WQd/o8MmkCdpqFHRbRMZrE
    IdesjPuI4+ERaKH5Ce3lvmcZOeUcy3RZsi51tTO4r8og==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dk-develop.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dk-develop.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=dk-develop.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=dk-develop.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbeB1BpC (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 20:45:02 -0500
Received: from hs01.dk-develop.de ([213.136.71.231]:43228 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeB1BpC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 20:45:02 -0500
From: Danilo Krummrich <danilokrummrich@dk-develop.de>
To: mcgrof@kernel.org, keescook@chromium.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        stable@vger.kernel.org
Subject: [PATCH v3 1/2] fs/sysctl: fix potential page fault while unregistering sysctl table
Date: Wed, 28 Feb 2018 02:35:05 +0100
Message-Id: <20180228013506.4915-1-danilokrummrich@dk-develop.de>
X-Mailer: git-send-email 2.14.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

proc_sys_link_fill_cache() does not take currently unregistering
sysctl tables into account, which might result into a page fault in
sysctl_follow_link() - add a check to fix it.

This bug has been present since v3.4.

Fixes: 0e47c99d7fe25 ("sysctl: Replace root_list with links between sysctl_table_sets")
Cc: stable@vger.kernel.org
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
---
v2: removed empty line between between sysctl_head_grab and IS_ERR
v3: extend commit message, add tags and cc stable
---
 fs/proc/proc_sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c5cbbdff3c3d..82ac5f682b73 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -707,7 +707,10 @@ static bool proc_sys_link_fill_cache(struct file *file,
 				    struct ctl_table *table)
 {
 	bool ret = true;
+
 	head = sysctl_head_grab(head);
+	if (IS_ERR(head))
+		return false;
 
 	if (S_ISLNK(table->mode)) {
 		/* It is not an error if we can not follow the link ignore it */
-- 
2.14.1
