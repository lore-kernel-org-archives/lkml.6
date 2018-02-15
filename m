Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227wuSdkMShpwlx2hxKH8jtvfr6qoa4qVMfhYg+6HRTA4x6YhzULP4Y4oBLx+OwZ4bfFKAGg
ARC-Seal: i=1; a=rsa-sha256; t=1518708622; cv=none;
        d=google.com; s=arc-20160816;
        b=BXgDcHmO0cF+YFbLIWbp/j7mqeDBAqqxEH+Xr/GCDAZnz8GOg6RQjaHdhbtYQBUSHs
         pCQItOEuev3QchSHhZv+/I+I1lQY/L+deMBeXwVAw9h0EmnLwd0RGo6fxTmVwgJHnpRs
         qJq+/XL3I1YQrMcBBCO2g8VouPNEJfKdS+QYmOmGDPmpDamuWuyHcRVwmAj3LiTeJI1j
         S5SIm65yVtXuxhdLAQrI4DHmXScAxSibKPvcWlTBgWi+3NXUMXbQE2ftNk9MeStXeBRt
         WbbUxAru5fFXAS7DvdbNbiQcwayhZ0+E5OaZdGz6OixZJwbXlR02P0eiLbFb22oAv8NJ
         dGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0S2jHkZXo0nUOp9OKCsFJBvHMBFd3pDUCorudBk9FuE=;
        b=wte3Nx8hkOQvRWjJ3bmDsk4zn3Uo3qnjNWdyUoQ1i8Qiu1E7zvzP713xyls7ds2Dsx
         P5VXEIRdHNWY7JZ0lgE9v+D0ODTRuTlb7EvuNKqcDLbvdmImt5+GTIozixG0ZLnTpQvW
         LVRlIz7oWX/wVe8ES1mEbwn+pHYUjtqfbgTToJexkqxaJQaFJgxwqARUq0VqbUP6uSTb
         d7g+ydaACv9RSDs8S8lZSV/tVa5JhDGz2A+5nAzmfVgWZHjUj7XpvMAF7LqYzA0cV+rB
         TQz2djPIbnu+TxBFnyaqu2P0HzVaiP2Tn5/BBoCi/M9YlJyoLzmvMhz3BQ0dZIiQweM/
         pq8g==
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
Subject: [PATCH 4.14 020/195] media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner
Date: Thu, 15 Feb 2018 16:15:11 +0100
Message-Id: <20180215151706.757770004@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480721810490491?=
X-GMAIL-MSGID: =?utf-8?q?1592481412862873748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1076,8 +1076,6 @@ static int dm04_lme2510_frontend_attach(
 
 		if (adap->fe[0]) {
 			info("FE Found M88RS2000");
-			dvb_attach(ts2020_attach, adap->fe[0], &ts2020_config,
-					&d->i2c_adap);
 			st->i2c_tuner_gate_w = 5;
 			st->i2c_tuner_gate_r = 5;
 			st->i2c_tuner_addr = 0x60;
@@ -1143,17 +1141,18 @@ static int dm04_lme2510_tuner(struct dvb
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
 
