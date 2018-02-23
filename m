Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413810-2-16099918616785533864
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413810; b=vMnlAQjKq0fYCAPTfGa/0oOezNNMRheqehDZCDa9fSLTNg9
    k5H2/Kjw0Kh1nyhjb/fWmSxSVfzqy770aKDUs/tK4MznfrpXG0/2rLE9Ad0w2QQY
    2tjMpL+f0KQwOKtPqu0e1NhRtEQhwkuGkRK/cnlvVxfNhbtkhHqx0a/BORwCALTG
    1QJzsWggHQ66feFhT4MNd4E6sdz5+rcWz+vlIPKgpWMDQJImvtHODTG0QeqEkPpk
    r13VsZKdfIrZT7RVE+98y0Avux7m0XohItsiwm8Io5jaOudNvsuSXqJpRRlNR7QG
    WQLqU4kQ1vZFusz04Ve3yCSXWUfLJo569/Kljkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413810; bh=oAiIZ5HQfCJ8r15xmpAO1DhMHC
    Iw8KwsUJ9Igianag0=; b=KQnzERccR51q5z9hDAB/QPHmILmybtIw/MHLuHdPGB
    aMsPFFuRbMBxoB0scxDyvw0kkVJ8/aMETE5/bPpMvuWZLo0hpySaNmx05BkpeODl
    +cXpqhlSnhsCVhiELbXQL6whACz0JeB+UHkNBlCcp1o9a14nDiufGo1NZ4bd57hx
    ABilJRyG6DFWLzYAp5Ilp7U7416MjP9H25t2ff/DXCvS4kaBNUi1hI3uH946HCiD
    gYKvbEdCrzQYTKCFT2VhmrYiEQQnhMHD5aXftu5bK6G+FUmLiM+BhFOU2jVFReRU
    Z41tMfIKZz0c8ow+3CrOfYVRoBH+LakPcB3/X8Jl3LLg==
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
        id S1754532AbeBWTXO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:23:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935396AbeBWSx1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:27 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Moni Shoua <monis@mellanox.com>,
        Mukesh Kacker <mukesh.kacker@oracle.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 092/159] RDMA/cma: Make sure that PSN is not over max allowed
Date: Fri, 23 Feb 2018 19:26:40 +0100
Message-Id: <20180223170754.669742874@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Moni Shoua <monis@mellanox.com>


[ Upstream commit 23a9cd2ad90543e9da3786878d2b2729c095439d ]

This patch limits the initial value for PSN to 24 bits as
spec requires.

Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Mukesh Kacker <mukesh.kacker@oracle.com>
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/cma.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -801,6 +801,7 @@ struct rdma_cm_id *rdma_create_id(struct
 	INIT_LIST_HEAD(&id_priv->mc_list);
 	get_random_bytes(&id_priv->seq_num, sizeof id_priv->seq_num);
 	id_priv->id.route.addr.dev_addr.net = get_net(net);
+	id_priv->seq_num &= 0x00ffffff;
 
 	return &id_priv->id;
 }
