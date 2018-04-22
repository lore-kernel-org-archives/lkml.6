Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48AO6SD0DZeVxg4x3H1n3pHD4Fcudzx6P1n/BFfoS6uZWQ975oNMZltDtKFPM0lOauTWA+I
ARC-Seal: i=1; a=rsa-sha256; t=1524406430; cv=none;
        d=google.com; s=arc-20160816;
        b=ybT7wInxpxqh08DcX9hojYAYCKc6LXTBYV2Ms5Y8F7/nP5gkGlq3x19/Z4ehurIRcs
         NiVOU5xXsLMsTjs0duioht2Ia7+/D/hOYLcxVByHjS93QqBLfgKturU2qBb2Cj7KkvYM
         h1T0cc8NNAibqijaF94ZNSq72SdPfb3Shb4yKmVwxA3yn9E1rq1xg1iiLWbdoYQxbfkJ
         lnoMlHzh2WvKtfP8nnh2bktagKSfCvBvZhgajAC6enI9pY+WT/h2xB399BckKx4wn75c
         p4wz665dcCO9Z6ePCXjio28CTdN6BaRx/mMbKiuTCP7jRRxQjp/xWKPv1ZzBkeRwKZzx
         qSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qIs3j+CF5P3e+m3AgUjQzhuPUDEc/RCksAvRwdh62as=;
        b=LAXoDcMajnIQWFF6ud2q7iG1JPfRwOXgK4q8WwcEfszfNCR+9rEdH//iOWGAbwEV4z
         FkIFdcK2HDGLRmORA+Ss+2IDn/uvImDhmuGDSA6RxnIpcSA0ZORid0f49qgqlh4FJYVM
         acqz/owtI5GJapw0bMKOhmFWN/r3DQQaRv8REByBNcZaZjrvgOeLT87T2tJakOX7vJpb
         8yZxSfDgQ370FIHBK2c0gKKRd8aUw3bwTE1E7gpYIW9Cb3G1YgxXkZUnzR6NdqGp5K1C
         wEvXekZjlHxscJy4yWPEgCnANXxr33wPUn+4sMk8/zj1QHo/adcxunqxUpnmAvsHFxE2
         4lFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.9 69/95] drm/rockchip: Clear all interrupts before requesting the IRQ
Date: Sun, 22 Apr 2018 15:53:38 +0200
Message-Id: <20180422135213.252429672@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455213348332797?=
X-GMAIL-MSGID: =?utf-8?q?1598455996964518523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 5f9e93fed4d45e9a8f84728aff1a8f2ab8922902 upstream.

Calling request_irq() followed by disable_irq() is usually a bad idea,
specially if the interrupt can be pending, and you're not yet in a
position to handle it.

This is exactly what happens on my kevin system when rebooting in a
second kernel using kexec: Some interrupt is left pending from
the previous kernel, and we take it too early, before disable_irq()
could do anything.

Let's clear the pending interrupts as we initialize the HW, and move
the interrupt request after that point. This ensures that we're in
a sane state when the interrupt is requested.

Cc: stable@vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[adapted to recent rockchip-drm changes]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20180220130120.5254-2-marc.zyngier@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1386,6 +1386,9 @@ static int vop_initial(struct vop *vop)
 	usleep_range(10, 20);
 	reset_control_deassert(ahb_rst);
 
+	VOP_INTR_SET_TYPE(vop, clear, INTR_MASK, 1);
+	VOP_INTR_SET_TYPE(vop, enable, INTR_MASK, 0);
+
 	memcpy(vop->regsbak, vop->regs, vop->len);
 
 	for (i = 0; i < vop_data->table_size; i++)
@@ -1541,17 +1544,9 @@ static int vop_bind(struct device *dev,
 
 	mutex_init(&vop->vsync_mutex);
 
-	ret = devm_request_irq(dev, vop->irq, vop_isr,
-			       IRQF_SHARED, dev_name(dev), vop);
-	if (ret)
-		return ret;
-
-	/* IRQ is initially disabled; it gets enabled in power_on */
-	disable_irq(vop->irq);
-
 	ret = vop_create_crtc(vop);
 	if (ret)
-		goto err_enable_irq;
+		return ret;
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -1561,13 +1556,19 @@ static int vop_bind(struct device *dev,
 		goto err_disable_pm_runtime;
 	}
 
+	ret = devm_request_irq(dev, vop->irq, vop_isr,
+			       IRQF_SHARED, dev_name(dev), vop);
+	if (ret)
+		goto err_disable_pm_runtime;
+
+	/* IRQ is initially disabled; it gets enabled in power_on */
+	disable_irq(vop->irq);
+
 	return 0;
 
 err_disable_pm_runtime:
 	pm_runtime_disable(&pdev->dev);
 	vop_destroy_crtc(vop);
-err_enable_irq:
-	enable_irq(vop->irq); /* To balance out the disable_irq above */
 	return ret;
 }
 
