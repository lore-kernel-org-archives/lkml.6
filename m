Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31003C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10C22765B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10C22765B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753665AbeF1PxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:53:18 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41585 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeF1PxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:53:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id b12-v6so5467795edt.8;
        Thu, 28 Jun 2018 08:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bOr8WpGL+yg9XN15dL9ghyc9ym4lymMRsxrFwr3REkw=;
        b=S9SN2UUcq9tFwlsLnXJPrkdC3qORuVZLvFCbE2nyABwwcted2Xqj1XwIgOfVsBVr2b
         vAFvOwYqA7zwqN0hTDRZOk3eV0xDbCoq6yPdpRraQe3oJXnNDOOUm/3gEoBqoA/FAKpb
         R0Y4CpfSx76Nm8mkbTg5J2Q1nxmyG9PEEueDNvqD1lpW7aDgtBZEgyyLz1V6IjU8wq3s
         qCSh7RAJnSUqt8ay6sVFCILDFty46AF85VCnEFMMvJOPkmZQn9I0C5G2rzCW/fNZsgvW
         WVlCKHZRRsZz0phDPb5RSfJuOsswTPBfHP8NIH5+tkcqHPzooH+2Xh3QJRfwQZa6kq2g
         F7zA==
X-Gm-Message-State: APt69E3gxS1FA4YsYqLksqTdz9wfbiw+tnrEY08jeGGkEXlcO4ugXtUv
        cN3jVjGu/eKZiKKvAocGcIDdqw==
X-Google-Smtp-Source: AAOMgpf8D4fZ1Kf9jR1yy4mpno7aSYEU/8PuQrGlZP1udtnUg3KHs55KYiH218vhcN26xN7zaCmHcQ==
X-Received: by 2002:a50:9a64:: with SMTP id o91-v6mr9745506edb.173.1530201196158;
        Thu, 28 Jun 2018 08:53:16 -0700 (PDT)
Received: from tiehlicka.microfocus.com (nat.nue.novell.com. [195.135.221.2])
        by smtp.gmail.com with ESMTPSA id t3-v6sm3034131edq.50.2018.06.28.08.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:53:15 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     davem@davemloft.net
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: [PATCH] net: cleanup gfp mask in alloc_skb_with_frags
Date:   Thu, 28 Jun 2018 17:53:06 +0200
Message-Id: <20180628155306.29038-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

alloc_skb_with_frags uses __GFP_NORETRY for non-sleeping allocations
which is just a noop and a little bit confusing.

__GFP_NORETRY was added by ed98df3361f0 ("net: use __GFP_NORETRY for
high order allocations") to prevent from the OOM killer. Yet this was
not enough because fb05e7a89f50 ("net: don't wait for order-3 page
allocation") didn't want an excessive reclaim for non-costly orders
so it made it completely NOWAIT while it preserved __GFP_NORETRY in
place which is now redundant.

Drop the pointless __GFP_NORETRY because this function is used as
copy&paste source for other places.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 net/core/skbuff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index c642304f178c..eba8dae22c25 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5276,8 +5276,7 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 			if (npages >= 1 << order) {
 				page = alloc_pages((gfp_mask & ~__GFP_DIRECT_RECLAIM) |
 						   __GFP_COMP |
-						   __GFP_NOWARN |
-						   __GFP_NORETRY,
+						   __GFP_NOWARN,
 						   order);
 				if (page)
 					goto fill_page;
-- 
2.18.0

