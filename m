Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591468-2-8037827218103122397
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
    t=1517591467; b=WP7Z5cNGWesPLP9ZmTALf++lt3uvYTl0WvMOKK9lCPQdPZg
    PSpcQBZPalVmif45cMQctNIfsMtY8ti2riCZVfAidtPGyM6BwjwxF8KRodAYuMcd
    gfRkx+6pDZYXa6hv/IPC9SDG8zLy13ZfwdQnw0LQeEdRab8oDC+9g3sxhpQZrZEK
    3DR2SwoEMry6H2sRbah6fjZPLyzDlZJrNhdgBkT9Ax2XK5IXEd8tltHILJ4s74uJ
    RT/dsVitoAVhdNx68aTiSnHPpEZ76LegrIa1brSCXx3jiRFa8lN69gj61WveBFiu
    OZkoVpuimF0YS+/Lik606cHRMjTtRFxZnRjv+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591467; bh=9PpoTkxBfiQv1n1UFDYy1ZMw/y
    usGlpTCl3aqW8bzBw=; b=wSQjSNppj4P6Tm7LtvaZ7+3pyFxsPsxZLV+2J4Pmy5
    R6pCIGbRvMkBJuH8l9C3KqV2p9FkuZV8chhKalEZHQTWjvL8ruIWLrNyCavpkNdP
    V8ggJK8I7vKcgbMmXTn4XCqD1zVCdihYzpBJNwK5E3xv2IBmrBxeYsnAlfuYJS8H
    +JqnOJBNjHihmNVXW5hJZZN6K0sRYoDcQghMuXKA46m9tsgRRTy9vxnKYIg6BgTp
    L+wtY4Ng2ZnbFHUY0Za3aX85uCTpoYB/QVh7ZGR99qwt9rDxd+yhkKxtgz+IVk3s
    k4jGFzED6algLPsCwIWQ3N7kH+olYGq24iJc3Eyrw7IA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeBBRLF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:11:05 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38502 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753355AbeBBRK6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:10:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 087/156] grace: replace BUG_ON by WARN_ONCE in exit_net hook
Date: Fri,  2 Feb 2018 17:57:48 +0100
Message-Id: <20180202140844.185927878@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>


[ Upstream commit b872285751c1af010e12d02bce7069e2061a58ca ]

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs_common/grace.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -104,7 +104,9 @@ grace_exit_net(struct net *net)
 {
 	struct list_head *grace_list = net_generic(net, grace_net_id);
 
-	BUG_ON(!list_empty(grace_list));
+	WARN_ONCE(!list_empty(grace_list),
+		  "net %x %s: grace_list is not empty\n",
+		  net->ns.inum, __func__);
 }
 
 static struct pernet_operations grace_net_ops = {
