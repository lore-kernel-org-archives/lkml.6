Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC97AC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C15420835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C15420835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeJNXPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:15:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36556 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbeJNXPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:15:05 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004cg-B9; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000K3-4D; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Kees Cook" <keescook@chromium.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Danilo Krummrich" <danilokrummrich@dk-develop.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.538975909@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 134/366] fs/proc/proc_sysctl.c: fix potential page
 fault while unregistering sysctl table
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <danilokrummrich@dk-develop.de>

commit a0b0d1c345d0317efe594df268feb5ccc99f651e upstream.

proc_sys_link_fill_cache() does not take currently unregistering sysctl
tables into account, which might result into a page fault in
sysctl_follow_link() - add a check to fix it.

This bug has been present since v3.4.

Link: http://lkml.kernel.org/r/20180228013506.4915-1-danilokrummrich@dk-develop.de
Fixes: 0e47c99d7fe25 ("sysctl: Replace root_list with links between sysctl_table_sets")
Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/proc/proc_sysctl.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -654,7 +654,10 @@ static bool proc_sys_link_fill_cache(str
 				    struct ctl_table *table)
 {
 	bool ret = true;
+
 	head = sysctl_head_grab(head);
+	if (IS_ERR(head))
+		return false;
 
 	if (S_ISLNK(table->mode)) {
 		/* It is not an error if we can not follow the link ignore it */

