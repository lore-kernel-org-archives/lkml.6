Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A098EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A72B204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jknPlUwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A72B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbeJIB7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56CB2087D;
        Mon,  8 Oct 2018 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024370;
        bh=igfHERKDCbOMFKj32NpmeuEvS8MiHh4djFTDEFe2q+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jknPlUwGWPzllgvuMh1mWMKq6pEiR8oXMpGMZVklO338kKNZuLCmUOAPwNo2fSZVd
         7/71AC49u2E8UMhxaCSi0qMMNO5qbi8yUCUKG60iggyzpTOrN7DcLKrsHJw8xLeYpM
         5JMLcUQ70aJkG6HyxIRMFtvKQleCu74AS+ELWneY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 019/168] nl80211: Fix nla_put_u8 to u16 for NL80211_WMMR_TXOP
Date:   Mon,  8 Oct 2018 20:29:59 +0200
Message-Id: <20181008175620.779756107@linuxfoundation.org>
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

[ Upstream commit d3c89bbc7491d5e288ca2993e999d24ba9ff52ad ]

TXOP (also known as Channel Occupancy Time) is u16 and should be
added using nla_put_u16 instead of u8, fix that.

Fixes: 50f32718e125 ("nl80211: Add wmm rule attribute to NL80211_CMD_GET_WIPHY dump command")
Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -672,8 +672,8 @@ static int nl80211_msg_put_wmm_rules(str
 				rule->wmm_rule.client[j].cw_max) ||
 		    nla_put_u8(msg, NL80211_WMMR_AIFSN,
 			       rule->wmm_rule.client[j].aifsn) ||
-		    nla_put_u8(msg, NL80211_WMMR_TXOP,
-			       rule->wmm_rule.client[j].cot))
+		    nla_put_u16(msg, NL80211_WMMR_TXOP,
+			        rule->wmm_rule.client[j].cot))
 			goto nla_put_failure;
 
 		nla_nest_end(msg, nl_wmm_rule);


