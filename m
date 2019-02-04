Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F34C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADAA2075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276969;
	bh=m42tWcRboTnRszByh3Oj+ksnDkrxL+bfVuSZQxlN3dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ONNKcRfeWQlBjO+Yd+B3d59NE4I9PcPhtDjfUyuROXwfES9b64GbiQAzI/2nrMLgf
	 RT2BX45lIojT8KC/yWiVzpWvF0LukLlYKEmnbSTVt27ZiK4QB92Wrn9ScmE9lDrQeY
	 9IbRBI5TTq3ikzpBqPolpyQGDw7H4ols3PA8IQNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfBDKmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:42:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbfBDKmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:42:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81F302087C;
        Mon,  4 Feb 2019 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276962;
        bh=m42tWcRboTnRszByh3Oj+ksnDkrxL+bfVuSZQxlN3dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fs7np+KuRZOFyGY/xaCWKzcyURHUlBNrVH6Ya4KBf1zJaDEOmK8F2XHVJMdR3OffE
         5J8pQd3Qwlh4w5/qEb4JUSyeFH7zeCjl13WrhOXbUtEkEiZcRfn+ngRwieQrP6YHyy
         5HhXj4ENvTDluD0f97FLS4pEfL0JtkBaNW+F8j1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 65/65] ipv4: frags: precedence bug in ip_expire()
Date:   Mon,  4 Feb 2019 11:36:58 +0100
Message-Id: <20190204103620.791197005@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 70837ffe3085c9a91488b52ca13ac84424da1042 upstream.

We accidentally removed the parentheses here, but they are required
because '!' has higher precedence than '&'.

Fixes: fa0f527358bd ("ip: use rb trees for IP frag queue.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/ip_fragment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -257,7 +257,7 @@ static void ip_expire(unsigned long arg)
 	IP_INC_STATS_BH(net, IPSTATS_MIB_REASMFAILS);
 	IP_INC_STATS_BH(net, IPSTATS_MIB_REASMTIMEOUT);
 
-	if (!qp->q.flags & INET_FRAG_FIRST_IN)
+	if (!(qp->q.flags & INET_FRAG_FIRST_IN))
 		goto out;
 
 	/* sk_buff::dev and sk_buff::rbnode are unionized. So we


