Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrIXVCw9aHN0GOFsxMCTJhHaujFw+hMMTMffaB5yd8v/GcU0Yn/Hekw82IXpA7Bp5GpfeGU
ARC-Seal: i=1; a=rsa-sha256; t=1525116369; cv=none;
        d=google.com; s=arc-20160816;
        b=g0iplVvDnDLl9TF1tb1yEiT6aARg1y1J4V+jb+VsN8X3vuJIn7lnN4vedbOJrqyMhP
         lYnOer/6Uu86hMgYeBcpWBVhj8ZkRIMpO+QNTQWfhxBF9NhctHlWQY/m7O1EFYv0IKPG
         cBbK4kWk+PsDWTFuTm3uCMtGsy//sVCyNziURFBXaZiVeWJVinz5UNJkTyqbCRyVv+Ii
         p/BT9QH7SQFOQhRzMc+jBqQx0IGTvJL6K+pi3ekycbBaeV7JB6Ge3BoiqcpyFulmGysU
         op0ZNh4oYClDYqUEsO5aqfRhm2yqXJ+gk3sr0WQy3JKo9wf2vTnDNBvhzBPaitqo/Ql8
         k7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ihgVskkEh2dApA7/XQ3roK45SHLuvI1Toq5pwxrqeaA=;
        b=P0yB8YQ0R3DfPlDtyG7zyV403fysmm+YCyL+o0SAcFUE0+T5xyEhaWK7j3gCHGvU7i
         lpFRSuOviaxwHKyGr+BVNr220YFtQpMr0a1ti4K5ayhq+tpWQ42vLeFahIUGK1u7NoYe
         qvaaJZ7dqoUCUaVBcPMvpzMrXGNfFYIwL3ywx4ZusI399H2ynD8pPqS0i9xESJgIxJ0L
         Ruw11qVWY24h3slDl8ELpVWWfehjwgo1Z9CsxaNdycx0pMtH1ifnVgBKfwk9GVqXi+Zj
         P8vjc818kSbUDpPurWAstDCeKWNtF7SZdSybKs7GRryC610ge/XYkPtmqPH1lIqrmLjZ
         iVIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D302022DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 20/44] ALSA: opl3: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:31 -0700
Message-Id: <20180430190947.152790912@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200422064417466?=
X-GMAIL-MSGID: =?utf-8?q?1599200422064417466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
