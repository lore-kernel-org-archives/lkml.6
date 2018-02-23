Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227NVY/Y+vO+Kll51AWG7oBTYGKOX+uBNI3qe1OSQnlAJ4K3Qpl1+KCs5J9/6tQvK1dc+qU8
ARC-Seal: i=1; a=rsa-sha256; t=1519411040; cv=none;
        d=google.com; s=arc-20160816;
        b=F1yDk1Hx7xhYdvNr514fHBd9gC4c8Dv1Rmpis2FcGcFqLO8gItsLc2HSZz+WKSnV2G
         jOfkoANetUJZG7FDsE/z6baI8kVVnGr28PzeZrAQO2A4jr10CdxPb56UbWmw4dJLjaiA
         +39d+2nq3f9n1jc9amJ3wgMLmjrgkbZM8ouSk2GjSlNQOhpqAuTHyeAJzg4pULexdPWi
         uvkWa384pRgs1Za9h8oJQUiUYwzdhtXIY4ktoPVnsDil4/hS9W7XVOGFmeAvCuLVM4qK
         Gc1uoGJEPLtoFxVvPO1av+wCLqkqVrfhuBnWHqwJIgKc2yQcRsPTogcLeUbFMoTcNBIZ
         1exg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HeZWXSOs9YJFkVNYsvecfHAefuczU7GvsO9VTeomRdM=;
        b=L1HjaKu2z/oDSUCeND2FYjR+JqZ0WFXOE41dVM27MhFa2DSOcSYFbNwPLYUII/Q2aL
         QO2F6sOw7MpH0/dMhn/0itLsf67vMM78wN+o2TjbjvWmaS7luv7hTHx/vAz4Gt61K/ca
         y7h9M92VDnHBdoXc7BMwXPOpUgH0Ak/e40i7kI6lOF1QtL5oUgXfHGiVHilSq2Hel8d+
         osGhWfx8RxO/Wx3b/OmG3LNI1x9R2NEvJtaKj8otOn/bCcBRnqnyF3MCm3i/InzHNXd1
         r6EltYtZjHCSgF3YW5wclMBdsdsExNQZYrSqSA13MVzHnlwYqcl2l81LzkQrIE/lp7aJ
         99IQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.4 100/193] usb: musb/ux500: remove duplicate check for dma_is_compatible
Date: Fri, 23 Feb 2018 19:25:33 +0100
Message-Id: <20180223170341.680390410@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217951669274244?=
X-GMAIL-MSGID: =?utf-8?q?1593217951669274244?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 62a6abdd427b5fc4d8aad5dac874904e96273e6d upstream.

When dma_addr_t is 64-bit, we get a warning about an invalid cast
in the call to ux500_dma_is_compatible() from ux500_dma_channel_program():

drivers/usb/musb/ux500_dma.c: In function 'ux500_dma_channel_program':
drivers/usb/musb/ux500_dma.c:210:51: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  if (!ux500_dma_is_compatible(channel, packet_sz, (void *)dma_addr, len))

The problem is that ux500_dma_is_compatible() is called from the
main musb driver on the virtual address, but here we pass in a
DMA address, so the types are fundamentally different but it works
because the function only checks the alignment of the buffer and
that is the same.

We could work around this by adding another cast, but I have checked
that the buffer we get passed here is already checked before it
gets mapped, so the second check seems completely unnecessary
and removing it must be the cleanest solution.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/ux500_dma.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/usb/musb/ux500_dma.c
+++ b/drivers/usb/musb/ux500_dma.c
@@ -207,9 +207,6 @@ static int ux500_dma_channel_program(str
 	BUG_ON(channel->status == MUSB_DMA_STATUS_UNKNOWN ||
 		channel->status == MUSB_DMA_STATUS_BUSY);
 
-	if (!ux500_dma_is_compatible(channel, packet_sz, (void *)dma_addr, len))
-		return false;
-
 	channel->status = MUSB_DMA_STATUS_BUSY;
 	channel->actual_len = 0;
 	ret = ux500_configure_channel(channel, packet_sz, mode, dma_addr, len);
