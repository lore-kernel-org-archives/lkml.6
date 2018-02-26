Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs16fAqgPqxSZSSNlONC6sdh6wSSh8m9uLK9UYW9+n8y9L9QRtehNa3X0CZWUgITUp3UT5t
ARC-Seal: i=1; a=rsa-sha256; t=1519676901; cv=none;
        d=google.com; s=arc-20160816;
        b=tg7pZ/UhV+qGl6OUwNSm2emJAR3dnOgDHEHoTlbFiH4lLBxTEQ5wun5ABxv/joEoNO
         i0zwkoFAmt4slvpRVSqbtlLOdZbBvUL1ZzA+cGX+VS8wGFgOw4Q4lUTbsVSlaC4atL4m
         jC0E9wxItEPTGes4nvUXB02aQu7LKQB8mMB9CfEnVInWcopI4ljHrN80XtIeaR7n3dpK
         Bpk7Y/WBqNEkXhAAEN6BdEI89Vp5dGtPPpZfE262kw6VQ9byR6GiVc4XHczR5y7VTJG3
         ufu1a2AwP+loobmt4O8X74KT53oj/acoNiNFgG6gKZkCns490ebMo8l+sycnPgd3tJdX
         olYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AfD8H/2qlan5daKGjD1jjOVZxi7RktWVG5YbLX6Gy88=;
        b=frmMTRNrOklTue8NGpmyX3FAsM02Nd6v4WB34BkxkJzsy4TdheGihW4UuVgA1IvfdV
         jdVHR8DqgH3CEz9X+vuOjU/vKwQoU5Lr/wQNn7HtEsOTGiR7CCyeErnnz7cwTAOZAnMm
         xw7PrUuor8boMcsd2i2pFNO0xNVS+PCYlPIzpYvGvu3g2EMyM0zuKYfUOwecghbSFakz
         g174gwe5iDQ0XB00LdnNXuMUKoM3kesonu6Hf3tl4iYf6z1iODFoJv7NyMh+y9PkNzl6
         64FzmC8xBUYPXvhefsdAGPfHaRj4S+1cL7Bcw1L759/s8YeMG2X1VgHB/gvuivuXVaTh
         DxGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jack Pham <jackp@codeaurora.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.15 51/64] usb: gadget: f_fs: Use config_ep_by_speed()
Date: Mon, 26 Feb 2018 21:22:28 +0100
Message-Id: <20180226202155.631310593@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496518220924076?=
X-GMAIL-MSGID: =?utf-8?q?1593496726376375778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Pham <jackp@codeaurora.org>

commit 675272d092e4a5570bace92593776f7348daf4c5 upstream.

In commit 2bfa0719ac2a ("usb: gadget: function: f_fs: pass
companion descriptor along") there is a pointer arithmetic
bug where the comp_desc is obtained as follows:

 comp_desc = (struct usb_ss_ep_comp_descriptor *)(ds +
	       USB_DT_ENDPOINT_SIZE);

Since ds is a pointer to usb_endpoint_descriptor, adding
7 to it ends up going out of bounds (7 * sizeof(struct
usb_endpoint_descriptor), which is actually 7*9 bytes) past
the SS descriptor. As a result the maxburst value will be
read incorrectly, and the UDC driver will also get a garbage
comp_desc (assuming it uses it).

Since Felipe wrote, "Eventually, f_fs.c should be converted
to use config_ep_by_speed() like all other functions, though",
let's finally do it. This allows the other usb_ep fields to
be properly populated, such as maxpacket and mult. It also
eliminates the awkward speed-based descriptor lookup since
config_ep_by_speed() does that already using the ones found
in struct usb_function.

Fixes: 2bfa0719ac2a ("usb: gadget: function: f_fs: pass companion descriptor along")
Cc: stable@vger.kernel.org
Signed-off-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/f_fs.c |   38 ++++++-------------------------------
 1 file changed, 7 insertions(+), 31 deletions(-)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1852,44 +1852,20 @@ static int ffs_func_eps_enable(struct ff
 
 	spin_lock_irqsave(&func->ffs->eps_lock, flags);
 	while(count--) {
-		struct usb_endpoint_descriptor *ds;
-		struct usb_ss_ep_comp_descriptor *comp_desc = NULL;
-		int needs_comp_desc = false;
-		int desc_idx;
-
-		if (ffs->gadget->speed == USB_SPEED_SUPER) {
-			desc_idx = 2;
-			needs_comp_desc = true;
-		} else if (ffs->gadget->speed == USB_SPEED_HIGH)
-			desc_idx = 1;
-		else
-			desc_idx = 0;
-
-		/* fall-back to lower speed if desc missing for current speed */
-		do {
-			ds = ep->descs[desc_idx];
-		} while (!ds && --desc_idx >= 0);
-
-		if (!ds) {
-			ret = -EINVAL;
-			break;
-		}
-
 		ep->ep->driver_data = ep;
-		ep->ep->desc = ds;
 
-		if (needs_comp_desc) {
-			comp_desc = (struct usb_ss_ep_comp_descriptor *)(ds +
-					USB_DT_ENDPOINT_SIZE);
-			ep->ep->maxburst = comp_desc->bMaxBurst + 1;
-			ep->ep->comp_desc = comp_desc;
+		ret = config_ep_by_speed(func->gadget, &func->function, ep->ep);
+		if (ret) {
+			pr_err("%s: config_ep_by_speed(%s) returned %d\n",
+					__func__, ep->ep->name, ret);
+			break;
 		}
 
 		ret = usb_ep_enable(ep->ep);
 		if (likely(!ret)) {
 			epfile->ep = ep;
-			epfile->in = usb_endpoint_dir_in(ds);
-			epfile->isoc = usb_endpoint_xfer_isoc(ds);
+			epfile->in = usb_endpoint_dir_in(ep->ep->desc);
+			epfile->isoc = usb_endpoint_xfer_isoc(ep->ep->desc);
 		} else {
 			break;
 		}
