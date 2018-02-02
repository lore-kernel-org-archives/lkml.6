Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227FWZfedjO0oCUaZ8cc9OAAXJBBygYzcB4fyoCqP80tTEaKvlK0hUOUUwFdYiImE0I7aYlg
ARC-Seal: i=1; a=rsa-sha256; t=1517590945; cv=none;
        d=google.com; s=arc-20160816;
        b=yMyWSJmUn+4DhKn1js8Z2xNLbA4zM2C9MDcx7mBDAGQcAXHpTv11OLj5C0ibpIBp/4
         57zZeHiX09S3jq/b+HGKAoSMkcsu/Z35CwCLcEjzp6dN2eSzXnslMw9z9Kss5/u8ytHN
         OEV5XS7igAXiZFXJNkRfPL3c/w7UeM5Cd78MON1Seape6uQpvUdBdUnHpoyM56ihsb7p
         OWN9S1oG4EHfOYXPrLOPh59nzF6MWx7DUCTlBrGh+u8aKx6gh60FclU2984/umDvhZC0
         2bMBMDZfufutM8mN8NORkZVwRfnViJ89gjIhVihbUB5nFAO2W33/sIk3IpIfJ7GKHqRs
         Yh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=twvX1WEiulCfT/sLY8nQca0/ZP4WeHnk2ZN7hpzXQns=;
        b=pmdl7KtjpMiaRd2Yk8IZ9W+88Y3/Qdc8ddlIMJYY5vqSCJw0RzFdlIWImh6Xny5QAT
         QoDE5LGAaq/uZGvY6ddH3kMIdy46fmsyWBYHIwE4TNUzgOP2Edq0Jh0EkGYbRtw859rS
         SCI5iJbw6iK9QDBdhmpmcJOLha0WLo40e9m1VYdfeBorMpvxNpVFa9Bk8zfFiZxdI2ts
         CecU6v3tVY19NDvIMntZoaihh3MkhND4psN04SRHcOLcfd59ukJW9H8BoXHg6C+MQALA
         VkuQJ0CfUBLf2nfehY81wZwzQ4NbCXKsP46VA7Ab9H7H1BuQapYyhW8uOF2BLl8LtJ2X
         erEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikita Leshenko <nikita.leshchenko@oracle.com>,
	Liran Alon <liran.alon@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 24/67] KVM: x86: ioapic: Fix level-triggered EOI and IOAPIC reconfigure race
Date: Fri,  2 Feb 2018 17:57:53 +0100
Message-Id: <20180202140818.078345208@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309444031014728?=
X-GMAIL-MSGID: =?utf-8?q?1591309444031014728?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Leshenko <nikita.leshchenko@oracle.com>


[ Upstream commit 0fc5a36dd6b345eb0d251a65c236e53bead3eef7 ]

KVM uses ioapic_handled_vectors to track vectors that need to notify the
IOAPIC on EOI. The problem is that IOAPIC can be reconfigured while an
interrupt with old configuration is pending or running and
ioapic_handled_vectors only remembers the newest configuration;
thus EOI from the old interrupt is not delievered to the IOAPIC.

A previous commit db2bdcbbbd32
("KVM: x86: fix edge EOI and IOAPIC reconfig race")
addressed this issue by adding pending edge-triggered interrupts to
ioapic_handled_vectors, fixing this race for edge-triggered interrupts.
The commit explicitly ignored level-triggered interrupts,
but this race applies to them as well:

1) IOAPIC sends a level triggered interrupt vector to VCPU0
2) VCPU0's handler deasserts the irq line and reconfigures the IOAPIC
   to route the vector to VCPU1. The reconfiguration rewrites only the
   upper 32 bits of the IOREDTBLn register. (Causes KVM to update
   ioapic_handled_vectors for VCPU0 and it no longer includes the vector.)
3) VCPU0 sends EOI for the vector, but it's not delievered to the
   IOAPIC because the ioapic_handled_vectors doesn't include the vector.
4) New interrupts are not delievered to VCPU1 because remote_irr bit
   is set forever.

Therefore, the correct behavior is to add all pending and running
interrupts to ioapic_handled_vectors.

This commit introduces a slight performance hit similar to
commit db2bdcbbbd32 ("KVM: x86: fix edge EOI and IOAPIC reconfig race")
for the rare case that the vector is reused by a non-IOAPIC source on
VCPU0. We prefer to keep solution simple and not handle this case just
as the original commit does.

Fixes: db2bdcbbbd32 ("KVM: x86: fix edge EOI and IOAPIC reconfig race")

Signed-off-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/ioapic.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -247,8 +247,7 @@ void kvm_ioapic_scan_entry(struct kvm_vc
 		    index == RTC_GSI) {
 			if (kvm_apic_match_dest(vcpu, NULL, 0,
 			             e->fields.dest_id, e->fields.dest_mode) ||
-			    (e->fields.trig_mode == IOAPIC_EDGE_TRIG &&
-			     kvm_apic_pending_eoi(vcpu, e->fields.vector)))
+			    kvm_apic_pending_eoi(vcpu, e->fields.vector))
 				__set_bit(e->fields.vector,
 					(unsigned long *)eoi_exit_bitmap);
 		}
