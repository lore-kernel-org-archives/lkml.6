Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591072-2-4545124551605576724
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
    t=1517591070; b=cq0PoIoaKKeib0hqQ7p5AatfJtoAb0xzWaA2Xf5MxzA0MP6
    spHpULKAd+qC5mdrFVv/SihzAD50YQ/QJU+ECPQES4uR7eSrkX5vbUW1wZsN/vGl
    p1gXwls90arcE/g/cc+FaRFVX63+OpwzHrucRAB1UQIY5tJ/UaMB+u9ISdBdcfu/
    1HlWhrAxldMEXxNDjS+s6onGQWwkXXN1kGWHG1TNXMcnpO3aqC0fiXb7JDL9WPye
    cuqifqU0k++P6ttpNUxqO+RdbOx/TWA7LySuDK9vWev/3z61kJrwAneSedOY3Xe3
    pPBA84hv/RE+EtHFvTDpLvgYcT1UDg6Egd+weLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591070; bh=hvCsXe56oQzXX1rd80VlZdJAWQ
    Wbv81ojSXX9SIQ25g=; b=dY/H6Jl/cdO8We27ArfYCNCYnE3Nr7b+gKM6IeGHpJ
    eoYdP9i7lir9VxN94mztlIunXHI/a683wUS5wZBGpW5S0UXo2ZpDmJXT1EcPRO+y
    5B+k5eML4WoY7RrHGBHn1fDsxpawE3oR8DQCle/WVt2ckBhbriFQ91AOX3uge+he
    yJj5/w2RVC8TPnWr2ncdgv9epNHb+B+1BDKHFGhxCPPyLX+UGwH3XnD9YL8S6IHt
    4JcGx+1TJ22fZPvtQFa8Z7VAXBlEOe8YczQh/Bm0TS9RMMJXzzwMmrlEVM4v+LDF
    K0vMCwqGC9G15O687mLFbBQgCMOZ1Y3IWCfgUANt9jXw==
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
        id S1752861AbeBBREW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:04:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36118 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbeBBREJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:04:09 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Omar Sandoval <osandov@fb.com>, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 34/86] btrfs: fix deadlock when writing out space cache
Date: Fri,  2 Feb 2018 17:57:54 +0100
Message-Id: <20180202140825.686102707@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
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

From: Josef Bacik <jbacik@fb.com>


[ Upstream commit b77000ed558daa3bef0899d29bf171b8c9b5e6a8 ]

If we fail to prepare our pages for whatever reason (out of memory in
our case) we need to make sure to drop the block_group->data_rwsem,
otherwise hilarity ensues.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add label and use existing unlocking code ]
Signed-off-by: David Sterba <dsterba@suse.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/free-space-cache.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1253,7 +1253,7 @@ static int __btrfs_write_out_cache(struc
 	/* Lock all pages first so we can lock the extent safely. */
 	ret = io_ctl_prepare_pages(io_ctl, inode, 0);
 	if (ret)
-		goto out;
+		goto out_unlock;
 
 	lock_extent_bits(&BTRFS_I(inode)->io_tree, 0, i_size_read(inode) - 1,
 			 &cached_state);
@@ -1346,6 +1346,7 @@ out_nospc_locked:
 out_nospc:
 	cleanup_write_cache_enospc(inode, io_ctl, &cached_state, &bitmap_list);
 
+out_unlock:
 	if (block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA))
 		up_write(&block_group->data_rwsem);
 
