Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F62C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C01205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zmmWGjPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C01205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbeK3B1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731856AbeK3B1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:27:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085DA2145D;
        Thu, 29 Nov 2018 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501328;
        bh=S18KEXnh5sFGd8BYZcJ49sY/VG2z1vq/7jM9Z6jl5aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmmWGjPzEtbG1v5z8JezdiEIhpDgcZRKTH3B0rTl6UwYrD3kfEO8N+70t5J8qQMon
         PD6mv8j7TSh/B1t7fRshRGnVZ9pKs9RsZU2ED0VGV9a8PcWWvb98lh8IrdDuyBf06i
         248MfQ4VcqbIZZWgCbBBvyH8P3QiH8JqygsUHzCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 45/92] ath10k: fix kernel panic due to race in accessing arvif list
Date:   Thu, 29 Nov 2018 15:12:14 +0100
Message-Id: <20181129140109.881773978@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>

commit ebaa4b1620bf69f2bc43cb45ea85fbafdaec23c3 upstream.

arvifs list is traversed within data_lock spin_lock in tasklet
context to fill channel information from the corresponding vif.
This means any access to arvifs list for add/del operations
should also be protected with the same spin_lock to avoid the
race. Fix this by performing list add/del on arvfis within the
data_lock. This could fix kernel panic something like the below.

 LR is at ath10k_htt_rx_pktlog_completion_handler+0x100/0xb6c [ath10k_core]
 PC is at ath10k_htt_rx_pktlog_completion_handler+0x1c0/0xb6c [ath10k_core]
 Internal error: Oops: 17 [#1] PREEMPT SMP ARM
 [<bf4857f4>] (ath10k_htt_rx_pktlog_completion_handler+0x2f4/0xb6c [ath10k_core])
 [<bf487540>] (ath10k_htt_txrx_compl_task+0x8b4/0x1188 [ath10k_core])
 [<c00312d4>] (tasklet_action+0x8c/0xec)
 [<c00309a8>] (__do_softirq+0xdc/0x208)
 [<c0030d6c>] (irq_exit+0x84/0xe0)
 [<c005db04>] (__handle_domain_irq+0x80/0xa0)
 [<c00085c4>] (gic_handle_irq+0x38/0x5c)
 [<c0009640>] (__irq_svc+0x40/0x74)

(gdb) list *(ath10k_htt_rx_pktlog_completion_handler+0x1c0)
0x136c0 is in ath10k_htt_rx_h_channel (drivers/net/wireless/ath/ath10k/htt_rx.c:769)
764		struct cfg80211_chan_def def;
765
766		lockdep_assert_held(&ar->data_lock);
767
768		list_for_each_entry(arvif, &ar->arvifs, list) {
769			if (arvif->vdev_id == vdev_id &&
770			    ath10k_mac_vif_chan(arvif->vif, &def) == 0)
771				return def.chan;
772		}
773

Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/mac.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4967,7 +4967,9 @@ static int ath10k_add_interface(struct i
 	}
 
 	ar->free_vdev_map &= ~(1LL << arvif->vdev_id);
+	spin_lock_bh(&ar->data_lock);
 	list_add(&arvif->list, &ar->arvifs);
+	spin_unlock_bh(&ar->data_lock);
 
 	/* It makes no sense to have firmware do keepalives. mac80211 already
 	 * takes care of this with idle connection polling.
@@ -5118,7 +5120,9 @@ err_peer_delete:
 err_vdev_delete:
 	ath10k_wmi_vdev_delete(ar, arvif->vdev_id);
 	ar->free_vdev_map |= 1LL << arvif->vdev_id;
+	spin_lock_bh(&ar->data_lock);
 	list_del(&arvif->list);
+	spin_unlock_bh(&ar->data_lock);
 
 err:
 	if (arvif->beacon_buf) {
@@ -5164,7 +5168,9 @@ static void ath10k_remove_interface(stru
 			    arvif->vdev_id, ret);
 
 	ar->free_vdev_map |= 1LL << arvif->vdev_id;
+	spin_lock_bh(&ar->data_lock);
 	list_del(&arvif->list);
+	spin_unlock_bh(&ar->data_lock);
 
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP ||
 	    arvif->vdev_type == WMI_VDEV_TYPE_IBSS) {


