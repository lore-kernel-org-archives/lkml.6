Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F76C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB1F2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMru1mbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB1F2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeJIByT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbeJIByS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395D02064A;
        Mon,  8 Oct 2018 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024073;
        bh=EDlLkj2pklvqm3m6qklfk6o/57Rqel8TaPcKhdDDbDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMru1mbGq5hC5VEsZmjUbu3a+APwoqxfoaKNvQ/YbRLaHrQw1TP65L4kHTBsxdteR
         FZC/s8hXwMa0PEzg8Gbu/9gp230qNYsWV8csYGavyS3pi59Cp7lhMrdQ4xxJwn24MZ
         WUytJOu/nWBHMuEDir5hqVurORF1BcrTXjAd3gqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Danek Duvall <duvall@comfychair.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 11/94] mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X
Date:   Mon,  8 Oct 2018 20:30:52 +0200
Message-Id: <20181008175605.592286855@linuxfoundation.org>
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

From: Danek Duvall <duvall@comfychair.org>

[ Upstream commit d7c863a2f65e48f442379f4ee1846d52e0c5d24d ]

The mac80211_hwsim driver intends to say that it supports up to four
STBC receive streams, but instead it ends up saying something undefined.
The IEEE80211_VHT_CAP_RXSTBC_X macros aren't independent bits that can
be ORed together, but values.  In this case, _4 is the appropriate one
to use.

Signed-off-by: Danek Duvall <duvall@comfychair.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2632,9 +2632,6 @@ static int mac80211_hwsim_new_radio(stru
 				IEEE80211_VHT_CAP_SHORT_GI_80 |
 				IEEE80211_VHT_CAP_SHORT_GI_160 |
 				IEEE80211_VHT_CAP_TXSTBC |
-				IEEE80211_VHT_CAP_RXSTBC_1 |
-				IEEE80211_VHT_CAP_RXSTBC_2 |
-				IEEE80211_VHT_CAP_RXSTBC_3 |
 				IEEE80211_VHT_CAP_RXSTBC_4 |
 				IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK;
 			sband->vht_cap.vht_mcs.rx_mcs_map =


