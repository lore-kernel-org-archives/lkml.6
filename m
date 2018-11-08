Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B87ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04E820892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1bKUfKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04E820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbeKIHgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbeKIHgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:07 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80BBB208E3;
        Thu,  8 Nov 2018 21:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714319;
        bh=qTKF1X5OXMvJMIsBcwqOgAKtCt58TOa4GEoyO6H/+qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1bKUfKWejkU2ty76pmpMZqJL5SF2kXVHoDRGGmiTOAjGQKg2lYpBJ/xit/Tus2sA
         k6wVqDxEJgQLly5Itrbb7DANKo/n5pOTND5kT9vs1jcbUZBpfLOwVjTKQRm5pR4CxH
         JpMJsZht2zGoCJCM53MkxTzZ+JuYyXMc9z3UXVrA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 003/114] mac80211: Always report TX status
Date:   Thu,  8 Nov 2018 13:50:18 -0800
Message-Id: <20181108215059.304209937@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8682250b3c1b75a45feb7452bc413d004cfe3778 ]

If a frame is dropped for any reason, mac80211 wouldn't report the TX
status back to user space.

As the user space may rely on the TX_STATUS to kick its state
machines, resends etc, it's better to just report this frame as not
acked instead.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/status.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 45fb1abdb265..2731cf5bf052 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -466,11 +466,6 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 	if (!skb)
 		return;
 
-	if (dropped) {
-		dev_kfree_skb_any(skb);
-		return;
-	}
-
 	if (info->flags & IEEE80211_TX_INTFL_NL80211_FRAME_TX) {
 		u64 cookie = IEEE80211_SKB_CB(skb)->ack.cookie;
 		struct ieee80211_sub_if_data *sdata;
@@ -491,6 +486,8 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 		}
 		rcu_read_unlock();
 
+		dev_kfree_skb_any(skb);
+	} else if (dropped) {
 		dev_kfree_skb_any(skb);
 	} else {
 		/* consumes skb */
-- 
2.17.1



