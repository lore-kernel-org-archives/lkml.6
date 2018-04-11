Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Ap/glycg9PkS8EmJRQfKxkMFUPTNKPbmOSyzzoIb8pMvEo4AhTM/+LMbKiyWwXMSJqlwj
ARC-Seal: i=1; a=rsa-sha256; t=1523472657; cv=none;
        d=google.com; s=arc-20160816;
        b=bjdZwtf45J/I9R0i0lXP02AwHe5YtjY1Lkxpt6oL3H3o5kjtLCpMfFXSyUEJysPpr2
         ckzc4RnnYacIofRsKmDsH5lPoKGi2HpiHYj6OwH6rCW5EDXXB2wpoBuvz39UitHBuSD9
         iy9BroV5/5K2Nx8pFtHBLn+aa6g+5NpNr7ttGYvH8hu49fRD1xEbJbgAlOJwtVn1cMwj
         G6yLvcWr4rHQ4OPki2dpvKHtbrEd0E8FgfkpcMkogbyEqr/NjG22Bu+ZX8Qp4k2dUgVp
         1zsJK0raygbrLjxjW3HjNUdFVMUD9k/LY9eks9mJk1ZbecVBt6v7gudFRafEUf+yQWzr
         v2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bs//SNAqSVQ6a5evR88agHOYxo6PllT6UBpCSroI+t4=;
        b=L9Q9+Dhu4c3dxyGhomGEpslbST87ccz44ykCkc5MqSlLyRYFNODTyg81hnweyqPl/Z
         /3lM6XRDYjX8Fx8k51Rp9kKASQnjLUQqG6Ra27JQQ9sTwXd0SdKvc/bXYfhDzoMuRyO2
         AzNtW/Nj/cNpHalMvcBHbTdChK+cUdbZdAd51FjtjMpZ57v1Aj1FblP4aFjgJWExj2xY
         ZSkVqob3bJgaHTxkMOoi16DNIaqQyHWd/GKW5uaONYs0pn8Uy69QgvqNP3b0/yMGhUg7
         3TS5CV7vjwg8RwyTq8W+0t8vOoiZGgtM9lDIFl3nhWDrfQkoEkQDaXvUBVBv8WT8Q2LB
         14iA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 137/190] skbuff: only inherit relevant tx_flags
Date: Wed, 11 Apr 2018 20:36:23 +0200
Message-Id: <20180411183600.603547227@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476864960528556?=
X-GMAIL-MSGID: =?utf-8?q?1597476864960528556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>


[ Upstream commit fff88030b3ff930ca7a3d74acfee0472f33887ea ]

When inheriting tx_flags from one skbuff to another, always apply a
mask to avoid overwriting unrelated other bits in the field.

The two SKBTX_SHARED_FRAG cases clears all other bits. In practice,
tx_flags are zero at this point now. But this is fragile. Timestamp
flags are set, for instance, if in tcp_gso_segment, after this clear
in skb_segment.

The SKBTX_ANY_TSTAMP mask in __skb_tstamp_tx ensures that new
skbs do not accidentally inherit flags such as SKBTX_SHARED_FRAG.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2551,7 +2551,8 @@ void skb_split(struct sk_buff *skb, stru
 {
 	int pos = skb_headlen(skb);
 
-	skb_shinfo(skb1)->tx_flags = skb_shinfo(skb)->tx_flags & SKBTX_SHARED_FRAG;
+	skb_shinfo(skb1)->tx_flags |= skb_shinfo(skb)->tx_flags &
+				      SKBTX_SHARED_FRAG;
 	if (len < pos)	/* Split line is inside header. */
 		skb_split_inside_header(skb, skb1, len, pos);
 	else		/* Second chunk has no header, nothing to copy. */
@@ -3115,8 +3116,8 @@ struct sk_buff *skb_segment(struct sk_bu
 		skb_copy_from_linear_data_offset(head_skb, offset,
 						 skb_put(nskb, hsize), hsize);
 
-		skb_shinfo(nskb)->tx_flags = skb_shinfo(head_skb)->tx_flags &
-			SKBTX_SHARED_FRAG;
+		skb_shinfo(nskb)->tx_flags |= skb_shinfo(head_skb)->tx_flags &
+					      SKBTX_SHARED_FRAG;
 
 		while (pos < offset + len) {
 			if (i >= nfrags) {
@@ -3734,7 +3735,8 @@ void __skb_tstamp_tx(struct sk_buff *ori
 		return;
 
 	if (tsonly) {
-		skb_shinfo(skb)->tx_flags = skb_shinfo(orig_skb)->tx_flags;
+		skb_shinfo(skb)->tx_flags |= skb_shinfo(orig_skb)->tx_flags &
+					     SKBTX_ANY_TSTAMP;
 		skb_shinfo(skb)->tskey = skb_shinfo(orig_skb)->tskey;
 	}
 
