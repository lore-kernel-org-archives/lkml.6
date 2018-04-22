Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49P/xorA4wuc1bLmjtRX14FmXOIZuU1POy/FFfZvj+EN7xUPD7/Ml5dag89zeoYIIL1S9tH
ARC-Seal: i=1; a=rsa-sha256; t=1524405683; cv=none;
        d=google.com; s=arc-20160816;
        b=p8xTJpF308X9hno9HsbhrZZNAIDbb0lhvdplUTra9RHonrnqvBZ2OAI4wNAjOSVsd5
         2sIRBFdb6FC72TuXLWQ/ACImyYvVxnkKgQKYpT0T1qpg9t/3N1raHGPJFhzYnG5ZVfP4
         wdnep7YgtKvqn2eB0H7R1k7BR4GcjHfSVblAM36ILUExYwQXBB+I85UMQl+DVDmkDO9D
         gJfzVZf7UwCkSVzQWLo7T8fq+Lw/GPqf5+Tda7xFbnbkEOXAS3vgZ+4m61CLCA+IZz9K
         KrGKwXecL54CISlgGlCJzvigcqiBlIFE57KL4u6qX4UI7lSFGgTUdpAOBuRCG8DFr1F1
         IzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=c3SxseKodBxeBRJTg2u3EM2kV1Y0q6CD+uAkMnBF1f4=;
        b=Ut0SSGC63tiaoX2WHMcyvttv3XvWwA80eYJNnTJ0WWOxL4OZDfhTufvJ+qXP/H1rIr
         2E9QEMajqYKlmCAoSTvRej7K2wDYjN44YekKBBtXkT3OQdqc95IJ/5+cuLfUx/l0+ZW6
         hCs6K/22WJAgi7Z+QL2Y0AzkBRbVYpvhoXHZHh6aMRoc82i8OXxTdEXJZjzhv5SJw4o7
         tXhhXkxpObRdUUY9/CI9lo231QhIvMiq0qn7UX6gk3doIGwg6heCLrolKwxDjONjApVq
         ivdfN92iKNBDZ4LpulfjuI67BrV3rvb7BAUz1xiJOnkUVMCsWLAw9sBcD/No/MmEjQJr
         scjw==
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
Subject: [PATCH 4.16 155/196] drm/rockchip: Clear all interrupts before requesting the IRQ
Date: Sun, 22 Apr 2018 15:52:55 +0200
Message-Id: <20180422135112.236961163@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455213348332797?=
X-GMAIL-MSGID: =?utf-8?q?1598455213348332797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1414,6 +1414,9 @@ static int vop_initial(struct vop *vop)
 	usleep_range(10, 20);
 	reset_control_deassert(ahb_rst);
 
+	VOP_INTR_SET_TYPE(vop, clear, INTR_MASK, 1);
+	VOP_INTR_SET_TYPE(vop, enable, INTR_MASK, 0);
+
 	memcpy(vop->regsbak, vop->regs, vop->len);
 
 	VOP_REG_SET(vop, misc, global_regdone_en, 1);
@@ -1569,17 +1572,9 @@ static int vop_bind(struct device *dev,
 
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
 
@@ -1590,13 +1585,19 @@ static int vop_bind(struct device *dev,
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
 
