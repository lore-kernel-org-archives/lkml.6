Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ED921527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+Y+smyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ED921527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbeKVFnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388124AbeKVFnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1454A214DB;
        Wed, 21 Nov 2018 19:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827298;
        bh=NJ0XJ5D76qauL7K2BAhWCD2VFS26K56Truwf+5MOlD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+Y+smynEfvv/kRC0U9uAzoeIA7v4P8ym9xvAXfFwXeBJ4RoVNAmI3w+gA2mJkod1
         lqGFdLa4rqySvEnZ6LX0jiuNf48Tp8YbFF4j7DFfwblQzc24LCzf6FYRPNEOg5PnX5
         PVhPaRAu15vw3vOCgFdjI3gezV4JeTHtajdnZJUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 15/42] net/sched: act_pedit: fix memory leak when IDR allocation fails
Date:   Wed, 21 Nov 2018 20:05:51 +0100
Message-Id: <20181121183148.653311264@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 19ab69107d3ecfb7cd3e38ad262a881be40c01a3 ]

tcf_idr_check_alloc() can return a negative value, on allocation failures
(-ENOMEM) or IDR exhaustion (-ENOSPC): don't leak keys_ex in these cases.

Fixes: 0190c1d452a9 ("net: sched: atomically check-allocate action")
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_pedit.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -201,7 +201,8 @@ static int tcf_pedit_init(struct net *ne
 			goto out_release;
 		}
 	} else {
-		return err;
+		ret = err;
+		goto out_free;
 	}
 
 	p = to_pedit(*a);


