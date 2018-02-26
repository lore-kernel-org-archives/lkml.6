Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227JESoqxz4VUGq68YwLwFQKzdPZlivYJQDUhP8WqjYKo054wCajNIoQxQERB3UbQJEqieMP
ARC-Seal: i=1; a=rsa-sha256; t=1519676886; cv=none;
        d=google.com; s=arc-20160816;
        b=pbtEWKbWIAqcC/UJzvcSRI5npPuznsXesqtDfXJuPrkGHYtDtG+V3mh629C1Tde5Fh
         BGoBjlGL1DZEplcUfPodz/scsTN9n9kHmddnfHkslqCChKUTmuX8tE0GaCDKXnw8eC5j
         pI3bNJptYn8yXzunr/elI/GM+qr8wYmbfqYp9ID4d4Clmm0dp9aAgZy9CmIKunx7pPVG
         Mb8Xj3L2rUZMQ7x0GQW2/HEZYdAnNoDUgVnMjwhryAfzkTeJr1W2eJbyj2u8oPEiJHHi
         4Ev8AqOVA69izMz1bOXxh8xWmTk3L6CAycTn7bJT2Y3iV14oQPgjmibc6FehAjGX01AB
         xXeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Bnbz0IGNpt9jPtiwqkQKT4bbYGG96HCvfdzDOmQK/II=;
        b=WgNQdT/xmPO3LFAwniuLRvp5oqg6x2qdT2FHGVfAdU0jQSD2o+KGw8IJ0PLv5H6cyL
         tSnO4EO0j3BVnfI6OgM+OtMmvkRafumX7w05Q5i0pfnf45aCQvH/dt146HHgW5qOchfM
         Sf2bcKakYvgeoEuACUZuv8klv2J/5b7yYX4WcZY2s5164JTbxG1h+zN1R5V4aGZ+pr8O
         Bir2NH40i6QICRV242sHT3pQGUVO+t9wjCrA9N41o5n6WxlF24WseWpIoq5pzO8HWDaX
         BDwRgUSWh4wM1NV64bcaowGTwS5pb7VQSRD2pxrC0dU1+wvKGG6rG1fPSmPBHE0kQKmT
         FIqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Li Jun <jun.li@nxp.com>,
	Peter Chen <peter.chen@nxp.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.15 47/64] usb: phy: mxs: Fix NULL pointer dereference on i.MX23/28
Date: Mon, 26 Feb 2018 21:22:24 +0100
Message-Id: <20180226202155.466230975@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496710797544236?=
X-GMAIL-MSGID: =?utf-8?q?1593496710797544236?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>

commit 499350865387f8b8c40a9e9453a9a7eb3cec5dc4 upstream.

Commit e93650994a95 ("usb: phy: mxs: add usb charger type detection")
causes the following kernel hang on i.MX28:

[    2.207973] usbcore: registered new interface driver usb-storage
[    2.235659] Unable to handle kernel NULL pointer dereference at virtual address 00000188
[    2.244195] pgd = (ptrval)
[    2.246994] [00000188] *pgd=00000000
[    2.250676] Internal error: Oops: 5 [#1] ARM
[    2.254979] Modules linked in:
[    2.258089] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc8-next-20180117-00002-g75d5f21 #7
[    2.266724] Hardware name: Freescale MXS (Device Tree)
[    2.271921] PC is at regmap_read+0x0/0x5c
[    2.275977] LR is at mxs_phy_charger_detect+0x34/0x1dc

mxs_phy_charger_detect() makes accesses to the anatop registers via regmap,
however i.MX23/28 do not have such registers, which causes a NULL pointer
dereference.

Fix the issue by doing a NULL check on the 'regmap' pointer.

Fixes: e93650994a95 ("usb: phy: mxs: add usb charger type detection")
Cc: <stable@vger.kernel.org> # v4.15
Reviewed-by: Li Jun <jun.li@nxp.com>
Acked-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/phy/phy-mxs-usb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -602,6 +602,9 @@ static enum usb_charger_type mxs_phy_cha
 	void __iomem *base = phy->io_priv;
 	enum usb_charger_type chgr_type = UNKNOWN_TYPE;
 
+	if (!regmap)
+		return UNKNOWN_TYPE;
+
 	if (mxs_charger_data_contact_detect(mxs_phy))
 		return chgr_type;
 
