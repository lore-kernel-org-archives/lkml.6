Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Iy5uKWfyAlrHtqKsXs6QS9Zzzyr68cJ4sSpCu+GiLTJGsEGUPNmV+5eC1OuG/Y7VCakXi
ARC-Seal: i=1; a=rsa-sha256; t=1524405561; cv=none;
        d=google.com; s=arc-20160816;
        b=SWHzr4RnhyEFounaLmqxriUDCp2k9050zFr3h5AfYoHVPFFozqLnQRKVzHxI3BZMGy
         sl0WcIlb2MP5M8+PYMwRbVp48UfVapNrVCS6mopAsqoqsRiUj4Italj17BGX2/Aqv2aE
         fKpV0iBSZTfE5WCJ3cjMi5uur9B7GelxP1EMbq8i8ujaJODiAqYpkgVWuD4Ik1t7oHNt
         LUTlR06OGuOO22WplcyZahXH6u50faOR7ZRqNkYbUL1b8gN8FFpkmYR068Yptapnff7o
         VRFQ7xenNhyhqK/3u3mq7Gv5HxpE1toT8adrhCyS7t8I0Mf3vUtSq8m/IZi5Cja/3Y5N
         S1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dKzJkZag3Gab3CR/i6kVnbXuQ6QCppXFQWXQhnaOS+I=;
        b=re54waNOo/K59oGb07L2RDY8D9c7HKQwGkvBr6eu4iJHIu2ry9xqNx9wOgw5zJ0iA4
         +H4ZJ7VFqu0KI5YVcXeKzh7yaYJaOrVMZPN81HybyAJvzzxunLZUA+DwFZQm9oPJElfI
         RsIT+RPIsQ2eX0oeubNaTb0Sq+S64uHYOFTTdYgUzIX3eRJVGhP8jBG7qAeuNKp+iDBA
         VaeDMQr2rtitYTkSlfaLa5pw/UQ+csEzWKia1Nh7nilPYDVbzQ6o7/Vm48+3JzGMzre4
         Ynbe9L0b0TU4fucVw51RwYZ0DX92w1BZb6T93dVW3/VCITrz6HNplIO5r4FqkOG3p5DX
         XDEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+8e62ff4e07aa2ce87826@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 111/196] ALSA: pcm: Fix UAF at PCM release via PCM timer access
Date: Sun, 22 Apr 2018 15:52:11 +0200
Message-Id: <20180422135110.009761064@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455086390291327?=
X-GMAIL-MSGID: =?utf-8?q?1598455086390291327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit a820ccbe21e8ce8e86c39cd1d3bc8c7d1cbb949b upstream.

The PCM runtime object is created and freed dynamically at PCM stream
open / close time.  This is tracked via substream->runtime, and it's
cleared at snd_pcm_detach_substream().

The runtime object assignment is protected by PCM open_mutex, so for
all PCM operations, it's safely handled.  However, each PCM substream
provides also an ALSA timer interface, and user-space can access to
this while closing a PCM substream.  This may eventually lead to a
UAF, as snd_pcm_timer_resolution() tries to access the runtime while
clearing it in other side.

Fortunately, it's the only concurrent access from the PCM timer, and
it merely reads runtime->timer_resolution field.  So, we can avoid the
race by reordering kfree() and wrapping the substream->runtime
clearance with the corresponding timer lock.

Reported-by: syzbot+8e62ff4e07aa2ce87826@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -28,6 +28,7 @@
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/pcm.h>
+#include <sound/timer.h>
 #include <sound/control.h>
 #include <sound/info.h>
 
@@ -1054,8 +1055,13 @@ void snd_pcm_detach_substream(struct snd
 	snd_free_pages((void*)runtime->control,
 		       PAGE_ALIGN(sizeof(struct snd_pcm_mmap_control)));
 	kfree(runtime->hw_constraints.rules);
-	kfree(runtime);
+	/* Avoid concurrent access to runtime via PCM timer interface */
+	if (substream->timer)
+		spin_lock_irq(&substream->timer->lock);
 	substream->runtime = NULL;
+	if (substream->timer)
+		spin_unlock_irq(&substream->timer->lock);
+	kfree(runtime);
 	put_pid(substream->pid);
 	substream->pid = NULL;
 	substream->pstr->substream_opened--;
