Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1657C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C98217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277481;
	bh=BuDnXDpqBp+x9IXCzopt9nMukZHMEWO6G765LbZEhBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ANrMyvmB9oc+l3w/hH56pwA/l4Pqet3NyKqDNe5BMalEUApQnC1f3md3MYZELDjZm
	 v8GHVxcCR10QTPwcvsaJsKyWfbFO9EMVcx4/sSm2Tvk93RNb/l9NyCldLrWWeJ7/Ku
	 2Tb9E2LkO6L8FJ85vTl3UI3QAHGb2vohAEd1Walk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbfBDKvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:51:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732336AbfBDKvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24EF2070C;
        Mon,  4 Feb 2019 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277477;
        bh=BuDnXDpqBp+x9IXCzopt9nMukZHMEWO6G765LbZEhBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnIQCtwf2BjiMgH6ZrUpKa2bYjFFzXGLiCDKeA9D8V/FFq556gvLCrskkValbKQUd
         tQrMTtg2dZpGQJi1zoWkaVD1XqUlE2iZuhaOBuQqu9yuvYEnNtx00samnAnAklCKBU
         jzIdSxlw+GjR9+6kjXVsvRwyRKyJWKO12ATms54g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 25/80] net: tls: Fix deadlock in free_resources tx
Date:   Mon,  4 Feb 2019 11:36:45 +0100
Message-Id: <20190204103623.446165493@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Watson <davejwatson@fb.com>

[ Upstream commit 1023121375c6b0b3dc00334983c762ba2b76cb19 ]

If there are outstanding async tx requests (when crypto returns EINPROGRESS),
there is a potential deadlock: the tx work acquires the lock, while we
cancel_delayed_work_sync() while holding the lock.  Drop the lock while waiting
for the work to complete.

Fixes: a42055e8d2c30 ("Add support for async encryption of records...")
Signed-off-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1768,7 +1768,9 @@ void tls_sw_free_resources_tx(struct soc
 	if (atomic_read(&ctx->encrypt_pending))
 		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
 
+	release_sock(sk);
 	cancel_delayed_work_sync(&ctx->tx_work.work);
+	lock_sock(sk);
 
 	/* Tx whatever records we can transmit and abandon the rest */
 	tls_tx_records(sk, -1);


