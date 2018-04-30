Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqcTlZWIdqSwwBxAXNeAwlc7IeokibVI6waHGIL+SLP/iXtCM3iPMC8C3NHFy3JTCF25+gV
ARC-Seal: i=1; a=rsa-sha256; t=1525116231; cv=none;
        d=google.com; s=arc-20160816;
        b=VTa90o0+x8pOfPpP9dhX+zq9xTcVyMjUcNdF6rK8GTSebGHXd6QsX4TZNlBH1vLqVT
         Zlw+it5lt+38NkmB3qI72LoGHFaE1n9LKuKc9TibAetxMghrA+c6g9Zpv1eUKjxXfXqo
         mGFwyGzT6EBKtGNpC0+c8hVq12zj6xhIpkjF2ZPkRYtmPmV9Y5X4Z2fDw1urswU7WZnk
         G2PndiUZun7Ff1tBEtyFAZ62lpuYThHK5lpSVxE0Yz1GNzQqoNKMkJsERiQljQDqfIvg
         nxTenrfNBW2VJ0aA7bPK2dO1pBe9FxPUTcF/+WnrPWzvV0OOVAQQxE+idihFXXYfw7KE
         l3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=m3E07HIBRzBit8k24GZ4oyyLbkv1n6FTy6P3m7NZsJU=;
        b=fVxIhyt633q9pKvOKk9F9zuXiSFSLicwRgNy/Pj/CUmply99aRSSltSkcnoDiZlzdJ
         dt++J7un+tc53+agOz7mWecUKUKr6jsnIKJaoz3myrk5GBkKhwgtqfFW8+kD/e/PF26A
         ctQ0jEyMioJ7oG2N7fCNLeIJkFmd9w1WFpOzxemqKfp0pSCn+6Lvrc3Ad68H0Inao3Cm
         d6KX0iwD4CJiqxE+KbyjMTCQmBxwW0KqkZl/K6Omw2qk5E3kFex1L+rImNkX/B7LZ300
         5rkR+b/FwsD2rxElbyjtjEWpDm7D1prVjjnkXZ4+zhXw5QEvUX0xSpLyueLuYc+upRE9
         k3uA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F8822DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 10/25] ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
Date: Mon, 30 Apr 2018 12:23:17 -0700
Message-Id: <20180430183911.244353411@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200277633443997?=
X-GMAIL-MSGID: =?utf-8?q?1599200277633443997?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -353,8 +353,11 @@ static struct usbmix_name_map dragonfly_
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
