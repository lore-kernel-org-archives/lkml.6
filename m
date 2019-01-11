Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A21C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D728F21848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217554;
	bh=pyovbB8wqmuuM7KNBUpg3NJr78OUdcwkt1jR4QQni7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h6n0bPNXBzSUqaDeh1/+gE/QskMt5TrhNrgnT/4M+sMyOBpQ3sJFVAn6C/T2SSXZa
	 8jJn2pxao8TEN7EJWGTVPq4oVbIyQdP1MWn46v0Ki4vhTLrsC2Doxo+ZagH/ve8TDl
	 rOAFNWy6k0zw8mTV8EiHo3InPm6qin10w7k0T6z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390995AbfAKOjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390975AbfAKOjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456152063F;
        Fri, 11 Jan 2019 14:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217549;
        bh=pyovbB8wqmuuM7KNBUpg3NJr78OUdcwkt1jR4QQni7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5zbsumUK9cZe4jAJyWXjAb5HRHfUocuWwWcVIENaotnZi2JURWSEX3e4a7sUpr8k
         wCOlF7G8i44XDBnsM+y9uVOiS7h4FhEbloKqVPDND5SeVyJLJ0lhkrhcTfiig6yxtH
         h0yIe3l564fWydYM7kQW0vKsCoq3Gpk/3WHH/Ab0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 065/148] nl80211: fix memory leak if validate_pae_over_nl80211() fails
Date:   Fri, 11 Jan 2019 15:14:03 +0100
Message-Id: <20190111131116.851551657@linuxfoundation.org>
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

[ Upstream commit d350a0f431189517b1af0dbbb605c273231a8966 ]

If validate_pae_over_nl80211() were to fail in nl80211_crypto_settings(),
we might leak the 'connkeys' allocation. Fix this.

Fixes: 64bf3d4bc2b0 ("nl80211: Add CONTROL_PORT_OVER_NL80211 attribute")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 176edfefcbaa..295cd8d5554f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -8993,8 +8993,10 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_CONTROL_PORT_OVER_NL80211]) {
 		int r = validate_pae_over_nl80211(rdev, info);
 
-		if (r < 0)
+		if (r < 0) {
+			kzfree(connkeys);
 			return r;
+		}
 
 		ibss.control_port_over_nl80211 = true;
 	}
-- 
2.19.1



