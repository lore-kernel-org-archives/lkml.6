Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226JVoFtoBVWf9WRPtFuLh/zgWIr+WUboUUqvMQiIA9P2nS//NhDCMSHa9kfnM3JFxUE/1zw
ARC-Seal: i=1; a=rsa-sha256; t=1518709248; cv=none;
        d=google.com; s=arc-20160816;
        b=TS39iDBno2UyFeXiLIyrz8E5jlGOWjg0d4KfZ016MqbSUHDcwb0LoVFEfAKgd3RBI5
         yyk3BX9otB3mHnxB7NDmn1rqmeYTnolnDW9LdJ1G1ySsq/aQZlLFm/tZIu74HaC4zvZR
         Vx3lfDMpIY9YJpKc0usjWgCdrSaWQ41jxgN6YCrSqcHoN8snQ0DpuZOk5SgR4LMi1UwF
         QE5A6hEZlwY8pAPkAboBFi4p7UnFdqC8qnQ6I71JINyiowKPpswBjHZBonpeoORXBdsv
         CsLLEA3RqOlOn/5uTDvtLdnKvyfOAuHuMoshrAf2zvus7dqONyB/PScUrvuw6JeZ/v0Y
         0VuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=alHq6o2bwE4Y9QFzjd4yL/n+9g1VEyvJjccijbgIuIQ=;
        b=fNtvlDYT5LBT2H8a2TLs0+DtJ1oTdKykeZBQ6mW9Bens0dUPexgbApLjx9O3CNKSVh
         cQ1gQQh9FE+MzdkvzLyULTMT/1Ci/xZaAQQsnYRYi08jH+vSs79nTfP9Ptb71frj5wPv
         fZaC67uApi6hdcOrP0+jiMfWwcc0UWqYNbTRz+jaHu1c3DHNqPBC8Sbb0wESp59j/Air
         NOBDIbG4/iuxxQIDrcnCFIHY+6VM4oFO8Wqd/bNC58JD24P7yRLTLx6ynygpSLuRdBF7
         zZlGdbaHBv9Du1wnrKsYYygWjuEo4KkbfgeGkLl+wUYDf1HTVJxMDOkcBwzYfADrQB6X
         tj0w==
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
Subject: [PATCH 4.15 013/202] media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner
Date: Thu, 15 Feb 2018 16:15:13 +0100
Message-Id: <20180215151713.521839138@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480721810490491?=
X-GMAIL-MSGID: =?utf-8?q?1592482069260019971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
