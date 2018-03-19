Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv1IZkaIfXweMVVu89EIGEojYTtmDSd20kGNdVPle5Ks3dantILAF1IiBTSaHSzcSWWfL7j
ARC-Seal: i=1; a=rsa-sha256; t=1521483982; cv=none;
        d=google.com; s=arc-20160816;
        b=o3bA7K+t0ePdpOozt/ZHPraYQjUXnO8clLyNlf98StjKpyRWYVR7SNS9B6wzfApfTN
         K5Rw8YBbUCdL7dF2sfiwr4ZGGI38AyAl1NgrOOpYfjj6Lk2ANkI97SJGtD9TPlDpoWWb
         XK5xXLZqiBppakGAs2DMwDuomxr7EFKdCPuE2XHusdoqXTxChgh4ZzbKpd5Kzj05f6az
         CPM9VxfI54sUgsQ7syGitDPROQ5snCC4rArD/HMMiae4PZ0XlxMzHQ60faV8rR3LnTNU
         aFWGhl5GmRPf2vCcuGsKX/LNwRUSlxAyA7gt/o9qtaqHt4cOsIFfZHlhjQGfpVPPpmpf
         EEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NHp19sSJc0Ysj3WJ7hHXTQ6LofK8SlRHymmjPM4Fwug=;
        b=r//v/YFRvZ9zF0feohWWLKwmEXvjxTX1RsjXsyZMJYUZiGokk/88BgFnNwer7EUjRb
         uCzV97cB5F0vBoy1jMC83dLtHRPAylaGFkPRqkCNtHDt/ZWaEWQEkBXtcB1vXTCn11IR
         tWAVYkMwB1fRlrDhYXlBD4Oos/6poaejbAgHZd026o7xXBw4kljKSmaWO5EFA8SZQEqc
         VsyDgWiZJcY8QJmnk310uPHvHNLW/ibD1/K79oVMiYZLr6y7VBN7ATo4p14+bIGK44XK
         iuioGD4+CPTmHaTbZWndsFGqQMomh+5Z12QTD6Z7+xsbTL3Wc+GwCgd7hcQd/GIz0YZR
         vmlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Limin Zhu <liminzhu@marvell.com>,
	Xinming Hu <huxm@marvell.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 189/241] mwifiex: cfg80211: do not change virtual interface during scan processing
Date: Mon, 19 Mar 2018 19:07:34 +0100
Message-Id: <20180319180758.971784748@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391588673319503?=
X-GMAIL-MSGID: =?utf-8?q?1595391588673319503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Limin Zhu <liminzhu@marvell.com>


[ Upstream commit c61cfe49f0f0f0d1f8b56d0b045838d597e8c3a3 ]

(1) Change virtual interface operation in cfg80211 process reset and
reinitilize private data structure.
(2) Scan result event processed in main process will dereference private
data structure concurrently, ocassionly crash the kernel.

The cornel case could be trigger by below steps:
(1) wpa_cli mlan0 scan
(2) ./hostapd mlan0.conf

Cfg80211 asynchronous scan procedure is not all the time operated
under rtnl lock, here we add the protect to serialize the cfg80211
scan and change_virtual interface operation.

Signed-off-by: Limin Zhu <liminzhu@marvell.com>
Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1109,6 +1109,12 @@ mwifiex_cfg80211_change_virtual_intf(str
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	enum nl80211_iftype curr_iftype = dev->ieee80211_ptr->iftype;
 
+	if (priv->scan_request) {
+		mwifiex_dbg(priv->adapter, ERROR,
+			    "change virtual interface: scan in process\n");
+		return -EBUSY;
+	}
+
 	switch (curr_iftype) {
 	case NL80211_IFTYPE_ADHOC:
 		switch (type) {
