Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414856-2-10335839484497946816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414856; b=o6jwpmR8B42dedtlWS36KGnw6Gj3PATGTusPBCAdYHlePzT
    nl4pLloMzbLlMlvZi7u8sJ/bXk9dDA+j6i1ZanX20IXInKIvytxHhupEIlovaBjq
    17QCmyttM6TAx6sy2edYE/7AQbH7Yk4uSZ8mn6eA1xrUk6VKuhE37xqUedLuVxNX
    HbQS6d8BVvlHmKSzkP6Sx/9NGTIxMn3p/qNGq9eCKBcVw3Xo6PbIHeMjbZBUETPo
    gGS+pLSBO+nXHNsfoTFKqnZxOqFFs99nIiCxyuE/pa2YP8zFUz8fgMPXgV1jz3Fm
    p5o847I62kp30vILAvaBbfw4CkgC4g/LVILCZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414856; bh=rhwt239xBTQppNtvCDWml0TkhZ
    AhVRCIfQW2br4lxxg=; b=rr95ssP1ngY/Uaeyy6t3lDh0ErOST9VrB1xDEbUUPK
    9BpiH7QKPFtCsOUzN1LY+XyQcHZNMNqidfEzr88ydY9qegV483lzvN0PqRQq3kKj
    yK8Uc4SBzU9H5x4F+7PVWKyfpjSCi00Ql7gf9LZPo2Hnw25gogn+uWDEtB2NRPxE
    w0sjX5uJiD6yJmIjNhd700Huw8/Or4ETjuHW1d/zBUmis3wimYPZGE37cFX32WI0
    oNPOg6UE5ZZmAmoEhGWiTblqtegYs9DAZBPkfYYOnrdkwcKDrAxPfq8S7vxsdH/E
    aOPLxIRPv7ei3Ethzla2rfS7seMl2GOMvZTh5yM5Q2zg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933596AbeBWTkk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:40:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934513AbeBWStV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 001/159] usb: core: Add a helper function to check the validity of EP type in URB
Date: Fri, 23 Feb 2018 19:25:09 +0100
Message-Id: <20180223170743.256398104@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit e901b9873876ca30a09253731bd3a6b00c44b5b0 upstream.

This patch adds a new helper function to perform a sanity check of the
given URB to see whether it contains a valid endpoint.  It's a light-
weight version of what usb_submit_urb() does, but without the kernel
warning followed by the stack trace, just returns an error code.

Especially for a driver that doesn't parse the descriptor but fills
the URB with the fixed endpoint (e.g. some quirks for non-compliant
devices), this kind of check is preferable at the probe phase before
actually submitting the urb.

Tested-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/urb.c |   30 ++++++++++++++++++++++++++----
 include/linux/usb.h    |    2 ++
 2 files changed, 28 insertions(+), 4 deletions(-)

--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -187,6 +187,31 @@ EXPORT_SYMBOL_GPL(usb_unanchor_urb);
 
 /*-------------------------------------------------------------------*/
 
+static const int pipetypes[4] = {
+	PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
+};
+
+/**
+ * usb_urb_ep_type_check - sanity check of endpoint in the given urb
+ * @urb: urb to be checked
+ *
+ * This performs a light-weight sanity check for the endpoint in the
+ * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
+ * a negative error code.
+ */
+int usb_urb_ep_type_check(const struct urb *urb)
+{
+	const struct usb_host_endpoint *ep;
+
+	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
+	if (!ep)
+		return -EINVAL;
+	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_urb_ep_type_check);
+
 /**
  * usb_submit_urb - issue an asynchronous transfer request for an endpoint
  * @urb: pointer to the urb describing the request
@@ -326,9 +351,6 @@ EXPORT_SYMBOL_GPL(usb_unanchor_urb);
  */
 int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 {
-	static int			pipetypes[4] = {
-		PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
-	};
 	int				xfertype, max;
 	struct usb_device		*dev;
 	struct usb_host_endpoint	*ep;
@@ -444,7 +466,7 @@ int usb_submit_urb(struct urb *urb, gfp_
 	 */
 
 	/* Check that the pipe's type matches the endpoint's type */
-	if (usb_pipetype(urb->pipe) != pipetypes[xfertype])
+	if (usb_urb_ep_type_check(urb))
 		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
 			usb_pipetype(urb->pipe), pipetypes[xfertype]);
 
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1729,6 +1729,8 @@ static inline int usb_urb_dir_out(struct
 	return (urb->transfer_flags & URB_DIR_MASK) == URB_DIR_OUT;
 }
 
+int usb_urb_ep_type_check(const struct urb *urb);
+
 void *usb_alloc_coherent(struct usb_device *dev, size_t size,
 	gfp_t mem_flags, dma_addr_t *dma);
 void usb_free_coherent(struct usb_device *dev, size_t size,
