Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520452005-2-5308732351271466365
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
    t=1520452004; b=r/LPKSaGDkpejLIL4QCQyaei0iAvh4vOBCDTy5eoYUgwzfV
    KOuSLu3BOfLQXFQIjKmKHW40RE7yGTTcs+b/vAdAPsWzflUVRPSMj1ximE/Ncv9L
    n1lRongH2Za7Rb3P5UlDa0/AdeCgHWVqZ6o6HZNAYxwGFzwOt0BVodjwoywmHhRa
    pIC6LSz5LZJpzFjEangICmISlFv7dzUBvH5TWFEwbJAe9oRC9Sg5ParrF2vPZQ/F
    LkLB4jEntoEdbyCp1QPInofCQgRAksHCz/GXb9+bFNWD+QhVniUuHY6w5ZM5fKNN
    K8wLAUfNDdS+CvUJOKPFWIVkk9c7uk0efpaqUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452004; bh=JpH8RjP4XpcI9zwx8kO/CUwBgC
    10Zr9CRQ0YcqQMwuo=; b=wnFhF/2EhK5Lc5dJ080AhJENKonMVIn3vf4InN++/U
    cTI0ghdwllFPDdprOovKiLle6JtehkTiv9PLuvvxVEO3ys4VpoDdpM2eYabDqgJQ
    q6y+2ni3oTJM7Pnmj8XwfVwHaznmKZInqZSyym9MSuK7IQwSJuCNWrCvQm/0DjIc
    uAd51T/5SkLSS586BlEWeeQyoC404wIED+J2gkFqFq8m8/P6QZclXTW7lRUPWmLl
    D95okcdoa8XRYCxHfEm0JT1x/UnKwoBywyZFzvVWSJ8Yva3wk6moEd78HmhrW/6G
    JK5aF7hIQTrNCTcsWCX0P5PbP4HD8elZ4rdlSgGBfGYg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S965574AbeCGTqk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965259AbeCGTqh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.14 066/110] net/mlx5e: Verify inline header size do not exceed SKB linear size
Date: Wed,  7 Mar 2018 11:38:49 -0800
Message-Id: <20180307191047.994943325@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: Eran Ben Elisha <eranbe@mellanox.com>


[ Upstream commit f600c6088018d1dbc5777d18daa83660f7ea4a64 ]

Driver tries to copy at least MLX5E_MIN_INLINE bytes into the control
segment of the WQE. It assumes that the linear part contains at least
MLX5E_MIN_INLINE bytes, which can be wrong.

Cited commit verified that driver will not copy more bytes into the
inline header part that the actual size of the packet. Re-factor this
check to make sure we do not exceed the linear part as well.

This fix is aligned with the current driver's assumption that the entire
L2 will be present in the linear part of the SKB.

Fixes: 6aace17e64f4 ("net/mlx5e: Fix inline header size for small packets")
Signed-off-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -155,7 +155,7 @@ static inline u16 mlx5e_calc_min_inline(
 	default:
 		hlen = mlx5e_skb_l2_header_offset(skb);
 	}
-	return min_t(u16, hlen, skb->len);
+	return min_t(u16, hlen, skb_headlen(skb));
 }
 
 static inline void mlx5e_tx_skb_pull_inline(unsigned char **skb_data,
