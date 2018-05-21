Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoonKaMVoP2GOfQE25zY92UlZFp5oFbcUffk4sGnVnxBclN26K83389Hlqz/IzLKatRZRZo
ARC-Seal: i=1; a=rsa-sha256; t=1526937264; cv=none;
        d=google.com; s=arc-20160816;
        b=IttkpEqhIKWN/JtYYTcDhg24UEHrMRx73tobOzdCrqF0N26/NnjEIClZnk+ivI/OH4
         pXRiQyS1NjwZww4w3AO3G3UoQPqvfZQPMGHmJhNAV3hbWkH5fCHwyob8PjiWVNurANsh
         9YdcFM5qaNJV0DMMxR4DELxfah/l49Oanqgejjje1dSuyz4G/7ZulXFDiERGYznxZkd2
         6ftVUiMdu+QjWZ8csSleVjczAaB5eK7b+60qDi1R3Cjc/iumh5ncCR3bVNxEeiHX4wXx
         yWIYwiT0b+uT75MY5fahdJw7H1MtVQbyCgsuyC0rx6glx8jxOvQZampPbWdb3DbkXC/A
         IRJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6Kzzn/yLLA9c2wL9DKU/MOyTuWeEAOiEK4S///iQyXs=;
        b=lGOdHkbNFshA7JDv4uGV1qO7LegNLz4rUNzfr4G+ZuARIOSU+UByANMmdD7p4ExDpA
         PkF7V1/4VgTreZ3VIePcl9l6Z5EiOw5lytuwSkQ3t9FsZ9Gus3FbJf1RNNjloFbWolW9
         nrofUIU6EUFpg3UGGMqyoCX4elbavzlUzrQ3QP7kkQrU42OQVjFkDmO2lfLLWd14vU6K
         VMoJHxFmH2vBQQLk5+ay5S/2GPAj5FVyPBfAblGucPL+DcmNizCOc1T0db8T7nEShmgy
         UjUVBpJA6eYAwamYuUojW4blT9jckeaH2SnimnQY4vYfbZfxhnJkPt1d3LxFjZfwafwx
         7UHA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JiWGYGPc;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JiWGYGPc;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Federico Cuello <fedux@fedux.com.ar>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 06/87] ALSA: usb: mixer: volume quirk for CM102-A+/102S+
Date: Mon, 21 May 2018 23:10:42 +0200
Message-Id: <20180521210420.767686726@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109768849668423?=
X-GMAIL-MSGID: =?utf-8?q?1601109768849668423?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Federico Cuello <fedux@fedux.com.ar>

commit 21493316a3c4598f308d5a9fa31cc74639c4caff upstream.

Currently it's not possible to set volume lower than 26% (it just mutes).

Also fixes this warning:

  Warning! Unlikely big volume range (=9472), cval->res is probably wrong.
  [13] FU [PCM Playback Volume] ch = 2, val = -9473/-1/1

, and volume works fine for full range.

Signed-off-by: Federico Cuello <fedux@fedux.com.ar>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -905,6 +905,14 @@ static void volume_control_quirks(struct
 		}
 		break;
 
+	case USB_ID(0x0d8c, 0x0103):
+		if (!strcmp(kctl->id.name, "PCM Playback Volume")) {
+			usb_audio_info(chip,
+				 "set volume quirk for CM102-A+/102S+\n");
+			cval->min = -256;
+		}
+		break;
+
 	case USB_ID(0x0471, 0x0101):
 	case USB_ID(0x0471, 0x0104):
 	case USB_ID(0x0471, 0x0105):
