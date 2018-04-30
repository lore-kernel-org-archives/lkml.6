Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrMZrSGB1MLQOMcdRsBd9GnYShUf8AjcCCTOj1goNY6d3f+gXpnkAaCeq8NzcP0Z59nONVd
ARC-Seal: i=1; a=rsa-sha256; t=1525116496; cv=none;
        d=google.com; s=arc-20160816;
        b=OpHaC9D0715UgrUGPUV13ax1yFDFvEX6I60+bb6Msv29M25GLsi0v+uUbltK0/2F7s
         fsv1OjzrBoZjiUJi1ccKIoEGvdwE4aRQBrAlRN5KBevSpFkHqZ6MdhO1msGrL18e6dKQ
         rs2Nvk+cPOwjuOTvDbe/32D+o+P8inFeJTNQb2M8D4ZpUAcCAdBPGI5TuiV7Ry6i85/L
         KJ9ODrjDTx6iRs9o4OUXD6bvgetnB26pJcEW2uVOXkNTHvOtPglxjI/DJX171UsjwIea
         b0jHVHfOUMiBsr2IvJdAyrm2Ojb+tsGRFypgcClgqIeCXhxXk/vKm9X3v5xGs1Lcm46z
         2RoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=rKmVPqjm4qWfrB0QqZtyA0ArI9vZPhzmUs8pJ7a8F1w=;
        b=Fbxls9SmtslL9DKjZuGnOe/m4P4g8ej79kqFQftJsVnNgufq5Rx8bSRzvUd+3jCNJu
         CUfqJSp5AKmaREzxxZTydDN1zgVeoUdadf5IjtjS7a87qoGj6tqH94miCbw/ouOs53ZL
         2XxuAUl3vJLCbqFiG9DXBQXSaY7JsmWBk66l3uU5hvFqOK/HqYcV+TdPrgodj02RDGeU
         a5AQ4WPJe+qpuimrldEZtW7Ohj8ySDhpeiPcMQ+9Cuu3D2K+s5Kj3/TGRU9CBEjAn7PK
         hznx98JqEnasg181kPLFArp4uJm/ZTVKRXTIVyQPfhYrO0mE9kHbvZDuBS6Q+c1phHUJ
         t/bQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEF522DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Henningsson <diwic@ubuntu.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 047/113] ALSA: core: Report audio_tstamp in snd_pcm_sync_ptr
Date: Mon, 30 Apr 2018 12:24:18 -0700
Message-Id: <20180430184017.044188828@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200281194240670?=
X-GMAIL-MSGID: =?utf-8?q?1599200555455600747?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Henningsson <diwic@ubuntu.com>

commit f853dcaae2f5bbe021161e421bd1576845bae8f6 upstream.

It looks like a simple mistake that this struct member
was forgotten.

Audio_tstamp isn't used much, and on some archs (such as x86) this
ioctl is not used by default, so that might be the reason why this
has slipped for so long.

Fixes: 4eeaaeaea1ce ("ALSA: core: add hooks for audio timestamps")
Signed-off-by: David Henningsson <diwic@ubuntu.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_native.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2749,6 +2749,7 @@ static int snd_pcm_sync_ptr(struct snd_p
 	sync_ptr.s.status.hw_ptr = status->hw_ptr;
 	sync_ptr.s.status.tstamp = status->tstamp;
 	sync_ptr.s.status.suspended_state = status->suspended_state;
+	sync_ptr.s.status.audio_tstamp = status->audio_tstamp;
 	snd_pcm_stream_unlock_irq(substream);
 	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
 		return -EFAULT;
