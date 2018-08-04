Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47FDC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6154E217AF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="igt34LEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6154E217AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeHEB6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 21:58:12 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46228 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbeHEB6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 21:58:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id o8-v6so3426677edt.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 16:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=04/YLKpPy8GzPvF3YsUrwDSbX3uagrGSa0DdrzEICE8=;
        b=igt34LEYNlt12B/IwJUmTggUMGV15KOxX1Tx4sAJnMwA6JPC5aZf55ENnDOCgGYi/E
         WGcGlW1iMc7ZzxLfXYz3fS5+z0i3wV18ZNOBZlN9UE0kzp0Z6htByNCyfZt5N+efbGr+
         LAPi0Ml92Y20LUsvMkozr1KRH+q3/q8/9ni2fXZiKs6I/UqFhuz1y7vm8aIfebgJSHXQ
         Zf4ioMry85z1Jg4CwPg1mO2sh8cMpQ+BSApgQPCXGtDP2xpU4RyeAnfq80V8KaXg+5AU
         01SECHn8Q3cKsBgn3DAtY3ZFYVVJhTV1AQpW1XjMDFHbyMyNwetKKEyf+uEDZ6HvKT3C
         Uf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=04/YLKpPy8GzPvF3YsUrwDSbX3uagrGSa0DdrzEICE8=;
        b=n9fLRTS7Uv2toJbc9E9f0gL+amIsquw6MIeFP8uN2SoOyt4pEvfzboETGvQeykz38H
         G++YgC8NdfvYp+2CD5P2+1OIo0607jMJm7qvGK02ZvIqptPm2zIbLbqUa/BB7oaMZnhg
         1udWmK4trcPlSBFdaBwv/diIXwv2GAFk5VGtYAK1deypbtY9xoXqqv4DlERYOtbrtMTJ
         Z9OyYkGtadtwChd5e+jKbiQL86CYocRS8DXvYmfAO+4QyuRauuWsaRsQPIZeLzou/pL6
         Y+nrCjDIwtmXG/qAHtLkcy7+FzL4GBOdBFXbHPxPHJB8msUaNrL5x/vyhyYn4ij+xirJ
         HBAA==
X-Gm-Message-State: AOUpUlELTlR0Uvp8VHntGAC163wjMttajIvycliBwBCQPHOp7xfO3jcL
        aqiWzBCTZdKI1aDUUsNdOWxcUIom2nM=
X-Google-Smtp-Source: AAOMgpceEYfIx06YAyM6yWiQXn62m/xtg+EP65KJhcUqRNFz4i6sR8FR9OWHkhAu1hxUYbptE/9uUw==
X-Received: by 2002:a50:9e2f:: with SMTP id z44-v6mr12298861ede.303.1533426946504;
        Sat, 04 Aug 2018 16:55:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:5459:5b7e:632c:59fc])
        by smtp.gmail.com with ESMTPSA id d11-v6sm3332674edo.39.2018.08.04.16.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 16:55:45 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] netlink: Don't shift on 64 for ngroups
Date:   Sun,  5 Aug 2018 00:55:44 +0100
Message-Id: <20180804235544.10347-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's legal to have 64 groups for netlink_sock.

As user-supplied nladdr->nl_groups is __u32, it's possible to subscribe
only to first 32 groups.

The check for correctness of .bind() userspace supplied parameter
is done by applying mask made from ngroups shift. Which broke Android
as they have 64 groups and the shift for mask resulted in an overflow.

Fixes: 61f4b23769f0 ("netlink: Don't shift with UB on nlk->ngroups")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Reported-and-Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/netlink/af_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 7d860a22e5fb..e44edadfad20 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1011,8 +1011,8 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 
 	if (nlk->ngroups == 0)
 		groups = 0;
-	else
-		groups &= (1ULL << nlk->ngroups) - 1;
+	else if (nlk->ngroups < sizeof(long unsigned int))
+		groups &= (1UL << nlk->ngroups) - 1;
 
 	bound = nlk->bound;
 	if (bound) {
-- 
2.13.6

