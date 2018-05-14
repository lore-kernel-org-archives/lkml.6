Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrhvdh6FO1nhokwtxm4jS3RHH47ydUKtiL+5N55/Mmg8Jo7XJ8ojXElC49tp7eZ627xHXDE
ARC-Seal: i=1; a=rsa-sha256; t=1526280722; cv=none;
        d=google.com; s=arc-20160816;
        b=Nej9kw/WM2Bz2To30YcZ3fFIDI4Rpf+7Jo2+zb58/AE3s5+CrD9MRJ1yWlBh0KtLzV
         xqWmimIUVoiEBqFG9hNwz7doDpNgqS92M71ZIdoh3diM3udgcrA4fDPjj1BAFtV74Q6p
         u4KsegVBMTRnS+qL3vK5OXxM09ftwyzcaic9vnvBGMs9LR/UhgnX/XH/J1M3ICA2y5pR
         BFD7hWaxPgOC71ux3lBdKNYwAsRhs1BvUUG5fF6HOGpduv9uWEpHNY3iwC6KQrNX/48V
         C2Qte6HpkLrIhUTPaOBmXqK3J3ifECScyN5URYopj8fV8kvPTNzt2ts8EeDpyZhLF1lY
         7NGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=H2d1ZECQUVYZJ7OonIttJy1VDXAxCt0yF6gaGqA0/G0=;
        b=xmHIdMWww1RKNZLeTaQYylk4hT0GrYoSXKWosGn6Js9Nh10OfCf+nrZPPL9+f5XBps
         MxIqB550DhFeYUI3iCbqVL71m0ZsGkeoU3O5xSr33fLBSDGB+IJwNc8eBwtK1bSJ8lM9
         TZc0+hEB3+Uev6fUFZNcQ4zMJTMGhAiJ4u1FGeALM9E02thD+9Y4Coc+uzG3GpUDQeUY
         u8/0mDsk9l2cagquPynKs/1TkRXXzirUzUCSS5qxkI8iv982YtoMxNkMG3MhcDa86Yj/
         DjH1+2GlIsIem5LswZJ1nS57gCHO904RvIuVnyX1CzQ1v7pOd/BM6Mjopp20/WDzxxNv
         XD9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TaeCnvu+;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TaeCnvu+;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Spinadel <david.spinadel@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sriram R <srirrama@codeaurora.org>
Subject: [PATCH 4.4 07/56] mac80211: Add RX flag to indicate ICV stripped
Date: Mon, 14 May 2018 08:48:12 +0200
Message-Id: <20180514064755.647627131@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421334839366293?=
X-GMAIL-MSGID: =?utf-8?q?1600421334839366293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Spinadel <david.spinadel@intel.com>

commit cef0acd4d7d4811d2d19cd0195031bf0dfe41249 upstream.

Add a flag that indicates that the WEP ICV was stripped from an
RX packet, allowing the device to not transfer that if it's
already checked.

Signed-off-by: David Spinadel <david.spinadel@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Cc: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/mac80211.h |    5 ++++-
 net/mac80211/wep.c     |    3 ++-
 net/mac80211/wpa.c     |    3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -975,7 +975,7 @@ ieee80211_tx_info_clear_status(struct ie
  * @RX_FLAG_DECRYPTED: This frame was decrypted in hardware.
  * @RX_FLAG_MMIC_STRIPPED: the Michael MIC is stripped off this frame,
  *	verification has been done by the hardware.
- * @RX_FLAG_IV_STRIPPED: The IV/ICV are stripped from this frame.
+ * @RX_FLAG_IV_STRIPPED: The IV and ICV are stripped from this frame.
  *	If this flag is set, the stack cannot do any replay detection
  *	hence the driver or hardware will have to do that.
  * @RX_FLAG_PN_VALIDATED: Currently only valid for CCMP/GCMP frames, this
@@ -1034,6 +1034,8 @@ ieee80211_tx_info_clear_status(struct ie
  * @RX_FLAG_ALLOW_SAME_PN: Allow the same PN as same packet before.
  *	This is used for AMSDU subframes which can have the same PN as
  *	the first subframe.
+ * @RX_FLAG_ICV_STRIPPED: The ICV is stripped from this frame. CRC checking must
+ *	be done in the hardware.
  */
 enum mac80211_rx_flags {
 	RX_FLAG_MMIC_ERROR		= BIT(0),
@@ -1066,6 +1068,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_RADIOTAP_VENDOR_DATA	= BIT(31),
 	RX_FLAG_MIC_STRIPPED		= BIT_ULL(32),
 	RX_FLAG_ALLOW_SAME_PN		= BIT_ULL(33),
+	RX_FLAG_ICV_STRIPPED		= BIT_ULL(34),
 };
 
 #define RX_FLAG_STBC_SHIFT		26
--- a/net/mac80211/wep.c
+++ b/net/mac80211/wep.c
@@ -293,7 +293,8 @@ ieee80211_crypto_wep_decrypt(struct ieee
 			return RX_DROP_UNUSABLE;
 		ieee80211_wep_remove_iv(rx->local, rx->skb, rx->key);
 		/* remove ICV */
-		if (pskb_trim(rx->skb, rx->skb->len - IEEE80211_WEP_ICV_LEN))
+		if (!(status->flag & RX_FLAG_ICV_STRIPPED) &&
+		    pskb_trim(rx->skb, rx->skb->len - IEEE80211_WEP_ICV_LEN))
 			return RX_DROP_UNUSABLE;
 	}
 
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -298,7 +298,8 @@ ieee80211_crypto_tkip_decrypt(struct iee
 		return RX_DROP_UNUSABLE;
 
 	/* Trim ICV */
-	skb_trim(skb, skb->len - IEEE80211_TKIP_ICV_LEN);
+	if (!(status->flag & RX_FLAG_ICV_STRIPPED))
+		skb_trim(skb, skb->len - IEEE80211_TKIP_ICV_LEN);
 
 	/* Remove IV */
 	memmove(skb->data + IEEE80211_TKIP_IV_LEN, skb->data, hdrlen);
