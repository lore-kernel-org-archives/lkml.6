Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELugRLKa5O8AqZ75JO9UYxGFsBCjaOOyT74s/YBLGBrk5rGjqN3UkxdxiyLvp8uepV1Qw5vk
ARC-Seal: i=1; a=rsa-sha256; t=1519676705; cv=none;
        d=google.com; s=arc-20160816;
        b=020JbZfNuQ8wbAPF5NGFINod2prI3xt5KdMvDRz8vmr975CQPIrIXcPt8raYsgqo2i
         0VR4EK1U8G/qE3v5iVq0cyEjtXpNA77vVJrD57o+I9GhXqRK+Eu456DHF+43Y884+P3H
         JtF8JkdeIwB5qnhWZ2oVIu5bhuh0OuQgdsaXMfcSE0VcQqJjxlN8t4Q+j/85xbueCJtY
         641J82bPIGdhrIshh5l3V0hQr/rNZJlfkRijuksofvr6/7OwRcUuWqIC2P9Dn8zFUU+6
         K4k+8iSzSOaitBRn7Sq19b82LOz7/2bLeCta1Mh9Q+oMP+iXbccJZkjlWuQjdorw/r1I
         o74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l/iz5oJlNV+D2Je1p6cCLUoGFR06YOay+TXEzOoh+AY=;
        b=0aKhSsHJJorHK1lbROWphFpOYWno/fdYCrcl++YFWO5tV3VVxDPj8TNzbhUOdElXWs
         A8pL+fk3IMFONwA3L6GlkdWhAk2pQsQbTG/FcyNveh5F/xRP1UpBDLus79kqoEos7Tam
         nn+ZRsHlHOCpXhVQyOTIxOtGc0ie0ui1+YpwG9MgedBAlpnUJXxiLsV4NtKjgYkdvjJX
         TX9iC0fkk7L+YBP/7mGyNgUc33wlcs0B261mfuGhTVFqV0xPmr3Mc2xLeSI/g9ktwCT9
         nSAIv4D5J6nKTfTz9eIoM8+GgNNr7r/5bgh81D4j2FxY7ixe9OG9HEeC63ziAWFsvgHX
         9xYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 45/54] usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path
Date: Mon, 26 Feb 2018 21:22:22 +0100
Message-Id: <20180226202146.653301014@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496020414539698?=
X-GMAIL-MSGID: =?utf-8?q?1593496521367903464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 17aa31f13cad25daa19d3f923323f552e87bc874 upstream.

This fixes an issue that a gadget driver (usb_f_fs) is possible to
stop rx transactions after the usb-dmac is used because the following
functions missed to set/check the "running" flag.
 - usbhsf_dma_prepare_pop_with_usb_dmac()
 - usbhsf_dma_pop_done_with_usb_dmac()

So, if next transaction uses pio, the usbhsf_prepare_pop() can not
start the transaction because the "running" flag is 0.

Fixes: 8355b2b3082d ("usb: renesas_usbhs: fix the behavior of some usbhs_pkt_handle")
Cc: <stable@vger.kernel.org> # v3.19+
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/renesas_usbhs/fifo.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -998,6 +998,10 @@ static int usbhsf_dma_prepare_pop_with_u
 	if ((uintptr_t)pkt->buf & (USBHS_USB_DMAC_XFER_SIZE - 1))
 		goto usbhsf_pio_prepare_pop;
 
+	/* return at this time if the pipe is running */
+	if (usbhs_pipe_is_running(pipe))
+		return 0;
+
 	usbhs_pipe_config_change_bfre(pipe, 1);
 
 	ret = usbhsf_fifo_select(pipe, fifo, 0);
@@ -1188,6 +1192,7 @@ static int usbhsf_dma_pop_done_with_usb_
 	usbhsf_fifo_clear(pipe, fifo);
 	pkt->actual = usbhs_dma_calc_received_size(pkt, chan, rcv_len);
 
+	usbhs_pipe_running(pipe, 0);
 	usbhsf_dma_stop(pipe, fifo);
 	usbhsf_dma_unmap(pkt);
 	usbhsf_fifo_unselect(pipe, pipe->fifo);
