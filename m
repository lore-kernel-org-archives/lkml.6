Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC353C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DF62084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aEcIDTtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfBBXTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 18:19:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44258 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfBBXTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 18:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QHfuQxucmqZgc7hoYtVZKtpcSP8kkrGOwNmfYkDUJsc=; b=aEcIDTtdLtmcbOHo0b7nxVxOW
        OHPf0/ol77FLmDKqbIFyLdKvyUS130MXyBnGWA1noOB/lv4vkgMcqamfPpt1NWAX4Mk9kudb+MQsM
        2h1bxdRtH6xdevg/dW/5foVotZt9XsZa2BnRBrvMQbMpuFPAI4tLCVemIFBoHUjOh4azYZpyYrhBZ
        oRKnUxCmDcAAZOwU4Vlwo2erNbuTdQk5K3xNEt3c1oq+v5Gn4/yEEIn0GK6GN5BBemF4uKi7A8EUt
        t1UvTmk7UiCQqE1i3sx0DCp4kEudF75rswMq3+FjBDZaNOZAXA+WaCpSuffZl9g09QNnzxaNJaG2/
        pF4dwPHAA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gq4Zc-0006Im-UH; Sat, 02 Feb 2019 23:19:44 +0000
Date:   Sat, 2 Feb 2019 15:19:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] XArray tests: allocation has to be GFP_ATOMIC under
 rcu_read_lock
Message-ID: <20190202231944.GB13285@bombadil.infradead.org>
References: <1548760122-13000-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548760122-13000-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 07:08:42PM +0800, Li RongQing wrote:
> -	XA_BUG_ON(xa, xa_store_index(xa, 1, GFP_KERNEL) != NULL);
> +	XA_BUG_ON(xa, xa_store_index(xa, 1, GFP_ATOMIC) != NULL);

Did you try running this change in userspace too?  I don't think it'll
work.

I think the right change would be:

+++ b/lib/test_xarray.c
@@ -107,8 +107,11 @@ static noinline void check_xas_retry(struct xarray *xa)
        XA_BUG_ON(xa, xas.xa_node != XAS_RESTART);
        XA_BUG_ON(xa, xas_next_entry(&xas, ULONG_MAX) != xa_mk_value(0));
        XA_BUG_ON(xa, xas.xa_node != NULL);
+       rcu_read_unlock();
 
        XA_BUG_ON(xa, xa_store_index(xa, 1, GFP_KERNEL) != NULL);
+
+       rcu_read_lock();
        XA_BUG_ON(xa, !xa_is_internal(xas_reload(&xas)));
        xas.xa_node = XAS_RESTART;
        XA_BUG_ON(xa, xas_next_entry(&xas, ULONG_MAX) != xa_mk_value(0));

