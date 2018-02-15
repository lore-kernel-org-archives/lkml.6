Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226OKDSR2vFpIrv5Ds64+jyPKJx25QYddmBK4kO2ghoEG4n9/Xb5YYrA1IAeIn7acu+xuXbt
ARC-Seal: i=1; a=rsa-sha256; t=1518708996; cv=none;
        d=google.com; s=arc-20160816;
        b=FyQgskHVlMFxoiWJh50ByGC4RKu0qKKLKAGzi1WCsgAeUelBVvmvRB1AEyggZYM+Uz
         p4sBZMlvCpjiawVqSi5GKXIZpPFejSRrVlXO+wpDInZz0dD6MPdofJcjSvPCyZ1E95o3
         eSUlEfkS9VlHkBL2/HEXpeuRr5EHbDhOpnO7TCScnHeIDtU8EaZjelHjUlnRNdsuX/0+
         If9z0kJKitYViIT3W7RgudiosBD20UqzUvDE2sbyQ2/IbFT3Xuw5D5tFcRdqlJuiMjRP
         x/RRPf0U/eylspyoUTEhky5XcHBcWmbnbJbw5dtJztI63WouJYh7BjNXRSkqozuZEtX5
         uh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=giGu7CRQM+ud6h5bug1ZabdUagIjA+J+bHeOZpMRyvU=;
        b=mtNJ5z4TomnAWl3x7vpEJGhNnhiJ4fWhWi2zSHNJZX8HpkfVm0JVoLUbCn3vLmXbxn
         owx/4NVjUAjiFItVxGLClY2z7J7NWefpJR2J0jw5lxm/Jyf3B96oyFiROaplm90C6+vf
         JSw/ueH5HxZpKoikkBNisjSeST4ohzvm1PcNKSGLrYmyDfsqATZb+4cOwLH3L4fM3L3F
         XMzRMtzqnld7gtEYe6538TYcnBW5yuZt291lywXDxfHNvNN6u5jxuS811ipYiwyTufux
         P29xjS6WWHdjTvwkMEVn2KoXpxS3Si9R73Hl0f6d7S3QK6n//Dwn1mbH3/AgNXEe79gC
         Rb6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 150/195] media: ts2020: avoid integer overflows on 32 bit machines
Date: Thu, 15 Feb 2018 16:17:21 +0100
Message-Id: <20180215151713.372569798@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481060573127199?=
X-GMAIL-MSGID: =?utf-8?q?1592481804426082301?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

commit 81742be14b6a90c9fd0ff6eb4218bdf696ad8e46 upstream.

Before this patch, when compiled for arm32, the signal strength
were reported as:

Lock   (0x1f) Signal= 4294908.66dBm C/N= 12.79dB

Because of a 32 bit integer overflow. After it, it is properly
reported as:

	Lock   (0x1f) Signal= -58.64dBm C/N= 12.79dB

Fixes: 0f91c9d6bab9 ("[media] TS2020: Calculate tuner gain correctly")
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-frontends/ts2020.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/dvb-frontends/ts2020.c
+++ b/drivers/media/dvb-frontends/ts2020.c
@@ -368,7 +368,7 @@ static int ts2020_read_tuner_gain(struct
 		gain2 = clamp_t(long, gain2, 0, 13);
 		v_agc = clamp_t(long, v_agc, 400, 1100);
 
-		*_gain = -(gain1 * 2330 +
+		*_gain = -((__s64)gain1 * 2330 +
 			   gain2 * 3500 +
 			   v_agc * 24 / 10 * 10 +
 			   10000);
@@ -386,7 +386,7 @@ static int ts2020_read_tuner_gain(struct
 		gain3 = clamp_t(long, gain3, 0, 6);
 		v_agc = clamp_t(long, v_agc, 600, 1600);
 
-		*_gain = -(gain1 * 2650 +
+		*_gain = -((__s64)gain1 * 2650 +
 			   gain2 * 3380 +
 			   gain3 * 2850 +
 			   v_agc * 176 / 100 * 10 -
