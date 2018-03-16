Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221746-2-9949921310063322008
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
    t=1521221746; b=LGAIAbWdC4OEia2ypVbI75QSKizLO8p1Ry2B8vz8grJy+Vg
    slGzgfZnZq36LOEhS73EmDFasXQDP3DzfBs09W8UInE79j2jFpPc6/BgdOGj0kB/
    sgZdyJKqIXrShf0HMgAWhlPAJsZ+dg3SwW8KpwFAEkPOkQ48j+1qzrphih6CAMIM
    4eVgiV1xFxBpP2+O1AYViJEjVOyJN/CT1pTZTidtqv5MbSQnYgPdAvsE/PPKxOWp
    fmOyd1daA4X6yMmZ3Axoa1Kr6yzz8poBHVj63tjRYwxUS2rRsjI6LiZmGj/Aj5P+
    63qzDQZ1CwkSKuwoldUkgs0te3utXMWqlhZaV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221746; bh=Qjc4/uF36jNnyGu59Mp5T2399A
    K+u+jLZdbu8TOLJXw=; b=hSwGJgd0trGwymREyrKMqa+IVlgzcJrHZlYAouFnsE
    9vPRYvwT5aZ9KBdG8bGfM/A4tkCsWTHLUkLKRTFxWlRRUapVtJ47Lox9aM7ixgkD
    Xr1YM5z33et3Z24CBIk9cOhwo9chOIClXwQ6NBMPKzsDpRTngS4N8nAL7qsTjS+Z
    dQrkILTvX68PP+DYFFlhbW0Qvj21sMYcRkoN9rsir5ONE1KMOjcfwdxq+l1Gk7eR
    IZlGc1f1dDuabkL+eYSPZqdHxeCjkUlFJCameklnQ1twnhECUXcY+BE6v9jJ2o4s
    BMyHL4rDATz39zmC80cLgSWQAmOPRrxxCNsI+JuK0g5w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeCPP0w (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:26:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754152AbeCPP0v (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0df1ab766f8924b1edba@syzkaller.appspotmail.com,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.4 02/63] RDMA/ucma: Check that user doesnt overflow QP state
Date: Fri, 16 Mar 2018 16:22:34 +0100
Message-Id: <20180316152300.209728755@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit a5880b84430316e3e1c1f5d23aa32ec6000cc717 upstream.

The QP state is limited and declared in enum ib_qp_state,
but ucma user was able to supply any possible (u32) value.

Reported-by: syzbot+0df1ab766f8924b1edba@syzkaller.appspotmail.com
Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1138,6 +1138,9 @@ static ssize_t ucma_init_qp_attr(struct
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
 
+	if (cmd.qp_state > IB_QPS_ERR)
+		return -EINVAL;
+
 	ctx = ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
