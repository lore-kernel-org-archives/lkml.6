Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrGyWgVoLUtJCzYjX+jGEt1piZxNo1qjd4TL71NRxr1F+Y8sRn4s75HBgZz4xS5iqJKr1LQ
ARC-Seal: i=1; a=rsa-sha256; t=1525116482; cv=none;
        d=google.com; s=arc-20160816;
        b=n4XsdJyHyjgb2Q+NTIMq564vf6W432v9BR5hthJeUE35se33E/7j2gL53NummumfXB
         gbDnNJ0FIghgy8GrFCEYC0/GLX+xYa2FW8mbOFLwJcjh7dAhYy8I/VBBczdyNsIvmIpS
         4KOPbgejxiEmKwhAZa1QMfAjGffiOhWpAgmQs0dRVLz6odemY8f3oDKjFE+ohPqDhFzF
         OpgCNsgfoRhBjkk1LKYx9uDMO7IPT4Vn3qSwvyKJiH56WRDL66zYjFCQ8Z5jcqWnqiyS
         pBZ0/c9qzs/ZTeUXK5ebTGuBgbFUvuTyzYZ4EGZVtN/1zZhtdz6Ga51qN7P2RWH/7E63
         24SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=cdNZ6lqH9SUMLi+t0cakE2yiTQPsSm6zEvEDjH5tp2A=;
        b=h3e1o21VcB0pPL5dQYQYa1UZ1l2PnvKEeiXV34w0+YVvwhc1/zziHrWbQ8sQOtOikT
         9XBTp3RDXq8zEX5gIq6j/pr7IVx2O0IgijhZ/Klc0zJBAC82sg32E0pkgFQp4oeBnzFK
         hWphg8zj3aXcngb/E4xESuMZNNOMa+2z8/IE1tQ/H2CoVRXF/lFhY13ow3U4SIu//7a9
         iLu7wugeHX7EYoUb+/wA9YyKiZfFv7UaGhGA9s2+AYJJf1LCukny3x6/v9jVm4NIBw7O
         nkLGLHSYwzmDR9FHxJRLrnabtjNqUevoL9MR4DijJt1RzIiA2Qp38u5K4vSSw7wyw74D
         mnqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8521422DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 023/113] ALSA: usb-audio: Skip broken EU on Dell dock USB-audio
Date: Mon, 30 Apr 2018 12:23:54 -0700
Message-Id: <20180430184016.060258378@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200277633443997?=
X-GMAIL-MSGID: =?utf-8?q?1599200540317831382?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
