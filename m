Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77C9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFBD20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544711;
	bh=bSJcPJE7Hr2YTMZpNd44wO2/sEDF8WKHa23u/I4goPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fcf8n55AzQF9PR9Rf1vrlLUdFDWQbpPUK+EM4+6YrTodKkXhpVXJrVv0VNHJy6AlD
	 H0POO5DZXF/C9FlLrlAoCWFeYBVtOY1FiKYWLFQ0VksEtSGrfVl8n6ohFEriKMFDf0
	 r+v3nPArohOaMZLYKDDlFbnczkW2LQCB7KIAZK0E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFBD20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbeLKQLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:11:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729311AbeLKPug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54FD52084E;
        Tue, 11 Dec 2018 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543435;
        bh=bSJcPJE7Hr2YTMZpNd44wO2/sEDF8WKHa23u/I4goPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPNt6XyJnngD85sFpZsYRzuSnsBhlsZ6wojqjp1HoAkIM4NSony8biU1GflyYbTi6
         QD6GDYFVV7MF5gBy08EfL7aWMgycSgGTNg1c0wy6CJQnwXki95267MJmmO8UHwd8Nr
         BSGo8oC1wfhOP1uEJE6ffojwj86n7s/Xf0RWWebc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 49/51] mac80211: ignore NullFunc frames in the duplicate detection
Date:   Tue, 11 Dec 2018 16:41:57 +0100
Message-Id: <20181211151618.447983362@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 990d71846a0b7281bd933c34d734e6afc7408e7e upstream.

NullFunc packets should never be duplicate just like
QoS-NullFunc packets.

We saw a client that enters / exits power save with
NullFunc frames (and not with QoS-NullFunc) despite the
fact that the association supports HT.
This specific client also re-uses a non-zero sequence number
for different NullFunc frames.
At some point, the client had to send a retransmission of
the NullFunc frame and we dropped it, leading to a
misalignment in the power save state.
Fix this by never consider a NullFunc frame as duplicate,
just like we do for QoS NullFunc frames.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=201449

CC: <stable@vger.kernel.org>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/rx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1230,6 +1230,7 @@ ieee80211_rx_h_check_dup(struct ieee8021
 		return RX_CONTINUE;
 
 	if (ieee80211_is_ctl(hdr->frame_control) ||
+	    ieee80211_is_nullfunc(hdr->frame_control) ||
 	    ieee80211_is_qos_nullfunc(hdr->frame_control) ||
 	    is_multicast_ether_addr(hdr->addr1))
 		return RX_CONTINUE;


