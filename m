Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/cjJUpnTn5PhTk29zrzfRoFjzwa0ajnXo9J8TWaeijMwPZceHgbCsDnRsKppTlicmsvh0t
ARC-Seal: i=1; a=rsa-sha256; t=1524406789; cv=none;
        d=google.com; s=arc-20160816;
        b=QF3r0FfZ1NTIJ/jtRxdLNX+fQk9gqqqfWmDfR/ih4XQKPbpbXn1eyJSoM1j6wKuthy
         2Kng/btSB6KB/9FbnkOzuh4YDpHyECCDO0J/XflptfFOcYp2ACaJCJRfIpEQLUnaCG6v
         gsvaXs1k1x9jXEUKt1QtdWR1wxtXLFZSHEjS/SzLEPzFEoi2b1FsyxuA4wIAMALBOp5N
         yXAxZgSmKz0NqQ5Ld60LHeWD7snbGj9l1bZMEMyvJmD/GiBOgoydoajT6KzeZW8Oxs2H
         cKSnOfk6H8kG+zTdWJw1gZDiMvnL5XlhlVVc6RQDFdqk+pgXziA7RDFBOzfT/o3D2ksp
         XipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5olQsZl5pmXQ5EDUjh3dB4/r70bnBdgIXYWaHhUcnd0=;
        b=tebxm5WCnFywZ6aje9WzNH/FnV5CIRNDpfBPavWThAeDBaFokke98zEz3E6TI9Mw01
         6MHlhuG5q/sEfosmCJvPDnR48LhZiaOklPCLEK6bEBwshejPHktPU3QBYKdVkYt1pfWf
         rSfuwiJY4NY0AEqgo/WnKN1TAl4IfACeNVKKkYZlIQt0AeV7TY5EuNPNHG1SAIrMMG5A
         7CaTaHJsilFeyRaqjkQ/062E9gYb/2neh5V1brYxKtgQGkbZmOCnswIBVhi6zgo3oXRj
         RU8xonUWRbpepTeKNcTZx+0lbye7C8BkXCIrv88x6l8jQ6bvKPA+lp/PdcipfgCu74jL
         s+Bg==
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
Subject: [PATCH 4.4 78/97] ALSA: line6: Use correct endpoint type for midi output
Date: Sun, 22 Apr 2018 15:53:56 +0200
Message-Id: <20180422135309.485150340@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455267717959842?=
X-GMAIL-MSGID: =?utf-8?q?1598456373291056315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
