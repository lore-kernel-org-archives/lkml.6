Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rYw039eCEzdb7B+GvkxAjwWI/NiQUOuV5sxIxfwHl2rRs0+5NHsaQ74mpdQ5NX6MbAH9h
ARC-Seal: i=1; a=rsa-sha256; t=1522168399; cv=none;
        d=google.com; s=arc-20160816;
        b=efcYeKnuGuQ9BrmoF/humTz690rwYEHaNIrPHxfERdmdcsgnGl4alyGjWG/KvGgTG4
         UXuB6SZ55LyObs8oMW2R/vaEw0j/UOsemGtgVV+FOx03z+DLF3qfukL30C21Tzbh5Wte
         t4nOUudG1BV6gxc/j7b22anPwQCQvUF6tvl6Q6cmnYwaDhR2heQ1joQredgbP0PQ3/aN
         3A340kRJwSeg4pii7bLeEGHdv9hU75wuvZC+r38pdSpjHJOlrJ3n5cu3aOv48k1VfB8/
         di8IgYOYV6oTVnvGgs+nCKnze5hneqsNGLz7tufLgYXHR3Uz3dHuwRsV/b5aP6fU6Qro
         B8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9AvG6nEfRh3xqForYANZuOV/cXY7qH9TTNGatlwrv9M=;
        b=n3j3mAnGFNa4bKXTUv/h5/u28D6cDrXPbIknqd7IwRhCQrWjno2+t69mJUoysDhKdO
         yOIlfO7lKftouKHUJ6RIiIJaRj7RkYcP7J7LVEKftxqkl3ClaJkoK5A02cgvMJu7ILO8
         SP8bAkeOnpu7xMmBNVXWL02V18DegqEFLcj1uup9iTiyBKrywm97cchd8RzEouKLqcSX
         tKM6WLKjCApKvMurgGmNgo9jp2ZFR5W38C88kzuMn0a1Se8Gz1tqbO8OIE46TRqztx2D
         Sd0VO16qx9rftXLmCbPaawhiqzz6xIhKtKPTINBlz2aLt6A9T8QZe+blwfI0WxwCT7+9
         yLtw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marek Vasut <marex@denx.de>,
	Heiko Schocher <hs@denx.de>,
	Markus Marb <markus@marb.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.9 44/67] can: ifi: Check core revision upon probe
Date: Tue, 27 Mar 2018 18:27:36 +0200
Message-Id: <20180327162729.536862203@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109251430732676?=
X-GMAIL-MSGID: =?utf-8?q?1596109251430732676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

commit 591d65d5b15496af8d05e252bc1da611c66c0b79 upstream.

Older versions of the core are not compatible with the driver due
to various intrusive fixes of the core. Read out the VER register,
check the core revision bitfield and verify if the core in use is
new enough (rev 2.1 or newer) to work correctly with this driver.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Markus Marb <markus@marb.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/ifi_canfd/ifi_canfd.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -144,6 +144,8 @@
 #define IFI_CANFD_SYSCLOCK			0x50
 
 #define IFI_CANFD_VER				0x54
+#define IFI_CANFD_VER_REV_MASK			0xff
+#define IFI_CANFD_VER_REV_MIN_SUPPORTED		0x15
 
 #define IFI_CANFD_IP_ID				0x58
 #define IFI_CANFD_IP_ID_VALUE			0xD073CAFD
@@ -943,7 +945,7 @@ static int ifi_canfd_plat_probe(struct p
 	struct resource *res;
 	void __iomem *addr;
 	int irq, ret;
-	u32 id;
+	u32 id, rev;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	addr = devm_ioremap_resource(dev, res);
@@ -957,6 +959,13 @@ static int ifi_canfd_plat_probe(struct p
 		return -EINVAL;
 	}
 
+	rev = readl(addr + IFI_CANFD_VER) & IFI_CANFD_VER_REV_MASK;
+	if (rev < IFI_CANFD_VER_REV_MIN_SUPPORTED) {
+		dev_err(dev, "This block is too old (rev %i), minimum supported is rev %i\n",
+			rev, IFI_CANFD_VER_REV_MIN_SUPPORTED);
+		return -EINVAL;
+	}
+
 	ndev = alloc_candev(sizeof(*priv), 1);
 	if (!ndev)
 		return -ENOMEM;
