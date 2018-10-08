Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E19C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FFF21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ5Nb4Kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6FFF21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbeJIB7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:01 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5818214C4;
        Mon,  8 Oct 2018 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024355;
        bh=jl9580sxSzt3B4tTaPRE2FfSDPpL5UqPeYLUJ0ty6tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZ5Nb4KxjNiQGc3sSpt1V3EPpwBVnhZWAWXXPjLLXfiaTQYcGqYEXxFMH2SWk/Jb5
         v2/azyWkCKe29mcLc7W7cyAQNeUzCoc+evbs0Ttd+pOBmDSKXEbd9wuxN1JuSYUd84
         Dd5K+AothTJ8sSebd9AdVuWIkb/kjZJx7Kxb8Dfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 006/168] cfg80211: remove division by size of sizeof(struct ieee80211_wmm_rule)
Date:   Mon,  8 Oct 2018 20:29:46 +0200
Message-Id: <20181008175620.285806689@linuxfoundation.org>
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

[ Upstream commit 8a54d8fc160e67ad485d95a0322ce1221f80770a ]

Pointer arithmetic already adjusts by the size of the struct,
so the sizeof() calculation is wrong. This is basically the
same as Colin King's patch for similar code in the iwlwifi
driver.

Fixes: 230ebaa189af ("cfg80211: read wmm rules from regulatory database")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/reg.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -452,8 +452,7 @@ reg_copy_regd(const struct ieee80211_reg
 			continue;
 
 		regd->reg_rules[i].wmm_rule = d_wmm +
-			(src_regd->reg_rules[i].wmm_rule - s_wmm) /
-			sizeof(struct ieee80211_wmm_rule);
+			(src_regd->reg_rules[i].wmm_rule - s_wmm);
 	}
 	return regd;
 }


