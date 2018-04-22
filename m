Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/49Q9jGXk2kIv0rV+ozpRlEenNIyaEQG63sfiVvYVYTfdFYe5gCu277taZnSvDN3s9m4gV
ARC-Seal: i=1; a=rsa-sha256; t=1524405734; cv=none;
        d=google.com; s=arc-20160816;
        b=bDu96zALqAv8pYmIwEI0gpX3eSeq7L4pifrfrB64fMMpaa+Ttc5C2tJgZCmmDFyfV1
         C2eaIxdHiK/GU6QqfkmgqQbObZBE6nqEGFdQuTcsHcRfiIVRhARmrVc6TN7IYC0uNhwo
         9ZMFhKpCVHxyYeYyaitBukRpEuv0nA97CZZgD4Sk7VACz3Wecy5rvbO58Eu2VHNZ4YjP
         zTosJJ46un9wbCUdTMddodv6tLNsSjaRp+eLyLaezXjL0ZvPuOh67rDbav8QTwml4lBU
         k4B6wE4x48saZBP5OR/81Sz/I3vd+yt9g5Vg4GOIH+wHvQ5RpAE5a7yrZCEdo39gD7sp
         Pnuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B0Fxj6Nk09kPH+w974GmPuFqi/JZP2bwlk1bu/LNCAw=;
        b=RJR7qlm58ywN5hxaRkVGjw+KfbZSop5Ic+BjIQZQSUXvSA9sJf/SdgLgKj+NOCab9l
         YI285fxhBBLWuuZv8uRzYV/S8+M39Zym1tQu4EhieL0A1nJuQJvQ/+8D4hP8qx0L3kzM
         YXaajpjuR077szxV15IdD1xl6244oDvc+r/zbpNqzmTI17tbox93IUlYUfK8zH32epUU
         w/jsEJ8av21O0Qw0Y+PArm9uU+YghZ1PqIPLknmmKboY4GqfxN+ACez+TB9y/N7O2+3I
         foDpdl4AmkXOYT5fADIEuW5Hv7UyQ5k2Gs9hPZRFAa1sR06m/kUuY7PiBr5/8b1qZUuV
         rQBA==
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
Subject: [PATCH 4.16 158/196] ALSA: line6: Use correct endpoint type for midi output
Date: Sun, 22 Apr 2018 15:52:58 +0200
Message-Id: <20180422135112.394068094@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455267717959842?=
X-GMAIL-MSGID: =?utf-8?q?1598455267717959842?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
