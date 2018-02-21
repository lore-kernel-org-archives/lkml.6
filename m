Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218894-2-14548008424695772540
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218893; b=uFgRHf6+UeFYPAUKZT4+qizuFwQjZHFpu00XG9+4Q3Iv5ql
    IeYxnREON0Fmk6Pl+UZWBWP9wL8aTLMQeOFlEpwIjGjXBdLaD/8DeLnmi7ZeXbLq
    8BOwL441F4AUlNrknQtEjmPvoRuHBRnM/tJta1sOxNtLXBNDmiMfFFJq/8BckaYz
    5sDg/yf1uMzQaWsnvR+voD4WKnw8G17rYxCs6GK/X9EE8dar9I/OXiuHD87RNsr9
    bQwkGCxlNsDJ5FZqCJ7mbailQqcJPqmFcrIZtieXImHFyULnw2YzocxFrAMtQrxr
    qbnLaDDNTSrRG3Tnu7SvM6vtT8C+GdLr28csDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218893; bh=9EdFVSYaorMUNh6JXp+e8Mkfrp
    uw158akSWVcU4LBRA=; b=RjFYwvejfXd6LptQYWzs2lTZL5rUtM3m5tPEldURij
    1ieeIE3vgQBR6ohSqFavlRuTqu3RpqCgamHHYBLMBBh0eBnSiZ93/1dcV/bkws8K
    MWm7MLxBpAbJ1CSvBQoIGh1Euhr4D2VlGU14qIJNjNZeztfnQcm3oC4XhbH8TD4R
    LDm0QpcsOSEMTM18WBsWh1oTbFLepxg/DsPf1PnOfo8WrHXqnR7CfmriT5FFdUxL
    mhDl6S10Z7tfFhgvdVO2rKQlEJLORQYqmNxWzVaPXdyYjR0WumfhFJrl5Dn635VL
    qnod13mcx19721ALy/VNjQTqyS00fAg68O2nzflhMVJg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeBUNOh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:14:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965724AbeBUNNW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 136/163] Btrfs: fix crash due to not cleaning up tree log blocks dirty bits
Date: Wed, 21 Feb 2018 13:49:25 +0100
Message-Id: <20180221124537.701931714@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 1846430c24d66e85cc58286b3319c82cd54debb2 upstream.

In cases that the whole fs flips into readonly status due to failures in
critical sections, then log tree's blocks are still dirty, and this leads
to a crash during umount time, the crash is about use-after-free,

umount
 -> close_ctree
    -> stop workers
    -> iput(btree_inode)
       -> iput_final
          -> write_inode_now
	     -> ...
	       -> queue job on stop'd workers

cc: <stable@vger.kernel.org> v3.12+
Fixes: 681ae50917df ("Btrfs: cleanup reserved space when freeing tree log on error")
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2494,6 +2494,9 @@ static noinline int walk_down_log_tree(s
 					clean_tree_block(fs_info, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner !=
@@ -2574,6 +2577,9 @@ static noinline int walk_up_log_tree(str
 					clean_tree_block(fs_info, next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+				} else {
+					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+						clear_extent_buffer_dirty(next);
 				}
 
 				WARN_ON(root_owner != BTRFS_TREE_LOG_OBJECTID);
@@ -2652,6 +2658,9 @@ static int walk_log_tree(struct btrfs_tr
 				clean_tree_block(fs_info, next);
 				btrfs_wait_tree_block_writeback(next);
 				btrfs_tree_unlock(next);
+			} else {
+				if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
+					clear_extent_buffer_dirty(next);
 			}
 
 			WARN_ON(log->root_key.objectid !=
