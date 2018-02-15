Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224mQUUxKJpDLQOAXV1kWJiUnhvdyRNkLNnw7P/nT4rWQeIQURj/Yofv8UVjJX2/yEVgrL7m
ARC-Seal: i=1; a=rsa-sha256; t=1518708534; cv=none;
        d=google.com; s=arc-20160816;
        b=BugV+pae1eiQH19coQq4OtN2zPPU7MoF6W+Z0Uj7215so4VJ4AJe99qHRKM3SbTEXs
         FbweKFNNVQieT0d/ssrEQ6vr79gSsV22UTpO33MlasFyWmfPI2fM42MR+AuHueTNyqiZ
         PgypFxwcCby0XluufuvxcTFq4Wk6FGadDokYPQyWpuOLOaBNeFYRWnMASKWLB42ebutP
         GL7bbS6BVoakcjlZFShjpChf2dnF5OZo4nc/h2pr/OmWBuFWCqbAsrE8ZKO3Ghf1Jl68
         mHsyBfFbA15NKm8/iLK6YGcQkXtb9VRfoQzqOJt2OEk5f2x0KCe5aJ9D/HiFmKJyabXb
         508Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CDsGoqkEhxKugejpvSII+ajZYJnajg7sqSdh++HcCnk=;
        b=foNejXKFZUlOZ3KxlicPDldSgblOadzIrr8ZlOtnqE8Ovdp48F6FuH4ju0hjfprHu6
         opnt4VfNg9FKFa0kilnQvYrg1ISh5D93xEXoRafoQU5CwUtdgxBbKRSdbGbYFxgk8SeT
         BP97ItqZ7QYga9nVznsaV086sn3LMBElyc5FhDeLLnLzKiVuN2InP4zkKzlcyuBuj+Zp
         TfnbXWzgIjFL7igXdbLLlzYZn2txveOH2rcC7Ng/GfY6pQW9SBhbxiOFuaPdCKbg45td
         Qi+onJgdv1TLfZvuwvyn4jtqjWV5xgsQgWAVFS00ATBDcW9llKlPb7ALx6MXcAR+nVAm
         vSCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 59/88] media: ts2020: avoid integer overflows on 32 bit machines
Date: Thu, 15 Feb 2018 16:17:26 +0100
Message-Id: <20180215151230.851095889@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481060573127199?=
X-GMAIL-MSGID: =?utf-8?q?1592481320152438160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -369,7 +369,7 @@ static int ts2020_read_tuner_gain(struct
 		gain2 = clamp_t(long, gain2, 0, 13);
 		v_agc = clamp_t(long, v_agc, 400, 1100);
 
-		*_gain = -(gain1 * 2330 +
+		*_gain = -((__s64)gain1 * 2330 +
 			   gain2 * 3500 +
 			   v_agc * 24 / 10 * 10 +
 			   10000);
@@ -387,7 +387,7 @@ static int ts2020_read_tuner_gain(struct
 		gain3 = clamp_t(long, gain3, 0, 6);
 		v_agc = clamp_t(long, v_agc, 600, 1600);
 
-		*_gain = -(gain1 * 2650 +
+		*_gain = -((__s64)gain1 * 2650 +
 			   gain2 * 3380 +
 			   gain3 * 2850 +
 			   v_agc * 176 / 100 * 10 -
