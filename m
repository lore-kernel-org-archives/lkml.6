Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpXkQjDsgYL3ObXH9LXWGo9B/eh/cStH/rLtkUkCPKDeEFVQjbGBdzChziBRDI2UvoHoOA5
ARC-Seal: i=1; a=rsa-sha256; t=1525116423; cv=none;
        d=google.com; s=arc-20160816;
        b=IBQRAWynRSenrJPYd0MQvywqS4C3ch5xiw03TeZ6O9RyVZuZ2JzlUJnLF0J2/f6mG4
         gH7acvPhV5vCRvxx/fpAgWuWCYLQLMu/s2xj5gg6NJ7nCPmaf8mkYXxyTKqQ5uTRC4eD
         YGh8UEavR7NMEjKMxQPCytLhodoOgiU1nJxE/hwdnzGi+CLTVwP9AEwZiIoJySc5c5W2
         nkVwk+SadbKRdOtkbUmtEYTmuACF91j3BXrQgi14WPkaBAR8AW6lN5Ycf5Asg1K/bmgl
         yAWAPkMePRLtDT+pMRMALeJ/qY+EEZbTGNo0kO1q3l1DGwLJpXa/ASTY1H69oRR5B4Bs
         EZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=IMLsJvlVxnmCLfJLqEZ2uz5m3AxwJ262IQxzCPc/H6s=;
        b=KRm7OthjP2KASe6uOJ1QVjQ7oKI4KtyI1vv+ZCdzq6iIUzjN2JmrAbzI2ACbGZ2ZI0
         AvFVlo88sn622dG/o7HH3uS7bnOgFQ32gyngpFHLxPLEtUVkLEQ6LtWd0D2Xrv+3h/E4
         Ua7Bhw4v4wTKSMpiNYeW6Zzolj9MLD7hoUbMIQTsHNNVVKFhQkJYQdSSZX3oDVH2ofBS
         4lxC5b24m+w/bwMRam2PVTHkQglbLjxoi5R2SXuaOgtjn/ytNIIK9qqw80B3aU845nM2
         tiTG1s8tQ6njxlWkj1KBHGE8s2R784cH3VLK8R3HZqyFltmM93E/HcP5MIvETKMG9XTL
         UZKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9CE22DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 21/91] ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
Date: Mon, 30 Apr 2018 12:24:03 -0700
Message-Id: <20180430184005.310920638@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200277633443997?=
X-GMAIL-MSGID: =?utf-8?q?1599200478088638450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -353,8 +353,11 @@ static struct usbmix_name_map bose_compa
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
