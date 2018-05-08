Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqYZtQ5slepdi6NBPnDhRwdLkeFHolNK6ClekI4foEAIaIN5FVZnSGoKWyuBbahergbewJi
ARC-Seal: i=1; a=rsa-sha256; t=1525767383; cv=none;
        d=google.com; s=arc-20160816;
        b=i1dH1e9z1Y5YnaDOmjdk/9rDgFOdgPLonPs3G5Ke75ufQ89dsDAHImH+g8Frj794WS
         nSx2s+gbNNGppRynePxatXer1I3y88xhCm/LAZJLQdtv2nWK8EPpD0nNubNPgdcoE/Jm
         y9qQDH0WDsAKS7HeVDMoPyJbpwv0ByXzW2kSZkiKMr0zGjP1/yniOHINt67w2afiHXGj
         sZS0M6ffmnMn8ufk5vMJy4LEbUjTjhNA8AQquVc0s4Jo+T1dzc2eVoWKDxhQvxZqIwaH
         Sp3Cg586AAdo8Q4Go9U4KPQCZEXh2sxw5Y/cYmsCpkWi1X5FS2BHyzU4NXu67djimCTo
         fiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=qeXDAzJIfDU8VFiiHLbOFJQ8JNTnhDIGQwlK6PsLHgo=;
        b=dixVW2ipLK5mBydPIePIWmzM662LSCgRCE+z+D/2+Z8arekBk/+KGItaylc+apfyC0
         G1dDU07sIEWlJyHJK7p5FzDWLutSHArSioioaL9ghfPkHiZOrK8iSOcd4hsqSRpoCooM
         h1UMivWgVT6HrHWybUfeZ45f8P+I3QNw2SHoWyNF9/7zTyCQG8TVGOO8aMHh8JzuxzgV
         YkxZpwSzH8DGy1b9BBISqC2xZtjkJP6SJ85qsrW7h9cN9L9g8VOq5aZzFC3G0v5AshtS
         gLyEoxW36pk06qPJUko7HBGnf3XOof6h2feeHVyf6KzLzkeI9a0DTnuoijWpZyejBZ2+
         MFoA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=w0feZLli;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=w0feZLli;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mayank Rana <mrana@codeaurora.org>,
	Jack Pham <jackp@codeaurora.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 35/43] usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue
Date: Tue,  8 May 2018 10:10:54 +0200
Message-Id: <20180508074009.451735824@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882897810276471?=
X-GMAIL-MSGID: =?utf-8?q?1599883060015289256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1444,7 +1444,7 @@ static int dwc3_gadget_ep_dequeue(struct
 					dwc->lock);
 
 			if (!r->trb)
-				goto out1;
+				goto out0;
 
 			if (r->num_pending_sgs) {
 				struct dwc3_trb *trb;
