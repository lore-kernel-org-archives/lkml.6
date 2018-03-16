Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvJ9um1qWLdgei8clXB/YceGbu6ggGJADU2XPeXguF/i1QoGTxFhjOL3Ok7dlyHAafgL0ch
ARC-Seal: i=1; a=rsa-sha256; t=1521215003; cv=none;
        d=google.com; s=arc-20160816;
        b=mwWAjwe8CL+8oGXhxgp5vSk/ev3uXdaQqn0dX5gHsZBRZzLZDwXQ6qS4TiF3pNS5xj
         W7JJO6+oEWUymdeaLTjKsdcKDe2xuRP4SQ1IzqCAOCiXal2Loif1tSjKl3ZBIocL1/a2
         FsvuLUl4NPluEWzDSH8rBNEKpo9YWY1VkzfwH2fFFzjEboNS0r2yNNOCLmjk9ePfPXPk
         8kliIhttsQ8A7jle2A0tJqRvOcRW1oBVh2uKhTJ+vE7J3MnTBP/57l8z2yaEIT5CzkKH
         LYZuFLnF19Q7+aWcIExt/paSb5ihUfK6uAMusCiWnjIq60gS9gLD34+bNQ5q/hzLEKOz
         Tlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3S5hkyfGenmLTQWZzA1c/6aC4zRY6q38nGIV2A+BxFI=;
        b=m39iiW01hTNnW79/NpV+vhAX+3hhjiLci450P5Nj4BkDG57M6aDdFObiTDfZGqI+7o
         dVrHPZH7ykmjjZVvSTS3rKMFZMdAMAryagoiUlXaQ5uxi2cKJJyAt5ahWZZrFoeXlowL
         N9bRxdU+S9E138SO1bi7Q8w+AvJ8fq/F8RqAbJQWWo7K7PoOF02VTjzSc1lNb2ImSDt+
         goYJnFQhzNVYqRD5eLWDQPHHI64KL9MuLoLxD9X8sXp2FeUuZwkk+lde9YPTfSzVBazx
         u+gv2LB1/K+ZZnm299QDmh7oagiiAZco/HBLfQ62zKjcjczcyK2ksH+ZEcrCScYPg26a
         +QJw==
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
Subject: [PATCH 4.15 094/128] mwifiex: cfg80211: do not change virtual interface during scan processing
Date: Fri, 16 Mar 2018 16:23:55 +0100
Message-Id: <20180316152341.246459244@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109159552331303?=
X-GMAIL-MSGID: =?utf-8?q?1595109542952718647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1116,6 +1116,12 @@ mwifiex_cfg80211_change_virtual_intf(str
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
