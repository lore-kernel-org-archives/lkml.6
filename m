Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE478C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8378C2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILpOVGYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8378C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbeJICBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJICBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47413204FD;
        Mon,  8 Oct 2018 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024492;
        bh=NDgYbCf3K/X/0Bg78tqBgoLfka4p377X8rJqMlZ936s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILpOVGYkEyH+ddYe1s2ML/Bz3qaGQj55VEn8wo8OOK+3P2ri0nXldVtv6JBC5KMXD
         1Rb19P4tRPjSR+U6EwWzRJaB9yleyBlL5vfnPIzlmQkDfstCRjtqYv9jcnntkAhaWv
         gw2M88qqiAALzBglkwGSQXSuDWEOBgKQI3QLMIOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 057/168] mac80211: fix an off-by-one issue in A-MSDU max_subframe computation
Date:   Mon,  8 Oct 2018 20:30:37 +0200
Message-Id: <20181008175622.220586721@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 66eb02d839e8495ae6b612e2d09ff599374b80e2 ]

Initialize 'n' to 2 in order to take into account also the first
packet in the estimation of max_subframe limit for a given A-MSDU
since frag_tail pointer is NULL when ieee80211_amsdu_aggregate
routine analyzes the second frame.

Fixes: 6e0456b54545 ("mac80211: add A-MSDU tx support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/tx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3174,7 +3174,7 @@ static bool ieee80211_amsdu_aggregate(st
 	void *data;
 	bool ret = false;
 	unsigned int orig_len;
-	int n = 1, nfrags, pad = 0;
+	int n = 2, nfrags, pad = 0;
 	u16 hdrlen;
 
 	if (!ieee80211_hw_check(&local->hw, TX_AMSDU))


