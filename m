Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoJdwGMBmprC5CMv0udOjnX4FXCvEnSSS1Rbvk88OxBF400g8jrRdJuNxM6DouLRJOLD1Zy
ARC-Seal: i=1; a=rsa-sha256; t=1525116495; cv=none;
        d=google.com; s=arc-20160816;
        b=EGUDmGqJWhHyIBQqArIFmdjXxhdt+q8mXyLVBPl5uC+iW2Q/C2h3gQrDdHqlWjMwhx
         S0wxmK/HEWTOngsFCtftHI2pLC1Ksdbiun2B9rPA3GnGuXQNkWN3lqXH1HBZTiXcGySi
         F7nx7FthlAZnA0SFcGyLRjKSNJ0myylfRg4JGiP70X11jcfC6GvesVsyvnDg3cQqTGl5
         jYbXHqf012zzl8dWZ+GlOOrA3uivMBa1ypR0cWtu3hWwvJNl4wRaHd4n+Wal84kEdBam
         hBluHShJMyrCQB3YpUJfZxm4OslgFZyeGNpOjvd+Lh6k2Uk8ujCv7j4V7104l9gV/C7o
         clxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0h6vrLhH8Q/RgppzhS/KDxsIski1j82wQzTrf9bkTB4=;
        b=SdIYVZ892oKMCAZjpx/8ZyqHaEfWaYzr+zI0AkfemMKnP3VeESQ1a/NonsAX6vw0QG
         AYg1JxF4geLBy3Dq3GrAZQqbMDJv+eHp4wnmEu18WY7EGA2pxEjEYyNGuHBvRFz0HJF7
         4AsofE2/jwwAFLf32GLcGKnkxsbU+l/sMXxg3rMX+H5RA63+RLboBmVfKmGJhBDdwLlr
         Ual2ChTbC8/DNWciPZH6fN9Dgrx+gTS5GjfIDGgsuEAX+MtIp66WzyGeWwxK2jOnnGgk
         lAyZGZDwEM2CgnGc8hm9ogeEh3eDl4YUCzqsfZNGvibf8DsO9NV7eA5Tg+WvSGIsmn1z
         lVhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CA322DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 045/113] ALSA: control: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:16 -0700
Message-Id: <20180430184016.950348790@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200426740166309?=
X-GMAIL-MSGID: =?utf-8?q?1599200553843948214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 088e861edffb84879cf0c0d1b02eda078c3a0ffe upstream.

As recently Smatch suggested, a few places in ALSA control core codes
may expand the array directly from the user-space value with
speculation:

  sound/core/control.c:1003 snd_ctl_elem_lock() warn: potential spectre issue 'kctl->vd'
  sound/core/control.c:1031 snd_ctl_elem_unlock() warn: potential spectre issue 'kctl->vd'
  sound/core/control.c:844 snd_ctl_elem_info() warn: potential spectre issue 'kctl->vd'
  sound/core/control.c:891 snd_ctl_elem_read() warn: potential spectre issue 'kctl->vd'
  sound/core/control.c:939 snd_ctl_elem_write() warn: potential spectre issue 'kctl->vd'

Although all these seem doing only the first load without further
reference, we may want to stay in a safer side, so hardening with
array_index_nospec() would still make sense.

In this patch, we put array_index_nospec() to the common
snd_ctl_get_ioff*() helpers instead of each caller.  These helpers are
also referred from some drivers, too, and basically all usages are to
calculate the array index from the user-space value, hence it's better
to cover there.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/sound/control.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -23,6 +23,7 @@
  */
 
 #include <linux/wait.h>
+#include <linux/nospec.h>
 #include <sound/asound.h>
 
 #define snd_kcontrol_chip(kcontrol) ((kcontrol)->private_data)
@@ -148,12 +149,14 @@ int snd_ctl_get_preferred_subdevice(stru
 
 static inline unsigned int snd_ctl_get_ioffnum(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id)
 {
-	return id->numid - kctl->id.numid;
+	unsigned int ioff = id->numid - kctl->id.numid;
+	return array_index_nospec(ioff, kctl->count);
 }
 
 static inline unsigned int snd_ctl_get_ioffidx(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id)
 {
-	return id->index - kctl->id.index;
+	unsigned int ioff = id->index - kctl->id.index;
+	return array_index_nospec(ioff, kctl->count);
 }
 
 static inline unsigned int snd_ctl_get_ioff(struct snd_kcontrol *kctl, struct snd_ctl_elem_id *id)
