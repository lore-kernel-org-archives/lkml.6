Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221785-2-2768853054882278627
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
    t=1521221784; b=j7PMOyjea+jseeE51tNANuXRfI/saq2DJKGkUk6JJ59Bu+R
    vs88k4FepZzEdbqqM07fcxZUQ6G3G/9x/Db1oOURER/3R8sIrrvSfOrnH9EAJtFz
    Pos2SFzP4ESsbWpvzdL3ksYNAiUZCJvPIn++9QpCpkzHtfpqeEbokk5k54I6CZiZ
    m45FKtR7GIE4g5JPxUbDXZ2IghzHxIOAQEMs1z2JDWKtCAKJvR9FC4mZ4wtZgG5W
    Zshm1S7SK48jMyFn28hTh1H3A/MFBWE1C3cCeC/LpniKIzkBkEydfInoBkDZoHCt
    xbM+HWsvIl4lu+SwFY9G7EYJJknGaLXqbRve2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221784; bh=MnK9T/4VQvzcgEiRc2s0AjXE03
    V/eaTJuKgOBJjYE8M=; b=Tw4DM8YsMFTlsKwGSVw0kxLh+q6gCon4MLl7PGHjfW
    +aA1G3nyP4lKSlW37z4hvLdxTVaRllkDapdL4+Ytim6v//gKBaBzBJiglIaWnxag
    pLZMidtDnHdzCbAM25CNNi8boKgWqbX8kqWfah7bkWpudhEe5K2AzZAnxQ4pdeGC
    ZiikeKh5www3Xon30RaSZ7MunJgeZDwYBLI6RKr6+WtA1KSCLDc+pL5mmhhcNF4E
    gtyShrbPLPEE7F1P6tyIKS6bRwNtP4E6K+yf6FS/lM/Xu1nui9NAQnaiL0z0uA7D
    NwE3Vj8SSnmjhpvP7EM7ZkP/6+udl+pBlMtXcN/OX5/g==
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
        id S1753500AbeCPRgI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:36:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33968 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753340AbeCPP0s (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.4 01/63] RDMA/ucma: Limit possible option size
Date: Fri, 16 Mar 2018 16:22:33 +0100
Message-Id: <20180316152300.134957368@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
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

From: Leon Romanovsky <leonro@mellanox.com>

commit 6a21dfc0d0db7b7e0acedce67ca533a6eb19283c upstream.

Users of ucma are supposed to provide size of option level,
in most paths it is supposed to be equal to u8 or u16, but
it is not the case for the IB path record, where it can be
multiple of struct ib_path_rec_data.

This patch takes simplest possible approach and prevents providing
values more than possible to allocate.

Reported-by: syzbot+a38b0e9f694c379ca7ce@syzkaller.appspotmail.com
Fixes: 7ce86409adcd ("RDMA/ucma: Allow user space to set service type")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/ucma.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1274,6 +1274,9 @@ static ssize_t ucma_set_option(struct uc
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (unlikely(cmd.optval > KMALLOC_MAX_SIZE))
+		return -EINVAL;
+
 	optval = memdup_user((void __user *) (unsigned long) cmd.optval,
 			     cmd.optlen);
 	if (IS_ERR(optval)) {
