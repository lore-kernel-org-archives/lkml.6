Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F3AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA39222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897637;
	bh=f9zpnDp0l4b2/CBPGRPAbS6G6f+UKTaPACWFfUz3eTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aSrFtJcECbzNdzGn9ARW/r5qBv940Jf59oUV630eBvsIkKjtcEDzxoInD9cgE4fEW
	 3CpBUdCbh6nk1GMkQHD0PSV7xeMKc/dotwNMq9+XnWVsqTlaCoIO9tOfWRtAEgNg7S
	 VSwvyZjCAeVrfu+3FXrKbRMpIp1EAfJLxPEKOP2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391333AbfBKPHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:07:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390226AbfBKPHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99EEC217D9;
        Mon, 11 Feb 2019 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897630;
        bh=f9zpnDp0l4b2/CBPGRPAbS6G6f+UKTaPACWFfUz3eTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sepfbx3GDJ2clUf8CEqd/yJg7g4JfPXS8FHstxbU6s5vcbptIBouOU6KIDcwMM4yH
         O3woOM9Cobho+hPNfFRTIU7Grsni+5zcYBVN8hPNQrIB8w5pqY+lIVH7utGyzgU7A6
         cs6AAa0aeMKnRaaAzUI9dXZdRVlIJJ6CAVNgI3Ks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 062/137] mac80211: fix radiotap vendor presence bitmap handling
Date:   Mon, 11 Feb 2019 15:19:03 +0100
Message-Id: <20190211141817.715069018@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
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
index 93c332737e86..af02d2136a06 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -152,6 +152,9 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	/* allocate extra bitmaps */
 	if (status->chains)
 		len += 4 * hweight8(status->chains);
+	/* vendor presence bitmap */
+	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA)
+		len += 4;
 
 	if (ieee80211_have_rx_timestamp(status)) {
 		len = ALIGN(len, 8);
@@ -193,8 +196,6 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA) {
 		struct ieee80211_vendor_radiotap *rtap = (void *)skb->data;
 
-		/* vendor presence bitmap */
-		len += 4;
 		/* alignment for fixed 6-byte vendor data header */
 		len = ALIGN(len, 2);
 		/* vendor data header */
-- 
2.19.1



