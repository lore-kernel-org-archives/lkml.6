Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C2AC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B8B2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWbO29gt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B8B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbeKLIUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733238AbeKLIUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:48 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CF1223CA;
        Sun, 11 Nov 2018 22:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975451;
        bh=4Ntq5c92oVm1/yETUZWrtff/mqoymfcTVwWlBMJXdzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWbO29gt0vfedz7Fv+dPSSzzbble35kFAed6MrsL0e/t+k87w5S0FgBqUTbVmlx4G
         IjWfrcDSREW6rbtrmgXKrL35NuSvQV/vvt5lKTBBgHINciaY3xqJqVnHs/CQ+OMwGv
         qMXwrn42pxKhIvpzPI77IA0li3A6N5gpP3b3Wukw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7f4a27091759e2fe7453@syzkaller.appspotmail.com,
        Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.18 218/350] jbd2: fix use after free in jbd2_log_do_checkpoint()
Date:   Sun, 11 Nov 2018 14:21:22 -0800
Message-Id: <20181111221717.146841015@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit ccd3c4373eacb044eb3832966299d13d2631f66f upstream.

The code cleaning transaction's lists of checkpoint buffers has a bug
where it increases bh refcount only after releasing
journal->j_list_lock. Thus the following race is possible:

CPU0					CPU1
jbd2_log_do_checkpoint()
					jbd2_journal_try_to_free_buffers()
					  __journal_try_to_free_buffer(bh)
  ...
  while (transaction->t_checkpoint_io_list)
  ...
    if (buffer_locked(bh)) {

<-- IO completes now, buffer gets unlocked -->

      spin_unlock(&journal->j_list_lock);
					    spin_lock(&journal->j_list_lock);
					    __jbd2_journal_remove_checkpoint(jh);
					    spin_unlock(&journal->j_list_lock);
					  try_to_free_buffers(page);
      get_bh(bh) <-- accesses freed bh

Fix the problem by grabbing bh reference before unlocking
journal->j_list_lock.

Fixes: dc6e8d669cf5 ("jbd2: don't call get_bh() before calling __jbd2_journal_remove_checkpoint()")
Fixes: be1158cc615f ("jbd2: fold __process_buffer() into jbd2_log_do_checkpoint()")
Reported-by: syzbot+7f4a27091759e2fe7453@syzkaller.appspotmail.com
CC: stable@vger.kernel.org
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/checkpoint.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -251,8 +251,8 @@ restart:
 		bh = jh2bh(jh);
 
 		if (buffer_locked(bh)) {
-			spin_unlock(&journal->j_list_lock);
 			get_bh(bh);
+			spin_unlock(&journal->j_list_lock);
 			wait_on_buffer(bh);
 			/* the journal_head may have gone by now */
 			BUFFER_TRACE(bh, "brelse");
@@ -333,8 +333,8 @@ restart2:
 		jh = transaction->t_checkpoint_io_list;
 		bh = jh2bh(jh);
 		if (buffer_locked(bh)) {
-			spin_unlock(&journal->j_list_lock);
 			get_bh(bh);
+			spin_unlock(&journal->j_list_lock);
 			wait_on_buffer(bh);
 			/* the journal_head may have gone by now */
 			BUFFER_TRACE(bh, "brelse");


