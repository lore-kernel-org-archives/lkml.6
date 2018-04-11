Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48k85946bs3UgHL1ttn2s6qPLyV7J3BGKBFTmJpZYBqaPY/PObjuTMtYDN/hCm99TdiyaQ4
ARC-Seal: i=1; a=rsa-sha256; t=1523472788; cv=none;
        d=google.com; s=arc-20160816;
        b=xMs97rjqmQkcrkRir9TI+NPEuFFtVcI1VAjYYN0J51IOZsFacvhYtEzXh90cgmKo7b
         X94ADsgf2uUArqBEexUDbP/GJ58LbzBMIBgPnAIec/ZWlbUu4EMreXNDw3t3FYl+2aUF
         FEWqZyBb5jR9POu/lDs3oqZE2veeaTvqsZ6tJoh1X9dPttQKhaCdHHXVSujx5WRAR1W1
         JgYNNhFpQ3VRFuQUz+vr+dbbTGZekIBnvaY6l91gW4h7cnIY1GaSIOgpr5KROp2MyIsp
         8ygV15x1ewT9GHQz4skx023l7QfIVs88NuRPS7cF94KloLgduQ3aE+81TCJvzsduvduH
         NmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fKcCyeexQm85FitqgGA6R+JAUyO9n/FSpKwH9mDfpjM=;
        b=u+C0s0R/EQeeL9f8zdqOgimazClJQQqChldlrFpyyZtU5E0Xo5c/EnpB0tAilxMNjN
         ihZKwYJRpswZPWjWsUfEH31G/DNP4+fAjjUnXL3Q0I17sqceMSoFzRGvO4kfIEXZUFba
         i8GtJDkVYDkR9jiVmxxUaGf21aQEBoAGqfZAreUbEVQWPa5FEnS0wg54atZPLWyuRhEX
         Bt1UMt9S/0DjUF+ulDqcvO67GJr5DosA8eM2pxmwrQYeMYSf+Nq5CT1xpLldsWLLd8VT
         co21DYK+OfrUWU9NJU0WylgBPuXWytRVlZppiNN57mvO0M9GQfr8OkSoOy/izFvaeTlx
         1yFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jim Baxter <jim_baxter@mentor.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 018/310] net: cdc_ncm: Fix TX zero padding
Date: Wed, 11 Apr 2018 20:32:37 +0200
Message-Id: <20180411183623.081034500@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476415462028016?=
X-GMAIL-MSGID: =?utf-8?q?1597477002619873722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Baxter <jim_baxter@mentor.com>


[ Upstream commit aeca3a77b1e0ed06a095933b89c86aed007383eb ]

The zero padding that is added to NTB's does
not zero the memory correctly.
This is because the skb_put modifies the value
of skb_out->len which results in the memset
command not setting any memory to zero as
(ctx->tx_max - skb_out->len) == 0.

I have resolved this by storing the size of
the memory to be zeroed before the skb_put
and using this in the memset call.

Signed-off-by: Jim Baxter <jim_baxter@mentor.com>
Reviewed-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ncm.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1118,6 +1118,7 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev
 	u16 n = 0, index, ndplen;
 	u8 ready2send = 0;
 	u32 delayed_ndp_size;
+	size_t padding_count;
 
 	/* When our NDP gets written in cdc_ncm_ndp(), then skb_out->len gets updated
 	 * accordingly. Otherwise, we should check here.
@@ -1274,11 +1275,13 @@ cdc_ncm_fill_tx_frame(struct usbnet *dev
 	 * a ZLP after full sized NTBs.
 	 */
 	if (!(dev->driver_info->flags & FLAG_SEND_ZLP) &&
-	    skb_out->len > ctx->min_tx_pkt)
-		memset(skb_put(skb_out, ctx->tx_max - skb_out->len), 0,
-		       ctx->tx_max - skb_out->len);
-	else if (skb_out->len < ctx->tx_max && (skb_out->len % dev->maxpacket) == 0)
+	    skb_out->len > ctx->min_tx_pkt) {
+		padding_count = ctx->tx_max - skb_out->len;
+		memset(skb_put(skb_out, padding_count), 0, padding_count);
+	} else if (skb_out->len < ctx->tx_max &&
+		   (skb_out->len % dev->maxpacket) == 0) {
 		*skb_put(skb_out, 1) = 0;	/* force short packet */
+	}
 
 	/* set final frame length */
 	nth16 = (struct usb_cdc_ncm_nth16 *)skb_out->data;
