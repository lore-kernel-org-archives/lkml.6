Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A38C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC6721855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oLQMH4Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAWVoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:44:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33300 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfAWVoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:44:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so1832893plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3/uZIwlnkiagj/KNfMOOqUpOUjR6rsb4oQn9ZsZlaNg=;
        b=oLQMH4EcuyKyIYYV4vanW37DXXGFxK3/mbRoEqDP2Ju+Npq0YavvnV+GXjGRwIyJQz
         h1gd9rlUWFkme4Fhj5KOZp9FAHQJ5AgH/uxuS6zITYyjB3sPNEhCuvEwUoOdbPLSKKHa
         lcN7BVGFi9FjxOGQkzu5n/B17DWihiQ9mPkzWTuLQz0XWJv7X0JmKat3tLcYNXJcdEHF
         CJkZo/xkGcbJKoGqrv6FVugXM65HU+VbrnPSOOaIUbwX6AcPcAbXSv3fbCYhR5q5l+2C
         NIaMGhQ06iAWVje0JijuP193kp9/x4PUbGYTlEPUQHMDdODWpo3FDMWguQnhYJV9Pko3
         m8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3/uZIwlnkiagj/KNfMOOqUpOUjR6rsb4oQn9ZsZlaNg=;
        b=dKA1BvmfV+2ZuFJ80o8RsTnUCMmkVNMhDrxyLwyixpTQ4S092JmaikOF713EnmNwyj
         X26xim/bc0/RuGoipnHTE/LKzJ8MeWV+tQyjgTTil+bsNBV5qdeW9JiJBoGY6+4/jchs
         BEXVxr1gheJokEAEZAkHl8eQAQArHoJDtg8GEAGSOEmEM1FZpsJgPXztfJis9ACAA7Ui
         fsbaurFGX3gfqxUpRW0z9yj+W88RU2SQiLxegLo+98GQpcoCGtzRRZ+BHBi3qqcAzwlr
         9qUzzdFcCaeLJSyLZiWeyj6gEylr8oJwlIG3JPGvVhrjLebP0vHdIoldBzWfyDm1plOA
         jNEQ==
X-Gm-Message-State: AJcUukcwKQj2+eid6BVT0TYwp8uEaY74/lI4laWrUCMmWYJFuLvAu43D
        6MNvukxaqPAiNX8eXUaG6zWr+w==
X-Google-Smtp-Source: ALg8bN7Yn5IztwMbrUR640ecAT9jOBAZaSZGbtbGVmLYGVSGYZSuFBbopH7yzikDNMMlgWcY4OoY0g==
X-Received: by 2002:a17:902:2c83:: with SMTP id n3mr4015238plb.104.1548279856564;
        Wed, 23 Jan 2019 13:44:16 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id e187sm26380347pfa.130.2019.01.23.13.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:44:15 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gmQJj-0005NW-2p; Wed, 23 Jan 2019 14:44:15 -0700
Date:   Wed, 23 Jan 2019 14:44:15 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Raju Rangoju <rajur@chelsio.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iw_cxgb4: drop check - dead code
Message-ID: <20190123214415.GA20648@ziepe.ca>
References: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 02:27:13AM +0100, Nicholas Mc Guire wrote:
> The kmalloc is called with  | __GFP_NOFAIL  so there is no point in
> checking the return value - it either returns valid storage or it would
> hang/terminate there. But it is not possible to say if the use of
> __GFP_NOFAIL is really needed and the check should be removed or
> vice-versa (use of __GFP_NOFAIL should be only in exceptional
> cases as I understand it and alloc_srq_queue() is called in quite
> a few places)
> In either way it would need fixing.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 6a0b6174d35a ("rdma/cxgb4: Add support for kernel mode SRQ's")
> ---

As per steve's remarkes I revised this to the below and applied it to
for-next

From 4b2d4262ee2ea58df867de1928bf208795344432 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Sun, 20 Jan 2019 02:27:13 +0100
Subject: [PATCH] RDMA/iw_cxgb4: Drop __GFP_NOFAIL

There is no reason for this __GFP_NOFAIL, none of the other routines in
this file use it, and there is an error unwind here. NOFAIL should be
reserved for special cases, not used by network drivers.

Fixes: 6a0b6174d35a ("rdma/cxgb4: Add support for kernel mode SRQ's")
Reported-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/cxgb4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index 03f4c66c265946..c00a4114412694 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -2597,7 +2597,7 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
 	/* build fw_ri_res_wr */
 	wr_len = sizeof(*res_wr) + sizeof(*res);
 
-	skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
+	skb = alloc_skb(wr_len, GFP_KERNEL);
 	if (!skb)
 		goto err_free_queue;
 	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
-- 
2.20.1

