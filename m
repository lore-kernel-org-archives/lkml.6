Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsdcL61GCtOEl183pT/4UfVuYyxZ1ny+rs7/3nVlOwfnYGYmQLHKcdD8NAGWcz2qdARNpcx
ARC-Seal: i=1; a=rsa-sha256; t=1521484303; cv=none;
        d=google.com; s=arc-20160816;
        b=fwry5zK5jia8eLMAQUxNUgdjHqNpFCoRUJiTIEUkZSgMm7uGKnkrMn41QRwJgLEzsw
         Im2LCmGs3gtTNkfhGpZKhqnR1QRRDGS8gbiGEa5m0Cn6tKwsN/+vjjMJ9H2WNleR1MgD
         yLzwYKUQ131Hi7fuHylv1JGcg8l8gsZ2P31AQ91FxOc/g9Tte0cqC7SGPP/1GVgsfmQU
         6LmEIgGzTGcQEanQrXuXwmuSxanNZG+zaedPHRUlpbEBQFvxwHJ57FN3N2CJCyWxKX1I
         /RpF7kxatafKW7sAxHlREbwuhHv4sSEr7ldyZYm8yLyyzkoeSkr1/6tuuPcq2iThz4Z4
         iGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hx2s4sGnaZK5ycDYhmLeFKqNrS8o1TtFBDG3/x1hjhk=;
        b=HtqgnCjJyn9+gpjApsZWN4D4vNx2ljiTEWYYFcrWSkbgJqwDIiWmYYXIwhqN7tEaJd
         HLtR6/YRhHh65qJ70Ajx2eYpb/DzRvdQ1/YsljxmhBrEulByiw+Kp6QW1u5V4faQEAek
         fQ+iqnMxW9LhYvSPrObtTsoMj8+Qv0RPo/6ojb6taqYeQYexUFrwfCXwfrcVr3+kax8K
         VMrGhJvZfP8Meh3s1Sdt7ZpQQe3zHcAAUPi9PTHFdQmbWvQlJ3ikzBZJ47yBgwRFJarI
         a0j7XuZYqJ2O1PMXcpjet1kqPsB5ZOMYvGQF9g3gXfuiz9eIBpVNBvb/j49eyH3J2oyv
         LN+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Christoffer Dall <cdall@kernel.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.15 21/52] KVM: arm/arm64: Reduce verbosity of KVM init log
Date: Mon, 19 Mar 2018 19:08:19 +0100
Message-Id: <20180319180736.298970050@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391829188994151?=
X-GMAIL-MSGID: =?utf-8?q?1595391925415573514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 76600428c3677659e3c3633bb4f2ea302220a275 upstream.

On my GICv3 system, the following is printed to the kernel log at boot:

   kvm [1]: 8-bit VMID
   kvm [1]: IDMAP page: d20e35000
   kvm [1]: HYP VA range: 800000000000:ffffffffffff
   kvm [1]: vgic-v2@2c020000
   kvm [1]: GIC system register CPU interface enabled
   kvm [1]: vgic interrupt IRQ1
   kvm [1]: virtual timer IRQ4
   kvm [1]: Hyp mode initialized successfully

The KVM IDMAP is a mapping of a statically allocated kernel structure,
and so printing its physical address leaks the physical placement of
the kernel when physical KASLR in effect. So change the kvm_info() to
kvm_debug() to remove it from the log output.

While at it, trim the output a bit more: IRQ numbers can be found in
/proc/interrupts, and the HYP VA and vgic-v2 lines are not highly
informational either.

Cc: <stable@vger.kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/arch_timer.c   |    2 +-
 virt/kvm/arm/mmu.c          |    6 +++---
 virt/kvm/arm/vgic/vgic-v2.c |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -773,7 +773,7 @@ int kvm_timer_hyp_init(bool has_gic)
 		}
 	}
 
-	kvm_info("virtual timer IRQ%d\n", host_vtimer_irq);
+	kvm_debug("virtual timer IRQ%d\n", host_vtimer_irq);
 
 	cpuhp_setup_state(CPUHP_AP_KVM_ARM_TIMER_STARTING,
 			  "kvm/arm/timer:starting", kvm_timer_starting_cpu,
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1760,9 +1760,9 @@ int kvm_mmu_init(void)
 	 */
 	BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
 
-	kvm_info("IDMAP page: %lx\n", hyp_idmap_start);
-	kvm_info("HYP VA range: %lx:%lx\n",
-		 kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
+	kvm_debug("IDMAP page: %lx\n", hyp_idmap_start);
+	kvm_debug("HYP VA range: %lx:%lx\n",
+		  kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
 
 	if (hyp_idmap_start >= kern_hyp_va(PAGE_OFFSET) &&
 	    hyp_idmap_start <  kern_hyp_va(~0UL) &&
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -381,7 +381,7 @@ int vgic_v2_probe(const struct gic_kvm_i
 	kvm_vgic_global_state.type = VGIC_V2;
 	kvm_vgic_global_state.max_gic_vcpus = VGIC_V2_MAX_CPUS;
 
-	kvm_info("vgic-v2@%llx\n", info->vctrl.start);
+	kvm_debug("vgic-v2@%llx\n", info->vctrl.start);
 
 	return 0;
 out:
