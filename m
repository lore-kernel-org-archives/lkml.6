Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226a5VszPdMWxrV1nRL9HerammhfyhepYAmzJLd13Hd/l8btwl88Rik4Y75ps/rjChQKXgu9
ARC-Seal: i=1; a=rsa-sha256; t=1518707963; cv=none;
        d=google.com; s=arc-20160816;
        b=o1IKH4GjIPuSAddB/zfW3XTFrIcV21wo4vXD4sN/t4+BR0OE3ouEhjD5uUjvYVwrJJ
         SCPlxNDXQiKkPJFGg2FIp/e1uCM2bTw063u3/bqhWcHH+iEjpbMtCTKOwo6qasgu5EeH
         ISFeJRtNOcntcVtP/6Cv0mj33Q6FmlufFsahcobCiZX5lH/31j31UoY3hrTZjnbMqctY
         KpniYawj6t+Tb5DmAWS9AdEiGfZo9XGRY3wNFeConSbXxdRA1xiiiB+xZHLJY1GRm2Lp
         rS7w/Nv8bHfAaoL9jdxESHX5D265NheDbxQeXn0DduHAslx83HKjxTh8XC5lQZ3TTsuy
         7PNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZMN8+dstt6+VB1pWj1KAQdnKONofB6D8y/wvB8RyRU4=;
        b=k5wVr+uq9sNY4sfgX+8LAuhPz+VJXzSfxeVhVkdB75Jry9oztiuIaFNzI0xa3Vs++j
         TXXbWiuaBuD+LIPFbw1u2dBL8KuW1E4Fc9DpT7OvhWNNjkel0Y9tdc9Dm++KXYlOKUpr
         11DUgCBIkIpLv9Vxr6UAAz8KPiEiaiTb1vXswCcpqMf7D+YgDv/46NZb9VwDrpENd/pa
         Bkd01EhRPScw/NRonttPxhUhvlUJJUIRv1mBYOJ/GvN7GlPnHKoS5AquuG0NrFNdW93G
         DMOtm/RHkZT/q/F6ReMPTg2TXJw5XihY6+70uDW6TAu8I9cJa6Ov0Hi9ncungcs+YfIr
         8jkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>,
	Malcolm Priestley <tvboxspy@gmail.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 26/45] media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner
Date: Thu, 15 Feb 2018 16:17:17 +0100
Message-Id: <20180215144121.516153135@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480721810490491?=
X-GMAIL-MSGID: =?utf-8?q?1592480721810490491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 7bf7a7116ed313c601307f7e585419369926ab05 upstream.

When the tuner was split from m88rs2000 the attach function is in wrong
place.

Move to dm04_lme2510_tuner to trap errors on failure and removing
a call to lme_coldreset.

Prevents driver starting up without any tuner connected.

Fixes to trap for ts2020 fail.
LME2510(C): FE Found M88RS2000
ts2020: probe of 0-0060 failed with error -11
...
LME2510(C): TUN Found RS2000 tuner
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb-v2/lmedm04.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -1118,8 +1118,6 @@ static int dm04_lme2510_frontend_attach(
 
 		if (adap->fe[0]) {
 			info("FE Found M88RS2000");
-			dvb_attach(ts2020_attach, adap->fe[0], &ts2020_config,
-					&d->i2c_adap);
 			st->i2c_tuner_gate_w = 5;
 			st->i2c_tuner_gate_r = 5;
 			st->i2c_tuner_addr = 0x60;
@@ -1182,17 +1180,18 @@ static int dm04_lme2510_tuner(struct dvb
 			ret = st->tuner_config;
 		break;
 	case TUNER_RS2000:
-		ret = st->tuner_config;
+		if (dvb_attach(ts2020_attach, adap->fe[0],
+			       &ts2020_config, &d->i2c_adap))
+			ret = st->tuner_config;
 		break;
 	default:
 		break;
 	}
 
-	if (ret)
+	if (ret) {
 		info("TUN Found %s tuner", tun_msg[ret]);
-	else {
-		info("TUN No tuner found --- resetting device");
-		lme_coldreset(d);
+	} else {
+		info("TUN No tuner found");
 		return -ENODEV;
 	}
 
