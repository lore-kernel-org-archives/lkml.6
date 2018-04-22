Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49LHoymZ2WZP7QYCR2sehCzEypnmIqrIkq3W18J2bscTC9jy2lOenAOtV6xjYZRbrs1N2y0
ARC-Seal: i=1; a=rsa-sha256; t=1524406142; cv=none;
        d=google.com; s=arc-20160816;
        b=WbsgDwqCsGKtnXfwqakn2aMXIEyxNGkAvPC9mQgQDz15rDXWeYnJw+dKrREU/SWVdo
         LyT6+LOm+7mkkP+/2IvtcXXgBGD/LdgeQ4fHL4giYYf5L/90mUuY5eArQ5DDFdgaeH8o
         BOSlPs0sDgeHKQhC02byYWidU9M7GtkcTRj7i6rMgUTvP8020Cb9juxEIuQBs7GWQSLb
         1bdqklqLn6iuTQlVac2XtK3YyIO0gQyAPxbL0Gq+kvbJjiKDhF813dWisPv9o6goNRlH
         DcQwv7iwKTeEfZgHA3nWruuRzUplpHd0+uiDx3Cf43M60JIIH6VVCEMsw9NSLF2gsR1n
         iKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+JA6ba6lD2VF38yIPe4lrtPTtAx1ASQwyOCKYR5mDlY=;
        b=I6afoTNHX9eKW/uQA/H6Nc7GsolTxNcDZCfxfSVDNEy7yfKmGXjHMCwQ9pHzgOP/xV
         yZ0bmLXZJMpC4x0UjCwitWwXgGYtZ0apwT7pPPUWKGoGZxc4ygSXqxwb6G6AjZNhW3VT
         +n/4NMNK4AXYAy4vPYbKnIcsnOU+VM3Rf+qWV13HJGVjOxXVORaBw/MakYpH76evUxS+
         SJSZwcpZDtZMMu8FriIFqcZNjIx5OEKVf4H+Ctk5Irh9kbBqXNFDirrtCBEhcJC8yQFw
         qbJONrNgg9AleY7q7+xUungoH/d5Jr4+TIScLVi1o2CtJFljMvYwIAFvf+AYIguQi9/C
         VP6A==
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
Subject: [PATCH 4.14 128/164] ALSA: line6: Use correct endpoint type for midi output
Date: Sun, 22 Apr 2018 15:53:15 +0200
Message-Id: <20180422135140.627750467@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455267717959842?=
X-GMAIL-MSGID: =?utf-8?q?1598455694760813149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
