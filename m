Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225WIsr7pMLrGafRgaUzS5XL0xPHL8t6QsBXbIJ1wmEMFr/1PA6JB30eP8mPgyYE9/rASjM7
ARC-Seal: i=1; a=rsa-sha256; t=1519676529; cv=none;
        d=google.com; s=arc-20160816;
        b=vF15fuDE4AbLW4CaFW/SIPV25QGdeg2W82uJMA0KOgGCLtWS31YdmEEea0UgQqkoUN
         HUHeBMKY+gE8I6nIxyz7G0gFdPu7gi2UCLkxh3X/wDxDZ8bpa7egJPqagtq6EAJnF7HI
         QGp20KwdKYc6D0kOjlvdE9kVqX71bVXfAmAUw4XAb7eStO3VLOPNHZ7ouiAknqbRXFCS
         HZl6LYDUwrEifTeTCef50R7kzwjiZRgmOV7ClC88sqnHYSNQHQzot98XZmfE9oCTImNX
         Nw0J1xLjNZEJd1DXZER6hYIUFKmiAC3Gb5DJZwIN6w9n28SY2P2hQ/xXAtczjexqmE7y
         S1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZnrriezaO+2wscSQxvYhGmGv5EdaeUh5of7vP4Rlss0=;
        b=DK2qY33A+04SPQ9PSoOAca/6A9jwKBQGkbcs5HP27PQBvW3kz8Ki8F43VKiWgyoljx
         vNNXZCyAAlrdO1EZjci77WJN/DVV6ibuPttqUYGe5hvu8wwF6O85IK/j6whZBWBFJoEt
         HKw+lzpWzv5T54dm8g+Aw3yyVB4PsxoLdW86fbt7GVswloiw88UZz7bJGz8/3lZjV/GV
         moVnYSv+844lErsgd9S3baKRHbFooVECfA82QFSSu3IL1imF4ynKDbXMb+FkWcE4YswV
         1xYnc0xdDEuv+Fe3RHvLXzuyN538BY7xZXfMNhpQXxc75ELMBT0BbacBv577MlxUh9q8
         EGSw==
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
Subject: [PATCH 4.9 22/39] usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path
Date: Mon, 26 Feb 2018 21:20:43 +0100
Message-Id: <20180226201644.648054891@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496020414539698?=
X-GMAIL-MSGID: =?utf-8?q?1593496336361990701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1001,6 +1001,10 @@ static int usbhsf_dma_prepare_pop_with_u
 	if ((uintptr_t)pkt->buf & (USBHS_USB_DMAC_XFER_SIZE - 1))
 		goto usbhsf_pio_prepare_pop;
 
+	/* return at this time if the pipe is running */
+	if (usbhs_pipe_is_running(pipe))
+		return 0;
+
 	usbhs_pipe_config_change_bfre(pipe, 1);
 
 	ret = usbhsf_fifo_select(pipe, fifo, 0);
@@ -1191,6 +1195,7 @@ static int usbhsf_dma_pop_done_with_usb_
 	usbhsf_fifo_clear(pipe, fifo);
 	pkt->actual = usbhs_dma_calc_received_size(pkt, chan, rcv_len);
 
+	usbhs_pipe_running(pipe, 0);
 	usbhsf_dma_stop(pipe, fifo);
 	usbhsf_dma_unmap(pkt);
 	usbhsf_fifo_unselect(pipe, pipe->fifo);
