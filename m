Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519988987-2-11036052237330354458
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
    t=1519988987; b=YY5+grjetw1MRuTxDEBi36F7tC0KKZF25dsL9vYjWUbKO08
    gAoLS1QsvGY+iQjdc3dZs8GYlxKjGKX94nnbPUz11yWSi3WtesYa/akPJjmrkzzj
    vXVS9k9OlK58URE2BphomRbw+CWJS+2iF+xb27ljNp123x/Y8+HKR6X/0FQwcVzc
    XI+EtTmGhhTcfRgy9zDO20UkFkUXWIRFybf1A2K0NfGE6oWitGAndor80wGHt7iY
    JxzE8/g60OhJzsAZiPENG8DuztuELOnSqgsO5XTK/IAEoUDKw3Bb1N0yvH0USx3r
    K5ZJeLn9iREkJoOzgA/VL7zJ5sAA6I/ikKLKE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519988987; bh=qdXiG9/jlNmmsXAptrEEio4FaR
    0kjt+0MpscDbygZ04=; b=CcABBek3dHDnEe+De/hlgkAfCSt2zSeTupFg9ubLiw
    ucZSgqiwiuDxYN4Mgn5FB1yifylYymiM+aniqVmjFkAkctFjlG4wykTq5jD1EB9G
    E9YaydxdL6hobhRjT4h/aJVnUJ/2gSMowwuncZP49k3M3JLjT9kXYKpGryiuiER7
    708PP54HbRzCbiDngzQptbcB0ug8EitfdR0XWLBrGRYJkj4HDSJBa6ZFvN28QMow
    yb9CacZWsZgGJgasEP75OT9cnNB2mgMj/T1nxiRZuLu1g7xElZb/IIFnoZLCiRic
    Pw19R5aZIlmTKojcXv7CbjLXdG2oNNnJNJR+3iJfWjzA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423495AbeCBLJ1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:09:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50466 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423515AbeCBIyd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:33 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nitzan Carmi <nitzanc@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 18/34] IB/mlx4: Fix mlx4_ib_alloc_mr error flow
Date: Fri,  2 Mar 2018 09:51:14 +0100
Message-Id: <20180302084437.138817347@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
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


[ Upstream commit 5a371cf87e145b86efd32007e46146e78c1eff6d ]

ibmr.device is being set only after ib_alloc_mr() is successfully complete.
Therefore, in case imlx4_mr_enable() returns with error, the error flow
unwinder calls to mlx4_free_priv_pages(), which uses ibmr.device.

Such usage causes to NULL dereference oops and to fix it, the IB device
should be set in the mr struct earlier stage (e.g. prior to calling
mlx4_free_priv_pages()).

Fixes: 1b2cd0fc673c ("IB/mlx4: Support the new memory registration API")
Signed-off-by: Nitzan Carmi <nitzanc@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/mr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -424,7 +424,6 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib
 		goto err_free_mr;
 
 	mr->max_pages = max_num_sg;
-
 	err = mlx4_mr_enable(dev->dev, &mr->mmr);
 	if (err)
 		goto err_free_pl;
@@ -435,6 +434,7 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib
 	return &mr->ibmr;
 
 err_free_pl:
+	mr->ibmr.device = pd->device;
 	mlx4_free_priv_pages(mr);
 err_free_mr:
 	(void) mlx4_mr_free(dev->dev, &mr->mmr);
