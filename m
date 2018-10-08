Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C555C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AAA2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDbdqKsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AAA2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbeJIB40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:56:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeJIB4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:56:25 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 994F5214C3;
        Mon,  8 Oct 2018 18:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024200;
        bh=etXq8I7zTe260QPaxfQWclFzq5X0Qsg4tsIvtLMLJn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDbdqKsNON7fCPYYFy4QBBbkDZ3UGojNnFWPhMgBko0ij8UxzTEUoSsJ/mGqz1jZ0
         SMeyM4oBWocwkmSlbAK2/cvZRGye7jFeD0fx2w8iS3L5i0BCiz0g8wV7z/3hliMToF
         XN4tb8M8h6L7VHQUmeySWuzLNz2cyc+BXC23GN5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 32/94] mac80211: fix an off-by-one issue in A-MSDU max_subframe computation
Date:   Mon,  8 Oct 2018 20:31:13 +0200
Message-Id: <20181008175606.540190862@linuxfoundation.org>
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
@@ -3123,7 +3123,7 @@ static bool ieee80211_amsdu_aggregate(st
 	void *data;
 	bool ret = false;
 	unsigned int orig_len;
-	int n = 1, nfrags, pad = 0;
+	int n = 2, nfrags, pad = 0;
 	u16 hdrlen;
 
 	if (!ieee80211_hw_check(&local->hw, TX_AMSDU))


