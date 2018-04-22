Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48TKIS1Rf08he2c+RaUvqI0BW/suplAVg4VCe2f4UTRbHAzjGcqbP/wgbMZLeb9gBn9i3st
ARC-Seal: i=1; a=rsa-sha256; t=1524406330; cv=none;
        d=google.com; s=arc-20160816;
        b=bsNLcom+Vv7n2cpBEIKzf7No17arAPMCbWwQ3Maw60vwGtr+KfTXl5WpbWqY201Bmh
         W+WsaF11kFvtcrPeKwhKuLpM/k3uZn4ZoOjyq3NI+FIQMQ/M1UL03EZmaWFREgKPnAWy
         Nzpr6ysrRUlaDRWLvL1VG7PChkJPluVS+zgkD7x55/FX/Q+QJyPwd1yjMOfEvd0GA4co
         vda55IofK2X+xeVH4HtBN25waDATxElmZSCUVBFST/tYGhgkfr+3bvSOTvDeR8O/nzNe
         00q5/2Mo/7sX4nDRdptp35GHO1VP64k+J8BQ0OrzKAJrf0RALu9Mif2h6xUFpkk9HTbg
         8ESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uhdjmz4TWPoKM9KOMMZx1IFdMpoobNUILIkPfYq1/UU=;
        b=wsQm/8uIv0npN0mPqUk64tWrFM+gnBAVOL3HseppggLTxAE/0YYVFiwo2WQSq8pZqu
         QT2xm8KOO3PCfmxNsYvpIbEuoy1mCN6C0Gcx6JNU+DHs95ZpdZ+olrnanCg7UCq2CQPL
         JsSjkRqMqGEGgiz5OBbb27RFxc2yUox8uF5NAx1Z6/rkX/VItfolKi5b7WHoG1ZzfIUd
         b/8ANPp+YmaZyowfxaEaccOYuGM9/fPxsGSrjh/YK5JMaJ4qgOFP8cy7HHApIHVRiYNj
         norie29vPR1qe6QCfrF3dUt2GKtiViQmBlm3EnHYg4SP+yT3b1RZJuOcu4rdz+D+xfu4
         Nt4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aniruddha Banerjee <aniruddhab@nvidia.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.9 32/95] irqchip/gic: Take lock when updating irq type
Date: Sun, 22 Apr 2018 15:53:01 +0200
Message-Id: <20180422135211.751167345@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454998846603091?=
X-GMAIL-MSGID: =?utf-8?q?1598455891854570448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aniruddha Banerjee <aniruddhab@nvidia.com>

commit aa08192a254d362a4d5317647a81de6996961aef upstream.

Most MMIO GIC register accesses use a 1-hot bit scheme that
avoids requiring any form of locking. This isn't true for the
GICD_ICFGRn registers, which require a RMW sequence.

Unfortunately, we seem to be missing a lock for these particular
accesses, which could result in a race condition if changing the
trigger type on any two interrupts within the same set of 16
interrupts (and thus controlled by the same CFGR register).

Introduce a private lock in the GIC common comde for this
particular case, making it cover both GIC implementations
in one go.

Cc: stable@vger.kernel.org
Signed-off-by: Aniruddha Banerjee <aniruddhab@nvidia.com>
[maz: updated changelog]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-common.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -21,6 +21,8 @@
 
 #include "irq-gic-common.h"
 
+static DEFINE_RAW_SPINLOCK(irq_controller_lock);
+
 static const struct gic_kvm_info *gic_kvm_info;
 
 const struct gic_kvm_info *gic_get_kvm_info(void)
@@ -52,11 +54,13 @@ int gic_configure_irq(unsigned int irq,
 	u32 confoff = (irq / 16) * 4;
 	u32 val, oldval;
 	int ret = 0;
+	unsigned long flags;
 
 	/*
 	 * Read current configuration register, and insert the config
 	 * for "irq", depending on "type".
 	 */
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 	val = oldval = readl_relaxed(base + GIC_DIST_CONFIG + confoff);
 	if (type & IRQ_TYPE_LEVEL_MASK)
 		val &= ~confmask;
@@ -64,8 +68,10 @@ int gic_configure_irq(unsigned int irq,
 		val |= confmask;
 
 	/* If the current configuration is the same, then we are done */
-	if (val == oldval)
+	if (val == oldval) {
+		raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 		return 0;
+	}
 
 	/*
 	 * Write back the new configuration, and possibly re-enable
@@ -83,6 +89,7 @@ int gic_configure_irq(unsigned int irq,
 			pr_warn("GIC: PPI%d is secure or misconfigured\n",
 				irq - 16);
 	}
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
 	if (sync_access)
 		sync_access();
