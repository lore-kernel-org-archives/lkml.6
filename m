Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803259-2-16161689854990258669
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
    t=1521803259; b=Hc4MN1RHNnYhUhTq5dn0zGfP4VAk9MD4tvyse9SIApmWAGe
    sbDpjuiMY4Wbiqy6tQeEWtoA9U3Es3RtSbtJfKpdsgg+GplH/j1BuILVzw636Vjp
    7T40HpI3iEtSfrL3nHqRCNI7vNryPDLi6S3pWBnPEnLuiK+GIgZ3nyIOp3QL84a5
    bdKO2gyGTN/WGWFcaZUVsjUma8eADwR1/rqc/VIZSYZfaTelbchFopeg46uIt+AY
    kf0vdkxBO26rJKhuYJdn7klmFBuMkV9cYfFRgmYMQH9mjlKHS1a0iDEwC/1somlZ
    c3jYFIePZLCpGg1RK8aBpUSnPAIs+yJW0FAJgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803259; bh=spcWgkqTxyCSDPucxBdqLQl/lQ
    yZemz9uGskACcgkhU=; b=mVc/wUe3AbM82aRKNj0X8FdaZSvSLcK8nLgDtsb3i9
    a/vHhm63+1W5Xng04qiHu7PABgi9Y4MprDl41v+L8niTZkuuJ8syuP3YZ5zotn8v
    at90VbICKmxdP/ADIG9l7kVBGHCQbWq+YLklZP36IQWWq8AGv+MCVkC9BtUCIbQw
    N4/tEDop7Iyx1jUISD+3w7h5JlXlP8XVrJeBCwd2+3/pbLj+yx4V5aBxOWnQtgSR
    z+bPlw2bQZqKDTs37c4EG6PH0e0NR16RYFEnMuZjGdOwzpz7MIIjflnOgPdvpmP+
    6k6C2Rh8bghxvz9LV/l/7AZOjFTcUPNcTWruPFvAcRAw==
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
        id S933095AbeCWKMB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:12:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44108 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeCWKL7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:11:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 154/177] IB/umem: Fix use of npages/nmap fields
Date: Fri, 23 Mar 2018 10:54:42 +0100
Message-Id: <20180323094211.976441827@linuxfoundation.org>
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

From: Artemy Kovalyov <artemyko@mellanox.com>


[ Upstream commit edf1a84fe37c51290e2c88154ecaf48dadff3d27 ]

In ib_umem structure npages holds original number of sg entries, while
nmap is number of DMA blocks returned by dma_map_sg.

Fixes: c5d76f130b28 ('IB/core: Add umem function to read data from user-space')
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/umem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -357,7 +357,7 @@ int ib_umem_copy_from(void *dst, struct
 		return -EINVAL;
 	}
 
-	ret = sg_pcopy_to_buffer(umem->sg_head.sgl, umem->nmap, dst, length,
+	ret = sg_pcopy_to_buffer(umem->sg_head.sgl, umem->npages, dst, length,
 				 offset + ib_umem_offset(umem));
 
 	if (ret < 0)
