Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELukVNfAPARHSNCOfyrb+yBr+kzee8JvbAY/PbpTZodQ/1oaoWXW/xkfBiIpfamNOew3mZXq
ARC-Seal: i=1; a=rsa-sha256; t=1521214968; cv=none;
        d=google.com; s=arc-20160816;
        b=FBoSEdcM86FlSAgmgAS6M8bmxvREfZomJrqa/o4HbzT8QsHBmhyL4WNgCqIJLf/JCT
         muLw18/oAJRj19t8rEBwCxLYMoQI5tWTyykfh+Jd+5/KBrZLIBPGBCAMl+Od2qGqAa8+
         mLtq1KOdkyH2IfPFujdatjKaimfN3MgYZlaD/U3Ld4LK/e5Tn5oDfnqk9rSLTC8iddwM
         Tyev2J0KLoEIvO8XX16RBabIaufuolXJZfX6wnlfTpu35iVWy3tvq1JTme+0R1bQE9Re
         XKB62855/IC1pshAW+qolDMncx2mZ2AbTJR8aulLRF73YBCO4fXo73qTuoB/ZxbktMnn
         xrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CIkty6Ty0Ac6NbtYJnfRua1v+5dDuoO9+Pqzp6VZMHU=;
        b=EUg3B/0EasjvWejixuR/4+7KvOhgUzs3gFd/NOjiRT4wJwbztZkflaL0dYEtmYT08F
         2NDH+Zc4o7r8bjUFP3aAEfuSbR7DU90f0LbPhJ0qB7oVw7Se0e+zV7fBsogJhthZ670K
         3T6OExKokpwR6YjZbv8cKKyhu0hFwvMX9H9eUrDx8RMMycgkTPtMU0AE2L1kv+RLuoZL
         pYjeagnxS77l/D5eCdzlFSvYOkKv8hlljBTEUxJgvJvaeEFjQnhYX5GTM+kkfuy5BuTN
         W3+B5fs4Kj6WaAwcoeC1wki9kT0cBoAMRYb8E0H6p7tSkZBvqsBQfo3Ddb39qjnc5svM
         DP7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mark Jackson <mpfj@newflow.co.uk>,
	=?UTF-8?q?Micha=C5=82=20Oleszczyk?= <oleszczyk.m@gmail.com>,
	Rafael Gago Castano <rgc@hms.se>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 045/128] dt-bindings: serial: Add common rs485 binding for RTS polarity
Date: Fri, 16 Mar 2018 16:23:06 +0100
Message-Id: <20180316152339.067669635@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109506738515914?=
X-GMAIL-MSGID: =?utf-8?q?1595109506738515914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>


[ Upstream commit 6abe9ea8a5a5904d935b8a482117a7fd9b25f09e ]

rs485 allows for robust half-duplex serial communication.  It is often
implemented by attaching an rs485 transceiver to a UART.  The UART's
RTS line is wired to the transceiver's Transmit Enable pin and
determines whether the transceiver is sending or receiving.

Examples for such transceivers are Maxim MAX13451E and TI SN65HVD1781A:
https://datasheets.maximintegrated.com/en/ds/MAX13450E-MAX13451E.pdf
http://www.ti.com/lit/ds/symlink/sn65hvd1781a-q1.pdf

In the devicetree, the transceiver itself is not represented, only the
UART is.  A few rs485-specific dt-bindings already exist and these go
into the UART's device node.

This commit adds a binding to set the RTS polarity.  Most (if not all)
transceivers require the Transmit Enable pin be driven high for sending,
but in some cases boards may negate the pin and RTS must then be driven
low.  Consequently the polarity defaults to active high but can be
inverted with the newly added "rs485-rts-active-low" binding.

Document this binding in rs485.txt and in the two drivers fsl-imx-uart
and fsl-lpuart that are about to be amended with support for it.

Curiously, the omap_serial driver defaults to active low and already
supports an "rs485-rts-active-high" binding to invert the polarity.
This is left unchanged to retain compatibility, but the binding is
herewith documented.

Cc: Mark Jackson <mpfj@newflow.co.uk>
Cc: Michał Oleszczyk <oleszczyk.m@gmail.com>
Cc: Rafael Gago Castano <rgc@hms.se>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/serial/fsl-imx-uart.txt |    3 ++-
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt   |    3 ++-
 Documentation/devicetree/bindings/serial/omap_serial.txt  |    1 +
 Documentation/devicetree/bindings/serial/rs485.txt        |    1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

--- a/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
@@ -9,7 +9,8 @@ Optional properties:
 - fsl,irda-mode : Indicate the uart supports irda mode
 - fsl,dte-mode : Indicate the uart works in DTE mode. The uart works
                   in DCE mode by default.
-- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
+- rs485-rts-delay, rs485-rts-active-low, rs485-rx-during-tx,
+  linux,rs485-enabled-at-boot-time: see rs485.txt
 
 Please check Documentation/devicetree/bindings/serial/serial.txt
 for the complete list of generic properties.
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -16,7 +16,8 @@ Required properties:
 Optional properties:
 - dmas: A list of two dma specifiers, one for each entry in dma-names.
 - dma-names: should contain "tx" and "rx".
-- rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
+- rs485-rts-delay, rs485-rts-active-low, rs485-rx-during-tx,
+  linux,rs485-enabled-at-boot-time: see rs485.txt
 
 Note: Optional properties for DMA support. Write them both or both not.
 
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -20,6 +20,7 @@ Optional properties:
          node and a DMA channel number.
 - dma-names : "rx" for receive channel, "tx" for transmit channel.
 - rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time: see rs485.txt
+- rs485-rts-active-high: drive RTS high when sending (default is low).
 
 Example:
 
--- a/Documentation/devicetree/bindings/serial/rs485.txt
+++ b/Documentation/devicetree/bindings/serial/rs485.txt
@@ -12,6 +12,7 @@ Optional properties:
   * b is the delay between end of data sent and rts signal in milliseconds
       it corresponds to the delay after sending data and actual release of the line.
   If this property is not specified, <0 0> is assumed.
+- rs485-rts-active-low: drive RTS low when sending (default is high).
 - linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
   feature at boot time. It can be disabled later with proper ioctl.
 - rs485-rx-during-tx: empty property that enables the receiving of data even
