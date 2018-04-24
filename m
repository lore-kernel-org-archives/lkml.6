Return-Path: <matthias.bgg@kernel.org>
X-Google-Smtp-Source: AIpwx487mIv33SEi6W0bR+GlZb7vZPa4nBt0ql0BoxbKItvbcAt15Yleim8xLPoF07b5t9c7QjNn
ARC-Seal: i=1; a=rsa-sha256; t=1524563287; cv=none;
        d=google.com; s=arc-20160816;
        b=SvMzWt3vPoh6CXzkS6tWQ5jSdAfjs8y19bwiSZk/6Bzy5IbRPbHztCCIwyVL3hlEUj
         vyQ6remAmy3NA3VxLAHwLOnez9WUvzXVYwWHDNB+nhJCKltKK2AgI+C9NTEg0ZitJuYi
         sd8KZOiLm2wfxGcyW83atY5d+ut31c+a1zSeK0oLC4czJdfg0SGoIhRyHTphLueeMM7l
         kH2YjMB4MRkgQf/lane22z8jxHAkvMVw+sBt0b34mJk0h8nqkEPgu3uibObtIgdjo93x
         YJVbCUv83c9tRUt7lPKi3PW7jRqKeELv3oicOlqCMRijkNmQ9DPGC+q3mNPkwJE5cY+1
         kaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=dmeCkJ7AvKJtcBLqEPUe9SmlWlckwxvG0vcODkRP51E=;
        b=Eq80MNVcYwWDQ6bg+VM2SO1AhmJTzwxujidrcnZASmepPGBWbvgTP1VHZ1IY1r40H9
         zKa9fGu/zrC+Sv2YIZnVjOWaIehq2sri5LJvAXX+hFWjNNaCngiljXMwERxBaYMbpaxI
         Hsw0ZVV+RIRH5yC5oThvsWUkrQ1qqfJsZ7Y9CxE29zl/3oQhCZ9gsdv/3DUmXIthIE7g
         Z7Ccr7h+xMKsTt1smlhudSWiW3GuS1n4idHJaVPFJDTAUsP3434Y59RV2onRej8VYmQY
         Kxm14UsXASdowOiGboGGg9QkzKXM11ibbf7Kwj+LxHlnNJ9MJTvV2fq6MlfftVAZNBIj
         o3mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of matthias.bgg@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=matthias.bgg@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3E29217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=matthias.bgg@kernel.org
From: matthias.bgg@kernel.org
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
Subject: [v2 resend 09/10] drm: mediatek: Omit warning on probe defers
Date: Tue, 24 Apr 2018 11:47:06 +0200
Message-Id: <a698a40ce7723200fd55d0d98daff5a28a7d0039.1524563001.git.mbrugger@suse.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
In-Reply-To: <cover.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598620474277711521?=
X-GMAIL-MSGID: =?utf-8?q?1598620474277711521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthias Brugger <mbrugger@suse.com>

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
