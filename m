Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518719490-2-6127473248150555782
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
    t=1518719489; b=hDd2qltsZZJHhzmtyZNVQoq0Xb7utQF8iUWGYDvGONGnfkE
    27eaWsBuBZkJPqmkCTWTMv70HGwB2MkWSWTr3cu4AwrsKvCi0Etk3U5psGNQVrmu
    wVPLqKI5RY+k6+xAI0ogQaGUsNlpOHplFWXzT3QnY52sCzvR47QzjGNsGKk15WyA
    iSdZUVtQnoQ8FZzici6g9HZ7yBiaIYJbD7M1/Sqvn+Ps/uu114azsoLYWO4xDUsb
    ZUDDNiYIiCT9s85itKSggNz6uKTpda2ate91nm4FmRC9QGYCOotHvLI7w7o1H1x1
    nbQmLi/ryMMHXqe5kFuXk+lKhUYLPJhOyiQtBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719489; bh=+ytpOuzdMSWEaW4v30u2zoKUKV
    iXb3qAuxlhWMa5jXQ=; b=t53oOeh1Tn3UogvgpHUh05fjGAMVQLyM9++Axd8Oko
    jvcBlxJ/icDhin/CBjfg5yqiTB2YZ1N5bn6kc4ikoKTM/71Y+D1jSx4xOsdQTkag
    oo5MrtrMubBE1IMWCmTwDwpAq4+xNSOwe7Akl+v4nXwwHCWI+YKbsqET399sl8KW
    5GqwIe5roYAVoRypNKbwAX1PXFPtQXlpcc2Wc7f3akmMv+Ydw+kx2lpy2OptfnN/
    mqbsCNjiLhetDYi8ReYu/1Ut06M6ab304jlpaHaH/sMJ4xasIAIt0M/CoK5xS88a
    qIo8tZOO9HMuOXDfVbyxZM0Df+ywzE/nx6U5HAm4rBdQ==
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
        id S1162990AbeBOSbO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:31:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163046AbeBOPZB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:25:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 103/108] btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker
Date: Thu, 15 Feb 2018 16:17:40 +0100
Message-Id: <20180215151236.655363934@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 fs/btrfs/inode.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2015,7 +2015,15 @@ again:
 		goto out;
 	 }
 
-	btrfs_set_extent_delalloc(inode, page_start, page_end, &cached_state);
+	ret = btrfs_set_extent_delalloc(inode, page_start, page_end,
+					&cached_state);
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
