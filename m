Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E42C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9AFE20839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AFE20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387617AbeHWMTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:19:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51480 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732508AbeHWMTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:19:37 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96AC3BE0;
        Thu, 23 Aug 2018 08:50:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 142/324] mac80211: disable BHs/preemption in ieee80211_tx_control_port()
Date:   Thu, 23 Aug 2018 09:53:28 +0200
Message-Id: <20180823075003.047550058@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Kenzior <denkenz@gmail.com>

[ Upstream commit e7441c9274a6a5453e06f4c2b8b5f72eca0a3f17 ]

On pre-emption enabled kernels the following print was being seen due to
missing local_bh_disable/local_bh_enable calls.  mac80211 assumes that
pre-emption is disabled in the data path.

    BUG: using smp_processor_id() in preemptible [00000000] code: iwd/517
    caller is __ieee80211_subif_start_xmit+0x144/0x210 [mac80211]
    [...]
    Call Trace:
    dump_stack+0x5c/0x80
    check_preemption_disabled.cold.0+0x46/0x51
    __ieee80211_subif_start_xmit+0x144/0x210 [mac80211]

Fixes: 911806491425 ("mac80211: Add support for tx_control_port")
Signed-off-by: Denis Kenzior <denkenz@gmail.com>
[commit message rewrite, fixes tag]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/tx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4800,7 +4800,9 @@ int ieee80211_tx_control_port(struct wip
 	skb_reset_network_header(skb);
 	skb_reset_mac_header(skb);
 
+	local_bh_disable();
 	__ieee80211_subif_start_xmit(skb, skb->dev, flags);
+	local_bh_enable();
 
 	return 0;
 }


