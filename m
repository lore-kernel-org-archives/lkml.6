Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227WRrwI9pfxmRwvb5oytjAxxwr7ORt8VXGtGpp6eE1AkgjuxfSytv2YDuIHR6vi82FNSchw
ARC-Seal: i=1; a=rsa-sha256; t=1518708353; cv=none;
        d=google.com; s=arc-20160816;
        b=bizxj81nBPbCfE6AXsR9EV3lBF5VpCMR5SnAjpCLw21iNVvObt6lV42VF6ffZyYXbc
         EXZJlKv9A7+kpfUiulzDKtAR1Un0KNlbAHsD7ZJWgpPyjJxDP62XxQUtMmCzxPwH3CzI
         PEkio4guuU+Xb+vTtNlErPEA4y7mcLFQ5nwPMeZy0R0dTX+D/zM/sVFVC0RGI/kumhwr
         uXBKl0rDm7yPyqOoyfY9Ky7BLOM3aZ5f9k0MF/9jLUBIMLnpXSCCpVKQ+c1W4WGMToyw
         xIzVhd/6Wjik5kXFUm+QqeaRdLCtFtIGbi3hkzt2FGuOK5n51IG8CtjSNLNgqWZ/qbX7
         Jdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UfKESpjMbkqOYs2Cunk5iWhTIoufxVWsVqKLJ15Ovtk=;
        b=T74Si3vSqXUWlUYXfkFXV8SCctNMlpgfDWUYM3PNPaljGvGa3b3JiQL2dnEobjgVZS
         R7ilhU8lm7+CxgIq+P2IFCrHIqeBg0YJJUhK3FCFq9pN+O4qLraoqWe4VCG47AiNhl1q
         5xFknBd1qPg++w8+RwNs1rHzZZygDzLQcKbRNRg1EzNwm2GsZ9LRNiLPFQG+1icgnXKL
         H+KLIQl3lesZfGBifzFknZd1ntsO9ns5KC946eUBWBost0qet2RJBg/TIgcJ0NISWBmL
         UyuDck/lDZJ8n7UUTst2sFxUt4gohFoI7ivj0pCxdNrS2pSnF5+CmDkKM7tD7haJM2YL
         Bi9Q==
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
Subject: [PATCH 4.9 13/88] media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner
Date: Thu, 15 Feb 2018 16:16:40 +0100
Message-Id: <20180215151224.531110910@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480721810490491?=
X-GMAIL-MSGID: =?utf-8?q?1592481131024698071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1084,8 +1084,6 @@ static int dm04_lme2510_frontend_attach(
 
 		if (adap->fe[0]) {
 			info("FE Found M88RS2000");
-			dvb_attach(ts2020_attach, adap->fe[0], &ts2020_config,
-					&d->i2c_adap);
 			st->i2c_tuner_gate_w = 5;
 			st->i2c_tuner_gate_r = 5;
 			st->i2c_tuner_addr = 0x60;
@@ -1151,17 +1149,18 @@ static int dm04_lme2510_tuner(struct dvb
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
 
