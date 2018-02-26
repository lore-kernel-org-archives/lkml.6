Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsd3gjsWhPygpEFaLkQUSEHf6Vf+zlV53BJy3o0cgdUA7aKlQK2duc8Z6A5QZr0JxAYvHHb
ARC-Seal: i=1; a=rsa-sha256; t=1519676597; cv=none;
        d=google.com; s=arc-20160816;
        b=HP+bD8FQOa7QgiS82/U/3ULYvNlTpX2fC1X2VqWKKTyMyLE2jvRJLloNTVfmu2sSgX
         TNkZtZm//7pNauhxAkugtJOHqvkOwCv4GEuiXeFysUAVj+ra0uZYoyJtFQkQukdOj/9F
         fAPzLJrFO/etbxsLa16gbT4ZQsItX6lfeUBQ26Qtsqgs17VSIwbqlSKg/A9iy1phnGzu
         D1M7n9IGOBIkbHxny6Kx8BtbYa+yNW7YcdE8rKSBSq5pb5zIqOb81vQtdt3fHY9Zaqgk
         4L5XVrePdG9I6Q0UFUHtllSRbDbZfHgIEbhG4xNMHCCvRaaZYvI1eOpPwqdHzGU+fZfy
         Q9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=e+f2tTjUdMXnxnXiJ73cHw9d6mh2AKnQzyxMuUho88k=;
        b=WiRMpLP17DCSsUvwA9fX6RnzQAbvTWxL/0Lbb8e+3yKRkT2lInWNrCYfT7ALQir7HJ
         Mf2p1VC86hhjcoHXwUvP3UjEVNQhp1N/qdpaG+84Ry85EfqWEy9By+MHXxwhrsSDvDsr
         f7ve42jqqiew3eeN7fk3nyk9r6GECSmDaJq7pLKFo/QPuflGEsiuX1YW+bihB/v8pIo7
         Y1N3JIcAOUO0fJGhl+jFGatEzkTus+a9LjC87K6PRVMLTEH0tFlBg8f78CqZdX+fGtw6
         7T5G7QJIMqZLhBynqHjJSpPNTPVi3YuWJBhfJYyXcNLmRGuWWoZdrfJl0Jm1CJI+2FCk
         /Hpg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Anholt <eric@anholt.net>,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	stable@kernel.org
Subject: [PATCH 4.14 10/54] i2c: bcm2835: Set up the rising/falling edge delays
Date: Mon, 26 Feb 2018 21:21:47 +0100
Message-Id: <20180226202144.869715000@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496407794895346?=
X-GMAIL-MSGID: =?utf-8?q?1593496407794895346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Anholt <eric@anholt.net>

commit fe32a815f05c8568669a062587435e15f9345764 upstream.

We were leaving them in the power on state (or the state the firmware
had set up for some client, if we were taking over from them).  The
boot state was 30 core clocks, when we actually want to sample some
time after (to make sure that the new input bit has actually arrived).

Signed-off-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-bcm2835.c |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -50,6 +50,9 @@
 #define BCM2835_I2C_S_CLKT	BIT(9)
 #define BCM2835_I2C_S_LEN	BIT(10) /* Fake bit for SW error reporting */
 
+#define BCM2835_I2C_FEDL_SHIFT	16
+#define BCM2835_I2C_REDL_SHIFT	0
+
 #define BCM2835_I2C_CDIV_MIN	0x0002
 #define BCM2835_I2C_CDIV_MAX	0xFFFE
 
@@ -81,7 +84,7 @@ static inline u32 bcm2835_i2c_readl(stru
 
 static int bcm2835_i2c_set_divider(struct bcm2835_i2c_dev *i2c_dev)
 {
-	u32 divider;
+	u32 divider, redl, fedl;
 
 	divider = DIV_ROUND_UP(clk_get_rate(i2c_dev->clk),
 			       i2c_dev->bus_clk_rate);
@@ -100,6 +103,22 @@ static int bcm2835_i2c_set_divider(struc
 
 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
 
+	/*
+	 * Number of core clocks to wait after falling edge before
+	 * outputting the next data bit.  Note that both FEDL and REDL
+	 * can't be greater than CDIV/2.
+	 */
+	fedl = max(divider / 16, 1u);
+
+	/*
+	 * Number of core clocks to wait after rising edge before
+	 * sampling the next incoming data bit.
+	 */
+	redl = max(divider / 4, 1u);
+
+	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DEL,
+			   (fedl << BCM2835_I2C_FEDL_SHIFT) |
+			   (redl << BCM2835_I2C_REDL_SHIFT));
 	return 0;
 }
 
