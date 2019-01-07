Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD53C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C006020651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865278;
	bh=1B4mooM7rEPi1KwzCpAEGtLbDMp4DnOsPq9UGxuHCC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ILfQp8x3uzzfCQXy0egirfG4mUXhL0C0JasVgS1mff8OtkAwjSRmgdS3ZoSczSvz
	 q6pJxuwBuz1MBoahMpygxn9bLAunVmLDv87Kqzq0Zi7RLcEiJXZvnJjMQLZ4w41l2/
	 FverEP3V8kk9QGnhHJ0gIKl61Le7u2I4nAQqihqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfAGMr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbfAGMrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:47:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A1B220651;
        Mon,  7 Jan 2019 12:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865273;
        bh=1B4mooM7rEPi1KwzCpAEGtLbDMp4DnOsPq9UGxuHCC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gE/mtOeH5yJQS2U1f8+FgR4FKb4iM8hu2nqc9sFHYuGTsuj8Sa23/bvYFFNWEhg2A
         OyrWjMNgik2g7OxFlFkqB0iuZMYsQAja+N178tSuA3uZjf4WwO5cXIByW/XOQ0V3MW
         l25Epi2+hfISyypWrs3+JjKPAyj11rMZSJcU4t68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>,
        Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 040/170] xen/netfront: tolerate frags with no data
Date:   Mon,  7 Jan 2019 13:31:07 +0100
Message-Id: <20190107104457.995460155@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

[ Upstream commit d81c5054a5d1d4999c7cdead7636b6cd4af83d36 ]

At least old Xen net backends seem to send frags with no real data
sometimes. In case such a fragment happens to occur with the frag limit
already reached the frontend will BUG currently even if this situation
is easily recoverable.

Modify the BUG_ON() condition accordingly.

Tested-by: Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -905,7 +905,7 @@ static RING_IDX xennet_fill_frags(struct
 		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS) {
 			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
 
-			BUG_ON(pull_to <= skb_headlen(skb));
+			BUG_ON(pull_to < skb_headlen(skb));
 			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
 		}
 		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {


