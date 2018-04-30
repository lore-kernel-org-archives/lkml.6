Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZohtG/mIxEoWwmgm0Xdwzrp5u2Y9/18hXE1GVnjdDrORXkxskoFM2iaKPpXHEXF5jGOWBEq
ARC-Seal: i=1; a=rsa-sha256; t=1525116515; cv=none;
        d=google.com; s=arc-20160816;
        b=nl+4mo5pLbi7jLB4opC9eS+HRK7YGm2c2VNeI3A4NpWN+eXkd27TMUMtjizzGbTPOJ
         KOsdDp0yMJORda928qKlhLfGh9q/a1nDjDhsik9a/RcKal33MgC350GEJ3a6rdNInCMz
         FxhiPFJpiQpY13n84/jKbLUXdrEEIdgvkspv2ThTOtl8CLjqW1B9IRGevPCVvWF8YaEm
         TgWOxrmeBVQ42ZJPrWnAOGK2i3VIo0PGPU8IAShX6FuLZMASgOEYCrBpA2EOynpyEpah
         al3mk6b/jX/xndNdn+SRK03BgbMx9D0ROO7tW1bvPihsaEpgdOejvciw/PLCGgtvdGuM
         k8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=10h74zg/4rO+GNq2jqpg4s+R98sfok/fy5bil3bwZhk=;
        b=ZiDt4SlioB9T7IQhgdCCrlsJNlkxBnwavifXNGBwBILbgB5uOZgQh1PigLMg9IWuJ0
         w9AEzxw+7NpVzYehbSH5TXlQVZSjQXrGNDvuZsvvyDO1qx0b0Q8pfPSBKT/wscZradny
         nMA+dbW/xCNvTyf5epN+gYbNpT5LHYFi8vrxEngDrtiA9zaJRhwmrP4nmFIIsqplwmas
         holAKB4EmGvCBjlCGcGFLiNTFlJUqPKK9/w19d/D0+xlwaJWlNt53ygKT5dBcv7Bkdo/
         pGwqoz2YbOdB6scZ0HnaAXXnY5KLdluHbJvDuVs0cVScZcd57grNrz5tkFay2hzytDtM
         aU+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3EEF22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 041/113] ALSA: opl3: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:12 -0700
Message-Id: <20180430184016.793344825@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200422064417466?=
X-GMAIL-MSGID: =?utf-8?q?1599200575501734037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
