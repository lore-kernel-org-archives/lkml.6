Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFB2C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB8C2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0HM9YCwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB8C2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbeJKXPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeJKXPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:15:09 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B2DB2147C;
        Thu, 11 Oct 2018 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272844;
        bh=fEw28/XEuMuofUhIQjA+G88olbS/sh+5mOsEKu9eORQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0HM9YCwlyvAr3b6K61e5vksEYOg+xAkr6wCrnD+9x6KnbC/lOm6eDMZWVWJLqyC+3
         W2jSp6nbgWzKnSsCiPDwlniuE86ay2Y5jPgopV3/RhzOezq9C0vePC8kRzymK7s7Na
         GpvLc45tev9f2jW3xrR/mJ/Z59IbrKVOBtkPgFs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Catrinel Catrinescu <cc@80211.de>,
        Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.18 14/44] mac80211: allocate TXQs for active monitor interfaces
Date:   Thu, 11 Oct 2018 17:39:52 +0200
Message-Id: <20181011152453.118926892@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152452.571669983@linuxfoundation.org>
References: <20181011152452.571669983@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit 8105f9b8a8879bff7f1d43d0720c993a99c9d135 upstream.

Monitor mode interfaces with the active flag are passed down to the driver.
Drivers using TXQ expect that all interfaces have allocated TXQs before
they get added.

Fixes: 79af1f866193d ("mac80211: avoid allocating TXQs that won't be used")
Cc: stable@vger.kernel.org
Reported-by: Catrinel Catrinescu <cc@80211.de>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/iface.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1756,7 +1756,8 @@ int ieee80211_if_add(struct ieee80211_lo
 
 		if (local->ops->wake_tx_queue &&
 		    type != NL80211_IFTYPE_AP_VLAN &&
-		    type != NL80211_IFTYPE_MONITOR)
+		    (type != NL80211_IFTYPE_MONITOR ||
+		     (params->flags & MONITOR_FLAG_ACTIVE)))
 			txq_size += sizeof(struct txq_info) +
 				    local->hw.txq_data_size;
 


