Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq3w2Q8RK7UkwE7w7iPnHO2m8fE9lfndPWRtEkIdLlbBhq/+0YekyjA/ojSQZvHgIs4drUt
ARC-Seal: i=1; a=rsa-sha256; t=1527156340; cv=none;
        d=google.com; s=arc-20160816;
        b=z2fmcPzhbzWh626JE6dO2TWl7aLdH6VbKSaxaDhSx9ahHWpHPPpFQz6uo0R9IsZ/f6
         Bw+RCrtHCkSG20YA+MYwOnSU7FQKk1cTUTYKLWfYs0/DlZ07Btf99PV6/0gPIjy4AcTt
         owcZmbpPYCLK9XdNPoR6h14A/6JcCHVc8Lnw5eL9/r0Yw51uCLEDygHptNMukMsJTBoO
         v+MEeRodkXu7qwDYhc4mQ5QEbBVim6q7A/UOBt0e6DMdBjuHTIl8tiKL+FPqmDTziIIh
         6ISOn1jE6oPcoTnllBzxC/e2a7PeR6JeWp4dSjHvg4u9R00x5k8jDo1Mr0f5x3wCkAJ7
         n3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9bFhn2TlvvHl/aJCfh++FU1z3162GBByFxzZZscQMSg=;
        b=aIdbuQRj/SuQ3+aDBgLjwNBcS87QxgxcLQhr5+OcqVdK2hxTp/2Pe1fziU+39PBobO
         tSKyuyeDSZRxje+hr4mFxS2aNHzTp96oFlZ2SAIcmOlJrI6jtZEs9a7jOfA/RWm9qnEY
         3KMyqeDOhjHvuqjB8S6v1QmCxgcXhS4bDbbFekLdRLGp4/8pH0yeoykquGaVcnD0IdSZ
         mxmmV7Rt0Ift4eXMREop0pZyNvqSZ3Wo7UWT/ToVmdWl1PTl/KgER5RZn422Q3oy2hw/
         AxUt6faI6lN5KOnMaaTYpu5viKNthWE2JNFGtxiNIZr+iyId71TGtVSP7uq4WGYkogsg
         hPag==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XRRu0cqJ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XRRu0cqJ;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 152/161] serial: arc_uart: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:37 +0200
Message-Id: <20180524093036.463094416@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338563820395981?=
X-GMAIL-MSGID: =?utf-8?q?1601339487157088596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit f9f5786987e81d166c60833edcb7d1836aa16944 ]

The arc_uart_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_ARC_NR_PORTS), so this can even be triggered using a
legitimate DTB.

Fixes: ea28fd56fcde69af ("serial/arc-uart: switch to devicetree based probing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/arc_uart.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -593,6 +593,11 @@ static int arc_serial_probe(struct platf
 	if (dev_id < 0)
 		dev_id = 0;
 
+	if (dev_id >= ARRAY_SIZE(arc_uart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", dev_id);
+		return -EINVAL;
+	}
+
 	uart = &arc_uart_ports[dev_id];
 	port = &uart->port;
 
