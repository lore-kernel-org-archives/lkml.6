Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6D82146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543627;
	bh=eMg5wGQWftbv9dATqS9dqodGCQ6lql0URAanJ4LTMhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NTbH24fFUiKuB2LIt4NsUqjR3Zs4dxczvt/gMTXDDKIA/er13sc7y56NJmz/G+URO
	 CtE0ILUxerrK+6o3VkNQ4fTY9QPwM1uI8nxBIL5RFd3P8y6PMBB2i4nFaxcJWt8ez3
	 9fZQJmFjDbHuUjDT2knmbaf24lWlajDcDhmkx6FQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6D82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbeLKPxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbeLKPxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:53:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2919120855;
        Tue, 11 Dec 2018 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543620;
        bh=eMg5wGQWftbv9dATqS9dqodGCQ6lql0URAanJ4LTMhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sXMwvzLnQQcNbmVAE/vQ+rBa8Yh0wN0aBiQgsy4UzEazCr1ZhzhyjqhAffe4iQcCH
         9PPdokgFcoqvccL8cvUIfg0Qt+bkCwFMAg84TaW4e3PZW/SUpX4QT09vG4TrEWqIql
         qe1fys5B19k0miZRs40N66xx9yFhqBiiC9FDYbOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 66/67] mac80211: fix reordering of buffered broadcast packets
Date:   Tue, 11 Dec 2018 16:42:06 +0100
Message-Id: <20181211151634.204050948@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

commit 9ec1190d065998650fd9260dea8cf3e1f56c0e8c upstream.

If the buffered broadcast queue contains packets, letting new packets bypass
that queue can lead to heavy reordering, since the driver is probably throttling
transmission of buffered multicast packets after beacons.

Keep buffering packets until the buffer has been cleared (and no client
is in powersave mode).

Cc: stable@vger.kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/tx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -435,8 +435,8 @@ ieee80211_tx_h_multicast_ps_buf(struct i
 	if (ieee80211_hw_check(&tx->local->hw, QUEUE_CONTROL))
 		info->hw_queue = tx->sdata->vif.cab_queue;
 
-	/* no stations in PS mode */
-	if (!atomic_read(&ps->num_sta_ps))
+	/* no stations in PS mode and no buffered packets */
+	if (!atomic_read(&ps->num_sta_ps) && skb_queue_empty(&ps->bc_buf))
 		return TX_CONTINUE;
 
 	info->flags |= IEEE80211_TX_CTL_SEND_AFTER_DTIM;


