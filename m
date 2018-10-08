Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C581C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32452087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci/bEuT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32452087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeJIByY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbeJIByY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFE2D2064A;
        Mon,  8 Oct 2018 18:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024079;
        bh=LcHVTKCQ0WOD1e3qssd0UUfRi2PvBFOlLOFdas6f2PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ci/bEuT6dV/yrDDAnb8+EA9qjP6EOgvEy+7tri7DyYkX5sJsb/0ZGhufPwOU/HS+t
         4fvLPk6xKtxDK3ydDoK/roJfCoq3RcxXDCn9LtEQVlrdz51mDDpb+9+ig1htVe3+Mh
         4Y051BnitADlwyBAhHNYpiIO10ANAdXFmNmC0Ww0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuan-Chi Pang <fu3mo6goo@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 13/94] mac80211: mesh: fix HWMP sequence numbering to follow standard
Date:   Mon,  8 Oct 2018 20:30:54 +0200
Message-Id: <20181008175605.689013566@linuxfoundation.org>
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

From: Yuan-Chi Pang <fu3mo6goo@gmail.com>

[ Upstream commit 1f631c3201fe5491808df143d8fcba81b3197ffd ]

IEEE 802.11-2016 14.10.8.3 HWMP sequence numbering says:
If it is a target mesh STA, it shall update its own HWMP SN to
maximum (current HWMP SN, target HWMP SN in the PREQ element) + 1
immediately before it generates a PREP element in response to a
PREQ element.

Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mesh_hwmp.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -572,6 +572,10 @@ static void hwmp_preq_frame_process(stru
 		forward = false;
 		reply = true;
 		target_metric = 0;
+
+		if (SN_GT(target_sn, ifmsh->sn))
+			ifmsh->sn = target_sn;
+
 		if (time_after(jiffies, ifmsh->last_sn_update +
 					net_traversal_jiffies(sdata)) ||
 		    time_before(jiffies, ifmsh->last_sn_update)) {


