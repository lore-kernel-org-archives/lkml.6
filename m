Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo1Hu6M7X7kBBjgV/Huy/2OCOy0DD1DjGuqaKA7mA+2xKZk9rftMYXx8JrE3cj44iLDNtm3
ARC-Seal: i=1; a=rsa-sha256; t=1525116437; cv=none;
        d=google.com; s=arc-20160816;
        b=HGi9qogipyAH2bynZvRSAGEIHS/62IV08l7regyf+TNAe9cp9W3POc8se+ucws1fpk
         WFQ9FiFDRu+aSlnf6DEg2rI8UHOYD6AuajfNO6trlsBtDM1DOb798RASuQZ7i+wDTTkY
         hSkAoSs8dF/SeKCkDeKnJL3Q7RXl0/IBMxTAey+ybk4HZc5OAzl5LsPiLQ+dbE5jNX7A
         h8imUv4c+367yDpnmYWcu35CGnkz36EbOfKnukvhEAbwofdkh5jkujY06nESzmV2JU4D
         YmALwNPd4wwenp+tHD1jUuLw4jzrWuJYVkxizv/2pj7mzy725631ZVM4FKrSAQiIEOVY
         X+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/SfBPMmxVT5b3eRCVGu7QBFK4IXTqYSL7tLSt6HnbqA=;
        b=rW0ZTxR1V3Bjk6kJzerR8NUM0tlg7gu5+Gjj8OAXxfvpSh33xqxaNdK0TjDJ9ZjOKa
         NpSI8y4w8AvlxVtr2b/GZJk+UOMQLlupn+H0DbCiHOjMjJeivWMDcKCDEnWXxByIVTUy
         SvCoDDWC6TOMayKFva1u/Urv+FMmo4uMu99Iw326TvXAzHzgyG/YwoKlL/6h5mYYKJkj
         pwAgjyQ6o1CW7eyp0VrOe+MduEC7oK6i+pKTBvv/3xjSo4/u7zRWWujm6EvBxDhR5p5O
         VZM5y0qkojP0P9TooHiStJ42iCY7hZd5rCSwv12AMiKlrjmcj6D5ZH6t0GX4RLTakwmG
         S2mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBB922DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 44/91] ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
Date: Mon, 30 Apr 2018 12:24:26 -0700
Message-Id: <20180430184006.490057738@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200282251951106?=
X-GMAIL-MSGID: =?utf-8?q?1599200493187490584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
