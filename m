Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48be+nubbZNzqam8gnpdbJ7QHMInJsv8DH3jkLg3dig3dM2NrsOVYQAC0zXQ2f0FSh/V32T
ARC-Seal: i=1; a=rsa-sha256; t=1523399753; cv=none;
        d=google.com; s=arc-20160816;
        b=CwRinyrPSRSUp5Tdv0yq4zSQBnmuUGNiPy30zJ2vIXWtqXAJxC1ezocCAYnirQLyB4
         IFE43KEdi1zLFkvktCgxhEoml1x1NTJ9udqk4p+XPmQc7xybMew3L0Nyu9xlX6Gv2SEu
         B66y3D49WARZRQ20SA50jlZWDfwxFBUzpsBzLK261sEWd6QZDxYGeWUSYFk9Yvh0fJWc
         VTed3GfX8cxnBluGgDOBMvf6Pp7DMbhJ4yyn+gd1767NdsBmpyq53b18tYJDfYeEjVv6
         cS5I44f8h3jN262XwSx3WWeg0p6vYcfAToxmIWLrVLBuY/apr+8VyjUvhwq08Bhdlq+J
         QuJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3atcZgmi8sEhtjwrbPoADmrhcm9MDOgf+JiXE+uhjHQ=;
        b=a6Y4ZC9Yc0otK0vIjy1MecPY+aTs/zmcbdy1bMsylmOd4J85DH5XPLxPdfkc0ErCpq
         KuCeh5VZRwtgMs+13x9FqohPq3X257ybzO2jlfHEfQ9f/5GryAULl4x0c1wBOkw9s4Rx
         JB7Bdxms82ETnGNgH/X2VSlmpzKQ0HpD0Lsz50eQoUxLFcX1I1YTfXwBWLAPa8HsBDca
         tNcOewhD2AuvmXOexr1rSpERwbbmi9ERPLGFI5n+PT+8TaPFJZCOnEFiAcNyGliCy0pz
         QNcaha7JA4TTt1lRkwOnfFJKjVUSs6VOouQSRjBiJCkS8rQ1si+vmjlBvf9Ics+KHuVP
         1fZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Peter=20Gro=C3=9Fe?= <pegro@friiks.de>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 034/138] mac80211: Fix setting TX power on monitor interfaces
Date: Wed, 11 Apr 2018 00:23:44 +0200
Message-Id: <20180410212906.074731000@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399905951439472?=
X-GMAIL-MSGID: =?utf-8?q?1597400420525342644?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Peter Gro�e" <pegro@friiks.de>


[ Upstream commit 3a3713ec360138f806c6fc368d1de570f692b347 ]

Instead of calling ieee80211_recalc_txpower on monitor interfaces
directly, call it using the virtual monitor interface, if one exists.

In case of a single monitor interface given, reject setting TX power,
if no virtual monitor interface exists.

That being checked, don't warn in ieee80211_bss_info_change_notify,
after setting TX power on a monitor interface.

Fixes warning:
------------[ cut here ]------------
 WARNING: CPU: 0 PID: 2193 at net/mac80211/driver-ops.h:167
 ieee80211_bss_info_change_notify+0x111/0x190 Modules linked in: uvcvideo
 videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core
rndis_host cdc_ether usbnet mii tp_smapi(O) thinkpad_ec(O) ohci_hcd vboxpci(O)
 vboxnetadp(O) vboxnetflt(O) v boxdrv(O) x86_pkg_temp_thermal kvm_intel kvm
 irqbypass iwldvm iwlwifi ehci_pci ehci_hcd tpm_tis tpm_tis_core tpm CPU: 0
 PID: 2193 Comm: iw Tainted: G           O    4.12.12-gentoo #2 task:
 ffff880186fd5cc0 task.stack: ffffc90001b54000 RIP:
 0010:ieee80211_bss_info_change_notify+0x111/0x190 RSP: 0018:ffffc90001b57a10
 EFLAGS: 00010246 RAX: 0000000000000006 RBX: ffff8801052ce840 RCX:
 0000000000000064 RDX: 00000000fffffffc RSI: 0000000000040000 RDI:
 ffff8801052ce840 RBP: ffffc90001b57a38 R08: 0000000000000062 R09:
 0000000000000000 R10: ffff8802144b5000 R11: ffff880049dc4614 R12:
 0000000000040000 R13: 0000000000000064 R14: ffff8802105f0760 R15:
 ffffc90001b57b48 FS:  00007f92644b4580(0000) GS:ffff88021e200000(0000)
 knlGS:0000000000000000 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f9263c109f0 CR3: 00000001df850000 CR4: 00000000000406f0
 Call Trace:
  ieee80211_recalc_txpower+0x33/0x40
  ieee80211_set_tx_power+0x40/0x180
  nl80211_set_wiphy+0x32e/0x950

Reported-by: Peter Große <pegro@friiks.de>
Signed-off-by: Peter Große <pegro@friiks.de>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/cfg.c        |   28 +++++++++++++++++++++++++++-
 net/mac80211/driver-ops.h |    3 ++-
 2 files changed, 29 insertions(+), 2 deletions(-)

--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2373,10 +2373,17 @@ static int ieee80211_set_tx_power(struct
 	struct ieee80211_sub_if_data *sdata;
 	enum nl80211_tx_power_setting txp_type = type;
 	bool update_txp_type = false;
+	bool has_monitor = false;
 
 	if (wdev) {
 		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
+		if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
+			sdata = rtnl_dereference(local->monitor_sdata);
+			if (!sdata)
+				return -EOPNOTSUPP;
+		}
+
 		switch (type) {
 		case NL80211_TX_POWER_AUTOMATIC:
 			sdata->user_power_level = IEEE80211_UNSET_POWER_LEVEL;
@@ -2415,15 +2422,34 @@ static int ieee80211_set_tx_power(struct
 
 	mutex_lock(&local->iflist_mtx);
 	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
+			has_monitor = true;
+			continue;
+		}
 		sdata->user_power_level = local->user_power_level;
 		if (txp_type != sdata->vif.bss_conf.txpower_type)
 			update_txp_type = true;
 		sdata->vif.bss_conf.txpower_type = txp_type;
 	}
-	list_for_each_entry(sdata, &local->interfaces, list)
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
+			continue;
 		ieee80211_recalc_txpower(sdata, update_txp_type);
+	}
 	mutex_unlock(&local->iflist_mtx);
 
+	if (has_monitor) {
+		sdata = rtnl_dereference(local->monitor_sdata);
+		if (sdata) {
+			sdata->user_power_level = local->user_power_level;
+			if (txp_type != sdata->vif.bss_conf.txpower_type)
+				update_txp_type = true;
+			sdata->vif.bss_conf.txpower_type = txp_type;
+
+			ieee80211_recalc_txpower(sdata, update_txp_type);
+		}
+	}
+
 	return 0;
 }
 
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -165,7 +165,8 @@ static inline void drv_bss_info_changed(
 	if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_P2P_DEVICE ||
 			 sdata->vif.type == NL80211_IFTYPE_NAN ||
 			 (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
-			  !sdata->vif.mu_mimo_owner)))
+			  !sdata->vif.mu_mimo_owner &&
+			  !(changed & BSS_CHANGED_TXPOWER))))
 		return;
 
 	if (!check_sdata_in_driver(sdata))
