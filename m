Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21622C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A762063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218300;
	bh=plSyj5+jS2RDRyZbKjsMA5o1/cSeRtKFkb6mjRyohkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X1h9mu+V5eSZRzwdy0WQ4g51aB1856RHRqeXjAiuf8ryA4mpJ3x6GJQqaiTwKu64M
	 KdPywJgEXYrDFmtF8gPUc1QIwVDoS837w6Zk/UTX6+SJeaM/escJe4UF6hqNl731WD
	 S271u00VSf1PrPIEwfXQOo7Xk6k8/wAwUHcHwnts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbfAKOjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:60072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403783AbfAKOjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F1F82133F;
        Fri, 11 Jan 2019 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217557;
        bh=plSyj5+jS2RDRyZbKjsMA5o1/cSeRtKFkb6mjRyohkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZI8a9oUARGRMd3BsDKWOIWvpm6jnhPn8rB6EsmqUCM45opnCLqbcw0A/REAr8RdLE
         EdLwC0fKwNIDq0++/idE51i7EaYmkJc7f0Do/mjMWv8YaZQ1hSc++E9q30FxFs1KUm
         9gfLnPSb3f6ZuN5zUVkRggengic0Q7POj2R24rw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 066/148] mac80211: free skb fraglist before freeing the skb
Date:   Fri, 11 Jan 2019 15:14:04 +0100
Message-Id: <20190111131116.891914905@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

[ Upstream commit 34b1e0e9efe101822e83cc62d22443ed3867ae7a ]

mac80211 uses the frag list to build AMSDU. When freeing
the skb, it may not be really freed, since someone is still
holding a reference to it.
In that case, when TCP skb is being retransmitted, the
pointer to the frag list is being reused, while the data
in there is no longer valid.
Since we will never get frag list from the network stack,
as mac80211 doesn't advertise the capability, we can safely
free and nullify it before releasing the SKB.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/status.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 7fa10d06cc51..534a604b75c2 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -556,6 +556,11 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 	}
 
 	ieee80211_led_tx(local);
+
+	if (skb_has_frag_list(skb)) {
+		kfree_skb_list(skb_shinfo(skb)->frag_list);
+		skb_shinfo(skb)->frag_list = NULL;
+	}
 }
 
 /*
-- 
2.19.1



