Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuNDk8fC1k7LxuN16pgnMHmHCHDc2t5jSlsfuwieOLGugqBc8XEoiDxb2Rz2L3w7SNTP1Ko
ARC-Seal: i=1; a=rsa-sha256; t=1521483952; cv=none;
        d=google.com; s=arc-20160816;
        b=r4/Q0G4trNlQYA0+MPrwDmHZbc1zNjPwg2xHoCuPE6cMxovPdbMXYm5IJTdW6/DQ2n
         CoGnGHqqFBlJEmTxEumuVqwohvtqF1Fik/nMIAYla8zPnwlpeWFQCLEtPNA3jTy1hDbG
         0SZNqIMALfSXBSi8x/4j5wpFQNQDO7z+JjHyWWEn92tV/39Fq+QQPNrS6FAplWT4p/UB
         yiLLX1gtJ1STPJ/n7dXQqFFHoFBQ1S0IBL9p7qhBI8N7lzV4e95Eski8TCVJqHE77gmG
         +nhV+5fSIkWsuEEOYt+xmBBMYvtF7o8z2tYRQxMpeBvqlV2dqLauTGi85AUng/kSDsd5
         LilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rSVMKckzNWTVrYguVZr5zfKLRFJ5uzO52vlVICC0h8s=;
        b=mVafI2a5fK1sSksTbsYSDjqjYPplAozxM/viFdyZS0Mgh9+rwGl1qaluepqH42etH3
         T5IWppDvGbXY9zv1xwLClyp2FqM72t4hrtf/WeLIkefcR6k2ahS5xImLg1ZViVZdkLd+
         VwfjP9jEhaWbZwgnP/eHdannXVcgdIMhev/TNTKJS43cdkaSGheBECUEPNCvulEFPhhS
         MxrHiAuY56ukGgtsjw/HUIvljE8O75WfBJ91HQW1ZxgrgTQfvzjbvJTwUaz0d1FSzVH7
         eul5azNIXBzold+7v8VYUxGikwAW4Jq2VpbTjARM6elNgf7BQqWMcY6/xfjknjkcr7R0
         ytrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 142/241] iwlwifi: mvm: fix RX SKB header size and align it properly
Date: Mon, 19 Mar 2018 19:06:47 +0100
Message-Id: <20180319180757.064467960@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391557581874063?=
X-GMAIL-MSGID: =?utf-8?q?1595391557581874063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>


[ Upstream commit 5cddd05c9cbe420436799716d009bc0372ef8268 ]

When receiving a frame, we currently pull in sizeof(*hdr) plus
some extra (crypto/snap), which is too much, most headers aren't
actually sizeof(*hdr) since that takes into account the 4-address
format but doesn't take into account QoS. As a result, a typical
frame will have 4 bytes of the payload in the SKB header already.

Fix this by calculating the correct header length, and now that
we have that, align the end of the SKB header to a multiple of 4
so that the IP header will be aligned properly when pulled in.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -104,7 +104,20 @@ static void iwl_mvm_pass_packet_to_mac80
 					    u8 crypt_len,
 					    struct iwl_rx_cmd_buffer *rxb)
 {
-	unsigned int hdrlen, fraglen;
+	unsigned int hdrlen = ieee80211_hdrlen(hdr->frame_control);
+	unsigned int fraglen;
+
+	/*
+	 * The 'hdrlen' (plus the 8 bytes for the SNAP and the crypt_len,
+	 * but those are all multiples of 4 long) all goes away, but we
+	 * want the *end* of it, which is going to be the start of the IP
+	 * header, to be aligned when it gets pulled in.
+	 * The beginning of the skb->data is aligned on at least a 4-byte
+	 * boundary after allocation. Everything here is aligned at least
+	 * on a 2-byte boundary so we can just take hdrlen & 3 and pad by
+	 * the result.
+	 */
+	skb_reserve(skb, hdrlen & 3);
 
 	/* If frame is small enough to fit in skb->head, pull it completely.
 	 * If not, only pull ieee80211_hdr (including crypto if present, and
@@ -118,8 +131,7 @@ static void iwl_mvm_pass_packet_to_mac80
 	 * If the latter changes (there are efforts in the standards group
 	 * to do so) we should revisit this and ieee80211_data_to_8023().
 	 */
-	hdrlen = (len <= skb_tailroom(skb)) ? len :
-					      sizeof(*hdr) + crypt_len + 8;
+	hdrlen = (len <= skb_tailroom(skb)) ? len : hdrlen + crypt_len + 8;
 
 	memcpy(skb_put(skb, hdrlen), hdr, hdrlen);
 	fraglen = len - hdrlen;
