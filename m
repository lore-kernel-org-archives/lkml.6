Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B79C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C6D21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCVxRaux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C6D21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbeJIByu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbeJIBys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200212087D;
        Mon,  8 Oct 2018 18:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024104;
        bh=qSYKPlZBeT2lObKkdblsCk2276OU2FRRnrqJE/535C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCVxRauxqDSx8z63YpHxMF+0MrkkKEqfviiPIhH1G3QvKi+v640pWR9bUnr2l2zZ9
         KVC3HAXAeONlObm3bgdSh+R7bLBmnt0i5AtT5MS3fUe5IMYfxocWLF9S2bBIzxXlxb
         tbFRNqC1DW7t7ExuS/rJMNUcP04A4a5vmYPs8VUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 21/94] mac80211: always account for A-MSDU header changes
Date:   Mon,  8 Oct 2018 20:31:02 +0200
Message-Id: <20181008175606.048800057@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit aa58acf325b4aadeecae2bfc90658273b47dbace ]

In the error path of changing the SKB headroom of the second
A-MSDU subframe, we would not account for the already-changed
length of the first frame that just got converted to be in
A-MSDU format and thus is a bit longer now.

Fix this by doing the necessary accounting.

It would be possible to reorder the operations, but that would
make the code more complex (to calculate the necessary pad),
and the headroom expansion should not fail frequently enough
to make that worthwhile.

Fixes: 6e0456b54545 ("mac80211: add A-MSDU tx support")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/tx.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3188,7 +3188,7 @@ static bool ieee80211_amsdu_aggregate(st
 
 	if (!ieee80211_amsdu_realloc_pad(local, skb, sizeof(rfc1042_header) +
 						     2 + pad))
-		goto out;
+		goto out_recalc;
 
 	ret = true;
 	data = skb_push(skb, ETH_ALEN + 2);
@@ -3205,11 +3205,13 @@ static bool ieee80211_amsdu_aggregate(st
 	head->data_len += skb->len;
 	*frag_tail = skb;
 
-	flow->backlog += head->len - orig_len;
-	tin->backlog_bytes += head->len - orig_len;
-
-	fq_recalc_backlog(fq, tin, flow);
+out_recalc:
+	if (head->len != orig_len) {
+		flow->backlog += head->len - orig_len;
+		tin->backlog_bytes += head->len - orig_len;
 
+		fq_recalc_backlog(fq, tin, flow);
+	}
 out:
 	spin_unlock_bh(&fq->lock);
 


