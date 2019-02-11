Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD8AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF42C20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896424;
	bh=sO7e0nkqbpsrVyXhkC5b4+Qg5Y2G2RkZrSiXeEiIOKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hhOHa1XVpUkfnqEz7YTbCWYWjoDfd1kaXsipYicX4zl3eIm+XDp30sqU8mM5/wXJ0
	 KNv0J5QuIGBs+inHHcj5DShqZucljaTF7bciQI78q2fM21Yi2/JlEVh49iXzskMstk
	 9OcEZQtitYZ8fCwotvSg9yDCz0PLXJ1lV/ygZPRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbfBKOrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:47:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732327AbfBKOrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:47:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7589B206BA;
        Mon, 11 Feb 2019 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896420;
        bh=sO7e0nkqbpsrVyXhkC5b4+Qg5Y2G2RkZrSiXeEiIOKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UON6l885eSNQ/CR5lLXSezGqWXy3P6je4QJ5ZTavm+rp0AbKDonv8Q2sn6UEFKp7P
         tJ58xyKsbTzUpuyAfsnDdlc4JLUzx9/FvlzaQvUkOsC7UQoXRmBOpev2V2sNZ/4DY1
         Bbiz/bGmMrJB7AAsXNsKnF+co7anOmq+grSZBrT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 178/313] mac80211: fix radiotap vendor presence bitmap handling
Date:   Mon, 11 Feb 2019 15:17:38 +0100
Message-Id: <20190211141905.245584686@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit efc38dd7d5fa5c8cdd0c917c5d00947aa0539443 ]

Due to the alignment handling, it actually matters where in the code
we add the 4 bytes for the presence bitmap to the length; the first
field is the timestamp with 8 byte alignment so we need to add the
space for the extra vendor namespace presence bitmap *before* we do
any alignment for the fields.

Move the presence bitmap length accounting to the right place to fix
the alignment for the data properly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 5e2b4a41acf1..51ad330bf8e8 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -142,6 +142,9 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	/* allocate extra bitmaps */
 	if (status->chains)
 		len += 4 * hweight8(status->chains);
+	/* vendor presence bitmap */
+	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA)
+		len += 4;
 
 	if (ieee80211_have_rx_timestamp(status)) {
 		len = ALIGN(len, 8);
@@ -197,8 +200,6 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA) {
 		struct ieee80211_vendor_radiotap *rtap = (void *)skb->data;
 
-		/* vendor presence bitmap */
-		len += 4;
 		/* alignment for fixed 6-byte vendor data header */
 		len = ALIGN(len, 2);
 		/* vendor data header */
-- 
2.19.1



