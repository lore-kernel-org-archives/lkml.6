Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE141C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78CC720837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF8QYGyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CC720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbeKCDzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727629AbeKCDzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:55:31 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6050B20837;
        Fri,  2 Nov 2018 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184438;
        bh=5JiKkvDKLZhSDMXqlG4FR+hbjEKlurwoeqdOEvb4pnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eF8QYGyxlfP+HWFW3K5X9FJp5jdkSk1BSPO+3gv+Q0nfm6o5c279UVZ5yv7V5Md7L
         fZLgFWMIGK3z9yPm1qRZ0rQV/wev4x5NJP3noYf4p5iRz3bq7gBscYWR/DZRS6CsQl
         kukHzYRrgfxKwiZSeFdnU13JaJr92v7k2AdP5hK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 126/150] net: ipmr: fix unresolved entry dumps
Date:   Fri,  2 Nov 2018 19:34:48 +0100
Message-Id: <20181102182911.647092459@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

[ Upstream commit eddf016b910486d2123675a6b5fd7d64f77cdca8 ]

If the skb space ends in an unresolved entry while dumping we'll miss
some unresolved entries. The reason is due to zeroing the entry counter
between dumping resolved and unresolved mfc entries. We should just
keep counting until the whole table is dumped and zero when we move to
the next as we have a separate table counter.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 8fb472c09b9d ("ipmr: improve hash scalability")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ipmr_base.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -295,8 +295,6 @@ int mr_rtm_dumproute(struct sk_buff *skb
 next_entry:
 			e++;
 		}
-		e = 0;
-		s_e = 0;
 
 		spin_lock_bh(lock);
 		list_for_each_entry(mfc, &mrt->mfc_unres_queue, list) {


