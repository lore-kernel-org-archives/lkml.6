Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsMNnd20xFwrhOeHXgCKbahtiSS0Omc0iZFACsVh2HUvJJd2lcI/tuuwSIStnamBtrdBZGg
ARC-Seal: i=1; a=rsa-sha256; t=1521214965; cv=none;
        d=google.com; s=arc-20160816;
        b=TEez/jyq5GRbjvZ80DLdQ9rCz2QwmplHKNiTftkPELOpE4s6M/RUkY0Xz0Q2FKVMEy
         IBj9bG7j00y2p93E5kAeMDDuofiT/mCq2Au3N3LLBL7tvgnYg56pW/6MdxycF2qWvBZB
         HYgFLlTHe6vT/T2t8xWXjgwatnSvDpHP04Spd3h00TsHb/qRaALjrw9tBj8WnTXJP8lJ
         TWNmGgNQxPaPysVyaOsjEd8AFj6O3CInMWQH4kyNaiZpsI4nxINyFGBHFSfFK2FWfVUy
         FXj+2IXNvg0MruospNAkQqyTLijxym3emCu9h7jpA/98QODfnorM+RRQ8Kd25mqxV0tn
         JTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2e6jLe9FrCVmqXH7zmzNB76PGncZDyEPYjJj7WTuL5w=;
        b=BqgmaJG9qU+x3K/qgsLx7YXNZTb7an+/O8eYJOPUSUNxJP+b7p4U4tj7XBpoqdN49g
         viORDmZihcGRe1ZGHV9DS2uNvq3itbbtsV/eUyrIO6T/2qwuulTLYf48iLroeyxjHNDg
         kJGgDxedUE/aNdXe8Fzi1ycXbwbj7EL0XHjEJu4c/YmdNmjI9p5eC2mQu0mQJM+qJDPH
         SuYnyP3EmPjclOfxYr/JMQYlZVr34p+6qgohSVwxhPsB5L0795y+Loy6xYITtowibj++
         pJFNhzeC/INWg5MvobV+g7j/sSlMxXRpHr+O20OMfi5GA6JrTbHahOW2Wep3iW8jb7Bt
         f6kQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Johan Hovold <johan@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 044/128] USB: ledtrig-usbport: fix of-node leak
Date: Fri, 16 Mar 2018 16:23:05 +0100
Message-Id: <20180316152339.001329604@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109045086411487?=
X-GMAIL-MSGID: =?utf-8?q?1595109503822206126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>


[ Upstream commit 03310a15484ab6a8f6d91bbf7fe486b17275c09a ]

This code looks up a USB device node from a given parent USB device but
never dropped its reference to the returned node.

As only the address of the node is used for a later matching, the
reference can be dropped immediately.

Note that this trigger implementation confuses the description of the
USB device connected to a port with the port itself (which does not have
a device-tree representation).

Fixes: 4f04c210d031 ("usb: core: read USB ports from DT in the usbport LED trigger driver")
Cc: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/ledtrig-usbport.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/ledtrig-usbport.c
+++ b/drivers/usb/core/ledtrig-usbport.c
@@ -137,11 +137,17 @@ static bool usbport_trig_port_observed(s
 	if (!led_np)
 		return false;
 
-	/* Get node of port being added */
+	/*
+	 * Get node of port being added
+	 *
+	 * FIXME: This is really the device node of the connected device
+	 */
 	port_np = usb_of_get_child_node(usb_dev->dev.of_node, port1);
 	if (!port_np)
 		return false;
 
+	of_node_put(port_np);
+
 	/* Amount of trigger sources for this LED */
 	count = of_count_phandle_with_args(led_np, "trigger-sources",
 					   "#trigger-source-cells");
