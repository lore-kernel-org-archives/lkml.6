Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225XTZ0a7hMAfsV9YVAJlIivozrUUuwEwAtqa330e7q1bz/CcK8mdJukKCkdJmsg3Bguf8DT
ARC-Seal: i=1; a=rsa-sha256; t=1518709045; cv=none;
        d=google.com; s=arc-20160816;
        b=Tz5+H8OIXz+g/ioLiO4HFIbYeWyRdSeCGB5pujLHHHHHxgFF8QF/pqctEUOOw33I4l
         6UNNVvRQxRs8NHoqQwvQFfgr+BQkLZeB+c+PBS4eNLTzsQdo3zldO/MKzyyvKnxvAXvk
         x0Ymt1fuMk0xDcuTrI+k3onAjEBnH6V6B26EVzADVTrnqF4nyp2TpcIEy3g4mDPEI9bU
         HzW51f+n3YOXsIO3t2jmdu0NMEpEVWVMNKBu71haJEW1/NaC+B9bt5vlnh4BoWo3YWxJ
         iwJ51j2UT8ImwHrMXZoWuxT1tKvh1RefBldUP9DVO9sftATTpMilFLA3DZAdob4zxZ32
         RgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6qjiO/5qc8Pq/nsgFOjQMYrtLuGz2kui0tL0c2Py/Nw=;
        b=EC0sL6O7gpePmjnY/LZ8TBFxqvA8+bcTwz6Hg6qIjwhRGbZSbTRIVpvQjjptgTvDhj
         q9MxInc4TJ3GWfmsePWKe9BaiEiX8357rzDS9ToirF8dmF8gRv/f4TkGiWL8ioFbh3Lt
         lRi4Bv8luOE5MZbQL3ub+G3cXNaMw5PYl4VzCgyetc8p3L9A6PuSNUZua6bQIrV+YvWR
         FSQe0e0xI156FJNUM/9D0cbWUplQLZKQGLE9MMaE6Ya0f7HY26r3j0HGddM4V/oFFM8n
         eJVUzBPb28id5AGMgGmJl4c7WEDFIaVYQFEtHf18uJETmEikUvW/2WIwY9StJ93ktn3Q
         NBEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Mastykin <mastichi@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 172/195] pinctrl: mcp23s08: fix irq setup order
Date: Thu, 15 Feb 2018 16:17:43 +0100
Message-Id: <20180215151714.663835340@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481856301862398?=
X-GMAIL-MSGID: =?utf-8?q?1592481856301862398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Mastykin <mastichi@gmail.com>

commit 02e389e63e3523828fc3832f27e0341885f60f6f upstream.

When using mcp23s08 module with gpio-keys, often (50% of boots)
it fails to get irq numbers with message:
"gpio-keys keys: Unable to get irq number for GPIO 0, error -6".
Seems that irqs must be setup before devm_gpiochip_add_data().

Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-mcp23s08.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -891,16 +891,16 @@ static int mcp23s08_probe_one(struct mcp
 			goto fail;
 	}
 
-	ret = devm_gpiochip_add_data(dev, &mcp->chip, mcp);
-	if (ret < 0)
-		goto fail;
-
 	if (mcp->irq && mcp->irq_controller) {
 		ret = mcp23s08_irq_setup(mcp);
 		if (ret)
 			goto fail;
 	}
 
+	ret = devm_gpiochip_add_data(dev, &mcp->chip, mcp);
+	if (ret < 0)
+		goto fail;
+
 	mcp->pinctrl_desc.name = "mcp23xxx-pinctrl";
 	mcp->pinctrl_desc.pctlops = &mcp_pinctrl_ops;
 	mcp->pinctrl_desc.confops = &mcp_pinconf_ops;
