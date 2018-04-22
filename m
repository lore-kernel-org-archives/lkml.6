Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/uivpUwKlJnD5BkHLRm6L8RRgZZKtule4GKzDWpQTm2W/EPnJyhahc5oondbYjeRzwZLmc
ARC-Seal: i=1; a=rsa-sha256; t=1524405370; cv=none;
        d=google.com; s=arc-20160816;
        b=JoARpNzwFj/Yj5tysEV7aRgg4vk2xKrftC0R/isAoE3Ul0E8+NQBsPxZ1AwA0A9CF9
         zQlFI4HvHIS102EAhhThuiqLp2NpTteRsc5nFQlaCasGlasagS68oJ/iUJhYo+iYikAE
         gVKTFZZQdOzLOZUl2oAUHntpWY75efJVPDazuTfgqq2pXkZFwtIWdaQXJHjtY3wJV+sK
         4FIEvohMnGsBeKcQZpsxbmQDgcoxM4lwFr0Bq4Ar1zkzXVkS/kYjiqN4j1kASY49gvSb
         WN0YvawoYfrMIHq6q0XNDbChtrjCoG0dS2r2b5qgh03M+P4Tt5nPoqrlvQySoRhuyltQ
         TpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7dB69dvaTI7SGW2cgmdPXn51waSYnpoD90XMsz8zOGM=;
        b=y1OsBPbtAJnwzNXon2xSH6GuM7mI17plN6gkmWyjNqm5YjBNnS2DSAFwYuJueZCWeY
         2T3goyq+opEw2z2QNZklRU8mS896STNs1oV1LvNnW2sMvGPbj7KTn55XhraSFI6S3gCX
         I5eihFUlGI02A1La8wVRkWXWJQAVefUglDds6IF9Fan3Zijzi3PT8Wo2pmwdJqol7qbX
         q9Uxvrf/OfMcWwMfzDxYdJjJDcOb6PwV1xIRNOIOSeHvR0HO2oFaOAGmkbaityxZGX8k
         ppnzq8QV+on5jf6dCN8uOXzWMM0gRvnODRAlQubCi/iTJqlvHbKnRUWVNpM4qrr6zmEi
         xC+A==
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
Subject: [PATCH 4.16 040/196] USB: gadget: f_midi: fixing a possible double-free in f_midi
Date: Sun, 22 Apr 2018 15:51:00 +0200
Message-Id: <20180422135106.154436732@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454885662324670?=
X-GMAIL-MSGID: =?utf-8?q?1598454885662324670?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -404,7 +404,8 @@ static int f_midi_set_alt(struct usb_fun
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
@@ -61,7 +61,9 @@ struct usb_request *alloc_ep_req(struct
 /* Frees a usb_request previously allocated by alloc_ep_req() */
 static inline void free_ep_req(struct usb_ep *ep, struct usb_request *req)
 {
+	WARN_ON(req->buf == NULL);
 	kfree(req->buf);
+	req->buf = NULL;
 	usb_ep_free_request(ep, req);
 }
 
