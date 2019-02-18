Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7EF21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498626;
	bh=EIYsO8mXMJBGQDes7FaU+b1+AgQ/LNzMp32bkUbPBkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tov4N7SzebdvOuZjgu9iwzpFKVvkrXJv1jVuy1ywLWLSDVth0DL/2E9jI1j8YxV3/
	 2fZBnLsGOtOCQWc9Y6/OGfgnX7iXz5GkGiY528LaGiTiNoNQZHzpJwGCQKGZZe9QEP
	 8eV5lBEqk1i7XmB6GhpPOmTK2OzJ828J3BKksp24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbfBRODp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:03:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389726AbfBRODm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC3621902;
        Mon, 18 Feb 2019 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498622;
        bh=EIYsO8mXMJBGQDes7FaU+b1+AgQ/LNzMp32bkUbPBkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubLRtyUFectiMoegqMzc4h8FELg1dZ0l2fLkBBb8+W4B17PbPZervOrbiQJpB9rKY
         3x0cHvviM3az3jkQCbv9gCypWtTPHAhU3MhAWnA9RAz7shJX5JLO/duN5/ta2WFgb0
         XUFK8SUKgINZIe7VZy0/cv2O4O7mTxPQFFk6lntI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 045/143] cw1200: Fix concurrency use-after-free bugs in cw1200_hw_scan()
Date:   Mon, 18 Feb 2019 14:42:53 +0100
Message-Id: <20190218133530.784715432@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4f68ef64cd7feb1220232bd8f501d8aad340a099 ]

The function cw1200_bss_info_changed() and cw1200_hw_scan() can be
concurrently executed.
The two functions both access a possible shared variable "frame.skb".

This shared variable is freed by dev_kfree_skb() in cw1200_upload_beacon(),
which is called by cw1200_bss_info_changed(). The free operation is
protected by a mutex lock "priv->conf_mutex" in cw1200_bss_info_changed().

In cw1200_hw_scan(), this shared variable is accessed without the
protection of the mutex lock "priv->conf_mutex".
Thus, concurrency use-after-free bugs may occur.

To fix these bugs, the original calls to mutex_lock(&priv->conf_mutex) and
mutex_unlock(&priv->conf_mutex) are moved to the places, which can
protect the accesses to the shared variable.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/cw1200/scan.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/cw1200/scan.c b/drivers/net/wireless/cw1200/scan.c
index bff81b8d4164..9f1037e7e55c 100644
--- a/drivers/net/wireless/cw1200/scan.c
+++ b/drivers/net/wireless/cw1200/scan.c
@@ -78,6 +78,10 @@ int cw1200_hw_scan(struct ieee80211_hw *hw,
 	if (req->n_ssids > WSM_SCAN_MAX_NUM_OF_SSIDS)
 		return -EINVAL;
 
+	/* will be unlocked in cw1200_scan_work() */
+	down(&priv->scan.lock);
+	mutex_lock(&priv->conf_mutex);
+
 	frame.skb = ieee80211_probereq_get(hw, priv->vif->addr, NULL, 0,
 		req->ie_len);
 	if (!frame.skb)
@@ -86,19 +90,15 @@ int cw1200_hw_scan(struct ieee80211_hw *hw,
 	if (req->ie_len)
 		memcpy(skb_put(frame.skb, req->ie_len), req->ie, req->ie_len);
 
-	/* will be unlocked in cw1200_scan_work() */
-	down(&priv->scan.lock);
-	mutex_lock(&priv->conf_mutex);
-
 	ret = wsm_set_template_frame(priv, &frame);
 	if (!ret) {
 		/* Host want to be the probe responder. */
 		ret = wsm_set_probe_responder(priv, true);
 	}
 	if (ret) {
+		dev_kfree_skb(frame.skb);
 		mutex_unlock(&priv->conf_mutex);
 		up(&priv->scan.lock);
-		dev_kfree_skb(frame.skb);
 		return ret;
 	}
 
@@ -120,10 +120,9 @@ int cw1200_hw_scan(struct ieee80211_hw *hw,
 		++priv->scan.n_ssids;
 	}
 
-	mutex_unlock(&priv->conf_mutex);
-
 	if (frame.skb)
 		dev_kfree_skb(frame.skb);
+	mutex_unlock(&priv->conf_mutex);
 	queue_work(priv->workqueue, &priv->scan.work);
 	return 0;
 }
-- 
2.19.1



