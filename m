Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28CCC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AD2E214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3G9Ugfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD2E214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeJIBvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIBve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:51:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92DF0214C2;
        Mon,  8 Oct 2018 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023911;
        bh=8mC/hqfsGZemliNQ7eR/LJ7401nZIRDusPuS4insOfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3G9UgfzNpr7lt+Qw+O3Txv9HlzTKldXqcGw6JPnWHmty0CofApbywOal3lu0W8RV
         RlpGUjbdgE3Pl6tnjdzf+tW2+YpjTpdBCt9NNm80V4wdG1rmTFhPwZJgfqd7PJfjYS
         NvxttobRRBZqK+HjrGMIYUwqHRnK+deWvzS7CwtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Greear <greearb@candelatech.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 03/59] mac80211: Run TXQ teardown code before de-registering interfaces
Date:   Mon,  8 Oct 2018 20:31:10 +0200
Message-Id: <20181008175547.240790589@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1164,6 +1164,7 @@ void ieee80211_unregister_hw(struct ieee
 #if IS_ENABLED(CONFIG_IPV6)
 	unregister_inet6addr_notifier(&local->ifa6_notifier);
 #endif
+	ieee80211_txq_teardown_flows(local);
 
 	rtnl_lock();
 
@@ -1191,7 +1192,6 @@ void ieee80211_unregister_hw(struct ieee
 	skb_queue_purge(&local->skb_queue);
 	skb_queue_purge(&local->skb_queue_unreliable);
 	skb_queue_purge(&local->skb_queue_tdls_chsw);
-	ieee80211_txq_teardown_flows(local);
 
 	destroy_workqueue(local->workqueue);
 	wiphy_unregister(local->hw.wiphy);


