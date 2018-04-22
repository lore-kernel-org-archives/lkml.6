Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49wUI8tpp6KJE60jwLs6Vi9f5UO+bqGzSCo+sRPtOVkQtB33Dwjua96Vdd2+mVys2OKB9R5
ARC-Seal: i=1; a=rsa-sha256; t=1524405843; cv=none;
        d=google.com; s=arc-20160816;
        b=b2LTuyf/XBrEXuWxHQpMi1WMqqbwBVPQ2fv7F0L20u9bAqBaOUVxgBudi+uzyd6oVp
         93ojmzwAmjkmdswRVa3/hFwOY4XWPJfOTc1JcvrJ2N9S87LvQ3l8CA12TvtCstkRotmm
         8+WdDUi76DZSsEvfWc2sXxkklLtWhM+Vmjdr/RaqTjB/VD6h/RSOtJBLfvVNRs8FEOD7
         Y6T2bZ7AcKuUWIJN5dPRUYZxX6dE8FcpXmZVGFFOGjGfTzJtuiwZEgM+ZJwCIqK93naK
         kAVDP23Jk5LO76EpbEgvsuFJ93d7ooqyQMCQ0S3qtRzn5nbNpkWmdyHxZWVwu5ous2iG
         UiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O9XBcHFkVQG3izkjDdVHP41qM1PXKn27CHyrYLQaMD4=;
        b=qBHqELSAYNKM0GsPTRg6UFI8iO+or/ZCSdUrRyngWyzwU5hnQ2sU6f3DsetG8FG85V
         ajiZkmf2Bon13vaKDj3i9p4kitXTDN3TiQ/iN4jJThuW+5bAy7xNtTQ4lGcHRG/nA9rV
         dVUpWNR2Fet7wgLAfs9Y7+NHCeQmANQNv+Yud3BqwsspU7JW3Om5wXO8rASyrLvf8hXH
         mp0D56rLg73cvxtea5XyTzgtXfspI2DA9G7kghQalXPW4UhLj2oyFWauObNf57ouUeB7
         iW0tV/AKlkIAg+wt/qyePAJ7PMr0WrdiMpagtsNHClZCXE+q8OkKG8xvrIQrCnwrWwhJ
         YW0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 019/164] KVM: arm/arm64: vgic-its: Fix potential overrun in vgic_copy_lpi_list
Date: Sun, 22 Apr 2018 15:51:26 +0200
Message-Id: <20180422135136.180413069@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454825216817587?=
X-GMAIL-MSGID: =?utf-8?q?1598455382076115717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 7d8b44c54e0c7c8f688e3a07f17e6083f849f01f upstream.

vgic_copy_lpi_list() parses the LPI list and picks LPIs targeting
a given vcpu. We allocate the array containing the intids before taking
the lpi_list_lock, which means we can have an array size that is not
equal to the number of LPIs.

This is particularly obvious when looking at the path coming from
vgic_enable_lpis, which is not a command, and thus can run in parallel
with commands:

vcpu 0:                                        vcpu 1:
vgic_enable_lpis
  its_sync_lpi_pending_table
    vgic_copy_lpi_list
      intids = kmalloc_array(irq_count)
                                               MAPI(lpi targeting vcpu 0)
      list_for_each_entry(lpi_list_head)
        intids[i++] = irq->intid;

At that stage, we will happily overrun the intids array. Boo. An easy
fix is is to break once the array is full. The MAPI command will update
the config anyway, and we won't miss a thing. We also make sure that
lpi_list_count is read exactly once, so that further updates of that
value will not affect the array bound check.

Cc: stable@vger.kernel.org
Fixes: ccb1d791ab9e ("KVM: arm64: vgic-its: Fix pending table sync")
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/vgic/vgic-its.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -309,21 +309,24 @@ static int vgic_copy_lpi_list(struct kvm
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
 	struct vgic_irq *irq;
 	u32 *intids;
-	int irq_count = dist->lpi_list_count, i = 0;
+	int irq_count, i = 0;
 
 	/*
-	 * We use the current value of the list length, which may change
-	 * after the kmalloc. We don't care, because the guest shouldn't
-	 * change anything while the command handling is still running,
-	 * and in the worst case we would miss a new IRQ, which one wouldn't
-	 * expect to be covered by this command anyway.
+	 * There is an obvious race between allocating the array and LPIs
+	 * being mapped/unmapped. If we ended up here as a result of a
+	 * command, we're safe (locks are held, preventing another
+	 * command). If coming from another path (such as enabling LPIs),
+	 * we must be careful not to overrun the array.
 	 */
+	irq_count = READ_ONCE(dist->lpi_list_count);
 	intids = kmalloc_array(irq_count, sizeof(intids[0]), GFP_KERNEL);
 	if (!intids)
 		return -ENOMEM;
 
 	spin_lock(&dist->lpi_list_lock);
 	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
+		if (i == irq_count)
+			break;
 		/* We don't need to "get" the IRQ, as we hold the list lock. */
 		if (irq->target_vcpu != vcpu)
 			continue;
