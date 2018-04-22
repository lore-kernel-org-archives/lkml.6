Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48NTAkaAYtP2W2nwsuLw0GKQAN+YctH3EUrxfporMekjF5OkE01TCHfZrOEveYJEWABrBW2
ARC-Seal: i=1; a=rsa-sha256; t=1524406036; cv=none;
        d=google.com; s=arc-20160816;
        b=AvGaYyWu5eu+eeqmL4abNWhVHXBwg4T5tmyP9dyiv6RuQdacWBmsMxsMo4V1K2DhM9
         CB02fbNsok7Hcl1/qdNkiKJLyMcgC8N6R+HnqSks1gZypHSYPnYaqe4JHGMMAZ7DH2Ri
         Nh7zGvu8bOhIBp1kLR0Yvoe/v/u22gET8R4x6wp6WmF987CB+gug1vOltIfzp4SFts3G
         4x/IRuW05RV5nFCjWvBBLBbNrFy3UhWRNmpVTfS6BBc3Cy/p0XksN/FeVo1YJuGxSDF9
         d1EvnYXa1WLzDLC6r26svPPpI3C7DeK4H47MzQZaCzQS2cNPnz4+wOuwoSEBNzUyrCnm
         W+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kes5wneymeLg1eTzrCBdkLFPLDkkO/c/IB/UhZ3Sx2w=;
        b=MnxOL8QuRS2da6yIi92W3waLAnCUsJcAZhZq6IsXHPsx2jy9I1v8STD3YtqRaC9VLF
         dCOa3NJ1nEr/n3ai3M59z5LNfYqOtvtUbJKNho3fbAW5SrYfM+JooGIPi1/EZWVI2AeX
         2PYKmBm52AtGJX6YUe6Mr9eWNZWS1cnM1oNrxSocCwpXuYuP33BXuVS5FrLEUQ+Tq2YW
         b5I4syZ3rR6uhXZvL0QUMsYYQGLmqHgE8XM4o8DDNeYmdL976lGI7+r/WGttdKsk7FYt
         HeIOtO09pmvJeuuak83HS9f9G5/zXZPNoFkwF98UtsnjPHTGgKuG1SvzHP9+L10dNqMK
         DWvg==
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
Subject: [PATCH 4.14 089/164] ALSA: pcm: Fix UAF at PCM release via PCM timer access
Date: Sun, 22 Apr 2018 15:52:36 +0200
Message-Id: <20180422135139.070429881@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455086390291327?=
X-GMAIL-MSGID: =?utf-8?q?1598455584437343775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -1050,8 +1051,13 @@ void snd_pcm_detach_substream(struct snd
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
