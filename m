Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsCat3XiQwS2jTUebSDiymUqBwd1w6V0jpYmkdI9hihtvL39pnszSCFgG4D3e5fszrebdcV
ARC-Seal: i=1; a=rsa-sha256; t=1519676742; cv=none;
        d=google.com; s=arc-20160816;
        b=bKG9hlnncTWXH9F22x9tccuiUe3eotyYKeyIC+S8aZJcOMqhQ/n32bUoBZPTn6ubw0
         LCWLSzoA/tk1G3JfR6AzJ+C8VOYisx2CvVD1Hpxd+DKiTf4usr+NFHd+qa0dVtrNo+ty
         slpudqXSyEoH5r5aQDmS/15q3vdWpUWIvHfc18BVCXKGYaPjRtLRqrL11J26y4vU5Wxx
         zoEjPFsukv7qbLzA7ovbixPRwwaM4XBRv3AHHyO32JcWtx1DiMUCWeh3Gmg0uuuZs5jb
         JqBNEhFZD2RL4AyFdLAyTOYTjUFD4CgR2GT+NA6Kiw+CMQFBNXH/Q25hBiFfr5mZDenC
         f1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dLLVdZQBGX42yrbJ7CHI75pFZBmUreA5Kr46dmodlrg=;
        b=ExVmCeJjXGek5Ipyr68XCpQg8TOCoN/0vQsa2Nk1VD7I5or6Jqo1CoRkkupbqDDUVi
         fLLpkCVw61atykJ3S63mwybSeQEege6Lppzfafd4zgAFLBDzTly6Hj0EAsTFhMOFeXdg
         ojnBSgx0FYxcwBqGmzlHt+JGGf7rpJE8+lnQTgghbO19H1r+AWycxxgNbuALYwLVyn3g
         Z8FZpq0ljeNgTdpnB/6o+Klk7p1dKZAWa69ww9nnCQx8NqJ2tWQzOyRKMbGF/67C18dO
         8WviHaPJsd7BDiu3NuLomJ5PEvo/tYRW0DM+uIXBRB83JgkUts3EuAVejZrOhoNfNHXZ
         D6LQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Chen <peter.chen@nxp.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.14 38/54] usb: host: ehci: use correct device pointer for dma ops
Date: Mon, 26 Feb 2018 21:22:15 +0100
Message-Id: <20180226202146.259675323@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496560226767703?=
X-GMAIL-MSGID: =?utf-8?q?1593496560226767703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chen <hzpeterchen@gmail.com>

commit 02a10f061a3f8bca1b37332672f50a107198adbe upstream.

commit a8c06e407ef9 ("usb: separate out sysdev pointer from usb_bus")
converted to use hcd->self.sysdev for DMA operations instead of
hcd->self.controller, but forgot to do it for hcd test mode. Replace
the correct one in this commit.

Fixes: a8c06e407ef9 ("usb: separate out sysdev pointer from usb_bus")
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/ehci-hub.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -787,12 +787,12 @@ static struct urb *request_single_step_s
 	atomic_inc(&urb->use_count);
 	atomic_inc(&urb->dev->urbnum);
 	urb->setup_dma = dma_map_single(
-			hcd->self.controller,
+			hcd->self.sysdev,
 			urb->setup_packet,
 			sizeof(struct usb_ctrlrequest),
 			DMA_TO_DEVICE);
 	urb->transfer_dma = dma_map_single(
-			hcd->self.controller,
+			hcd->self.sysdev,
 			urb->transfer_buffer,
 			urb->transfer_buffer_length,
 			DMA_FROM_DEVICE);
