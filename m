Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqcgEzxdq00Ch73QTlbZPGjWwcVi159voYhMzyKS2VhbBzPInhr/+PD5lv/kiz3LgmNJ7jz
ARC-Seal: i=1; a=rsa-sha256; t=1525116356; cv=none;
        d=google.com; s=arc-20160816;
        b=euzHI9XVxnVLrFpt6EnItqYeGwt4Vm1uE0iiWY3PuwAeoS7tv5xC8hug4hptrVGIbo
         rYve2T63a/86EpsxmVS1xnKfUg9U9iokKEcsXk1eevLhyNVvftiAD1K81helbaGSn+PK
         z7HwVnd+GCN/r7LuWMNBSuAty7fxfXcsKvoo7Z/ccRvKuGuxaZ1JkfMCX+z46+XGePvE
         0KysRNW4GWpzOqpYcFOrsc+v76E2t0deKzpNBBJI2qs9i408rprLeUzLkB9K+ysyRERa
         ZBm7peFQTvuce8X0QBWfR9Ymu0/nAhpz8z5k1Q3EJcGvf1DhSBwR80+fNUJ7YKMzPtUk
         SVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zsNHgS8mJSa3H1R/fWNqC3iW/beDTQ2HzNAC13ThY6s=;
        b=zVwdHleCY+Zu8wntsX7H2oIjZ5uX07UgxlTxyBLdP8qJ7ZXwBEmMV9Jmr66zGnnSJN
         t8O/xEX8KMQN9Fi3yp4Bt65Z/Ez0+njxwW+5LyojUAAi4xaEtlCBvsN/IIVHhCdulRdk
         HNqlpNsUvkhYs0CPh93jnXwL4fbBMB0/NwNPVXqQ/zhZpq4o44Rs9YBGlvhvo9jtCcVb
         ZUvZz/773EmxTB9Otox+SrEhJk2CtNwvkE/KgHPxDzqwJK8YBBxnulKYN9CeFpZep6XI
         kWzrAmA8ozdf2qIHdHOJxN7lpOk2M6H38gLP42BKYFbmVFPMWOt3p1uMHXOqgEnwI7Bv
         hLqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F3D22DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 26/44] ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
Date: Mon, 30 Apr 2018 12:24:37 -0700
Message-Id: <20180430190947.384214397@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200282251951106?=
X-GMAIL-MSGID: =?utf-8?q?1599200408584751411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f5e94b4c6ebdabe0f602d796e0430180927521a0 upstream.

When get_synthdev() is called for a MIDI device, it returns the fixed
midi_synth_dev without the use refcounting.  OTOH, the caller is
supposed to unreference unconditionally after the usage, so this would
lead to unbalanced refcount.

This patch corrects the behavior and keep up the refcount balance also
for the MIDI synth device.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/oss/seq_oss_synth.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -363,10 +363,14 @@ get_synthdev(struct seq_oss_devinfo *dp,
 		return NULL;
 	if (! dp->synths[dev].opened)
 		return NULL;
-	if (dp->synths[dev].is_midi)
-		return &midi_synth_dev;
-	if ((rec = get_sdev(dev)) == NULL)
-		return NULL;
+	if (dp->synths[dev].is_midi) {
+		rec = &midi_synth_dev;
+		snd_use_lock_use(&rec->use_lock);
+	} else {
+		rec = get_sdev(dev);
+		if (!rec)
+			return NULL;
+	}
 	if (! rec->opened) {
 		snd_use_lock_free(&rec->use_lock);
 		return NULL;
