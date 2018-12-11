Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F394C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2517C21104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543938;
	bh=rJmvEOCrS+ivRRR8gypou3uNE1WonnB+MKK/NlAfXy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bWBylTBI1O4dGRgOAIvZVfzv3vCpa08L9oDGJFBIH0biIfv4HRZs+r4e987JVGjRX
	 nWU5TFAMikZCrVWxS2Lc4ioKxxUTQamCr5aRNZOaI9Xojz92KUIJelGAH0joqwTDhD
	 R2z3qwBgd7Ly+pUgqO1VgtTCGzoj78yLM08iBIz0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2517C21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbeLKP65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731102AbeLKP6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C28522145D;
        Tue, 11 Dec 2018 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543933;
        bh=rJmvEOCrS+ivRRR8gypou3uNE1WonnB+MKK/NlAfXy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=maxpEYynHwmKXDVKYeAgciaXRuoknUS0KrY3LIZGRYprzFlnTHw1/b3ck7FqFBxL2
         4RIPvTnMiAG0BrhgX0BFSqqeP4fRB9quiV52daW/5SrtVkqoIcakxFZJ7c9cXPdzKr
         G7qsjYjSQgQz/YoT5pTM5SAKi5ILqdojZ5VHh7I0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.19 113/118] mac80211: fix GFP_KERNEL under tasklet context
Date:   Tue, 11 Dec 2018 16:42:12 +0100
Message-Id: <20181211151648.825577652@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

commit c752cac9db1b0c469db7ba9d17af4ba708984db5 upstream.

cfg80211_sta_opmode_change_notify needs a gfp_t flag to hint the nl80211
stack when allocating new skb, but it is called under tasklet context
here with GFP_KERNEL and kernel will yield a warning about it.

Cc: stable@vger.kernel.org
Fixes: ff84e7bfe176 ("mac80211: Add support to notify ht/vht opmode modification.")
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
ACKed-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/rx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3029,7 +3029,7 @@ ieee80211_rx_h_action(struct ieee80211_r
 			cfg80211_sta_opmode_change_notify(sdata->dev,
 							  rx->sta->addr,
 							  &sta_opmode,
-							  GFP_KERNEL);
+							  GFP_ATOMIC);
 			goto handled;
 		}
 		case WLAN_HT_ACTION_NOTIFY_CHANWIDTH: {
@@ -3066,7 +3066,7 @@ ieee80211_rx_h_action(struct ieee80211_r
 			cfg80211_sta_opmode_change_notify(sdata->dev,
 							  rx->sta->addr,
 							  &sta_opmode,
-							  GFP_KERNEL);
+							  GFP_ATOMIC);
 			goto handled;
 		}
 		default:


