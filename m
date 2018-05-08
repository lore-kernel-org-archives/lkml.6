Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoEN3jlRi+ILeg68/RmgdEV3VmNjCLMXlaaUT9P6XS4GWZa1e1xS6GsXyjdlT4bQB5508BW
ARC-Seal: i=1; a=rsa-sha256; t=1525767228; cv=none;
        d=google.com; s=arc-20160816;
        b=IOPrpz8Ux51cdR8uSunMDYmmBD4RBubG1q5D29uwNz/lw2eBlqFbAKoJ0awf9Q7E5s
         SZLVK9pgOG7FNQ9QgIyEeWlfOuOa9V1HFkH+f9bMrdUNUrygoiwZNYYOg4Anvk1gYH4n
         cvNqKnbQNzU+hnbaBca2wc+81DC4LO8+LF4w8n84M68nM2HLhdfg78NnZ8Dj2vb+Vlp+
         3o0rrXYj+zaTUcfs2thg9oJw12xUsjREMuKA7YtWbMWOrkTad/YIIQZtwxF5UGpC3hRw
         w8KtO6rr51tiAQokBLXqapFw9wzG7hFzTHf5pNJoQyNOhi7OpWfeinvT/S7yUVfYfttR
         iV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bONpOXDZg4hmMO4CnFeR5dMjtKVlZq/AVR2BAk1998U=;
        b=p81jJQlORtsEYeHHkxidcjF6w70S0w4ya2pOUf/iwrWaU+m4H6WiJVQGFcvI6jog2v
         ejxkMPsTdGiWbgECfwydgTwEGcbkZ8zJD2B6bIIBbqsCulsCFFAsPpZ/t+gaParwmKYY
         6FtviedWmbHacnSgIvEwMFbwIVQ4NB4r5G5bAhNYYS9InUAQoe0Egfv123o+Zel6I6Qs
         n+syhFkmZjI8ZHGR6llEoyXh+IEjujzMFDWhPrxHtPfHUty242OL9w1DOgNNIzTTv/Z6
         ketA4lCwFYYoKpIe4WWv3uMfnLwIvADb3LkDYxhCg+gtul6t9xZuOkaZInUL+myWUYE+
         wbaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wBSXfz5U;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wBSXfz5U;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mayank Rana <mrana@codeaurora.org>,
	Jack Pham <jackp@codeaurora.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.16 37/52] usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue
Date: Tue,  8 May 2018 10:10:35 +0200
Message-Id: <20180508073933.303811611@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882897810276471?=
X-GMAIL-MSGID: =?utf-8?q?1599882897810276471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mayank Rana <mrana@codeaurora.org>

commit 96bd39df29c29d348d65311e5954c0b7d3a2a790 upstream.

dwc3_ep_dequeue() waits for completion of End Transfer command using
wait_event_lock_irq(), which will release the dwc3->lock while waiting
and reacquire after completion. This allows a potential race condition
with ep_disable() which also removes all requests from started_list
and pending_list.

The check for NULL r->trb should catch this but currently it exits to
the wrong 'out1' label which calls dwc3_gadget_giveback(). Since its
list entry was already removed, if CONFIG_DEBUG_LIST is enabled a
'list_del corruption' bug is thrown since its next/prev pointers are
already LIST_POISON1/2. If r->trb is NULL it should simply exit to
'out0'.

Fixes: cf3113d893d4 ("usb: dwc3: gadget: properly increment dequeue pointer on ep_dequeue")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Mayank Rana <mrana@codeaurora.org>
Signed-off-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1424,7 +1424,7 @@ static int dwc3_gadget_ep_dequeue(struct
 					dwc->lock);
 
 			if (!r->trb)
-				goto out1;
+				goto out0;
 
 			if (r->num_pending_sgs) {
 				struct dwc3_trb *trb;
