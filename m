Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49k+wnLpO8QjbqvJpRAJGH8HLI84eW4p7srYE7M0giVmODXHj68Tg6f9IxCvGf4SeeXYpvi
ARC-Seal: i=1; a=rsa-sha256; t=1524406435; cv=none;
        d=google.com; s=arc-20160816;
        b=o9HWv20GoWNV0v5IOZBIp+3T/SPDi7tAxUtrCJUh3t+3VCq3gXRR8xImEqNn30cyjA
         BV8lEuzoDrinwBD9OmhjfaN8XjbWHEFPRcTwWC63o/2HFiAcTzphTiqCGRihdtsqJUGq
         +IxAvTG0lsiNk4pgW436EOdwQELbtMhRcqpdK+JL6D9t8tcJ3SIyBVG7m99DED3aczgD
         r8l1xcHoc82yZpGCgsrtc5vfznxb8dxlsQ30zB9Qzv3r9A+ZJyI+oBh0qFtn0aoNiy4B
         H4yC8U78HOpPKUYiGxSaA9swxGk3Zf9SNJYD5nNCZremt9IrlMr2SxdahjXwmzvttUmC
         DloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CQfTuh3ZMgAro7RTYOrqu1ZU8j0K8DnicKRROroeMEk=;
        b=UtrlRIaX2SQ6oyun6q8hgW8jgdzgNVnaDt7S+YgxF6nbJtfj9QDv2AcS6Xr5BwevfY
         S1GM3Tm9KoTQ3pSYv5deg2oMcKy9QMv4U+3c1YJFTg8bKCmzcaGrOL6NjLyXke9pKeyE
         Klug39z78ZoeLDCzOF7iIiuBMZ7LGMQPDskMYo+q4G8kcW7YBjwx3cqov4QTqda3M4Jv
         N6m+ptCIcWyNzEA7dHe6bjYFVRvmhYk1t4cov8MXo9br/sm5PImePtvNgh2C4AIBRQpS
         sY1Pru1FsPPAP/3yMt8G6fphqdOVeAJ8QbPfT0v3fsEWUc604CoLvr5nAjJpeXTwvJg8
         /hwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Fabi=C3=A1n=20Inostroza?= <fabianinostroza@udec.cl>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 71/95] ALSA: line6: Use correct endpoint type for midi output
Date: Sun, 22 Apr 2018 15:53:40 +0200
Message-Id: <20180422135213.335563003@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455267717959842?=
X-GMAIL-MSGID: =?utf-8?q?1598456002405763078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabián Inostroza <soulsonceonfire@gmail.com>

commit 7ecb46e9ee9af18e304eb9e7d6804c59a408e846 upstream.

Sending MIDI messages to a PODxt through the USB connection shows
"usb_submit_urb failed" in dmesg and the message is not received by
the POD.

The error is caused because in the funcion send_midi_async() in midi.c
there is a call to usb_sndbulkpipe() for endpoint 3 OUT, but the PODxt
USB descriptor shows that this endpoint it's an interrupt endpoint.

Patch tested with PODxt only.

[ The bug has been present from the very beginning in the staging
  driver time, but Fixes below points to the commit moving to sound/
  directory so that the fix can be cleanly applied -- tiwai ]

Fixes: 61864d844c29 ("ALSA: move line6 usb driver into sound/usb")
Signed-off-by: Fabián Inostroza <fabianinostroza@udec.cl>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/line6/midi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -125,7 +125,7 @@ static int send_midi_async(struct usb_li
 	}
 
 	usb_fill_int_urb(urb, line6->usbdev,
-			 usb_sndbulkpipe(line6->usbdev,
+			 usb_sndintpipe(line6->usbdev,
 					 line6->properties->ep_ctrl_w),
 			 transfer_buffer, length, midi_sent, line6,
 			 line6->interval);
