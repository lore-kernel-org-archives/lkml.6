Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAF5C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB601222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898142;
	bh=hSQxcZ1MXmRyFVByP3mi0tAkGAyC/osrP7mQdvspwSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZnPyIbomg2ma0nDMYLCJkF0VMo1rMEikrMaCwoG3H9qkuKPUWWT9jPz4Tz9IyyeMh
	 2qRKKgikcX4DNMNjF4uf20mBgUnHDJz29adcC9I3IxU+qolIZEOF5EPUyREZgD+eLQ
	 PB5y4HBA0Z7GxC6VitMFDO2qPhUrznFi0Nuv0JAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391374AbfBKPHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:57268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390905AbfBKPH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A460222A7;
        Mon, 11 Feb 2019 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897647;
        bh=hSQxcZ1MXmRyFVByP3mi0tAkGAyC/osrP7mQdvspwSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxNMim13xWTy6vOPoyyBqVGbq9IXsr1W8EavfnKwuxcQZRRvZvPK2E4cWd1gy3kAu
         jtcBIhgzitHJvSe6LwB07E5E9QXtxRlI3Wf4IYYSckVQOlqSOl7L0iT/mLRb/5R3uK
         PFd9yH/FAsWnN7Tzw1SM6ki3Os5cp6dAAN6xh6pU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 067/137] cw1200: Fix concurrency use-after-free bugs in cw1200_hw_scan()
Date:   Mon, 11 Feb 2019 15:19:08 +0100
Message-Id: <20190211141818.191080414@linuxfoundation.org>
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
 drivers/net/wireless/st/cw1200/scan.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/scan.c b/drivers/net/wireless/st/cw1200/scan.c
index 0a0ff7e31f5b..c5492d792f43 100644
--- a/drivers/net/wireless/st/cw1200/scan.c
+++ b/drivers/net/wireless/st/cw1200/scan.c
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



