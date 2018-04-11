Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Lxv5kgXCgDRCNphSmkoVJSJ7XABlYO3ET+8gVtguZq2GyLOLi/v93/NcRa2XglvGieR+B
ARC-Seal: i=1; a=rsa-sha256; t=1523472970; cv=none;
        d=google.com; s=arc-20160816;
        b=geu/gRp8PBAkf9CLqXAUc3q9+yDk3fLEXhIJ8THQUd58Z9dFaDGDzlrvtooJ5IBA90
         3IktOBUer7RHM5lQveMh6odkIXUI9+hYvWyVd1tCUv1AoXyVd/2V91v8+3E2NOyMyXOb
         CuQk6iQDyr6qI2So4QfQa0//svvi24l3CbVBt47ywtwA4a3W0oSHsSoeT1WzuEO7TWYa
         OjMekslAVQ7LA1ccLKa9hVol8J+VWrTVxC+ePWRHKUPfzbg9YOZOK2DcaW+kcOEzjp8T
         gGQ+W0NO/+LEZ/ZxKT1X3mLekM7w0mIzz8iaY3nw3GtXV2N82EsdV0VuUgFTr3oJIlwO
         RZ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HaMUst45gU0zOxaBWBDhIsMg2B7s5MLL4krP/ttyKh0=;
        b=Evb/aaNi2GE1N7h+1uCSG2qj0MRtR2BoMMI7A8BWP6irrqJzQjR9SXK9HhWl8xdN4L
         59STBG10TrGxrig5L9+OFQGEqkzvwx3FRD15nwSh8dqRrFcb8uqILwNiucPhtUPawZea
         OTE25F4HZ6jiL6ZSVdDlsdVCfM5tw1LVbrspzsxqgUklUgime+vjGW90b6SPDoc8qZBu
         Y1UtyLU7ve7a2Q+cqT4rQRiZUxvOrQuQ8r0iodiXJDTSe14ywS/h1nBsG7+oMocnFnAB
         GjK7y4wtuJQ/DJPXsJIEKukfTCCmRnEAfxQMGmI3XZcxnJIyL9sqh7m51Oa9aMCbIYtj
         KQvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 083/310] iio: hi8435: avoid garbage event at first enable
Date: Wed, 11 Apr 2018 20:33:42 +0200
Message-Id: <20180411183625.855924714@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476546516156819?=
X-GMAIL-MSGID: =?utf-8?q?1597477193785390070?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>


[ Upstream commit ee19ac340c5fdfd89c6348be4563453c61ab54a9 ]

Currently, driver generates events for channels if new reading differs
from previous one. This "previous value" is initialized to zero, which
results into event if value is constant-one.

Fix that by initializing "previous value" by reading at event enable
time.

This provides reliable sequence for userspace:
- enable event,
- AFTER THAT read current value,
- AFTER THAT each event will correspond to change.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/hi8435.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -121,10 +121,21 @@ static int hi8435_write_event_config(str
 				     enum iio_event_direction dir, int state)
 {
 	struct hi8435_priv *priv = iio_priv(idev);
+	int ret;
+	u32 tmp;
+
+	if (state) {
+		ret = hi8435_readl(priv, HI8435_SO31_0_REG, &tmp);
+		if (ret < 0)
+			return ret;
+		if (tmp & BIT(chan->channel))
+			priv->event_prev_val |= BIT(chan->channel);
+		else
+			priv->event_prev_val &= ~BIT(chan->channel);
 
-	priv->event_scan_mask &= ~BIT(chan->channel);
-	if (state)
 		priv->event_scan_mask |= BIT(chan->channel);
+	} else
+		priv->event_scan_mask &= ~BIT(chan->channel);
 
 	return 0;
 }
