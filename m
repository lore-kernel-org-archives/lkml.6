Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu8QK6KjuRMTDiUuzAKYclZfL38a+6n33eJoi6WvX3I6n4wcdrExZduZG1EfwQeKbJfKY8H
ARC-Seal: i=1; a=rsa-sha256; t=1521483805; cv=none;
        d=google.com; s=arc-20160816;
        b=o1Sh/YjYuUTyLyrPFGnQuNe+ir5qd0MLqlu8X0T8pJem2JU7JAf4FMUgmu6HBGQCIr
         lq63r2SUkH8otveihRnCscgF7PhyogUXSqj5k3hqGoDTIjh3jJU9o5AXDbd98NAN2bSU
         RKCOImoAvOaO/xhhie39OSxZ5051auo/b29W3Em/7MbgDeKai938RzUKkmRIp5ShWTBZ
         G0QJfL9gKNTG571QOf2fTgjHKcpUK6yhfTtm27gzFKCpkLdT4eViE8AkzLTF+OYVc/Kd
         qIUjANi0HUKY4k3DS9hMupaIzeq9Fo46fR4OvMEvy0KbMXieZHwHE4d5Obh98S7X+nMk
         G7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cSBwTDfjV0Lm6yQEuE4jviKlw+EW32nXoa43ZLFxwnw=;
        b=HHTjSVrGEgSbZw4JmHTrT4GLk1YFg8tY5sqdObcGCAj5ZqRv9O76guk6pMflvXjKUG
         tMWolRrbL+G2euko922t53GlhJZgRgd5ExAHXnRgzHPY5OhKUAucwhI81Zmcn4UKqABp
         nmgPAa9m+nM66nH6PSnVwr3AX0klb5hUtgHgfDvz+9c1olq/HAE1UeuzsOBvbiS8R7z8
         RG795b+euuRS/HHImP4VZ6GyQql5jsEbPDLwnXWZSuwdOcNlSjmpUMqvvOEkrnkL/nG7
         Ra2dWAndFkYweEWi32nhXp8uqHynEsqR0X/dDUxM9C1nZlrEHpVV0o31QoHBDI8wPz1g
         s1Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Sean Paul <seanpaul@chromium.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 123/241] drm/rockchip: vop: Enable pm domain before vop_initial
Date: Mon, 19 Mar 2018 19:06:28 +0100
Message-Id: <20180319180756.292330703@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391402570792885?=
X-GMAIL-MSGID: =?utf-8?q?1595391402570792885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeffy Chen <jeffy.chen@rock-chips.com>


[ Upstream commit 5e570373c015b60a68828b1cd9d475cb33d3be4b ]

We're trying to access vop registers here, so need to make sure
the pm domain is on.

Normally it should be enabled by the bootloader, but there's no
guarantee of it. And if we wanna do unbind/bind, it would also
cause the device to hang.

And this patch also does these:
1/ move vop_initial to the end of vop_bind for eaiser error handling.
2/ correct the err_put_pm_runtime of vop_enable.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: http://patchwork.freedesktop.org/patch/msgid/1491481885-13775-8-git-send-email-jeffy.chen@rock-chips.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   29 ++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -503,7 +503,7 @@ static int vop_enable(struct drm_crtc *c
 	ret = pm_runtime_get_sync(vop->dev);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
-		goto err_put_pm_runtime;
+		return ret;
 	}
 
 	ret = clk_enable(vop->hclk);
@@ -1348,10 +1348,16 @@ static int vop_initial(struct vop *vop)
 		return PTR_ERR(vop->dclk);
 	}
 
+	ret = pm_runtime_get_sync(vop->dev);
+	if (ret < 0) {
+		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare(vop->dclk);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to prepare dclk\n");
-		return ret;
+		goto err_put_pm_runtime;
 	}
 
 	/* Enable both the hclk and aclk to setup the vop */
@@ -1411,6 +1417,8 @@ static int vop_initial(struct vop *vop)
 
 	vop->is_enabled = false;
 
+	pm_runtime_put_sync(vop->dev);
+
 	return 0;
 
 err_disable_aclk:
@@ -1419,6 +1427,8 @@ err_disable_hclk:
 	clk_disable_unprepare(vop->hclk);
 err_unprepare_dclk:
 	clk_unprepare(vop->dclk);
+err_put_pm_runtime:
+	pm_runtime_put_sync(vop->dev);
 	return ret;
 }
 
@@ -1519,12 +1529,6 @@ static int vop_bind(struct device *dev,
 	if (!vop->regsbak)
 		return -ENOMEM;
 
-	ret = vop_initial(vop);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot initial vop dev - err %d\n", ret);
-		return ret;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "cannot find irq for vop\n");
@@ -1551,8 +1555,17 @@ static int vop_bind(struct device *dev,
 
 	pm_runtime_enable(&pdev->dev);
 
+	ret = vop_initial(vop);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot initial vop dev - err %d\n", ret);
+		goto err_disable_pm_runtime;
+	}
+
 	return 0;
 
+err_disable_pm_runtime:
+	pm_runtime_disable(&pdev->dev);
+	vop_destroy_crtc(vop);
 err_enable_irq:
 	enable_irq(vop->irq); /* To balance out the disable_irq above */
 	return ret;
