Return-Path: <mbrugger@localhost>
X-Google-Smtp-Source: AIpwx4/s82glnrSQBnzvcBqIWwNE9PDxsM6YMV0C1HCbqkZRcI7XC203bW1BAP7zCzQSTepVMGxF
ARC-Seal: i=1; a=rsa-sha256; t=1524497543; cv=none;
        d=google.com; s=arc-20160816;
        b=Gqu8n+xm+EctJWBwywI1NLQPvkOIRyyrIZJIYRWBoO1qG3wD7nOa60QabfSUiMZ5Aa
         J4Hz5JNEVTJRMb84DmtpKy/BhQG0+LfrOuC1uKBlMy9I+ftILSOym5/yV6y3VBmVVee4
         kHSVx/eza1Iugb2ANHzf1WoBX5eyrwkz0hcMeloHUXwTqJIoNaIbP1tq9KiMcjxGiKMP
         nbLL//2TFe76zEILIjKKdQQ4kxYI1h5g+5dsqQxDx2pCoZFsdCZHEuilaJKlW9sqCaqf
         2HNfrJiwSnaHSwk/ibDh2h0nEqG9/o67k+vIs0cMK+7dxQjsIzLATOAv62/a9QY8v6vu
         M0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+QvzcGC6csGQXahtI/hLxzb11vgORFGd55YQO4yHT4E=;
        b=m4e8dpjyQPHprhpfhgch5Y33VdyRv89YuLETYLVkhupIRmU2FOa9C/3TwhmnR5YuLk
         obW+z3mlayrhqTbrFFVgCVXe/a9xb4Mrylb0OZh7C0vhex+wh73dPMbMdHmapGDRn2Mp
         oKIS4FIH8fQ7JcAek4W6TmsTQzETKdTNILS50PXJ1brz9l2SBZz97vlZgQdJ2PecKUFS
         8RRtGBmrQFQhtQ9UtM/JdauHdJbDBLBUooW6lB83gwXBqV4p540CNh5gM5qYNUxAu832
         oC1JNOZ4udphluHqi0QtnKVShJOrtuBlui1Pk35EpNS6RnRCy4jJHUvg0av0yaCFli1W
         DVUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 37.223.140.222 is neither permitted nor denied by best guess record for domain of mbrugger@localhost) smtp.mailfrom=mbrugger@localhost
From: Matthias Brugger <mbrugger@suse.com>
To: ulrich.hecht+renesas@gmail.com,
	laurent.pinchart@ideasonboard.com,
	ck.hu@mediatek.com,
	p.zabel@pengutronix.de,
	airlied@linux.ie,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	mturquette@baylibre.com,
	sboyd@codeaurora.org,
	lee.jones@linaro.org
Cc: davem@davemloft.net,
	gregkh@linuxfoundation.org,
	mchehab@kernel.org,
	rdunlap@infradead.org,
	pi-cheng.chen@linaro.org,
	sean.wang@mediatek.com,
	linux-clk@vger.kernel.org,
	linux@armlinux.org.uk,
	matthias.bgg@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <mbrugger@suse.com>
Subject: [v2 09/10] drm: mediatek: Omit warning on probe defers
Date: Mon, 23 Apr 2018 17:32:08 +0200
Message-Id: <a698a40ce7723200fd55d0d98daff5a28a7d0039.1524497268.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
In-Reply-To: <cover.1524497268.git.mbrugger@suse.com>
References: <cover.1524497268.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598551535967617451?=
X-GMAIL-MSGID: =?utf-8?q?1598551535967617451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When probe through the MFD, it can happen that the
clock drivers wasn't probed before the ddp driver gets
invoked. The driver used to omit a warning that the driver
failed to get the clocks. Omit this error on the defered probe path.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index bafc5c77c4fb..6b399348a2dc 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -374,7 +374,8 @@ static int mtk_ddp_probe(struct platform_device *pdev)
 
 	ddp->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ddp->clk)) {
-		dev_err(dev, "Failed to get clock\n");
+		if (PTR_ERR(ddp->clk) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get clock\n");
 		return PTR_ERR(ddp->clk);
 	}
 
-- 
2.16.3
