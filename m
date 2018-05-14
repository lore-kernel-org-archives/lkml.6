Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqelaEZD44XmjIwGgMD79KTnU4Gm+64CWbrpv3/jZMSOVEjmuhh0AHTnwf81M/RKnZQdUpv
ARC-Seal: i=1; a=rsa-sha256; t=1526280717; cv=none;
        d=google.com; s=arc-20160816;
        b=i8f+IBv7YANB3AQfBR/IgUSYySvqNqRpcD99PFn5Fawx+pYQTpy5X9rFsAheynheYW
         AaYO5qrShyw1CH/PasLQg7fRK15bqC4zsJwNYwRqBBf4GodhNCSaCLElT8ZgRFSfGXMR
         gHX821pEuuyPZLqZEHslOul+Yt19HjuP+jxCYajSBm2Hxn+m4R4AWagkRNN547dycC4q
         GWp3eAlkooL+jRnZgSiPL2GOYUSFsb2mNbGEE5yxRgI5LNE+V2yRHkTlc5hdR8fUsmk0
         F0qccv4ogSbRa+FdwIlP1cl3YBhD3YHevnAigZn90zAcLFIbA30228df63mZign0Pora
         MdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZFwHqYfz1j1F/dOQd8esWgc33YKfiPFbxpJJIEGOQhc=;
        b=ilSjaB6ASTjC7BEJDPKfO6PUf8NnwqSViUcaVBoCshTAZwJEYvucr6aO4BbuDX4V7A
         kLGG7HH9Boexi5FRx3FLExf+KeCLDvNhOx1L5hqHgsw7r6TdjAHXOXv86tya/F0BNwHu
         SGKRzWZplMjTZt34eejyrq8zW4cZDDtoG9renbU7XOxm245oWS2zxVfNWNEp9ipGNIK0
         pe4MJ+95QxfZzTZa3hswNcJN3iGawHUcJTIdhnEgIG4Rdh/VmoaLWbHHBq3sCndgaEiL
         7cNySYukma+lPjlMILibp5nzY3TJLqOUmgUjqzCzNEtpwm2zKw+QpiyGLefhAH880ecg
         uk0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZzlZizWc;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZzlZizWc;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sara Sharon <sara.sharon@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sriram R <srirrama@codeaurora.org>
Subject: [PATCH 4.4 05/56] mac80211: allow not sending MIC up from driver for HW crypto
Date: Mon, 14 May 2018 08:48:10 +0200
Message-Id: <20180514064755.380450369@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421329628078714?=
X-GMAIL-MSGID: =?utf-8?q?1600421329628078714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sara Sharon <sara.sharon@intel.com>

commit f980ebc058c2fa2a552e495db1de0b330082ab70 upstream.

When HW crypto is used, there's no need for the CCMP/GCMP MIC to
be available to mac80211, and the hardware might have removed it
already after checking. The MIC is also useless to have when the
frame is already decrypted, so allow indicating that it's not
present.

Since we are running out of bits in mac80211_rx_flags, make
the flags field a u64.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Cc: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath10k/htt_rx.c |    2 +-
 drivers/net/wireless/ath/wcn36xx/txrx.c  |    2 +-
 include/net/mac80211.h                   |    5 ++++-
 net/mac80211/util.c                      |    5 +++--
 net/mac80211/wpa.c                       |   26 ++++++++++++++------------
 5 files changed, 23 insertions(+), 17 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -979,7 +979,7 @@ static void ath10k_process_rx(struct ath
 	*status = *rx_status;
 
 	ath10k_dbg(ar, ATH10K_DBG_DATA,
-		   "rx skb %p len %u peer %pM %s %s sn %u %s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%x fcs-err %i mic-err %i amsdu-more %i\n",
+		   "rx skb %p len %u peer %pM %s %s sn %u %s%s%s%s%s %srate_idx %u vht_nss %u freq %u band %u flag 0x%llx fcs-err %i mic-err %i amsdu-more %i\n",
 		   skb,
 		   skb->len,
 		   ieee80211_get_SA(hdr),
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -57,7 +57,7 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn,
 		       RX_FLAG_MMIC_STRIPPED |
 		       RX_FLAG_DECRYPTED;
 
-	wcn36xx_dbg(WCN36XX_DBG_RX, "status.flags=%x\n", status.flag);
+	wcn36xx_dbg(WCN36XX_DBG_RX, "status.flags=%llx\n", status.flag);
 
 	memcpy(IEEE80211_SKB_RXCB(skb), &status, sizeof(status));
 
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1013,6 +1013,8 @@ ieee80211_tx_info_clear_status(struct ie
  *	on this subframe
  * @RX_FLAG_AMPDU_DELIM_CRC_KNOWN: The delimiter CRC field is known (the CRC
  *	is stored in the @ampdu_delimiter_crc field)
+ * @RX_FLAG_MIC_STRIPPED: The mic was stripped of this packet. Decryption was
+ *	done by the hardware
  * @RX_FLAG_LDPC: LDPC was used
  * @RX_FLAG_STBC_MASK: STBC 2 bit bitmask. 1 - Nss=1, 2 - Nss=2, 3 - Nss=3
  * @RX_FLAG_10MHZ: 10 MHz (half channel) was used
@@ -1059,6 +1061,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_5MHZ			= BIT(29),
 	RX_FLAG_AMSDU_MORE		= BIT(30),
 	RX_FLAG_RADIOTAP_VENDOR_DATA	= BIT(31),
+	RX_FLAG_MIC_STRIPPED            = BIT_ULL(32),
 };
 
 #define RX_FLAG_STBC_SHIFT		26
@@ -1113,7 +1116,7 @@ struct ieee80211_rx_status {
 	u64 mactime;
 	u32 device_timestamp;
 	u32 ampdu_reference;
-	u32 flag;
+	u64 flag;
 	u16 freq;
 	u8 vht_flag;
 	u8 rate_idx;
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2663,8 +2663,9 @@ u64 ieee80211_calculate_rx_timestamp(str
 
 	rate = cfg80211_calculate_bitrate(&ri);
 	if (WARN_ONCE(!rate,
-		      "Invalid bitrate: flags=0x%x, idx=%d, vht_nss=%d\n",
-		      status->flag, status->rate_idx, status->vht_nss))
+		      "Invalid bitrate: flags=0x%llx, idx=%d, vht_nss=%d\n",
+		      (unsigned long long)status->flag, status->rate_idx,
+		      status->vht_nss))
 		return 0;
 
 	/* rewind from end of MPDU */
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -508,18 +508,20 @@ ieee80211_crypto_ccmp_decrypt(struct iee
 	    !ieee80211_is_robust_mgmt_frame(skb))
 		return RX_CONTINUE;
 
-	data_len = skb->len - hdrlen - IEEE80211_CCMP_HDR_LEN - mic_len;
-	if (!rx->sta || data_len < 0)
-		return RX_DROP_UNUSABLE;
-
 	if (status->flag & RX_FLAG_DECRYPTED) {
 		if (!pskb_may_pull(rx->skb, hdrlen + IEEE80211_CCMP_HDR_LEN))
 			return RX_DROP_UNUSABLE;
+		if (status->flag & RX_FLAG_MIC_STRIPPED)
+			mic_len = 0;
 	} else {
 		if (skb_linearize(rx->skb))
 			return RX_DROP_UNUSABLE;
 	}
 
+	data_len = skb->len - hdrlen - IEEE80211_CCMP_HDR_LEN - mic_len;
+	if (!rx->sta || data_len < 0)
+		return RX_DROP_UNUSABLE;
+
 	if (!(status->flag & RX_FLAG_PN_VALIDATED)) {
 		ccmp_hdr2pn(pn, skb->data + hdrlen);
 
@@ -724,8 +726,7 @@ ieee80211_crypto_gcmp_decrypt(struct iee
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	u8 pn[IEEE80211_GCMP_PN_LEN];
-	int data_len;
-	int queue;
+	int data_len, queue, mic_len = IEEE80211_GCMP_MIC_LEN;
 
 	hdrlen = ieee80211_hdrlen(hdr->frame_control);
 
@@ -733,19 +734,20 @@ ieee80211_crypto_gcmp_decrypt(struct iee
 	    !ieee80211_is_robust_mgmt_frame(skb))
 		return RX_CONTINUE;
 
-	data_len = skb->len - hdrlen - IEEE80211_GCMP_HDR_LEN -
-		   IEEE80211_GCMP_MIC_LEN;
-	if (!rx->sta || data_len < 0)
-		return RX_DROP_UNUSABLE;
-
 	if (status->flag & RX_FLAG_DECRYPTED) {
 		if (!pskb_may_pull(rx->skb, hdrlen + IEEE80211_GCMP_HDR_LEN))
 			return RX_DROP_UNUSABLE;
+		if (status->flag & RX_FLAG_MIC_STRIPPED)
+			mic_len = 0;
 	} else {
 		if (skb_linearize(rx->skb))
 			return RX_DROP_UNUSABLE;
 	}
 
+	data_len = skb->len - hdrlen - IEEE80211_GCMP_HDR_LEN - mic_len;
+	if (!rx->sta || data_len < 0)
+		return RX_DROP_UNUSABLE;
+
 	if (!(status->flag & RX_FLAG_PN_VALIDATED)) {
 		gcmp_hdr2pn(pn, skb->data + hdrlen);
 
@@ -776,7 +778,7 @@ ieee80211_crypto_gcmp_decrypt(struct iee
 	}
 
 	/* Remove GCMP header and MIC */
-	if (pskb_trim(skb, skb->len - IEEE80211_GCMP_MIC_LEN))
+	if (pskb_trim(skb, skb->len - mic_len))
 		return RX_DROP_UNUSABLE;
 	memmove(skb->data + IEEE80211_GCMP_HDR_LEN, skb->data, hdrlen);
 	skb_pull(skb, IEEE80211_GCMP_HDR_LEN);
