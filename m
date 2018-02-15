Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720212-2-9002192787945826297
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
    t=1518720211; b=xBQVVVIaUrYYIGKemXrskLG7WOcokye369jFFU/GaVVCwZd
    jjh+fMzjRz2fBmRQ6+vhcYV4z1dPj/86PYQvbruNy9lleJg9Dk1/pxraUNM+ECGJ
    6Rn9s+GD7A25tUOO/vvDYvA/2FZ4eGD5Y510eBB9+UAMZEuyq2RUIu4nWA5maAhb
    338+ZgU2C8e0fMkp/ptUyadvduYCMb7845LU1Hn5deUJv27scgGxCnsUHl+ghUoB
    K2As1FvJTfRxLTcJwbk6IYtHR0huDWVw4j1jTFIeTKZVgqbcOpFGXI6DhOMgFWqs
    sLo9Kq/ZxAG+6AJ+WbdmZlaFM27e568HAc2bcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720211; bh=e9Dp+XiPAIGIhUGKX9OreGrB25
    gC6FfqO/ruiYtYQKw=; b=E/a2Wg26s5anFL95M2Js0paEFJdtb7WEbi70XDkkEj
    849ZdE/EWWOQkaiBCBOtR2XF07GyhPp8QerXC0I6pFfgl/beYTc2xNw14genglAU
    Rp/Jlq2IWVOBIluw0tZ/bOPV0MVhDcj7rZglVWnKzOgl4VgdXv+iczqZmJEF+65w
    xDpvNu+vX1EmRanJ1mTuJlP07I3LVassGBIVySLMEaMQGvd++ycyYxmUGdXQCNSu
    lcsB5BZ2ZUtUB01s/ItTa+12ZJb0AlBWZCZClHmY7XpQJ3McgqeH6ss7qPGk9mWx
    4226BjGvQUXrywYtcMbq/Qy4Pj0+gahONHfJ3Y1ODtqA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162659AbeBOSnQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:43:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162636AbeBOPXW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.4 060/108] NFS: Add a cond_resched() to nfs_commit_release_pages()
Date: Thu, 15 Feb 2018 16:16:57 +0100
Message-Id: <20180215151230.825319379@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit 7f1bda447c9bd48b415acedba6b830f61591601f upstream.

The commit list can get very large, and so we need a cond_resched()
in nfs_commit_release_pages() in order to ensure we don't hog the CPU
for excessive periods of time.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/write.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1746,6 +1746,8 @@ static void nfs_commit_release_pages(str
 		set_bit(NFS_CONTEXT_RESEND_WRITES, &req->wb_context->flags);
 	next:
 		nfs_unlock_and_release_request(req);
+		/* Latency breaker */
+		cond_resched();
 	}
 	nfss = NFS_SERVER(data->inode);
 	if (atomic_long_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
