Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2316C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989B42087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsdC7LiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989B42087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbeJIB7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1ED32087D;
        Mon,  8 Oct 2018 18:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024373;
        bh=0r3J1KOEI377580CkCqnL5/cAb814sLlx/WbPDaxt7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lsdC7LiH5TAXseKR3UnTycdAtmTxP4VxSCDriJN7yZqm/gqANL8h+fKKKoXB4tbzE
         M3e2VtTPoQkdZH7iSrNvDtOX68gB40E48Ojf4DZzJc9T9G6eXA9f/ZB8xTh3UnCMmx
         S9cEjnTz0AsXUWYjrZ2lyScVHfW5Xm3tH70TsKrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 020/168] nl80211: Pass center frequency in kHz instead of MHz
Date:   Mon,  8 Oct 2018 20:30:00 +0200
Message-Id: <20181008175620.817622948@linuxfoundation.org>
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

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

[ Upstream commit b88d26d97c41680f7327e5fb8061ad0037877f40 ]

freq_reg_info expects to get the frequency in kHz. Instead we
accidently pass it in MHz.  Thus, currently the function always
return ERR rule. Fix that.

Fixes: 50f32718e125 ("nl80211: Add wmm rule attribute to NL80211_CMD_GET_WIPHY dump command")
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
[fix kHz/MHz in commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -764,7 +764,7 @@ static int nl80211_msg_put_channel(struc
 
 	if (large) {
 		const struct ieee80211_reg_rule *rule =
-			freq_reg_info(wiphy, chan->center_freq);
+			freq_reg_info(wiphy, MHZ_TO_KHZ(chan->center_freq));
 
 		if (!IS_ERR_OR_NULL(rule) && rule->has_wmm) {
 			if (nl80211_msg_put_wmm_rules(msg, rule))


