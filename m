Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A88C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4812064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcEybA78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4812064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbeJIBzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbeJIBzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:55:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 962A62064A;
        Mon,  8 Oct 2018 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024121;
        bh=TNVg3ttGWhiM1WZBRAJB94Very+byzv1U5CC/HP28po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcEybA78aCZjUSwNkkMNrSAm4NsJLhHbXJyCF0wBo+5phHk8DEhNrDuXjDmjle71i
         SWSX+RnnQruCr/8mx/u/hETgksWNeK5/dWMr+bxvSwyN0DccfoQNth51eHRumXl4Lx
         Val3kNRbHtctn9RSdAWwGeXuuLdnOpBRtkL/Uels=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Greear <greearb@candelatech.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 05/94] mac80211: Run TXQ teardown code before de-registering interfaces
Date:   Mon,  8 Oct 2018 20:30:46 +0200
Message-Id: <20181008175605.316344007@linuxfoundation.org>
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

From: "Toke Høiland-Jørgensen" <toke@toke.dk>

[ Upstream commit 77cfaf52eca5cac30ed029507e0cab065f888995 ]

The TXQ teardown code can reference the vif data structures that are
stored in the netdev private memory area if there are still packets on
the queue when it is being freed. Since the TXQ teardown code is run
after the netdevs are freed, this can lead to a use-after-free. Fix this
by moving the TXQ teardown code to earlier in ieee80211_unregister_hw().

Reported-by: Ben Greear <greearb@candelatech.com>
Tested-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Toke HÃ¸iland-JÃ¸rgensen <toke@toke.dk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1171,6 +1171,7 @@ void ieee80211_unregister_hw(struct ieee
 #if IS_ENABLED(CONFIG_IPV6)
 	unregister_inet6addr_notifier(&local->ifa6_notifier);
 #endif
+	ieee80211_txq_teardown_flows(local);
 
 	rtnl_lock();
 
@@ -1199,7 +1200,6 @@ void ieee80211_unregister_hw(struct ieee
 	skb_queue_purge(&local->skb_queue);
 	skb_queue_purge(&local->skb_queue_unreliable);
 	skb_queue_purge(&local->skb_queue_tdls_chsw);
-	ieee80211_txq_teardown_flows(local);
 
 	destroy_workqueue(local->workqueue);
 	wiphy_unregister(local->hw.wiphy);


