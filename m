Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9260EC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538B121479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YknC90bE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538B121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbeJIB6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:58:52 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B84B2087D;
        Mon,  8 Oct 2018 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024346;
        bh=WUvoHHhguRsBAOaE0SoyeetpJzc2gPq5FmUS1WQodHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YknC90bEJm61EZWAB+AO906J+hzn0kxMpaRQIVwreMchnu30jbrhABGpb414gkExA
         QKphJwex/8I01SgTQoiLdu9iMk6ZYe66Gm991rrqZWrzXaqi70sCIoVCYjBbT7j1W+
         SYd5RooJcvK26EVizjDcLbW35S/NrXxjygNgvA3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+2a12f11c306afe871c1f@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 003/168] mac80211_hwsim: require at least one channel
Date:   Mon,  8 Oct 2018 20:29:43 +0200
Message-Id: <20181008175620.171849782@linuxfoundation.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 484004339d4514fde425f6e8a9f6a6cc979bb0c3 ]

Syzbot continues to try to create mac80211_hwsim radios, and
manages to pass parameters that are later checked with WARN_ON
in cfg80211 - catch another one in hwsim directly.

Reported-by: syzbot+2a12f11c306afe871c1f@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3194,6 +3194,11 @@ static int hwsim_new_radio_nl(struct sk_
 	if (info->attrs[HWSIM_ATTR_CHANNELS])
 		param.channels = nla_get_u32(info->attrs[HWSIM_ATTR_CHANNELS]);
 
+	if (param.channels < 1) {
+		GENL_SET_ERR_MSG(info, "must have at least one channel");
+		return -EINVAL;
+	}
+
 	if (param.channels > CFG80211_MAX_NUM_DIFFERENT_CHANNELS) {
 		GENL_SET_ERR_MSG(info, "too many channels specified");
 		return -EINVAL;


