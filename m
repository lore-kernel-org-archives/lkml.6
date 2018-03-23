Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuwt9lPTNXu1Li49dh/5N/rG4dAXeTWW4dufiMc1ia7nBp0TDIyJAytWR93XJgYew3Z9cJ4
ARC-Seal: i=1; a=rsa-sha256; t=1521800094; cv=none;
        d=google.com; s=arc-20160816;
        b=otpGx2MFJy9GWQLAHJysUOtZZ+NG/OmFgI0nXRh1QTX+VR4QZR6rjHvBYuMUI6QbG9
         Wi0udvQhH7RrRdCsrYwTHF3OYJpazNFzm4RATkopp0YlOmrT0vJaNm2+c9mn7kzudBT1
         iDQyQYYLH0ZUsYIFxmEOUmZJlIv+nWCpfBP7JJbgrXvRVwregV08VPJMiHGjqvJnTDrN
         j575i6RWNGGdE0XSRwezZ63a5XoimwX6efGd8nw77cDK++zS/Y9iIflyCetltnJkK1wG
         neux/ISe3q4e/UWVzbEwwwAlCtbi+F+E2P0LbVl0CpZKfqHhQYisgaz+j3DZWYUgYnn1
         HNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vFv+vRNin3orJNTgpMWyO2/7TbyDubiVxjRRxvnw9Ek=;
        b=s/jG/dKTJbHJiMBqb3/Tz/fmg5ShVnGFZmzk4B5PmxuMpctz8pCL5g5hah1RuZgzEO
         rT8smXP5IayUi2er3GW6kdYL23v+ONrLL7yu0A/NEPAt3opHmIAjFk4jYOdIEoCCqe2t
         iiS4li77wsuhoo1fpR1zjzDCGEocuJ7KwdHc/0DkS3AaboRfdFC3nKbTftXxj5onEwgI
         chhYN4q98R2UPS7MPcUsqrUOoOlywCtenZFmDxBVTeoEfSmUjufdsoafatxFu9iheYhT
         xbF/iVEkQ+kJ1heAKKGdEPpmehPlpQSIo18Fbpe9GYGUWN0/sDFgfHODkTIQ2YnLDGnL
         iNew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>,
	Jakub Kicinski <kubakici@wp.pl>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 47/97] mt7601u: check return value of alloc_skb
Date: Fri, 23 Mar 2018 10:54:34 +0100
Message-Id: <20180323094200.258964491@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722602127070056?=
X-GMAIL-MSGID: =?utf-8?q?1595723056478543457?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pan Bian <bianpan2016@163.com>


[ Upstream commit 5fb01e91daf84ad1e50edfcf63116ecbe31e7ba7 ]

Function alloc_skb() will return a NULL pointer if there is no enough
memory. However, in function mt7601u_mcu_msg_alloc(), its return value
is not validated before it is used. This patch fixes it.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Acked-by: Jakub Kicinski <kubakici@wp.pl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mediatek/mt7601u/mcu.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -66,8 +66,10 @@ mt7601u_mcu_msg_alloc(struct mt7601u_dev
 	WARN_ON(len % 4); /* if length is not divisible by 4 we need to pad */
 
 	skb = alloc_skb(len + MT_DMA_HDR_LEN + 4, GFP_KERNEL);
-	skb_reserve(skb, MT_DMA_HDR_LEN);
-	memcpy(skb_put(skb, len), data, len);
+	if (skb) {
+		skb_reserve(skb, MT_DMA_HDR_LEN);
+		memcpy(skb_put(skb, len), data, len);
+	}
 
 	return skb;
 }
@@ -170,6 +172,8 @@ static int mt7601u_mcu_function_select(s
 	};
 
 	skb = mt7601u_mcu_msg_alloc(dev, &msg, sizeof(msg));
+	if (!skb)
+		return -ENOMEM;
 	return mt7601u_mcu_msg_send(dev, skb, CMD_FUN_SET_OP, func == 5);
 }
 
@@ -205,6 +209,8 @@ mt7601u_mcu_calibrate(struct mt7601u_dev
 	};
 
 	skb = mt7601u_mcu_msg_alloc(dev, &msg, sizeof(msg));
+	if (!skb)
+		return -ENOMEM;
 	return mt7601u_mcu_msg_send(dev, skb, CMD_CALIBRATION_OP, true);
 }
 
