Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0099AC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C4020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C4020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeJNXYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:24:12 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36968 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJNXYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:24:09 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004cZ-B6; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000K8-5Y; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Jeff Mahoney" <jeffm@suse.com>,
        "" <syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com>,
        "Jan Kara" <jack@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.556099704@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 135/366] fs/reiserfs/journal.c: add missing
 resierfs_warning() arg
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

From: Andrew Morton <akpm@linux-foundation.org>

commit 9ad553abe66f8be3f4755e9fa0a6ba137ce76341 upstream.

One use of the reiserfs_warning() macro in journal_init_dev() is missing
a parameter, causing the following warning:

  REISERFS warning (device loop0): journal_init_dev: Cannot open '%s': %i journal_init_dev:

This also causes a WARN_ONCE() warning in the vsprintf code, and then a
panic if panic_on_warn is set.

  Please remove unsupported %/ in format string
  WARNING: CPU: 1 PID: 4480 at lib/vsprintf.c:2138 format_decode+0x77f/0x830 lib/vsprintf.c:2138
  Kernel panic - not syncing: panic_on_warn set ...

Just add another string argument to the macro invocation.

Addresses https://syzkaller.appspot.com/bug?id=0627d4551fdc39bf1ef5d82cd9eef587047f7718

Link: http://lkml.kernel.org/r/d678ebe1-6f54-8090-df4c-b9affad62293@infradead.org
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: <syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Jeff Mahoney <jeffm@suse.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/reiserfs/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2641,7 +2641,7 @@ static int journal_init_dev(struct super
 	if (IS_ERR(journal->j_dev_bd)) {
 		result = PTR_ERR(journal->j_dev_bd);
 		journal->j_dev_bd = NULL;
-		reiserfs_warning(super,
+		reiserfs_warning(super, "sh-457",
 				 "journal_init_dev: Cannot open '%s': %i",
 				 jdev_name, result);
 		return result;

