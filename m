Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+ud0hCc3jyg7/6ZfFnTyCqlXRVafnQ7tYHmU/74l6SSQQ9/oO48ktQGzI/CKaUuw/WFYei
ARC-Seal: i=1; a=rsa-sha256; t=1524406651; cv=none;
        d=google.com; s=arc-20160816;
        b=FTEq6WVsUQ+NtE9geCwXRYo1Pscf1fpRawVOanpEwXPsWQiAHTv4/g2xw4AgNXxcUJ
         S/HmhmCvfoJ839E+r6a9DaQmsacYQnNFVm/aL078G6gjbwtb3LOV5cpQN/tqQQQe/uHY
         G9CM+jjxDW2xw1zdCHDTPuUnRIrGDpIppPif/mwfVuzvsLnCs7OVSTe0gYlDjaSyJ8cD
         YCXfOjn+SHQS4DDPgd5eqBGtKuSIZd3o+2Ek29Y3bzKGUK5KGEertfragAwWfJDpCyJw
         8U7YMp/QmOT3LmhTS9ZUO3bTqDPa/+DK2eMYg5q+TRjCalgvKL2ElFVgz/n560b5oR3A
         vssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+1gFRu5/i6QktzYS6h7fY0nE4lXtm2NbZVO6Ttcl3aQ=;
        b=fe+hzJHztZ6AefQvHF21Fb3L2VmG33Xg49WbVXlbet3gLdcMmQAqHIKSo1AabDtJga
         E85cI8dW5AIrUnQXwra5LVe6KUegIqbZ6Iz1ZG2wuPw7OTSoDlnyL8Mbw/Ewq7phB/1d
         8lWf/HpzWsn01Pg/1w3BAK2a9PJGVrY3mNEwbzXH/0XfXuNMvKDEotsAuGXu6eid1ytE
         v6zssjE/UBYYzcnwuU8dfZCMpqrAvK8t+eSIXEkZ5p/1tb5uRd27+bvqMRvr9ognvKCK
         A1HFRM93f8tR/zXyaCQL0f19NXkJRGNkDB8Q6l54tzWu9TDULgNA/ZAvGTVxLrNZB3YX
         Cylg==
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
Subject: [PATCH 4.4 53/97] ALSA: pcm: Fix UAF at PCM release via PCM timer access
Date: Sun, 22 Apr 2018 15:53:31 +0200
Message-Id: <20180422135308.244077643@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455086390291327?=
X-GMAIL-MSGID: =?utf-8?q?1598456228883679387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -1025,8 +1026,13 @@ void snd_pcm_detach_substream(struct snd
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
