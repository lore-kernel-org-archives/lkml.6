Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrZ3MgwoqwG0RhlQ3gr91jfcwEZgR4CjW3MGGtSlxbp5NDMDwaJBYUk7NqLMqDpBDsLC5DI
ARC-Seal: i=1; a=rsa-sha256; t=1525116432; cv=none;
        d=google.com; s=arc-20160816;
        b=ajAdtHhyAhKNkWwy4IsvUDXM5jH6K0H1t3Qfad6azbIQb1tJaS5Edy21jtoPHEFH27
         QtVrjNl7X0GwRhyi/DyPkyr+hB6GivqMU7gm4mYgSceFcnWK9J5CLUCnPKsv7LCEfyLM
         EFpMop05ondeFxYwjDEmVLmSwzp6lzgZ8pZnCKsaDwXb8+aE1M1GUxSE3kX0ubT5NMMf
         xaj6LLXtM07OxT+Z8Nrbf1/iMqBaesq0K2sKpQ+1io9LufGxHSpjMOdcHiA7hrBu1hAa
         AsMqNtER6Hoo+uOTP+unPcIIaORofAyATN26jyNiXIXZ+91Tc2eTBt8LEP4SSuG0zUWh
         d01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Cr/xQ1NPAIk1GtPZUYNBNo27oUxoy2J8B1hghssUNO8=;
        b=oI1MUMVvftjEy0WfJl862C1jU9zCLPNyLTHBNdpVzVJ8f5hzAMU4fZYnHVIyU0sa/y
         n2kbpRVsvydo6L0MABHfcQ3GwM/s83qK2HRsMx6YYypSbOlN3vPoMcdPoy3HEPPxUyAh
         w7Fd5VNyl1xuGR2/71AC+/JKep5IUcsO7SWNg6Ck5dr6FOJSaYPjep9OGXXh0xl1wRv3
         q2yTDa7E3box/TRapp9AFDNnaXvtLO4notfsxyPjPYXho+QyZLjablxo+s028KAmb95/
         yHCnUb3HuSz4OV5KyHUprS1olBxCqq0BhSfdcjg0r2Wb99wBGAUYZraaQBzF7xqBynRO
         AYsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418D522DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 37/91] ALSA: opl3: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:19 -0700
Message-Id: <20180430184006.106444963@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200422064417466?=
X-GMAIL-MSGID: =?utf-8?q?1599200488593762736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 7f054a5bee0987f1e2d4e59daea462421c76f2cb upstream.

As recently Smatch suggested, one place in OPL3 driver may expand the
array directly from the user-space value with speculation:
  sound/drivers/opl3/opl3_synth.c:476 snd_opl3_set_voice() warn: potential spectre issue 'snd_opl3_regmap'

This patch puts array_index_nospec() for hardening against it.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/drivers/opl3/opl3_synth.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/drivers/opl3/opl3_synth.c
+++ b/sound/drivers/opl3/opl3_synth.c
@@ -21,6 +21,7 @@
 
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 #include <sound/opl3.h>
 #include <sound/asound_fm.h>
 
@@ -448,7 +449,7 @@ static int snd_opl3_set_voice(struct snd
 {
 	unsigned short reg_side;
 	unsigned char op_offset;
-	unsigned char voice_offset;
+	unsigned char voice_offset, voice_op;
 
 	unsigned short opl3_reg;
 	unsigned char reg_val;
@@ -473,7 +474,9 @@ static int snd_opl3_set_voice(struct snd
 		voice_offset = voice->voice - MAX_OPL2_VOICES;
 	}
 	/* Get register offset of operator */
-	op_offset = snd_opl3_regmap[voice_offset][voice->op];
+	voice_offset = array_index_nospec(voice_offset, MAX_OPL2_VOICES);
+	voice_op = array_index_nospec(voice->op, 4);
+	op_offset = snd_opl3_regmap[voice_offset][voice_op];
 
 	reg_val = 0x00;
 	/* Set amplitude modulation (tremolo) effect */
