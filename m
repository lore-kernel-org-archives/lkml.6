Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsOzFMIeXZAPWeOfHMHcyxDebh3zDW5UmGgOrksBFW+K7RYEzgTARNADGpO3NggfexQ77qa
ARC-Seal: i=1; a=rsa-sha256; t=1519412153; cv=none;
        d=google.com; s=arc-20160816;
        b=Hcf+8l3kGESmI77vFV+Ikl5SpI4EyZHG9dILYM+ZIQSevT9EGCgoVZfbTGj7H+JYh+
         dhAfiAzVAvrUMv8CBezibTCqR049q6DC+3YagmqdFwLenxssrQozlNtI1D7ysrjLcQjj
         40qr4nmpb06WnpzFur8ZRuumWQfMG43m2xtayRDb2dhrghBS7nKUXvkmvU5axQDYxPVI
         oC4O8vsOVM5XUNzD/4wba5UTM5+uJZSPWkacds7dn/P3Q8tjdK9k+bjizHAiOaZRc6WZ
         iq9V4xeoz8fYSuBcirBnEt+zosV4sYhhCSncTGtysXrKWD+baFblAFdpVmA93joTLkmC
         P1HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+lSSeiGboGBGy7+nvLD7oEGyc/Izjtvgu1ocfOVBKRQ=;
        b=OsWsFs5hce7T+Rzo2EEfCV/sZ7xIxBjg0xcOt/nALbdyJS9CBa3KIdj07+F7+m54wE
         s1iSxCgWGdJ8XR6pnMGS1A9Sbb8USalZMQDUNrI7TXrvKAKnpXrlc7uTjJa1PEsyUosY
         6RNYm/1/9DMx1G1FiZoQi1q3MUk4/kVgrV+n2iZ8mkh/Up1O0HKTaIsOY4GlafdC38LG
         ihYF2HoZQBMesx4KT8bhXJY8wpmF7BvCuiWo+EUkzblfcMhJnEPE9MF9+OF3jp7E1odB
         b2zMxxVs2iP4fXWyhiWhokDRF+Zo5JTowx1w7mAS2zLD7Pu7VBWI4xuGt+ZdqbsK96Q4
         JSBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jiada Wang <jiada_wang@mentor.com>,
	Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 142/159] ASoC: rsnd: ssi: fix race condition in rsnd_ssi_pointer_update
Date: Fri, 23 Feb 2018 19:27:30 +0100
Message-Id: <20180223170800.182800801@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219117972842023?=
X-GMAIL-MSGID: =?utf-8?q?1593219117972842023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiada Wang <jiada_wang@mentor.com>


[ Upstream commit 33f801366bdf3f8b67dfe325b84f4051a090d01e ]

Currently there is race condition between set of byte_pos and wrap
it around when new buffer starts. If .pointer is called in-between
it will result in inconsistent pointer position be returned
from .pointer callback.

This patch increments buffer pointer atomically to avoid this issue.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reviewed-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sh/rcar/ssi.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -449,25 +449,29 @@ static bool rsnd_ssi_pointer_update(stru
 				    int byte)
 {
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
+	bool ret = false;
+	int byte_pos;
 
-	ssi->byte_pos += byte;
+	byte_pos = ssi->byte_pos + byte;
 
-	if (ssi->byte_pos >= ssi->next_period_byte) {
+	if (byte_pos >= ssi->next_period_byte) {
 		struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 
 		ssi->period_pos++;
 		ssi->next_period_byte += ssi->byte_per_period;
 
 		if (ssi->period_pos >= runtime->periods) {
-			ssi->byte_pos = 0;
+			byte_pos = 0;
 			ssi->period_pos = 0;
 			ssi->next_period_byte = ssi->byte_per_period;
 		}
 
-		return true;
+		ret = true;
 	}
 
-	return false;
+	WRITE_ONCE(ssi->byte_pos, byte_pos);
+
+	return ret;
 }
 
 /*
@@ -838,7 +842,7 @@ static int rsnd_ssi_pointer(struct rsnd_
 	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 
-	*pointer = bytes_to_frames(runtime, ssi->byte_pos);
+	*pointer = bytes_to_frames(runtime, READ_ONCE(ssi->byte_pos));
 
 	return 0;
 }
