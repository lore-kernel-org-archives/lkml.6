Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqtBf7PXpssGV/nm7+9A9aM51j6Wayc8Hj67sUaeITRR9g7WJBraLvzjT33w9g0IbwGTrc/
ARC-Seal: i=1; a=rsa-sha256; t=1525767352; cv=none;
        d=google.com; s=arc-20160816;
        b=0VjIPoQ4RhKlTyYUhLCDUQajvVL51fZNFDpoDMz1Lz/yTYwIIv8F5tGR7hYczaV/TT
         LEl7DdRhO9iqXR1Uzy5PzrYrN6qSg4kLmfnT7ltGDnJ/tehbpPGB2D5p+I2yaS60WrQu
         VUXfr5dSJB6z1SM49NPkwU1v0mexUjHwjJCtSQAZVH6gX1Z8xZo8Rl/HezLJTt5H4gyB
         c4XqyXQqE92ZFFaUbIY7hmhBrhcVCNfo9QeQ2SlG+PJobyYV4CyChOhBMB5qZgQfu3/K
         rvjlWL5iKLxHZ+pHw812hMgIr0aQcbsgQQR/eoDH0vDQiovA5qQHdlJOHD2szU0l0ltR
         KVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=5Ua9K449lrEKJDF9vQjGj1VAHniutc6mTNRhRCz/I4s=;
        b=qq6SZBycq701VQLBdLX1LifdxCl45+50koubDYLC5/yW9KUIJogrbt9CIi1lQ7P+hD
         p6F6QtoMFdo262Ot7WPl4MDA+y30y4lpAQuw67uhiwl+TPdg+lRTHEypoOXmI1lyc06t
         /ShlnlC0udCnEzJ0vo9OlgxsdUr0bmUmbAayJ/eHFmd0PL2QIe9rLhEMzTE3XvyqqW96
         lO7n3SKp8L6uJ0Hto/Z8WvVRbIxMqIY5sfQTcPaAXentjNOa9Q7OCOCfnJV1qpM9lOAq
         nuyn9weKoQKSEPndE5j7onW6ti8kTiC1k7475JIBg4DyktiSEmTOWKDxNDOxJ2AcQejh
         5fjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sw+TH7aK;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=sw+TH7aK;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.14 40/43] usb: musb: trace: fix NULL pointer dereference in musb_g_tx()
Date: Tue,  8 May 2018 10:10:59 +0200
Message-Id: <20180508074010.320357854@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882913684302891?=
X-GMAIL-MSGID: =?utf-8?q?1599883027725695655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -442,7 +442,6 @@ void musb_g_tx(struct musb *musb, u8 epn
 	req = next_request(musb_ep);
 	request = &req->request;
 
-	trace_musb_req_tx(req);
 	csr = musb_readw(epio, MUSB_TXCSR);
 	musb_dbg(musb, "<== %s, txcsr %04x", musb_ep->end_point.name, csr);
 
@@ -481,6 +480,8 @@ void musb_g_tx(struct musb *musb, u8 epn
 		u8	is_dma = 0;
 		bool	short_packet = false;
 
+		trace_musb_req_tx(req);
+
 		if (dma && (csr & MUSB_TXCSR_DMAENAB)) {
 			is_dma = 1;
 			csr |= MUSB_TXCSR_P_WZC_BITS;
