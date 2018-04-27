Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpgZi+t8ZxQe71O3XIXXJgr1SF0ko5t+ZRwErW4s49P1y2Y7xiYrLzgI0Dpc29H6vpgG3As
ARC-Seal: i=1; a=rsa-sha256; t=1524837812; cv=none;
        d=google.com; s=arc-20160816;
        b=o6cW5nteCWRjVCuQ2YLa9gwaE14D4R8bkYTa7cPAU+2C9sOnbujCWUhocEiHlGQotL
         a8kCQSDJyBawBv45tJH0r1rbh9S4INd8vDmmlgHyPO0BUkikndb/pNcrfNVPyL7FENkR
         GnsDPrfWgo+S9WLc8LefORc5UlaqNkOMQdtseWGNTRFviI2kbjF76oNcuf99e58/kJ7c
         uajAfFSXgXdr2Q33Lz1jHByzZbPUBMOYduyihYdmpDStR3hs1FjCPP4Xcj94LpTYcOE5
         KMKiB0qtoa5VcJrCX778PzwxQd+dmG0XuXlxkJnrdj7QS+/ScujkIBSGp7fgbg5RqG99
         9Yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=EDpAkeGbRyypQwW7P8GUFSa2yeD0RndsF6lQen7vP5I=;
        b=tqjEpv4rd/KiP0SXfUvC5FUOZJLgS9ur4IlPLMcBHinUtJbuOHE9/lcyVXUIR3pWpi
         Qs1+wxAvwAMdQAeBAb6qYsPQSBJwqmBC4FW8TnqTeazwhOKdimKFF96/v5NAvv4jTt1H
         L2/qihlCr9UaApUxCfWMFzAD82IydXiy7gJ+uGS2O7DDUbJbFHxly3vZ0sUSz511ABsb
         wrTIemCcfJciBnIxi9m2JT8xyn9PW4d0m5TRJmiGD/aSyPiyDmZP3FBKpX5i+lWx7IfV
         tymo5hdXuBAIeGKzDOr4p6uUAGShleF9jrtYUNUMXyMX8Nj7mK7BITuf1D9pw7lXUN4M
         S+hA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194F92189D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Karthikeyan Periyasamy <periyasa@codeaurora.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 26/74] Revert "ath10k: send (re)assoc peer command when NSS changed"
Date: Fri, 27 Apr 2018 15:58:16 +0200
Message-Id: <20180427135711.006935824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908224486989129?=
X-GMAIL-MSGID: =?utf-8?q?1598908333471895075?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

commit 55cc11da69895a680940c1733caabc37be685f5e upstream.

This reverts commit 55884c045d31a29cf69db8332d1064a1b61dd159.

When Ath10k is in AP mode and an unassociated STA sends a VHT action frame
(Operating Mode Notification for the NSS change) periodically to AP this causes
ath10k to call ath10k_station_assoc() which sends WMI_PEER_ASSOC_CMDID during
NSS update. Over the time (with a certain client it can happen within 15 mins
when there are over 500 of these VHT action frames) continuous calls of
WMI_PEER_ASSOC_CMDID cause firmware to assert due to resource exhaust.

To my knowledge setting WMI_PEER_NSS peer param itself enough to handle NSS
updates and no need to call ath10k_station_assoc(). So revert the original
commit from 2014 as it's unclear why the change was really needed.
Now the firmware assert doesn't happen anymore.

Issue observed in QCA9984 platform with firmware version:10.4-3.5.3-00053.
This Change tested in QCA9984 with firmware version: 10.4-3.5.3-00053 and
QCA988x platform with firmware version: 10.2.4-1.0-00036.

Firmware Assert log:

ath10k_pci 0002:01:00.0: firmware crashed! (guid e61f1274-9acd-4c5b-bcca-e032ea6e723c)
ath10k_pci 0002:01:00.0: qca9984/qca9994 hw1.0 target 0x01000000 chip_id 0x00000000 sub 168c:cafe
ath10k_pci 0002:01:00.0: kconfig debug 1 debugfs 1 tracing 0 dfs 1 testmode 1
ath10k_pci 0002:01:00.0: firmware ver 10.4-3.5.3-00053 api 5 features no-p2p,mfp,peer-flow-ctrl,btcoex-param,allows-mesh-bcast crc32 4c56a386
ath10k_pci 0002:01:00.0: board_file api 2 bmi_id 0:4 crc32 c2271344
ath10k_pci 0002:01:00.0: htt-ver 2.2 wmi-op 6 htt-op 4 cal otp max-sta 512 raw 0 hwcrypto 1
ath10k_pci 0002:01:00.0: firmware register dump:
ath10k_pci 0002:01:00.0: [00]: 0x0000000A 0x000015B3 0x00981E5F 0x00975B31
ath10k_pci 0002:01:00.0: [04]: 0x00981E5F 0x00060530 0x00000011 0x00446C60
ath10k_pci 0002:01:00.0: [08]: 0x0042F1FC 0x00458080 0x00000017 0x00000000
ath10k_pci 0002:01:00.0: [12]: 0x00000009 0x00000000 0x00973ABC 0x00973AD2
ath10k_pci 0002:01:00.0: [16]: 0x00973AB0 0x00960E62 0x009606CA 0x00000000
ath10k_pci 0002:01:00.0: [20]: 0x40981E5F 0x004066DC 0x00400000 0x00981E34
ath10k_pci 0002:01:00.0: [24]: 0x80983B48 0x0040673C 0x000000C0 0xC0981E5F
ath10k_pci 0002:01:00.0: [28]: 0x80993DEB 0x0040676C 0x00431AB8 0x0045D0C4
ath10k_pci 0002:01:00.0: [32]: 0x80993E5C 0x004067AC 0x004303C0 0x0045D0C4
ath10k_pci 0002:01:00.0: [36]: 0x80994AAB 0x004067DC 0x00000000 0x0045D0C4
ath10k_pci 0002:01:00.0: [40]: 0x809971A0 0x0040681C 0x004303C0 0x00441B00
ath10k_pci 0002:01:00.0: [44]: 0x80991904 0x0040688C 0x004303C0 0x0045D0C4
ath10k_pci 0002:01:00.0: [48]: 0x80963AD3 0x00406A7C 0x004303C0 0x009918FC
ath10k_pci 0002:01:00.0: [52]: 0x80960E80 0x00406A9C 0x0000001F 0x00400000
ath10k_pci 0002:01:00.0: [56]: 0x80960E51 0x00406ACC 0x00400000 0x00000000
ath10k_pci 0002:01:00.0: Copy Engine register dump:
ath10k_pci 0002:01:00.0: index: addr: sr_wr_idx: sr_r_idx: dst_wr_idx: dst_r_idx:
ath10k_pci 0002:01:00.0: [00]: 0x0004a000 15 15 3 3
ath10k_pci 0002:01:00.0: [01]: 0x0004a400 17 17 212 213
ath10k_pci 0002:01:00.0: [02]: 0x0004a800 21 21 20 21
ath10k_pci 0002:01:00.0: [03]: 0x0004ac00 25 25 27 25
ath10k_pci 0002:01:00.0: [04]: 0x0004b000 515 515 144 104
ath10k_pci 0002:01:00.0: [05]: 0x0004b400 28 28 155 156
ath10k_pci 0002:01:00.0: [06]: 0x0004b800 12 12 12 12
ath10k_pci 0002:01:00.0: [07]: 0x0004bc00 1 1 1 1
ath10k_pci 0002:01:00.0: [08]: 0x0004c000 0 0 127 0
ath10k_pci 0002:01:00.0: [09]: 0x0004c400 1 1 1 1
ath10k_pci 0002:01:00.0: [10]: 0x0004c800 0 0 0 0
ath10k_pci 0002:01:00.0: [11]: 0x0004cc00 0 0 0 0
ath10k_pci 0002:01:00.0: CE[1] write_index 212 sw_index 213 hw_index 0 nentries_mask 0x000001ff
ath10k_pci 0002:01:00.0: CE[2] write_index 20 sw_index 21 hw_index 0 nentries_mask 0x0000007f
ath10k_pci 0002:01:00.0: CE[5] write_index 155 sw_index 156 hw_index 0 nentries_mask 0x000001ff
ath10k_pci 0002:01:00.0: DMA addr: nbytes: meta data: byte swap: gather:
ath10k_pci 0002:01:00.0: [455]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [456]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [457]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [458]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [459]: 0x580c0a42 0 0 0 0
ath10k_pci 0002:01:00.0: [460]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [461]: 0x580c0c42 0 0 0 0
ath10k_pci 0002:01:00.0: [462]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [463]: 0x580c0c42 0 0 0 0
ath10k_pci 0002:01:00.0: [464]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [465]: 0x580c0a42 0 0 0 0
ath10k_pci 0002:01:00.0: [466]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [467]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [468]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [469]: 0x580c1c42 0 0 0 0
ath10k_pci 0002:01:00.0: [470]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [471]: 0x580c1c42 0 0 0 0
ath10k_pci 0002:01:00.0: [472]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [473]: 0x580c1c42 0 0 0 0
ath10k_pci 0002:01:00.0: [474]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [475]: 0x580c0642 0 0 0 0
ath10k_pci 0002:01:00.0: [476]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [477]: 0x580c0842 0 0 0 0
ath10k_pci 0002:01:00.0: [478]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [479]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [480]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [481]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [482]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [483]: 0x580c0842 0 0 0 0
ath10k_pci 0002:01:00.0: [484]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [485]: 0x580c0642 0 0 0 0
ath10k_pci 0002:01:00.0: [486]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [487]: 0x580c0642 0 0 0 0
ath10k_pci 0002:01:00.0: [488]: 0x594a0038 0 0 0 1
ath10k_pci 0002:01:00.0: [489]: 0x580c0842 0 0 0 0
ath10k_pci 0002:01:00.0: [490]: 0x594a0060 0 0 0 1
ath10k_pci 0002:01:00.0: [491]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [492]: 0x58174040 0 1 0 0
ath10k_pci 0002:01:00.0: [493]: 0x5a946040 0 1 0 0
ath10k_pci 0002:01:00.0: [494]: 0x59909040 0 1 0 0
ath10k_pci 0002:01:00.0: [495]: 0x5ae5a040 0 1 0 0
ath10k_pci 0002:01:00.0: [496]: 0x58096040 0 1 0 0
ath10k_pci 0002:01:00.0: [497]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [498]: 0x580c0642 0 0 0 0
ath10k_pci 0002:01:00.0: [499]: 0x5c1e0040 0 1 0 0
ath10k_pci 0002:01:00.0: [500]: 0x58153040 0 1 0 0
ath10k_pci 0002:01:00.0: [501]: 0x58129040 0 1 0 0
ath10k_pci 0002:01:00.0: [502]: 0x5952f040 0 1 0 0
ath10k_pci 0002:01:00.0: [503]: 0x59535040 0 1 0 0
ath10k_pci 0002:01:00.0: [504]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [505]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [506]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [507]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [508]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [509]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [510]: 0x594a0010 0 0 0 1
ath10k_pci 0002:01:00.0: [511]: 0x580c0042 0 0 0 0
ath10k_pci 0002:01:00.0: [512]: 0x5adcc040 0 1 0 0
ath10k_pci 0002:01:00.0: [513]: 0x5cf3d040 0 1 0 0
ath10k_pci 0002:01:00.0: [514]: 0x5c1e9040 64 1 0 0
ath10k_pci 0002:01:00.0: [515]: 0x00000000 0 0 0 0

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/mac.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -5819,9 +5819,8 @@ static void ath10k_sta_rc_update_wk(stru
 				    sta->addr, smps, err);
 	}
 
-	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED ||
-	    changed & IEEE80211_RC_NSS_CHANGED) {
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac update sta %pM supp rates/nss\n",
+	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED) {
+		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac update sta %pM supp rates\n",
 			   sta->addr);
 
 		err = ath10k_station_assoc(ar, arvif->vif, sta, true);
