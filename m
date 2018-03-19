Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuV+RJny0QXTJ3AZkXgUXoW+wF5E4ttY5oR3HxnnX5qb+x1PwPMryrZHlHdEvnpQp8+VtMw
ARC-Seal: i=1; a=rsa-sha256; t=1521483174; cv=none;
        d=google.com; s=arc-20160816;
        b=rjVZ+qQIEyfTP95yqHC7gtg5oVYm1vueYNG1wyTZN++rQZhlVdbTN5Mg2rLjsJMzHp
         wJH1T1OWpSdGskCNa/ncUtk+GKpv8RWk7NX1BG7ldZ3ShJWdioXWNhqLZI6IiCwMkTLO
         Yyp/lGVWNQpcgEFgUtmPxY9ZDLl/XC/SeoGqtXRnI85+qjgh+kpZ1Thph9yBS8eLceft
         WFqKSssCQCoyl9/cTpikDJJd3N3NgPUJyfBuVYd/hRs+kzmid5zoE0yQzesZ7zxJnDJB
         1cKHZBGqr6YgHWvdu9Nbk3gaRxCpECDB+SRJhR97kqQRU/fYTxEeElfG66ouwFm32hHT
         6wdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V/jKTivUXPnkaRhNsbnH9v1amidCPq+x9v6o2/JBCek=;
        b=UHqam2G5U7FRrxxPFdxlURMI8RWJ8hBqs9Bp/nk6mBxUlggSy1XTApQfmR3fEjijoA
         ZZGOoGq/bhpZDLl1JIykGfEnu5j1JPsY6kjOjwm/a5rxIv/Z3+NP68w18IM8/FMD6W2i
         uo7GELfXS9S0GGJTxpyH+NMmGNnKqSDDrBB2fxg/OtaBl2rQnWpKn/r/NmQ6b0GyGRee
         EGHuMLO3hjlUeaaRLEhmfSTdKmYf3EOH/f1O9KI3rlNzeWt74x0fuvgkn0Jr/8BfWHzB
         S7RyedyyKMHvR/yUzsLCAnWYpBw61yvq6Z0Vs0uTB4DFBJaSPMpHBkH52l9+d6oV76kh
         Hbfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 026/134] [media] media: i2c/soc_camera: fix ov6650 sensor getting wrong clock
Date: Mon, 19 Mar 2018 19:05:09 +0100
Message-Id: <20180319171852.960813790@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390514017985575?=
X-GMAIL-MSGID: =?utf-8?q?1595390741108404491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>


[ Upstream commit 54449af0e0b2ea43a8166611c95b730c850c3184 ]

After changes to v4l2_clk API introduced in v4.1 by commits a37462b919
'[media] V4L: remove clock name from v4l2_clk API' and 4f528afcfb
'[media] V4L: add CCF support to the v4l2_clk API', ov6650 sensor
stopped responding because v4l2_clk_get(), still called with
depreciated V4L2 clock name "mclk", started to return respective CCF
clock instead of the V4l2 one registered by soc_camera. Fix it by
calling v4l2_clk_get() with NULL clock name.

Created and tested on Amstrad Delta against Linux-4.7-rc3 with
omap1_camera fixes.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/soc_camera/ov6650.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/soc_camera/ov6650.c
+++ b/drivers/media/i2c/soc_camera/ov6650.c
@@ -1033,7 +1033,7 @@ static int ov6650_probe(struct i2c_clien
 	priv->code	  = MEDIA_BUS_FMT_YUYV8_2X8;
 	priv->colorspace  = V4L2_COLORSPACE_JPEG;
 
-	priv->clk = v4l2_clk_get(&client->dev, "mclk");
+	priv->clk = v4l2_clk_get(&client->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		ret = PTR_ERR(priv->clk);
 		goto eclkget;
