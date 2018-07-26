Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437CE20895
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 02:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bn8zq0M7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 437CE20895
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeGZDq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 23:46:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35754 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbeGZDq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 23:46:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id e6-v6so339185edr.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 19:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KPyvd5o+I9Jov49HHmbeHutGib2mspLlbfetN7M1LJA=;
        b=bn8zq0M7lAwJea4JONbDDYyqexIzxU/As0lvD/oskkExa/sy5ZuwZDOJ0V1FlU6nxS
         R0I90dDdcY5vbDRh7yGstJGSJFgsznflAlOPXeHuclwJfE72dF9bIlUWIvkHDlCDZ7tG
         YOeBdzgJ1KJ6NXGRWay7ELBswj0IndWiomcqDCsSrKoSdyy+FZ6uUySKSM8dRlrnEDan
         kmBStLemWkvujmASB5ZWc5j+jneBZ651wXAuCUCvMowU3Ek8kK6/Q9iN/eogO4SRnOl+
         tTZFkuJSjOA5Mfece1tPrkuD6Y3Snp024ZjGaPu50ktCumXSRqU37UjI5nefQHfd77o6
         3Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KPyvd5o+I9Jov49HHmbeHutGib2mspLlbfetN7M1LJA=;
        b=JU4HwoFE1AkmPdWRLjLsXQl/otbXYPW5CJ0EthBsDnW3lJefUVM07DqOul4or0mD7A
         5pnHPiMYLH/crJj7cyht4NCoBcwQKx3ZuvJu7VIRVenpfitDjROE7Udyo3fcXrXxFXLJ
         wbcmpuYwaQuss8/keD5oG+YYBQYRt8dPF6eG0cy206AYmfMq9ZFOXdvZ8tVlkVIGoKEe
         qLRD4VkAuPQGtGPdgQRL5tVHRbt6FM0kH+v5sEvJkmRjump7CzXDNPgDrjlPXrBTpE69
         LXNlgOS+8uEmdaHHbjbEV8WbWv0LQgeBkmsgPS+6jmq0fjUmusaIY1DCZU+HKHCR8NDw
         j8iw==
X-Gm-Message-State: AOUpUlFTB+rrOhYqf8rTXuKNoPZ2mAjL//w0wxKn3OFA7hyS/OFyL2cB
        flz3m1txa0gnAEBETC3iTM4vqIBjjjE=
X-Google-Smtp-Source: AAOMgpcSIkFsLpiYtmeWEpYDEK4GRRLgKAcZW3kilt7W7Y9pstzVUsJUtGGFqNtBDZ84+JLiiwnKgw==
X-Received: by 2002:a50:b306:: with SMTP id q6-v6mr481068edd.264.1532572313408;
        Wed, 25 Jul 2018 19:31:53 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x13-v6sm241024edx.17.2018.07.25.19.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 19:31:52 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH 06/18] netlink: Do not subscribe to non-existent groups
Date:   Thu, 26 Jul 2018 03:31:32 +0100
Message-Id: <20180726023144.31066-7-dima@arista.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180726023144.31066-1-dima@arista.com>
References: <20180726023144.31066-1-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make ABI more strict about subscribing to group > ngroups.
Code doesn't check for that and it looks bogus.
(one can subscribe to non-existing group)
Still, it's possible to bind() to all possible groups with (-1)

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/netlink/af_netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 393573a99a5a..ac805caed2e2 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1008,6 +1008,7 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 		if (err)
 			return err;
 	}
+	groups &= (1UL << nlk->ngroups) - 1;
 
 	bound = nlk->bound;
 	if (bound) {
-- 
2.13.6

