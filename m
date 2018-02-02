Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227f759LMw52qME6D6JfMCgG6dEFaU/U7g+JH+GWGmFXVY6T90jfpgwFSi/rfwtuneH3SCCp
ARC-Seal: i=1; a=rsa-sha256; t=1517591014; cv=none;
        d=google.com; s=arc-20160816;
        b=oSXDfCXaP6YLO2dCdOBDd6VgfZLurcpg2ZFPLJoVEEmzRu2Ii7hcVVQvh5EqwhABQt
         YVhL099ky81xuRbSyuY9W7M/gV50r8FQaI8DBteLY7DO4rs0+oTh8A95rnmmizfrzkB5
         DwA6+gONTHODg/w4VbqSrucAUz59QtE9uuOJ5NXYXHTNXCfwe1qzye+TRIy5AJYdU4x3
         csx0xFglDv2R5j5GQzoDmb3eh/iO2Z3nxABHKzqhG7bbeVFrAjWwTuweO+I47+jnIyfQ
         JrnV9Gooh8ISqiQlahhKhwm+IFiPwoUJZ6lN21g9gVX2YdbypocigC9zCaT/7Ymy4zRO
         G/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ix/xTsL9YvKtfexQC7TBRDiCXu2v8hhdlulchlt7wf0=;
        b=B/ycckmdYV7c+RfmGyloeFSflgPdM8lTTeXOgAwLN7wOaGjt89HjvLv26giYWOQBsX
         8tB/2fhDV6VM6w1wI3tvD4MkiFbXRX/+23LvvUEUZGxlMJ9dEEceM7BDiABE51Ry0SUy
         /cnbMazdL9kKz/zymEzhGk8CkRn2yg4xvF+9/HRVaPblyXLXjUVlpuS+N0i7rCZr8mQF
         ztmpsxdqvaePVNDbuSDi5dyHmEVftj8KyMoUZueifrmvoLhq+LeKdoW2VFdJ0shIifQ2
         vBJSUd+T25xZy+OrScJsCmJPhkyF20w76UOhEZgTTpDAjt+hmAYA2FhIUAQSCBmzKIFA
         FK3Q==
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
Subject: [PATCH 4.9 23/86] KVM: x86: ioapic: Fix level-triggered EOI and IOAPIC reconfigure race
Date: Fri,  2 Feb 2018 17:57:43 +0100
Message-Id: <20180202140824.809233792@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309444031014728?=
X-GMAIL-MSGID: =?utf-8?q?1591309515032454914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 arch/x86/kvm/ioapic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 6e219e5c07d2..a7ac8688bba8 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -257,8 +257,7 @@ void kvm_ioapic_scan_entry(struct kvm_vcpu *vcpu, ulong *ioapic_handled_vectors)
 		    index == RTC_GSI) {
 			if (kvm_apic_match_dest(vcpu, NULL, 0,
 			             e->fields.dest_id, e->fields.dest_mode) ||
-			    (e->fields.trig_mode == IOAPIC_EDGE_TRIG &&
-			     kvm_apic_pending_eoi(vcpu, e->fields.vector)))
+			    kvm_apic_pending_eoi(vcpu, e->fields.vector))
 				__set_bit(e->fields.vector,
 					  ioapic_handled_vectors);
 		}
-- 
2.16.1
