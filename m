Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTdFulgVp9BMRlO6ph0oOsYdRwFPMqzOxBf2wmcCCecdNrq5wos7U5Iu9NvS4RIJ2odQQv
ARC-Seal: i=1; a=rsa-sha256; t=1520451806; cv=none;
        d=google.com; s=arc-20160816;
        b=WTwIB1trfonGU4I9F59PW+sO15zj0sCMOJ6baJr17Xa49Ar47RIdDmgj5WHQ3FNu2o
         Wlz3dSJ53CF5hct6wSPgNSA2fttk4p5uSjFE/zFeOHkFT8sezPHqUJlX6PkCIuGUcvHY
         KzwXHktB0yqqnRde34vsp8fRTlcyrQBWZixxFRQ7TuyEkjSx38HE31+c3X9d86getHVL
         he1WnBfGyhjM1/zbz1RV04Qv3s5h9OgCjdN7QVmRHGtkCwiQPnl+sxheH3FK4cGUJOuO
         JYdPWgSmbS5/IEMGSIHMnTTiv/GrsH3ds1Q8GP3CgpHuN9ViHwpHifkYbilWfS1q+ufg
         E+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BrQrR9t8WHAF375xx9A3mt1l37pEwySyokWTgRaFZJY=;
        b=wHwMJlobCRbCN2hfLz8E7pCfdLBHnl6Lc0kWOfWvy6SnsCjISMRHBoPIpsWe6ItTHK
         rlgWGW2/WwJH50F2NA/fvAvP3YxVHU3m+2LHXt9FXy1zZuhiojFkSUdbdG4rBIWFQl/h
         vX341/bth4vAB9UOyVT4DhFkAlB3E++atN0SZ9qsbVAI8UbemXkkFmXN7eBO3RPZGK2r
         J3mTFJuwwiAlVES85pSYgYBhpUYwq4PI3n6dkDHwcEaVbEUKjonb3nyOS+1jDj/SXuXN
         gIgmYvWWeOO2Sff3GXSO0F8NgEPr562x2iHLIGHf9SG63Rs6K72+cjw60jyoq4P0JKfy
         oCwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4.15 101/122] KVM: s390: take care of clock-comparator sign control
Date: Wed,  7 Mar 2018 11:38:33 -0800
Message-Id: <20180307191744.006977301@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309273560523667?=
X-GMAIL-MSGID: =?utf-8?q?1594309273560523667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

commit 5fe01793dd953ab947fababe8abaf5ed5258c8df upstream.

Missed when enabling the Multiple-epoch facility. If the facility is
installed and the control is set, a sign based comaprison has to be
performed.

Right now we would inject wrong interrupts and ignore interrupt
conditions. Also the sleep time is calculated in a wrong way.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180207114647.6220-2-david@redhat.com>
Fixes: 8fa1696ea781 ("KVM: s390: Multiple Epoch Facility support")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/interrupt.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -170,8 +170,15 @@ static int ckc_interrupts_enabled(struct
 
 static int ckc_irq_pending(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.sie_block->ckc >= kvm_s390_get_tod_clock_fast(vcpu->kvm))
+	const u64 now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
+	const u64 ckc = vcpu->arch.sie_block->ckc;
+
+	if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
+		if ((s64)ckc >= (s64)now)
+			return 0;
+	} else if (ckc >= now) {
 		return 0;
+	}
 	return ckc_interrupts_enabled(vcpu);
 }
 
@@ -1011,13 +1018,19 @@ int kvm_cpu_has_pending_timer(struct kvm
 
 static u64 __calculate_sltime(struct kvm_vcpu *vcpu)
 {
-	u64 now, cputm, sltime = 0;
+	const u64 now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
+	const u64 ckc = vcpu->arch.sie_block->ckc;
+	u64 cputm, sltime = 0;
 
 	if (ckc_interrupts_enabled(vcpu)) {
-		now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
-		sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
-		/* already expired or overflow? */
-		if (!sltime || vcpu->arch.sie_block->ckc <= now)
+		if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
+			if ((s64)now < (s64)ckc)
+				sltime = tod_to_ns((s64)ckc - (s64)now);
+		} else if (now < ckc) {
+			sltime = tod_to_ns(ckc - now);
+		}
+		/* already expired */
+		if (!sltime)
 			return 0;
 		if (cpu_timer_interrupts_enabled(vcpu)) {
 			cputm = kvm_s390_get_cpu_timer(vcpu);
