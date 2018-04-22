Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+kRayKEsfT/cTSNky08J8geBvv6mYc8YHzkM9Uv7HzF1bP8yTfnuHEyIQM6kiXIpdmi2JX
ARC-Seal: i=1; a=rsa-sha256; t=1524405312; cv=none;
        d=google.com; s=arc-20160816;
        b=QMLHd8789j1rs+sZj8AKExBnsr2itmZauDRaOwdFiqWrPhIbwUxqiS1mH2B4cKLL+g
         2mz0MQl+2g0n7fAi6Y0c6TClWiIBWE9yzeVmV5jG+qIvkfKTZK9qjaWKE9E/k0p9oVh8
         vC2ku2Q21O2RVV1/YNJXH+6rPyURtmE+Am5zPlIiyxaV2jmAd4mlfTyvHiTJFKqVCrL0
         QLRvo3dBYMtI9LmKZXtfoymo4lquYrPn9EbnplpsnAajUAvzq7qn65RDne77u31jqp4R
         c3yTCdt6FAj9zmd31pGO/FxKRx7ihZeXGOJhj+lb6YMfpsXWSt6MMrBtdfG10ndHSLBu
         YDhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1lYg5E+5VWNasRe7isAByzuB4vMmFUGD+xwfes83xWg=;
        b=fvjo3A2TC4AYFlJy3IWoePZTypx+jNIsHZjVGe6kW/vqs/JIYXnDcx+JwwY4W+IDdy
         Oz9Dr5UiOTMn7+BsNuuY5JKdXPJ0xjC78bedtacz/AuSByOjbwusodzutJfbY1mVS3Sp
         wuYnhkH7/t0hSlfV6u/j2FfOcbAbpYhM8wKTgyciegWfZpg5U9xaedcfMpze/I1WIQWm
         pam/mYlAyFt7UCpomayb8FwEid2phk7yP09uz3dZDz71R1/9g1f1fDv0z2tGKKUja+t7
         g/rXfcfxPnJSSYT4qUdVNroIU0IUlm0M4dG2L9Bk3xSzp7f3EL1nLt9cBqvnwnj9nzXb
         VCww==
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
Subject: [PATCH 4.16 021/196] KVM: arm/arm64: vgic-its: Fix potential overrun in vgic_copy_lpi_list
Date: Sun, 22 Apr 2018 15:50:41 +0200
Message-Id: <20180422135105.224574864@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454825216817587?=
X-GMAIL-MSGID: =?utf-8?q?1598454825216817587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -316,21 +316,24 @@ static int vgic_copy_lpi_list(struct kvm
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
