Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuqdlzgtNdJJ2GX48cc5d6nhuwO5WkxvQeTcWZNL1OD0nV533GTdc1GoofZe9JYmZvx6WJA
ARC-Seal: i=1; a=rsa-sha256; t=1521483209; cv=none;
        d=google.com; s=arc-20160816;
        b=sRfGl+8Vlp1CuIZhe6Dxvg2szqMZhWZCV40NUHXgCUXEobEOkNLRiMDP2bb4nIOxq5
         BdPGyeAfKvfAu6Zt5pMXXSBU1OmKXANTn3xcJLD2vMau5s4QbJGIl8Xk41yQos2YHiuM
         OrC/uU/UtwkOZdTp+t0MfjVn06EBgZqop2jseqq038reaLfj8MIK3HUJ4/NAwicsCLhO
         H8tfKg9hM27j/dKsNaNxjxVmRUmrPb3qwFxHtUntAfItAiSDTRl4jDVuzI8zqYksXvy8
         Ox0jITRC4CzCD+afKnUyWdkinzaBJm544l1lNOsTEMTVEB0OggaZxk74wXXh74RmOmdp
         uHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l3tM1sLibZj3CHp62HFKhGxu5oVf4qFfY6TEMoV0gng=;
        b=0alkvQbS6mxfbj0hHuA3qywHUmFBwkaHl++ze9AjPby7Ba1fC/ToKGwIkNOaQj/ZAN
         NQ4aWSEnIbVhQ/5tOnWVLziBJMIWa6/luLSddlECHatpIYjzYgZqXZ3i47z84XBK0Fqz
         +uRPsIZJxfdN/w84c+b4NqTF4AIX+7oA0puepWEmJfbWulCuaBGxD7RaSFYwQROPwWGf
         IYqvMd+6inMl14BpPu4wxgzwORISLS3mcLQT5SAzhP2LH63sNknpVvFw5Ov3f87XJMIJ
         qqsc6dvyDbqUvw2+dGL12Kw2LMk+PjSmgF5YMoJ3V3WMYyD4UO+lDstz35vWs2jZr2S6
         A9ww==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 007/134] ath10k: fix a warning during channel switch with multiple vaps
Date: Mon, 19 Mar 2018 19:04:50 +0100
Message-Id: <20180319171850.177736568@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390777971895276?=
X-GMAIL-MSGID: =?utf-8?q?1595390777971895276?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>


[ Upstream commit c73f8c00330f59ce9b1ace9ff698aca83390d358 ]

Doing a channel switch via hostapd_cli seems to update
the new channel context for each VAP's appropriately as below
in 'ath10k_mac_update_vif_chan', hence we can safely suppress the
warning that shows up during this operation and dump the warning only
if no vaps are available for channel switch

hostapd_cli -i wlan0 chan_switch 5 5200
OK

ath10k_pci : mac chanctx switch n_vifs 3 mode 1
ath10k_pci : mac chanctx switch vdev_id 2 freq 5180->5200 width 0->0
ath10k_pci : mac chanctx switch vdev_id 1 freq 5180->5200 width 0->0
ath10k_pci : mac chanctx switch vdev_id 0 freq 5180->5200 width 0->0

Call Trace:

WARNING: backports-20161201-3.14.77-9ab3068/drivers/net/wireless/ath/ath10k/mac.c:7126
[<c022f2d4>] (warn_slowpath_null) from [<bf7f150c>]
(ath10k_reconfig_complete+0xe4/0x25c [ath10k_core])
[<bf7f150c>] (ath10k_reconfig_complete [ath10k_core])
[<bf7f35f0>] (ath10k_mac_vif_ap_csa_work+0x214/0x370 [ath10k_core])
[<bf7f38b8>] (ath10k_mac_op_change_chanctx+0x108/0x128 [ath10k_core])
[<bf782ac0>] (ieee80211_recalc_chanctx_min_def+0x30c/0x430 [mac80211])
[<bf7830a4>] (ieee80211_recalc_smps_chanctx+0x2ec/0x840 [mac80211])
[<bf7843e8>] (ieee80211_vif_use_reserved_context+0x7c/0xf8 [mac80211])
[<bf7843e8>] (ieee80211_vif_use_reserved_context [mac80211])
[<bf76e5d4>] (ieee80211_csa_finalize_work+0x5c/0x88 [mac80211])

Fixes: d7bf4b4aba05 ("ath10k: fix ar->rx_channel updating logic")
Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/mac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6427,7 +6427,7 @@ ath10k_mac_update_rx_channel(struct ath1
 	lockdep_assert_held(&ar->data_lock);
 
 	WARN_ON(ctx && vifs);
-	WARN_ON(vifs && n_vifs != 1);
+	WARN_ON(vifs && !n_vifs);
 
 	/* FIXME: Sort of an optimization and a workaround. Peers and vifs are
 	 * on a linked list now. Doing a lookup peer -> vif -> chanctx for each
