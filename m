Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49GrvP8HP0hDj+soQ47Pk9c3NbkjKlKOq8w5s1Wz1VVswOPCaPYdKaiQjlsjJ+Uvy00/7BY
ARC-Seal: i=1; a=rsa-sha256; t=1523473269; cv=none;
        d=google.com; s=arc-20160816;
        b=uWvcXBCiWNPMojpD6CNdKTf4RPiadZ0lI5rgiKQjboJ55dZ7jskahCbyREA/OmkqE9
         77IGr0ZviWmAd02Q8zEtJdulZ5R3Q9OE308NlXwANu2u0/d40sfjwaEhWVxD4zdIktqr
         04sJ57sWDI4/TDAMmfTyEm9BgwChEmzfXPisXUd4RIK9Vk/T1IvQ8LjxPRaNMUcGHOPT
         njE0iOdmrGj4Bbbyyxh6OxkjbL9HgryNceV68XOWPymA6TDP55EBd2iJY7D2oJCsTOYm
         DpAyMNxqF+IpzeJqxLRZI4GwOQZmqd+oK70E9/Rn4ENv8mhLm1vGaKLhR/UNeV7RbBsQ
         FRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2zLNpTn03kmoYJWtOID09fA0BOxCFrvOohmL9ash+4M=;
        b=GoteHgdTm/c8TghXh9so8GAtogvHPXuVTVLoJJzyM8g8wIyxQjTgVV4nxWqc8xwjvU
         AQO99TFa+wu1Qr9LaTofoyC8oLLl/Gv7F2V7npVDa90/tAb2Kyi7d3IUWJeaD9Jx4tHA
         RPT84IwGVyFUvxqCvl+82n0cCHCWdLvQQRQaz6yqsXyyLiBML9JCe/Y5OJJKenyMiIJP
         +nltI5rtbq/AnYuYFiwJ6thVd6Ze90+RH3w8N/HEqOnLdgfBt80QFMcZbjCYz3D/yPpd
         +f4Xvsjk8826Uo7SgE6xGUro6lGZCIUxoklZHBGNgeTTRBtX9O0v+t5txSxe6zKRAR5C
         A5uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 187/310] Fix serial console on SNI RM400 machines
Date: Wed, 11 Apr 2018 20:35:26 +0200
Message-Id: <20180411183630.655942922@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476214276262025?=
X-GMAIL-MSGID: =?utf-8?q?1597477507129457493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>


[ Upstream commit e279e6d98e0cf2c2fe008b3c29042b92f0e17b1d ]

sccnxp driver doesn't get the correct uart clock rate, if CONFIG_HAVE_CLOCK
is disabled. Correct usage of clk API to make it work with/without it.

Fixes: 90efa75f7ab0 (serial: sccnxp: Using CLK API for getting UART clock)

Suggested-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sccnxp.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -884,14 +884,19 @@ static int sccnxp_probe(struct platform_
 
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		if (PTR_ERR(clk) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		ret = PTR_ERR(clk);
+		if (ret == -EPROBE_DEFER)
 			goto err_out;
-		}
+		uartclk = 0;
+	} else {
+		clk_prepare_enable(clk);
+		uartclk = clk_get_rate(clk);
+	}
+
+	if (!uartclk) {
 		dev_notice(&pdev->dev, "Using default clock frequency\n");
 		uartclk = s->chip->freq_std;
-	} else
-		uartclk = clk_get_rate(clk);
+	}
 
 	/* Check input frequency */
 	if ((uartclk < s->chip->freq_min) || (uartclk > s->chip->freq_max)) {
