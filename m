Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsfGpcg+91Jb0aXCe6t/Cv7UYMqkeXIkmo846FeDNAENgSmdKiZPDsx8k+h3R4xzd5YbWNv
ARC-Seal: i=1; a=rsa-sha256; t=1521214528; cv=none;
        d=google.com; s=arc-20160816;
        b=p7316/R3Fy/wSV+Oeh2bTOEpx1tZhErZORYfdPrD4qlti5UNwLia02wSjsBpERaez0
         U77PeI3/0QacjgbFwqgFv0QD/L8L0jfJw2M3c760Ut8euQXdXflr3ox77I+BJl35e7aV
         x9ZJFpw/T/I+dqtdvOfTwDyu+PPEKBLCns9a+6mJtYfDA8mGT29z8mo1QSaS53z/P7Mv
         c9kEMZyjRK+Wx0I9Fb+DVaoFcV7yOuradIct3bbjmKmCFMmYLRl+SZrdN+qUOsxD6lPS
         ZbCTLsN1R7+NzfFKlMrJAJP/I/SGK3BySdGJaT4x8LqGAd2UVw3D7d79SAqlUKKVwFPs
         vtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eJRyu91oRm1XwnOYaZIj8evvNk0H+B32o/M99fkYzuU=;
        b=sRxg0ncu7hrPXfWegYlIvlXtFXy9IZrvufPIvYrIwlQACxKH7ip5d70Z4aJK3JXdWY
         pGHAvipCsP1OsUM544QiUMHDb/kzMQRn+Htwr/i98VVOx6vMiTBPat8e7tvqTAQxWAaC
         G8p5ChlJ9GVtTH/EN5i+OC86R5DmfHZG9l8I0un1UKfpobIJxNbPjWbOrxrX3nzjGJYk
         sCEHazygOXuYUxIKPWnBbTcRLSw3LkYyXkTikJbgu1kj2GxjJ78W9ln599U7CFw9AZMj
         yGMAigdsXkArj/ps92J+Te3iAlPeiqcBHpPjOxcwSXTQ0DpUformXoYbYK8QPhjMfPr8
         YvbA==
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
Subject: [PATCH 4.14 039/109] USB: ledtrig-usbport: fix of-node leak
Date: Fri, 16 Mar 2018 16:23:08 +0100
Message-Id: <20180316152332.064374720@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109045086411487?=
X-GMAIL-MSGID: =?utf-8?q?1595109045086411487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -140,11 +140,17 @@ static bool usbport_trig_port_observed(s
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
