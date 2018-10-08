Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43651C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0957E21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2QhzmKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0957E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbeJIBys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbeJIByq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:46 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5032087D;
        Mon,  8 Oct 2018 18:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024101;
        bh=mExEGaPW7+huSFTIO0JqNMwiPGiiG/2qg0W8KrTpU2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G2QhzmKUg73yNgTeNZIHP4QD+lkNEOsV5vElwWJdYnhpAfNPNC+BF/f5l0I2iY1jU
         ZKsM2s62/4pkngJBjzv1UVZYs1e6RGXp7bFpNMT850iJuGz6uAg+Kx4vG+ph5/hYwj
         m8sH84XWu5uAUQiCD4TC7HcTHvZ6MVWu+UGVWPEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 20/94] mac80211: do not convert to A-MSDU if frag/subframe limited
Date:   Mon,  8 Oct 2018 20:31:01 +0200
Message-Id: <20181008175606.000434436@linuxfoundation.org>
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

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 1eb507903665442360a959136dfa3234c43db085 ]

Do not start to aggregate packets in a A-MSDU frame (converting the
first subframe to A-MSDU, adding the header) if max_tx_fragments or
max_amsdu_subframes limits are already exceeded by it. In particular,
this happens when drivers set the limit to 1 to avoid A-MSDUs at all.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
[reword commit message to be more precise]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/tx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3157,9 +3157,6 @@ static bool ieee80211_amsdu_aggregate(st
 	if (skb->len + head->len > max_amsdu_len)
 		goto out;
 
-	if (!ieee80211_amsdu_prepare_head(sdata, fast_tx, head))
-		goto out;
-
 	nfrags = 1 + skb_shinfo(skb)->nr_frags;
 	nfrags += 1 + skb_shinfo(head)->nr_frags;
 	frag_tail = &skb_shinfo(head)->frag_list;
@@ -3175,6 +3172,9 @@ static bool ieee80211_amsdu_aggregate(st
 	if (max_frags && nfrags > max_frags)
 		goto out;
 
+	if (!ieee80211_amsdu_prepare_head(sdata, fast_tx, head))
+		goto out;
+
 	/*
 	 * Pad out the previous subframe to a multiple of 4 by adding the
 	 * padding to the next one, that's being added. Note that head->len


