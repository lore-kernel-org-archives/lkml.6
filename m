Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48GpR9MiApiRO21JcOeUwwb5YrIxV7Uu7a2EWZh5ibi4SLrzafx0/QfV8oufeJmgoyPVUic
ARC-Seal: i=1; a=rsa-sha256; t=1524405832; cv=none;
        d=google.com; s=arc-20160816;
        b=g0HcI7PSf8HFFzolSOksa5GLq3evw5KX4ggCKUJ2yoUVZCyzzHrU0BKd7QEyyGy4No
         +C+koN/3HAmBGij3cATebTcOXA8I0frBhJxNZvNX2r/7/HyIJjUvKmZoJ3W/L9FncPgW
         g1Gb6rXBNojICqxwMKIFyyNndPJusRWwfmCs1VRdfPqk2vbNk1kZVyCOa3zkOEDYJXm8
         eUX+FDoec1DJNNIEzIhg5c7fizNgJt/HfQUSkWqQKq6f9ukXHhrYV7xZRymM0Eem5zr0
         cEpvuTVQlir9oIrtnX9LSpsfcN8yeHp+ZTUgYgI3HZ8CO45urF9CZFfpeDN/IaegTqvb
         07zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IngYanPIZJJreNcPiD6Aie9bxcTHpAuuDHylUXbCldE=;
        b=NmKDimFSq4XzFMt4LuprY5Lv4eFo1GGRNpAUE5hC7ocd8bvz35SBXX1BuRMmPSDd+9
         2fvhMKYVdpJ4ZELPh0tQqo9R1VwuIsMT0xZYEo3UdPxHJCivwrWRjWId+/S9xZoJVHSR
         sjRhzT1r/FIphRWBD01qmf6iJLZzbxEcc2PY+QTwZfYueTJSxVCSinP5UryTp23IoccU
         XCKlts4cqhLgosbiE04NPmcMpCS4XctaSr4a0dch0FSxMNFhFZ/J5m8f5/7xiGmc3P3R
         CmYz9DUQOEmELVo2mqAAfLwBIKOJnESmnAIx4Fkx7nkfihe24WMu/Y6loZIAK8RwQGvO
         ayVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.14 015/164] usb: musb: gadget: misplaced out of bounds check
Date: Sun, 22 Apr 2018 15:51:22 +0200
Message-Id: <20180422135136.013445808@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454813951848255?=
X-GMAIL-MSGID: =?utf-8?q?1598455370587918778?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit af6f8529098aeb0e56a68671b450cf74e7a64fcd upstream.

musb->endpoints[] has array size MUSB_C_NUM_EPS.
We must check array bounds before accessing the array and not afterwards.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Bin Liu <b-liu@ti.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_gadget_ep0.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -114,15 +114,19 @@ static int service_tx_status_request(
 		}
 
 		is_in = epnum & USB_DIR_IN;
-		if (is_in) {
-			epnum &= 0x0f;
+		epnum &= 0x0f;
+		if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
+		}
+
+		if (is_in)
 			ep = &musb->endpoints[epnum].ep_in;
-		} else {
+		else
 			ep = &musb->endpoints[epnum].ep_out;
-		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}
