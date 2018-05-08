Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo6fnZ0j79pp8FrKnhOz4Hl5yBPYy+TiYEcMSRC6AuJXHpr4xO3yoh0w6HTR4eYyD3Oew/d
ARC-Seal: i=1; a=rsa-sha256; t=1525767244; cv=none;
        d=google.com; s=arc-20160816;
        b=zofAKpQkZ4ikyHXlhltt6Fo4kgIngowYLC5EslxUTKhkixYAANSSpY2LzdJRtrbXzH
         D/FFosUd1C8vzRl11bNWEKRnAkUXO3tmd0EDPGcrsXkj0d7MEADt3flsJMk5ePfohgdF
         LkVw3Cou1NzGb9Fd3mfvIL+PXRZa4oo3I8g+u7aQ83zFyaSbBNq0hJwpwrjvpIUlDeST
         K/BFSFlQjcmaVpwrkJDlKoUCN+NCq6dPjVLJU5NDI4bvsrcV4aa+WydvhKFXoXvRnQMg
         EwTvVe42LOMF2V4wh2a8aCbkd8GhG+8loj7W0rfQgagGBHKcVBaHHAosfHhUpKhYQzb+
         bX+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fxPaL3Ad6/5SP0CePpxBZW48DOb7DfP9106cRyVo2po=;
        b=oMfKleAzdRvEud6ovvBbjk3351S7Um5nIgLfZcu9vCOuLnBuqo2yySVfp72B7cGYD3
         /XQGDjXFeK9TwRU25s+0qv4EIbQHEF7lUo+xUSZNXTWTfxwPJFl0s8CaE3gOtHX99Prg
         D+mAaQ83R6lW1x7JD88o7RX+7ur3qLljzkXmdQ0Tf1FjDQn+lvrT31Ov65FPflypefHZ
         l93eU/8KtcNLaa5G0t4aBa50j9/VR1IfbZewEtSvB+v4krwpKpDNuCqH7IVDdreAxL9f
         FC8+2G0agwk9Cp3L+Zkjkto4jH5Ud66ANMbmuaL+/UTyRiO+bzCxVgjpKJBngj8vaOMN
         Soaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2hz+5oQZ;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2hz+5oQZ;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.16 42/52] usb: musb: trace: fix NULL pointer dereference in musb_g_tx()
Date: Tue,  8 May 2018 10:10:40 +0200
Message-Id: <20180508073934.008038060@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882913684302891?=
X-GMAIL-MSGID: =?utf-8?q?1599882913684302891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Liu <b-liu@ti.com>

commit 9aea9b6cc78d2b99b23d84fb2e0bc6e464c6569e upstream.

The usb_request pointer could be NULL in musb_g_tx(), where the
tracepoint call would trigger the NULL pointer dereference failure when
parsing the members of the usb_request pointer.

Move the tracepoint call to where the usb_request pointer is already
checked to solve the issue.

Fixes: fc78003e5345 ("usb: musb: gadget: add usb-request tracepoints")
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_gadget.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -417,7 +417,6 @@ void musb_g_tx(struct musb *musb, u8 epn
 	req = next_request(musb_ep);
 	request = &req->request;
 
-	trace_musb_req_tx(req);
 	csr = musb_readw(epio, MUSB_TXCSR);
 	musb_dbg(musb, "<== %s, txcsr %04x", musb_ep->end_point.name, csr);
 
@@ -456,6 +455,8 @@ void musb_g_tx(struct musb *musb, u8 epn
 		u8	is_dma = 0;
 		bool	short_packet = false;
 
+		trace_musb_req_tx(req);
+
 		if (dma && (csr & MUSB_TXCSR_DMAENAB)) {
 			is_dma = 1;
 			csr |= MUSB_TXCSR_P_WZC_BITS;
