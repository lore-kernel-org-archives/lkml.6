Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519981511-2-12979479835729903418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981510; b=kIIXPBnGrkjIkyeecb/Lln4sv4WTn5rHGuaOpZ4WEZBEsHQ
    +squi/6dl1fy41HAnfN7tKQMaV//lCy+Oo4klvmqk4U8htBHN+KpFoSZRqmP1CQT
    bgk2GIHPrgdZb8xJQYXbxS5/HqztvZTeZdaMJUcJD+sPssnaJVAgjQHRk5WEyasd
    IJwZNliJnW/BmZWctjBYaeIkz8ym4Jj+OASA003JcPVA3aIuUR/Slq86qNphh++D
    zAkAFRdL3sZrC8NOn51XxBaElKZIflJiJdegtm2wL5F2ZVjwygnOLnbzzja6RcAY
    fCEt0lKE48ekwoveP6BAxCJVJv3PrPDs3z/YkpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981510; bh=CNOkjZZUFDgfXDTVy6o1msf1Aj
    agpn/hNpjQ8KYj74M=; b=eYfuly6Hxm73zklcFZuW4QCJ9QGH8ez+5JRjjRKUUH
    Vf0TowxrOjhiR5zgYPCA8A05lZ26q7m4/Ikr3grWzL4qa0ebgLRHbcLycKJlfTYJ
    +Nf91M0kJLQN8cqHVj3GQaYRbwwU4FzYhXUpJWrWa3ftJVzZMMMqkRAr/T1etHWR
    q5uJ9AjbJHo0PJJ2mIBVLAbzW5+BzdgDAud0j7byDxMs0wANteoL4K/2cw5Mj7q+
    kz1nyXi3hUSw5ZkQ0rRkdregURXu6SaeBWawzuPkXnDGE8NmgJCf4GK1N0ofutP1
    D+u16SP7OiYMJPaGmgmj7oSE40m2EA3kt1iZHgaAlOBg==
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
        id S1425111AbeCBJEW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:04:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425107AbeCBJEU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:04:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Nitzan Carmi <nitzanc@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 063/115] IB/mlx5: Fix mlx5_ib_alloc_mr error flow
Date: Fri,  2 Mar 2018 09:51:06 +0100
Message-Id: <20180302084506.427431038@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nitzan Carmi <nitzanc@mellanox.com>


[ Upstream commit 45e6ae7ef21b907dacb18da62d5787d74a31d860 ]

ibmr.device is being set only after ib_alloc_mr() is
(successfully) complete. Therefore, in case mlx5_core_create_mkey()
return with error, the error flow calls mlx5_free_priv_descs()
which uses ibmr.device (which doesn't exist yet), causing
a NULL dereference oops.

To fix this, the IB device should be set in the mr struct earlier
stage (e.g. prior to calling mlx5_core_create_mkey()).

Fixes: 8a187ee52b04 ("IB/mlx5: Support the new memory registration API")
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Nitzan Carmi <nitzanc@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/mr.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1637,6 +1637,7 @@ struct ib_mr *mlx5_ib_alloc_mr(struct ib
 	MLX5_SET(mkc, mkc, access_mode, mr->access_mode);
 	MLX5_SET(mkc, mkc, umr_en, 1);
 
+	mr->ibmr.device = pd->device;
 	err = mlx5_core_create_mkey(dev->mdev, &mr->mmkey, in, inlen);
 	if (err)
 		goto err_destroy_psv;
