Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803639-2-9319123919941165023
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803638; b=fDQFE+zH137ryceC4fMbdHju8PO6zf0X9HYOykoqJ+Yl2m6
    Y6IWRt/nALq0G1UvAopeDsDACNzsQpZDCNqzT+HEzwVDzNiRR+dcZhva4Q308A+g
    CEgzqqkl7Kbwb/X/ky/PqimeSDdZnr3VANg4Z017FGv3T7SlUhPhA0lA47wC1/kC
    k8HiMkO9cgWVRbko9rtgoNvLDC07mnyCSkEL845JndqSwVNmyCzkq2E28JSciblt
    G4NnEo/AgVd1jr68XiRCYo9fd8wPr9Zi7DkuEnirDT8NtHabfnLKrX49OyionGql
    2R8DSJrz9vAiamUnfWuOJp/I+KDDPWHGy9ibv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803638; bh=KrXuHRqp9xoKorhiK8qYp2qCMC
    MIh5RjtVtNIUMp9+0=; b=sO2HyLOVmoaipeMof20ugh8beCK2e3oMvLcQQuPw8l
    jW3qBxcH910F6XieykR69J0BQJybDKIhJ0rxRXvwxxRCN0XeZwgkJ8HdoarjrhF3
    BfN3zt92QtlXxUO3MqpLsmcVd/BKz70pB8sBlivTvGr3zgLNhyOINUnFQHMd6iJ/
    6aUw6BTAjrolAXCPB+nVk2cAItpO6pZXcKdN2iwrP4Hj87HtqPw3vzppDh3aA54y
    NLOS6vQEjoMdeGK25mvS+nq4yO04zmTFYcsZY428DVT8xdrjE+FC9teaPPtkIlIt
    1EJbUimgj4QxSJpx3fve+XZpLiBtHDlWPCHlxTx90R8A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754798AbeCWLNp (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:13:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42548 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932681AbeCWKK2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 123/177] pNFS: Fix a deadlock when coalescing writes and returning the layout
Date: Fri, 23 Mar 2018 10:54:11 +0100
Message-Id: <20180323094210.671622255@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit 61f454e30c18a28924e96be12592c0d5e24bcc81 ]

Consider the following deadlock:

Process P1	Process P2		Process P3
==========	==========		==========
					lock_page(page)

		lseg = pnfs_update_layout(inode)

lo = NFS_I(inode)->layout
pnfs_error_mark_layout_for_return(lo)

		lock_page(page)

					lseg = pnfs_update_layout(inode)

In this scenario,
- P1 has declared the layout to be in error, but P2 holds a reference to
  a layout segment on that inode, so the layoutreturn is deferred.
- P2 is waiting for a page lock held by P3.
- P3 is asking for a new layout segment, but is blocked waiting
  for the layoutreturn.

The fix is to ensure that pnfs_error_mark_layout_for_return() does
not set the NFS_LAYOUT_RETURN flag, which blocks P3. Instead, we allow
the latter to call LAYOUTGET so that it can make progress and unblock
P2.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/pnfs.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1953,8 +1953,6 @@ void pnfs_error_mark_layout_for_return(s
 
 	spin_lock(&inode->i_lock);
 	pnfs_set_plh_return_info(lo, range.iomode, 0);
-	/* Block LAYOUTGET */
-	set_bit(NFS_LAYOUT_RETURN, &lo->plh_flags);
 	/*
 	 * mark all matching lsegs so that we are sure to have no live
 	 * segments at hand when sending layoutreturn. See pnfs_put_lseg()
