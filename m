Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49F5UuVCUsSJpHfX3CKG+drGN5HHV9B3q3WEUf4LQBqOZ2+Zy/h7o+42wqDONxpbejNU8VG
ARC-Seal: i=1; a=rsa-sha256; t=1524406134; cv=none;
        d=google.com; s=arc-20160816;
        b=tpcEVQR9d1Dx7RlAz8YHAQADY5WKkxzJZZYqyjt+yKo7l3LuDzOqpiDOrNYTr5+e5e
         M5kSwRE8y1A+DfHMVkmcpu4ximKRshoaYvEb8hVSk6wxM3SsOSRNIOwpgrD/cLkulnC8
         3f7m0vM0q4xq9ZpwBJJaVJ10cS1YNLqxLmwA27zJRyDJ7OsDZog5Uiub+CAf2BY+1Rkc
         Wl26B/HG9/fw41unYTU1mg/E4MXhUjb1K9YuoX0FjGB2WHNsquDRfnbJ+oDCYK+QoWrz
         Q/WQjRO74CkMt6i+i6ej4KBU+bnQZO+IAx7Jpx+99GxvUMi2FlQ32SDtMgH5f2pdqUu+
         OgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AVS1YbqsDrwza/UnIc8zRHFV3z0Zfq/SnnWV7oNSRYo=;
        b=orTKuLG8UUtM8Oleis8Yv2VKM54PoU7yJKR++pXth9yxBGhsnHqDy2EkvSSAb5HX6L
         JwvbdTNMJkkNssKQIf3THtnidaAd+UHg4UPE31rG8/OLhx5jnIdtFD/R/JjUmviQl8UZ
         OEmpZ/uKDNUS/lf05w+abkGzixzVoV88HZc7c/f+Bgp975WdDj/bB261K02jj1GKIRw8
         uH+cyJnUaOvRc/QBoKw/XpNoT2KJBUT+6ad94a2qJZ1y85dHpjNtUFkpiacAlfLPLw09
         NMxHwjo3pRvwCEMiRImSRXp3I/UE582ZtGrHbo4TnjAyScakdn69nLtIzZgAnZEKybCa
         dv4A==
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
Subject: [PATCH 4.14 125/164] drm/rockchip: Clear all interrupts before requesting the IRQ
Date: Sun, 22 Apr 2018 15:53:12 +0200
Message-Id: <20180422135140.515661719@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455213348332797?=
X-GMAIL-MSGID: =?utf-8?q?1598455686569929634?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1413,6 +1413,9 @@ static int vop_initial(struct vop *vop)
 	usleep_range(10, 20);
 	reset_control_deassert(ahb_rst);
 
+	VOP_INTR_SET_TYPE(vop, clear, INTR_MASK, 1);
+	VOP_INTR_SET_TYPE(vop, enable, INTR_MASK, 0);
+
 	memcpy(vop->regsbak, vop->regs, vop->len);
 
 	VOP_REG_SET(vop, misc, global_regdone_en, 1);
@@ -1568,17 +1571,9 @@ static int vop_bind(struct device *dev,
 
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
 
@@ -1588,13 +1583,19 @@ static int vop_bind(struct device *dev,
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
 
