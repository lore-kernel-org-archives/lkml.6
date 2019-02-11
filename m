Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90E6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89048222A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897165;
	bh=GBhFM5vbTQl7D/ihm1dfBJ0b63r0qcX35NCBbGf1zwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T/aavtYjkqaO/jIR0hk/YIPnI2lU10bqaJCm6aF++X3MzNikUz8wkUEK86dj5pYQv
	 pYpjMPQVJXYEe0HGUBubmdwDMQh+X8fVQnLhFGIHDRzM8awRzdwKDLTdGMlFOqujwF
	 of+ALB2Vl6w3ug54iZBq/rqRA1w0Kssbq7fGeDbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbfBKO7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:59:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389742AbfBKO7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:59:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84150206BA;
        Mon, 11 Feb 2019 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897158;
        bh=GBhFM5vbTQl7D/ihm1dfBJ0b63r0qcX35NCBbGf1zwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brHvOpyfA88dNT1kOHDTIT3cda9RE2vAAhQ8Z3Z3Il8tlb2HfwEiZyVx+n02+JwTe
         t827sVwBOZu1Vc+bT/lPwhZhsd05XovwOwSb3fogcFGuYDdgcJnbVNZXeSJ2NBeOmk
         MWHHrRTqwuJjuvXylLamCXOKLyNAXa2sapYrY6Po=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 109/205] mac80211: fix radiotap vendor presence bitmap handling
Date:   Mon, 11 Feb 2019 15:18:27 +0100
Message-Id: <20190211141835.663894608@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 9e19ddbcb06e..c7ac1a480b1d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -141,6 +141,9 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	/* allocate extra bitmaps */
 	if (status->chains)
 		len += 4 * hweight8(status->chains);
+	/* vendor presence bitmap */
+	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA)
+		len += 4;
 
 	if (ieee80211_have_rx_timestamp(status)) {
 		len = ALIGN(len, 8);
@@ -182,8 +185,6 @@ ieee80211_rx_radiotap_hdrlen(struct ieee80211_local *local,
 	if (status->flag & RX_FLAG_RADIOTAP_VENDOR_DATA) {
 		struct ieee80211_vendor_radiotap *rtap = (void *)skb->data;
 
-		/* vendor presence bitmap */
-		len += 4;
 		/* alignment for fixed 6-byte vendor data header */
 		len = ALIGN(len, 2);
 		/* vendor data header */
-- 
2.19.1



