Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/AkiaP/NBPUc7maBGi7ikIibEgcSknX/Bof6fBTJCSTcv4TptnQ1TRjRT2ykHLY8DItWBK
ARC-Seal: i=1; a=rsa-sha256; t=1524406300; cv=none;
        d=google.com; s=arc-20160816;
        b=0fLV8MujfQEu3ExNnzXbqYJWboOP1d8/m07FEaEcEaEVOxelC0L+YeFRq7LLPCl+ju
         22xN978pQAEZRb3T4mL4k8O1364BZCUHGifoGMXOyERvJ3vta2WZYftrSq/0yKImwL4d
         XbmTQ1mMMsrCm/lX8/R5/9uWrgWI2K/Z7MSO8afN9IIoGXE4f1tx+QWrniNorynEyMQb
         jl1k0rljIHPVB9qEFW/W7g7DzLQHvPM9INL6QmJnort7z5HLO0wltJo6k0saIo6cTKHE
         NcY61uLLPLAJwmqdhKR8qOzg5H0cqBZ3OaQTo4a8ArvWYgKHdfIZ6K3vtGSLH6dbKeOX
         wz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JR7DsSgJe2xwe1v58mQHtYb4i1g8aGgMjBfCIOiuykI=;
        b=N8E0PibTZDCgXg6zldCVDtguZX/9N5R+EiMAhMCj1ciHPA7bi4+eR8cbNbkv2CeO4r
         kYZqFI4UY3QquP8W5Vvrd3ph5tFsF6Kl6arT7xO1sX7IurlEKk6GANQaNtt19EaM7n2A
         f0/KZhbSUDywxG+NRR3Ow8b7supqHSj8UBZfJ3R8H15f1vgQChVOXHtx6L5R40X1n17Y
         BF6mL66MjG5o489eTnJDDERGri9ydS/IRyLp2Ob3tq/GcyHJHqlFu5q2wT0fOEtULex4
         IVFES1D0Uwr/QgNm4vIjZbXpVJsgAqk2H7K5MsSPo9hMiehHmOndIEQvRnbO5c4tgflm
         M0XA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tuba Yavuz <tuba@ece.ufl.edu>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.9 20/95] USB: gadget: f_midi: fixing a possible double-free in f_midi
Date: Sun, 22 Apr 2018 15:52:49 +0200
Message-Id: <20180422135211.266586357@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454885662324670?=
X-GMAIL-MSGID: =?utf-8?q?1598455860869216067?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yavuz, Tuba <tuba@ece.ufl.edu>

commit 7fafcfdf6377b18b2a726ea554d6e593ba44349f upstream.

It looks like there is a possibility of a double-free vulnerability on an
error path of the f_midi_set_alt function in the f_midi driver. If the
path is feasible then free_ep_req gets called twice:

         req->complete = f_midi_complete;
         err = usb_ep_queue(midi->out_ep, req, GFP_ATOMIC);
            => ...
             usb_gadget_giveback_request
               =>
                 f_midi_complete (CALLBACK)
                   (inside f_midi_complete, for various cases of status)
                   free_ep_req(ep, req); // first kfree
         if (err) {
                 ERROR(midi, "%s: couldn't enqueue request: %d\n",
                             midi->out_ep->name, err);
                 free_ep_req(midi->out_ep, req); // second kfree
                 return err;
         }

The double-free possibility was introduced with commit ad0d1a058eac
("usb: gadget: f_midi: fix leak on failed to enqueue out requests").

Found by MOXCAFE tool.

Signed-off-by: Tuba Yavuz <tuba@ece.ufl.edu>
Fixes: ad0d1a058eac ("usb: gadget: f_midi: fix leak on failed to enqueue out requests")
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_midi.c |    3 ++-
 drivers/usb/gadget/u_f.h             |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -389,7 +389,8 @@ static int f_midi_set_alt(struct usb_fun
 		if (err) {
 			ERROR(midi, "%s: couldn't enqueue request: %d\n",
 				    midi->out_ep->name, err);
-			free_ep_req(midi->out_ep, req);
+			if (req->buf != NULL)
+				free_ep_req(midi->out_ep, req);
 			return err;
 		}
 	}
--- a/drivers/usb/gadget/u_f.h
+++ b/drivers/usb/gadget/u_f.h
@@ -64,7 +64,9 @@ struct usb_request *alloc_ep_req(struct
 /* Frees a usb_request previously allocated by alloc_ep_req() */
 static inline void free_ep_req(struct usb_ep *ep, struct usb_request *req)
 {
+	WARN_ON(req->buf == NULL);
 	kfree(req->buf);
+	req->buf = NULL;
 	usb_ep_free_request(ep, req);
 }
 
