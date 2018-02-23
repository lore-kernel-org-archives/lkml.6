Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuk7dLu8PuE973CbGOZSS3w6GxA04xv7nZ04UE6VoJSKIY8+YIM42FOHYDmudtHXE6qQIIL
ARC-Seal: i=1; a=rsa-sha256; t=1519411303; cv=none;
        d=google.com; s=arc-20160816;
        b=zlHQe8c05Vm5y+SO72BrNIBmou/HbEoHWoJgVsg/OXuL27yhv54mhazSmeJAGPpSwd
         IB7iwLZeIIx/foLWUOdEi+GRz0XAUBgJd1qFZ/bYuQBNXy8SDCDitW1t8Ri/hG8Y4WuM
         7DL884/TELna17HHSW65xouqAJ+9ECc+0UahSY99t5HIH66pj+2o1KcepPxoQJd0f/9D
         Y+LtjHNYt8vNLZc4g2Kv7YMWm1jBAlokH2wkJq8RQIgjzc0gmhkeqtv9yiKBa8T5J76m
         9Qko3GRcdRwxSdB/cmUevKFb9x1YTPdTw8u9KetqW1Vn0pJZovwPcrZamxNvHLqYlm8Q
         8fNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MFcI+LycOHjBpRrkkcZ6W0MIWp1u1VHbbYrgT23H28g=;
        b=n+ykazmUpBByfJ8aMaG6csV+1FCG//MgiueVGX+IfPgIu3WgVTZZ3X/x1nksgcdkSO
         sZyunfLSVLUF9BMULYjs/JUXaXLOdoKB5GVje8KzsY2V7sUkzssdqm2cNEyPwlAPMK6g
         eG5HP58VdQH6DV22nCjxQNAtNIG16kifTdbPG1twkVEO3Tqo73DgC6K3UZy+NMWpLca+
         QL+kCkVmj3iEOQlSPeAxvtA4gL2wk5adozyWoNcdljz2QSsC8jJ57Bd4hGb1bIWQT680
         3H6FhFpbAAcCELZfAeBPEEKBCF+ygkOn28IaLCeplMopz+49t4hxaQFZx3KYXnskr0+0
         C3sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 189/193] KVM: nVMX: vmx_complete_nested_posted_interrupt() cant fail
Date: Fri, 23 Feb 2018 19:27:02 +0100
Message-Id: <20180223170355.959731589@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218226966328486?=
X-GMAIL-MSGID: =?utf-8?q?1593218226966328486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

(cherry picked from commit 6342c50ad12e8ce0736e722184a7dbdea4a3477f)

vmx_complete_nested_posted_interrupt() can't fail, let's turn it into
a void function.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: port to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4512,7 +4512,7 @@ static int vmx_cpu_uses_apicv(struct kvm
 	return enable_apicv && lapic_in_kernel(vcpu);
 }
 
-static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
+static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int max_irr;
@@ -4523,13 +4523,13 @@ static int vmx_complete_nested_posted_in
 	    vmx->nested.pi_pending) {
 		vmx->nested.pi_pending = false;
 		if (!pi_test_and_clear_on(vmx->nested.pi_desc))
-			return 0;
+			return;
 
 		max_irr = find_last_bit(
 			(unsigned long *)vmx->nested.pi_desc->pir, 256);
 
 		if (max_irr == 256)
-			return 0;
+			return;
 
 		vapic_page = kmap(vmx->nested.virtual_apic_page);
 		__kvm_apic_update_irr(vmx->nested.pi_desc->pir, vapic_page);
@@ -4542,7 +4542,6 @@ static int vmx_complete_nested_posted_in
 			vmcs_write16(GUEST_INTR_STATUS, status);
 		}
 	}
-	return 0;
 }
 
 static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu)
@@ -10155,7 +10154,8 @@ static int vmx_check_nested_events(struc
 		return 0;
 	}
 
-	return vmx_complete_nested_posted_interrupt(vcpu);
+	vmx_complete_nested_posted_interrupt(vcpu);
+	return 0;
 }
 
 static u32 vmx_get_preemption_timer_value(struct kvm_vcpu *vcpu)
