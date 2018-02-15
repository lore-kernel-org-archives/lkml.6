Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1518708554-2-1692640446698015978
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
    t=1518708554; b=SuCoUUlx4ReTXMSa9Pa6u276PXPSFqvchr2TwDazyop8UvT
    PyTWFnKiR9rwlJBveMx4lQ219QirXjJETcJDrpbpgMDW6zDtPtqfp2sCIhatYCnS
    0Og7Q3/M6dIqB1mQYfDC9IQF47731tJQ8yYxrFTGJUNqTNJAk6yjlKJcH3/KSAUk
    dx940mqzYVzkWoSTNqUKM3aZsKiJgUFn/JQGPgrM8yELjdWSR20Ln9CM1P+Iq/qc
    7jK3hHh2jwBddngqa5AYDc9YSQQEMo5JCQlhC6n9SC8Vhbr1o0BC6MArZ1TVYkG2
    MSOM3CMtRYaeF4nUSXd1nZVbbOr6o7xwoADPQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518708554; bh=FxSUjAGk7yyxyypAgZRdTiriMS
    wIZJRvpz9wDXLv4Bc=; b=hU6goUqTdY1ntcEnFUXzTy3mKRpfIHyfSyToqmkNwc
    nqiW2JbnuKAEZbaa/j/EB4T30pgMrqtvoUMbgwPfUpOzkrjcKwUa5r+qYt8ZCHDj
    OWcdaEX9txofPzclQs/0mOgD/EwRHR/M3FnA+MLQ0UquxIW3zmNgPK4GPwppBR9Z
    5EolAGD49dgxA5cEpD1xxFmgUakWv5gi/Z/27dKKUwXL/XCc56TwoelRT64Rvo8F
    xkEzxgdniZ2e0NYpMjV19OSSjLSrmiDI1lm+rsdlJDjhV6X2YnT3kXdoEIvEOU0H
    fa7drc0uBddRoJcGZqdbdj0ZBMH9+bak1ayif7m0lWLA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163926AbeBOP3L (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:29:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163973AbeBOP3J (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:29:09 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 82/88] btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker
Date: Thu, 15 Feb 2018 16:17:49 +0100
Message-Id: <20180215151233.825344562@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2063,8 +2063,15 @@ again:
 		goto out;
 	 }
 
-	btrfs_set_extent_delalloc(inode, page_start, page_end, &cached_state,
-				  0);
+	ret = btrfs_set_extent_delalloc(inode, page_start, page_end,
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
 out:
