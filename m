Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518711122-2-10684312462998984150
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518711122; b=LnLmVLVEwrHa5f6CmsvMkxJS/K7KVL6LE/+PWHkFH188m3m
    yP+TugAvc++hr0/jGJZfi6V/hka8nP71bp6/AtbFD0axjwpLjfPUjJmg+LtIM5Xv
    o4xyrHLUuKKR3nMo00NnmrkQCrZK72GfMiJzINpZ111jmET1tKMNe/OskcSoylT0
    Pg3+pqOaOOSjVN0TGztunU2lv36/l92sFY8Z9u/j+XcSp2FtsoFx5CUgIQiuZd6/
    BQF6FJ0z8ZC8ZvppzS0vSzJcyuWpzFqzFhg/e0OqOjwGZ1xldeqKR3zXjTAgxDbE
    DKduA1X2w2rQ0pdp9SXYxXv9SGM/oVF4YWVgJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711122; bh=I+0/ZHKDCH/A3penlwhp5kXEuS
    fYDrvOQJglVeDvWMk=; b=wVDlvGubT/Eo+31hsfyxn6cVwEv4yDUP0jZ4BSEj1L
    PxAHk1bBn+SvmsZMd9tNqGH/Tkti2KgB/hHTt4OpbbKU0NCWrV2J075O7OBcCI3e
    uQ6OWk86oTaPFWUMLbuX8tWQ7+M+JHxaqJNmV0kBr3a2fufEZ9fDxbGaZZPor6zz
    blfamqSyAz2xXNJ7TRdfM/XzWxt1KXxWBFPHsj6kjielSlLin3T/EzrV6/Qd3ZjH
    g/+DD2rpVuF9HPZVhsOD9FwHUhXOuXFSS4mUu9wCdqZG3bBhnUrTEar+nuZf4xMN
    KeFx8IOvnnlMMC/SRsvOlfZT+8pRQSs0OEplWI428VlA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424806AbeBOQLg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:11:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424433AbeBOPpS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 146/202] btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker
Date: Thu, 15 Feb 2018 16:17:26 +0100
Message-Id: <20180215151720.664579239@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit f3038ee3a3f1017a1cbe9907e31fa12d366c5dcb upstream.

This function was introduced by 247e743cbe6e ("Btrfs: Use async helpers
to deal with pages that have been improperly dirtied") and it didn't do
any error handling then. This function might very well fail in ENOMEM
situation, yet it's not handled, this could lead to inconsistent state.
So let's handle the failure by setting the mapping error bit.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2098,8 +2098,15 @@ again:
 		goto out;
 	 }
 
-	btrfs_set_extent_delalloc(inode, page_start, page_end, 0, &cached_state,
-				  0);
+	ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
+					&cached_state, 0);
+	if (ret) {
+		mapping_set_error(page->mapping, ret);
+		end_extent_writepage(page, ret, page_start, page_end);
+		ClearPageChecked(page);
+		goto out;
+	}
+
 	ClearPageChecked(page);
 	set_page_dirty(page);
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
