Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvuHJpUMuGn+lNLpLsCpjs7ciHbf+1Tase2znn8djrw371kR4VKKF3+kjxXXR0F+kpHxPpR
ARC-Seal: i=1; a=rsa-sha256; t=1521483560; cv=none;
        d=google.com; s=arc-20160816;
        b=CR7dN6p7MGFTY35xDAXy80j8c5ybrybwVhLAoej02Ki+qm/0QxdYpA7ucIMeU563b6
         PCs56U8hfgNrj1Dxz1PUC8loev3SEF3PzlKUqEH2ur3+RA+mb6ZSy7EQSG9ADB45a2B2
         7IPMHgEISc+SW9uLofj4n07Y+XYK4aOCUQOZ8DH1qp0MBxJ6oqVnM1R9uceKpU9zjJrW
         7Rn2SsONMVkpW3OZ1pJXLX2NmjG2wk/pc1DwGexHgmnTWXgQE02UqhiDEbrpYXVO4t90
         tKsiMsKZoaIXB1q/CPTx1wiyn8A7J83qb2UIZqJ2C6HSVQu2lTAOXcjy/iM7WPUli1ug
         f46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pFJWBwWgP7KRhfroXCjsl7AiPg11emHNLrVYFkkooX8=;
        b=DzjXNnEdBmGIHUkSgP+lHkEB6By0MOE2wzdd2mxCABaBPfyCLJ7+ZlYP05tSEcvrOX
         xhnOphfFObzTKLata8AQ6XMFT9R0lnhk4fKIrdMNpSjsKld2WOogP6/i2JI1d8G9Nxvg
         l6/zQvfRn//1xsRlztsGV2cb3B0bvFQQmHn2pXFch5z3UjjiIec0/2iB/F8zKLjcHYmx
         0hZ55JRwCUmr72erePWwjebxjDAtx4F11ak9W7mlxJEWk/PnXpOeRjjxoInIAQViYYYy
         3VCPc9GWoy5eo04dapLNlLOS6aZOoOD7xU2KQcfpSKRpzSVIaP9e6M90KDMQvH8HI/a7
         U6Zg==
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
Subject: [PATCH 4.9 034/241] ath10k: fix fetching channel during potential radar detection
Date: Mon, 19 Mar 2018 19:04:59 +0100
Message-Id: <20180319180752.591707462@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391145874736449?=
X-GMAIL-MSGID: =?utf-8?q?1595391145874736449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>


[ Upstream commit a28f6f27a88f047f03f04b9246ca260ebc91455e ]

Fetch target operating channel during potential radar detection when
the interface is just brought up, but no channel is assigned from
userspace. In this scenario rx_channel may not be having a valid pointer
hence fetch the target operating channel to avoid warnings as below
which can be triggered by the commands with DFS testing over longer run

comamnds:
iw wlan1 set type mesh
ifconfig wlan1 up (valid tgt_oper_chan only)
iw wlan1 cac trigger freq 5260 HT20 (valid rx_channel, tgt_oper_chan)
iw wlan1 cac trigger freq 5280 HT20
iw wlan1 cac trigger freq 5300 HT20

Once the CAC expires, current channel context will be removed and
we are only left with the fallback option of using 'target operating
channel'

Firmware and driver log:
ath: phy1: DFS: radar found on freq=5300: id=1, pri=1125, count=5,
count_false=4
ath: phy1: DFS: radar found on freq=5260: id=5, pri=3151, count=6,
count_false=11
ath: phy1: DFS: radar found on freq=5280: id=1, pri=1351, count=6,
count_false=4
ath: phy1: DFS: radar found on freq=5300: id=1, pri=1125, count=5,
count_false=4
ath10k_pci 0001:01:00.0: failed to derive channel for radar pulse,
treating as radar
ath10k_pci 0001:01:00.0: failed to derive channel for radar pulse,
treating as radar

Call trace:

WARNING: CPU: 1 PID: 2145 at
backports-20161201-3.14.77-9ab3068/net/wireless/chan.c:265
cfg80211_set_dfs_state+0x3c/0x88 [cfg80211]()

 Workqueue: phy1 ieee80211_dfs_radar_detected_work
[mac80211]
[<c0320770>] (warn_slowpath_null) from [<bf79b90c>]
(cfg80211_set_dfs_state+0x3c/0x88 [cfg80211])
[<bf79b90c>] (cfg80211_set_dfs_state [cfg80211]) from
[<bf79697c>] (cfg80211_radar_event+0xc4/0x140 [cfg80211])
[<bf79697c>] (cfg80211_radar_event [cfg80211]) from
[<bf83c058>] (ieee80211_dfs_radar_detected_work+0xa8/0xb4 [mac80211])
[<bf83c058>] (ieee80211_dfs_radar_detected_work
[mac80211]) from [<c0339518>] (process_one_work+0x298/0x4a4)

Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/wmi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3638,6 +3638,11 @@ static void ath10k_dfs_radar_report(stru
 
 	spin_lock_bh(&ar->data_lock);
 	ch = ar->rx_channel;
+
+	/* fetch target operating channel during channel change */
+	if (!ch)
+		ch = ar->tgt_oper_chan;
+
 	spin_unlock_bh(&ar->data_lock);
 
 	if (!ch) {
