Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218825-2-7543774147312876383
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
    t=1519218825; b=bH4T+0GBr1xMkcvesnHuHX4Rzhx7FQ1TzaESm1pVBYhCUd0
    xNCJ/dRo1zKqGsOyr0jpp5S4jpGG3BUZlXfEHuZFoFz84+iS2p21h1vQ6ziA2w1O
    oWAPXyK7xzGX1L9jh8GWH+snI+OHdxxNm+e/FYRuKvHv3LzVJJ9lik43gicwKZF0
    rVhjzEgPkPuknAnzw1vVX3oJoEZSbM43rjRuUwXSDt+ttHsLdwo0Kkp/+4gydbRM
    rbWH7gWA6fKTAYUaqjSkUZuljl6FzLJTiRXt2CNxXGPA6EDJa38/ajj0LgSmR6b/
    I/NyxQPBFmuFzhLg6CtkEAYTGfv6FWITUSQuTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218825; bh=vN90t4oNKSlNbU95QRVX9BU+fI
    vzfvSbrLvgCAWfjxg=; b=J27otDX+pgga8sk3klg9NuEuB9HHGYlDLhI1UAR85T
    rAK7nxAxzExiEHdNn17HbBz/Vypbfzt9A7Y1KUcWzvjczWJSN56H1/2EmQlU+vov
    Aydt0rvWJt92sTmitzaoWyl4I0cJLqMG4Wiu/oIDqCbYzESBUM2a0L24yL7TzAiP
    0jZVXbc5avZKdgofgn5CnAEtJn0gyk3yo+0LSmgHnz/Puh1BVkUDCy3kDrDFplPJ
    oeQVAbTciFZ0U1lY3mc4VC+k4Bmu/wJudca0PlmT+RyPvAZPDfDg1HWKUXR4C43/
    hSn6szu7iUNa+kds7DZeeRGQ63/b7sol6psKQhjzPprw==
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
        id S1753216AbeBUNN3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:13:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754572AbeBUNN1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:27 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 4.15 138/163] Btrfs: fix btrfs_evict_inode to handle abnormal inodes correctly
Date: Wed, 21 Feb 2018 13:49:27 +0100
Message-Id: <20180221124537.793312598@linuxfoundation.org>
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

commit e8f1bc1493855e32b7a2a019decc3c353d94daf6 upstream.

This regression is introduced in
commit 3d48d9810de4 ("btrfs: Handle uninitialised inode eviction").

There are two problems,

a) it is ->destroy_inode() that does the final free on inode, not
   ->evict_inode(),
b) clear_inode() must be called before ->evict_inode() returns.

This could end up hitting BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
in evict() because I_CLEAR is set in clear_inode().

Fixes: commit 3d48d9810de4 ("btrfs: Handle uninitialised inode eviction")
Cc: <stable@vger.kernel.org> # v4.7-rc6+
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5266,7 +5266,7 @@ void btrfs_evict_inode(struct inode *ino
 	trace_btrfs_inode_evict(inode);
 
 	if (!root) {
-		kmem_cache_free(btrfs_inode_cachep, BTRFS_I(inode));
+		clear_inode(inode);
 		return;
 	}
 
