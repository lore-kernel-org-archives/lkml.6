Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo3PNmBbVv7amAY3C/JJz49CL4w+bXfA87dx6MQbVjwMrFLexSHLoO7+6PUxPFMIuliIxSO
ARC-Seal: i=1; a=rsa-sha256; t=1527155625; cv=none;
        d=google.com; s=arc-20160816;
        b=IYup6nQPzNHzlW5xvHU7JpehFHjzrKzufGgpoYnlMcMOuM+sNXaUFZZ+5J2eT3GwrI
         eLFC3/o98ufWlCLxlHa/s9QS6fFXGs+iO1Ds5YdeOR5lmX3wZ80jgGWLn+r4InNcHAB/
         iK/MXSpue/GfDmiyy7gJUFAJVjfGHKWLOKB1ciUVvsuYm3bARdfQ1Gc8r6WNioAyCafu
         agfGEui9dYLYWDKEqnFCuVlqz2afrkkJ5xKvD6eN78uZcPu0GJCS23u2xrprzLU+t78O
         Z7TOMNW3Jh6q4xjZfbfsqU7vaRhZgcg+dHpSYOuLml87B7x5KKFw7ptm4uZkuDr8qAHj
         NKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=pGj8DST3WKy0akzw6REKetrVwht4gHuwyXX4dqrgbUQ=;
        b=eoayLF6Ja6MXZxvWlYfJnoY6JcyUg4v3evNw+D9BSxFsbpmLqJQS1TWtCzjXD4TL3f
         1oHeh8xE8BRBWu2vZpGYeb1ZErqIzPuCiUjYtJkE15Rj1SyInEIKYOrn5qyFOKhI7qVQ
         UlkT/yh/QNX2VzjqvNKnEx7lJgdEoDjqYmYgpuOYLZHB82PUTDWVXlBhhpHI8G2qF91L
         3lng/qQCPdJN7pwwq0bJVHJDnplGmLC5GRK7l2thw15J4JG42qHUh7FBMo+2rMfTwNRi
         UzIbAlemzhEnKCsse/s/3Cd4ZK1MkcL15sie9s8YKQEpf2wI5JWHpLJ5Wai0uuMaLcwe
         wC7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pmcPP+Fi;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pmcPP+Fi;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 058/165] usb: gadget: fsl_udc_core: fix ep valid checks
Date: Thu, 24 May 2018 11:37:44 +0200
Message-Id: <20180524093624.366302510@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338470588432637?=
X-GMAIL-MSGID: =?utf-8?q?1601338737648020962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit 20c63f4089cceab803438c383631963e34c4d8e5 ]

Clang reports the following warning:
  drivers/usb/gadget/udc/fsl_udc_core.c:1312:10: warning: address of array
  'ep->name' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (ep->name)
        ~~  ~~~~^~~~

It seems that the authors intention was to check if the ep has been
configured through struct_ep_setup. Check whether struct usb_ep name
pointer has been set instead.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1309,7 +1309,7 @@ static void udc_reset_ep_queue(struct fs
 {
 	struct fsl_ep *ep = get_ep_by_pipe(udc, pipe);
 
-	if (ep->name)
+	if (ep->ep.name)
 		nuke(ep, -ESHUTDOWN);
 }
 
@@ -1697,7 +1697,7 @@ static void dtd_complete_irq(struct fsl_
 		curr_ep = get_ep_by_pipe(udc, i);
 
 		/* If the ep is configured */
-		if (curr_ep->name == NULL) {
+		if (!curr_ep->ep.name) {
 			WARNING("Invalid EP?");
 			continue;
 		}
