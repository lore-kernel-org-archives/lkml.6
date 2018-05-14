Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqAXODJont9JYJVtyNVeYHpey4h1JA0IcV9BR7BXdPUy5u0dlIuEQ6zzsveskhdqUKsUOTn
ARC-Seal: i=1; a=rsa-sha256; t=1526280719; cv=none;
        d=google.com; s=arc-20160816;
        b=dzR9U/9gik8PUTAqIJUg4QZYBg2sYAN2f6xScCXHTASpG75L7anXj1HPq6aUo1v9J+
         tPhy/uuoyHc6rnzvrXMunbMfOfGxW7HWhXO96mEME1R1PoLmajABsqdT0849Xe98zRMz
         uVxo89zC6rLpDavKXyAghAKH3gKq1rcH3lWuxSXtyuk+6kiMLhD1pka4EUEeFHyNYPwo
         yDcf3I3c43YDKUgnrzhgGKWJXo1N6+6MI9OWUj4DbYIhrrzjzbmljCaS/WW1Tqf3ywal
         CAFHrwxG9f3dRLWV9FTzJ7KipKIlbWTTvVS3TImimwBYhBEkOCSMfWaTb34qNCmrmxql
         IVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=66O0hKi6KsMCPI8oR0beKRWWALfX5ZAnduUdN9X2l90=;
        b=LwcTssfWhWmb79i7qpR3yqeNFWoD5/5KWVQZI1jG0nb28kitosLENtzXWtkNGK1PEg
         yHH5q5OnlPOBDgadhEPc1z4nJ40BqQDCM3yiuAHEq74+KX9XSeaCjutyvi6hHwmfutm2
         +TRhXJ6+s2KfhaEZNgZN4HOtBxMoGP7fE1a3rFGwQlQhFK8jThOvdG4+V/havYmJESqQ
         3+zXdruDR55GV+8cFxaxMyt4d2CW4ImxZsJb5NMXCdCxFZNg20XYj14DM6bLRC+4WDxA
         vOIqYBqJzIKPaKHy4Q4IHtXzKX8ZyZhTTzqfuzFJmrnbmlhJ7KSGTm+ESdMQxIZc3xIr
         UCHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vgVA7iyc;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=vgVA7iyc;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sara Sharon <sara.sharon@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sriram R <srirrama@codeaurora.org>
Subject: [PATCH 4.4 06/56] mac80211: allow same PN for AMSDU sub-frames
Date: Mon, 14 May 2018 08:48:11 +0200
Message-Id: <20180514064755.556782755@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421332373394733?=
X-GMAIL-MSGID: =?utf-8?q?1600421332373394733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sara Sharon <sara.sharon@intel.com>

commit f631a77ba920f7153a1094d09cd8f2ebbffd0328 upstream.

Some hardware (iwlwifi an example) de-aggregate AMSDUs and copy the IV
as is to the generated MPDUs, so the same PN appears in multiple
packets without being a replay attack.  Allow driver to explicitly
indicate that a frame is allowed to have the same PN as the previous
frame.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Cc: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/mac80211.h |    6 +++++-
 net/mac80211/wpa.c     |   16 ++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1031,6 +1031,9 @@ ieee80211_tx_info_clear_status(struct ie
  * @RX_FLAG_RADIOTAP_VENDOR_DATA: This frame contains vendor-specific
  *	radiotap data in the skb->data (before the frame) as described by
  *	the &struct ieee80211_vendor_radiotap.
+ * @RX_FLAG_ALLOW_SAME_PN: Allow the same PN as same packet before.
+ *	This is used for AMSDU subframes which can have the same PN as
+ *	the first subframe.
  */
 enum mac80211_rx_flags {
 	RX_FLAG_MMIC_ERROR		= BIT(0),
@@ -1061,7 +1064,8 @@ enum mac80211_rx_flags {
 	RX_FLAG_5MHZ			= BIT(29),
 	RX_FLAG_AMSDU_MORE		= BIT(30),
 	RX_FLAG_RADIOTAP_VENDOR_DATA	= BIT(31),
-	RX_FLAG_MIC_STRIPPED            = BIT_ULL(32),
+	RX_FLAG_MIC_STRIPPED		= BIT_ULL(32),
+	RX_FLAG_ALLOW_SAME_PN		= BIT_ULL(33),
 };
 
 #define RX_FLAG_STBC_SHIFT		26
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -523,12 +523,16 @@ ieee80211_crypto_ccmp_decrypt(struct iee
 		return RX_DROP_UNUSABLE;
 
 	if (!(status->flag & RX_FLAG_PN_VALIDATED)) {
+		int res;
+
 		ccmp_hdr2pn(pn, skb->data + hdrlen);
 
 		queue = rx->security_idx;
 
-		if (memcmp(pn, key->u.ccmp.rx_pn[queue],
-			   IEEE80211_CCMP_PN_LEN) <= 0) {
+		res = memcmp(pn, key->u.ccmp.rx_pn[queue],
+			     IEEE80211_CCMP_PN_LEN);
+		if (res < 0 ||
+		    (!res && !(status->flag & RX_FLAG_ALLOW_SAME_PN))) {
 			key->u.ccmp.replays++;
 			return RX_DROP_UNUSABLE;
 		}
@@ -749,12 +753,16 @@ ieee80211_crypto_gcmp_decrypt(struct iee
 		return RX_DROP_UNUSABLE;
 
 	if (!(status->flag & RX_FLAG_PN_VALIDATED)) {
+		int res;
+
 		gcmp_hdr2pn(pn, skb->data + hdrlen);
 
 		queue = rx->security_idx;
 
-		if (memcmp(pn, key->u.gcmp.rx_pn[queue],
-			   IEEE80211_GCMP_PN_LEN) <= 0) {
+		res = memcmp(pn, key->u.gcmp.rx_pn[queue],
+			     IEEE80211_GCMP_PN_LEN);
+		if (res < 0 ||
+		    (!res && !(status->flag & RX_FLAG_ALLOW_SAME_PN))) {
 			key->u.gcmp.replays++;
 			return RX_DROP_UNUSABLE;
 		}
