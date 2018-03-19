Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuZOXYtZCMxlfiVuWMPlJ8wPTs6xsjba1Mr6WHuSMYpjaZ/iuOPD5e7+7EvjsxD+s0PQDeP
ARC-Seal: i=1; a=rsa-sha256; t=1521483623; cv=none;
        d=google.com; s=arc-20160816;
        b=WutXJWayJTF8LNP7NMgiqj0fs5YsZ2D963FWtsdtaR6N9f5jlRqcUW2gy2T098n/3k
         riMAMenuxrKK99jjOJdl6XxYK6oY3O9Rdsn6jtRUWq10pjiz5Wo7NFoHHqvEx35tIiH8
         6R27Ms8cj8GA9XgYelyuHk0O44KNISvPOgqjrKMY/ZnhoYLR6ztWLS97Mmuf+WAI3sXq
         5EhXcr33iKyMJ1J05+EYc6oweYJLA2nF4RUPL1aTfj9dCS4ptEXZxoS7fqaczsR1S0jJ
         +mmfeFpWHeTxOM610DB/pFoLtX6ydFV4Gc98sPOZ8pkxQPLP8WHHIdTD5ck/POT4V1Rv
         xluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dZNtslrSWIcA4dvCoi3furouGOErzVHG0Di18niDbWI=;
        b=NnI/pvun1IrKGETpRCOoByG5ilrsqfJD+ti0F4bPCo13jABFieZtjOHKGDwzPHKjJ4
         2JAotQcfD4bhGOhZ/dgp8NrtSuFCoCIJy95CM0+DJLzWxAgL9E46tgzhHLvbagXTbQvE
         RrwuZbydornDD2RtMnqokoRaYALvytt3MxzBphqM2DUmVeOOi79ip4NkYbDjpG4HRXnZ
         EJeXnmUx2Iml3+WFADDUtrLEGfOu4O0YPjLAb8XpDrINAKPvVkt7710GRgTYpkZd2nKB
         kGKo3CzKHgqwHxShZCF4gaowTuC1fbAaiHQCDRiDnHraxaDenrHORMedCCHkcElnkvxW
         aCeg==
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
Subject: [PATCH 4.9 055/241] [media] media: i2c/soc_camera: fix ov6650 sensor getting wrong clock
Date: Mon, 19 Mar 2018 19:05:20 +0100
Message-Id: <20180319180753.495272584@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390514017985575?=
X-GMAIL-MSGID: =?utf-8?q?1595391212035425639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
