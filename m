Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrh87i7ldsYRRZgDoSJA7OJilb+DNKYRfsWiFLN46cJz+m1uznQQDSbuVBx1tLz3olNvKHV
ARC-Seal: i=1; a=rsa-sha256; t=1526280728; cv=none;
        d=google.com; s=arc-20160816;
        b=YeMCOuPFsB/kWnzGYsk1+t0R7x2bswiCXu3XJPKoy04E5zFumIfPLm0EQpw5oMYgvn
         ue20YYCHprGJYFVFS15wCSk9keuuCXlHwJ4Wt/oVRUdsVwDXKE5DKfplU87B7mToZoJW
         ziTGv5v12Yfktf1ZZi1bWq1XK89VUaL8Xl0HbvLzcGY1KKoT6UTmcE1J97b4qCyxiuSk
         x8xQAdU7ruwjPU6UbR2nSv0K5sWnQYAlQWoHZ0gb7vnRDQAT+TxStOMr/O4j78qgXMNE
         MwL2rE1DFLIQnk5ShJLAVVTO1harowGBpJRiJIY+W80p4zoZUuJQMmXiQ7liW8+7tdE4
         mGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=j93v8iqXLENHxZIv/z+tgCXmg6+t6j112IsTTejPm0k=;
        b=0d4k+g/OeZSvyaoZP+DCxUeV1BXhwmFQbjr3vRvVgjiVQ8iCpBMqMoaxCX6I8uEAWc
         GlBJY8QJ0ub1NdZm6vjw+mt+vMnBhq4aececG5vzOUtsEjktwDdbKRQJy7WRazRKZ79M
         qYpb18fsjj+juH2Zh0OYcj6mOOINwObbN0IVUZ61KBPsZPm5lpQMA6EpFXu1Sx52mUNH
         eJsPUub0YfLLPKztw0kWnzbUTIhPSFpkHu8Gd8yM/2fNvVOrxZrNbB7jBUMcUzPFfRD+
         JndpMraCojKhIHp5SzekFU4+VbqyCZirqC+HgzUniyZHXagzxkruQJzAsRdxm7nqhOVt
         kucQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hiaUZOs0;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=hiaUZOs0;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>,
	Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
	Kalle Valo <kvalo@qca.qualcomm.com>,
	Sriram R <srirrama@codeaurora.org>
Subject: [PATCH 4.4 09/56] ath10k: rebuild crypto header in rx data frames
Date: Mon, 14 May 2018 08:48:14 +0200
Message-Id: <20180514064755.924711730@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421341166129465?=
X-GMAIL-MSGID: =?utf-8?q?1600421341166129465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>

commit 7eccb738fce57cbe53ed903ccf43f9ab257b15b3 upstream.

Rx data frames notified through HTT_T2H_MSG_TYPE_RX_IND and
HTT_T2H_MSG_TYPE_RX_FRAG_IND expect PN/TSC check to be done
on host (mac80211) rather than firmware. Rebuild cipher header
in every received data frames (that are notified through those
HTT interfaces) from the rx_hdr_status tlv available in the
rx descriptor of the first msdu. Skip setting RX_FLAG_IV_STRIPPED
flag for the packets which requires mac80211 PN/TSC check support
and set appropriate RX_FLAG for stripped crypto tail. Hw QCA988X,
QCA9887, QCA99X0, QCA9984, QCA9888 and QCA4019 currently need the
rebuilding of cipher header to perform PN/TSC check for replay
attack.

Please note that removing crypto tail for CCMP-256, GCMP and GCMP-256 ciphers
in raw mode needs to be fixed. Since Rx with these ciphers in raw
mode does not work in the current form even without this patch and
removing crypto tail for these chipers needs clean up, raw mode related
issues in CCMP-256, GCMP and GCMP-256 can be addressed in follow up
patches.

Tested-by: Manikanta Pubbisetty <mpubbise@qti.qualcomm.com>
Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c |   98 +++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 16 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1076,7 +1076,21 @@ static void ath10k_htt_rx_h_undecap_raw(
 	hdr = (void *)msdu->data;
 
 	/* Tail */
-	skb_trim(msdu, msdu->len - ath10k_htt_rx_crypto_tail_len(ar, enctype));
+	if (status->flag & RX_FLAG_IV_STRIPPED) {
+		skb_trim(msdu, msdu->len -
+			 ath10k_htt_rx_crypto_tail_len(ar, enctype));
+	} else {
+		/* MIC */
+		if ((status->flag & RX_FLAG_MIC_STRIPPED) &&
+		    enctype == HTT_RX_MPDU_ENCRYPT_AES_CCM_WPA2)
+			skb_trim(msdu, msdu->len - 8);
+
+		/* ICV */
+		if (status->flag & RX_FLAG_ICV_STRIPPED &&
+		    enctype != HTT_RX_MPDU_ENCRYPT_AES_CCM_WPA2)
+			skb_trim(msdu, msdu->len -
+				 ath10k_htt_rx_crypto_tail_len(ar, enctype));
+	}
 
 	/* MMIC */
 	if (!ieee80211_has_morefrags(hdr->frame_control) &&
@@ -1095,12 +1109,14 @@ static void ath10k_htt_rx_h_undecap_raw(
 static void ath10k_htt_rx_h_undecap_nwifi(struct ath10k *ar,
 					  struct sk_buff *msdu,
 					  struct ieee80211_rx_status *status,
-					  const u8 first_hdr[64])
+					  const u8 first_hdr[64],
+					  enum htt_rx_mpdu_encrypt_type enctype)
 {
 	struct ieee80211_hdr *hdr;
 	size_t hdr_len;
 	u8 da[ETH_ALEN];
 	u8 sa[ETH_ALEN];
+	int bytes_aligned = ar->hw_params.decap_align_bytes;
 
 	/* Delivered decapped frame:
 	 * [nwifi 802.11 header] <-- replaced with 802.11 hdr
@@ -1123,6 +1139,14 @@ static void ath10k_htt_rx_h_undecap_nwif
 	/* push original 802.11 header */
 	hdr = (struct ieee80211_hdr *)first_hdr;
 	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+
+	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
+		memcpy(skb_push(msdu,
+				ath10k_htt_rx_crypto_param_len(ar, enctype)),
+		       (void *)hdr + round_up(hdr_len, bytes_aligned),
+			ath10k_htt_rx_crypto_param_len(ar, enctype));
+	}
+
 	memcpy(skb_push(msdu, hdr_len), hdr, hdr_len);
 
 	/* original 802.11 header has a different DA and in
@@ -1180,6 +1204,7 @@ static void ath10k_htt_rx_h_undecap_eth(
 	void *rfc1042;
 	u8 da[ETH_ALEN];
 	u8 sa[ETH_ALEN];
+	int bytes_aligned = ar->hw_params.decap_align_bytes;
 
 	/* Delivered decapped frame:
 	 * [eth header] <-- replaced with 802.11 hdr & rfc1042/llc
@@ -1203,6 +1228,14 @@ static void ath10k_htt_rx_h_undecap_eth(
 	/* push original 802.11 header */
 	hdr = (struct ieee80211_hdr *)first_hdr;
 	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+
+	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
+		memcpy(skb_push(msdu,
+				ath10k_htt_rx_crypto_param_len(ar, enctype)),
+		       (void *)hdr + round_up(hdr_len, bytes_aligned),
+			ath10k_htt_rx_crypto_param_len(ar, enctype));
+	}
+
 	memcpy(skb_push(msdu, hdr_len), hdr, hdr_len);
 
 	/* original 802.11 header has a different DA and in
@@ -1216,10 +1249,12 @@ static void ath10k_htt_rx_h_undecap_eth(
 static void ath10k_htt_rx_h_undecap_snap(struct ath10k *ar,
 					 struct sk_buff *msdu,
 					 struct ieee80211_rx_status *status,
-					 const u8 first_hdr[64])
+					 const u8 first_hdr[64],
+					 enum htt_rx_mpdu_encrypt_type enctype)
 {
 	struct ieee80211_hdr *hdr;
 	size_t hdr_len;
+	int bytes_aligned = ar->hw_params.decap_align_bytes;
 
 	/* Delivered decapped frame:
 	 * [amsdu header] <-- replaced with 802.11 hdr
@@ -1231,6 +1266,14 @@ static void ath10k_htt_rx_h_undecap_snap
 
 	hdr = (struct ieee80211_hdr *)first_hdr;
 	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+
+	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
+		memcpy(skb_push(msdu,
+				ath10k_htt_rx_crypto_param_len(ar, enctype)),
+		       (void *)hdr + round_up(hdr_len, bytes_aligned),
+			ath10k_htt_rx_crypto_param_len(ar, enctype));
+	}
+
 	memcpy(skb_push(msdu, hdr_len), hdr, hdr_len);
 }
 
@@ -1265,13 +1308,15 @@ static void ath10k_htt_rx_h_undecap(stru
 					    is_decrypted);
 		break;
 	case RX_MSDU_DECAP_NATIVE_WIFI:
-		ath10k_htt_rx_h_undecap_nwifi(ar, msdu, status, first_hdr);
+		ath10k_htt_rx_h_undecap_nwifi(ar, msdu, status, first_hdr,
+					      enctype);
 		break;
 	case RX_MSDU_DECAP_ETHERNET2_DIX:
 		ath10k_htt_rx_h_undecap_eth(ar, msdu, status, first_hdr, enctype);
 		break;
 	case RX_MSDU_DECAP_8023_SNAP_LLC:
-		ath10k_htt_rx_h_undecap_snap(ar, msdu, status, first_hdr);
+		ath10k_htt_rx_h_undecap_snap(ar, msdu, status, first_hdr,
+					     enctype);
 		break;
 	}
 }
@@ -1314,7 +1359,8 @@ static void ath10k_htt_rx_h_csum_offload
 
 static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
 				 struct sk_buff_head *amsdu,
-				 struct ieee80211_rx_status *status)
+				 struct ieee80211_rx_status *status,
+				 bool fill_crypt_header)
 {
 	struct sk_buff *first;
 	struct sk_buff *last;
@@ -1324,7 +1370,6 @@ static void ath10k_htt_rx_h_mpdu(struct
 	enum htt_rx_mpdu_encrypt_type enctype;
 	u8 first_hdr[64];
 	u8 *qos;
-	size_t hdr_len;
 	bool has_fcs_err;
 	bool has_crypto_err;
 	bool has_tkip_err;
@@ -1345,15 +1390,17 @@ static void ath10k_htt_rx_h_mpdu(struct
 	 * decapped header. It'll be used for undecapping of each MSDU.
 	 */
 	hdr = (void *)rxd->rx_hdr_status;
-	hdr_len = ieee80211_hdrlen(hdr->frame_control);
-	memcpy(first_hdr, hdr, hdr_len);
+	memcpy(first_hdr, hdr, RX_HTT_HDR_STATUS_LEN);
 
 	/* Each A-MSDU subframe will use the original header as the base and be
 	 * reported as a separate MSDU so strip the A-MSDU bit from QoS Ctl.
 	 */
 	hdr = (void *)first_hdr;
-	qos = ieee80211_get_qos_ctl(hdr);
-	qos[0] &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+
+	if (ieee80211_is_data_qos(hdr->frame_control)) {
+		qos = ieee80211_get_qos_ctl(hdr);
+		qos[0] &= ~IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+	}
 
 	/* Some attention flags are valid only in the last MSDU. */
 	last = skb_peek_tail(amsdu);
@@ -1387,11 +1434,17 @@ static void ath10k_htt_rx_h_mpdu(struct
 	if (has_tkip_err)
 		status->flag |= RX_FLAG_MMIC_ERROR;
 
-	if (is_decrypted)
+	if (is_decrypted) {
 		status->flag |= RX_FLAG_DECRYPTED |
-				RX_FLAG_IV_STRIPPED |
 				RX_FLAG_MMIC_STRIPPED;
 
+		if (fill_crypt_header)
+			status->flag |= RX_FLAG_MIC_STRIPPED |
+					RX_FLAG_ICV_STRIPPED;
+		else
+			status->flag |= RX_FLAG_IV_STRIPPED;
+	}
+
 	skb_queue_walk(amsdu, msdu) {
 		ath10k_htt_rx_h_csum_offload(msdu);
 		ath10k_htt_rx_h_undecap(ar, msdu, status, first_hdr, enctype,
@@ -1404,6 +1457,9 @@ static void ath10k_htt_rx_h_mpdu(struct
 		if (!is_decrypted)
 			continue;
 
+		if (fill_crypt_header)
+			continue;
+
 		hdr = (void *)msdu->data;
 		hdr->frame_control &= ~__cpu_to_le16(IEEE80211_FCTL_PROTECTED);
 	}
@@ -1414,6 +1470,9 @@ static void ath10k_htt_rx_h_deliver(stru
 				    struct ieee80211_rx_status *status)
 {
 	struct sk_buff *msdu;
+	struct sk_buff *first_subframe;
+
+	first_subframe = skb_peek(amsdu);
 
 	while ((msdu = __skb_dequeue(amsdu))) {
 		/* Setup per-MSDU flags */
@@ -1422,6 +1481,13 @@ static void ath10k_htt_rx_h_deliver(stru
 		else
 			status->flag |= RX_FLAG_AMSDU_MORE;
 
+		if (msdu == first_subframe) {
+			first_subframe = NULL;
+			status->flag &= ~RX_FLAG_ALLOW_SAME_PN;
+		} else {
+			status->flag |= RX_FLAG_ALLOW_SAME_PN;
+		}
+
 		ath10k_process_rx(ar, status, msdu);
 	}
 }
@@ -1607,7 +1673,7 @@ static void ath10k_htt_rx_handler(struct
 		ath10k_htt_rx_h_ppdu(ar, &amsdu, rx_status, 0xffff);
 		ath10k_htt_rx_h_unchain(ar, &amsdu, ret > 0);
 		ath10k_htt_rx_h_filter(ar, &amsdu, rx_status);
-		ath10k_htt_rx_h_mpdu(ar, &amsdu, rx_status);
+		ath10k_htt_rx_h_mpdu(ar, &amsdu, rx_status, true);
 		ath10k_htt_rx_h_deliver(ar, &amsdu, rx_status);
 	}
 
@@ -1653,7 +1719,7 @@ static void ath10k_htt_rx_frag_handler(s
 
 	ath10k_htt_rx_h_ppdu(ar, &amsdu, rx_status, 0xffff);
 	ath10k_htt_rx_h_filter(ar, &amsdu, rx_status);
-	ath10k_htt_rx_h_mpdu(ar, &amsdu, rx_status);
+	ath10k_htt_rx_h_mpdu(ar, &amsdu, rx_status, true);
 	ath10k_htt_rx_h_deliver(ar, &amsdu, rx_status);
 
 	if (fw_desc_len > 0) {
@@ -1952,7 +2018,7 @@ static void ath10k_htt_rx_in_ord_ind(str
 			 */
 			ath10k_htt_rx_h_ppdu(ar, &amsdu, status, vdev_id);
 			ath10k_htt_rx_h_filter(ar, &amsdu, status);
-			ath10k_htt_rx_h_mpdu(ar, &amsdu, status);
+			ath10k_htt_rx_h_mpdu(ar, &amsdu, status, false);
 			ath10k_htt_rx_h_deliver(ar, &amsdu, status);
 			break;
 		case -EAGAIN:
