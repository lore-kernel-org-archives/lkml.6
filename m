Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTQ+o7NXQkvsU/mMiBCLkMdD3QG3iuxkLrdl1a9DX1lEriwAMPvH8CT0ckF67yke34KTXt
ARC-Seal: i=1; a=rsa-sha256; t=1521483510; cv=none;
        d=google.com; s=arc-20160816;
        b=uSw0DpLR/wd/DnAPwAVuWeE9ptdfYh6eX/i1LXIvZEE9TM3JgQduJGJyEuHj3+Dq17
         tg1LGV/R02BUpxM4A91+Ke9x5gXmsBeuNZqkaDSX/giky5d5lZPz/iikbRQWc/G7fZ71
         M2qZv3sxOoYoOhzp/yjiOvO8u1GrYlpemzRnf9cvaBgyRGBVC8OpnLrHAPq5LHsCDucP
         30VY3PhOVG26oHJc32p2J717RuUOiIFe55HiL3I2qI5kr0CJHCZiEN737DXig7NSLWd+
         5mAPHI1ZiYSpc/ZLulZA2nJ/e/o7f6A1Eqx1TrkHBAyHRq7KI+Q+Ix2koDNJCuwVV1s6
         xb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NGaDjAoY/bx14iyI9Z2HYdOBJfnWy714SdrZ1884hzQ=;
        b=QWTmKq/yU3oZRHhGMNMSd/cJVoikFNyF3Y077hGTN8ih/kn++2fB8jkH6Io/tq0Es/
         290sGuMXxvroiIMMX/mPChpwo0XdYYZ0GZaPhex4ulF2FGdjS+hxDCvqUFHZ3epv3gUR
         GRn5uK7jWw/EI3MdwP4wca2rN+lHTrcF++c/g/ZOFULDKGzB1LxniQ6QG2bO1y0Eh7Ml
         3Ppzj8D6w2ztwNtt+hE6ew8XaZq6vsq+UNEBdadbQ/8er+U6UlYV2SfEpJQwu0gUijbo
         YlLn4BbezsFFSPXx/yUqehgct6z0bBUzk+LNP8NUE4DyiimjX13m9YgPAqRcLR76GPXZ
         CMUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 016/241] drm/sun4i: Fix TCON clock and regmap initialization sequence
Date: Mon, 19 Mar 2018 19:04:41 +0100
Message-Id: <20180319180751.842712764@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391093394652122?=
X-GMAIL-MSGID: =?utf-8?q?1595391093394652122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@csie.org>


[ Upstream commit 4c7f16d14a33a9cfb4af9cb780d8a73bcca64a92 ]

The TCON driver calls sun4i_tcon_init_regmap and sun4i_tcon_init_clocks
in its bind function. The former creates a regmap and writes to several
register to clear its configuration to a known default. The latter
initializes various clocks. This includes enabling the bus clock for
register access and creating the dotclock.

In order for the first step's writes to work, the bus clock must be
enabled which is done in the second step. but the dotclock's ops use
the regmap created in the first step.

Rearrange the function calls such that the clocks are initialized before
the regmap, and split out the dot clock creation to after the regmap is
initialized.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -336,12 +336,11 @@ static int sun4i_tcon_init_clocks(struct
 		}
 	}
 
-	return sun4i_dclk_create(dev, tcon);
+	return 0;
 }
 
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
-	sun4i_dclk_free(tcon);
 	clk_disable_unprepare(tcon->clk);
 }
 
@@ -506,22 +505,28 @@ static int sun4i_tcon_bind(struct device
 		return ret;
 	}
 
+	ret = sun4i_tcon_init_clocks(dev, tcon);
+	if (ret) {
+		dev_err(dev, "Couldn't init our TCON clocks\n");
+		goto err_assert_reset;
+	}
+
 	ret = sun4i_tcon_init_regmap(dev, tcon);
 	if (ret) {
 		dev_err(dev, "Couldn't init our TCON regmap\n");
-		goto err_assert_reset;
+		goto err_free_clocks;
 	}
 
-	ret = sun4i_tcon_init_clocks(dev, tcon);
+	ret = sun4i_dclk_create(dev, tcon);
 	if (ret) {
-		dev_err(dev, "Couldn't init our TCON clocks\n");
-		goto err_assert_reset;
+		dev_err(dev, "Couldn't create our TCON dot clock\n");
+		goto err_free_clocks;
 	}
 
 	ret = sun4i_tcon_init_irq(dev, tcon);
 	if (ret) {
 		dev_err(dev, "Couldn't init our TCON interrupts\n");
-		goto err_free_clocks;
+		goto err_free_dotclock;
 	}
 
 	ret = sun4i_rgb_init(drm);
@@ -530,6 +535,8 @@ static int sun4i_tcon_bind(struct device
 
 	return 0;
 
+err_free_dotclock:
+	sun4i_dclk_free(tcon);
 err_free_clocks:
 	sun4i_tcon_free_clocks(tcon);
 err_assert_reset:
@@ -542,6 +549,7 @@ static void sun4i_tcon_unbind(struct dev
 {
 	struct sun4i_tcon *tcon = dev_get_drvdata(dev);
 
+	sun4i_dclk_free(tcon);
 	sun4i_tcon_free_clocks(tcon);
 }
 
