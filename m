Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C47C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0C52147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0C52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeHWL6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:58:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47660 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbeHWL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:58:17 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDB658B1;
        Thu, 23 Aug 2018 08:29:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 111/217] nl80211: check nla_parse_nested() return values
Date:   Thu, 23 Aug 2018 09:53:44 +0200
Message-Id: <20180823075510.475538641@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 95bca62fb723a121954fc7ae5473bb2c1f0d5986 ]

At the very least we should check the return value if
nla_parse_nested() is called with a non-NULL policy.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/nl80211.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10529,9 +10529,12 @@ static int nl80211_set_wowlan(struct sk_
 				    rem) {
 			u8 *mask_pat;
 
-			nla_parse_nested(pat_tb, MAX_NL80211_PKTPAT, pat,
-					 nl80211_packet_pattern_policy,
-					 info->extack);
+			err = nla_parse_nested(pat_tb, MAX_NL80211_PKTPAT, pat,
+					       nl80211_packet_pattern_policy,
+					       info->extack);
+			if (err)
+				goto error;
+
 			err = -EINVAL;
 			if (!pat_tb[NL80211_PKTPAT_MASK] ||
 			    !pat_tb[NL80211_PKTPAT_PATTERN])
@@ -10780,8 +10783,11 @@ static int nl80211_parse_coalesce_rule(s
 			    rem) {
 		u8 *mask_pat;
 
-		nla_parse_nested(pat_tb, MAX_NL80211_PKTPAT, pat,
-				 nl80211_packet_pattern_policy, NULL);
+		err = nla_parse_nested(pat_tb, MAX_NL80211_PKTPAT, pat,
+				       nl80211_packet_pattern_policy, NULL);
+		if (err)
+			return err;
+
 		if (!pat_tb[NL80211_PKTPAT_MASK] ||
 		    !pat_tb[NL80211_PKTPAT_PATTERN])
 			return -EINVAL;


