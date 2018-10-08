Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DE8C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8318B214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXHXzUo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8318B214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbeJICDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbeJICDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D686204FD;
        Mon,  8 Oct 2018 18:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024601;
        bh=zuC7Y14P9MlJBXwp0fDbgZFM/9O6QTSnvVR/fry8fKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXHXzUo2e2OzL/Wr4fyZHydEF3j3jBo/P9k+ZckeYA4my0muJQgh+fiQWjZnm7ibw
         MQ9SKUqjzyFi6380WdNlBbSqk0sdOJqNWUWK6J8Pxzcnp4iIFxn9yTjc9SB0dP74fq
         ysBxh2rkjCay25kZNSCZmOt7u12MIom5kVBUtg1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 059/168] mac80211: fix WMM TXOP calculation
Date:   Mon,  8 Oct 2018 20:30:39 +0200
Message-Id: <20181008175622.293561736@linuxfoundation.org>
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

From: "Dreyfuss, Haim" <haim.dreyfuss@intel.com>

[ Upstream commit abd76d255d69d70206c01b9cb19ba36a9c1df6a1 ]

In commit 9236c4523e5b ("mac80211: limit wmm params to comply
with ETSI requirements"), we have limited the WMM parameters to
comply with 802.11 and ETSI standard.  Mistakenly the TXOP value
was caluclated wrong.  Fix it by taking the minimum between
802.11 to ETSI to make sure we are not violating both.

Fixes: e552af058148 ("mac80211: limit wmm params to comply with ETSI requirements")
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/util.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1151,8 +1151,7 @@ void ieee80211_regulatory_limit_wmm_para
 	qparam->cw_min = max_t(u16, qparam->cw_min, wmm_ac->cw_min);
 	qparam->cw_max = max_t(u16, qparam->cw_max, wmm_ac->cw_max);
 	qparam->aifs = max_t(u8, qparam->aifs, wmm_ac->aifsn);
-	qparam->txop = !qparam->txop ? wmm_ac->cot / 32 :
-		min_t(u16, qparam->txop, wmm_ac->cot / 32);
+	qparam->txop = min_t(u16, qparam->txop, wmm_ac->cot / 32);
 	rcu_read_unlock();
 }
 


