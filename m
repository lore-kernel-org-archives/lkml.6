Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqe5G7cufAJ6I+lgPuDJ7OMWLPDVUDf20sdzWm0PbXLEXjEvfJBY+3C61iX/d7VNeVJsOGp
ARC-Seal: i=1; a=rsa-sha256; t=1525116346; cv=none;
        d=google.com; s=arc-20160816;
        b=gW4bg+jrMOchplaE+y+8ZznAXEINcTGsZk1HvitcdfgTiAyl9snZuvDBIxqnRzAuc4
         +7BwgxYFHk6Xci+zQ3dc0oGy9LZiI4fquOpS2f0j2gxZdWxrMJQoIBQZ2YbFRpzh2sfm
         ck73oV93+CFI48NHqdg7R4zltKjnT7e9Kb3XMWsHDdpsZKUuEMs0rS6aYbVrpMBdd1CF
         Kfcu3Zmh/XSOfnr17lRQHijeScXGMLlNkh/13c1JPnlcK1AdkcMpkVVlpZFFsRLxUOcC
         Uy78UVP/hf/8ktFIcNWFRJb3avfbU10hbvxmIceq3jStNleqrixEEB9q2K6tH4w4cbpr
         h0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=SnRVlvChUOip0/mS6gPKmDiTg52hsS/Xc5WRqp68Uj0=;
        b=Mm/NuC0ay2q2vnYjAh71dx9KJYBI4I3ELJ/qFeLVchDyvEVyyj5o2G16CM0HFaUxnm
         U2XF7w8yTuKaxzO+ewl2LogCD0ErUL4uVOmUYvD1ST2nuYtKOCwcC7pdrzUxXGlXBcfX
         cJZZkFK1/pxWlSPyfb1SGWXMbftRws506ed4oU4iQh3CvTBk1oQGsaL2VKi8zK8QBKWK
         e7kjPhbjwhaks9wxRS6pOsF+TubkFQXq28hQkNkijzCGaqfvpYpsR9RuGiuPML/3pROQ
         xAzjTNGUxIiUz1cmfOVtUJuJbgYCyrL3wvB3eXVhsvjJttntnS7E8JsbGH/H+CNw3DUc
         6JdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C002922DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 12/44] ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
Date: Mon, 30 Apr 2018 12:24:23 -0700
Message-Id: <20180430190946.832458154@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200277633443997?=
X-GMAIL-MSGID: =?utf-8?q?1599200397474452471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 1d8d6428d1da642ddd75b0be2d1bb1123ff8e017 upstream.

The Dell Dock USB-audio device with 0bda:4014 is behaving notoriously
bad, and we have already applied some workaround to avoid the firmware
hiccup.  Yet we still need to skip one thing, the Extension Unit at ID
4, which doesn't react correctly to the mixer ctl access.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1090658
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer_maps.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -351,8 +351,11 @@ static struct usbmix_name_map bose_compa
 /*
  * Dell usb dock with ALC4020 codec had a firmware problem where it got
  * screwed up when zero volume is passed; just skip it as a workaround
+ *
+ * Also the extension unit gives an access error, so skip it as well.
  */
 static const struct usbmix_name_map dell_alc4020_map[] = {
+	{ 4, NULL },	/* extension unit */
 	{ 16, NULL },
 	{ 19, NULL },
 	{ 0 }
